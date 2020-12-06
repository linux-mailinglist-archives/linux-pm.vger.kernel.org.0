Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD00C2D0725
	for <lists+linux-pm@lfdr.de>; Sun,  6 Dec 2020 21:50:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbgLFUtv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 6 Dec 2020 15:49:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbgLFUtu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 6 Dec 2020 15:49:50 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A896C0613D1;
        Sun,  6 Dec 2020 12:49:10 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id m5so1168707wrx.9;
        Sun, 06 Dec 2020 12:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FZUiiQFmDIfqjaethhGNXBNgXZjhrKddKRnEZeQNRw8=;
        b=sNXAaqS1/rAazmbiZ15yYEb/u+Atg1XCGwXiYfuXTJrToauF5eGO4gUG355wI7xVAD
         YvHrj7oDybxvvNndfEMjMg+bvB7cYCfwHBGN4eGRkLVEr02sjpsmfS33hQVBOabDQ49e
         RDW95H+1RRwUsi2oGvDDCZqDh9tXD8f8Ong3AoNAu887jbQ8P/WjDy8RJiwLN2syhgQZ
         kj44+L3GmHF5YQYVu82+fuRM81A4EtIm6yL+Q+4ALY+iZ+pLx3KtjrvRSWhwsk8hi6DI
         E7KsbV6kAEporI+IU7QetpIDh4zzIUUweomQuBcdcCuUnKS1/IcBvycOF0ezKraFROzQ
         JA0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FZUiiQFmDIfqjaethhGNXBNgXZjhrKddKRnEZeQNRw8=;
        b=k9onF82AvSEURr/Gwatsa0KX2zRfXFqTGIX/DJ7FRngPpRryxOQoSvs5ovEHvFMSNs
         hAs10Yrh0hcJm5IC7zGJ92xgqFbiyNCyfQf/ArGQDx78cDq5c43EvhEStUVMw6jtp08F
         PW+59OAA2HOKf+mm4BcnAJUZUMfqRSpy2qakUj0ZkLFiAsglvmuGrSvqqEhBaibenOIt
         p126JPXwmKw0FXm/QKmndt8bWr0c2Pqhi3TPmf/YMPZuU1qhWCC2dS4qWs16iDo3c9Wn
         35YA8dICz3ntXF4b9CUhteFKFcUtNzailM45PIJ1UYQzSZEpDa16P87I+NH/b7Trhwpm
         PCDg==
X-Gm-Message-State: AOAM531o0HyBFtZPyPeMTKbFUM3ePVWkXORocFCbRTdIPsP5gaMKCOpN
        tV44DF3b+YKn27Smcnl+e+GTtVrYWxTH9A==
X-Google-Smtp-Source: ABdhPJwnJuBx+OHgCwt2UQHekLW+UisOtTOPWcOsjtcjNoKUjHb9ScBQ4olp5UPfUuQz7nOBwdMnQA==
X-Received: by 2002:a5d:5107:: with SMTP id s7mr16694170wrt.148.1607287748418;
        Sun, 06 Dec 2020 12:49:08 -0800 (PST)
Received: from [192.168.0.21] (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id h20sm11068678wmb.29.2020.12.06.12.49.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Dec 2020 12:49:07 -0800 (PST)
Subject: Re: [PATCH 1/2] cpufreq: sun50i: add a100 cpufreq support
To:     Shuosheng Huang <huangshuosheng@allwinnertech.com>,
        robh+dt@kernel.org, mripard@kernel.org, wens@csie.org,
        jernej.skrabec@siol.net, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, tiny.windzz@gmail.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
References: <20201204070901.24592-1-huangshuosheng@allwinnertech.com>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Message-ID: <388512ba-9e2b-acad-8487-5c26a6eb101b@gmail.com>
Date:   Sun, 6 Dec 2020 21:49:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201204070901.24592-1-huangshuosheng@allwinnertech.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Shuosheng,

On 04/12/2020 08:09, Shuosheng Huang wrote:
> Let's add cpufreq nvmem based for allwinner a100 soc. It's similar to h6,
> let us use efuse_xlate to extract the differentiated part.

So you introduce 2 modifications here.
In this case it's better to have 2 patches.
One to introduce the efuse_xlate
And one to introduce the A100 support.

Regards,
Clement

> 
> Signed-off-by: Shuosheng Huang <huangshuosheng@allwinnertech.com>
> ---
>   drivers/cpufreq/cpufreq-dt-platdev.c   |  1 +
>   drivers/cpufreq/sun50i-cpufreq-nvmem.c | 81 ++++++++++++++++++++------
>   2 files changed, 64 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> index 3776d960f405..2ebf5d9cb616 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -102,6 +102,7 @@ static const struct of_device_id whitelist[] __initconst = {
>    */
>   static const struct of_device_id blacklist[] __initconst = {
>   	{ .compatible = "allwinner,sun50i-h6", },
> +	{ .compatible = "allwinner,sun50i-a100", },
>   
>   	{ .compatible = "calxeda,highbank", },
>   	{ .compatible = "calxeda,ecx-2000", },
> diff --git a/drivers/cpufreq/sun50i-cpufreq-nvmem.c b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> index 9907a165135b..044e44a763f5 100644
> --- a/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> +++ b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> @@ -21,21 +21,63 @@
>   
>   #define NVMEM_MASK	0x7
>   #define NVMEM_SHIFT	5
> +#define SUN50I_A100_NVMEM_MASK		0xf
> +#define SUN50I_A100_NVMEM_SHIFT		12
> +
> +#define SUN50I_H6_NVMEM_MASK		0x7
> +#define SUN50I_H6_NVMEM_SHIFT		5
> +
> +struct sunxi_cpufreq_soc_data {
> +	u32 (*efuse_xlate)(void *efuse);
> +};
>   
>   static struct platform_device *cpufreq_dt_pdev, *sun50i_cpufreq_pdev;
>   
> +static u32 sun50i_a100_efuse_xlate(void *efuse)
> +{
> +	u32 efuse_value = (*(u16 *)efuse >> SUN50I_A100_NVMEM_SHIFT) &
> +			  SUN50I_A100_NVMEM_MASK;
> +
> +	switch (efuse_value) {
> +	case 0b100:
> +		return 2;
> +	case 0b010:
> +		return 1;
> +	default:
> +		return 0;
> +	}
> +}
> +
> +static u32 sun50i_h6_efuse_xlate(void *efuse)
> +{
> +	u32 efuse_value = (*(u32 *)efuse >> SUN50I_H6_NVMEM_SHIFT) &
> +			  SUN50I_H6_NVMEM_MASK;
> +
> +	/*
> +	 * We treat unexpected efuse values as if the SoC was from
> +	 * the slowest bin. Expected efuse values are 1-3, slowest
> +	 * to fastest.
> +	 */
> +	if (efuse_value >= 1 && efuse_value <= 3)
> +		return efuse_value - 1;
> +	else
> +		return 0;
> +}
> +
>   /**
>    * sun50i_cpufreq_get_efuse() - Determine speed grade from efuse value
> + * @soc_data: pointer to sunxi_cpufreq_soc_data context
>    * @versions: Set to the value parsed from efuse
>    *
>    * Returns 0 if success.
>    */
> -static int sun50i_cpufreq_get_efuse(u32 *versions)
> +static int sun50i_cpufreq_get_efuse(const struct sunxi_cpufreq_soc_data *soc_data,
> +				    u32 *versions)
>   {
>   	struct nvmem_cell *speedbin_nvmem;
>   	struct device_node *np;
>   	struct device *cpu_dev;
> -	u32 *speedbin, efuse_value;
> +	u32 *speedbin;
>   	size_t len;
>   	int ret;
>   
> @@ -68,17 +110,7 @@ static int sun50i_cpufreq_get_efuse(u32 *versions)
>   	if (IS_ERR(speedbin))
>   		return PTR_ERR(speedbin);
>   
> -	efuse_value = (*speedbin >> NVMEM_SHIFT) & NVMEM_MASK;
> -
> -	/*
> -	 * We treat unexpected efuse values as if the SoC was from
> -	 * the slowest bin. Expected efuse values are 1-3, slowest
> -	 * to fastest.
> -	 */
> -	if (efuse_value >= 1 && efuse_value <= 3)
> -		*versions = efuse_value - 1;
> -	else
> -		*versions = 0;
> +	*versions = soc_data->efuse_xlate(speedbin);
>   
>   	kfree(speedbin);
>   	return 0;
> @@ -86,18 +118,23 @@ static int sun50i_cpufreq_get_efuse(u32 *versions)
>   
>   static int sun50i_cpufreq_nvmem_probe(struct platform_device *pdev)
>   {
> +	const struct of_device_id *match;
>   	struct opp_table **opp_tables;
>   	char name[MAX_NAME_LEN];
>   	unsigned int cpu;
>   	u32 speed = 0;
>   	int ret;
>   
> +	match = dev_get_platdata(&pdev->dev);
> +	if (!match)
> +		return -EINVAL;
> +
>   	opp_tables = kcalloc(num_possible_cpus(), sizeof(*opp_tables),
>   			     GFP_KERNEL);
>   	if (!opp_tables)
>   		return -ENOMEM;
>   
> -	ret = sun50i_cpufreq_get_efuse(&speed);
> +	ret = sun50i_cpufreq_get_efuse(match->data, &speed);
>   	if (ret)
>   		return ret;
>   
> @@ -163,8 +200,17 @@ static struct platform_driver sun50i_cpufreq_driver = {
>   	},
>   };
>   
> +static const struct sunxi_cpufreq_soc_data sun50i_a100_data = {
> +	.efuse_xlate = sun50i_a100_efuse_xlate,
> +};
> +
> +static const struct sunxi_cpufreq_soc_data sun50i_h6_data = {
> +	.efuse_xlate = sun50i_h6_efuse_xlate,
> +};
> +
>   static const struct of_device_id sun50i_cpufreq_match_list[] = {
> -	{ .compatible = "allwinner,sun50i-h6" },
> +	{ .compatible = "allwinner,sun50i-h6", .data = &sun50i_h6_data },
> +	{ .compatible = "allwinner,sun50i-a100", .data = &sun50i_a100_data >   	{}
>   };
>   
> @@ -198,9 +244,8 @@ static int __init sun50i_cpufreq_init(void)
>   	if (unlikely(ret < 0))
>   		return ret;
>   
> -	sun50i_cpufreq_pdev =
> -		platform_device_register_simple("sun50i-cpufreq-nvmem",
> -						-1, NULL, 0);
> +	sun50i_cpufreq_pdev = platform_device_register_data(NULL,
> +		"sun50i-cpufreq-nvmem", -1, match, sizeof(*match));
>   	ret = PTR_ERR_OR_ZERO(sun50i_cpufreq_pdev);
>   	if (ret == 0)
>   		return 0;
> 
