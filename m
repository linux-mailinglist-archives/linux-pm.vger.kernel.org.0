Return-Path: <linux-pm+bounces-42040-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cIDYIn7rgmnqewMAu9opvQ
	(envelope-from <linux-pm+bounces-42040-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 04 Feb 2026 07:47:26 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3042E2690
	for <lists+linux-pm@lfdr.de>; Wed, 04 Feb 2026 07:47:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A562306859B
	for <lists+linux-pm@lfdr.de>; Wed,  4 Feb 2026 06:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4FB387562;
	Wed,  4 Feb 2026 06:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MonAV9Wt"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8B0385EFE
	for <linux-pm@vger.kernel.org>; Wed,  4 Feb 2026 06:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770187561; cv=none; b=bsF8/Vm0pEtajAv2yJ2kRIZ3AC1AFv/h5NreZm6AvvaKJJhsReZHWlUXJom5nuMW47lmMqAvG6XGBrY7eiWgYoMIDrJd86ciQ8jlAZi3YIfpe+ddj5LQ60f6U7gE6a9x+DP+Jiqw6TqB409aRqGHfWXocmpNaGj2tPkjQ7m2Iww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770187561; c=relaxed/simple;
	bh=IdONEzeO/kcku0TNPRScc8YoDp0OPcTwD4lfoMWDGls=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MEipBX7c+Dp6CmLv3ksprlIf8g/xZH3osYZC0kP/HhWPAhKTq9zqs0qYGt1qrH9jl4ychyX5pEqe25kJCwxtJXoiTYu09g8ghE+cCMuWYdFzUtuNs8f+rULToWrOz1o2jG3lelcmJh4VQiHA8qpoksqAqSGPVgML3Lo5jW3pgJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MonAV9Wt; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4806bf03573so31512865e9.2
        for <linux-pm@vger.kernel.org>; Tue, 03 Feb 2026 22:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770187560; x=1770792360; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IdONEzeO/kcku0TNPRScc8YoDp0OPcTwD4lfoMWDGls=;
        b=MonAV9WtdyE7UMKkwNZh6mmFeiqnI7HjPePX1UpVAEJa/uIbRessX3pQTShd1OxggQ
         wf3O4s29UibTQ6tdFC+rqh+YThiEUz715lmKSkCHWd5usJBpbq7L1PYrSsUEPgz478QU
         U4HMVw+2YuO7p/tkvZvrTOGRxiTeJhWWR1VsIfoN0MOjhSjyoH8RN2ONnCScBGK245WB
         lzrVu6gpPF3syjHUf4FO+95cHMZo0N56o1EKOBJ81CiJsMS71jERgHSAHMKM1qLWEL9L
         LESXIxXOMKnuYmx8Gkb6iih5wlvAxAoSK/dd8ahoYIXcKii2BbMAaKQfNXn/JltkS8QF
         MM4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770187560; x=1770792360;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IdONEzeO/kcku0TNPRScc8YoDp0OPcTwD4lfoMWDGls=;
        b=MkjbAW4z8+K3RYq9OYqZVLTtjHDO+Eft/pH518rHTbjZ8pX4kK/jmv6p7cdvVc48LY
         6CyMRTWBSw2dxqDlIN95tdVz7rz3FVIRVaInI+uNm2ifhmJL182j7NFRZQIfQK9/Upl6
         xvBtVyScX/n2/SdmOLySW6D+Bs7bUP6XXj+hzqB3rddKF+H7HHx9FGyqgAsurODsk9xp
         tAdE6iTOMvM7Sav9g8gbR/J4a1//6YqnFwiZQvI4Wcti8h2UwVfF3nOTeLzN2SNQSh4z
         0S83a7xnUv9TZ48tXTD689zRe4PF0ASZ88+q9IUaLLGABG/8FnKzOe8dt6fA5gMV+LoG
         uJTw==
X-Forwarded-Encrypted: i=1; AJvYcCWsPrq9ZG1+MMQ2Vu5mzDi0A52bzXCINk35SKwCvVZnsIJWv/xX1iSMIi/4kOULCVJUT33REt91Tg==@vger.kernel.org
X-Gm-Message-State: AOJu0YysuUPI5vBzh9DirPP5v1kIrIkDlCPDY5fCRf/0UqP5cqrLrjY3
	k7faRXN0V5uKTq+XbH80rTCrp/0+ZN4pQZMzwXn+hqnvo6AxfZ5qDYpWcMx1NY5MYeI=
X-Gm-Gg: AZuq6aJbnfzvqYVLBfKa/0Iu8mX4c0mxDDWajrnscng1huJhy0O8g9Z5gOdxykSAWdM
	O28tsgKOeAi3pIqz2B7w2ksu+uQiMbPPmVuafAwWBsRL0tWutPnX2FnW/MbshnAKAOcwe2yft6H
	1/zjDEqZ+dTNDV1R5NcN/b6MKBKJ+mxdyopPi+LshZ5YLlyKgH7zjSoLZU0RvJO7DYEaUOCMUdP
	i9GK8Am2vT8DeinoC2FZdPBWBwx5MSghDCxocx3lJrhN1gAGM3WghvUyef0Sehpi2iWV8//1sV6
	V9lEdYh+/D+JQo4/4kEoR3A2jq2myPKElou4hMssE/5+MKB2y/xAl2vM+a72Xs6u/lp4YZIIWQ7
	wQKg+fIzTfpBzC8I26w0FzFVZwhGvwBbLG1tolunkmOEPt1jyQRDSlp2gKz2mYj/b0LI9+iM1hj
	mh57gvThuSpE01b8OlfA==
X-Received: by 2002:a05:600c:4fc4:b0:477:63db:c718 with SMTP id 5b1f17b1804b1-4830e95d692mr25283575e9.16.1770187559933;
        Tue, 03 Feb 2026 22:45:59 -0800 (PST)
Received: from draszik.lan ([212.129.76.169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4831088d318sm36527855e9.10.2026.02.03.22.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 22:45:59 -0800 (PST)
Message-ID: <977c081395c664a110389255e0cfa7eaafac912a.camel@linaro.org>
Subject: Re: [PATCH v5 3/5] mfd: max77759: add register bitmasks and modify
 irq configs for charger
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: amitsd@google.com, Sebastian Reichel <sre@kernel.org>, Rob Herring	
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley	
 <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, Greg Kroah-Hartman	
 <gregkh@linuxfoundation.org>, Badhri Jagan Sridharan <badhri@google.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, Peter Griffin
 <peter.griffin@linaro.org>, Tudor Ambarus	 <tudor.ambarus@linaro.org>, Alim
 Akhtar <alim.akhtar@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, RD
 Babiera <rdbabiera@google.com>, Kyle Tso <kyletso@google.com>
Date: Wed, 04 Feb 2026 06:46:16 +0000
In-Reply-To: <20260203-max77759-charger-v5-3-b50395376a5f@google.com>
References: <20260203-max77759-charger-v5-0-b50395376a5f@google.com>
	 <20260203-max77759-charger-v5-3-b50395376a5f@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-2+build4 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42040-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[linaro.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andre.draszik@linaro.org,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,linaro.org:dkim,linaro.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E3042E2690
X-Rspamd-Action: no action

On Tue, 2026-02-03 at 22:50 +0000, Amit Sunil Dhamne via B4 Relay wrote:
> From: Amit Sunil Dhamne <amitsd@google.com>
>=20
> Add register bitmasks for charger function.
> In addition split the charger IRQs further such that each bit represents
> an IRQ downstream of charger regmap irq chip. In addition populate the
> ack_base to offload irq ack to the regmap irq chip framework.
>=20
> Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
> ---
> =C2=A0drivers/mfd/max77759.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 =
91 +++++++++++++++++--
> =C2=A0include/linux/mfd/max77759.h | 204 ++++++++++++++++++++++++++++++++=
+++++------
> =C2=A02 files changed, 258 insertions(+), 37 deletions(-)

Reviewed-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>

