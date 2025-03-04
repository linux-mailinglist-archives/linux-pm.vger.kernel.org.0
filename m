Return-Path: <linux-pm+bounces-23364-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3461A4DFF8
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 14:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C0D01887E22
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 13:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2BB520487D;
	Tue,  4 Mar 2025 13:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gchrz530"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2B32046AF;
	Tue,  4 Mar 2025 13:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741096688; cv=none; b=ZZ0dybZ5CdLU/mTUdp9CPMMXchGZ4+uEZqlilStxt6hvow1k7dTH1F3kOHGgdZZ1EOuheMOF+6A46D131B/re5FjysVVT0b4avk78Ft7foEMRZ1gqEOKR85cThJqtZODW46c+K2UbiSPRp+1gj/ZgcM278+HZtlO2MDj2fwbzTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741096688; c=relaxed/simple;
	bh=MolSD5V79FK3aBpINXq3pcPNddfCoUo4vtI0wmCeKkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j+q3IA9Om43Xpz9ZQelYPGVwoFMHJKZywHr4C9TL1e56ziErdvjAcMn27LF/yvZYksuJijq3xY6dH+0bOjI45LXBGdfztwLyKZKrlQAATtXBIJrFfdmdDbZ8B1j/JLyDIr4Io5n6dUCgvGxp3ee3Y5j6ZRk3Z5Lm6a+Ls85hcBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gchrz530; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2AC0C4CEE5;
	Tue,  4 Mar 2025 13:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741096688;
	bh=MolSD5V79FK3aBpINXq3pcPNddfCoUo4vtI0wmCeKkM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gchrz530byFA6jaAP2iv1YVE8ocMEpaef4fwpOxm53Au+jqLRSwS4uRAesn6Pz2or
	 C57Uy4bK/6HUFltUq9kGnCBoeum0BSOFDzFhkrVncTrlA5cN2R3N49SpgZ2YxrBLAw
	 0rqBpbhi6zSX1WkKjeoZ308+GSr7dW5byMix3yFmi9ckRobmmJxgMG3MwMuyILj6pC
	 8wpz7dpBNL3mCnN7ZAxFp2iK8xxlZrXmwLQyVTkPaD/vCZdWvUZHsUHQ7v5Y5x3rMZ
	 Pnp2BvX2PHpxL+OseXzi7iGUAO2y40Z/zQ98mtw+jwhuHkAOGQ56O4R9j6CzNys8oY
	 +jrBYDviMDCiA==
Date: Tue, 4 Mar 2025 07:58:06 -0600
From: Rob Herring <robh@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: power: supply: Document Maxim
 MAX8971 charger
Message-ID: <20250304135806.GA2503334-robh@kernel.org>
References: <20250303115502.89457-1-clamor95@gmail.com>
 <20250303115502.89457-2-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303115502.89457-2-clamor95@gmail.com>

On Mon, Mar 03, 2025 at 01:55:01PM +0200, Svyatoslav Ryhel wrote:
> Add bindings for Maxim MAX8971 charger.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  .../bindings/power/supply/maxim,max8971.yaml  | 68 +++++++++++++++++++
>  1 file changed, 68 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/maxim,max8971.yaml
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/maxim,max8971.yaml b/Documentation/devicetree/bindings/power/supply/maxim,max8971.yaml
> new file mode 100644
> index 000000000000..2244cc3d45a6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/maxim,max8971.yaml
> @@ -0,0 +1,68 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/supply/maxim,max8971.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Maxim MAX8971 IC charger
> +
> +maintainers:
> +  - Svyatoslav Ryhel <clamor95@gmail.com>
> +
> +description:
> +  The MAX8971 is a compact, high-frequency, high-efficiency switch-mode charger
> +  for a one-cell lithium-ion (Li+) battery.
> +
> +allOf:
> +  - $ref: power-supply.yaml#
> +
> +properties:
> +  compatible:
> +    const: maxim,max8971
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  monitored-battery: true
> +
> +  port:
> +    description:
> +      An optional port node to link the extcon device to detect type of plug.
> +    $ref: /schemas/graph.yaml#/properties/port

extcon as a binding is pretty much deprecated in favor of connector 
bindings.

The OF graph is an overkill here too. You should just need a phandle to 
the connector node.

Rob

