Return-Path: <linux-pm+bounces-43895-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gLpgMiUerGkRlAEAu9opvQ
	(envelope-from <linux-pm+bounces-43895-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sat, 07 Mar 2026 13:46:29 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9F422BBF5
	for <lists+linux-pm@lfdr.de>; Sat, 07 Mar 2026 13:46:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C3D4F300B9D7
	for <lists+linux-pm@lfdr.de>; Sat,  7 Mar 2026 12:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16EE039B4B7;
	Sat,  7 Mar 2026 12:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rhRMsdpb"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54222BEC27;
	Sat,  7 Mar 2026 12:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772887585; cv=none; b=c7UZvnTQaHQ9FzwYjAyHaRwC3gSjPnMv1OCcnTC0dQ538uLQZyya31UDRce1YW3429mmYwTDfaFS/1JL0ecoJBrQQ3+WjudppLZP25ZJcFvWlX8LGtY25iKj3Nr4jgaQy6fLtJ1/nDmcJ2iQ/8ZsudFU62sHv2E3l2pvXUtpN2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772887585; c=relaxed/simple;
	bh=kjTxLgnrKrEL6IV1Y9jaA4cUpoDqaFywbK376zXACbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f/TY02Y/NqWPyJGgfT1iCGyHqOOCbTJNK7R4+PY4ooowNdX+DpRgKKNa43hpROscCWWs8gsPLVxVo4W4aMg/XYazBEG96QXSapfAPtf2lLCsM30CW3z/2JFOcIDcrz+JCHJSl8YMv2MEGIEu09yKtOf49E1AnMg3/HE/KwLkoBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rhRMsdpb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08EEFC19422;
	Sat,  7 Mar 2026 12:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772887584;
	bh=kjTxLgnrKrEL6IV1Y9jaA4cUpoDqaFywbK376zXACbQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rhRMsdpba+rolDoKBamq1w1atLpnK8T1HHMPi1/GGTKwBOn0Q8j6JwvJGKVed/bw8
	 Fqv6hBcVjKrc98syVX2m/Fa54Doe4K2KPcxKeiJR8UHZJzkZ8Ni3hIc+tnhoaiLAo8
	 P7XxaXsWFKchMyfCGl+za5MNOJ6ylufD2hMWJRCIRmGXla7IJPa5i42E7m44Uvr+Oz
	 YkWyqcu8G1zyMgSL5WX8vvQ04hG0WdhKOGEDkNeavNVos9hCvIxEvMn4VLufvrEuZh
	 xJmIGmQxGqDzbrTuZ28WcXMV/p3eyNHxWfxdDpYf5MrTWJeTCvNB9sDLyRj2Xkwxs+
	 HHfstdFBtKSpA==
Date: Sat, 7 Mar 2026 13:46:22 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Chanwoo Choi <cw00.choi@samsung.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH v3 4/6] dt-bindings: mfd: max77620: convert to DT schema
Message-ID: <20260307-huge-excellent-tench-0afefc@quoll>
References: <20260306133351.31589-1-clamor95@gmail.com>
 <20260306133351.31589-5-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260306133351.31589-5-clamor95@gmail.com>
X-Rspamd-Queue-Id: 6E9F422BBF5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43895-lists,linux-pm=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,linux-pm@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,intel.com,arm.com,samsung.com,bootlin.com,vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Fri, Mar 06, 2026 at 03:33:49PM +0200, Svyatoslav Ryhel wrote:
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/mfd/max77620.h>
> +
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        pmic@3c {
> +            compatible = "maxim,max77620";
> +            reg = <0x3c>;
> +
> +            interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;

This is odd interrupt. It's I2C device, so how can it be GIC?

> +            #interrupt-cells = <2>;
> +            interrupt-controller;
> +
> +            #gpio-cells = <2>;
> +            gpio-controller;
> +
> +            #thermal-sensor-cells = <0>;
> +
> +            system-power-controller;
> +
> +            pinctrl-names = "default";
> +            pinctrl-0 = <&max77620_default>;
> +
> +            max77620_default: pinmux {
> +                gpio0 {
> +                    pins = "gpio0";
> +                    function = "gpio";
> +                };
> +
> +                gpio1 {
> +                    pins = "gpio1";
> +                    function = "fps-out";
> +                    maxim,active-fps-source = <MAX77620_FPS_SRC_0>;
> +        };

Messed indentation.

> +
> +                gpio2 {
> +                    pins = "gpio2";
> +                    function = "fps-out";
> +                    maxim,active-fps-source = <MAX77620_FPS_SRC_1>;
> +                };
> +
> +                gpio3 {
> +                    pins = "gpio3";
> +                    function = "gpio";
> +                };
> +
> +                gpio4 {
> +                    pins = "gpio4";
> +                    function = "32k-out1";
> +                };
> +
> +                gpio5_6 {

No underscoers in node names. Use hyphen.

> +                    pins = "gpio5", "gpio6";
> +                    function = "gpio";
> +                    drive-push-pull = <1>;
> +                };
> +
> +                gpio7 {
> +                    pins = "gpio7";
> +                    function = "gpio";
> +                };
> +            };

Best regards,
Krzysztof


