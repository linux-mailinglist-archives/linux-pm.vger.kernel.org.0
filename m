Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFC0E15A46E
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2020 10:17:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728530AbgBLJRV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Feb 2020 04:17:21 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37227 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728150AbgBLJRV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Feb 2020 04:17:21 -0500
Received: by mail-oi1-f193.google.com with SMTP id q84so1371183oic.4;
        Wed, 12 Feb 2020 01:17:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UFykYmpeqq57o6fsy3lLQgTxgLUBdF0//2jzAtV9jNI=;
        b=oHqav0W9EJMmXoN2QtfEobnDgt5oyffWex9D0gqZjWBhvps765zyokW19FXeE6r/+P
         BwBWvNTotuxxQiyPFFKnbeHym3f2B3/+ae6sEnRI3DOLQSXzigpK301ptNNtdNGnf7hk
         QZZm2axThTABIY3JmQYYxWg9PdDIyVJt+bFHG83lw8S5aOCejaUgp5XiitZ0DW0z8Ooh
         dRqBUt/x4C5cPhXGGxA5bJvejyVqvoaZLu1A5kCjKf0gIb5J2siZ1Tcv1hBaOk8OIYYE
         xeN546t0tn2l3/Maf+ZKkiYeHX2EQLp0Xm0Y50rjXh7OYVfVeRcZaofkz2SNSXKvzBjr
         9YVQ==
X-Gm-Message-State: APjAAAW04Fh1J6YR2fMwK7K0TaAHQEHB3lNqY5xXrlFqBDXaZdO3IFYf
        ey1wiuVCnusxMeFI5D9mhUDY0qZgBdXc+Fa5dLBKEA==
X-Google-Smtp-Source: APXvYqzvxhB1urHRH45huzlpCbCrbTRtg8deoE3xRA4Tt/YsGbE5dBuQR8SE6FVUo6yzeJG6lRcGDlDORNKCut2uUdg=
X-Received: by 2002:aca:d6c8:: with SMTP id n191mr5789883oig.103.1581499040711;
 Wed, 12 Feb 2020 01:17:20 -0800 (PST)
MIME-Version: 1.0
References: <1654227.8mz0SueHsU@kreacher> <CAPDyKFrcRzDE9=A28uf2sp=zaJpbEGrW5jm3L6CBVVc=GaL-Jg@mail.gmail.com>
In-Reply-To: <CAPDyKFrcRzDE9=A28uf2sp=zaJpbEGrW5jm3L6CBVVc=GaL-Jg@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 12 Feb 2020 10:17:08 +0100
Message-ID: <CAJZ5v0gGjM2wgBvRAg_Oz1eBNQM8TMY601803miafBiRY5=M0w@mail.gmail.com>
Subject: Re: [PATCH 00/28] PM: QoS: Get rid of unuseful code and rework CPU
 latency QoS interface
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Feb 12, 2020 at 9:38 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Wed, 12 Feb 2020 at 00:39, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >
> > Hi All,
> >
> > This series of patches is based on the observation that after commit
> > c3082a674f46 ("PM: QoS: Get rid of unused flags") the only global PM QoS class
> > in use is PM_QOS_CPU_DMA_LATENCY, but there is still a significant amount of
> > code dedicated to the handling of global PM QoS classes in general.  That code
> > takes up space and adds overhead in vain, so it is better to get rid of it.
> >
> > Moreover, with that unuseful code removed, the interface for adding QoS
> > requests for CPU latency becomes inelegant and confusing, so it is better to
> > clean it up.
> >
> > Patches [01/28-12/28] do the first part described above, which also includes
> > some assorted cleanups of the core PM QoS code that doesn't go away.
> >
> > Patches [13/28-25/28] rework the CPU latency QoS interface (in the classic
> > "define stubs, migrate users, change the API proper" manner), patches
> > [26-27/28] update the general comments and documentation to match the code
> > after the previous changes and the last one makes the CPU latency QoS depend
> > on CPU_IDLE (because cpuidle is the only user of its target value today).
> >
> > The majority of the patches in this series don't change the functionality of
> > the code at all (at least not intentionally).
> >
> > Please refer to the changelogs of individual patches for details.
> >
> > Thanks!
>
> A big thanks for cleaning this up! The PM_QOS_CPU_DMA_LATENCY and
> friends, has been annoying me for a long time. This certainly makes
> the code far better and more understandable!
>
> I have looked through the series and couldn't find any obvious
> mistakes, so feel free to add:
>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Thanks for the review, much appreciated!

> Note, the review tag also means, that's fine for you to pick the mmc
> patch via your tree.

Thank you!
