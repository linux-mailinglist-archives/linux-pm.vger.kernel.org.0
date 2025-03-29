Return-Path: <linux-pm+bounces-24602-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC64A75651
	for <lists+linux-pm@lfdr.de>; Sat, 29 Mar 2025 14:02:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A392816EECB
	for <lists+linux-pm@lfdr.de>; Sat, 29 Mar 2025 13:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E7A1AB50D;
	Sat, 29 Mar 2025 13:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="q2q+5wxu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5406520E6;
	Sat, 29 Mar 2025 13:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743253317; cv=none; b=gcLrKLNRU3HiYq95yLr+hm3Y6yb8jaK14liNaQpKuSfVoo5LRvIjjP4L9N7+4TUY1aUsohO/k9d9HSHUle7RO0wvQ1hzS8ShH2a1/OXMgI6j27dBNfuSSWHUSDzliFi4T28RRwbwhvZzSGQgNzKHgA8cnxIj6bxO//Tql5XvuGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743253317; c=relaxed/simple;
	bh=Am2w47/73gq+uett9Rw8f58u333+sFYsQ8cWX1qaAPw=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=UKq1yIl2E0m0mzQU5baFZp0jh+zSOQ56rF1m1F1qBjVIGKLiTh30eQaEZU01hXQZB9F8QcpCdIIwbzvOWle3Li4iwiRnULOWYJnpc3agNP7FoeIvwXBWIp/28cDf60tGXLKuobE7CSfn49kzQcYXP0/JMvran9GCFWgJROuzMOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=q2q+5wxu; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1743253312; x=1743858112; i=markus.elfring@web.de;
	bh=Tp3dkmDDfClZJ6SRNE5grrhh78twSDzP7nsBHUHXXns=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=q2q+5wxuQSBkqtUQ2p14Pj4tX1KisKZ9KDC2j9khrDffazfOnhuvRHQ3WO71Gx+C
	 N2S2zN9dYwyNu1t7qlbNjApiJ64kNgmUM55pmEh65igNjwrpy0XRGi9QUPQQ2o80e
	 6/irG2Fv6q51p/n2geHHC2sK/4ViXtRPRKiJm0yav+5CayVSrdZur6cK0mucIJivy
	 uZiOe3XSxJdYnrszWzos9hO7TzM+hJCiaone6LV1/C0mqDHBOA33OnBL5Lb3hdquM
	 XkPHK7eY1f393jS/O1ltu9rw6fXjdLm6TWZmI2zT+AIRDxzhr0AigyRVI08U5VimN
	 qUHjUdq9ze5B7idvLA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.33]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MXocY-1tdVyW0rRU-00YS3z; Sat, 29
 Mar 2025 14:01:52 +0100
Message-ID: <207f5f63-39b2-4801-ab98-8fd8cb7c1302@web.de>
Date: Sat, 29 Mar 2025 14:01:49 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: John Madieu <john.madieu.xa@bp.renesas.com>,
 linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>
Cc: John Madieu <john.madieu@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
 Biju Das <biju.das.jz@bp.renesas.com>, Lukasz Luba <lukasz.luba@arm.com>,
 Magnus Damm <magnus.damm@gmail.com>, Stephen Boyd <sboyd@kernel.org>,
 Zhang Rui <rui.zhang@intel.com>
References: <20250317143442.100590-4-john.madieu.xa@bp.renesas.com>
Subject: Re: [PATCH v4 3/5] thermal: renesas: rzg3e: Add thermal driver for
 the Renesas RZ/G3E SoC
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250317143442.100590-4-john.madieu.xa@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5n9T1IjtlRMCWnQgJ9Ekav5awbr89GIg/I+0aCfw8sZL6XUdZSO
 ZNQa0eHPPNSTK1uck9in6Hjq8LoToiBV1+ODE6jqYP3YoddNrgWb3pJj3uVB6L+gBZP26W/
 SSPu+2ZXQdcWru/RU6WIXHnrHRf1xT7s4QEACET1CoJI6ogUxt+9CYALGjdzqnBCzfViq/J
 Yt/0rq9BAqSTQ8J2LNiBA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:9vNJ6TBTLdA=;7Ii4yRb+C8sJIMUSyLbzf86clx/
 0d4OWf4znONxJoj5gakPM1kTRv2vLTXL4tbLf3ZyQ/48hzZNa50nYWHIA4JpySg/u/fbPSg76
 SVv3gr1sBo/UVUGJTuQ+ywZrtidXddUnGaJFEZuWx2/jWOl7hADeqc8pZ8te4LF599vvMio3L
 tBmOdzMuV5HNgUDZ0M+Zii6n3IulyVtUXTJ3T62f4/LXaBz2eDyTn3xX54qY28vX4rPY3fE9s
 p4/KuFGjrxXK6M65sDZuBPMHjr/DV/35XYyuxjZUPTDpjAtZYq/ggVZt8MH1vjkJMrziVHiAb
 wLOS32ryWU7jCRUA3y42bfC/uy9Ac54A9DC1b3xQXd+cKerTJpnFprHg+h63C2lEylZEwG/h4
 VpbFbrOwOIkKESk6Vt5j1iz65/EgWafrjfgov+FzfmCvFPmS0hLNbA4jNUDMbo92RlexRtiZF
 SVW93MGVmMa2qgeIWFs4Hfwbbo4y8rcE8eicsHZrbuLk9lOA4wJ5S82xhZXqh2ihkMoJqDZaO
 eKRgrg9tFTT6wc5/zf0LweoyZkqv8RFf/tRs2kPcKeHOofgaYEn//oX94wzKXsjoJ5VEeQQfh
 VXGyR593GErOj706z4PB55fGcrs/mCpsUcgiOXVm3aPmRH3zVSOkLcZVQ97eNHRGUwCZTBOUz
 aApZnzAlWbSGepoXOgfMkJAkgnJ5hXJ1JlQAeekk669tcejXcZAxLZls5sGPQPfJiNGF8Xg+g
 lerhNDCu59NMO1ScMMzYyCHoQmCHI1eC90ulHIEiPi5yvLTUz5/PXkztdNjAas6VNNA82rNZ/
 JhlrD9K3AhliNApM23n2PpCXVmwq0SJwAoTj01DMc22sBkk87lKgo6T9bPRJpjys0T4wnLd1H
 4YBbGFfFWjNl/scp/hhlIDtEVa2yDMz2ze4h8yYKoBhMqTdeb2/DXh5wjT7W4eEc6n+yqoKXq
 lBgPtxs60z/J6RgK2O8/8O0MrPsQATe+mrMBWvsIErhGgWjxdyiws/Wpoyd4ICVirADUYDEz3
 2IwloCzOgt1lMXRDy+4fkMurPmRI3SlJBYzMFqSbth9c0B5O/Pv8EJk7sD2oAJPqEGGawxPPL
 FT+tJsarDbI1A1NlOwO/W70NB1vFH6rXPiW7SfdsCMqT45QWIDjWbqaCv4aM0L0lgoJKMrAEW
 r6TEsOtbtu+2+hP82hPG1UbQO3cYFqmZHzWKC1afcu0uyqVP6+9JnJsqP7//jBPyFbBcLM0uq
 8o4whuQ8DdfwiG55OPL+SCJEQV2k21nSkWA1w5tqytcfu1NqSHl+YYe4GFBZvl7dslwLHn3g3
 ZuJedFSfLvrW2KZxe5APss0IehMjXC2GAEpaev21RYSYP1GOm/rIDcQy3DWN8ZOYX/8kw9TEW
 bZIUh3Pbsqr687hcj/HMUSdywwJ2vDLuWezGhsnxzAJIrVNguHQdxD/KQoDAs58K2atpCxPMd
 2Bh2hI4CR0lJmkqHVmSeAOfgtwWDKGuif0X0Ug5XRkJm/YwrQ

=E2=80=A6
> +++ b/drivers/thermal/renesas/rzg3e_thermal.c
> @@ -0,0 +1,445 @@
=E2=80=A6
> +static irqreturn_t rzg3e_thermal_adc_irq(int irq, void *dev_id)
> +{
=E2=80=A6
> +	int new_temp =3D temp_val * MILLIDEGREE_PER_DEGREE;
> +
> +	scoped_guard(spinlock_irqsave, &priv->reg_lock) {
> +		priv->cached_temp =3D new_temp;
> +	}
> +
> +	complete(&priv->conv_complete);
=E2=80=A6

Are curly brackets really relevant for such a =E2=80=9Cscoped guard=E2=80=
=9D?
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tre=
e/Documentation/process/coding-style.rst?h=3Dv6.14#n197

Regards,
Markus

