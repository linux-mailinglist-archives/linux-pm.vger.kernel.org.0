Return-Path: <linux-pm+bounces-36584-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9723CBF7A70
	for <lists+linux-pm@lfdr.de>; Tue, 21 Oct 2025 18:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 43614354BB2
	for <lists+linux-pm@lfdr.de>; Tue, 21 Oct 2025 16:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C0E3491EB;
	Tue, 21 Oct 2025 16:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EuurpcqY"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B523491DA;
	Tue, 21 Oct 2025 16:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761064060; cv=none; b=W9RwmAGUHaIZjsRHtSPmsiq1MNVRwBJHj/xYgxDwaajvtIDdKsu5PDAb0p9S3rENP9D5fCoJ0CBJs0ZcaNlFzDPmcE9bvp33R4OnmyzSb/JWwud7GOBbFZbNSRygiUKteJ4P3gRDrRF3vpy817UTD/PibrlS6cIEEdxW0vXDCHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761064060; c=relaxed/simple;
	bh=kd69N002vmpOtiEZ/bz+Dv6wfmuq9EEiUSEIIPlzC/A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=KmbU3XIgGJ9jad9Rf2qbStn8/X1pde+F0aNhgrwrBTZshuljZJNXtRXBdhh25stO7RZ0coHfvAhsCfIzPsp9U5ahpHJBpQA1qk94C/BYUcxM49NcsukyDVKrOADobmU+SeEVH5RnnYg0ejhlRGSizz3ua9d5WD95lpXCi8ScPzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EuurpcqY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C56A6C4CEF1;
	Tue, 21 Oct 2025 16:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761064059;
	bh=kd69N002vmpOtiEZ/bz+Dv6wfmuq9EEiUSEIIPlzC/A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=EuurpcqYQ6t3c0RJHYtFpQ96qi9D2nhzD1mshw+97vGzJVzXqT3Fsjsw4kuea/pFC
	 4FL/5K7Db5TAWO8uRVOV8krL+nCPHc2xcKgEyRqWD0vgVqLGU5+napMl0uNycBMDoT
	 Zq65JHxannPosBC+9KsBi62bLqZQd7zMftRtJJZP5lF1MeJ+QVlmPKMiEG+6DAt696
	 XF7Ovh9rEzQq5ipuBedftxSHfQ+hTltnAX7YexgtqfH11aNYd4m4/5W/yghImzKHFR
	 2UjONgnl1YQIyDTnGzdzukB/6vidtTkc+cuZn9q08xseXzVfzNeGrv4kNTR/uxLpFQ
	 MeM4Ah23DvYUA==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Sebastian Reichel <sre@kernel.org>, Frank Li <Frank.li@nxp.com>, 
 Samuel Kayode <samuel.kayode@savoirfairelinux.com>
Cc: imx@lists.linux.dev, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-pm@vger.kernel.org, Abel Vesa <abelvesa@kernel.org>, 
 Abel Vesa <abelvesa@linux.com>, Robin Gong <b38343@freescale.com>, 
 Robin Gong <yibin.gong@nxp.com>, 
 Enric Balletbo i Serra <eballetbo@gmail.com>, 
 Sean Nyekjaer <sean@geanix.com>, 
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>, 
 Abel Vesa <abelvesa@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Frank Li <Frank.Li@nxp.com>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
In-Reply-To: <20251001-pf1550-v12-0-a3302aa41687@savoirfairelinux.com>
References: <20251001-pf1550-v12-0-a3302aa41687@savoirfairelinux.com>
Subject: Re: [PATCH v12 0/6] add support for pf1550 PMIC MFD-based drivers
Message-Id: <176106405453.1328165.3892656646740462467.b4-ty@kernel.org>
Date: Tue, 21 Oct 2025 17:27:34 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-52d38

On Wed, 01 Oct 2025 11:42:36 -0400, Samuel Kayode wrote:
> This series adds support for pf1550 PMIC. It provides the core driver and
> sub-drivers for the regulator, power supply and input subsystems.
> 
> Patch 1 adds the DT binding document for the PMIC. Patches 2-5 adds the
> pertinent drivers. Last patch adds a MAINTAINERS entry for the drivers.
> 
> The patches 3-5 depend on the core driver provided in patch 2.
> 
> [...]

Applied, thanks!

[1/6] dt-bindings: mfd: add pf1550
      commit: 2391e1377e39a7ca8592257d6b17126bffd58d48
[2/6] mfd: pf1550: add core driver
      commit: ebaec90ec0b5850ab80ca017e7b63183adcca131
[3/6] regulator: pf1550: add support for regulator
      commit: 7320d41c29bbd80144bb89112b8bf0c8223b94a1
[4/6] input: pf1550: add onkey support
      commit: 9acb215cbebdce721af2219e2859ad17342c9084
[5/6] power: supply: pf1550: add battery charger support
      commit: 4b6b6433a97d5863b5340fc87f866d784fdf0783
[6/6] MAINTAINERS: add an entry for pf1550 mfd driver
      commit: a7d6255a0bf302c028ac680564633a6aac5f611d

--
Lee Jones [李琼斯]


