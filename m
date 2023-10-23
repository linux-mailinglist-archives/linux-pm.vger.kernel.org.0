Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 369E07D3D0A
	for <lists+linux-pm@lfdr.de>; Mon, 23 Oct 2023 19:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjJWRGO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Oct 2023 13:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjJWRGN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Oct 2023 13:06:13 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 714B510A
        for <linux-pm@vger.kernel.org>; Mon, 23 Oct 2023 10:06:10 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9ad8a822508so534978366b.0
        for <linux-pm@vger.kernel.org>; Mon, 23 Oct 2023 10:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698080769; x=1698685569; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iuNkS1vd+Zd+VrcX8suE2Jf1b7hw/+wRSPSlfEzUIRc=;
        b=EPJ6Bwje+EtuUbXyyWbD6oblprYcPa2jUebzfivtS9+1Ts5Hgkh1TL0vcOMyqcObbP
         sX3t/AUc1fv7MuqOGrvamzCQGBK1OW3JjqpFg6W4adyqg0ej8mhmJLb5vYJ564zgJkQO
         jQFFodpJvmAV9P+gU6yu1lYb4spixu/RIQcfXxhzaPRlIQr9JQ72gtS3Gtou1krK82QU
         bzXZsrkH/JpQCspwkezitqsI6VoDQWppqxVR+ys0vOC3kDJWWXuWyph2AZ4INaCW9RmH
         zmVbfK/zwb9CRBEe4DXOlST4lYhIcN2bjcYVpuByjHCtohVLGVl9PTUe92IOlgZ8cqcD
         gwTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698080769; x=1698685569;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iuNkS1vd+Zd+VrcX8suE2Jf1b7hw/+wRSPSlfEzUIRc=;
        b=ZNJxWJU1BkmqfsrqRRJRT4OpZGl52sk1pGvTDX+fuvf8yJ9uzR0eefmJnxpe8ZJw18
         mmEjrfEJ0LFIInIVkjS0QH5bRhLshTgcZeHRoPKqr2TGWt/k0vOMcaccv8UPHjXkye90
         dOzCj2bslhfG6BEwWD8uTe3fyHh7vu77DF+icncF1ESpJ4GzOoIH3RyzFjWigTNnXrw9
         s1+RNq51x+SJUSfj4hB+UszvsyQrKzbZQ+Am7YWJRO7FHbfdLhrSNBtkiWAnFbKAM6eG
         zVjZQT2LUSPoV4wM04XLvDASzhM7BdCfIvlr0B9KlpCEQiGAxRhK6aDebTY8eaeKd+LE
         1k/A==
X-Gm-Message-State: AOJu0Yy1C/f5eGayywUM7AJZJ0Xs4PlC0XScfXbKbk8dTQiPVJCGsVKB
        U8l4LzmZr6OHqcL6c2WEAKKwtQ==
X-Google-Smtp-Source: AGHT+IFg/unW3xdDh9FUgZuDg3qWnEitzvQlsARDu5ZM7VumYoliIbM/vxMYxdiwQ73lhD+0x6V46g==
X-Received: by 2002:a17:907:7b9f:b0:9bf:8073:a922 with SMTP id ne31-20020a1709077b9f00b009bf8073a922mr8850355ejc.19.1698080768812;
        Mon, 23 Oct 2023 10:06:08 -0700 (PDT)
Received: from [192.168.198.23] ([37.166.25.68])
        by smtp.googlemail.com with ESMTPSA id y19-20020a1709060a9300b0098d2d219649sm7021536ejf.174.2023.10.23.10.06.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Oct 2023 10:06:08 -0700 (PDT)
Message-ID: <59ea8714-2ed8-f64b-e8d4-93cd6bf4ff92@linaro.org>
Date:   Mon, 23 Oct 2023 19:06:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 03/18] PM: EM: Find first CPU online while updating OPP
 efficiency
Content-Language: en-US
To:     Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, rafael@kernel.org
Cc:     dietmar.eggemann@arm.com, rui.zhang@intel.com,
        amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
        viresh.kumar@linaro.org, len.brown@intel.com, pavel@ucw.cz,
        mhiramat@kernel.org, qyousef@layalina.io, wvw@google.com
References: <20230925081139.1305766-1-lukasz.luba@arm.com>
 <20230925081139.1305766-4-lukasz.luba@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230925081139.1305766-4-lukasz.luba@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi Lukasz,

On 25/09/2023 10:11, Lukasz Luba wrote:
> The Energy Model might be updated at runtime and the energy efficiency
> for each OPP may change. Thus, there is a need to update also the
> cpufreq framework and make it aligned to the new values. In order to
> do that, use a first online CPU from the Performance Domain.

I'm failing to do the connection with the description and the change.

Perhaps, the changelog shall explain why 'cpu' must be replaced with the 
first active cpu ?

> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>   kernel/power/energy_model.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
> index 42486674b834..3dafdd7731c4 100644
> --- a/kernel/power/energy_model.c
> +++ b/kernel/power/energy_model.c
> @@ -243,12 +243,19 @@ em_cpufreq_update_efficiencies(struct device *dev, struct em_perf_state *table)
>   	struct em_perf_domain *pd = dev->em_pd;
>   	struct cpufreq_policy *policy;
>   	int found = 0;
> -	int i;
> +	int i, cpu;
>   
>   	if (!_is_cpu_device(dev) || !pd)
>   		return;
>   
> -	policy = cpufreq_cpu_get(cpumask_first(em_span_cpus(pd)));
> +	/* Try to get a CPU which is online and in this PD */
> +	cpu = cpumask_first_and(em_span_cpus(pd), cpu_active_mask);
> +	if (cpu >= nr_cpu_ids) {
> +		dev_warn(dev, "EM: No online CPU for CPUFreq policy\n");
> +		return;
> +	}
> +
> +	policy = cpufreq_cpu_get(cpu);
>   	if (!policy) {
>   		dev_warn(dev, "EM: Access to CPUFreq policy failed\n");
>   		return;

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

