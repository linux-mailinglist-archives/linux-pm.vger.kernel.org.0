Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E771750D8E0
	for <lists+linux-pm@lfdr.de>; Mon, 25 Apr 2022 07:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241302AbiDYFjB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Apr 2022 01:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236625AbiDYFiy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 Apr 2022 01:38:54 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD7813F0F
        for <linux-pm@vger.kernel.org>; Sun, 24 Apr 2022 22:35:51 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id s14so24538683plk.8
        for <linux-pm@vger.kernel.org>; Sun, 24 Apr 2022 22:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=T2oxad3crhUuqjbi9y9dJMMYmCSsVXY7Ev+0B50BV+0=;
        b=qDZG8k5tDIz4MvJx+OydJWKJelMxeRJN8ZN7/tavSk56FfCWp42xJTc/KSu57tV/mZ
         fQdDDY/W8fp3//v3jBXi+EzaeIh882MAvQjc/0XqLfj2HLHTZtv/toIofCQo0DwZJvn3
         gUyEmZBF+WiGVi2Wo1cwrDkw9jzGN6wgZoPmaip+7AESEsTdWwnuB/R9UZMFolm1bJxN
         qpTJpPhIsP6ZscFHpeY/314oVST+nmNBwwDHAwiXJQbBfWK/aHZGgFZJmLd+iYV1Fwng
         Yrh+1rzRBta+YycnMKuqiaaC2ddt7bzzYWAre8fH0Gf9NAOQkK39kzEGpHxJRZ5yIjJt
         nUOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=T2oxad3crhUuqjbi9y9dJMMYmCSsVXY7Ev+0B50BV+0=;
        b=st5PocOfl/Yz5FwozT5a2VSxf5ZvcNlESdkDKr8t5jnz4AJXR+rR/YdGiddNTBaO6I
         jtdD0fEgbl4z6MaDb0ABehH9iM+g0HLHbyQzv8i3qxJ+uBlwTapUzWG+Q9R1WnZ/ITSm
         X0Qm8je6PndLx/ifGP4m7KqY4ZtLzHAFmWzpQAMmIEMuUYi/DP3eYBE410QEUMWY1QTZ
         paSX06pGGBr8vWJ3EKM/aOGc3GdOhy7IrwrASWf3q1hQxJu5Gno7wVoWSZ82Oj0NdbNi
         0EAX3UBkw51MdVODhA/2G60GsbzV17mKN4QeESiEIlgpL/aA5H9brQY5YBFTNm7zoeOB
         sVzA==
X-Gm-Message-State: AOAM5317Yr1n+DXFRyxb/fbyqn3EsPBaiDlC1al9VgI8gW8i5C07dpgU
        edAgWNCYmlwBSNXqExfnXp9zdw==
X-Google-Smtp-Source: ABdhPJwnOiyciQSstf5JSoNHFmid7vkH7V23CkAvcMQLZ9tHebui2ItXK187LidqDcgz+iDQDT6d2Q==
X-Received: by 2002:a17:903:410b:b0:15c:fd57:aa34 with SMTP id r11-20020a170903410b00b0015cfd57aa34mr6247282pld.82.1650864950700;
        Sun, 24 Apr 2022 22:35:50 -0700 (PDT)
Received: from localhost ([122.171.250.232])
        by smtp.gmail.com with ESMTPSA id d141-20020a621d93000000b00505aa1026f1sm9768440pfd.51.2022.04.24.22.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 22:35:50 -0700 (PDT)
Date:   Mon, 25 Apr 2022 11:05:48 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>
Cc:     rafael@kernel.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        matthias.bgg@gmail.com, jia-wei.chang@mediatek.com,
        roger.lu@mediatek.com, hsinyi@google.com, khilman@baylibre.com,
        angelogioacchino.delregno@collabora.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH V4 07/14] cpufreq: mediatek: Add .get function
Message-ID: <20220425053548.72w2jh2g6lpzgz6g@vireshk-i7>
References: <20220422075239.16437-1-rex-bc.chen@mediatek.com>
 <20220422075239.16437-8-rex-bc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422075239.16437-8-rex-bc.chen@mediatek.com>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 22-04-22, 15:52, Rex-BC Chen wrote:
> From: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> 
> We want to get opp frequency via opp table. Therefore, we add the function
> "mtk_cpufreq_get()" to do this.
> 
> Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> ---
>  drivers/cpufreq/mediatek-cpufreq.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
> index e070a2619bcb..0b2ca0c8eddc 100644
> --- a/drivers/cpufreq/mediatek-cpufreq.c
> +++ b/drivers/cpufreq/mediatek-cpufreq.c
> @@ -71,6 +71,15 @@ static struct mtk_cpu_dvfs_info *mtk_cpu_dvfs_info_lookup(int cpu)
>  	return NULL;
>  }
>  
> +static unsigned int mtk_cpufreq_get(unsigned int cpu)
> +{
> +	struct mtk_cpu_dvfs_info *info;
> +
> +	info = mtk_cpu_dvfs_info_lookup(cpu);
> +
> +	return !info ? 0 : (info->opp_freq / 1000);
> +}
> +
>  static int mtk_cpufreq_voltage_tracking(struct mtk_cpu_dvfs_info *info,
>  					int new_vproc)
>  {
> @@ -588,7 +597,7 @@ static struct cpufreq_driver mtk_cpufreq_driver = {
>  		 CPUFREQ_IS_COOLING_DEV,
>  	.verify = cpufreq_generic_frequency_table_verify,
>  	.target_index = mtk_cpufreq_set_target,
> -	.get = cpufreq_generic_get,
> +	.get = mtk_cpufreq_get,

The .get callback should read the real frequency from hardware instead of
fetching a cached freq value.

>  	.init = mtk_cpufreq_init,
>  	.exit = mtk_cpufreq_exit,
>  	.register_em = cpufreq_register_em_with_opp,
> -- 
> 2.18.0

-- 
viresh
