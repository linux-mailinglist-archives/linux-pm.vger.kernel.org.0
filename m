Return-Path: <linux-pm+bounces-29209-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD792AE2D8A
	for <lists+linux-pm@lfdr.de>; Sun, 22 Jun 2025 02:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CDD917183D
	for <lists+linux-pm@lfdr.de>; Sun, 22 Jun 2025 00:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A6A139B;
	Sun, 22 Jun 2025 00:10:51 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5B8376;
	Sun, 22 Jun 2025 00:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750551051; cv=none; b=Dl7ObIAfZeMpnjZ/LN0p4bhlJQL5agTjBGE/6yv3706HVomi8RL2lYaTrkQQV/SUUacpVsgsM7ROCThlpwVlr3GnZCnurRQhJ3RtBjv5C3ktauLC32NyL+EHiOIHNIYlcnNWcNgC7UgWih/4yMHGwofa6GGltNLF17JKDBZIc1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750551051; c=relaxed/simple;
	bh=Kh8ni98oQFXIwtLUqfMfE9h+Yfj3RmR2wk1ig7fdEtM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HpoFM3aeB9S5UQXVtKdBWFOxgimMomFHM4WVK4fTIlEgUJGy2RrPHL5rWB20xcD6/U+pbEgiuUGyl3dennjCrsf6j2yGSLuEUCRzfgSwfwZ+OJre3d9u6t8nmOdL+90aq9leKpqGNYtEjYhs23Nbiq04441pReuBlvQWEvRvHbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 245A3C4CEED;
	Sun, 22 Jun 2025 00:10:51 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id E005A1806CD; Sun, 22 Jun 2025 02:10:48 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andrew Davis <afd@ti.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Jakob Hauser <jahau@rocketmail.com>, David Heidelberg <david@ixit.cz>, 
 Dmitry Osipenko <digetx@gmail.com>, Tobias Schrammm <t.schramm@manjaro.org>, 
 Linus Walleij <linus.walleij@linaro.org>, Chen-Yu Tsai <wens@csie.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250604-dt-bindings-psy-monitored-battery-v1-0-7f755ff75218@linaro.org>
References: <20250604-dt-bindings-psy-monitored-battery-v1-0-7f755ff75218@linaro.org>
Subject: Re: [PATCH 0/6] dt-bindings: power: supply: Few cleanups around
 monitored-battery
Message-Id: <175055104889.226297.3213536042267714829.b4-ty@collabora.com>
Date: Sun, 22 Jun 2025 02:10:48 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Wed, 04 Jun 2025 10:18:20 +0200, Krzysztof Kozlowski wrote:
> Reference the common power supply schema to bring the definition of
> monitored-battery property allowing to drop redundant pieces.
> 
> Best regards,
> Krzysztof
> 

Applied, thanks!

[1/6] dt-bindings: power: supply: bq2515x: Add missing power-supply ref
      commit: 0dc41c6b18b8fdd959c56f2d5b61a2d0960e3d91
[2/6] dt-bindings: power: supply: bq256xx: Add missing power-supply ref
      commit: 0835608458bc4bd1afb15d108c6d8a3b8b3d5767
[3/6] dt-bindings: power: supply: qcom,pmi8998: Add missing power-supply ref
      commit: 860cb8df5a622f2044a65f98c4158a7ff9c5b07c
[4/6] dt-bindings: power: supply: richtek,rt5033: Add missing power-supply ref
      commit: 221e08ebf6271eb80c6cb77df9ad3586229920e9
[5/6] dt-bindings: power: supply: summit,smb347: Add missing power-supply ref
      commit: 128c0704821e7101257951c1d32459e2fc3e591b
[6/6] dt-bindings: power: supply: Drop redundant monitored-battery ref
      commit: da32b6d7bcdd7a7cfd5f77418a1c026bc3374113

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


