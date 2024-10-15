Return-Path: <linux-pm+bounces-15639-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19FE799DDBB
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2024 07:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B7091C21475
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2024 05:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A761779BB;
	Tue, 15 Oct 2024 05:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pQzcS5yC"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A13A173357;
	Tue, 15 Oct 2024 05:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728971715; cv=none; b=XF5YWw1DS9+38Fl6nZaaZ271faqmYcuxWpwsCIPoJ59lf8n+Nc6i4McnYd0UYZUyKP1RQ+v1HPiUKSP3ge28JAeHUJlhVQB4fPVnGmaeOZGkveZ0nT05u59MwY5p5IFOZ1VzrOfQ/A1FUWGG/tV7F17g4Krg5L6v2K3dfQjGHWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728971715; c=relaxed/simple;
	bh=kWLHVvcvN2bSXqY2RMOj0qilVEgJsGNToj1Exm2AhDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pfUUKeJJo+TFzWODXFIxyqvpBD75o7SCzj1WBACYEtmWZo+PsbXaLASlgLHUkLBcKQrhMV/0oaKAytKIow6EYmcUG+MKcqSsplL0uyaVxeizIE0AP9RFlQrPT9iys1kjTmFRzjTsrrgBcKKOW0NMAT7AgECCPPUMyjPvDtND20Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pQzcS5yC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0225EC4CEC7;
	Tue, 15 Oct 2024 05:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728971714;
	bh=kWLHVvcvN2bSXqY2RMOj0qilVEgJsGNToj1Exm2AhDk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pQzcS5yC3K7U2OtzrX9rJTMPbuxRjLQ/xE4Arr24JdSI122irbNpZKtg9JFDS5BAR
	 uqtPQrhOmK0ymnIn1cz2zWQyybcNw6N9U4nEJmXGd/WDTQ/Z4GQmxMVoLZfaUg+v2d
	 YDrRQ1Re6eyLMjQxlPf91GZ421QJIZ4rjMtJPRMbMjSLDKuBkPvmKo9lFyK3TMkI7c
	 8jrpWZ5G6dy/ScldF/+n1sVM4+A4R4lBsl76kAYIpc1e5Pd9bhy51i1VwdwwYxZW3K
	 jjUh+LDT3yBvxcu0HPKi+Pl+8/bfG8aApthurePHwd5k9S1/C14U0ME0mvgAMCffWi
	 deWNravhRvZrw==
Date: Tue, 15 Oct 2024 07:55:10 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Haylen Chu <heylenay@4d2.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@outlook.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Jisheng Zhang <jszhang@kernel.org>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v5 1/3] dt-bindings: thermal: sophgo,cv1800-thermal: Add
 Sophgo CV1800 thermal
Message-ID: <4ey46hxumhldwrbzalyw6xzn2l52cejggxvg6e3imus3qqzsjn@r55xpxvkpodu>
References: <20241014073813.23984-1-heylenay@4d2.org>
 <20241014073813.23984-2-heylenay@4d2.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241014073813.23984-2-heylenay@4d2.org>

On Mon, Oct 14, 2024 at 07:38:11AM +0000, Haylen Chu wrote:
> Add devicetree binding documentation for thermal sensors integrated in
> Sophgo CV1800 SoCs.
> 
> Signed-off-by: Haylen Chu <heylenay@4d2.org>
> ---
>  .../thermal/sophgo,cv1800-thermal.yaml        | 57 +++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/sophgo,cv1800-thermal.yaml
> 
> diff --git a/Documentation/devicetree/bindings/thermal/sophgo,cv1800-thermal.yaml b/Documentation/devicetree/bindings/thermal/sophgo,cv1800-thermal.yaml
> new file mode 100644
> index 000000000000..14abeb7a272a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/sophgo,cv1800-thermal.yaml
> @@ -0,0 +1,57 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/thermal/sophgo,cv1800-thermal.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Sophgo CV1800 on-SoC Thermal Sensor
> +
> +maintainers:
> +  - Haylen Chu <heylenay@4d2.org>
> +
> +description: Sophgo CV1800 on-SoC thermal sensor
> +
> +$ref: thermal-sensor.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - sophgo,cv1800-thermal
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  sample-rate-hz:
> +    minimum: 1
> +    maximum: 1908
> +    default: 1

1. Why this is a property of a board?
2. I do not see this property defined in any common schema and I am not
sure if it even should. Sample rate appears from time to time, but not
in context of thermal sensors, so this should have vendor prefix.

Best regards,
Krzysztof


