Return-Path: <linux-pm+bounces-42416-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oETCNff4imlSPAAAu9opvQ
	(envelope-from <linux-pm+bounces-42416-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 10:23:03 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BDA0118D22
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 10:23:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BFE5C300E492
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 09:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3CE3340A49;
	Tue, 10 Feb 2026 09:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rk62YpQA"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BBD2D879B;
	Tue, 10 Feb 2026 09:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770715358; cv=none; b=e0/6/anca20qlMBSewDrL9LsmCDPuyLhv0kR1pRmmofsWHCrRD8lWaucS5jbouHIBlwkzXBT6n1iXFJ804zqKwBlY1iRlP4iBxAyTaH7/CLnNEBrLH0Tjb471vo+XCnrVzutYTMJi2UhLJf/z8NttF1EFzXt/sY9ZaUM31lgmVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770715358; c=relaxed/simple;
	bh=BxqDTJiOkmjhY+WCB/0ujA9faPlLX0QG7mPPvcRDw+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iAE9p94oywX6j4ldR4uIcasFfn4xwp0JM6rOpxyKdOnSsWcenjbCGgTamKXdoS+oHu3JXjv/MxjV6qsGya2uDAkKEu/Bq7SpO6K3+3Q7aNlquUDsASeuRhsJ/6793Ye/wUPdgsTu0Mxd4RB/HTahKovpnneIVnXRrQXJvSh2QUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rk62YpQA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82281C116C6;
	Tue, 10 Feb 2026 09:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770715358;
	bh=BxqDTJiOkmjhY+WCB/0ujA9faPlLX0QG7mPPvcRDw+Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rk62YpQA5m1Z51hE8sDF3x8+QM6vhvZq/bC1d5d12AxNuZPGc1gxIOfUTB5YC2Qni
	 gX6LOWlLvso2vIjlTBTRhEW0JNQWkLvo81Cnef5UdsnspCZvxcVMtwRA3fkJnupIv1
	 AJdzi9I48yoKFv24K4ywsX1hXZuEyt2LTiVnigPKTAoiq1PvdlNqdT2h6SEDdDWldI
	 YUNsNeMIZPwbLZCMXvJ5fTgdllq56aYVJrW7UfX1hJZhhwHzzy7qVfn2mm5V6sVweX
	 FGV8n/38LgLB2sdRo34wsaL3bepc7PG+FEf8lM/gtaWL4eja5Z4AegI9kFWT0+uGTk
	 T6EcRqdiiVagA==
Date: Tue, 10 Feb 2026 10:22:35 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, 
	=?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, Ion Agorria <ion@agorria.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 3/9] dt-bindings: mfd: document ASUS Transformer EC
Message-ID: <20260210-sexy-grumpy-sambar-44edd2@quoll>
References: <20260209104407.116426-1-clamor95@gmail.com>
 <20260209104407.116426-4-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260209104407.116426-4-clamor95@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42416-lists,linux-pm=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,linux-pm@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,arndb.de,linuxfoundation.org,rere.qmqm.pl,agorria.com,vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[devicetree.org:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2BDA0118D22
X-Rspamd-Action: no action

On Mon, Feb 09, 2026 at 12:44:01PM +0200, Svyatoslav Ryhel wrote:
> Document embedded controller used in ASUS Transformer device series.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  .../devicetree/bindings/mfd/asus,ec.yaml      | 152 ++++++++++++++++++
>  1 file changed, 152 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/asus,ec.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/asus,ec.yaml b/Documentation/devicetree/bindings/mfd/asus,ec.yaml
> new file mode 100644
> index 000000000000..1d1a62761b71
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/asus,ec.yaml

EC do not go to MFD, but to dedicated directory (there is such).

> @@ -0,0 +1,152 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/asus,ec.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ASUS Transformer's Embedded Controller
> +
> +description:
> +  Several Nuvoton based Embedded Controller attached to an I2C bus,
> +  running a custom ASUS firmware, specific to the Asus Transformer
> +  device series.
> +
> +maintainers:
> +  - Svyatoslav Ryhel <clamor95@gmail.com>
> +
> +properties:
> +  compatible:
> +    oneOf:

Drop oneOf

> +      - enum:
> +          - asus,ec-pad  # Pad part of Asus Transformer
> +          - asus,ec-dock # Dock part of Asus Transformer


Compatibles are way too generic. "ec" basically means you document all
Asus EC, which is for sure not true. You need specific compatible for
this specific model.

Missing blank line.

> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  request-gpio:

gpio is deprecated. gpios, look at any other binding.

> +    maxItems: 1
> +
> +  asus,dockram:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: I2C device used to access power related functions.
> +
> +  asus,clear-factory-mode:
> +    type: boolean
> +    description: clear Factory Mode bit in EC control register

Why would this be a static/fixed property over lifecycle of all devices?

> +
> +  battery:
> +    type: object
> +    $ref: /schemas/power/supply/power-supply.yaml
> +    unevaluatedProperties: false
> +
> +    properties:
> +      compatible:
> +        const: asus,ec-battery
> +
> +    required:
> +      - compatible
> +
> +  charger:
> +    type: object
> +    $ref: /schemas/power/supply/power-supply.yaml
> +    additionalProperties: false
> +
> +    properties:
> +      compatible:
> +        const: asus,ec-charger
> +
> +      monitored-battery: true
> +
> +    required:
> +      - compatible
> +
> +  keyboard-ext:
> +    type: object
> +    description: top row of multimedia keys
> +    additionalProperties: false
> +
> +    properties:
> +      compatible:
> +        const: asus,ec-keys
> +
> +    required:
> +      - compatible
> +
> +  led:
> +    type: object
> +    additionalProperties: false
> +
> +    properties:
> +      compatible:
> +        const: asus,ec-led
> +
> +    required:
> +      - compatible
> +
> +  serio:

All of these children are pointless - no resources. Drop all of them,
it's btw explicitly documented rule in writing bindings.

Best regards,
Krzysztof


