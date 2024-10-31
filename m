Return-Path: <linux-pm+bounces-16833-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF5649B7CA7
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2024 15:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40BB0B21FC1
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2024 14:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3D919EED6;
	Thu, 31 Oct 2024 14:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linumiz.com header.i=@linumiz.com header.b="MElCisaX"
X-Original-To: linux-pm@vger.kernel.org
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A0619924F
	for <linux-pm@vger.kernel.org>; Thu, 31 Oct 2024 14:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730384417; cv=none; b=mqZJg9fNJ0ZxEvTayxfVytS7ubtoKU4ByRF8ceaNZtg3Rqk/zbzI0o79Yi/N6025itcC9zVIWfc19V5HtQGwn9Kmoqxd+jk3v3JPo3s1ZcvU/IiY5d7Vja10S4wON8QhRdzVI4z8stNHYWyM2JtNNi/JhM7fS5VjCwggiZjU5zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730384417; c=relaxed/simple;
	bh=l2hyfqAJXg9tKTsASSLgWaBLbApxQC/IUedeczyE7dA=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nBycODHRLApXQTI7CMiJj4jdCKTMqZs53xMsXw/QVy22ZotBmM0YRHjrzrHdCKLKi7h1bASMWQ7SxhPte8PEmyVK4KWi96O7yyQD9wThoYK6Ji3GPjIhTMlV3bxoxuzr0zFJxGvvQBDTeqRkd4x/f13yqSG9SX3Pnptd2nvLj0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linumiz.com; spf=pass smtp.mailfrom=linumiz.com; dkim=pass (2048-bit key) header.d=linumiz.com header.i=@linumiz.com header.b=MElCisaX; arc=none smtp.client-ip=35.89.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linumiz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linumiz.com
Received: from eig-obgw-6002a.ext.cloudfilter.net ([10.0.30.222])
	by cmsmtp with ESMTPS
	id 6BmWt6owSqvuo6W1xtSEp1; Thu, 31 Oct 2024 14:20:09 +0000
Received: from md-in-79.webhostbox.net ([43.225.55.182])
	by cmsmtp with ESMTPS
	id 6W1vt3Fjw65gF6W1wtL63x; Thu, 31 Oct 2024 14:20:09 +0000
X-Authority-Analysis: v=2.4 cv=Z58nH2RA c=1 sm=1 tr=0 ts=67239219
 a=LfuyaZh/8e9VOkaVZk0aRw==:117 a=kofhyyBXuK/oEhdxNjf66Q==:17
 a=IkcTkHD0fZMA:10 a=DAUX931o1VcA:10 a=-pn6D5nKLtMA:10 a=6Ujbnq6iAAAA:8
 a=vU9dKmh3AAAA:8 a=UQ0gWoj1K6JKIvSkpFIA:9 a=QEXdDO2ut3YA:10
 a=-sNzveBoo8RYOSiOai2t:22 a=rsP06fVo5MYu2ilr0aT5:22 a=ZCPYImcxYIQFgLOT52_G:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=linumiz.com
	; s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+jxM7lRle7VcSb1cHFDpbe2ijsT2r/j9mqp7JE6/0QY=; b=MElCisaXm1Z0+gopzkxIofO/XC
	+bkgABtUvhl7xIE1PLBpyq9jFI7iHPGc6lOLzoTPbeRP4d6rtjGAq1K0QB83bWCnZR/sInsKWQnl4
	ip/MD9ihA/DsKWRDpRSau8c3zk5rcrL4ZIVZBDAPWdXPfkf5CLNimFRm80eEOEyoPbto/+ZDoOp5t
	OO5nny7KBgSUcN526T+uBC716GoaxD0A+Gv0RJdwTKaEq5N800HkDG/rpNqez1wRabx+h3MX+MeAp
	QGDtNqgxeyeKKUXiiBuh+89gz2WYaPxPACvKWio8Wx+H1AoG45aWwWzCRNN7kcakWMWSk7zFfrAuK
	io09hJAg==;
Received: from [122.165.245.213] (port=32784 helo=[192.168.1.5])
	by md-in-79.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <parthiban@linumiz.com>)
	id 1t6W1o-003EHK-1D;
	Thu, 31 Oct 2024 19:50:00 +0530
Message-ID: <4c2afef1-dd0d-48e8-a9bc-650edf44b399@linumiz.com>
Date: Thu, 31 Oct 2024 19:49:55 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: parthiban@linumiz.com, Conor Dooley <conor+dt@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Maxime Ripard
 <mripard@kernel.org>, Michael Turquette <mturquette@baylibre.com>,
 Nishanth Menon <nm@ti.com>, Rob Herring <robh@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Viresh Kumar <vireshk@kernel.org>, Andre Przywara <andre.przywara@arm.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v2 12/13] cpufreq: sun50i: add a100 cpufreq support
To: Cody Eksal <masterr3c0rd@epochal.quest>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Yangtao Li <tiny.windzz@gmail.com>,
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>
References: <20241031070232.1793078-1-masterr3c0rd@epochal.quest>
 <20241031070232.1793078-13-masterr3c0rd@epochal.quest>
Content-Language: en-US
From: Parthiban <parthiban@linumiz.com>
Organization: Linumiz
In-Reply-To: <20241031070232.1793078-13-masterr3c0rd@epochal.quest>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - md-in-79.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - linumiz.com
X-BWhitelist: no
X-Source-IP: 122.165.245.213
X-Source-L: No
X-Exim-ID: 1t6W1o-003EHK-1D
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.5]) [122.165.245.213]:32784
X-Source-Auth: parthiban@linumiz.com
X-Email-Count: 27
X-Org: HG=dishared_whb_net_legacy;ORG=directi;
X-Source-Cap: bGludW1jbWM7aG9zdGdhdG9yO21kLWluLTc5LndlYmhvc3Rib3gubmV0
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfKwFH8CMDW52ai9okL0kbUE0w18A7YYFBB2B9ZHAGYEC84y0wvNqE+cTunQeBpXrg6LusVkTpUAYCfVtvxW30S50R7E55TaDKgjFzzWzKLBatSwEPu/v
 t9Hn197uNNPHY8v8HH0DMe4BI1alJZLCiIZ2Mn8hX6Qktx69K3A6/POIaMRY8b2e0C45hwzuEn6SH0UOF1t6aXRmnfLBwAnoOD4=

On 10/31/24 12:32 PM, Cody Eksal wrote:
> From: Shuosheng Huang <huangshuosheng@allwinnertech.com>
> 
> Let's add cpufreq nvmem based for allwinner a100 soc. It's similar to h6,
> let us use efuse_xlate to extract the differentiated part.
> 
> Signed-off-by: Shuosheng Huang <huangshuosheng@allwinnertech.com>
> [masterr3c0rd@epochal.quest: add A100 to opp_match_list]
> Signed-off-by: Cody Eksal <masterr3c0rd@epochal.quest>

Although I couldn't get the secondary CPU's running because of missing BL31 support,
it works fine in CPU0.

Tested-by: Parthiban Nallathambi <parthiban@linumiz.com>

Thanks,
Parthiban

> ---
> Changes in V2:
>  - Add the A100 to the cpufreq-dt-platdev blacklist.
> 
>  drivers/cpufreq/cpufreq-dt-platdev.c   |  1 +
>  drivers/cpufreq/sun50i-cpufreq-nvmem.c | 28 ++++++++++++++++++++++++++
>  2 files changed, 29 insertions(+)
> 
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> index 18942bfe9c95..2a3e8bd317c9 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -103,6 +103,7 @@ static const struct of_device_id allowlist[] __initconst = {
>   * platforms using "operating-points-v2" property.
>   */
>  static const struct of_device_id blocklist[] __initconst = {
> +	{ .compatible = "allwinner,sun50i-a100" },
>  	{ .compatible = "allwinner,sun50i-h6", },
>  	{ .compatible = "allwinner,sun50i-h616", },
>  	{ .compatible = "allwinner,sun50i-h618", },
> diff --git a/drivers/cpufreq/sun50i-cpufreq-nvmem.c b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> index 293921acec93..3a29c026d364 100644
> --- a/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> +++ b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> @@ -22,6 +22,9 @@
>  #define NVMEM_MASK	0x7
>  #define NVMEM_SHIFT	5
>  
> +#define SUN50I_A100_NVMEM_MASK	0xf
> +#define SUN50I_A100_NVMEM_SHIFT	12
> +
>  static struct platform_device *cpufreq_dt_pdev, *sun50i_cpufreq_pdev;
>  
>  struct sunxi_cpufreq_data {
> @@ -45,6 +48,23 @@ static u32 sun50i_h6_efuse_xlate(u32 speedbin)
>  		return 0;
>  }
>  
> +static u32 sun50i_a100_efuse_xlate(u32 speedbin)
> +{
> +	u32 efuse_value;
> +
> +	efuse_value = (speedbin >> SUN50I_A100_NVMEM_SHIFT) &
> +		      SUN50I_A100_NVMEM_MASK;
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
>  static int get_soc_id_revision(void)
>  {
>  #ifdef CONFIG_HAVE_ARM_SMCCC_DISCOVERY
> @@ -108,6 +128,10 @@ static struct sunxi_cpufreq_data sun50i_h6_cpufreq_data = {
>  	.efuse_xlate = sun50i_h6_efuse_xlate,
>  };
>  
> +static struct sunxi_cpufreq_data sun50i_a100_cpufreq_data = {
> +	.efuse_xlate = sun50i_a100_efuse_xlate,
> +};
> +
>  static struct sunxi_cpufreq_data sun50i_h616_cpufreq_data = {
>  	.efuse_xlate = sun50i_h616_efuse_xlate,
>  };
> @@ -116,6 +140,9 @@ static const struct of_device_id cpu_opp_match_list[] = {
>  	{ .compatible = "allwinner,sun50i-h6-operating-points",
>  	  .data = &sun50i_h6_cpufreq_data,
>  	},
> +	{ .compatible = "allwinner,sun50i-a100-operating-points",
> +	  .data = &sun50i_a100_cpufreq_data,
> +	},
>  	{ .compatible = "allwinner,sun50i-h616-operating-points",
>  	  .data = &sun50i_h616_cpufreq_data,
>  	},
> @@ -291,6 +318,7 @@ static struct platform_driver sun50i_cpufreq_driver = {
>  
>  static const struct of_device_id sun50i_cpufreq_match_list[] = {
>  	{ .compatible = "allwinner,sun50i-h6" },
> +	{ .compatible = "allwinner,sun50i-a100" },
>  	{ .compatible = "allwinner,sun50i-h616" },
>  	{ .compatible = "allwinner,sun50i-h618" },
>  	{ .compatible = "allwinner,sun50i-h700" },


