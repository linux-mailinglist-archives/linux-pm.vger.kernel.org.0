Return-Path: <linux-pm+bounces-20080-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D46BA05750
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2025 10:49:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F085A3A5044
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2025 09:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A228D1F5432;
	Wed,  8 Jan 2025 09:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JaMuWFnh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C29B1F2C5E
	for <linux-pm@vger.kernel.org>; Wed,  8 Jan 2025 09:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736329767; cv=none; b=TbMUN+AO+jlSFa9Sy9ZGebmUdRLwOCRkxnTsvmlBgrzpGwEhHogPUg0GNVs2P43bVbsYiZvC0eZJ5/xIzkU9qT54plMN1fLnHopMtBeZaen/NC47SxVAgm47y+vqkrZKeg4Ox7E69L5CSDO9hpnuf9NqCGuvAog+c+jCUf0uoaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736329767; c=relaxed/simple;
	bh=9deTj6/vvguCX59Rp5CA9tK97aPiY1BmdFL+MDFSKko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qvveCJaqZDGg1j2ULYhjycXn9GgihO1sEw3tzZKKti4lvkWiJLekrgg8+VCflRDBsLFe8/u3cNiKsMw0RnIZtyhW8VUiGi0/ub8bLEIR2fowDoYHAv3gKPvQCsvVnsbSDPWv4toTPmjJaT/BwnZioI126k4iW9u4nugeGGgYu3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JaMuWFnh; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3ebb2d8dac4so9035618b6e.0
        for <linux-pm@vger.kernel.org>; Wed, 08 Jan 2025 01:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736329765; x=1736934565; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9deTj6/vvguCX59Rp5CA9tK97aPiY1BmdFL+MDFSKko=;
        b=JaMuWFnhvRe9Dx/dKXneuV/27sMd4smP6tmfeoUV6ZCWMcajTfwvYp2ryHwrEFtF4h
         AoS70UmNEQ/fdAnnufMfxcm0SLInHurSTaSlGgJWAqxej50QBcadH5rj6QhALfDQin0t
         SFklNc0Qgmo3XoqDnn2A3lRJ7ecyVFX1P8HnPJ5b5OhG1FcH5+lGVryHUVLb1D0v3d7R
         7PFnvZoqwSHNX212tUjoNCyckLMv7rCvoodaq8Wy/+5sWN/QlozpEdVbC38iMP8wFT6h
         i3RwL7LUbYIcgBrvpgYojlU4sLyAwcbocPOY26tcqyE5IlsReXAb3kgMZg4EUNuGXa68
         MQrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736329765; x=1736934565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9deTj6/vvguCX59Rp5CA9tK97aPiY1BmdFL+MDFSKko=;
        b=a6hapv0BgfNXHH+GzWpRyq+xf7fGxmQgp3NCtr9MjU8q6QHigqVIyB9TvdgD+bZaAJ
         7SLCaXpxyrkunXi44UJr8APWf1c10AQJ7Jz7N1TFK0nWJVM6BQj0y88fXaPZzKgGDIn/
         /EuDbOFWGyiH/CyW134W7W1QXAXoUPgorJswPHnLr9SDOnBvOF9Z1TO3RNZrhlJA1PS1
         Gy21SCiQqjzdZirx5KTZxNpFgCTJogP86P26rMsil15+1gGYFZE5ZeO5f2IWan/2xbmV
         mipvHIpUBkkwENs+Ek7hj+viuKvrAv2FIc5yQQPcgGFuGIqouX3wjts6arbu+bi77nuq
         Mudg==
X-Forwarded-Encrypted: i=1; AJvYcCXEuwZVY5unoBq2e67IPJM/wHzcFbwr1l71cTwRkYGrBf8YniJB9/5XkggEQPhsp0id9MJwBAkvOA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzUca95LOlXSBaRCbq8HZgeGQy0/aEz/r7gQRAQoh+QyOUyVzEH
	eGfyRRTF/7PSy7CmyVUCAwYnRGAH7fq8UdvRT0At3s96XpzIeZC8n5/+9FxmX9ZrQ0DaV86NoKW
	54X4hof+HpcSSuAL3vZkicGPXnO7Rf/RoD0C/YQ==
X-Gm-Gg: ASbGncs84L9odReUkNG+tO2Rnjoz2qDhecDO1NIpNBm9x3zWUzXNkCtFwv0+D2+hkne
	Eb/BylMXZHMopyAWsXKYRszu53zTJKVLVFXoWj1s=
X-Google-Smtp-Source: AGHT+IHZ2qa5v003ct1VSkNjp4+W849xZ86hZNQfh08NEbSUCMyVnvNz0IJm/V2fxZ6p4xrdj0xHIGvA99BCjD8jKng=
X-Received: by 2002:a05:6808:10ce:b0:3eb:6044:5a8c with SMTP id
 5614622812f47-3ef2ec96526mr1173978b6e.20.1736329764752; Wed, 08 Jan 2025
 01:49:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250102-b4-gs101_max77759_fg-v2-0-87959abeb7ff@uclouvain.be> <20250102-b4-gs101_max77759_fg-v2-1-87959abeb7ff@uclouvain.be>
In-Reply-To: <20250102-b4-gs101_max77759_fg-v2-1-87959abeb7ff@uclouvain.be>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Wed, 8 Jan 2025 09:49:13 +0000
X-Gm-Features: AbW1kvYKpkuMkeIC0jLCwnzruoE9AbHyOFZse_X-2P5ly2F0MUO4jvDNj5kUorY
Message-ID: <CADrjBPpkiNvxGjw_iLG3tw2MNy62trao+igaMMX_zjL44+w1EQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] power: supply: add support for max77759 fuel gauge
To: t.antoine@uclouvain.be
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Dimitri Fedrau <dima.fedrau@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	=?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Thomas,

On Thu, 2 Jan 2025 at 11:16, Thomas Antoine via B4 Relay
<devnull+t.antoine.uclouvain.be@kernel.org> wrote:
>
> From: Thomas Antoine <t.antoine@uclouvain.be>
>
> The interface of the Maxim max77759 fuel gauge has a lot of common with t=
he
> Maxim max1720x. The major difference is the lack of non-volatile memory
> slave address. No slave is available at address 0xb of the i2c bus, which
> is coherent with the following driver from google: line 5836 disables
> non-volatile memory for m5 gauge.
>
> Link: https://android.googlesource.com/kernel/google-modules/bms/+/1a68c3=
6bef474573cc8629cc1d121eb6a81ab68c/max1720x_battery.c
>
> Other differences include the lack of V_BATT register to read the battery
> level and a difference in the way to identify the chip (the same register
> is used but not the same mask).
>
> Add support for the max77759 by allowing to use the non-volatile
> memory or not based on the chip. Also add the V_CELL regsister as a
> fallback to read voltage value in the case where read of V_BATT fails.
>
> The cast is necessary to avoid an overflow when the value of the register
> is above 54975 (equivalent to a voltage around 4.29 V).
>
> The regmap of the max77759 will lead the read to fail for V_BATT and to
> correctly use V_CELL instead. This regmap was proposed by Andr=C3=A9 Dras=
zik in
>
> Link: https://lore.kernel.org/all/d1bade77b5281c1de6b2ddcb4dbbd033e455a11=
6.camel@linaro.org/

Firstly thanks for working on this :) Fuel gauge is a great addition
to the Pixel 6 upstream support.

It would be good if you can document what you consider "working" with
this series applied. I think it's fine for support to come
incrementally (say feature additions to the driver to support x,y,z).
But anything that is now reported in sysfs with this series applied
should be accurate (or alternatively not exposed for MAX77759 variant
if it's not accurate and it's unclear from checking the downstream
driver how to fix it).

Thanks,

Peter

