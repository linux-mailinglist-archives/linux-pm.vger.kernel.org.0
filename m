Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35EBD32B32D
	for <lists+linux-pm@lfdr.de>; Wed,  3 Mar 2021 04:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352463AbhCCDsf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 2 Mar 2021 22:48:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447343AbhCBMw2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 2 Mar 2021 07:52:28 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 555F9C061356;
        Tue,  2 Mar 2021 04:51:47 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id k9so11165357lfo.12;
        Tue, 02 Mar 2021 04:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CG/5QlNuJ1KNPPhd8D/4ac7gmQv2YGcSkIDPjvGHLKY=;
        b=f6IBe6p3Lk5pn7nTThtsyM5m0MTzaHE2c1Ij32oGe/DdyKymToP05XSJY1oZne+M/V
         YHE+fXxy//S8rsD4J7WmgrHd2/CVvZO04trwVHGSOJRzWkmV8aYVQs6lSVFIh/EkooL4
         v6l027dFKlhLSdzuesSKmot1xagBK1ozLjKMtYqY/r5rmbnuKbXw3JJIdlGYdBJM5gP+
         FWn9zNOEpdon0BerfRl1L9DqP8DDmEFG4WP2rW2hHytXhwPf3aAiT0az/2k9HEyuiXtQ
         OJbStF3biO1BrD2A0aUCd6PsuNcG/Zdwb30YI7BAIrlfsmoTvAAtnERYS/YwvL5XcUII
         ZLNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CG/5QlNuJ1KNPPhd8D/4ac7gmQv2YGcSkIDPjvGHLKY=;
        b=asJuAZ4ZXQoZ8J60KHTb+Hprq06yEO2eUsxzyj+npqYTuzUw54NTPJdV003U21EM+6
         wqWqv9YSG/kKia02yLxMZ3OUH1A3JZCDjuuuMBlkoJHlEdVphcM9tanXcCCU2FUHodcB
         o9ElCwUOfDaAG7P1o51KP2o/ZpFTa1b+VW0MlGGf1KZl6PZOVh276Iwu0Xey03tLEncf
         hXZ1Fc0iBfwEjkDJMpQsKeCjsdKqfH6+6/tm0yD1L16Tm26mKBE7Y5SLOBcYn+LutaAj
         QdQBDK9OpLK7joU5I5BPIJJIwJD2xgxr1M+1rI9tLP3HsGzWTFmvW0SGYSbc7F/cVY9j
         7rgA==
X-Gm-Message-State: AOAM531pa3pqjAFfq48bSb/5gXVelmJ0kPYYBHtdyxyya/bD9wy4JZGB
        VutLfsETCyKoaVHlpc/6ttxBDAJSor4=
X-Google-Smtp-Source: ABdhPJx+iK7c9zLSYUtGA/nvc3RU8int9Y5ss7FRNYjlRREgm+2lybcDRG75VVWriAQj/maa2FVhDw==
X-Received: by 2002:a05:6512:2206:: with SMTP id h6mr12230604lfu.239.1614689505664;
        Tue, 02 Mar 2021 04:51:45 -0800 (PST)
Received: from [192.168.2.145] (109-252-193-52.dynamic.spd-mgts.ru. [109.252.193.52])
        by smtp.googlemail.com with ESMTPSA id s24sm2818690ljg.26.2021.03.02.04.51.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Mar 2021 04:51:45 -0800 (PST)
Subject: Re: [PATCH RESEND v2 2/2] cpuidle: tegra: Remove do_idle firmware
 call
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Anton Bambura <jenneron@protonmail.com>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Peter Geis <pgwipeout@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20210302095405.28453-1-digetx@gmail.com>
 <20210302095405.28453-2-digetx@gmail.com>
 <dd5cff9e-b86b-7fea-c88b-c32b5c428705@linaro.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <1da82ae3-6b23-2aa0-3275-309ffd8738d0@gmail.com>
Date:   Tue, 2 Mar 2021 15:51:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <dd5cff9e-b86b-7fea-c88b-c32b5c428705@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

02.03.2021 15:45, Daniel Lezcano пишет:
> On 02/03/2021 10:54, Dmitry Osipenko wrote:
>> The do_idle firmware call is unused by all Tegra SoCs, hence remove it in
>> order to keep driver's code clean.
>>
>> Tested-by: Anton Bambura <jenneron@protonmail.com> # TF701 T114
>> Tested-by: Matt Merhar <mattmerhar@protonmail.com> # Ouya T30
>> Tested-by: Peter Geis <pgwipeout@gmail.com> # Ouya T30
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>
>> Changelog:
>>
>> v2: - No changes. V1 got no attention, hence re-sending.
>>
>>  drivers/cpuidle/cpuidle-tegra.c | 13 +------------
>>  1 file changed, 1 insertion(+), 12 deletions(-)
>>
>> diff --git a/drivers/cpuidle/cpuidle-tegra.c b/drivers/cpuidle/cpuidle-tegra.c
>> index 29c5e83500d3..508bd9f23792 100644
>> --- a/drivers/cpuidle/cpuidle-tegra.c
>> +++ b/drivers/cpuidle/cpuidle-tegra.c
>> @@ -48,11 +48,6 @@ enum tegra_state {
>>  static atomic_t tegra_idle_barrier;
>>  static atomic_t tegra_abort_flag;
>>  
>> -static inline bool tegra_cpuidle_using_firmware(void)
>> -{
>> -	return firmware_ops->prepare_idle && firmware_ops->do_idle;
>> -}
>> -
>>  static void tegra_cpuidle_report_cpus_state(void)
>>  {
>>  	unsigned long cpu, lcpu, csr;
>> @@ -139,10 +134,6 @@ static int tegra_cpuidle_c7_enter(void)
>>  	if (err && err != -ENOSYS)
>>  		return err;
>>  
>> -	err = call_firmware_op(do_idle, 0);
>> -	if (err != -ENOSYS)
>> -		return err;
>> -
>>  	return cpu_suspend(0, tegra30_pm_secondary_cpu_suspend);
>>  }
>>  
>> @@ -356,9 +347,7 @@ static int tegra_cpuidle_probe(struct platform_device *pdev)
>>  	 * is disabled.
>>  	 */
>>  	if (!IS_ENABLED(CONFIG_PM_SLEEP)) {
>> -		if (!tegra_cpuidle_using_firmware())
>> -			tegra_cpuidle_disable_state(TEGRA_C7);
> 
> So firmware_ops->do_idle is always NULL, thus
> tegra_cpuidle_using_firmware() is always false and
> tegra_cpuidle_disable_state() always called, right ?

Yes, the tegra_cpuidle_disable_state(TEGRA_C7) is always
called if CONFIG_PM_SLEEP is disabled in kernel config.
