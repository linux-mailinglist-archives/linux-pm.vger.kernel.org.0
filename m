Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 092434D0722
	for <lists+linux-pm@lfdr.de>; Mon,  7 Mar 2022 20:02:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244704AbiCGTDk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Mar 2022 14:03:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241678AbiCGTDj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Mar 2022 14:03:39 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76ED613CEE
        for <linux-pm@vger.kernel.org>; Mon,  7 Mar 2022 11:02:44 -0800 (PST)
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 3E7DC3F613
        for <linux-pm@vger.kernel.org>; Mon,  7 Mar 2022 19:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646679763;
        bh=Vq+Wtj+GyJ+co0AT1jDLyXY4eOmwo/VOwm55xSz0z6A=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=CFSyg+POL+68nbwj7qPrBOLhj5PIrIze1EK4E1ZKo9GKb1yok7Sp8xH/RKVke/Uhz
         cTyg7lYGlogxW9UmT4ufiIVIeNSabwYemGHXvPNFrVrgqvTh2SevwBcUm5k9/6KNsV
         UTU80rv+YvRdSgAvKwit2KkZg6YliUqUFnyYEClK/Ai72w73sFvE5DBWZvKaQcYl6q
         njmvCniFRG5J/faS3xxOQn3U0ubpUJJEewSUzzhnswQQ6A4SewGWwXDS0S0wNe2n+U
         lEjGp1zif+pfR6+O14XPy6qp4Lq67AfgT+x42yjYAuL1X2Es+yGY9qldqw3kjlkltx
         ApFEOBRp1zW/w==
Received: by mail-ej1-f71.google.com with SMTP id ey18-20020a1709070b9200b006da9614af58so5391822ejc.10
        for <linux-pm@vger.kernel.org>; Mon, 07 Mar 2022 11:02:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Vq+Wtj+GyJ+co0AT1jDLyXY4eOmwo/VOwm55xSz0z6A=;
        b=rH9V3BWST46BcTQEsu5KAn9Ih83bHlVcOzKZjofFgcWvZlRXvUiMG4FuX/Mc4Sstl/
         xI5ZE4/rlXImLSRf934IdsI3KEkEaGRKE3X9cdoucHLGaaXmSvT01wgVc02peRHtRFv5
         iot3ZNS+yblcd3Y0MFiWwU4WL/fYcV+HNvV13/aXIancdw8S8GRHNZ12vJ1cPcf4Gu1T
         hLp01ZKStRB9neE8/sJUEjQir/zhQvFJ3tJCGUT4lQUMzJaZ0nUWdz3JG6IEFj1ZyOY/
         RplgUTU+7y59zQmAVxamfXxkYTdqrz0a0YUpXiuaXEvaOEwyKUDEWg1t1Qw9lZB2E9V4
         CdBA==
X-Gm-Message-State: AOAM531i+BQW1bMpdSkRKvF0Tj0Ulz4Ki1QOxPnNwY8p2XTXs/1fuLdE
        iry4GDxHcE9zceKge8PoKEOIcF8fc2w8RdBrjCexaXW8L7LR+yFcOL/jGLIyKuPG1vRw/qy12vj
        cA2JrETCJvIC4O9LfySJKjIR2zuJoYMZrS3rS
X-Received: by 2002:a05:6402:168a:b0:3fb:600e:4cc3 with SMTP id a10-20020a056402168a00b003fb600e4cc3mr12645892edv.32.1646679761681;
        Mon, 07 Mar 2022 11:02:41 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzGHTRfZqI1f7NfmlXnfc8CnSpyAgiiBB+6cgpM2S/0teiqFrn9zZ+Tl1DI7G8Bi+m6XdPd9A==
X-Received: by 2002:a05:6402:168a:b0:3fb:600e:4cc3 with SMTP id a10-20020a056402168a00b003fb600e4cc3mr12645854edv.32.1646679761342;
        Mon, 07 Mar 2022 11:02:41 -0800 (PST)
Received: from [192.168.0.143] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id n6-20020aa7c786000000b00410d2403ccfsm6699066eds.21.2022.03.07.11.02.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 11:02:40 -0800 (PST)
Message-ID: <0fa44005-158b-74ee-f4ff-f2694ffce38a@canonical.com>
Date:   Mon, 7 Mar 2022 20:02:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 3/4] cpufreq: mediatek: clean up cpufreq driver
Content-Language: en-US
To:     Tim Chang <jia-wei.chang@mediatek.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, fan.chen@mediatek.com,
        louis.yu@mediatek.com, roger.lu@mediatek.com,
        Allen-yy.Lin@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        hsinyi@google.com,
        Jia-Wei Chang <jia-wei.chang@mediatek.corp-partner.google.com>
References: <20220307122151.11666-1-jia-wei.chang@mediatek.com>
 <20220307122151.11666-4-jia-wei.chang@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220307122151.11666-4-jia-wei.chang@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 07/03/2022 13:21, Tim Chang wrote:
> cleanup of naming, print log and comments.
> 
> Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.corp-partner.google.com>
> ---
>  drivers/cpufreq/mediatek-cpufreq.c | 487 ++++++++++++++---------------
>  1 file changed, 233 insertions(+), 254 deletions(-)
> 
> diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
> index 8e9d706d8081..3f00c7eb01f1 100644
> --- a/drivers/cpufreq/mediatek-cpufreq.c
> +++ b/drivers/cpufreq/mediatek-cpufreq.c
> @@ -1,7 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /*
> - * Copyright (c) 2015 Linaro Ltd.
> - * Author: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
> + * Copyright (C) 2022 MediaTek Inc.

Removal of authorship and existing copyrights does not fit into "clean
up". Please explain this thoroughly.

>   */
>  
>  #include <linux/clk.h>
> @@ -22,7 +21,7 @@
>  #define VOLT_TOL		(10000)
>  
>  /*
> - * The struct mtk_cpu_dvfs_info holds necessary information for doing CPU DVFS
> + * The struct mtk_cpufreq_drv holds necessary information for doing CPU DVFS
>   * on each CPU power/clock domain of Mediatek SoCs. Each CPU cluster in
>   * Mediatek SoCs has two voltage inputs, Vproc and Vsram. In some cases the two
>   * voltage inputs need to be controlled under a hardware limitation:
> @@ -32,7 +31,7 @@
>   * needs to be switched to another stable PLL clock temporarily until
>   * the original PLL becomes stable at target frequency.
>   */
> -struct mtk_cpu_dvfs_info {
> +struct mtk_cpufreq_drv {
>  	struct cpumask cpus;
>  	struct device *cpu_dev;
>  	struct regulator *proc_reg;
> @@ -40,45 +39,45 @@ struct mtk_cpu_dvfs_info {
>  	struct clk *cpu_clk;
>  	struct clk *inter_clk;
>  	struct list_head list_head;
> -	int intermediate_voltage;
> +	int inter_voltage;
>  	bool need_voltage_tracking;
> -	int old_vproc;
> -	struct mutex lock; /* avoid notify and policy race condition */
> +	int old_voltage;
> +	struct mutex lock;  /* avoid notify and policy race condition */
>  	struct notifier_block opp_nb;
>  	int opp_cpu;
>  	unsigned long opp_freq;
>  };
>  
> -static LIST_HEAD(dvfs_info_list);
> +static LIST_HEAD(drv_list);
>  
> -static struct mtk_cpu_dvfs_info *mtk_cpu_dvfs_info_lookup(int cpu)
> +static struct mtk_cpufreq_drv *mtk_cpufreq_drv_lookup(int cpu)
>  {
> -	struct mtk_cpu_dvfs_info *info;
> +	struct mtk_cpufreq_drv *drv;
>  
> -	list_for_each_entry(info, &dvfs_info_list, list_head) {
> -		if (cpumask_test_cpu(cpu, &info->cpus))
> -			return info;
> +	list_for_each_entry(drv, &drv_list, list_head) {
> +		if (cpumask_test_cpu(cpu, &drv->cpus))
> +			return drv;>  	}
>  
>  	return NULL;
>  }
>  
> -static int mtk_cpufreq_voltage_tracking(struct mtk_cpu_dvfs_info *info,
> -					int new_vproc)
> +static int mtk_cpufreq_voltage_tracking(struct mtk_cpufreq_drv *drv,
> +					int new_voltage)
>  {
> -	struct regulator *proc_reg = info->proc_reg;
> -	struct regulator *sram_reg = info->sram_reg;
> -	int old_vproc, old_vsram, new_vsram, vsram, vproc, ret;
> -
> -	old_vproc = regulator_get_voltage(proc_reg);
> -	if (old_vproc < 0) {
> -		pr_err("%s: invalid Vproc value: %d\n", __func__, old_vproc);
> -		return old_vproc;
> +	struct regulator *proc_reg = drv->proc_reg;
> +	struct regulator *sram_reg = drv->sram_reg;
> +	int old_voltage, old_vsram, new_vsram, vsram, voltage, ret;
> +
> +	old_voltage = regulator_get_voltage(proc_reg);
> +	if (old_voltage < 0) {
> +		pr_err("%s: invalid vproc value: %d\n", __func__, old_voltage);
> +		return old_voltage;


Several different changes in one commit. Please read the document
"Submitting patches".

(...)

> -MODULE_AUTHOR("Pi-Cheng Chen <pi-cheng.chen@linaro.org>");
> +MODULE_AUTHOR("Jia-Wei Chang <jia-wei.chang@mediatek.com>");

Ekhm, why? He was not the author?

Best regards,
Krzysztof
