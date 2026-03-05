Return-Path: <linux-pm+bounces-43655-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WDBFKCMkqWkL2gAAu9opvQ
	(envelope-from <linux-pm+bounces-43655-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 05 Mar 2026 07:35:15 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6A020BAB4
	for <lists+linux-pm@lfdr.de>; Thu, 05 Mar 2026 07:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 608C430234E9
	for <lists+linux-pm@lfdr.de>; Thu,  5 Mar 2026 06:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D477730648C;
	Thu,  5 Mar 2026 06:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="lm1yAbd0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD08F2DB7BB;
	Thu,  5 Mar 2026 06:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772692512; cv=none; b=oTrpbHbtesiIEoBgCiIBvY1tqg+90oYT/hAjRyvJLaWbpH0T6JOo+OHLc7BnHprX7bRTZK+hn9bRgENPu6CxVRroLlYZmtFnhir3lomF/tCWCCPNNNduCJjrlrufy1cb2ob/EZqBX6r/Bipao7e8FzF07LjQ7EPPn2P6b9Jg5uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772692512; c=relaxed/simple;
	bh=/UJ5jdqtAKSPzc8ABxq9qxtgXhxe3+XsR3r8n6e7x64=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=OIXpYF2bB/ZcZGdAWzAb2p+TO1G7NNAsJoO6ngqWGwiSb7vz0Auq15Dfu447xgmqxUJhoKO7GYLbGlj+3qVzNGMNkjur6cA4ejp62SjWBt3/LGMEddQavin1C4C4ype/gzmjvVygEDHV9Wavo65JLVZ8S+0b715ZxhKP0CRsQ2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=lm1yAbd0; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4fRKXT4QGzz9tj4;
	Thu,  5 Mar 2026 07:35:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1772692505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Roprykd/0bxr9LQQRe+mNdX0hmWBmJ1X7LdzolcDU9k=;
	b=lm1yAbd0qAPVSB0OOQRUd4vtc6/wSfKt2qM2Mf5PCiHXw/Aq5lbJdcLgCoWXi5rGNzqG9h
	JsPxrV2AZuTaGZHE9YEkXufXbnBOa1vgH/OnrUowClqEfNoiCn0Z2RCtvrYzR+oA3RBpJW
	e+Nrb02yhjVWSON6v9JBwtizQrlHgMOvTo/30HxJDRNIAzfuXY5d4VmIh7mzzr4cBGo9SX
	fibh2XYjLeQstM/fIMbgtwCn+WkPMUCv1469slw01W53veN710C6/45blpQJ7jwf568oQT
	YYEE0Ukn3WsikjqQgjaUW0CHXyLVJTZeb85uiJItA17JeDi5NujobxUHRg6jUw==
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 05 Mar 2026 14:34:47 +0800
Message-Id: <DGUN1I6AY5QI.3VWQAV1IQGD7P@mailbox.org>
Subject: Re: [PATCH v3 0/3] thermal: spacemit: Add support for SpacemiT K1
 SoC thermal sensor
From: "Shuwei Wu" <shuwei.wu@mailbox.org>
To: "Shuwei Wu" <shuweiwoo@163.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Daniel Lezcano" <daniel.lezcano@linaro.org>, "Zhang
 Rui" <rui.zhang@intel.com>, "Lukasz Luba" <lukasz.luba@arm.com>, "Rob
 Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "Yixun Lan" <dlan@gentoo.org>,
 "Philipp Zabel" <p.zabel@pengutronix.de>, "Paul Walmsley" <pjw@kernel.org>,
 "Palmer Dabbelt" <palmer@dabbelt.com>, "Albert Ou" <aou@eecs.berkeley.edu>,
 "Alexandre Ghiti" <alex@ghiti.fr>
Cc: <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-riscv@lists.infradead.org>, <spacemit@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski@oss.qualcomm.com>
References: <20260119-patchv2-k1-thermal-v3-0-3d82c9ebe8a4@163.com>
In-Reply-To: <20260119-patchv2-k1-thermal-v3-0-3d82c9ebe8a4@163.com>
X-MBO-RS-ID: 6a4d1feab15b69ac214
X-MBO-RS-META: oyujgzgony737ozxqjnzkwqas9ubuoo4
X-Rspamd-Queue-Id: 2A6A020BAB4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43655-lists,linux-pm=lfdr.de];
	FREEMAIL_TO(0.00)[163.com,kernel.org,linaro.org,intel.com,arm.com,gentoo.org,pengutronix.de,dabbelt.com,eecs.berkeley.edu,ghiti.fr];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shuwei.wu@mailbox.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[mailbox.org:+];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hi,=20

Sorry for the HTML noise in my previous mail. Correcting the format now.

Gentle ping on this patch.
Any feedback to help move it forward would be appreciated!
Thanks!

On Mon Jan 19, 2026 at 10:41 AM CST, Shuwei Wu wrote:
> Introduce support for the on-die thermal sensor found
> on the SpacemiT K1 SoC.
>
> Include the device tree binding documentation in YAML format, the
> thermal sensor driver implementation, and the device tree changes to
> enable the sensor on K1 SoC.
>
> ---
> Changes in v3:
> - Fix indentation and variable types
> - Simplify clock management and redundant assignments
> - Link to v2: https://lore.kernel.org/r/20251216-patchv2-k1-thermal-v1-0-=
d4b31fe9c904@163.com
>
> Changes in v2:
> - Move driver to drivers/thermal/spacemit/ and update Kconfig/Makefile
> - Address reviewer feedback on style and structure
> - Improve variable naming and comments
> - Link to v1: https://lore.kernel.org/r/20251127-b4-k1-thermal-v1-0-f32ce=
47b1aba@163.com
>
> ---
> Shuwei Wu (3):
>       dt-bindings: thermal: Add SpacemiT K1 thermal sensor
>       thermal: spacemit: k1: Add thermal sensor support
>       riscv: dts: spacemit: Add thermal sensor for K1 SoC
>
>  .../bindings/thermal/spacemit,k1-tsensor.yaml      |  76 ++++++
>  arch/riscv/boot/dts/spacemit/k1.dtsi               | 101 ++++++++
>  drivers/thermal/Kconfig                            |   2 +
>  drivers/thermal/Makefile                           |   1 +
>  drivers/thermal/spacemit/Kconfig                   |  19 ++
>  drivers/thermal/spacemit/Makefile                  |   3 +
>  drivers/thermal/spacemit/k1_tsensor.c              | 281 +++++++++++++++=
++++++
>  7 files changed, 483 insertions(+)
> ---
> base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
> change-id: 20251215-patchv2-k1-thermal-5ffb838fc1cc
>
> Best regards,


