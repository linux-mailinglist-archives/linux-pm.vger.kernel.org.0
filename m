Return-Path: <linux-pm+bounces-5457-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA2F88D527
	for <lists+linux-pm@lfdr.de>; Wed, 27 Mar 2024 04:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C39C01C24F0B
	for <lists+linux-pm@lfdr.de>; Wed, 27 Mar 2024 03:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1230622EF3;
	Wed, 27 Mar 2024 03:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="qW94ZDVW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZQgC6lTc"
X-Original-To: linux-pm@vger.kernel.org
Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A59624A12;
	Wed, 27 Mar 2024 03:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711511193; cv=none; b=llH1drmttjLwtwRPnUsBFkH/P/2ikzW2pjKqBoNj96nq7r9zXb+KbA0gFCq2Ytk7BpRWJOTH1RUocWLLhKxR2Akd4OvTaSrjqwZqliNr8TH+C9Dbmr8buIHMQGTL9TeZaCPL4P8GPfFfF/2a3XWloJqBrcPXEy+c9/akBfalk4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711511193; c=relaxed/simple;
	bh=ciicCspdRaHnQz/jdjSOPf958AP0f8cdXDGzYOTyj20=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FmZbWmacCAdxsx2lAeEwTLUcrSULDkycPeiKIMOdfTbX+5zTGzpnC11FOz9Yd7jnoLf/EBrnuaTDZIOKBbBfqx9pZV6taPQKqjkYe1oIgLh0CneGlEDsvwHK+MbxEJU51GkgGRhhISLUn+Q9JECJDn71I+9JqkDP0QOjFBeAgQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sholland.org; spf=pass smtp.mailfrom=sholland.org; dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b=qW94ZDVW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZQgC6lTc; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sholland.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sholland.org
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id A481913800E1;
	Tue, 26 Mar 2024 23:46:29 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 26 Mar 2024 23:46:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1711511189;
	 x=1711597589; bh=xMuO78seROBlDOTM7NoMldv7CeXi6BqoTvO7uXL1+cw=; b=
	qW94ZDVWCjwTv7HbMBDF+BCZ0rUo+bzt6r91boaLRXEi3qir/8/GvGbbiWeWUoQb
	P95PXHFSVWMV/Cch8H2YGHDaNpcAtqwfH03NTMcXCSV3bgeS7hCoEV29kuZBxJp2
	xmYUN62hTR/y6cFOIGm2qBw1Jm5H6c1eI+dJ/05mSICSOIXD+08b2ZC4Ctaup5x4
	604PjpOGI6x4mfGhPaJC5H1aGTQl53QPJE+AHVUDx7zdrpeV9nQ0dnnf1DDPZo1T
	opQdzWa0LY1ndv9hz3vVpNg7OTF81uNRw/AzSIuc5mO4UuvS5PtinOsnL8JVN7nK
	hIuQUTADiXzyEp+OB80erg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1711511189; x=
	1711597589; bh=xMuO78seROBlDOTM7NoMldv7CeXi6BqoTvO7uXL1+cw=; b=Z
	QgC6lTc5lR068dsKgyqGXimbXgfd3UFmr/hJHDipoj0vOty6dowP2+YtNyXMhHhS
	1cu4xXqnnDava2gOHKKDBLLFsaHgEk1qn6FCj6qbc0T2ZcgEyDhJdpwh8wyTyftS
	JfvVX2tBEhuKgCx4BBmPaH1nr9tSnGm0OS14tX5CJ67x88K/eZWnns6f+DVnNNMg
	85yw2yTUhSxjPZvqWV1cAJysKmPhuyjBsArM5HKhaa/O0uSnB+RVeewKjcEonmJw
	QxA3Mek/kSOZfnarmg0i5jTCyHpMImp+L06WPcpthULGQNzYQSZ1e4OqDNVfXB1R
	mbO+CgE7i9ycTrBHLag9Q==
X-ME-Sender: <xms:lJYDZiLf3ozVr7HYFM-2PF3ILctvA6SbsBEkT5BdNHFzmZIPxh3a3A>
    <xme:lJYDZqKpq66UrF9JK3OG7MDm3QKWDxcjdk2ZbjZfGyKpxIraux-luiPxMQCHC4y1y
    M8A6bOXsZCTAXA49w>
X-ME-Received: <xmr:lJYDZiseN27AqS-I3GtD4CGmdx6rAgdmNLIeloZTMAp3mtAV6hgrsQzhFtVMBm7Aajg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddugedgieegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeetieekgeeilefgtdfgteejhfevtdfgieekvdffjedvvedvveei
    veelfeeuhffhfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:lJYDZnbmGdFZJg6_paWscor44Iq0QasYMQ4Br7K2DsyJr_PFe0-yiQ>
    <xmx:lJYDZpboIFLvjzdKYqcERJY9WjBrQsAJn4fl-WCQ_yvmfsWKte8bXg>
    <xmx:lJYDZjBoKIihBPXBcJDHIUPaVH3U00XZ0Olz_jVGuvijsr7S_w83Vg>
    <xmx:lJYDZvYNrWVmzzV2qjote1rsCWq-82JmUzwgLKYKfDmpq6N3RO3asg>
    <xmx:lZYDZtJx1_t_ntArrTjtv10-zLASVcy2VKT57YT6w9mjlacRFglw2w>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Mar 2024 23:46:27 -0400 (EDT)
Message-ID: <65e86555-761e-4e26-8778-e2452876b5e4@sholland.org>
Date: Tue, 26 Mar 2024 22:46:27 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/8] cpufreq: sun50i: Add H616 support
Content-Language: en-US
To: Andre Przywara <andre.przywara@arm.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-sunxi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 Brandon Cheo Fusi <fusibrandon13@gmail.com>,
 Martin Botka <martin.botka@somainline.org>,
 Martin Botka <martin.botka1@gmail.com>, Chris Morgan
 <macroalpha82@gmail.com>, Ryan Walklin <ryan@testtoast.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Sudeep Holla <sudeep.holla@arm.com>, Yangtao Li <tiny.windzz@gmail.com>,
 Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>
References: <20240326114743.712167-1-andre.przywara@arm.com>
 <20240326114743.712167-7-andre.przywara@arm.com>
From: Samuel Holland <samuel@sholland.org>
In-Reply-To: <20240326114743.712167-7-andre.przywara@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Andre,

On 3/26/24 06:47, Andre Przywara wrote:
> From: Martin Botka <martin.botka@somainline.org>
> 
> The Allwinner H616/H618 SoCs have different OPP tables per SoC version
> and die revision. The SoC version is stored in NVMEM, as before, though
> encoded differently. The die revision is in a different register, in the
> SRAM controller. Firmware already exports that value in a standardised
> way, through the SMCCC SoCID mechanism. We need both values, as some chips
> have the same SoC version, but they don't support the same frequencies and
> they get differentiated by the die revision.
> 
> Add the new compatible string and tie the new translation function to
> it. This mechanism not only covers the original H616 SoC, but also its
> very close sibling SoCs H618 and H700, so add them to the list as well.
> 
> Signed-off-by: Martin Botka <martin.botka@somainline.org>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  drivers/cpufreq/sun50i-cpufreq-nvmem.c | 61 ++++++++++++++++++++++++++
>  1 file changed, 61 insertions(+)
> 
> diff --git a/drivers/cpufreq/sun50i-cpufreq-nvmem.c b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> index bd170611c7906..f9e9fc340f848 100644
> --- a/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> +++ b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> @@ -10,6 +10,7 @@
>  
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>  
> +#include <linux/arm-smccc.h>
>  #include <linux/cpu.h>
>  #include <linux/module.h>
>  #include <linux/nvmem-consumer.h>
> @@ -46,14 +47,71 @@ static u32 sun50i_h6_efuse_xlate(u32 speedbin)
>  		return 0;
>  }
>  
> +/*
> + * Judging by the OPP tables in the vendor BSP, the quality order of the
> + * returned speedbin index is 4 -> 0/2 -> 3 -> 1, from worst to best.
> + * 0 and 2 seem identical from the OPP tables' point of view.
> + */
> +static u32 sun50i_h616_efuse_xlate(u32 speedbin)
> +{
> +	int ver_bits = arm_smccc_get_soc_id_revision();

This needs a Kconfig dependency on ARM_SMCCC_SOC_ID.

Regards,
Samuel

> +	u32 value = 0;
> +
> +	switch (speedbin & 0xffff) {
> +	case 0x2000:
> +		value = 0;
> +		break;
> +	case 0x2400:
> +	case 0x7400:
> +	case 0x2c00:
> +	case 0x7c00:
> +		if (ver_bits != SMCCC_RET_NOT_SUPPORTED && ver_bits <= 1) {
> +			/* ic version A/B */
> +			value = 1;
> +		} else {
> +			/* ic version C and later version */
> +			value = 2;
> +		}
> +		break;
> +	case 0x5000:
> +	case 0x5400:
> +	case 0x6000:
> +		value = 3;
> +		break;
> +	case 0x5c00:
> +		value = 4;
> +		break;
> +	case 0x5d00:
> +		value = 0;
> +		break;
> +	case 0x6c00:
> +		value = 5;
> +		break;
> +	default:
> +		pr_warn("sun50i-cpufreq-nvmem: unknown speed bin 0x%x, using default bin 0\n",
> +			speedbin & 0xffff);
> +		value = 0;
> +		break;
> +	}
> +
> +	return value;
> +}
> +
>  static struct sunxi_cpufreq_data sun50i_h6_cpufreq_data = {
>  	.efuse_xlate = sun50i_h6_efuse_xlate,
>  };
>  
> +static struct sunxi_cpufreq_data sun50i_h616_cpufreq_data = {
> +	.efuse_xlate = sun50i_h616_efuse_xlate,
> +};
> +
>  static const struct of_device_id cpu_opp_match_list[] = {
>  	{ .compatible = "allwinner,sun50i-h6-operating-points",
>  	  .data = &sun50i_h6_cpufreq_data,
>  	},
> +	{ .compatible = "allwinner,sun50i-h616-operating-points",
> +	  .data = &sun50i_h616_cpufreq_data,
> +	},
>  	{}
>  };
>  
> @@ -230,6 +288,9 @@ static struct platform_driver sun50i_cpufreq_driver = {
>  
>  static const struct of_device_id sun50i_cpufreq_match_list[] = {
>  	{ .compatible = "allwinner,sun50i-h6" },
> +	{ .compatible = "allwinner,sun50i-h616" },
> +	{ .compatible = "allwinner,sun50i-h618" },
> +	{ .compatible = "allwinner,sun50i-h700" },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, sun50i_cpufreq_match_list);


