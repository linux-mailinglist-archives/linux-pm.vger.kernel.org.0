Return-Path: <linux-pm+bounces-34488-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52DB7B536A8
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 16:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99010586B67
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 14:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A973346A0A;
	Thu, 11 Sep 2025 14:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GGczcTiK"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0267E352064;
	Thu, 11 Sep 2025 14:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757602598; cv=none; b=XhwKlQtVTsHNMv474xOyeiRscN2NJEZNn0Gt+IyufO3FeeGetjvIiyOEd5GCGSB4/PlJPwSqbWoiTwowyKarZ6GQ8Z99zp1fE/7/SRN5z8/5CxJ2M+8eKuVOF3vbZw3QpU0q5mi2neGMF+pP0Xyb0fSAhZ/Lfq3jzK6zk1icjl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757602598; c=relaxed/simple;
	bh=mzzYH3yyMeHKI7BTWHx+Zt/6c7yLTYHq11U1qlLZrzY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Ap+Svg/ALGpIYxyQ6AHO6pXwCegJVT+c7XAJ1scXZhlwmMIkOISIKDHMjfoaKLuHC6RPcJkwnJ3k356dusQxw2hjR6sR+5cDqzd81lsusjyJZ0/UgbGe4KGMai4P8u0ogAroXdALVcnbTUihTbIV6lDesUqReuJ91/JElUBn1FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GGczcTiK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AE66C4CEF8;
	Thu, 11 Sep 2025 14:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757602597;
	bh=mzzYH3yyMeHKI7BTWHx+Zt/6c7yLTYHq11U1qlLZrzY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=GGczcTiK8TQzQF6ZTFFMC5Nygd3JkE//1AKbAPTO2ME5uukIPQOEqvj/SZebXId0w
	 CZrQSk/57u/RfgP79D3Ad70oDPU1311L1ybn02moBmb3QwrazCoAftivGk/O935IS+
	 ceYTftR8mfD1IJSpq/znJu0zV1SdP5e2otAYjGTwgsFkdzclTvwjHTIHhv5HzFc/LE
	 d0PKlfVylmkwA0rEwnfRt1e7zWuSuiVSpzy4ICL2t7lccgNvf6Pu+F9Pm/GseRgEfa
	 gLXGKT6RxqIiWq1US42rHQ/sRGCGZyfYbY27jcdx9lFVjc0X04MfSulAkCoLbDGzJ0
	 x6NCQlwjfbnrw==
From: Lee Jones <lee@kernel.org>
To: linux-rockchip@lists.infradead.org, 
 Chris Morgan <macroalpha82@gmail.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 broonie@kernel.org, lee@kernel.org, lgirdwood@gmail.com, sre@kernel.org, 
 heiko@sntech.de, conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org, 
 Chris Morgan <macromorgan@hotmail.com>
In-Reply-To: <20250904160530.66178-1-macroalpha82@gmail.com>
References: <20250904160530.66178-1-macroalpha82@gmail.com>
Subject: Re: (subset) [PATCH v8 0/5] Add Texas Instruments BQ25703A Charger
Message-Id: <175760259503.1582479.14013409824773713781.b4-ty@kernel.org>
Date: Thu, 11 Sep 2025 15:56:35 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-c81fc

On Thu, 04 Sep 2025 11:05:25 -0500, Chris Morgan wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Add support for the Texas Instruments BQ25703A charger manager. The
> device integrates a boost converter with the charger manager. This
> series adds the device as an MFD with separate regulator and power
> supply drivers. This allows us to manage a circular dependency with
> a type-c port manager which depends on the regulator for usb-otg
> but supplies power to the BQ25703A charger.
> 
> [...]

Applied, thanks!

[1/5] dt-bindings: mfd: ti,bq25703a: Add TI BQ25703A Charger
      commit: 76bc2203a46ef704a4cd8003986f6bd74139a367
[2/5] mfd: bq257xx: Add support for BQ25703A core driver
      commit: 3b1bbfb5fce3ca9fffc92ac1b053b0cfbb1f322b
[3/5] power: supply: bq257xx: Add support for BQ257XX charger
      commit: 1cc017b7f9c7b7cd86fdda4aee36b92d91cc2ad2
[4/5] regulator: bq257xx: Add bq257xx boost regulator driver
      commit: 981dd162b63578aee34b5c68795e246734b76d70

--
Lee Jones [李琼斯]


