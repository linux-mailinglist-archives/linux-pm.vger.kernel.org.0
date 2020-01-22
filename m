Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EAF6145F56
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2020 00:47:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbgAVXrF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 22 Jan 2020 18:47:05 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36252 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgAVXrF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 22 Jan 2020 18:47:05 -0500
Received: by mail-ot1-f67.google.com with SMTP id m2so1096822otq.3;
        Wed, 22 Jan 2020 15:47:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1ijeMfptlUQ+pwbNvh3VIsU5PJPv8c6coBhP2L0ToSk=;
        b=uDPjRKwbgNk3NQomHOJ0Icm27FsNS4VX5vQctgHbbJA7kDe4tlvWUIObPlUen7ew/M
         PRroi1ahvwlrQACuKP9nqXdaSMsjpvaUdz8to7PY6fTfzhqG1nBHUVQVYDuRPxmRkUgn
         oShfkv5R6MKsSPfPdRi/5m6njkOGUbzhoKhBkR8DOGop9SRC3FgmbhRWQ6WaYAlgvoKk
         EaGT6OIlW0SAXQIc+5QF5Eg900uM+teJt5m/rgIZpBortXlhX71BVnCdNTSbwHMxrE/l
         IfgZK6PkohprPYsxMrf8QmT7K48kHcspdyPqisbvw3vlr1vWcAfOtFTH5Emq10eFfLBC
         OI1Q==
X-Gm-Message-State: APjAAAUgnt9he6ttKUoU1La7Xw9DQzq1fU8QcsDWt2yVpoShe9fIaeLn
        +52ll8k3TBL5H9IdhF7PKxdAnPsag1eW21DQkno=
X-Google-Smtp-Source: APXvYqyR1Y5s7+fFOMg6ezJ2h8VJY8liRSi34iuMWDTc6MoFuroMArxoLbn9m3JI3neF3vKPWezDc8U2q8nGY0AIs1c=
X-Received: by 2002:a05:6830:1651:: with SMTP id h17mr8810330otr.167.1579736824565;
 Wed, 22 Jan 2020 15:47:04 -0800 (PST)
MIME-Version: 1.0
References: <or5zh9l5ok.fsf@livre.home> <20200120180612.gurkikzbh77stk4v@pburton-laptop>
 <20200121045354.2ugc6u2p6j7k6kof@vireshk-i7> <oro8uxgfey.fsf@livre.home>
In-Reply-To: <oro8uxgfey.fsf@livre.home>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 23 Jan 2020 00:46:53 +0100
Message-ID: <CAJZ5v0ha0Wp5-8eRZhcJq23VOTyqp2TYXZVQW1EEHmpQzgo6Mw@mail.gmail.com>
Subject: Re: [PATCH] [Loongson2F] adjust cpufreq uses of LOONGSON_CHIPCFG
To:     Alexandre Oliva <lxoliva@fsfla.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Paul Burton <paulburton@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-mips@vger.kernel.org, paul.burton@mips.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jan 21, 2020 at 1:39 PM Alexandre Oliva <lxoliva@fsfla.org> wrote:
>
> The post-fork cleanup of loongson2ef from loongson64 changed
> LOONGSON_CHIPCFG from a single-argument functional macro to a
> non-functional macro with an mmio address in loongson2ef, but
> loongson2_cpufreq still uses the notation of a functional macro call
> expecting it to be an lvalue.  Fixed based on loongson_suspend_enter.
>
> Signed-off-by: Alexandre Oliva <lxoliva@fsfla.org>
> Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Cc: linux-mips@vger.kernel.org
> Cc: paul.burton@mips.com
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Queued up as 5.6 material under modified subject ("cpufreq:
loongson2_cpufreq: adjust cpufreq uses of LOONGSON_CHIPCFG"), thanks!

> ---
>  drivers/cpufreq/loongson2_cpufreq.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/cpufreq/loongson2_cpufreq.c b/drivers/cpufreq/loongson2_cpufreq.c
> index 84f0eee..ace2d46 100644
> --- a/drivers/cpufreq/loongson2_cpufreq.c
> +++ b/drivers/cpufreq/loongson2_cpufreq.c
> @@ -144,9 +144,11 @@ static void loongson2_cpu_wait(void)
>         u32 cpu_freq;
>
>         spin_lock_irqsave(&loongson2_wait_lock, flags);
> -       cpu_freq = LOONGSON_CHIPCFG(0);
> -       LOONGSON_CHIPCFG(0) &= ~0x7;    /* Put CPU into wait mode */
> -       LOONGSON_CHIPCFG(0) = cpu_freq; /* Restore CPU state */
> +       cpu_freq = readl(LOONGSON_CHIPCFG);
> +       /* Put CPU into wait mode */
> +       writel(readl(LOONGSON_CHIPCFG) & ~0x7, LOONGSON_CHIPCFG);
> +       /* Restore CPU state */
> +       writel(cpu_freq, LOONGSON_CHIPCFG);
>         spin_unlock_irqrestore(&loongson2_wait_lock, flags);
>         local_irq_enable();
>  }
> --
> 2.7.4
>
> --
> Alexandre Oliva, freedom fighter   he/him   https://FSFLA.org/blogs/lxo
> Free Software Evangelist           Stallman was right, but he's left :(
> GNU Toolchain Engineer    FSMatrix: It was he who freed the first of us
> FSF & FSFLA board member                The Savior shall return (true);
