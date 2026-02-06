Return-Path: <linux-pm+bounces-42202-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0MQdKvHvhWlvIQQAu9opvQ
	(envelope-from <linux-pm+bounces-42202-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Feb 2026 14:43:13 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E25FE565
	for <lists+linux-pm@lfdr.de>; Fri, 06 Feb 2026 14:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE69C3097591
	for <lists+linux-pm@lfdr.de>; Fri,  6 Feb 2026 13:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09FB3ED131;
	Fri,  6 Feb 2026 13:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mYfsIHvW"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CC33DA7FC;
	Fri,  6 Feb 2026 13:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770385118; cv=none; b=ghWgzNVlaKho6h4QF4bF9IkiHz0wUK7MID0t/A/cwiBs5bCP1+GY+oPAmnwXDR0jgfAqiFUbuWpjeTPPou7CVJ8l352PtcfWmfyHMxZgR0c+9m9cKjvYaA2UQ2TnT/noZsljUy1Icy6NEXJ6fJQIwFIdlBG/k7+IaEdh6avpj0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770385118; c=relaxed/simple;
	bh=TKImgnehvE6Ydt2EXD44DX+FMzv6VK2ZzlRPkbvF1jc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BqVhqfduHcCTQ6Q/tCERTwaWUh1UP5ZOBTJaO48SKOkH9r0zC4aAq25UXiTXWn+nBPozMkF+i0QaIijwRHqGF02gpdYlAtM9iFMwDY1DcigXty69Ezsq+bqB28gPMkSGe55xL9+df1ajN89UzfEhAxxoiV+YmJy53GWMD9o4qIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mYfsIHvW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08282C19421;
	Fri,  6 Feb 2026 13:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770385118;
	bh=TKImgnehvE6Ydt2EXD44DX+FMzv6VK2ZzlRPkbvF1jc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mYfsIHvW64Omhh6lN3F/YsJGsIAQF+jmA9xWN3Wregpo02nTFLPaiswtE7FcEeBbq
	 OPvU/kWEkdjesch6VrpCHmbXr9g0dcIY2qQZ/cgX89TGYHt8yndZU4rGft8NdV1Fge
	 ToMLH1rBFuKfgwAo7Wx197oXISgRLA8A+d11Au92tpWAwAilo7Oro2THyQBJ4pueFq
	 DIK4j2nIwkNb+MvL5Gbns+YLlhUuJ2iG1Cs+DzUlpvRpvRjr+YyVlKJE7aSXEhwtaz
	 G28SsuCI23yegEGeNH2t+An37GVhtxpOJA6FPGoTwvuYTY/k5Imt2ahHyroVBbefwy
	 oRmPeOxNV5/jQ==
Date: Fri, 6 Feb 2026 07:38:37 -0600
From: Rob Herring <robh@kernel.org>
To: Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Sebastian Reichel <sre@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	=?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>, linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	linux-rtc@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 02/12] dt-bindings: leds: document Samsung S2M series
 PMIC RGB LED device
Message-ID: <20260206133837.GA157817-robh@kernel.org>
References: <20260126-s2mu005-pmic-v2-0-78f1a75f547a@disroot.org>
 <20260126-s2mu005-pmic-v2-2-78f1a75f547a@disroot.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126-s2mu005-pmic-v2-2-78f1a75f547a@disroot.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42202-lists,linux-pm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.990];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robh@kernel.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[devicetree.org:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 55E25FE565
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 12:37:09AM +0530, Kaustabh Chakraborty wrote:
> Certain Samsung S2M series PMICs have a three-channel LED device with
> independent brightness control for each channel, typically used as
> status indicators in mobile phones. Document the devicetree schema from
> this device.
> 
> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
> ---
>  .../bindings/leds/samsung,s2mu005-rgb.yaml         | 34 ++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/leds/samsung,s2mu005-rgb.yaml b/Documentation/devicetree/bindings/leds/samsung,s2mu005-rgb.yaml
> new file mode 100644
> index 0000000000000..6806b6d869ff7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/samsung,s2mu005-rgb.yaml
> @@ -0,0 +1,34 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/leds/samsung,s2mu005-rgb.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: RGB LED Controller for Samsung S2M series PMICs
> +
> +maintainers:
> +  - Kaustabh Chakraborty <kauschluss@disroot.org>
> +
> +description: |
> +  The Samsung S2M series PMIC RGB LED is a three-channel LED device with
> +  8-bit brightness control for each channel, typically used as status
> +  indicators in mobile phones.
> +
> +  This is a part of device tree bindings for S2M and S5M family of Power
> +  Management IC (PMIC).
> +
> +  See also Documentation/devicetree/bindings/mfd/samsung,s2mps11.yaml for
> +  additional information and example.
> +
> +allOf:
> +  - $ref: common.yaml#

This looks a bit lacking. Don't you need 3 child nodes for each or 
reference to the multi-color schema?

> +
> +properties:
> +  compatible:
> +    enum:
> +      - samsung,s2mu005-rgb
> +
> +required:
> +  - compatible
> +
> +unevaluatedProperties: false
> 
> -- 
> 2.52.0
> 

