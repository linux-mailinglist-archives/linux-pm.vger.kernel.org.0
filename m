Return-Path: <linux-pm+bounces-43543-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MDsaIO7up2mWlwAAu9opvQ
	(envelope-from <linux-pm+bounces-43543-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 09:35:58 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A7F1FCB02
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 09:35:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 30D9331006EE
	for <lists+linux-pm@lfdr.de>; Wed,  4 Mar 2026 08:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE4839184B;
	Wed,  4 Mar 2026 08:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nG+5oQB9"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E8D391842;
	Wed,  4 Mar 2026 08:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772613160; cv=none; b=dqdZrY4mnUUSJkjX2vtVnToKq2NLca5VL8+oRfl97V9kp8hECCOE7+g+ojHEhEolO9+4+/qxaFrLuoxh6YfqpvC4XBiNsFeXniq0InIP0a2gm5KcRQ2e2UseQuMNq8Y4q6pOn8r5ySQrSWKsdHeaPwZuCbQxjFMbr93NbPD1iNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772613160; c=relaxed/simple;
	bh=OAn7qPHFY7S2uR+hLeXahcKaOgemHG+Q+TXolKgw8Z0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E0dsFhtChD7gGJjubXbbzxniD2+wQIBuj5lt9zd45NJLwtDqxHB8WFAvhkg4USBVS+RFuKyRE+PIVjAljtt98874nq6xOQeOQE/8PDl9+noJJmI9M4ZrcpwFppC5EBtUgov/zMZT4wtCMoIuYDf8NQW2aEr9a2QDi5a+/JipFJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nG+5oQB9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8894CC19425;
	Wed,  4 Mar 2026 08:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772613160;
	bh=OAn7qPHFY7S2uR+hLeXahcKaOgemHG+Q+TXolKgw8Z0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nG+5oQB9JilC3wUmQu4qcom1kCybfPmTReuyQs14WuyRTOvJuIUFwY935dtIHWYi+
	 b+OoO9PYFcNaaCG92yG4BHhCMiJxDDtZToTaymeMHNmEcZU90Y61TncRxpm6LtlXem
	 B5jvefPZPra8Jb8AB0vUOYeNzdkhNZp3I0Osjn+OeG8/HySogckGWRq5jdgTq6Wn4T
	 VWcSiK+tET7U/O64+QaP+chfIXrc2vZZ+AfH9znlXpUKSldSWuiJ1XKXZkPXyZhmEK
	 qmPHq44kOwKhSK1sbhL4VErrRhhIouNNfJXHd4pUppn7avOuHVkZUU34NWnNEllAPI
	 kijiasR5nNMpw==
Date: Wed, 4 Mar 2026 09:32:37 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Alexey Charkov <alchark@flipper.net>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chris Morgan <macromorgan@hotmail.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Sebastian Reichel <sre@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sebastian Reichel <sebastian.reichel@collabora.com>, 
	linux-pm@vger.kernel.org
Subject: Re: [PATCH 01/11] dt-bindings: mfd: ti,bq25703a: Expand to include
 BQ25792
Message-ID: <20260304-groovy-vicugna-of-energy-5efecb@quoll>
References: <20260303-bq25792-v1-0-e6e5e0033458@flipper.net>
 <20260303-bq25792-v1-1-e6e5e0033458@flipper.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260303-bq25792-v1-1-e6e5e0033458@flipper.net>
X-Rspamd-Queue-Id: D2A7F1FCB02
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43543-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,hotmail.com,gmail.com,vger.kernel.org,collabora.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[devicetree.org:url,flipper.net:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, Mar 03, 2026 at 07:32:46PM +0400, Alexey Charkov wrote:
> TI BQ25792 is similar in operation to BQ25703A, but has a different
> register layout and different current/voltage capabilities.
> 
> Expand the existing BQ25703A binding to include BQ25792, and move the
> voltage and current limits into per-variant conditional statements.
> 
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> ---
>  .../devicetree/bindings/mfd/ti,bq25703a.yaml       | 79 +++++++++++++++++-----
>  1 file changed, 62 insertions(+), 17 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/ti,bq25703a.yaml b/Documentation/devicetree/bindings/mfd/ti,bq25703a.yaml
> index ba14663c9266..99b4fba7c1d4 100644
> --- a/Documentation/devicetree/bindings/mfd/ti,bq25703a.yaml
> +++ b/Documentation/devicetree/bindings/mfd/ti,bq25703a.yaml
> @@ -4,7 +4,7 @@
>  $id: http://devicetree.org/schemas/mfd/ti,bq25703a.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>  
> -title: BQ25703A Charger Manager/Buck/Boost Converter
> +title: BQ257xx Charger Manager/Buck/Boost Converter
>  
>  maintainers:
>    - Chris Morgan <macromorgan@hotmail.com>
> @@ -14,7 +14,9 @@ allOf:
>  
>  properties:
>    compatible:
> -    const: ti,bq25703a
> +    enum:
> +      - ti,bq25703a
> +      - ti,bq25792
>  
>    reg:
>      const: 0x6b
> @@ -23,9 +25,6 @@ properties:
>      description:
>        Maximum total input current allowed used for both charging and
>        powering the device.
> -    minimum: 50000
> -    maximum: 6400000
> -    default: 3250000

Broadest constraints allways stay. See writing bindings and writing schema.

>  
>    interrupts:
>      maxItems: 1
> @@ -50,18 +49,10 @@ properties:
>  
>          properties:
>            regulator-name: true
> -          regulator-min-microamp:
> -            minimum: 0
> -            maximum: 6350000
> -          regulator-max-microamp:
> -            minimum: 0
> -            maximum: 6350000
> -          regulator-min-microvolt:
> -            minimum: 4480000
> -            maximum: 20800000
> -          regulator-max-microvolt:
> -            minimum: 4480000
> -            maximum: 20800000

Best regards,
Krzysztof


