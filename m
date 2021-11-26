Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1F245F44C
	for <lists+linux-pm@lfdr.de>; Fri, 26 Nov 2021 19:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243936AbhKZS2r (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Nov 2021 13:28:47 -0500
Received: from mail-oi1-f182.google.com ([209.85.167.182]:43971 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241981AbhKZS0p (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Nov 2021 13:26:45 -0500
Received: by mail-oi1-f182.google.com with SMTP id o4so20240024oia.10;
        Fri, 26 Nov 2021 10:23:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wJs4qIzN7tdGNmWLLZgECzleFNg3olCYYbAdn6+WWTc=;
        b=6T8ZKy+NG2ZIRHIV2ZzSvmXO4sg6DG8DWkbCzJ+WGrnYD0C0vCY8GkPJP44mx05Smx
         4Jfdp398eP1fECIVArKfsC+5nYsMy87R95yN0PLS1qyaAcUs4ms1mVZcgD77SeXzyD1f
         cyUsunXTcqSfAE3ONTvKTDDwBkSZh+El5fINA4QqZ1qNrc6Dz7RR8OCPs4F8eoHbbeYX
         cwUWevMtcKYo44tlhgukUukfrUUGEyCdLALs/vHUh7I6tQW7c++6pjwZan5mHOogezPb
         TbBCagRywn1zaFDAViDTTTCsGQ1g72IJ+ynxABR2Q+EtfbW43X3KSKnn9i4gmDGNxJcw
         skFA==
X-Gm-Message-State: AOAM531PlLWZuTJ2Lax7fAcTRpy5Mpb5vVvaZfOYXiSdYm/ZiAltqkXH
        irA2zxBNsvXju3LQmql4P7MT2XZ1ss4E44gE3kC1NVD4
X-Google-Smtp-Source: ABdhPJzwvmUTZUjytwHBzf5yT8L/DTo17kJm5ogcH2Ay644b3htcu+cr8LWWD5sF4zgQE5f9tTbseeDeb1vLvSFax3w=
X-Received: by 2002:a05:6808:14c3:: with SMTP id f3mr24781640oiw.51.1637951012267;
 Fri, 26 Nov 2021 10:23:32 -0800 (PST)
MIME-Version: 1.0
References: <20210401183654.27214-1-daniel.lezcano@linaro.org>
 <20210401183654.27214-3-daniel.lezcano@linaro.org> <CAAYoRsURO1tf03nfiki1uaXYEmTKQyYKUeTyKW+vefrVzCO7jg@mail.gmail.com>
 <1e75f7ff-4b1b-ff47-2344-903605067693@linaro.org>
In-Reply-To: <1e75f7ff-4b1b-ff47-2344-903605067693@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 26 Nov 2021 19:23:21 +0100
Message-ID: <CAJZ5v0jtOVs=P2HxGoL2pATwCj9ZxsAnH_ZWL_vMFNjpMsqrng@mail.gmail.com>
Subject: Re: [PATCH v6 3/7] powercap/drivers/dtpm: Simplify the dtpm table
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Doug Smythies <dsmythies@telus.net>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Nov 26, 2021 at 6:40 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 26/11/2021 18:08, Doug Smythies wrote:
> > Hi Daniel,
> >
> > This patch introduces a regression, at least on my test system.
> > I can no longer change CPU frequency scaling drivers, for example
> > from intel_cpufreq (A.K.A intel_pstate in passive mode) to intel_pstate
> > (A.K.A. active mode). The task just hangs forever.
> >
> > I bisected the kernel and got this commit as the result.
> > As a double check, I reverted this commit:
> > 7a89d7eacf8e84f2afb94db5ae9d9f9faa93f01c
> > on kernel 5.16-rc2 and the issue was resolved.
> >
> > While your email is fairly old, I observe that it was only included as of
> > kernel 5.16-rc1.
>
> Could it be related to and fixed by:
>
> https://lore.kernel.org/all/20211108062345.273855-1-daniel.lezcano@linaro.org/
>
> ?

It seems so, but that patch is present in 5.16-rc2.
