Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EFDE41F524
	for <lists+linux-pm@lfdr.de>; Fri,  1 Oct 2021 20:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353493AbhJASrD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Fri, 1 Oct 2021 14:47:03 -0400
Received: from mail-ot1-f50.google.com ([209.85.210.50]:38839 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbhJASrD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Oct 2021 14:47:03 -0400
Received: by mail-ot1-f50.google.com with SMTP id c6-20020a9d2786000000b005471981d559so12654035otb.5;
        Fri, 01 Oct 2021 11:45:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sTQlV2vOuRpiwUSvu0wpsV3N4QOSq/uiLXPbqZ1y08I=;
        b=QXRWhKQRWs5Vkl4egMCXEU7vj2VS3H4+FrEO+CX99TMXgvwwjcb5SeBNjujApInpOE
         0bsqrt9sVX1se1A6OsNk2/hAVgCDR2MEbZyOHOAdjhplEH9+m+S/F6ldbY4H7BvtYyYE
         qqGkEDFows9n4ajEWAIJCnRnafabv4ddm1MTUCqQ2HraDRLEkoZVTekyolBfjncj7ukZ
         Rhq1vYWkpHqB4NXLCob1FgrJtgPGVnegUdkC5BuQDCYLf/mkK6EyStCKkXmtXEjiTi5u
         eWLAsaE19rt96QzCFO1MVTWI0DxxTtn0v/+Ot3oJ6qrkT4OJeVo4dgGa5tzV70fzmEqZ
         W4+g==
X-Gm-Message-State: AOAM532m31Ra7Z84W8HwFBEm5ltiWSEbJlwEpehtGqeF5Qc2NJV1a59E
        UL3qW4hs8jWsYPUfq+aKgpmqRKTQW4lsZ8F9mao=
X-Google-Smtp-Source: ABdhPJwu6GA6KfvB1Lh8J8w2t/keuFowz0gZRUuAb9Pvvsz5OUUcEVPCEDlCEf7gJi+XULOu+EMC7YMVl5fuECjJL+4=
X-Received: by 2002:a05:6830:165a:: with SMTP id h26mr11915593otr.301.1633113918243;
 Fri, 01 Oct 2021 11:45:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210906183440.85710-1-anelkz@amazon.de> <CAJZ5v0ghTGx_1Y5R07pJ9CkTxrMjs=nj2UefeJn6Yh5ud2uP2A@mail.gmail.com>
 <20210915154440.GA34487@dev-dsk-anelkz-1b-031e727b.eu-west-1.amazon.com>
In-Reply-To: <20210915154440.GA34487@dev-dsk-anelkz-1b-031e727b.eu-west-1.amazon.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 1 Oct 2021 20:45:07 +0200
Message-ID: <CAJZ5v0gE2qd=OwA-SNyMC0VNxpa1nDxeWdXcfCS0iXdmieic-g@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: Fix memory leaks
To:     Anel Orazgaliyeva <anelkz@amazon.de>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Aman Priyadarshi <apeureka@amazon.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Sep 15, 2021 at 5:45 PM Anel Orazgaliyeva <anelkz@amazon.de> wrote:
>
> > On Wed, Sep 15, 2021 at 02:14:56PM +0200, Rafael J. Wysocki wrote:
> > CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
> >
> >
> >
> > On Mon, Sep 6, 2021 at 8:35 PM Anel Orazgaliyeva <anelkz@amazon.de> wrote:
> > >
> > > Commit c343bf1ba5ef ("cpuidle: Fix three reference count leaks")
> > > fixes the cleanup of kobjects; however, it removes kfree() calls
> > > altogether, leading to memory leaks.
> >
> > Wait, won't the cleanup be done by cpuidle_free_state_kobj()?
>
> For state cleanup, cpuidle_free_state_kobj() is called on the all the previously created kobjs:
>
> error_state:
>         for (i = i - 1; i >= 0; i--)
>                 cpuidle_free_state_kobj(device, i);
>
> so we still need to cleanup the kobj created in the current iteration.
>
>
> For overall sysfs, the flow is as follows:
>
> cpuidle_register_device
>      ret = cpuidle_add_sysfs(dev);
>     if (ret)
>         goto out_unregister;
>
> out_unregister:
>     __cpuidle_unregister_device(dev);
>    goto out_unlock;
>
> so when there is an error in cpuidle_add_sysfs() dev doesn’t get freed.

OK, applied as 5.16 material, thanks!
