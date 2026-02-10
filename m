Return-Path: <linux-pm+bounces-42428-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SK6BD3gBi2npPAAAu9opvQ
	(envelope-from <linux-pm+bounces-42428-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 10:59:20 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FFF811948B
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 10:59:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 841B0301828F
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 09:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 389B534253B;
	Tue, 10 Feb 2026 09:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZQz7nBck"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B074832AADE
	for <linux-pm@vger.kernel.org>; Tue, 10 Feb 2026 09:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770717291; cv=none; b=AkCuI1/FvZPdP4nTLBzUIaUhZYwbEZLzgW89Zp2z9L5tEbZTzIBxeZzmLeboq/rSmsVEaQe8Q/vDOrdiYwQUyIt+XSsfhK0aTtUtBbUfe7D3eGxVv0Q+pU7Nhx5vmIKiwCBqlwWNQIysicGg3LwSUsSVaKvjvD2aK0NIIHqRnoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770717291; c=relaxed/simple;
	bh=HxxenadFwN0QecO/VcAoIcmjFPcwyrISlXCM0v/oOYo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NlKDjTMocsIz4pLMDPi6qpXfqJ3/1YEJrLuH5pSurGdqWkxaMTjmPieoc2dOHfl6FyDR/J11tQFf+e1F5L09QRahHQjwCeRdrVPmHEdcChFALcCWxAaEf+mXIi6MFSNKOv/59p2zSTusfvFLxUr9F/bivUZ0jpSQ0M2wDm85M5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZQz7nBck; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso6421275e9.1
        for <linux-pm@vger.kernel.org>; Tue, 10 Feb 2026 01:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770717288; x=1771322088; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8HYdS+zrmd+b3Wrxo0gB3qyloTrSaCZ1qSRZuELJtL4=;
        b=ZQz7nBckSlVgz3NphooJaa4UG/JHDyLHzGwmCJrkG3TW0W46js5oASREoep3pjUDeX
         hY98/9Qvbt9lVdm9We9DLBc1PNR+mlInuHdl/4Wwi9mGrNgrz+S5vPy7Grw9dsEJs1vi
         YVSpbsP3xvFbPHVz19ui1gt1/tH6oRt/FMAmyq68Pm9V1+bcKvQ+pAmJ3whgwbRpF/go
         iNGy/EhkvHhDFT9kEwrXIWpF14HZrCgeddPgNGBMQkfq7XBuiNoYS95dsYM1JFFO4095
         u6su+gUqs5ZGHINTxlZiLKwFsMVne/PaglGpr+SNkALVS/SkgRUtGeuSH/lVD8Bb6LhR
         iSgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770717288; x=1771322088;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8HYdS+zrmd+b3Wrxo0gB3qyloTrSaCZ1qSRZuELJtL4=;
        b=IfhiWF8SDPtQIkT5lJFv+8/PNfbVLCvSa8WnBP//0zevTpeEeyyJFfGzRXvCeeeEGE
         FDZG9Aa7psvlqqVHRYGN1H1VLqei4hFO9rmzlezrAj7HMWTh+GK+n5Vwdp9w1LgXPBVp
         ScplSjDzZtoQJUNofrm4LBVeFybR8qyJUQTCe3l4mK70X+itZaBbK22jIiD1VtouO9d+
         ge8GyWBMAWFJh31ettQM7RRSLVR4c8mH+ZmrYS9g1Pf6KTQoEVm1hPpyjnwuVylZ/d8N
         XWVn5PQu3Jw0iFpJw6r9gn36imsU9ECnLY2I8bg8dUHSVJyBpPjS2ySla5DAQD91RHlT
         LeCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtdsMKHgJBHyqx66/9l80rmd0r8liOE0b0zKKXvXbL5vAnB/8w0VnxEOYmFs6BjPkrBA1uaMYhKA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwtBlJ9fF7XXsNkthr54BKte3TvhxH8k8hvc0VwcyYYWsABlGpD
	0vHUv3sUZbagAjAOsl7ReLbb12IFsT0ReVsbKowYyf78xYjKK/ybwrjuCPUrO4fwnRE=
X-Gm-Gg: AZuq6aLtRIiDRs2HFZ1ECy0uM+MT4cel2f7oRgHmktBRfN47e1dL2e8KSIwEB6+o622
	9NgZJvFfR1lcT8PTVOVmB3chG6vl3EgXDBrxoQn4rA6xL7pU/0MiwbK/omHJO2ETvKMz2rKtOQz
	MWtz6wBxn3E7+wonqoR+DVwjEIPmlDjHQV6g2+ugqjTB+0J3ZRZ/Htje0MQJwLlVRo/QaURVqiV
	9sfLX5jK3TaRMVAYzVdHVEBjlBYyXeIDPVZOgixN12c+Moiqf6YkOp6RLXFS3Ag020zuAZZ0FhN
	R1zJ/fGS6RVct1aaS59RF+OvjAIA/pC1l2pQFopwqQ5821flnrLst0qAVI7e9zV9lv5WmeMX2/0
	1bnv8lX9yKDuHeYoWPoijlEc0Q9GLcjo06ZuBAerBhQGbZSlq7h2XykOJiyp1XeF4rJFYRJ8rzs
	9PQ8S9dS8+v7nP20/vKKiy9VdN79ebV6w+cg4SHcfn
X-Received: by 2002:a05:600c:3509:b0:477:a9e:859a with SMTP id 5b1f17b1804b1-4832021604amr182180095e9.22.1770717288054;
        Tue, 10 Feb 2026 01:54:48 -0800 (PST)
Received: from draszik.lan ([212.129.79.225])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48320961701sm214759035e9.5.2026.02.10.01.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 01:54:47 -0800 (PST)
Message-ID: <6cb639e1b655efb68aebc8b21ae34450b8936830.camel@linaro.org>
Subject: Re: [PATCH v2 06/12] mfd: sec: add support for S2MU005 PMIC
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Kaustabh Chakraborty <kauschluss@disroot.org>, Lee Jones
 <lee@kernel.org>,  Pavel Machek <pavel@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,  Conor Dooley
 <conor+dt@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo
 Choi	 <cw00.choi@samsung.com>, Sebastian Reichel <sre@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, Jonathan Corbet	 <corbet@lwn.net>, Shuah
 Khan <skhan@linuxfoundation.org>
Cc: linux-leds@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, linux-rtc@vger.kernel.org, 
	linux-doc@vger.kernel.org
Date: Tue, 10 Feb 2026 09:55:14 +0000
In-Reply-To: <DG74Y3QSCLIO.32Q8ZKCTISXXB@disroot.org>
References: <20260126-s2mu005-pmic-v2-0-78f1a75f547a@disroot.org>
	 <20260126-s2mu005-pmic-v2-6-78f1a75f547a@disroot.org>
	 <69e2c1b1a2f3d2ed5e5da995cc5ee49bb3627597.camel@linaro.org>
	 <DG74Y3QSCLIO.32Q8ZKCTISXXB@disroot.org>
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
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42428-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linaro.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andre.draszik@linaro.org,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linaro.org:mid,linaro.org:dkim,disroot.org:email]
X-Rspamd-Queue-Id: 8FFF811948B
X-Rspamd-Action: no action

On Thu, 2026-02-05 at 21:02 +0530, Kaustabh Chakraborty wrote:
> On 2026-02-04 15:23 +00:00, Andr=C3=A9 Draszik wrote:
> > Hi,
> >=20
> > On Mon, 2026-01-26 at 00:37 +0530, Kaustabh Chakraborty wrote:
> > > Samsung's S2MU005 PMIC includes subdevices for a charger, an MUIC (Mi=
cro
> > > USB Interface Controller), and flash and RGB LED controllers.
> > >=20
> > > S2MU005's interrupt registers can be properly divided into three regm=
ap
> > > IRQ chips, one each for the charger, flash LEDs, and the MUIC.
> > >=20
> > > Add initial support for S2MU005 in the PMIC driver, along with it's t=
hree
> > > interrupt chips.
> > >=20
> > > Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
> > > ---
> > > =C2=A0drivers/mfd/sec-common.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 16 ++
> > > =C2=A0drivers/mfd/sec-i2c.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 12 ++
> > > =C2=A0drivers/mfd/sec-irq.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 74 ++++++++
> > > =C2=A0include/linux/mfd/samsung/core.h=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=
=A0 1 +
> > > =C2=A0include/linux/mfd/samsung/irq.h=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
 66 ++++++++
> > > =C2=A0include/linux/mfd/samsung/s2mu005.h | 328 +++++++++++++++++++++=
+++++++++++++++
> > > =C2=A06 files changed, 497 insertions(+)
> > >=20
>=20
> [...]
>=20
> > > diff --git a/drivers/mfd/sec-i2c.c b/drivers/mfd/sec-i2c.c
> > > index 3132b849b4bc4..3f1d70cc3292b 100644
> > > --- a/drivers/mfd/sec-i2c.c
> > > +++ b/drivers/mfd/sec-i2c.c
> > > @@ -17,6 +17,7 @@
> > > =C2=A0#include <linux/mfd/samsung/s2mps14.h>
> > > =C2=A0#include <linux/mfd/samsung/s2mps15.h>
> > > =C2=A0#include <linux/mfd/samsung/s2mpu02.h>
> > > +#include <linux/mfd/samsung/s2mu005.h>
> > > =C2=A0#include <linux/mfd/samsung/s5m8767.h>
> > > =C2=A0#include <linux/mod_devicetable.h>
> > > =C2=A0#include <linux/module.h>
> > > @@ -130,6 +131,11 @@ static const struct regmap_config s2mpu05_regmap=
_config =3D {
> > > =C2=A0	.val_bits =3D 8,
> > > =C2=A0};
> > > =C2=A0
> > > +static const struct regmap_config s2mu005_regmap_config =3D {
> > > +	.reg_bits =3D 8,
> > > +	.val_bits =3D 8,
> > > +};
> >=20
> > No cache? And what is the .max_register value?
> >=20
>=20
> This was in the previous revision, but I ended up removing it because
> (at least I thought at that time) interfered with interrupts firing in
> some way. The actual issue was unrelated, so I will add it back.
>=20
> However, there is also another thing I see in logs:
>=20
> sec-pmic-i2c 2-003d: using zero-initialized flat cache, this may cause un=
expected behavior
>=20
> This is due to REGCACHE_FLAT, I am not sure if I should just ignore
> this.

I think the error might be because you should also specify num_reg_defaults=
_raw:

.max_register =3D xxx,
.num_reg_defaults_raw =3D xxx + 1,


Cheers,
Andre'

