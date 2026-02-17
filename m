Return-Path: <linux-pm+bounces-42735-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SPsAEQVSlGlFCgIAu9opvQ
	(envelope-from <linux-pm+bounces-42735-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 12:33:25 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9957614B695
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 12:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6C353036EE2
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 11:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A185E330324;
	Tue, 17 Feb 2026 11:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u2ruo2Jd"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF9828640F;
	Tue, 17 Feb 2026 11:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771327951; cv=none; b=ZVjQ6sqWlXwcTIUn7U4GqFEPFVCWDVyNvVTV6LPsKr4rjxTWaB5xlEI3Amjact+G3gqM63fDFg/YjuO8GX77XQZbhfBQwGsIVTWclMCvo7LJVD2U/7Z2QoZ+JB5LfGlhAka6LR1NzmWLWXdC6NMF34yT6fEF6NpykagaEWJjecs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771327951; c=relaxed/simple;
	bh=P3OsmKbJawEhi3OXvofQa81VseCumNhItOTZirw03UM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U5mv5RIGId3465qMLw0tzL7TM6F9XSXDheYqCzSJsTJQE/6iIuYGfL4OrLm2CJp6uaJIvvsmjMVudQDfzfxHfxtvujY8yCCRPM2dx95ikX7guX3mIt1YaEnFKnmHfCEtv7tPQ5eH+x2l83WFcYRiXUtL+4Oe8TN5WTQGh/wGaVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u2ruo2Jd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC8EDC19423;
	Tue, 17 Feb 2026 11:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771327951;
	bh=P3OsmKbJawEhi3OXvofQa81VseCumNhItOTZirw03UM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=u2ruo2JdEaiFxjFmaHJbr8to6bz8ANqzR8DJCM6Ogm/HsJCQKH+mR11/m/cYhnBKZ
	 1DZjmCZS3UyO3jiXN8sYP+BE0pmRhFo1sCD3Ozt1pMyZQBTKMuFf5VJaI4JGtRcFQ5
	 OhEBhp9w2rFvE+4gqKr00ZAbodDR3wCSL0MGF7DT54xjgVkmY6oV/0IeRD5+zJSwDL
	 fNamuOfz62PygGqydxToUH5xQ1y730PzkhayNzXr6mh+cn7cTaC0TuaxHRVBBIg/VX
	 tpYwRv72+hlc/TBg/zuQ/MAKSV0KpS/RflmI/N/YqYLxiE8h0eDSQnc/BtrVOGm5fN
	 e5t/uXI6U0m7Q==
Message-ID: <1519143e-4fc3-490d-ab8d-e65edd2c4eec@kernel.org>
Date: Tue, 17 Feb 2026 12:32:26 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/7] dt-bindings: embedded-controller: document ASUS
 Transformer EC
To: Svyatoslav Ryhel <clamor95@gmail.com>, Conor Dooley <conor@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee@kernel.org>,
 Pavel Machek <pavel@kernel.org>, Sebastian Reichel <sre@kernel.org>,
 Ion Agorria <ion@agorria.com>, =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?=
 <mirq-linux@rere.qmqm.pl>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
 linux-leds@vger.kernel.org, linux-pm@vger.kernel.org
References: <20260214180959.30714-1-clamor95@gmail.com>
 <20260214180959.30714-2-clamor95@gmail.com>
 <20260216-sprung-scallop-de7b64bf528c@spud>
 <CAPVz0n06+uLCSfY_bYS9v7KJ-hXotye7ej-rze6-Q8_JAF7XVA@mail.gmail.com>
 <20260216-plunder-defense-de11cf56dd3d@spud>
 <CAPVz0n0-LbTUZBCaO=oN3PpPLpwAqzNo29r687pKY8NbEE9giA@mail.gmail.com>
 <20260217-vowed-botany-b1c47c7e40b8@spud>
 <55C30023-4175-48F2-BCB0-12EC23C48F01@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <55C30023-4175-48F2-BCB0-12EC23C48F01@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42735-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,agorria.com,rere.qmqm.pl,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 9957614B695
X-Rspamd-Action: no action

On 17/02/2026 12:23, Svyatoslav Ryhel wrote:
>>> in other words you propose this:
>>>
>>> properties:
>>>   compatible:
>>>     oneOf:
>>>       - items:
>>>           - enum:
>>>               - asus,sl101-ec-dock
>>>               - asus,tf101-ec-dock
>>>               - asus,tf101g-ec-dock
>>>               - asus,tf201-ec-dock
>>>               - asus,tf300t-ec-dock
>>>               - asus,tf300tg-ec-dock
>>>               - asus,tf300tl-ec-dock
>>>               - asus,tf700t-ec-dock
>>>           - const: asus,transformer-ec-dock
>>>
>>>       - items:
>>>           - enum:
>>>               - asus,p1801-t-ec-pad
>>>               - asus,tf201-ec-pad
>>>               - asus,tf300t-ec-pad
>>>               - asus,tf300tg-ec-pad
>>>               - asus,tf300tl-ec-pad
>>>               - asus,tf700t-ec-pad
>>>               - asus,tf600t-ec-pad
>>>               - asus,tf701t-ec-pad
>>>           - const: asus,transformer-ec-pad
>>>
>>> And in the driver add match to every single entry of enums?
>>
>> No, I was talking about removing the generic compatibles entirely, since
>> they are not suitably generic to cover all devices at the point of
>> addition. So like:
>>
> 
> Actually, they all can be grouped under asus,transformer-ec fallback if that is needed, both pad and dock EC have the same core functions just different set of cells. And then in the driver each compatible will get a dedicated matching data. Will this work?

Then what does the generic compatible express if it is not used by the SW.

Wrap your emails to mailing list style.

> 
> properties:
>   compatible:
>       - items:
>           - enum:
>               - asus,p1801-t-ec-pad
>               - asus,sl101-ec-dock
>               - asus,tf101-ec-dock
>               - asus,tf101g-ec-dock
>               - asus,tf201-ec-dock
>               - asus,tf201-ec-pad
>               - asus,tf300t-ec-dock
>               - asus,tf300t-ec-pad
>               - asus,tf300tg-ec-dock
>               - asus,tf300tg-ec-pad
>               - asus,tf300tl-ec-dock
>               - asus,tf300tl-ec-pad
>               - asus,tf700t-ec-dock
>               - asus,tf700t-ec-pad
>               - asus,tf600t-ec-pad
>               - asus,tf701t-ec-pad
>           - const: asus,transformer-ec
> 
> And them schema name will match the genetic compatible.

Then what does the generic compatible express?


Best regards,
Krzysztof

