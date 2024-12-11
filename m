Return-Path: <linux-pm+bounces-19031-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B129ECF21
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 15:55:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F1F1168043
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 14:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386CC19F41B;
	Wed, 11 Dec 2024 14:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="gD8uc+gj"
X-Original-To: linux-pm@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFC51A0AF7;
	Wed, 11 Dec 2024 14:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733928865; cv=none; b=uOSdyisKAylRe11ZRyMRJfMDyKu3i/3TKwzG5dxm84gy6FBdTy2RQppgkUzT6XrPlj2iHQWnEBMh/HuNNxq7jcCLWWqclfZyR68UAeRk5edFYdKGR/aqR9kncmzSTZqBr/4ph76/K0V94UlB55LTaDs1O/ZCFj8wPwOLaygOBog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733928865; c=relaxed/simple;
	bh=xe0UYBCVfKvAz9v8Pjf9aqrBdvihnJHwRRYtEIeVpKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KCqRe6IQqg34A98IaN9+0aeu9rnol1G1YEyqGR1EWTLYgADAINfWfs3Ngk2ObSvrlmnfQFXYe/ppqTEvAv7Jsu4HvjYBChg/iZvviQJcnCAOn1v+VL9zO2F6h80Jgsh5hYLhlVsqhuSa05jpsAB90Lbjb6A4AqtNlqV4sOUGBrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=gD8uc+gj; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=f0ict5pkgGeI+p368kbyJJKZCXQ+MeVCahfdmbeAq6I=; b=gD8uc+gjmkv9ScT6fm2P5axTzj
	4En7tUNJbvKNbGNe810TRcRO+MqsrMUpTXWTEhr/ASELmC5WbzjFDl4iw+x5nAP3kdDvlewgyEN6e
	DPBU8F1dCC4coKT+Y7ps3qe6ZX05LS0SHT/JMCkUyMBmPfnB8m0Gv+jdvT/H8L3sXa397Z+0BQTKF
	hggERW46N9l3ZfMEnhHejV5O8/RfeA+4QSFzSMho4+KUUkJdpyiGw6lwEl3OU926XEe1jmxCUm46N
	r0UzdPe8tItMOyCSOqiSJwnO4xT+WEQxSUYBE4DRqd5NJU0iEh71sAwpvaSxSuEvfwjDAsZH39mmD
	Sx1MkK+Q==;
Received: from i53875bc4.versanet.de ([83.135.91.196] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tLO6M-0004Px-JU; Wed, 11 Dec 2024 15:54:10 +0100
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Mark Brown <broonie@kernel.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
 Elaine Zhang <zhangqing@rock-chips.com>,
 =?ISO-8859-1?Q?Adri=E1n_Mart=EDnez?= Larumbe <adrian.larumbe@collabora.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org,
 Sebastian Reichel <sebastian.reichel@collabora.com>, kernel@collabora.com
Subject: Re: [PATCH v5 6/7] pmdomain: rockchip: add regulator support
Date: Wed, 11 Dec 2024 15:54:09 +0100
Message-ID: <3638293.eFTFzoEnKi@diego>
In-Reply-To: <20241211143044.9550-7-sebastian.reichel@collabora.com>
References:
 <20241211143044.9550-1-sebastian.reichel@collabora.com>
 <20241211143044.9550-7-sebastian.reichel@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Mittwoch, 11. Dezember 2024, 15:26:51 CET schrieb Sebastian Reichel:
> Some power domains require extra voltages to be applied. For example
> trying to enable the GPU power domain on RK3588 fails when the SoC
> does not have VDD GPU enabled. The same is expected to happen for
> the NPU, which also has a dedicated supply line.
> 
> We get the regulator using devm_of_regulator_get(), so a missing
> dependency in the devicetree is handled gracefully by printing a warning
> and creating a dummy regulator. This is necessary, since existing DTs do
> not have the regulator described. They might still work if the regulator
> is marked as always-on. It is also working if the regulator is enabled
> at boot time and the GPU driver is probed before the kernel disables
> unused regulators.
> 
> The regulator itself is not acquired at driver probe time, since that
> creates an unsolvable circular dependency. The power domain driver must
> be probed early, since SoC peripherals need it. Regulators on the other
> hand depend on SoC peripherals like SPI, I2C or GPIO. MediaTek does not
> run into this, since they have two power domain drivers.
> 
> Tested-by: Heiko Stuebner <heiko@sntech.de>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>




