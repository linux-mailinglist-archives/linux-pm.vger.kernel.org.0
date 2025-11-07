Return-Path: <linux-pm+bounces-37599-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB55C3ECDD
	for <lists+linux-pm@lfdr.de>; Fri, 07 Nov 2025 08:45:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C062C188D8BF
	for <lists+linux-pm@lfdr.de>; Fri,  7 Nov 2025 07:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2786E30E85E;
	Fri,  7 Nov 2025 07:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GKgY5pb7"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA26F1E1A17;
	Fri,  7 Nov 2025 07:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762501530; cv=none; b=aVxoWShzREiQEdrecR7C6tfk/sTrdgXyqJT8ZgAihsr1mwkeFjHEiWwAlGQzT+iVLI0BaHwEzuPegzkxmfAjj2BhZqTGkUvl77ZGKvH/AkMHKwG1zYEY7rXVVcVhMTrNlzEwp5Mt8GwQC9KQsWCDeQsPpyTmYHOVggwKxLPoPnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762501530; c=relaxed/simple;
	bh=wPfFig2exRn52OaPdt2nkS1xzEnycb/w/6c7LGHcgrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HngT2j+6u0niFlHFZHAPPS2LvDvpRETIbmnJ8acohAHzwjNJzgP3L1dzK0/PkgPTRyIR44/AxJpHMar7K+F3vgdqlK5m0GjktLV8iFRO8SZ8wpte75MmRMZtExA6aZ+hOHj9YXDcjM5ktu452prKxSVUTJkF/g/a9uwlRl2nz5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GKgY5pb7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EADEAC4CEF5;
	Fri,  7 Nov 2025 07:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762501529;
	bh=wPfFig2exRn52OaPdt2nkS1xzEnycb/w/6c7LGHcgrQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GKgY5pb7NalGw49yQLy4PnVS8P+v9jvIpsZgBx50jpJq1CX5ZFsP6pHiLd0JSBU46
	 4Xrj1j8Vol3atumOXUeKy13uLtgQPE5pkZ6b1O4NG3bF7NlQ8tqpxPbF4Uqh2Fupk4
	 J8/CtX5EjSf+3IpunJEgbxsKMlCzDIMagVUTcllp1yqtcFUHtxM8FF+2BMt/csuZxo
	 rLO0PiV6dYvBHFYr6JFs+lXVHvw/CLTrgbmf4TZZmanlsnioG2QVHrQj4/b18swxq5
	 bYA8ulZbypIba0MMC3Q/JzZzw4HQWCAbxNpXj7rlFRQd2Vsdg93h3UN8g8mPApb01U
	 RTmGKath00UDQ==
Date: Fri, 7 Nov 2025 08:45:27 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 4/5] dt-bindings: arm: airoha: Add the chip-scu node
 for AN7583 SoC
Message-ID: <20251107-splendid-alpaca-of-influence-97216f@kuoka>
References: <20251106225929.1778398-1-ansuelsmth@gmail.com>
 <20251106225929.1778398-5-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251106225929.1778398-5-ansuelsmth@gmail.com>

On Thu, Nov 06, 2025 at 11:59:13PM +0100, Christian Marangi wrote:
> Document support for Airoha AN7583 chip-scu node.
> 
> This is similar to Airoha EN7581 with the addition of the presence of
> thermal sensor in addition to controlling HW PIN and other miscellaneous
> pheriperals.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  .../bindings/arm/airoha,en7581-chip-scu.yaml       | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/airoha,en7581-chip-scu.yaml b/Documentation/devicetree/bindings/arm/airoha,en7581-chip-scu.yaml
> index 67c449d804c2..0d042fb90a78 100644
> --- a/Documentation/devicetree/bindings/arm/airoha,en7581-chip-scu.yaml
> +++ b/Documentation/devicetree/bindings/arm/airoha,en7581-chip-scu.yaml
> @@ -18,16 +18,30 @@ properties:
>    compatible:
>      items:
>        - enum:
> +          - airoha,an7583-chip-scu

Again, random order.

>            - airoha,en7581-chip-scu
>        - const: syscon

Best regards,
Krzysztof


