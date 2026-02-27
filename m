Return-Path: <linux-pm+bounces-43328-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wO4IDEm0oWmMvgQAu9opvQ
	(envelope-from <linux-pm+bounces-43328-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 27 Feb 2026 16:12:09 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D2C1B97D3
	for <lists+linux-pm@lfdr.de>; Fri, 27 Feb 2026 16:12:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 34C543010736
	for <lists+linux-pm@lfdr.de>; Fri, 27 Feb 2026 15:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C01641C2FB;
	Fri, 27 Feb 2026 15:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="hJCuxZJy"
X-Original-To: linux-pm@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B65E2472A6;
	Fri, 27 Feb 2026 15:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772205121; cv=none; b=Fv7wiYEbyz6/4eGg6Gpl3kP52RYMRGwmYYg0wG0WIgJwHUMwwe9ybNdq8A3UuIIKIgf2b5XfPbwknDYyqyEsxKEHR7LvH8IKJnevcgVAR9rlbzV8icq31Rj6aL06ZO8NIlbhqnsK+RPE5Wvii6TGFMqh761rLxVpXaL4Jb6piQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772205121; c=relaxed/simple;
	bh=irR3JYp0TTVgm0qtqdE0bAHioGjEPqy0Cdw4ZxZ7UnM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=FtGSH1TVYface7A/yCF9clfqoaolje0qfFQXPLvA2i7egYrsCFJY6hNqgcOaxIgrcy7UtXcsWM+XH9MgIKkoiODAoMlkcwVSAspzqznGWhxuHZOJmRuYmz40yBy6vqbRQ+0qTDNFGJsFArb5Ztjewrqb3QDeAQ0ElHFBYRe3F48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=hJCuxZJy; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 529272602D;
	Fri, 27 Feb 2026 16:11:57 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XAbdgqFAuMAv; Fri, 27 Feb 2026 16:11:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1772205116; bh=irR3JYp0TTVgm0qtqdE0bAHioGjEPqy0Cdw4ZxZ7UnM=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To;
	b=hJCuxZJy3yGznOny6+ryfErku1V5Gb/V0QeuXGfywmX/YoPpk5knFFIT8TZB9J0+T
	 1lpQ8pwsj+oDBTs57WoVXZubcl5g7Ssj6nOeqynazyRPA/5Ewan7VJWgpOzjmW3TXs
	 gB+OhlSsOf7UsxO9JrjfH1bTXpCTkE3x+DRowE7qXe1+13bAgK9+t+DcTx4fSIBCbK
	 9g4K9looklH1bJdN/fHMTp9OlrtMqJYrC+Oh12eS43O/2gt1y7JcsNU6LeQOpWG8Np
	 Vuv6yxDDZ9TD9FSaAcGlY3l2l10Sqm395aAVxnpuThBaIJW9bUe/hOsIPnwBPzU3OY
	 OH7lhkLshI/hQ==
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Feb 2026 20:41:46 +0530
Message-Id: <DGPUA2NC5ZJI.O10VWM5D15B3@disroot.org>
Cc: <linux-leds@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
 <linux-samsung-soc@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
 <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v3 03/13] dt-bindings: extcon: document Samsung S2M
 series PMIC extcon device
From: "Kaustabh Chakraborty" <kauschluss@disroot.org>
To: "Kaustabh Chakraborty" <kauschluss@disroot.org>, "Lee Jones"
 <lee@kernel.org>, "Pavel Machek" <pavel@kernel.org>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, "MyungJoo Ham" <myungjoo.ham@samsung.com>,
 "Chanwoo Choi" <cw00.choi@samsung.com>, "Sebastian Reichel"
 <sre@kernel.org>, "Krzysztof Kozlowski" <krzk@kernel.org>,
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, "Jonathan Corbet"
 <corbet@lwn.net>, "Shuah Khan" <skhan@linuxfoundation.org>, "Nam Tran"
 <trannamatk@gmail.com>
References: <20260225-s2mu005-pmic-v3-0-b4afee947603@disroot.org>
 <20260225-s2mu005-pmic-v3-3-b4afee947603@disroot.org>
In-Reply-To: <20260225-s2mu005-pmic-v3-3-b4afee947603@disroot.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[disroot.org,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[disroot.org:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43328-lists,linux-pm=lfdr.de];
	FREEMAIL_TO(0.00)[disroot.org,kernel.org,samsung.com,linaro.org,bootlin.com,lwn.net,linuxfoundation.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kauschluss@disroot.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[disroot.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,disroot.org:mid,disroot.org:dkim,disroot.org:email]
X-Rspamd-Queue-Id: 37D2C1B97D3
X-Rspamd-Action: no action

On 2026-02-25 00:45 +05:30, Kaustabh Chakraborty wrote:
> Certain Samsung S2M series PMICs have a MUIC device which reports
> various cable states by measuring the ID-GND resistance with an internal
> ADC. Document the devicetree schema for this device.
>
> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
> ---
>  .../bindings/extcon/samsung,s2mu005-muic.yaml      | 39 ++++++++++++++++=
++++++
>  1 file changed, 39 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/extcon/samsung,s2mu005-mui=
c.yaml b/Documentation/devicetree/bindings/extcon/samsung,s2mu005-muic.yaml
> new file mode 100644
> index 0000000000000..e047e8cbc264e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/extcon/samsung,s2mu005-muic.yaml
> @@ -0,0 +1,39 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/extcon/samsung,s2mu005-muic.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MUIC Device for Samsung S2M series PMICs
> +
> +maintainers:
> +  - Kaustabh Chakraborty <kauschluss@disroot.org>
> +
> +description: |
> +  The Samsung S2M series PMIC MUIC device is a USB port accessory
> +  detector. It reports multiple states depending on the ID-GND
> +  resistance measured by an internal ADC.
> +
> +  This is a part of device tree bindings for S2M and S5M family of Power
> +  Management IC (PMIC).
> +
> +  See also Documentation/devicetree/bindings/mfd/samsung,s2mps11.yaml fo=
r
> +  additional information and example.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - samsung,s2mu005-muic
> +
> +  connector:
> +    $ref: /schemas/connector/usb-connector.yaml#
> +
> +  port:
> +    $ref: /schemas/graph.yaml#/properties/port

A v1 review from Conor says:

  Why does this need a dedicated child node for just a port property?

In v3, connector is added. This now has the same properties as
maxim,max14526. If this still applies, it would be nice to have more
insight...

> +
> +required:
> +  - compatible
> +  - connector
> +  - port
> +
> +additionalProperties: false


