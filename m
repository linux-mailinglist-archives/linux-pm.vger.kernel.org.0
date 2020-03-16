Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F118A186BBA
	for <lists+linux-pm@lfdr.de>; Mon, 16 Mar 2020 14:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731054AbgCPNFl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Mar 2020 09:05:41 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36212 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731033AbgCPNFl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Mar 2020 09:05:41 -0400
Received: by mail-pg1-f193.google.com with SMTP id z4so3950672pgu.3
        for <linux-pm@vger.kernel.org>; Mon, 16 Mar 2020 06:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:subject:in-reply-to:references:date:message-id:mime-version;
        bh=S3ylSoSVkSVtheK/F1qvWvf0XZ/cN1+4cUsuDfSQPrg=;
        b=HC5iw9nsPFCCHJIQ4FigojhiQRRfcdyb6Qpgcbl9eWbw97vM6ByH1GNo0POUcLpnq8
         W2526eX+MuNa5a/YiPRQpKhHy989nZbvMYd0iQ068YzwHi/XfEMOAHswjNqJkdwQO/xa
         W0/LGixqd91m0pYY9vhfsXQG0Fssoiruwz8xI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=S3ylSoSVkSVtheK/F1qvWvf0XZ/cN1+4cUsuDfSQPrg=;
        b=dBm2cCsnQnMvDxqtQXfet4Vk9TLTXW+7Wu7Q0aSWl38rV7nRmN8kcGgpUCVoZxw8f7
         C59HwsP2Ee0LuycdKJYoOiydmHGm77dLUT1YjlFd77htl4PKnLKjxK7UxxMWBOCdoemW
         /xVvoImLq3k1ApUCn++pOQSH6N9nvqHNowk7SeKw6aCAbdUhhKEHQErWxfJ2p4EAc5Wm
         VskTl4WqZPFLrm0RvuHZi8eQFG2LXjUc+kPVzr9xdz+NFqhw6+kEt2+Lt3qZJkfFgvzP
         KxRIIibpSpWbiCEyKwWrHi0s2gbecuMdf1oOtBPeWk+doV4FYUE3nPSBjjvjWUjlzZO2
         RyeQ==
X-Gm-Message-State: ANhLgQ2L8cZ3tg09ifuD4d/3FOCLuXDVu59HsO3gxDcUttbQSCdVZ6jP
        veH9rIu/LePgJHbKU8DUolgivg==
X-Google-Smtp-Source: ADFU+vte8YprRXpiosPh6oK8UzgBCXexYDX8dInWwsIZfEzpUDJTBrqtjf9QP5Ukzx4PTdYLK6yJpw==
X-Received: by 2002:a63:5506:: with SMTP id j6mr26894163pgb.43.1584363939827;
        Mon, 16 Mar 2020 06:05:39 -0700 (PDT)
Received: from localhost (2001-44b8-1113-6700-789d-cd2c-42e1-23af.static.ipv6.internode.on.net. [2001:44b8:1113:6700:789d:cd2c:42e1:23af])
        by smtp.gmail.com with ESMTPSA id z15sm32281786pfg.152.2020.03.16.06.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 06:05:38 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     Pratik Rajesh Sampat <psampat@linux.ibm.com>,
        linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, psampat@linux.ibm.com,
        pratik.r.sampat@gmail.com, ego@linux.vnet.ibm.com
Subject: Re: [PATCH] Fixes: 227942809b52 ("cpufreq: powernv: Restore cpu frequency to policy->cur on unthrottling")
In-Reply-To: <20200306110549.25517-1-psampat@linux.ibm.com>
References: <20200306110549.25517-1-psampat@linux.ibm.com>
Date:   Tue, 17 Mar 2020 00:05:35 +1100
Message-ID: <87v9n4o3fk.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Pratik,

Please could you resend this with a more meaningful subject line and
move the Fixes: line to immediately above your signed-off-by?

Thanks!

Regards,
Daniel

> The patch avoids allocating cpufreq_policy on stack hence fixing frame
> size overflow in 'powernv_cpufreq_work_fn'
>
> Signed-off-by: Pratik Rajesh Sampat <psampat@linux.ibm.com>
> ---
>  drivers/cpufreq/powernv-cpufreq.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
> index 56f4bc0d209e..20ee0661555a 100644
> --- a/drivers/cpufreq/powernv-cpufreq.c
> +++ b/drivers/cpufreq/powernv-cpufreq.c
> @@ -902,6 +902,7 @@ static struct notifier_block powernv_cpufreq_reboot_nb = {
>  void powernv_cpufreq_work_fn(struct work_struct *work)
>  {
>  	struct chip *chip = container_of(work, struct chip, throttle);
> +	struct cpufreq_policy *policy;
>  	unsigned int cpu;
>  	cpumask_t mask;
>  
> @@ -916,12 +917,14 @@ void powernv_cpufreq_work_fn(struct work_struct *work)
>  	chip->restore = false;
>  	for_each_cpu(cpu, &mask) {
>  		int index;
> -		struct cpufreq_policy policy;
>  
> -		cpufreq_get_policy(&policy, cpu);
> -		index = cpufreq_table_find_index_c(&policy, policy.cur);
> -		powernv_cpufreq_target_index(&policy, index);
> -		cpumask_andnot(&mask, &mask, policy.cpus);
> +		policy = cpufreq_cpu_get(cpu);
> +		if (!policy)
> +			continue;
> +		index = cpufreq_table_find_index_c(policy, policy->cur);
> +		powernv_cpufreq_target_index(policy, index);
> +		cpumask_andnot(&mask, &mask, policy->cpus);
> +		cpufreq_cpu_put(policy);
>  	}
>  out:
>  	put_online_cpus();
> -- 
> 2.17.1
