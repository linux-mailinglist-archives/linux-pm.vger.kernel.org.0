Return-Path: <linux-pm+bounces-38904-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A9EABC93344
	for <lists+linux-pm@lfdr.de>; Fri, 28 Nov 2025 22:48:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5E9444E22AA
	for <lists+linux-pm@lfdr.de>; Fri, 28 Nov 2025 21:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C112DC786;
	Fri, 28 Nov 2025 21:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b="AgY2i32M"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx.olsak.net (mx.olsak.net [37.205.8.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F73B274650;
	Fri, 28 Nov 2025 21:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.8.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764366514; cv=none; b=UcBP1JcNXelscWG/qNsrBY19jJ6vILnGyL+EhST/BlzVF/T+mCHAyOLjxMZsxujnvqpaJ3EdnS/CFmDTFoEPTBuP8ZRVxe9EFTLo7PhT1ISiLDsEWvhcfnuXvSj79d1H7TtbWwH6zbJjAzDLS2E10E0gvE4HPq+ZUw4jItQt8Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764366514; c=relaxed/simple;
	bh=8J3YDjpYznPiRiy+EBBMfAiGasMqL72qxn8ycf9hKvI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ufW1kR3ovIDs3mtjLqZAKOl1lKjeE78c6GogOh84A5QWn9mvNWcCIA4N8rOJRY+Ra4uuenImyEwXokubLZIT5x8a1QzBwVH+tG+OabHWeE8v32bRAtEzSBa293e3fClHfAmoFPZ6Zu+4nVSmhDfzD2dxextD11FlfWsjoNKQ4sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz; spf=pass smtp.mailfrom=dujemihanovic.xyz; dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b=AgY2i32M; arc=none smtp.client-ip=37.205.8.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dujemihanovic.xyz
DKIM-Signature: a=rsa-sha256; bh=p2qtcpRq8efSAHaERqbxo76VCGb4u4RH+i4nykgh9AU=;
 c=relaxed/relaxed; d=dujemihanovic.xyz;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:In-Reply-To:Message-Id:Message-Id:References:References:Autocrypt:Openpgp;
 i=@dujemihanovic.xyz; s=default; t=1764365456; v=1; x=1764797456;
 b=AgY2i32MfwrLjBId1IrPpncT+tqowE+QwxuR7ntoWP3V8c5Px3J7ADTQjstLIDuyQ1TV5Sbp
 5jb0Io14qPVxkm9MpOHzDo2WjXSqQIXalzeeoknH5rXOy6tygBNOGUc/a/Go+rqjSsQGgZV2SFH
 ARbvDv22F3DK+Q4i2bDg8OYYxKwdsJq+V7lhUOf+fGa0u/mJQgbi/HyfEnq40EgOe/Lo6rtGwD7
 CXTgYGjXKd2d5CuCY6WRwdjz+Kr3irAzm8QfFTdsPPCmHu71sedWfLtvqXI09rDUBHrvs7C+Lul
 oA8GeHbPwWD2mRlKrgNaDH70Hm9HnRVd0P2ZHikCoX/GQ==
Received: by mx.olsak.net (envelope-sender <duje@dujemihanovic.xyz>) with
 ESMTPS id 43edb07d; Fri, 28 Nov 2025 22:30:56 +0100
Message-ID: <51c9408e-45e7-4ce7-9e95-6e0a45bcc8fa@dujemihanovic.xyz>
Date: Fri, 28 Nov 2025 22:30:55 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] pmdomain: add audio power island for Marvell PXA1908
 SoC
To: Karel Balej <balejk@matfyz.cz>, Ulf Hansson <ulf.hansson@linaro.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
References: <20251127190237.745-1-balejk@matfyz.cz>
 <20251127190237.745-2-balejk@matfyz.cz>
Content-Language: en-US
From: =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
In-Reply-To: <20251127190237.745-2-balejk@matfyz.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/27/2025 8:02 PM, Karel Balej wrote:
> Define power domain which needs to be enabled in order for audio to work
> on the PXA1908-based samsung,coreprimevelte smartphone. In the
> downstream code, this power-on method is marked as specific to the ulcx
> series which is likely some variant of the board or some part of it. No
> other audio components needed for sound to work on this phone are
> currently available mainline but some successful testing was performed
> with the vendor variants of the respective drivers and with the domain
> forced always-on.

From what I know, ULCx is actually meant to be some SoC codename. ULC1
happens to be PXA1908, but I couldn't find any such codename for the rest.

Other than that, just a few nits:

> diff --git a/drivers/pmdomain/marvell/pxa1908-power-controller.c b/drivers/pmdomain/marvell/pxa1908-power-controller.c
> index ff5e6e82d3f8..e32eb227f235 100644
> --- a/drivers/pmdomain/marvell/pxa1908-power-controller.c
> +++ b/drivers/pmdomain/marvell/pxa1908-power-controller.c
> @@ -29,7 +29,10 @@
>  #define POWER_POLL_TIMEOUT_US	(25 * USEC_PER_MSEC)
>  #define POWER_POLL_SLEEP_US	6
>  
> -#define NR_DOMAINS	5
> +#define APMU_AUD_CLK		0x80
> +#define AUDIO_ULCX_ENABLE	0x0d

I would group these with the other register definitions.

Also, it's probably better to be more consistent with the naming, so I'd
prefer APMU_AUDIO_CLK.

> @@ -59,9 +62,13 @@ static inline bool pxa1908_pd_is_on(struct pxa1908_pd *pd)
>  {
>  	struct pxa1908_pd_ctrl *ctrl = pd->ctrl;
>  
> -	return pd->data.id != PXA1908_POWER_DOMAIN_DSI
> -		? regmap_test_bits(ctrl->base, APMU_PWR_STATUS_REG, pd->data.pwr_state)
> -		: regmap_test_bits(ctrl->base, APMU_DEBUG, DSI_PHY_DVM_MASK);
> +	switch (pd->data.id) {
> +	case PXA1908_POWER_DOMAIN_AUDIO:
> +		return regmap_test_bits(ctrl->base, APMU_AUD_CLK, AUDIO_ULCX_ENABLE);
> +	case PXA1908_POWER_DOMAIN_DSI:
> +		return regmap_test_bits(ctrl->base, APMU_DEBUG, DSI_PHY_DVM_MASK);
> +	}
> +	return regmap_test_bits(ctrl->base, APMU_PWR_STATUS_REG, pd->data.pwr_state);

Perhaps this should go into the switch?

Regards,
--
Duje

