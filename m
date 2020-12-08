Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 173BF2D21D9
	for <lists+linux-pm@lfdr.de>; Tue,  8 Dec 2020 05:14:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbgLHEKx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Dec 2020 23:10:53 -0500
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:56067 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726048AbgLHEKw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Dec 2020 23:10:52 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 35D31C0D;
        Mon,  7 Dec 2020 23:10:06 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 07 Dec 2020 23:10:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        to:cc:references:from:subject:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm1; bh=t
        hPfHNvHBgBwFsdE/nnkzFCxSaj3tnRQE7Aisw/au5c=; b=nI3kvkR+hZ0kK/IGt
        lvtnviRbpSjaXztIA68DjAJo0BP1UEa8kXrTk1lbKAxxEFUeP5DeIwRHOKZwkKuA
        q4d0d6VYNQWjkJOBi+cDr3WegNgzfW8a649xplpCqsdxqGjYAy7rQakmak4P8UOl
        tz5k+8URRWaTAs9tT2P8ddF1fvigelfFMTnw2Vh4k7tiqKw9VnnCDYBwbFMkszQ3
        BRyh1xyMLByB5VA7S0IFtWYADP3+Mkef6ConjZIpCteK92gz2EHxujDA/wA6u5md
        zDpC/C4uqWQTIhupiUlZuIcZTr+gevwdwO4q5bYBdcWDrI3jjlNyy2OFGWHYhsO0
        JGcTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=thPfHNvHBgBwFsdE/nnkzFCxSaj3tnRQE7Aisw/au
        5c=; b=nXTvLnNmSah2K4sfz5H3jW7oOaks9kBKO0LkVQaw1CWk5nTU163Zmf85M
        yEXmXG/9kSSJeZd0x229/ShlJ/I3BNj9mo5gNoBCANaPsCulYRd6ovkQa9+zJFMF
        ZCC8UabwPTbhx0tGJn183HcyIB6e+F5RLlReec8wtBJuRGMDMjKujTraQtxTZnI6
        o5S5iXDd1qTAgkWYo7lIU6WeHscIzH8bMTob1sMQVgN/sahaBPBJ9wh8jEcN+10u
        kHfwqiMTwGe+YYWRCCg1pZHHG3rQvfzMMSr/71NQXgS1kVliLVXIOSi/X/HjPCFc
        dBlzPJMJw42uUuTLDZkNf5JoXKccQ==
X-ME-Sender: <xms:nPzOX3RBDOIK0F6oFJ-OeoGuQkQEocxE-4Rw4OG_XNtUXtIwZ1P1SA>
    <xme:nPzOX4wy7HjNtS5cyaEs71E3B-algqMtkCVH4zKwTxriDXFeh8Y0HW0C6Whn9mZJz
    EfnEJz396PuBBAFpg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudejhedgieejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepvfhfhffukffffgggjggtgfesthekredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepvddttdejieduudfgffevteekffegffeguddtgfefkeduvedukeff
    hedtfeevuedvnecukfhppeejtddrudefhedrudegkedrudehudenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgr
    nhgurdhorhhg
X-ME-Proxy: <xmx:nPzOX82la6ot3lC2T8ZN9GCqTtSRDA7mYZQieJivbMG9kscSA1Zq7w>
    <xmx:nPzOX3AyqypJ9qqA7wYGo-Dp0ejI_0yxvwPTeWqkIYzHawtU0SN-zg>
    <xmx:nPzOXwjeuNV3uqsKwlNixId-5W_pOlN2WSaz0DyCKSBfd8ChsGzH1g>
    <xmx:nfzOX8h3N-Z_fBU6n07cqyq8XnKpVdyFBmowqYGOwSK14PH12W8BLw>
Received: from [70.135.148.151] (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 001AB24005D;
        Mon,  7 Dec 2020 23:10:03 -0500 (EST)
To:     Shuosheng Huang <huangshuosheng@allwinnertech.com>,
        tiny.windzz@gmail.com, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        mripard@kernel.org, wens@csie.org, jernej.skrabec@siol.net
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
References: <20201208023720.22544-1-huangshuosheng@allwinnertech.com>
From:   Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH v3 1/6] cpufreq: sun50i: add efuse_xlate to get efuse
 version.
Message-ID: <e0a2573d-8009-39c1-63cb-c828dfcbabef@sholland.org>
Date:   Mon, 7 Dec 2020 22:10:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux ppc64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201208023720.22544-1-huangshuosheng@allwinnertech.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello,

On 12/7/20 8:37 PM, Shuosheng Huang wrote:
> It's better to use efuse_xlate to extract the differentiated part
> regarding different SoC.
> 
> Signed-off-by: Shuosheng Huang <huangshuosheng@allwinnertech.com>
> ---
>  drivers/cpufreq/sun50i-cpufreq-nvmem.c | 72 +++++++++++++++++---------
>  1 file changed, 48 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/cpufreq/sun50i-cpufreq-nvmem.c b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> index 9907a165135b..da23d581a4b4 100644
> --- a/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> +++ b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> @@ -22,21 +22,52 @@
>  #define NVMEM_MASK	0x7
>  #define NVMEM_SHIFT	5

You should remove these definitions now that you added the ones below.

>
> +#define SUN50I_H6_NVMEM_MASK		0x7
> +#define SUN50I_H6_NVMEM_SHIFT		5
> +
> +struct sunxi_cpufreq_soc_data {
> +	u32 (*efuse_xlate)(void *efuse);
> +};
> +
>  static struct platform_device *cpufreq_dt_pdev, *sun50i_cpufreq_pdev;
>  
> +static u32 sun50i_h6_efuse_xlate(struct nvmem_cell *speedbin_nvmem)
> +{
> +	size_t len;
> +	u32 *speedbin;
> +	u32 efuse_value;
> +
> +	speedbin = nvmem_cell_read(speedbin_nvmem, &len);
> +	if (IS_ERR(speedbin))
> +		return PTR_ERR(speedbin);

You're trying to return a negative value for an error here, but the
return type is unsigned.

> +
> +	efuse_value = (*(u32 *)speedbin >> SUN50I_H6_NVMEM_SHIFT) &
> +			  SUN50I_H6_NVMEM_MASK;
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
> + * @soc_data: pointer to sunxi_cpufreq_soc_data context
>   * @versions: Set to the value parsed from efuse
>   *
>   * Returns 0 if success.
>   */
> -static int sun50i_cpufreq_get_efuse(u32 *versions)
> +static int sun50i_cpufreq_get_efuse(const struct sunxi_cpufreq_soc_data *soc_data,
> +				    u32 *versions)
>  {
>  	struct nvmem_cell *speedbin_nvmem;
>  	struct device_node *np;
>  	struct device *cpu_dev;
> -	u32 *speedbin, efuse_value;
> -	size_t len;
>  	int ret;
>  
>  	cpu_dev = get_cpu_device(0);
> @@ -63,41 +94,31 @@ static int sun50i_cpufreq_get_efuse(u32 *versions)
>  		return PTR_ERR(speedbin_nvmem);
>  	}
>  
> -	speedbin = nvmem_cell_read(speedbin_nvmem, &len);
> +	*versions = soc_data->efuse_xlate(speedbin_nvmem);
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
>  	return 0;

If *versions is negative, you need to pass that error back to the caller.

>  };
>  
>  static int sun50i_cpufreq_nvmem_probe(struct platform_device *pdev)
>  {
> +	const struct of_device_id *match;
>  	struct opp_table **opp_tables;
>  	char name[MAX_NAME_LEN];
>  	unsigned int cpu;
>  	u32 speed = 0;
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
> +	ret = sun50i_cpufreq_get_efuse(match->data, &speed);
>  	if (ret)
>  		return ret;

Since we've already decoupled the speed grade from the nvmem value, why
not make this:

	int speed;
	...
	speed = sun50i_cpufreq_get_efuse(match->data);
	if (speed < 0)
		return speed;

And have sun50i_cpufreq_get_efuse return the value from efuse_xlate
without all the pointer indirection.

And this is a separate bug in the existing code, but it leaks opp_tables
if sun50i_cpufreq_get_efuse fails. That could be fixed by moving the
call to sun50i_cpufreq_get_efuse up.

Cheers,
Samuel

>  
> @@ -163,8 +184,12 @@ static struct platform_driver sun50i_cpufreq_driver = {
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
> @@ -198,9 +223,8 @@ static int __init sun50i_cpufreq_init(void)
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

