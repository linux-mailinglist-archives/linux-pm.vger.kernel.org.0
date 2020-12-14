Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB0112D9175
	for <lists+linux-pm@lfdr.de>; Mon, 14 Dec 2020 01:48:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730880AbgLNArq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 13 Dec 2020 19:47:46 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:34529 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725785AbgLNAri (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 13 Dec 2020 19:47:38 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 33B2A5C00AC;
        Sun, 13 Dec 2020 19:46:51 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 13 Dec 2020 19:46:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm1; bh=y
        svwVpQMfEdqrL3d2zX2/QKrjF7XUtr7yq5syXzpByE=; b=nrCQgU93zATfMXQ+k
        GUuzRvnj3mi8gE8RjeJkXIn4OH5kmzIeFEQl+fkINFITKM42ZqM3RSpJqYvrJ6Cu
        gyTl8IMaWrfDj6ay+5Q0jPJ9KyAjg5usF89MujVE0vEixLUxm/IorJ2/xSuZHM1g
        oWdom7ha3P6Yr6Z+HUMtZjQWKb9jZK3Yjn2jOi6LmoL1uhMHUrNLRibRd/IIYWRu
        Ai45BNCc/JM4D/gD7JmVBYEGmVmiqGqC7iHTildIGBDjW0Cwc+B2aJ+J42mr/U1r
        1nCL8OrZMmCZwYrzTXx6EMmQFxlUpciAEbca6xjqQQEUT+EfD9M78FahT6M8uBsX
        5Ozgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=ysvwVpQMfEdqrL3d2zX2/QKrjF7XUtr7yq5syXzpB
        yE=; b=Xa3FeqIEWYaSybqMfNn1B0yMZhL3wauKEU+DIPBbqnWSHQltBku/4TY37
        BZqTcgUgWpV9HUr1aZ5f7A38z39UvAOND6TQLJcREDY++w8X8p9PG2Ux1WcR/8xS
        fBEo/i6BSzhZ65z02bEd8KHQJbJkv6OS21aGjMzYmYPhPZAxUtQyUYKaDv2jkV5p
        4pHPwfOqeG21YUmufdBqJov1SXX30JNGP3vJIUbqdfif9UNzRK19Mu5dLTbBrt/H
        ghVR7IAp0pJqjCswNAdCt1goxqr1SeZgXrVScyOn/pNvUnllBdRr6h+EW6u+SXCk
        VqxgxZdBTI0g4d/VnG+Vk5zMb8W9g==
X-ME-Sender: <xms:-LXWXyBmvlWWodMzqI-HkcQFZUaZp90VYv1h43fHiGagoqXUsANLeA>
    <xme:-LXWX8hXSL98buKqpINWoiu_V3OGJgu0zwJLfLfmCYNU7h2coiUg6-p0Urdt3dv_f
    9f2q0ZrXQF263PvWw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudekjedgtddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvfhfhkffffgggjggtgfesthejredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepgfevffetleehffejueekvdekvdeitdehveegfeekheeuieeiueet
    uefgtedtgeegnecukfhppeejtddrudefhedrudegkedrudehudenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgr
    nhgurdhorhhg
X-ME-Proxy: <xmx:-LXWX1loa8Rq9yo10DIMGEsVry3EueKv1JfLr-gqzSbQqIFZphawIQ>
    <xmx:-LXWXwzQasYqTYtHFZdCbwfV_BGZeyjyB_EiwTBKCDRpL9WirtHYuQ>
    <xmx:-LXWX3QhueEQjsafDv15dVWdoPp9N0m8NEmXMs7KpdvcPClX3tnFxw>
    <xmx:-7XWXwRkF9vyxNtKrMbJVr9sVyxsRHP5KeqG4IwzFoN-5izkH28N5A>
Received: from [70.135.148.151] (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8320224005E;
        Sun, 13 Dec 2020 19:46:48 -0500 (EST)
Subject: Re: [PATCH v4 1/6] cpufreq: sun50i: add efuse_xlate to get efuse
 version.
To:     Shuosheng Huang <huangshuosheng@allwinnertech.com>,
        tiny.windzz@gmail.com, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        mripard@kernel.org, wens@csie.org, jernej.skrabec@siol.net
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20201208071928.2078-1-huangshuosheng@allwinnertech.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <fbc5ed5d-588a-7e8a-bd26-bb732805bf3a@sholland.org>
Date:   Sun, 13 Dec 2020 18:46:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux ppc64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201208071928.2078-1-huangshuosheng@allwinnertech.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12/8/20 1:19 AM, Shuosheng Huang wrote:
> It's better to use efuse_xlate to extract the differentiated part
> regarding different SoC.
> 
> Signed-off-by: Shuosheng Huang <huangshuosheng@allwinnertech.com>
> ---
>  drivers/cpufreq/sun50i-cpufreq-nvmem.c | 82 ++++++++++++++++----------
>  1 file changed, 51 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/cpufreq/sun50i-cpufreq-nvmem.c b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> index 9907a165135b..3c0531938d1a 100644
> --- a/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> +++ b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> @@ -19,24 +19,51 @@
>  
>  #define MAX_NAME_LEN	7
>  
> -#define NVMEM_MASK	0x7
> -#define NVMEM_SHIFT	5
> +#define SUN50I_H6_NVMEM_MASK		0x7
> +#define SUN50I_H6_NVMEM_SHIFT		5
> +
> +struct sunxi_cpufreq_soc_data {
> +	int (*efuse_xlate)(struct nvmem_cell *speedbin_nvmem);
> +};
>  
>  static struct platform_device *cpufreq_dt_pdev, *sun50i_cpufreq_pdev;
>  
> +static int sun50i_h6_efuse_xlate(struct nvmem_cell *speedbin_nvmem)
> +{
> +	size_t len;
> +	u32 *speedbin;
> +	u32 efuse_value;
> +
> +	speedbin = nvmem_cell_read(speedbin_nvmem, &len);
> +	if (IS_ERR(speedbin))
> +		return PTR_ERR(speedbin);
> +
> +	efuse_value = (*(u32 *)speedbin >> SUN50I_H6_NVMEM_SHIFT) &
> +			  SUN50I_H6_NVMEM_MASK;

This does not need a cast. speedbin is already a pointer to u32.

With the cast removed:

Reviewed-by: Samuel Holland <samuel@sholland.org>
Tested-by: Samuel Holland <samuel@sholland.org> # H6

> +	kfree(speedbin);
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
>  /**
>   * sun50i_cpufreq_get_efuse() - Determine speed grade from efuse value
> - * @versions: Set to the value parsed from efuse
> + * @soc_data: pointer to sunxi_cpufreq_soc_data context
>   *
>   * Returns 0 if success.
>   */
> -static int sun50i_cpufreq_get_efuse(u32 *versions)
> +static int sun50i_cpufreq_get_efuse(const struct sunxi_cpufreq_soc_data *soc_data)
>  {
>  	struct nvmem_cell *speedbin_nvmem;
>  	struct device_node *np;
>  	struct device *cpu_dev;
> -	u32 *speedbin, efuse_value;
> -	size_t len;
> +	int versions;
>  	int ret;
>  
>  	cpu_dev = get_cpu_device(0);
> @@ -63,43 +90,33 @@ static int sun50i_cpufreq_get_efuse(u32 *versions)
>  		return PTR_ERR(speedbin_nvmem);
>  	}
>  
> -	speedbin = nvmem_cell_read(speedbin_nvmem, &len);
> +	versions = soc_data->efuse_xlate(speedbin_nvmem);
>  	nvmem_cell_put(speedbin_nvmem);
> -	if (IS_ERR(speedbin))
> -		return PTR_ERR(speedbin);
> -
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
>  
> -	kfree(speedbin);
> -	return 0;
> +	return versions;
>  };
>  
>  static int sun50i_cpufreq_nvmem_probe(struct platform_device *pdev)
>  {
> +	const struct of_device_id *match;
>  	struct opp_table **opp_tables;
>  	char name[MAX_NAME_LEN];
>  	unsigned int cpu;
> -	u32 speed = 0;
> +	int speed = 0;
>  	int ret;
>  
> +	match = dev_get_platdata(&pdev->dev);
> +	if (!match)
> +		return -EINVAL;
> +
>  	opp_tables = kcalloc(num_possible_cpus(), sizeof(*opp_tables),
>  			     GFP_KERNEL);
>  	if (!opp_tables)
>  		return -ENOMEM;
>  
> -	ret = sun50i_cpufreq_get_efuse(&speed);
> -	if (ret)
> -		return ret;
> +	speed = sun50i_cpufreq_get_efuse(match->data);
> +	if (speed < 0)
> +		return speed;
>  
>  	snprintf(name, MAX_NAME_LEN, "speed%d", speed);
>  
> @@ -163,8 +180,12 @@ static struct platform_driver sun50i_cpufreq_driver = {
>  	},
>  };
>  
> +static const struct sunxi_cpufreq_soc_data sun50i_h6_data = {
> +	.efuse_xlate = sun50i_h6_efuse_xlate,
> +};
> +
>  static const struct of_device_id sun50i_cpufreq_match_list[] = {
> -	{ .compatible = "allwinner,sun50i-h6" },
> +	{ .compatible = "allwinner,sun50i-h6", .data = &sun50i_h6_data },
>  	{}
>  };
>  
> @@ -198,9 +219,8 @@ static int __init sun50i_cpufreq_init(void)
>  	if (unlikely(ret < 0))
>  		return ret;
>  
> -	sun50i_cpufreq_pdev =
> -		platform_device_register_simple("sun50i-cpufreq-nvmem",
> -						-1, NULL, 0);
> +	sun50i_cpufreq_pdev = platform_device_register_data(NULL,
> +		"sun50i-cpufreq-nvmem", -1, match, sizeof(*match));
>  	ret = PTR_ERR_OR_ZERO(sun50i_cpufreq_pdev);
>  	if (ret == 0)
>  		return 0;
> 

