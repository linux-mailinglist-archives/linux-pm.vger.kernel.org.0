Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E07882212E9
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jul 2020 18:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgGOQrK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jul 2020 12:47:10 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33496 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbgGOQrJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jul 2020 12:47:09 -0400
Received: by mail-ot1-f67.google.com with SMTP id h13so1991651otr.0
        for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2020 09:47:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X6IepPjY/ERRGkZ1QCaaoSCW0i1aZPjuUdsosr9ObGY=;
        b=AtD0Bi0nTUsEHrDuuTDlALhS8waD9mFLT6O/Nt7zNkHbID8qQq8uAzZeP+OytYr1l+
         1tlQauJWIQzR+ReTcVxNxGKH0cGVWl1/n8FJmd38zf9/GVxXFDLvxje301J716YhFaCT
         4/YZhsQe8coVkZgBHuEz/CkpkAvGtTwcAIwzWpDsENayrVyU2I8MvP9xB94DkFk370Mm
         o8xR3eLcUdRwF2kwK3a1LSFLjlUOX0ZJV/KPxmLnX0FMq9ZlWmCbtWOJFjxqMtKLqVFt
         4gahHE/0Nhb4NN9XlIdBaTT853tN9UNK2I76v1uaOoSnSQuWyDhBZDqY2jV/aPRbvn7G
         8CoQ==
X-Gm-Message-State: AOAM531acGD2GCc6K5oX9vMsrI6MENoDcioA2EtNBfqstGetJirNHS6k
        WRFzsstdLxlJuVx+pFqylVmUzBCv/JFFlTXZBVo=
X-Google-Smtp-Source: ABdhPJzkjvIpaVvjlDaAgoZLZsbPVXqvBLMV98KeLut1T4WKwC7Bz1pAP3m283SYC61mKHfC9o5MOod9XR1XEifvHuk=
X-Received: by 2002:a05:6830:30ba:: with SMTP id g26mr497703ots.118.1594831628210;
 Wed, 15 Jul 2020 09:47:08 -0700 (PDT)
MIME-Version: 1.0
References: <000701d656be$c48083e0$4d818ba0$@net>
In-Reply-To: <000701d656be$c48083e0$4d818ba0$@net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 15 Jul 2020 18:46:56 +0200
Message-ID: <CAJZ5v0hKeHBNC2Bzdizm=42jtOqq8VOswCNNNk5HA9x_Y2T_Ng@mail.gmail.com>
Subject: Re: cpufreq: intel_pstate: EPB with performance governor
To:     Doug Smythies <dsmythies@telus.net>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jul 10, 2020 at 3:34 PM Doug Smythies <dsmythies@telus.net> wrote:
>
> Hi Srinivas and/or Rafael,
>
> Can you please confirm or deny that an older
> commit:
>
> commit 8442885fca09b2d26375b9fe507759879a6f661e
> cpufreq: intel_pstate: Set EPP/EPB to 0 in performance mode
>
> has been superseded by:
>
> arch/x86/kernel/cpu/intel_epb.c

No, it hasn't.

However, intel_pstate only touches the EPB if EPP is not supported,
which should become a non-issue after this patch posted by me
yesterday: https://patchwork.kernel.org/patch/11663315/

If EPP is supported, intel_pstate will use it and it will never look
at the EPB even.

> and that now there is no way to have some default EPB (say 6) for
> governors other than performance, while still getting an EPB of 0
> for the performance governor.

If EPP is supported, what happens to the EPB is completely orthogonal
to cpufreq etc.

So it is possible to have the EPB different from 0, but it should be
the same for all governors unless changed via energy_perf_bias.

If EPP is not supported, though, then without the patch mentioned
above, intel_pstate may fiddle with the EPB.

> Additional notes:
> Both my test computers have EPB as 0 upon startup,

That is before intel_epb_init() runs, because it will change the EPB
to "normal" (6).

> But I also tried this:
>
> diff --git a/arch/x86/kernel/cpu/intel_epb.c b/arch/x86/kernel/cpu/intel_epb.c
> index f4dd73396f28..b536e381cd56 100644
> --- a/arch/x86/kernel/cpu/intel_epb.c
> +++ b/arch/x86/kernel/cpu/intel_epb.c
> @@ -74,7 +74,8 @@ static int intel_epb_save(void)
>
>  static void intel_epb_restore(void)
>  {
> -       u64 val = this_cpu_read(saved_epb);
> +//     u64 val = this_cpu_read(saved_epb);
> +       u64 val = 6;
>         u64 epb;
>
>         rdmsrl(MSR_IA32_ENERGY_PERF_BIAS, epb);
>
> which did get rid of this message:
> kernel: [    0.102158] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'

Which is exactly what happens when this message is printed.

Instead of commenting out the line of code above, which is not a
correct thing to do in general, you can simply set the EPB to 0 via
energy_perf_bias for all CPUs and it should stick.

Thanks!
