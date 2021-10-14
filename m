Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 493CF42D93F
	for <lists+linux-pm@lfdr.de>; Thu, 14 Oct 2021 14:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbhJNM1Q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Oct 2021 08:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbhJNM1P (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Oct 2021 08:27:15 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4450AC061570
        for <linux-pm@vger.kernel.org>; Thu, 14 Oct 2021 05:25:10 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id x27so26331483lfu.5
        for <linux-pm@vger.kernel.org>; Thu, 14 Oct 2021 05:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ecDOxJ4g4rGekvg6Ad7KQ5ygSfRdg/EpAd1GYPQ0UAU=;
        b=V2yOk6j0nyPSfywCPSk+T5zC77Z8P+1d4kSMfqNEom2mJSpFKjaexaTDKIKNgd/uBw
         JT343HMobT/VyIVVloVoFq07SqJydkUOWoBOphIycADkj++npExCYTRID1iHmBwYp2yO
         mBSV35f+U+ACXeph2oDYz7wcdflX8zDiGizx2ycAfrYwCWQj0einJ0/7xA/2lk2kC4ni
         ocUzCsSRiz+6/iWrPrbmSRo+ai4wKZDY6C4IvK3s/AwXKRbf3pvDTfwee1iBVNwyuNLp
         ekTS0cm6A0CEfr/Wjq4dbOHBRHFEqeUsvrv+nK8JkMxG7pKbMzMhPU0MB/DTNA++PmID
         G8OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ecDOxJ4g4rGekvg6Ad7KQ5ygSfRdg/EpAd1GYPQ0UAU=;
        b=EUVZ4PPmVj01qX+wg3tumfFbCUPYDHG1rTQLetFZALgZxFyy1IFFxm+YvcBiHcQLz7
         ZkRZnA4kiwGHYJ4ALiAtZf7ywZPyKUCWS/+sogNrnqc7tpCEd6Xpbst8HPzTKAKes3DU
         4HxN6Cm/lGLNwWkSL9+VbuYCBvkhwoJSoTZSpf49s2V/k7YEKRRN6g1tPGRi1SbLeRiF
         PwzlCDnziylvWk5uaeA0ekTXJ5StXZcBJhsmg7AVFffCvDr/qB40GI3KaHn7hwgVmFDB
         iIN9qhH8dWHolQctU1/cBrY3aAEEYjOoFGq2qiUXj+a+jkMtT9/oAPK6wL2da2yPqExV
         CeXw==
X-Gm-Message-State: AOAM5308Sqj3pxasN1AQCCtQZ4P/+4TS2iyv/WNFfaxr7fiPLpsgW+YN
        OaJIBnOvjP40TwMyufmHNr+pfQ==
X-Google-Smtp-Source: ABdhPJy7zlyfngIg6lyxPZFE4lAszVXSZLyFVA06ruM/zhwbizwMiSLOMbC8PwwtkU0Q/RrfvOCASQ==
X-Received: by 2002:a2e:bd8a:: with SMTP id o10mr5630339ljq.316.1634214308569;
        Thu, 14 Oct 2021 05:25:08 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id r10sm251605ljg.10.2021.10.14.05.25.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Oct 2021 05:25:08 -0700 (PDT)
Subject: Re: [PATCH 4/8] cpufreq: qcom_cpufreq_nvmem: Simplify reading kryo
 speedbin
To:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Loic Poulain <loic.poulain@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org
References: <20211014083016.137441-1-y.oudjana@protonmail.com>
 <20211014083016.137441-5-y.oudjana@protonmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Message-ID: <7e8b5d31-0232-7aee-ceed-ec453b447638@linaro.org>
Date:   Thu, 14 Oct 2021 15:25:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211014083016.137441-5-y.oudjana@protonmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 14/10/2021 11:32, Yassine Oudjana wrote:
> In preparation for adding a separate device tree for MSM8996 Pro, skip reading
> msm-id from smem and just read the speedbin efuse.

It would be nice to comment, why is it possible/necessary. For example:

MSM8996 Pro has completely different set of frequencies, so it makes no 
sense to have a single table covering Pro and original SoCs. 
msm8996pro.dtsi would override frequency table from msm8996.dtsi.


> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---
>   drivers/cpufreq/Kconfig.arm          |  1 -
>   drivers/cpufreq/qcom-cpufreq-nvmem.c | 75 +++-------------------------
>   2 files changed, 6 insertions(+), 70 deletions(-)
> 
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index 954749afb5fe..7d9798bc5753 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -154,7 +154,6 @@ config ARM_QCOM_CPUFREQ_NVMEM
>   	tristate "Qualcomm nvmem based CPUFreq"
>   	depends on ARCH_QCOM
>   	depends on QCOM_QFPROM
> -	depends on QCOM_SMEM
>   	select PM_OPP
>   	help
>   	  This adds the CPUFreq driver for Qualcomm Kryo SoC based boards.
> diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> index d1744b5d9619..909f7d97b334 100644
> --- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
> +++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> @@ -9,8 +9,8 @@
>    * based on the silicon variant in use. Qualcomm Process Voltage Scaling Tables
>    * defines the voltage and frequency value based on the msm-id in SMEM
>    * and speedbin blown in the efuse combination.
> - * The qcom-cpufreq-nvmem driver reads the msm-id and efuse value from the SoC
> - * to provide the OPP framework with required information.
> + * The qcom-cpufreq-nvmem driver reads efuse value from the SoC to provide the
> + * OPP framework with required information.
>    * This is used to determine the voltage and frequency value for each OPP of
>    * operating-points-v2 table when it is parsed by the OPP framework.
>    */
> @@ -27,22 +27,6 @@
>   #include <linux/pm_domain.h>
>   #include <linux/pm_opp.h>
>   #include <linux/slab.h>
> -#include <linux/soc/qcom/smem.h>
> -
> -#define MSM_ID_SMEM	137
> -
> -enum _msm_id {
> -	MSM8996V3 = 0xF6ul,
> -	APQ8096V3 = 0x123ul,
> -	MSM8996SG = 0x131ul,
> -	APQ8096SG = 0x138ul,
> -};
> -
> -enum _msm8996_version {
> -	MSM8996_V3,
> -	MSM8996_SG,
> -	NUM_OF_MSM8996_VERSIONS,
> -};
>   
>   struct qcom_cpufreq_drv;
>   
> @@ -142,35 +126,6 @@ static void get_krait_bin_format_b(struct device *cpu_dev,
>   	dev_dbg(cpu_dev, "PVS version: %d\n", *pvs_ver);
>   }
>   
> -static enum _msm8996_version qcom_cpufreq_get_msm_id(void)
> -{
> -	size_t len;
> -	u32 *msm_id;
> -	enum _msm8996_version version;
> -
> -	msm_id = qcom_smem_get(QCOM_SMEM_HOST_ANY, MSM_ID_SMEM, &len);
> -	if (IS_ERR(msm_id))
> -		return NUM_OF_MSM8996_VERSIONS;
> -
> -	/* The first 4 bytes are format, next to them is the actual msm-id */
> -	msm_id++;
> -
> -	switch ((enum _msm_id)*msm_id) {
> -	case MSM8996V3:
> -	case APQ8096V3:
> -		version = MSM8996_V3;
> -		break;
> -	case MSM8996SG:
> -	case APQ8096SG:
> -		version = MSM8996_SG;
> -		break;
> -	default:
> -		version = NUM_OF_MSM8996_VERSIONS;
> -	}
> -
> -	return version;
> -}
> -
>   static int qcom_cpufreq_kryo_name_version(struct device *cpu_dev,
>   					  struct nvmem_cell *speedbin_nvmem,
>   					  char **pvs_name,
> @@ -178,30 +133,13 @@ static int qcom_cpufreq_kryo_name_version(struct device *cpu_dev,
>   {
>   	size_t len;
>   	u8 *speedbin;
> -	enum _msm8996_version msm8996_version;
>   	*pvs_name = NULL;
>   
> -	msm8996_version = qcom_cpufreq_get_msm_id();
> -	if (NUM_OF_MSM8996_VERSIONS == msm8996_version) {
> -		dev_err(cpu_dev, "Not Snapdragon 820/821!");
> -		return -ENODEV;
> -	}
> -
>   	speedbin = nvmem_cell_read(speedbin_nvmem, &len);
>   	if (IS_ERR(speedbin))
>   		return PTR_ERR(speedbin);
>   
> -	switch (msm8996_version) {
> -	case MSM8996_V3:
> -		drv->versions = 1 << (unsigned int)(*speedbin);
> -		break;
> -	case MSM8996_SG:
> -		drv->versions = 1 << ((unsigned int)(*speedbin) + 4);
> -		break;
> -	default:
> -		BUG();
> -		break;
> -	}
> +	drv->versions = 1 << (unsigned int)(*speedbin);
>   
>   	kfree(speedbin);
>   	return 0;
> @@ -464,10 +402,9 @@ static const struct of_device_id qcom_cpufreq_match_list[] __initconst = {
>   MODULE_DEVICE_TABLE(of, qcom_cpufreq_match_list);
>   
>   /*
> - * Since the driver depends on smem and nvmem drivers, which may
> - * return EPROBE_DEFER, all the real activity is done in the probe,
> - * which may be defered as well. The init here is only registering
> - * the driver and the platform device.
> + * Since the driver depends on the nvmem driver, which may return EPROBE_DEFER,
> + * all the real activity is done in the probe, which may be defered as well.
> + * The init here is only registering the driver and the platform device.
>    */
>   static int __init qcom_cpufreq_init(void)
>   {
> 


-- 
With best wishes
Dmitry
