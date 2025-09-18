Return-Path: <linux-pm+bounces-34934-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69976B82606
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 02:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3212117496E
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 00:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5059176ADE;
	Thu, 18 Sep 2025 00:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="phoUyoSI"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DD372634;
	Thu, 18 Sep 2025 00:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758155504; cv=none; b=AhBshCE2bKsOblLAbabIQTobX1GiwcwapqQVJgKXjlhEg0fatBaaB4DqtAkfJDTbN9RRQUsBaWhgriMjXeugs+yKwOCiCFxG1e64Fstc/EHCne+QzsrDKAh5/4SsEC24utpsqV6G2KzvE0uWtEJtZxfP5r0qUTF0WfKYqmbBzlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758155504; c=relaxed/simple;
	bh=iIdI2nVYChT/3mg+w2hb4SPCTU6Zg+BJCAlX2qIxdvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OQqfBPWiCOUg7777XA4KbcTJxhrqBzovQuXX1IWf4roIBlCr1aPTnL8B967FLLbZ9qiPZ79f3ZVN+uVfaVeFwbfeYXAd4GahAQRNj0isb6ConeIv5mhuzKcUtPRSPvZF/0JK/C3ByeLLq9oesXXpg2GJS/QSsY4FY7JAy8Wmv5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=phoUyoSI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E15C7C4CEE7;
	Thu, 18 Sep 2025 00:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758155504;
	bh=iIdI2nVYChT/3mg+w2hb4SPCTU6Zg+BJCAlX2qIxdvI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=phoUyoSIsHrZEp6LjQPs6tpELvmBp1F/OF8DNkAF6mX+9iz49xnhMFKH5GIIJByin
	 DfDEQ9zCNVpDYz1bW7XCUm2Ew9AOpex6Qf4xkJOApkRA44A0RHRc8QQkrJOB4rY5Q9
	 2jI1XAaM7aMZs974De+dE42iEnmQTXzH+B+qheaE5/U55esheQbE0WFdm6mUv0VMw5
	 L7L4CqmJFo3QUojPzCXh6BUfGWwZZzyLRU7PIKA1+8CntOCQEOTwXHQobP9RHHiy/n
	 RYS4psHc6q+7Vkb/Zwhsk96jKWhpHVOJi0Z0yHg2DG17I3xLX46KIa3byYRA4M7z3D
	 tDIAdFUVDiROg==
Date: Thu, 18 Sep 2025 09:31:42 +0900
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Boris Brezillon <boris.brezillon@collabora.com>, Steven Price <steven.price@arm.com>, 
	Liviu Dudau <liviu.dudau@arm.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, 
	Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, 
	Jassi Brar <jassisinghbrar@gmail.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Chia-I Wu <olvaffe@gmail.com>, Chen-Yu Tsai <wenst@chromium.org>, 
	kernel@collabora.com, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 02/10] dt-bindings: devfreq: add mt8196-gpufreq binding
Message-ID: <20250918-silent-dragon-of-gaiety-fdbfe3@kuoka>
References: <20250917-mt8196-gpufreq-v3-0-c4ede4b4399e@collabora.com>
 <20250917-mt8196-gpufreq-v3-2-c4ede4b4399e@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250917-mt8196-gpufreq-v3-2-c4ede4b4399e@collabora.com>

On Wed, Sep 17, 2025 at 02:22:33PM +0200, Nicolas Frattaroli wrote:
 +
> +  shmem:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: phandle to the shared memory region of the GPUEB MCU
> +
> +  "#performance-domain-cells":
> +    const: 0
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - clocks
> +  - clock-names
> +  - mboxes
> +  - mbox-names
> +  - shmem
> +  - "#performance-domain-cells"

Keep same order as in "properties:" block.

> +
> +additionalProperties: false

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


