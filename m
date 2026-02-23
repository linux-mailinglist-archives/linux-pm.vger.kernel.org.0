Return-Path: <linux-pm+bounces-43064-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AEwJLRGhnGnqJgQAu9opvQ
	(envelope-from <linux-pm+bounces-43064-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 19:48:49 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F2017BC7C
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 19:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 85525301C575
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 18:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7DFE36922C;
	Mon, 23 Feb 2026 18:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sfaJyT1w"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26A6328B7F;
	Mon, 23 Feb 2026 18:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771872496; cv=none; b=IkA3Eeh5D/H2Jg85dVVG3kcpsSY7rB9u0UtS1ecunxt/kuva9RwL8ejqUqlDNUOnKnfHEvgmYT+zCWLiCl7W//lf/by7VJn5g5cpWURCGukg8cX7CCysBg9fYzmhkb+E52T32kEu2wsxGc3vq0RJn2GcVLHGcwvPYJ8jj342rWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771872496; c=relaxed/simple;
	bh=JY36a2jUISNBgyzIWqavdWoGTymBOPrCDh5m1/4qjIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LY4dwTXj3WICA4A1GJjKX06io9eL6oZWpQys7hIPO7QRgJ5ey8KpnjQalaH5+KI2cKV2HKr9T7OwrvWFFJ1ULNRTeFVM72BVA4gTkVnGE479qMoOKZOnx2yrp3J4wGUhXCnVcLn5mNbT2KgLGn/Vs/ILoUSfYBQEOBBlivSDtDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sfaJyT1w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22C1CC116C6;
	Mon, 23 Feb 2026 18:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771872496;
	bh=JY36a2jUISNBgyzIWqavdWoGTymBOPrCDh5m1/4qjIA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sfaJyT1wWvFGevl1EEh0CxnaZq++wbd/uiH9qfCMoGugRwDV8duXYbJJ4HkQSPv/D
	 9hST8Q5KTdFPuQghY/jm3yc1dax8SIpOYJkiku3R5nLn6m6YXw6IitzzNOrIBBS1NF
	 pbTNdWquk5XxYV8CjGqHxCaR4ukIt8SDHq+pHczMITa9qNZbNz65Zc61XyI638Uhzc
	 25fN1FpkJzkcYDA0n+hwLrEY0tpiE8GgA42aRIn/vCpoK7oDKLOta+Ro9dQDdDkE4i
	 qV2rNW4m7iumW3ohk614sIq+E7RUunXZ8MCnJ3YVdhb5vnT61rr2qwf4sMI4G5uIMj
	 01/RpOF5VF4gw==
Date: Mon, 23 Feb 2026 12:48:15 -0600
From: Rob Herring <robh@kernel.org>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Hans de Goede <hansg@kernel.org>,
	Jens Reidel <adrian@mainlining.org>,
	Casey Connolly <casey.connolly@linaro.org>,
	~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/5] dt-bindings: thermal: generic-adc: Document
 #io-channel-cells
Message-ID: <20260223184815.GA144001-robh@kernel.org>
References: <20260220-bat-temp-adc-v2-0-fe34ed4ea851@fairphone.com>
 <20260220-bat-temp-adc-v2-2-fe34ed4ea851@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260220-bat-temp-adc-v2-2-fe34ed4ea851@fairphone.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43064-lists,linux-pm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robh@kernel.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 76F2017BC7C
X-Rspamd-Action: no action

On Fri, Feb 20, 2026 at 10:19:06AM +0100, Luca Weiss wrote:
> Document the property to allow using this sensor with io-channels.

Why? On the surface, it looks like you are adding a provider property to 
a consumer. Maybe that's right? 

> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  Documentation/devicetree/bindings/thermal/generic-adc-thermal.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/generic-adc-thermal.yaml b/Documentation/devicetree/bindings/thermal/generic-adc-thermal.yaml
> index 12e6418dc24d..317fc39ed46a 100644
> --- a/Documentation/devicetree/bindings/thermal/generic-adc-thermal.yaml
> +++ b/Documentation/devicetree/bindings/thermal/generic-adc-thermal.yaml
> @@ -24,6 +24,9 @@ properties:
>    '#thermal-sensor-cells':
>      const: 0
>  
> +  "#io-channel-cells":
> +    const: 0
> +
>    io-channels:
>      maxItems: 1
>  
> @@ -58,6 +61,7 @@ examples:
>      thermal-sensor {
>          compatible = "generic-adc-thermal";
>          #thermal-sensor-cells = <0>;
> +        #io-channel-cells = <0>;
>          io-channels = <&ads1015 1>;
>          io-channel-names = "sensor-channel";
>          temperature-lookup-table = <
> 
> -- 
> 2.53.0
> 

