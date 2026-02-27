Return-Path: <linux-pm+bounces-43327-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KI7HCUCroWm1vQQAu9opvQ
	(envelope-from <linux-pm+bounces-43327-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 27 Feb 2026 15:33:36 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DDA21B9077
	for <lists+linux-pm@lfdr.de>; Fri, 27 Feb 2026 15:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9CFB63041A78
	for <lists+linux-pm@lfdr.de>; Fri, 27 Feb 2026 14:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D1A29D280;
	Fri, 27 Feb 2026 14:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="fnN4P0+D"
X-Original-To: linux-pm@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0208822B8C5;
	Fri, 27 Feb 2026 14:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772202439; cv=none; b=hqQ6IQbQujyXeiiZTRdZRiwv4PJGzS5HiJf2P5M8ozPiGipJ2w7YfPyJuR+3ryCidvpi3qqImWSnmdPjMF9va3PT3TK6O44H6Zd23qoKUdP9Uo1Oghs5v7CFFsht2o+VZCqfVmKwA/brKDVsbei9yOhW1V33DpqFO3QNxtbcnU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772202439; c=relaxed/simple;
	bh=1tXm+TnS2G3rRfI9XAxUYTYh0E2cTN52tteBOP81uiY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=B3rWSAECJUd5j7WQB9bc7lP9UP5p2odbLiF1s8BhqUKlG/dg15sl/A0K1O6yFuoWdI/E0bfNHTmjqsJuSSL2Wfdtjawju09e2utBbNMfZ7eq1SeNpq+NGkWLWfA9FVmmOzeVbiVV1lhEvjNSzoTaRQzhtaUsN7CS8yBFlrzl+50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=fnN4P0+D; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 130E0261CE;
	Fri, 27 Feb 2026 15:27:15 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A3OePZrBMocl; Fri, 27 Feb 2026 15:27:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1772202434; bh=1tXm+TnS2G3rRfI9XAxUYTYh0E2cTN52tteBOP81uiY=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To;
	b=fnN4P0+D+u62BEqExLXqBcaNbpfI/VaJMhGMi61wnTGHyG3cdRMb2mUOMG/4DJP1c
	 WdUPi38kY2bGSlxdqKC9wf+7pqZftfPm0z5gl7HPEFhtQvmL9Lum8Ufn6yL1i/8wpY
	 Z15rrsKnd5RcIEmuzH+RzH5uatixCatJ/36V/E6Ehb4+wf8wO8hMD1tCSO88T9QSb1
	 iZhfeXsY7clss9mFtiIDQ9jYcNJePjZ5L6HCsyzEW7MlJr/89k4jtNT74gLDJClhTh
	 ELoYopHFIKpOuylC7VJFDcWYPheTb1NbOW8YCRtd9qGYJYtlJk3GJ16ISi37e4WvLo
	 zS7uehygjp1qQ==
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Feb 2026 19:56:58 +0530
Message-Id: <DGPTBRX09EU5.1D1ZSR7EUV7AT@disroot.org>
Cc: "Lee Jones" <lee@kernel.org>, "Pavel Machek" <pavel@kernel.org>, "Rob
 Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "MyungJoo Ham"
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
To: "Krzysztof Kozlowski" <krzk@kernel.org>, "Kaustabh Chakraborty"
 <kauschluss@disroot.org>
References: <20260225-s2mu005-pmic-v3-0-b4afee947603@disroot.org>
 <20260225-s2mu005-pmic-v3-4-b4afee947603@disroot.org>
 <20260225-secret-amusing-cuttlefish-d3bee5@quoll>
In-Reply-To: <20260225-secret-amusing-cuttlefish-d3bee5@quoll>
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
	TAGGED_FROM(0.00)[bounces-43327-lists,linux-pm=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[disroot.org:mid,disroot.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9DDA21B9077
X-Rspamd-Action: no action

On 2026-02-25 11:44 +01:00, Krzysztof Kozlowski wrote:
> On Wed, Feb 25, 2026 at 12:45:06AM +0530, Kaustabh Chakraborty wrote:
>> +
>> +  This is a part of device tree bindings for S2M and S5M family of Powe=
r
>> +  Management IC (PMIC).
>> +
>> +  See also Documentation/devicetree/bindings/mfd/samsung,s2mps11.yaml f=
or
>> +  additional information and example.
>> +
>> +allOf:
>> +  - $ref: power-supply.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - samsung,s2mu005-charger
>
> Review from v1 still applies. I think you ignored several reviews, so I
> will mark entire patchset as changes requested.

Somehow I missed this one... anyways I address them here:

  Why do you need a dedicated child node for this? It's got one property,
  other than the compatible, that you're using. It could easily just go
  in the parent without a dedicated node etc.

The dt node also references a simple-battery node, that's why it's
required.

>
> Best regards,
> Krzysztof


