Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9475C22F1EF
	for <lists+linux-pm@lfdr.de>; Mon, 27 Jul 2020 16:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731274AbgG0Of6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Jul 2020 10:35:58 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42157 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730524AbgG0OOX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jul 2020 10:14:23 -0400
Received: by mail-ot1-f65.google.com with SMTP id v21so5132573otj.9;
        Mon, 27 Jul 2020 07:14:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RwV/fYC6R5PVghDc7Xcfm5xADtIIp1K2tl3Z3YbTId0=;
        b=EyX8oZgXnnyZ14gS8R68le0lWjEV7pUltjytZqZJTHMzrGP3kfFlD6aSKu2sUVX5qy
         +r7/BwgrNFPi8NzabwoV+P7U4eWB8aHHtrzjF7e9TC6cyk1FLp/Naeun9VqE0X2TdTfN
         d1b03WqVKQgdcEiteOXfr9uDxGghi/X+8R5HplMezJuFIIsPGMf7IegyoCe+5lqoa0Ye
         NEnVBVKreCylidXQB4n8U6fZtjySGYO3BvZ2mb+t/q6LKmyCqxLQ4c0HB3jwh88TiMma
         GHB+34AFs9M9PhYLaPzdKf4q7H3hbz/fQWrkS6Co5WGWdtvH6o3k6uOV8gbec6e5zdhx
         6aKA==
X-Gm-Message-State: AOAM531ZdEKEz0AZS7F/F0NBgGuZqAR95rrPeUTy7+KVN0QLJbWPYXhk
        QKgmJDYO9iGTYXZYbnjBivWc4092QE7sCq/zFG4=
X-Google-Smtp-Source: ABdhPJy3IQ4gWoo3GVjFr2jd6qToC3wtimm7RFwI0aGYMQzT7H7gS+icm3pzzCk7LtxkYZm+IgVNdSPw5XxX9M393tU=
X-Received: by 2002:a9d:590a:: with SMTP id t10mr20554597oth.262.1595859262962;
 Mon, 27 Jul 2020 07:14:22 -0700 (PDT)
MIME-Version: 1.0
References: <1594120299-31389-1-git-send-email-ego@linux.vnet.ibm.com> <20200707113235.GM14120@in.ibm.com>
In-Reply-To: <20200707113235.GM14120@in.ibm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 27 Jul 2020 16:14:12 +0200
Message-ID: <CAJZ5v0jA20TJyxRwtBu31zF5otkqbTW9R03Na3LgJsWB3nDmoQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] cpuidle-pseries: Parse extended CEDE information for idle.
To:     "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Anton Blanchard <anton@ozlabs.org>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michael Neuling <mikey@neuling.org>,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
        linuxppc-dev@ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 7, 2020 at 1:32 PM Gautham R Shenoy <ego@linux.vnet.ibm.com> wrote:
>
> Hi,
>
> On Tue, Jul 07, 2020 at 04:41:34PM +0530, Gautham R. Shenoy wrote:
> > From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> >
> > Hi,
> >
> >
> >
> >
> > Gautham R. Shenoy (5):
> >   cpuidle-pseries: Set the latency-hint before entering CEDE
> >   cpuidle-pseries: Add function to parse extended CEDE records
> >   cpuidle-pseries : Fixup exit latency for CEDE(0)
> >   cpuidle-pseries : Include extended CEDE states in cpuidle framework
> >   cpuidle-pseries: Block Extended CEDE(1) which adds no additional
> >     value.
>
> Forgot to mention that these patches are on top of Nathan's series to
> remove extended CEDE offline and bogus topology update code :
> https://lore.kernel.org/linuxppc-dev/20200612051238.1007764-1-nathanl@linux.ibm.com/

OK, so this is targeted at the powerpc maintainers, isn't it?
