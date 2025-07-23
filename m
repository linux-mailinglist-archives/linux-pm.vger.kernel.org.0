Return-Path: <linux-pm+bounces-31307-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A6CB0E9EE
	for <lists+linux-pm@lfdr.de>; Wed, 23 Jul 2025 07:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52DE217EA28
	for <lists+linux-pm@lfdr.de>; Wed, 23 Jul 2025 05:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0646F21ABAD;
	Wed, 23 Jul 2025 05:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T1eJpYtP"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB73020B207;
	Wed, 23 Jul 2025 05:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753247026; cv=none; b=j6Ppq8ytiujqPFmqSq5ZgcntO6bkxioDWPqinWyARHyN3y1xJ5PGQ0gEtYo69YoODVPn9ixvNrPFM25KQnIvZ72Q/8H+kZa0z/wFX4w+O5WZZC/l7wUltteKfLOTxShS/21a+RyqQSANezsdLe8B4UF1WwnmU1JJYjOYKFuxBzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753247026; c=relaxed/simple;
	bh=HNdcDInfR5691ALsx7YFA6KQ881CsZllB61Hu6dp+sc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XgQrw+vN4XofuD9JnG0oTZ5xGArGHW9irhVT1yhWlUwus80rIEqv1pOrO/PJLgyhDvJlYvgGYhZZaBLXImitKGJztMsQv6Ek6uMekPskP4kx5vxZnJhGbyg0UTWWm1JPhQCaDQGT2t3E85wyPHtD6MELRR09q1k9FNh5B9Gp6r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T1eJpYtP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3714AC4CEE7;
	Wed, 23 Jul 2025 05:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753247026;
	bh=HNdcDInfR5691ALsx7YFA6KQ881CsZllB61Hu6dp+sc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T1eJpYtP362i6QpQB+Gyr3nVNU4ib/ncXo5a8bynYbCbVde1E4PIfSG1viBeQFXri
	 rZLxYRWbemEoP9mMxnTuF8rtwfg06RtoWNz8PEsbqTHnts0Wd/mVt6y819T/xD6RuL
	 mOFHzLVYKVP+pxhxcOYL4QotHxlwjOfbPo/CG7bHZ3R9w/FM9zzx8hvkrN+lR0uFOy
	 8nlygR5DDHvtsEJREgk2Y0HvV+R97GxJwshMLUEnM+VMnSchUU/mvhERqjU8tbRDM3
	 Tsen+b8Ztg/WXn7szBtQsSckYKxW5tObFakUNVKOcgxh8F21AF5wjxGYwH4C9rZreM
	 w64dgibb0Ew6w==
Date: Wed, 23 Jul 2025 00:03:45 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Xianwei Zhao <xianwei.zhao@amlogic.com>
Cc: Liming Xue <liming.xue@amlogic.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Guillaume La Roque <glaroque@baylibre.com>,
	linux-arm-kernel@lists.infradead.org,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: thermal: amlogic: Add compatible
 string for C3
Message-ID: <175324702489.1243031.2642099886679126022.robh@kernel.org>
References: <20250722-c3-thermal-v2-0-b2231b4be79e@amlogic.com>
 <20250722-c3-thermal-v2-1-b2231b4be79e@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722-c3-thermal-v2-1-b2231b4be79e@amlogic.com>


On Tue, 22 Jul 2025 19:26:27 +0800, Xianwei Zhao wrote:
> Add the compatible properties for Amlogic C3 SoC family.
> C3 family supports only one thermal node - CPU thermal
> sensor.
> 
> Signed-off-by: Liming Xue <liming.xue@amlogic.com>
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> ---
>  Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


