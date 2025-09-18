Return-Path: <linux-pm+bounces-35002-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10765B8702F
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 23:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE230167728
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 21:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6EF92EC081;
	Thu, 18 Sep 2025 21:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="mqdAqbuM"
X-Original-To: linux-pm@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7925F2DAFA5;
	Thu, 18 Sep 2025 21:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758229779; cv=none; b=MOqxf3YLe88RKX2N5ZV2n7maHFDCZn1m5xSVNucP1da+8unmIAc8qNo2gEiCG8zlbzL1BB9Ytv4SLimb1LZHwxFAmf9QcD4nUAzzA26BLN4u9nvE0dU17I65KWQeHrGoTIwLRodTyD9O/wCOgqTtNKBy/KMOkjb5Dr8EOdznEI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758229779; c=relaxed/simple;
	bh=6ksAn3H91O94k8DweiUh/m3t93Gdss8WZmDpjPojFDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QCYMv+Vv0c+OeT0vKExre+igyJpp52/IjmU9qZBYSEW/Kbffn5IOd1P5wRVn+AQlxxUhOuBEAEn3NACnsbcOTV/CHaWqdC2D6d8wxC+LtQGbKjbeekglDWALWQ20qPxPZnbgtI80+OKWTeTdg3d/qxNN5XK8hhYhbtEiG/2xx0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=mqdAqbuM; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=IhRFq4UtJ1FWApnkqY6mEgaYN11X3Y0mXj4sL73koYk=; b=mqdAqbuMhaX05+AVwIxaxZi0TB
	htLdqDt30MiAqnjBZnHKqLauhIC1vFJ+3unudCP6cWxJr9zFi2uNnUxSjVHjRiReiT3/TK7EHOdZb
	f0z5+XPJNg2kx3+N0nPkjjpB5UyoQYVk57Vsznj70YGQ8zUghwV9+k4KhQKblO/RtbXoEKg82aDRD
	LhmYH4cqRM7qXCOwP6ce+fFgjd/Czsns7wf5zWvyw2eLT+PvRwVjbtb3Hb4goFS+ia5d+0WNrJgjC
	saPGLtXUnj7S098virm7a0VhHbtt5BYjO+E4uEbZZr4EI3hHfE8zY8rQhQn93hP+/9h38SEy5elCX
	mUaTg40g==;
Received: from i53875b0a.versanet.de ([83.135.91.10] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uzLsk-0003SC-3D; Thu, 18 Sep 2025 23:09:34 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	Mikko Rapeli <mikko.rapeli@linaro.org>
Cc: Heiko Stuebner <heiko@sntech.de>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: (subset) [PATCH v4 0/4] enable ROCKCHIP_PM_DOMAINS
Date: Thu, 18 Sep 2025 23:09:22 +0200
Message-ID: <175822973681.1568500.10556154418854538683.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250915083317.2885761-1-mikko.rapeli@linaro.org>
References: <20250915083317.2885761-1-mikko.rapeli@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 15 Sep 2025 11:33:13 +0300, Mikko Rapeli wrote:
> MMC_DW_ROCKCHIP needs ROCKCHIP_PM_DOMAINS before MMC is detected
> on Rockchip rk3399 rockpi4b and similar devices. Make this dependency
> more visible, or the default with ARCH_ROCKCHIP if possible.
> 
> v4: fixed Kconfig whitespace, added select REGMAP_MMIO to MMC_LOONGSON2
>     instead of disabling COMPILE_TEST
> 
> [...]

Applied, thanks!

[4/4] ARM: rockchip: remove REGULATOR conditional to PM
      commit: a1b20e062245571c128ec521c4df56ad1bff9bd0

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

