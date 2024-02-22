Return-Path: <linux-pm+bounces-4299-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C57B486026C
	for <lists+linux-pm@lfdr.de>; Thu, 22 Feb 2024 20:15:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 655D21F21691
	for <lists+linux-pm@lfdr.de>; Thu, 22 Feb 2024 19:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808BA14B837;
	Thu, 22 Feb 2024 19:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e15zy45m"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9EC14B834;
	Thu, 22 Feb 2024 19:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708629330; cv=none; b=o/JlDeFRaYXHFeDz1OKByLbaUtGCsrBbHf22rgYtYfPiWwGSNyXs375kqxfpv80R+F1LAu8jsgbaQ7iML2tZWqi+XFwJk4IAlt8KnrS30iF6vjlVXXR53oI5BfTeBTn8mHbYhgk4ytKWsnXSG7mlQJaO76mhlIF30pEOc1Sr7jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708629330; c=relaxed/simple;
	bh=lJ2c3OXsmQPXj5fU9jUAfehd5sZPmYmHiVLEPGq+gLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pVL0XS1UfHC02/vHgbewvJ7geyz8WpAbJ2fzanII+BXPXSoqKZugXuYChfE+ow+qxVA8aiR0zFZfPL62N3p2klziE72IhsLv8eSEDP0w2CVODBH6IRro5lgMIgzEKCcG10Vjg3Qcy+Mf1Lpv56RyplVwf6CsagX2dFWU+F7oOSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e15zy45m; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-511976c126dso226187e87.1;
        Thu, 22 Feb 2024 11:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708629327; x=1709234127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lJ2c3OXsmQPXj5fU9jUAfehd5sZPmYmHiVLEPGq+gLI=;
        b=e15zy45mrLvt8tlsb98H/phHzQsvtI3mvlGG0cF/aaQXaLR/lZBceqfMBzs7/+Vgpg
         ssTon6ZnH43rCaP25QLvksRBahS7Y/uwDDhVbtqPWK2d5qqxuw8FaB8mg40v3sXzHeI5
         wIwgeggA5bJ05sX+ZFoVBxwOutpazj1mZJlUARAPfmZTTj87NRYkkZKGHB6Jr4JGgkjU
         4Q3MqVP4lQmO45xBr2WGh7xNMUa4wxIG9G3DhAbQqCwZiVXieEgfqz51wRYqpUrNaE48
         bc3OnYkjt/IEq4QyOSjYaxu3o4TrNQs++CBjSk6ANku4og43qsgFe1AXfD9Tga0jHn/9
         qGiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708629327; x=1709234127;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lJ2c3OXsmQPXj5fU9jUAfehd5sZPmYmHiVLEPGq+gLI=;
        b=ciDQMFUnsY6T1NOOSK7Tj5mJtOza38QOIgV6MN4Gl72u49tI6/JETMBcRNfk1judQ3
         U5tuBZNRoPH0eP1p16m9wMvrssqKDY3s4+iuebjc/ZIZYVW59hJUP5uTLfQ9CAtn+q0X
         lB1GhbYeH0BC0pQtj1K4b7JPBo9FBhLkELswSP5O955+mgkve3i+p0TubNhPHEXUy+6x
         UtkK4IOSO5gxNDGKmzett1Xo0Lm/+NM87YNV9fK6gSNKQ08yMxlUCKtR3oWsXY/d3MVv
         Dbf1aidPPmN9f2/yrF5s20wsen83rrr7aqMs5f1FFGP7mk4lmLoRLkqZMofsLUG09pQW
         5L8w==
X-Forwarded-Encrypted: i=1; AJvYcCXsZZqBn+3JngLGfeU4kV46BsY9ywYwiduUntjgSm/22w9U/X3RIIol/42WgZoi4mYFfFUwi8XeXSEMg7LdjTMhfZe/ce8VGah76Pwp+v1SuQckhxe76krUPD+QrBDmU5pgnd2a
X-Gm-Message-State: AOJu0Yz9i8Mh6pMRidakiV1wacFa6BRGGh+BfJ4CwrHgSMUZUNUS39PT
	3vENHgj12b+58ykBRgE2Sn227MLn8UnhXmy+XFAqyytIXDAJAYAw
X-Google-Smtp-Source: AGHT+IER/vmuD6l/fCUkPsT8W3LSUxshUclFAkO2I+bTa1CPpJ3dnNRrr76fSv42mzzs9VdOwiRzPQ==
X-Received: by 2002:a05:6512:4ce:b0:512:a52f:4690 with SMTP id w14-20020a05651204ce00b00512a52f4690mr43492lfq.68.1708629326683;
        Thu, 22 Feb 2024 11:15:26 -0800 (PST)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id q18-20020a170906145200b00a3d2d81daafsm6335565ejc.172.2024.02.22.11.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 11:15:26 -0800 (PST)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Vasily Khoruzhick <anarsoul@gmail.com>,
 Yangtao Li <tiny.windzz@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Martin Botka <martin.botka@somainline.org>,
 Maksim Kiselev <bigunclemax@gmail.com>,
 Bob McChesney <bob@electricworry.net>, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev
Subject:
 Re: [PATCH v5 1/7] soc: sunxi: sram: export register 0 for THS on H616
Date: Thu, 22 Feb 2024 20:15:24 +0100
Message-ID: <1956003.PYKUYFuaPT@jernej-laptop>
In-Reply-To: <dcd115fd-dc38-4f48-8485-9e4d64f53b4a@linaro.org>
References:
 <20240219153639.179814-1-andre.przywara@arm.com>
 <2717467.mvXUDI8C0e@jernej-laptop>
 <dcd115fd-dc38-4f48-8485-9e4d64f53b4a@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Dne =C4=8Detrtek, 22. februar 2024 ob 19:44:12 CET je Daniel Lezcano napisa=
l(a):
> On 22/02/2024 19:26, Jernej =C5=A0krabec wrote:
> > Dne ponedeljek, 19. februar 2024 ob 16:36:33 CET je Andre Przywara napi=
sal(a):
> >> The Allwinner H616 SoC contains a mysterious bit at register offset 0x0
> >> in the SRAM control block. If bit 16 is set (the reset value), the
> >> temperature readings of the THS are way off, leading to reports about
> >> 200C, at normal ambient temperatures. Clearing this bits brings the
> >> reported values down to the expected values.
> >> The BSP code clears this bit in firmware (U-Boot), and has an explicit
> >> comment about this, but offers no real explanation.
> >>
> >> Experiments in U-Boot show that register 0x0 has no effect on the SRAM=
 C
> >> visibility: all tested bit settings still allow full read and write
> >> access by the CPU to the whole of SRAM C. Only bit 24 of the register =
at
> >> offset 0x4 makes all of SRAM C inaccessible by the CPU. So modelling
> >> the THS switch functionality as an SRAM region would not reflect reali=
ty.
> >>
> >> Since we should not rely on firmware settings, allow other code (the T=
HS
> >> driver) to access this register, by exporting it through the already
> >> existing regmap. This mimics what we already do for the LDO control and
> >> the EMAC register.
> >>
> >> To avoid concurrent accesses to the same register at the same time, by
> >> the SRAM switch code and the regmap code, use the same lock to protect
> >> the access. The regmap subsystem allows to use an existing lock, so we
> >> just need to hook in there.
> >>
> >> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> >=20
> > Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> >=20
> > I guess this one goes through sunxi tree, right?
>=20
> I'll pick this patch along with the patch 2-6, so through the thermal=20
> tree. The patch 7/7 will go indeed via the sunxi tree

Ok.

Best regards,
Jernej




