Return-Path: <linux-pm+bounces-25199-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BAF0A8512A
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 03:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B900465D9D
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 01:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F7F26F461;
	Fri, 11 Apr 2025 01:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JTlPmKyP"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C11BD299;
	Fri, 11 Apr 2025 01:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744334474; cv=none; b=BxdZb2U+xCH9np0DN8yE0fsnflP/CwzMz6VsNK7GY/7f2e4fFQYHvDQdY0cexX1QxbQoKp0mOuyrouVRGS9VlWwA0wST4aSjEEhwDF+CmBhj2wpIA5Uq+pLfRfLyamk5pdeRsLbus1Azvb+T1lkz7pO6kcU+rIyhLUdI7jN6URc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744334474; c=relaxed/simple;
	bh=o046V02WtqlkkRSSA2YGh7WNKcRkrZEbNpFokx1S5W0=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=Uzgi81XEngTwSN+s9eRTJshvm8qoNloxWBXq9wGEfc1pxfKS470AHOQUnYc+aOqFAZ0UiW2s6fEa6bL24hyM7iYaDrCqi4x3u+TImTR1oaHss7SX3HBJK0pqW5DGyhq4z0/ES1MQ4rjay8BaPvtWl7Ca+NYLQovqm2vzr8ZVEKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JTlPmKyP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D109C4CEDD;
	Fri, 11 Apr 2025 01:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744334473;
	bh=o046V02WtqlkkRSSA2YGh7WNKcRkrZEbNpFokx1S5W0=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=JTlPmKyPES5VA7ZmxJLYX1Msxt/oigWQD0OYiLRLmvQ4k5N4T8xhUdZ5xzhOfWfuU
	 2QirmG6s7SD3uYGjXNTWWb45j1z9JkqnBu7gopdKbjSvx9rbMggpw5ony3HE8patxh
	 UqDtEJx0igTWcE0PJwIO1gX2qY9tq4pWjs2IxBRyBg+4a42zX1PngeGYx+LOBBsXHw
	 J1NZwi8Z8/HI45/GGHSFJWQcYdavbZJDJl5zz3gu3UIqCLLyTtC59/DeNxPHEJ1+So
	 4yKPPFKWwyvqnuCfRaxSFcTsAecRigu1p04AelE1h1NBItayGmFO3F3QY0YCYUFDxr
	 stsTG6NEuqFRg==
Date: Thu, 10 Apr 2025 20:21:12 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>, 
 linux-arm-kernel@lists.infradead.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, devicetree@vger.kernel.org, 
 Andre Przywara <andre.przywara@arm.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Yangtao Li <tiny.windzz@gmail.com>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, linux-kernel@vger.kernel.org, 
 linux-sunxi@lists.linux.dev, Conor Dooley <conor+dt@kernel.org>, 
 Vasily Khoruzhick <anarsoul@gmail.com>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, 
 Piotr Oniszczuk <piotr.oniszczuk@gmail.com>, 
 "Rafael J . Wysocki" <rafael@kernel.org>
To: iuncuim <iuncuim@gmail.com>
In-Reply-To: <20250411003827.782544-7-iuncuim@gmail.com>
References: <20250411003827.782544-1-iuncuim@gmail.com>
 <20250411003827.782544-7-iuncuim@gmail.com>
Message-Id: <174433447237.1635065.9681378963946489764.robh@kernel.org>
Subject: Re: [PATCH 6/6] dt-bindings: thermal: sun8i: Add A523 THS0/1
 controllers


On Fri, 11 Apr 2025 08:38:26 +0800, iuncuim wrote:
> From: Mikhail Kalashnikov <iuncuim@gmail.com>
> 
> Add dt-bindings description of the thermal sensors in the A523 processor.
> 
> Signed-off-by: Mikhail Kalashnikov <iuncuim@gmail.com>
> ---
>  .../bindings/thermal/allwinner,sun8i-a83t-ths.yaml           | 5 +++++
>  1 file changed, 5 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.example.dtb: thermal-sensor@1c25000 (allwinner,sun8i-h3-ths): clock-names:1: 'gpadc' was expected
	from schema $id: http://devicetree.org/schemas/thermal/allwinner,sun8i-a83t-ths.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250411003827.782544-7-iuncuim@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


