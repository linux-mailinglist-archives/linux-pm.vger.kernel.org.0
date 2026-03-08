Return-Path: <linux-pm+bounces-43917-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id BxN1KQ9orWm42gEAu9opvQ
	(envelope-from <linux-pm+bounces-43917-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sun, 08 Mar 2026 13:14:07 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 413872302D9
	for <lists+linux-pm@lfdr.de>; Sun, 08 Mar 2026 13:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E59DF30160C9
	for <lists+linux-pm@lfdr.de>; Sun,  8 Mar 2026 12:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BDBF314D18;
	Sun,  8 Mar 2026 12:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="KyjIBFlh"
X-Original-To: linux-pm@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AD8186E58;
	Sun,  8 Mar 2026 12:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772972041; cv=none; b=DueR3ubEq0LlLcQQnRfBF886q/hcnuD4FKGC+DB32GLdsZDAJcUop7R6NmK/5VvaNkLFN2YpEx7L74YwJTPrRyaPjJI3yVucJJIieVQvMe751pMf53a2GCFFE6iM/UjRHidVxl02XyZt+5FYqyJmOSmFLm1igT5SBQ47TSPdXd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772972041; c=relaxed/simple;
	bh=KlM4hl1KhneCR8S8wwL3AsgMH81tqTiQtLEzLpcTFB8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=SBsPfs4FrCayHhapXCVBQUEDjxEmog6qY4Wwwq/F9gdQCiA/Ga5aaO5K9se67+cr2Wn4tpxnZ6PIduqC0SmUXXpjgqRHcGcgAkCeOPzJdb1/VzqLdr8zadmfUXCkM7icEulraJ50qj+XPYs7Lo4w5t3K6j7sgGvGPVXr4LlhiMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=KyjIBFlh; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id DDFE326EFE;
	Sun,  8 Mar 2026 13:13:49 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0qODxsH7oPNB; Sun,  8 Mar 2026 13:13:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1772972029; bh=KlM4hl1KhneCR8S8wwL3AsgMH81tqTiQtLEzLpcTFB8=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To;
	b=KyjIBFlhaggFLByg0qYTM3R9UKdLN4gTJoVWxYMGCTO1AiAcHGG3puAma8c7K7iBm
	 P9ZyoJYeYwgWy6noq0JJD18uvLOh1I1iPAvkF2IpxFmh2brEhVsF3antyOKShJKK8J
	 UynPrM1MMQsLSkCEdxnvBxfyvZZhaMkW/FFMd/Zlvm3vkvzURROeTGX9bkw41grD8d
	 xzFD2lu6n52eR3qGpUMPs8Xh0CKIVtObiwABALQnVhItYrEb3+6lL4ZTEXP4mt7ZNI
	 m0G0IFI8jwnlkexuJbdlCb50yBqBShATich6U79uyfer27E0ydBBFrHKr+KXUVf+F9
	 39sDGFV1tNhcA==
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 08 Mar 2026 17:43:34 +0530
Message-Id: <DGXE4J5UJKGM.2R9HM21UDP13L@disroot.org>
Cc: "Krzysztof Kozlowski" <krzk@kernel.org>, "Lee Jones" <lee@kernel.org>,
 "Pavel Machek" <pavel@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "MyungJoo Ham"
 <myungjoo.ham@samsung.com>, "Chanwoo Choi" <cw00.choi@samsung.com>,
 "Sebastian Reichel" <sre@kernel.org>, =?utf-8?q?Andr=C3=A9_Draszik?=
 <andre.draszik@linaro.org>, "Alexandre Belloni"
 <alexandre.belloni@bootlin.com>, "Jonathan Corbet" <corbet@lwn.net>, "Shuah
 Khan" <skhan@linuxfoundation.org>, "Nam Tran" <trannamatk@gmail.com>,
 <linux-leds@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
 <linux-samsung-soc@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
 <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v3 04/13] dt-bindings: power: supply: document Samsung
 S2M series PMIC charger device
From: "Kaustabh Chakraborty" <kauschluss@disroot.org>
To: "Rob Herring" <robh@kernel.org>, "Kaustabh Chakraborty"
 <kauschluss@disroot.org>
References: <20260225-s2mu005-pmic-v3-0-b4afee947603@disroot.org>
 <20260225-s2mu005-pmic-v3-4-b4afee947603@disroot.org>
 <20260225-secret-amusing-cuttlefish-d3bee5@quoll>
 <DGPTBRX09EU5.1D1ZSR7EUV7AT@disroot.org>
 <20260306005057.GA877725-robh@kernel.org>
In-Reply-To: <20260306005057.GA877725-robh@kernel.org>
X-Rspamd-Queue-Id: 413872302D9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[disroot.org,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[disroot.org:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43917-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,samsung.com,linaro.org,bootlin.com,lwn.net,linuxfoundation.org,gmail.com,vger.kernel.org];
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
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 2026-03-05 18:50 -06:00, Rob Herring wrote:
> On Fri, Feb 27, 2026 at 07:56:58PM +0530, Kaustabh Chakraborty wrote:
>> On 2026-02-25 11:44 +01:00, Krzysztof Kozlowski wrote:
>> > On Wed, Feb 25, 2026 at 12:45:06AM +0530, Kaustabh Chakraborty wrote:
>> >> +
>> >> +  This is a part of device tree bindings for S2M and S5M family of P=
ower
>> >> +  Management IC (PMIC).
>> >> +
>> >> +  See also Documentation/devicetree/bindings/mfd/samsung,s2mps11.yam=
l for
>> >> +  additional information and example.
>> >> +
>> >> +allOf:
>> >> +  - $ref: power-supply.yaml#
>> >> +
>> >> +properties:
>> >> +  compatible:
>> >> +    enum:
>> >> +      - samsung,s2mu005-charger
>> >
>> > Review from v1 still applies. I think you ignored several reviews, so =
I
>> > will mark entire patchset as changes requested.
>>=20
>> Somehow I missed this one... anyways I address them here:
>>=20
>>   Why do you need a dedicated child node for this? It's got one property=
,
>>   other than the compatible, that you're using. It could easily just go
>>   in the parent without a dedicated node etc.
>>=20
>> The dt node also references a simple-battery node, that's why it's
>> required.
>
> That can go in the parent.

So the parent MFD has the following?

  allOf:
    - $ref: power-supply.yaml#

I'm kind of not sold on this one.

Moreover, I was planning to introduce a port to/from the MUIC in the
next revision so that would've been included here too.

>
> Rob


