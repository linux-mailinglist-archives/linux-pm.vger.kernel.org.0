Return-Path: <linux-pm+bounces-42204-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aDvZHo/yhWlsIgQAu9opvQ
	(envelope-from <linux-pm+bounces-42204-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Feb 2026 14:54:23 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C94FE792
	for <lists+linux-pm@lfdr.de>; Fri, 06 Feb 2026 14:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 50C6F3063B82
	for <lists+linux-pm@lfdr.de>; Fri,  6 Feb 2026 13:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9693ECBC2;
	Fri,  6 Feb 2026 13:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A7685P9B"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BA52C1598;
	Fri,  6 Feb 2026 13:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770385756; cv=none; b=c51Uevslpfr+pC24PhNRuCGA/nBv2yzZyWD3gzfjnwTtnq14sgngwJhQ2m4AJysZdCnE0fd0qjo6uK8rM6RkyVv6CZqtBItWpjp8t/mLfBFs3OMp6hZEjW7M46hfeved7ZfuBii6lTAbRDdI5xIFjoBWOysBKTuP5lpx5nPUcr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770385756; c=relaxed/simple;
	bh=bw8XnN7GAtHbMGWT6c70a57LvKvAaPHKIeczAuOJ/9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fg4Th89M/hpyf+ekKdvEJXF5LZwZhnQJQu397euq2H90ZS0GaRVU3PBVGN61eDE9KYYB8FN/To/Fu6HKk1uiix7zpjpN4425OyehXMj9eBac2ebelo61YV6wnlJPvnJugzuAsH8Z/0ESbPWTEOJBAsrnu4E8a4OxcUCPnTfbCXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A7685P9B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D102C116C6;
	Fri,  6 Feb 2026 13:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770385756;
	bh=bw8XnN7GAtHbMGWT6c70a57LvKvAaPHKIeczAuOJ/9Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A7685P9BsDfnk8ytrx5sGjOh/ELz1RZnEH9S3vCMjitXtGWDZ49ZWt7kugs9MVPUR
	 /AXXuqjOlp97Hjch3Msr0VEEhX6jpL3dZosW2cxbRXUPzUnxC3p9i2cEVo48QwZl9N
	 sJ8bEN3SuXobnKSt7fxjVKBmusMfEF9IrfJ0twDvs9l7GUgOuFmHan1UxOvBiq112y
	 9rBV1hu6Rcuk8mzfqcD8+KShCmavmq0eXhaT4MvPryUq1b09xF8fCs+fTF10bPQ0cD
	 Nw8Jpq0yRrEB2Dfu12wO0Ea+Abwrc5F9dFE/IDAeZ4vlnmIIUP5fhEHbbx8c5EUJ32
	 vEOHKTMyopw4A==
Date: Fri, 6 Feb 2026 07:49:15 -0600
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
Subject: Re: [PATCH v2 03/12] dt-bindings: extcon: document Samsung S2M
 series PMIC extcon device
Message-ID: <20260206134915.GA171264-robh@kernel.org>
References: <20260126-s2mu005-pmic-v2-0-78f1a75f547a@disroot.org>
 <20260126-s2mu005-pmic-v2-3-78f1a75f547a@disroot.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126-s2mu005-pmic-v2-3-78f1a75f547a@disroot.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42204-lists,linux-pm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[disroot.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,devicetree.org:url]
X-Rspamd-Queue-Id: 33C94FE792
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 12:37:10AM +0530, Kaustabh Chakraborty wrote:
> Certain Samsung S2M series PMICs have a MUIC device which reports
> various cable states by measuring the ID-GND resistance with an internal
> ADC. Document the devicetree schema for this device.
> 
> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
> ---
>  .../bindings/extcon/samsung,s2mu005-muic.yaml      | 35 ++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/extcon/samsung,s2mu005-muic.yaml b/Documentation/devicetree/bindings/extcon/samsung,s2mu005-muic.yaml
> new file mode 100644
> index 0000000000000..05828b7b5be13
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/extcon/samsung,s2mu005-muic.yaml
> @@ -0,0 +1,35 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/extcon/samsung,s2mu005-muic.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Extcon Device for Samsung S2M series PMICs
> +
> +maintainers:
> +  - Kaustabh Chakraborty <kauschluss@disroot.org>
> +
> +description: |
> +  The Samsung S2M series PMIC extcon device is a USB port accessory

extcon is a Linuxism. Use usb-connector binding.

> +  detector. It reports multiple states depending on the ID-GND
> +  resistance measured by an internal ADC.
> +
> +  This is a part of device tree bindings for S2M and S5M family of Power
> +  Management IC (PMIC).
> +
> +  See also Documentation/devicetree/bindings/mfd/samsung,s2mps11.yaml for
> +  additional information and example.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - samsung,s2mu005-muic
> +
> +  port:
> +    $ref: /schemas/graph.yaml#/properties/port

What does the port connect to?

> +
> +required:
> +  - compatible
> +  - port
> +
> +additionalProperties: false
> 
> -- 
> 2.52.0
> 

