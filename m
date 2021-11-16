Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E687945291D
	for <lists+linux-pm@lfdr.de>; Tue, 16 Nov 2021 05:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239700AbhKPE2j (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Nov 2021 23:28:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240467AbhKPE2J (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 15 Nov 2021 23:28:09 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66FBEC04EF95
        for <linux-pm@vger.kernel.org>; Mon, 15 Nov 2021 17:23:53 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id h19-20020a9d3e53000000b0056547b797b2so29790123otg.4
        for <linux-pm@vger.kernel.org>; Mon, 15 Nov 2021 17:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=nTaWvWeeIvOoP/P3B+BmghLZFxSmkp20dJxrE1Em0B0=;
        b=hODih3i3lk4StlS/Iqc9FkpsXI0426vZgUigkUppIJ4xA80HH4bgJh9Ia+jK/m7Gg5
         nKSgUCupmGcAKhN0ut2ZSlQfDLqO1twd1Fh2a0xwLWlPNhaZ68snOokozoxW18EuHLXN
         jC4dVkKbXfauv6PlYfl48LQiFXg3RJNAw/Hhp2r5te5HcMcwP3lbJq4ejF+O3shJdhXB
         7izOz0ACJo8MdLGLnGU04Y+uFEFiWZg7ra7vDWfH4t3YSVjJwf+0fHXrVy/6/etATcWX
         zFtDab3mneymYKABGNJuL1HHqc06t0gcgJqlBddYqJi65A8N1P1ieGOfbdmI0O/LaIhr
         Kfyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nTaWvWeeIvOoP/P3B+BmghLZFxSmkp20dJxrE1Em0B0=;
        b=6YypZNQ1UV3Y8cLEuQEqdS+EMxklYputjILdyTfB2xea410nwzgiyjR9KjmC2HbOPk
         N3TaI/2HyMaR/pZW9HVxJREd/obpc5d5mUnn/c8uf42CwkjIMcrzOH/XbY1oi0R/5CNB
         KkY2ZfdBJ9xaopuc0TlFmdpzPrgnbyJHJhi0x8f+SexWlvHtohoGpH0GIGOU1yJ3q0YV
         /0jbOWqzo0bVK+0Wo8wVbd9+mOvhyQUTAGFbMUiyxBxNiSgeZdNo6eG1ZfzzSPrjF06p
         gYFQZbKtDqGYoURbo0qUe21t+r2KPnYqjWcchce6kUGIImHQwEMy5aEtwbG0tAR5m++n
         uKcw==
X-Gm-Message-State: AOAM531SgV0bklbCEXivECtizdkqrpypWZxvYAuuftpx2Tz+oQEjmVIU
        SxespZIWBBQGu434f5DxRnhJmQ==
X-Google-Smtp-Source: ABdhPJzKVuOebXxy3RD99OR/9h+EwRvdqloC8YuBYE87p9xUODg5mFOHBn1LO5G0RHJpomFtr8JGOA==
X-Received: by 2002:a05:6830:1cc:: with SMTP id r12mr2845768ota.76.1637025832711;
        Mon, 15 Nov 2021 17:23:52 -0800 (PST)
Received: from [192.168.11.48] (cpe-173-173-107-246.satx.res.rr.com. [173.173.107.246])
        by smtp.gmail.com with ESMTPSA id l23sm3302357oti.16.2021.11.15.17.23.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Nov 2021 17:23:52 -0800 (PST)
Message-ID: <5ae2c644-4743-c62c-b17c-96945a0e6a01@kali.org>
Date:   Mon, 15 Nov 2021 19:23:50 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.0
Subject: Re: [PATCH] cpufreq: freq_table: Initialize cpuinfo.max_freq to
 correct max frequency.
Content-Language: en-US
To:     Thara Gopinath <thara.gopinath@linaro.org>, rafael@kernel.org,
        viresh.kumar@linaro.org, bjorn.andersson@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20211115195011.52999-1-thara.gopinath@linaro.org>
From:   Steev Klimaszewski <steev@kali.org>
In-Reply-To: <20211115195011.52999-1-thara.gopinath@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Thara,

On 11/15/21 1:50 PM, Thara Gopinath wrote:
> cpuinfo.max_freq reflects the maximum supported frequency of cpus in a
> cpufreq policy. When cpus support boost frequency and if boost is disabled
> during boot up (which is the default), cpuinfo.max_freq does not reflect
> boost frequency as the maximum supported frequency till boost is explicitly
> enabled via sysfs interface later. This also means that policy reports two
> different cpuinfo.max_freq before and after turning on boost.  Fix this by
> separating out setting of policy->max and cpuinfo.max_freq in
> cpufreq_frequency_table_cpuinfo.
>
> e.g. of the problem. Qualcomm sdm845 supports boost frequency for gold
> cluster (cpus 4-7). After boot up (boost disabled),
>
> 1.  cat /sys/devices/system/cpu/cpufreq/policy4/cpuinfo_max_freq 2649600
> <- This is wrong because boost frequency is
>
> 2.  echo 1 > /sys/devices/system/cpu/cpufreq/boost  <- Enable boost cat
> /sys/devices/system/cpu/cpufreq/policy4/cpuinfo_max_freq 2803200	<-
> max freq reflects boost freq.
>
> 3.  echo 0 > /sys/devices/system/cpu/cpufreq/boost <- Disable boost cat
> /sys/devices/system/cpu/cpufreq/policy4/cpuinfo_max_freq 2803200	<-
> Discrepancy with step 1 as in both cases boost is disabled.
>
> Note that the other way to fix this is to set cpuinfo.max_freq in Soc
> cpufreq driver during initialization. Fixing it in
> cpufreq_frequency_table_cpuinfo seems more generic solution
>
> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> ---
>   drivers/cpufreq/freq_table.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
> index 67e56cf638ef..6784f94124df 100644
> --- a/drivers/cpufreq/freq_table.c
> +++ b/drivers/cpufreq/freq_table.c
> @@ -35,11 +35,15 @@ int cpufreq_frequency_table_cpuinfo(struct cpufreq_policy *policy,
>   	struct cpufreq_frequency_table *pos;
>   	unsigned int min_freq = ~0;
>   	unsigned int max_freq = 0;
> +	unsigned int cpuinfo_max_freq = 0;
>   	unsigned int freq;
>   
>   	cpufreq_for_each_valid_entry(pos, table) {
>   		freq = pos->frequency;
>   
> +		if (freq > cpuinfo_max_freq)
> +			cpuinfo_max_freq = freq;
> +
>   		if (!cpufreq_boost_enabled()
>   		    && (pos->flags & CPUFREQ_BOOST_FREQ))
>   			continue;
> @@ -57,8 +61,8 @@ int cpufreq_frequency_table_cpuinfo(struct cpufreq_policy *policy,
>   	 * If the driver has set its own cpuinfo.max_freq above max_freq, leave
>   	 * it as is.
>   	 */
> -	if (policy->cpuinfo.max_freq < max_freq)
> -		policy->max = policy->cpuinfo.max_freq = max_freq;
> +	if (policy->cpuinfo.max_freq < cpuinfo_max_freq)
> +		policy->cpuinfo.max_freq = cpuinfo_max_freq;
>   
>   	if (policy->min == ~0)
>   		return -EINVAL;


Something still isn't quite right...

The setup is that I have an rc.local of

#!/bin/sh

echo 1 > /sys/devices/system/cpu/cpufreq/boost

exit 0


After booting and logging in:

steev@limitless:~$ cat 
/sys/devices/system/cpu/cpufreq/policy4/stats/time_in_state
825600 2499
<snip>
2649600 38
2745600 31
2841600 1473
2956800 0

After running a "cargo build --release" in an alacritty git checkout:

teev@limitless:~$ cat 
/sys/devices/system/cpu/cpufreq/policy4/stats/time_in_state
825600 11220
<snip>
2649600 41
2745600 35
2841600 3065
2956800 0


however...

If I then

steev@limitless:~$ echo 0 | sudo tee /sys/devices/system/cpu/cpufreq/boost
[sudo] password for steev:
0
steev@limitless:~$ echo 1 | sudo tee /sys/devices/system/cpu/cpufreq/boost
1

and run the build again...

steev@limitless:~$ cat 
/sys/devices/system/cpu/cpufreq/policy4/stats/time_in_state
825600 21386
<snip>
2649600 45
2745600 38
2841600 3326
2956800 4815

As a workaround, I attempted to jiggle it 1-0-1 in rc.local, however 
that ends up giving

steev@limitless:~$ cat 
/sys/devices/system/cpu/cpufreq/policy4/stats/time_in_state
825600 2902
<snip>
2649600 36
2745600 36
2841600 6050
2956800 13

And it doesn't go up, I even tried adding a sleep of 1 second between 
the echo 1/0/1 lines and while 2956800 goes up to 28 (but never uses it) 
it seems like, unless I do it manually once I've logged in, which I'm 
assuming is a lot slower than waiting 1 second between them, it's not 
quite giving us 2956800 "easily".

If the email wasn't clear, please let me know! I tried to explain as 
best I could what I am seeing here.

-- steev

