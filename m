Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2F052D9178
	for <lists+linux-pm@lfdr.de>; Mon, 14 Dec 2020 01:52:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437114AbgLNAwE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 13 Dec 2020 19:52:04 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:58451 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2437112AbgLNAwE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 13 Dec 2020 19:52:04 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 5F0F35C00E9;
        Sun, 13 Dec 2020 19:51:18 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 13 Dec 2020 19:51:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm1; bh=n
        UsnEJ5xuuI3XicalHfw7mauzuv7uoY9/R12OhFTi9c=; b=Xf+ozzDFhucycQ1Hg
        2yanfj9ezljGlH2nr/ZJafsT7QSP5mOhp3T92XGAFHCld0lPdK/xhAPmVnNYVLop
        g3CrkmEtG575crtTafG2NetKZSuM+SeJTxBX6zfIilSkQAWBa8mJQp6BeOxuVq9l
        6LLBR3E++2ifyx+JVtod3gD5RfFK7BLd21ekAr5/0Fz4w05jXhQO02hEFF27ooRn
        GZPa3thUFPYYO/855IAGjsqM61wRIyd5WMcz5WZAjCvm6Ao7JDC3QzAm+kxkfNla
        PDKHzEXI0DzZZ3GgUPdt4bKzzb6WAj8e74nVUvbI0E590HLJIvFvCluGcuOsh+2/
        OlI1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=nUsnEJ5xuuI3XicalHfw7mauzuv7uoY9/R12OhFTi
        9c=; b=ROjGx5eElgHG6618FqW7gYHtdyUY1kYQgFpdC96puvFBB722LnGSySmXK
        NYb2rJloDzBlrOwBhEHy55tHPkkFwP71zuH3haFRku8Hu89itzJwD7+HF4jFi9iJ
        c5GbblBqy+JwR/PViR0mpabeuT1PFQU5TYs84whII1gjT8hJzyArMhlQsRQyJO+b
        hu+2OaLZl4GVfTPRPt434iGCSqr6JoOMjGM/vwgJrN+xNHdmpZ0cWxHOJEmjtJfq
        +ApoNub94gXamvou9YCu6vz18GUz/kk5rZD+Qe2WFA6hBkYh02mssNLF/QgzoRPW
        PF/4SaIP7PTY1+psa/BBFv4obdDcg==
X-ME-Sender: <xms:BbfWXwecUhlnYL6IdLN5ysc2WiBtrU2sfB9OcJ-nnndJfXfx7JBjQw>
    <xme:BbfWXyPVxDDUpFVhAiKOkTyFO9DpyWoAUazCnRxsfxUvxpsFwM4WMJF9D6a7kJjm8
    hf6hKNaBhHEzewzzQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudekjedgtdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvfhfhkffffgggjggtgfesthejredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepgfevffetleehffejueekvdekvdeitdehveegfeekheeuieeiueet
    uefgtedtgeegnecukfhppeejtddrudefhedrudegkedrudehudenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgr
    nhgurdhorhhg
X-ME-Proxy: <xmx:BbfWXxiK8GiXHT49sN-4dz3YmNoytC_axA42c6UfUyqYqUMPK03TWA>
    <xmx:BbfWX1_Ify0gE41r7eHgyNbC6O3RFNHFzU1CrUztsiTUtPNUqG7t5A>
    <xmx:BbfWX8tuRYPZ_QILxnQwCD-P0nFAa7XboN-XH2xlvBT57qC9lvrAmQ>
    <xmx:BrfWXx_u6ZF26SNbAozMc6kRsC1uI3VH4RVskT44F5Uh5VBGcWUnfw>
Received: from [70.135.148.151] (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id C9DCD24005B;
        Sun, 13 Dec 2020 19:51:16 -0500 (EST)
Subject: Re: [PATCH v4 2/6] cpufreq: sun50i: add a100 cpufreq support
To:     Shuosheng Huang <huangshuosheng@allwinnertech.com>,
        tiny.windzz@gmail.com, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        mripard@kernel.org, wens@csie.org, jernej.skrabec@siol.net
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20201208071953.24536-1-huangshuosheng@allwinnertech.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <1e50b1d4-fc17-648f-2437-22f097868549@sholland.org>
Date:   Sun, 13 Dec 2020 18:51:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux ppc64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201208071953.24536-1-huangshuosheng@allwinnertech.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12/8/20 1:19 AM, Shuosheng Huang wrote:
> Add cpufreq nvmem based for allwinner a100 SoC, it's similar to h6.
> 
> Signed-off-by: Shuosheng Huang <huangshuosheng@allwinnertech.com>
> ---
>  drivers/cpufreq/cpufreq-dt-platdev.c   |  1 +
>  drivers/cpufreq/sun50i-cpufreq-nvmem.c | 32 ++++++++++++++++++++++++++
>  2 files changed, 33 insertions(+)
> 
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> index 3776d960f405..2ebf5d9cb616 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -102,6 +102,7 @@ static const struct of_device_id whitelist[] __initconst = {
>   */
>  static const struct of_device_id blacklist[] __initconst = {
>  	{ .compatible = "allwinner,sun50i-h6", },
> +	{ .compatible = "allwinner,sun50i-a100", },
>  
>  	{ .compatible = "calxeda,highbank", },
>  	{ .compatible = "calxeda,ecx-2000", },
> diff --git a/drivers/cpufreq/sun50i-cpufreq-nvmem.c b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> index 3c0531938d1a..aead98164373 100644
> --- a/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> +++ b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> @@ -22,6 +22,9 @@
>  #define SUN50I_H6_NVMEM_MASK		0x7
>  #define SUN50I_H6_NVMEM_SHIFT		5
>  
> +#define SUN50I_A100_NVMEM_MASK		0xf
> +#define SUN50I_A100_NVMEM_SHIFT		12
> +
>  struct sunxi_cpufreq_soc_data {
>  	int (*efuse_xlate)(struct nvmem_cell *speedbin_nvmem);
>  };
> @@ -52,6 +55,30 @@ static int sun50i_h6_efuse_xlate(struct nvmem_cell *speedbin_nvmem)
>  		return 0;
>  }
>  
> +static int sun50i_a100_efuse_xlate(struct nvmem_cell *speedbin_nvmem)
> +{
> +	size_t len;
> +	u32 *speedbin;
> +	u32 efuse_value;
> +
> +	speedbin = nvmem_cell_read(speedbin_nvmem, &len);
> +	if (IS_ERR(speedbin))
> +		return PTR_ERR(speedbin);
> +
> +	efuse_value = (*(u16 *)efuse >> SUN50I_A100_NVMEM_SHIFT) &

This does not compile. `efuse` should be `speedbin`. And please remove
the cast after fixing the types of the variables to be `u16` instead of
`u32`.

Cheers,
Samuel

> +			  SUN50I_A100_NVMEM_MASK;
> +	kfree(speedbin);
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
>  /**
>   * sun50i_cpufreq_get_efuse() - Determine speed grade from efuse value
>   * @soc_data: pointer to sunxi_cpufreq_soc_data context
> @@ -184,8 +211,13 @@ static const struct sunxi_cpufreq_soc_data sun50i_h6_data = {
>  	.efuse_xlate = sun50i_h6_efuse_xlate,
>  };
>  
> +static const struct sunxi_cpufreq_soc_data sun50i_a100_data = {
> +	.efuse_xlate = sun50i_a100_efuse_xlate,
> +};
> +
>  static const struct of_device_id sun50i_cpufreq_match_list[] = {
>  	{ .compatible = "allwinner,sun50i-h6", .data = &sun50i_h6_data },
> +	{ .compatible = "allwinner,sun50i-a100", .data = &sun50i_a100_data },
>  	{}
>  };
>  
> 

