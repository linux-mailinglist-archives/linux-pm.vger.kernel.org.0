Return-Path: <linux-pm+bounces-38921-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A32C94751
	for <lists+linux-pm@lfdr.de>; Sat, 29 Nov 2025 20:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D516C3A7991
	for <lists+linux-pm@lfdr.de>; Sat, 29 Nov 2025 19:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5ECF3112A5;
	Sat, 29 Nov 2025 19:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mff.cuni.cz header.i=@mff.cuni.cz header.b="hbJujqS6"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp1.ms.mff.cuni.cz (smtp-in1.ms.mff.cuni.cz [195.113.20.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F5925785E;
	Sat, 29 Nov 2025 19:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.113.20.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764446028; cv=none; b=eN6/gqBprXfytRpjhxZoIk3z3E1xVA4KIMJNcE58WKyA3C9AGmuqirRkcxYvf1iEFCxoZiTFs7VF56rSMb4W3HAlepr10xpydNIr98doBQQhsQzTthKtPyisGNEIlQTcnzQDeTnJWlBFvVH8qlZRlrHY2JMo+nCH58zeIgGJAog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764446028; c=relaxed/simple;
	bh=MrhO1nc68GfeCMgWnvVqz/TZa6wly1L1saVWsed5rlA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:To:From:
	 References:In-Reply-To; b=ru9uCl8X+LTClOzJaQXtddF0aRaS9tM7cvXr/Vy7qVUhgXebJAuFjICYaOZU5FPrguK0UIt2PulaYYu3QV0WNUrs9bfwLyjE2iEP/bZZOr8dppKDQZPxTbclMaxqM17vXHGBkPfF/JGu6ICpDvvZwVNqx7bjbmG1RGSbYY0adTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matfyz.cz; spf=pass smtp.mailfrom=matfyz.cz; dkim=pass (2048-bit key) header.d=mff.cuni.cz header.i=@mff.cuni.cz header.b=hbJujqS6; arc=none smtp.client-ip=195.113.20.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matfyz.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=matfyz.cz
X-SubmittedBy: id balejk@matfyz.cz subject /postalCode=110+2000/O=Univerzita+20Karlova/street=Ovocn+5CxC3+5CxBD+20trh+20560+5C/5/ST=Praha,+20Hlavn+5CxC3+5CxAD+20m+5CxC4+5Cx9Bsto/C=CZ/CN=Karel+20Balej/emailAddress=balejk@matfyz.cz
	serial F5FD910E8FE2121B897F7E55B84E351D
	issued by /C=NL/O=GEANT+20Vereniging/CN=GEANT+20Personal+20CA+204
	auth type TLS.CUNI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mff.cuni.cz;
	s=submission; t=1764445987; x=1765745987;
	bh=MQ3uT13n6qq7JkXGN76vfu9uM1WotpK8bIRwkXByhyw=; h=From;
	b=hbJujqS6Ism7p3H8rRTZ68IE3mNac7tqLmvIL2l9Na3TfRMx4DmOECmVsJtPqzlVY
	 cTgIqYvqt5PJZ54Rr3P031LjRgRQOUbhM7xLsQDaEv9Kix6eZQ9oNNxgnU7igun29M
	 ibL801xOd7E4HtiKnuZQpDYXI6qip5W80YOH+s1xJndVCUN/ROyKwcoEEIt0e+AQ4s
	 GqUdzuNoUEP8WxiQt6JdJbUxzQhm+63LfjgSODijNKHWBmLnqqajXAuKn4dkcZGJwh
	 ZLdpUa+797t71bez1HjtAs6JxFE5Z5f/fHw88xeqj/oaLLgULyeNlHuBTmRTv61BL0
	 uK8E69NWw0rtw==
Received: from localhost (internet5.mraknet.com [185.200.108.250])
	(authenticated)
	by smtp1.ms.mff.cuni.cz (8.18.1/8.18.1) with ESMTPS id 5ATJr5HC007466
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Sat, 29 Nov 2025 20:53:07 +0100 (CET)
	(envelope-from balejk@matfyz.cz)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 29 Nov 2025 20:53:05 +0100
Message-Id: <DELFWFLO1M8G.1AMPX0VKEOJND@matfyz.cz>
Cc: <~postmarketos/upstreaming@lists.sr.ht>, <phone-devel@vger.kernel.org>,
        "Ulf Hansson" <ulf.hansson@linaro.org>,
        "Rob Herring" <robh@kernel.org>,
        "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
        "Conor Dooley"
 <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH 2/2] pmdomain: add audio power island for Marvell
 PXA1908 SoC
To: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
From: "Karel Balej" <balejk@matfyz.cz>
References: <20251127190237.745-1-balejk@matfyz.cz>
 <20251127190237.745-2-balejk@matfyz.cz>
 <51c9408e-45e7-4ce7-9e95-6e0a45bcc8fa@dujemihanovic.xyz>
In-Reply-To: <51c9408e-45e7-4ce7-9e95-6e0a45bcc8fa@dujemihanovic.xyz>
X-Spam-Level: ****

Duje Mihanovi=C4=87, 2025-11-28T22:30:55+01:00:
> On 11/27/2025 8:02 PM, Karel Balej wrote:
>> diff --git a/drivers/pmdomain/marvell/pxa1908-power-controller.c b/drive=
rs/pmdomain/marvell/pxa1908-power-controller.c
>> index ff5e6e82d3f8..e32eb227f235 100644
>> --- a/drivers/pmdomain/marvell/pxa1908-power-controller.c
>> +++ b/drivers/pmdomain/marvell/pxa1908-power-controller.c
>> @@ -29,7 +29,10 @@
>>  #define POWER_POLL_TIMEOUT_US	(25 * USEC_PER_MSEC)
>>  #define POWER_POLL_SLEEP_US	6
>> =20
>> -#define NR_DOMAINS	5
>> +#define APMU_AUD_CLK		0x80
>> +#define AUDIO_ULCX_ENABLE	0x0d
>
> I would group these with the other register definitions.
>
> Also, it's probably better to be more consistent with the naming, so I'd
> prefer APMU_AUDIO_CLK.

So would I, but this is how the downstream code calls it so my idea was
that it possibly matches the datasheet and it would seem preferable to
me to match that even though we don't have it available.

I could then do the reverse of what you say and call the other
definition AUD_ULCX_ENABLE but AUDIO seems nicer to me too and this one
is not defined in the downstream code.

What do you think?

