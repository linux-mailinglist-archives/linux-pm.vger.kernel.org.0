Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1A8845F546
	for <lists+linux-pm@lfdr.de>; Fri, 26 Nov 2021 20:38:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237289AbhKZTl7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Nov 2021 14:41:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236879AbhKZTj7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Nov 2021 14:39:59 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65921C061191
        for <linux-pm@vger.kernel.org>; Fri, 26 Nov 2021 11:10:26 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id i63so20563384lji.3
        for <linux-pm@vger.kernel.org>; Fri, 26 Nov 2021 11:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v/nUUlQokdOLB5PSt1hTFYmsrGcrpyJxvqeThYufta0=;
        b=K9WBxs+3np+gSoWZtnavrHrjriDztJXlfxsI+dVokPvfBqmrSfb5XN/a0ceS/YRmwx
         RTsKXMs91VEb4IYWDICy+Bl/3ZkLpDcIAtgZz2BZ0gb+rpCBHDMqW0ncoau1t1QtUryi
         9+588tQ+Tz6al9+xOamT/hukkPvcb8c+43yXYg9R8dWHCNdOhzK8j4O/r4CpRLMTRsG/
         KEoDFJU2hKMh/xhRm+G68JBEBVN+WU67Y5KhDlmvyGwmF+2PjlrLI+yRJAOmbQI565ql
         czJwKsOe7kG/dfVG2MUAnQz/p6UXOHVj7NUaGpyPTn138d3x1SJuPEnbf94sN6VsC9G4
         MdpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v/nUUlQokdOLB5PSt1hTFYmsrGcrpyJxvqeThYufta0=;
        b=pIkdT2V1+IRsrWxl+xyJdYKREqefRmNwTwpeCkb60h6Kb72df1V6Xp9cCryPEBbh1i
         TH60tWbufol/4VmSlxJyxIdzKlFpEkoULXsJYWWoiCH6lZ5VyrgxAh0uYChcfv2kkXpr
         JwW3+PcgMtEd0kfgQu5rNdgM2CJKhZgEYbmN0cshlYeoLvWpfkp23/8Tg++MtyauzwnL
         Tq9vZkWEEMeVpL5bcTud/U3xXCzOhTOsLnrrbg9ytXDFg38gAGeBy4gScLN9RjrDo/z0
         t1Cixo6Wj54H0IvfZUpzGG4UmHIi8U7gOQs8T5ao8s/sh9MtGjirhiOVrbBM6eagHse4
         kfPA==
X-Gm-Message-State: AOAM531Lx7aD2aw+yCOtgk/T1F5sMd6HUp2ZVviksfQGCShSGPWTlC/2
        CFfQJFh3nRWfsHYmNeWjShyCMTKHre/ifx3/BIgIZQ==
X-Google-Smtp-Source: ABdhPJypBSwqOQ9WVkGSOuyRXqzgnhCvnOD4ehYZQOCksgsTkpoE/ivcICzXSabIi1UMQ2sEmf33ofWhsDG7jedcxpQ=
X-Received: by 2002:a2e:9e08:: with SMTP id e8mr32848587ljk.472.1637953824609;
 Fri, 26 Nov 2021 11:10:24 -0800 (PST)
MIME-Version: 1.0
References: <20210401183654.27214-1-daniel.lezcano@linaro.org>
 <20210401183654.27214-3-daniel.lezcano@linaro.org> <CAAYoRsURO1tf03nfiki1uaXYEmTKQyYKUeTyKW+vefrVzCO7jg@mail.gmail.com>
 <CAJZ5v0hcuq0qriHbc=XHbCo8fJMAV1dbCBws3M9GktN17aCE_g@mail.gmail.com>
In-Reply-To: <CAJZ5v0hcuq0qriHbc=XHbCo8fJMAV1dbCBws3M9GktN17aCE_g@mail.gmail.com>
From:   Doug Smythies <dsmythies@telus.net>
Date:   Fri, 26 Nov 2021 11:10:14 -0800
Message-ID: <CAAYoRsXLTYKGK_doqDqgerQ+uW3UhMYki7FfBy3cAhbfXiCrXA@mail.gmail.com>
Subject: Re: [PATCH v6 3/7] powercap/drivers/dtpm: Simplify the dtpm table
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        dsmythies <dsmythies@telus.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Nov 26, 2021 at 9:22 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> Hi Doug,
>
> On Fri, Nov 26, 2021 at 6:08 PM Doug Smythies <dsmythies@telus.net> wrote:
> >
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
> >
> > Command Example that never completes:
> >
> > $ echo passive | sudo tee /sys/devices/system/cpu/intel_pstate/status
> >
> > syslog excerpt attached.
>
> This looks like it may be problematic:
>
> diff --git a/drivers/powercap/dtpm_cpu.c b/drivers/powercap/dtpm_cpu.c
> index f6076de39540..98841524a782 100644
> --- a/drivers/powercap/dtpm_cpu.c
> +++ b/drivers/powercap/dtpm_cpu.c
> @@ -204,7 +204,7 @@ static int cpuhp_dtpm_cpu_online(unsigned int cpu)
>        return ret;
> }
>
> -int dtpm_register_cpu(struct dtpm *parent)
> +static int __init dtpm_cpu_init(void)
> {
>        int ret;
>
> so please try to remove the __init annotation from dtpm_cpu_init() and
> see if that helps.

Hi Rafael,

That did not fix the issue.
Just to be clear this is what I did, on top of 5.16-rc2:

$ git diff
diff --git a/drivers/powercap/dtpm_cpu.c b/drivers/powercap/dtpm_cpu.c
index b740866b228d..26d1a87bdec6 100644
--- a/drivers/powercap/dtpm_cpu.c
+++ b/drivers/powercap/dtpm_cpu.c
@@ -231,7 +231,7 @@ static int cpuhp_dtpm_cpu_online(unsigned int cpu)
        return ret;
 }

-static int __init dtpm_cpu_init(void)
+static int dtpm_cpu_init(void)
 {
        int ret;
