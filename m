Return-Path: <linux-pm+bounces-26394-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC808AA3AED
	for <lists+linux-pm@lfdr.de>; Wed, 30 Apr 2025 00:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEC1A5A3F0E
	for <lists+linux-pm@lfdr.de>; Tue, 29 Apr 2025 22:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AEE126B96B;
	Tue, 29 Apr 2025 22:04:18 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175622550AF;
	Tue, 29 Apr 2025 22:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745964258; cv=none; b=Vbx/E8MiILNIkeSDvl9AL31StQ/L79O7+12vHbFY8IfcovzVKK6Gu+I2gwb/+LqHmRKUDa1Bku0Pg9OzTfpqAsd0y228cjg3v9UQDivVNL0Bqv1CLMVqqvUBTDI3lRp8Om/KmVWuQbMnpB9nxJLP6TZQhCibnFBSrOqlo/+GVus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745964258; c=relaxed/simple;
	bh=moRUNVg79LIV9Cl77W8NSRlUOpDNv8Bx3i7b3aIOOhg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=SA/lScAkL+eNSxQhnP0G9jWVg4mok/KT/qNWhxuvc9Y4TwXFV1HbigyxudgMw1XRgMe948mPfc+Jpgs1+sdMr67EQ8K3z033iBR+f0leXaCNVxXVI5Zn1aqwUstiTM+0hXd1/1B3mUGsskNZKp9om3CY/CqV0tygnOpM/a+pjt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 664A9C4CEEA;
	Tue, 29 Apr 2025 22:04:17 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id A8364180F42; Wed, 30 Apr 2025 00:04:15 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>, 
 Aradhya Bhatia <a-bhatia1@ti.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
In-Reply-To: <20250429061803.9581-1-clamor95@gmail.com>
References: <20250429061803.9581-1-clamor95@gmail.com>
Subject: Re: (subset) [PATCH v3 0/4] power: supply: add support for
 Pegatron Chagall battery
Message-Id: <174596425567.12920.12934691933385405549.b4-ty@collabora.com>
Date: Wed, 30 Apr 2025 00:04:15 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Tue, 29 Apr 2025 09:17:58 +0300, Svyatoslav Ryhel wrote:
> The Pegatron Chagall is an Android tablet utilizing a customized Cypress
> CG7153AM microcontroller (MCU) as its battery fuel gauge. It supports a
> single-cell battery and features a dual-color charging LED.
> 

Applied, thanks!

[1/4] dt-bindings: vendor-prefixes: add prefix for Pegatron Corporation
      commit: b5cd5c42a9182cf6602b2a68201d39bd60a2a65e
[2/4] dt-bindings: power: supply: Document Pegatron Chagall fuel gauge
      commit: 615a8d9d897de77268ee81a78a5bf65fad53bcc8
[3/4] power: supply: Add driver for Pegatron Chagall battery
      commit: fbc1d056d3f3d417bc9df521cb45a0f51758b64a

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


