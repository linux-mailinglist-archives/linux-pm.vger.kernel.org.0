Return-Path: <linux-pm+bounces-42440-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CB6zMD8Ti2nnPQAAu9opvQ
	(envelope-from <linux-pm+bounces-42440-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 12:15:11 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D63D11A063
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 12:15:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 28F9F303076C
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 11:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1236A3644A7;
	Tue, 10 Feb 2026 11:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e65AQGhn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1F33624C3
	for <linux-pm@vger.kernel.org>; Tue, 10 Feb 2026 11:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770722108; cv=pass; b=Va4/d0f5tUxkKz5hH1Je8H0HnJInoMASq1o+XlVjf7v6KkCTy1IaYzNPGFxifnyCI7zdo0ekIZqd1rGJ+lZKBEIyDZwzmuRS2j7hpCtfji+zfbj0SzSIHeT7lYOV+SveASfD2tpDQZx3UJ2Se8J9kgRntbDS6lZuFgsUR1sAp3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770722108; c=relaxed/simple;
	bh=9RwOH4R4QH3gaTZuNlGDQPuuOYTY4NM/rcBF3DQRpJk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=duXWRSdjyO62KyIbcdLIJ+bEVc11kI6Bzp8J6BXmtQGJurCFWnW1ISckoo0ZDbiDxL9LcGXvncqWp+0S9tsrGMMgCWTGci92acrfkBYy+ntCDEhsawUSOvDiLAhrW4pN9DUr/QcWZgy/RzG9MqpBhqIlVlJ9RBfxE/lUMcnjdfg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e65AQGhn; arc=pass smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-4358fb60802so3671292f8f.1
        for <linux-pm@vger.kernel.org>; Tue, 10 Feb 2026 03:15:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770722106; cv=none;
        d=google.com; s=arc-20240605;
        b=N3zgvQeoXcOFuLlbH/Sc1Zu6c07CKAitgr8+pFl0PMUjU6C56nzD+BYoCF9UBiZg4O
         vYvAv2AVQsibno8x8Cp5Zaz4AUFlNVZABiABQ/8PhBIqMeDiBsOygnGMJst3u192DNnh
         ru8vKHr8+fLIqoFQOlr6ZF4+QvlrgbV0poSjsPza0s7IpVMWaaWL66Fxpyb3iV1GOrvZ
         167yi7hkNPY1XxVTUwOY5CmejtMM+LRpWw2MCilh/TT1qJSojE84Tl4fq3PUJKorHjVZ
         RVNF4P5unhtoZKzT6ZwqlX/8tlHqPYIKDTLySAu/4M2JHGZjAupASkUDMYdcTw/H2HV+
         dmYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZSAYORMyK0PsRntDbPFNKD2d4UOZsLZplo2+nFOE3f0=;
        fh=TD1mAYUoRTGUXdCJVmo4nCaKs4lIC3JR3zcyY5+U2RE=;
        b=FLiN9nxIo9sBEJuK0x45oBMhtGys4loR9rhoTHYvE2y7NdMBjP2QzZprj5kSd3GqX7
         lSgOAgXRSVNi/ug+wC3x9OgOvt1n2W3ecbAfFcLoBKgK6jX1BfujHrlWQgJwxHNYBwsn
         7tV1I7tL2dyeKMUsQwZOIz1id7LDNTE4Xs4XlVJBbXGM6PGLYuMbjP7pmWitygMp80S5
         8vAsswQy+Aqez6hmG0mvf9S+Sx4Xg1O5KMUOHkpC2F4p1xwfxREyvtRzLnk8OL/oPkga
         lvp2/qGFGehd0X+/nAYGwNjt6q74Va4xzu1Akatpofn8WpWL0PcmMKhCM/ahyf/lZBN2
         IBJA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770722106; x=1771326906; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZSAYORMyK0PsRntDbPFNKD2d4UOZsLZplo2+nFOE3f0=;
        b=e65AQGhnvdaLKgQEePASEnn1uArSYPcLLtNE/LagVjnVXxWPQE0M5Z+STwJUYnDuxh
         VkCO0K9HHao6r1CR8g1Wv4+Sk6RjSmCFjjdyR7cPmqtCA30gJnQl5LA7iJ8ZeQMsFUrQ
         6G60TqXAEDOo1YNK5mNsToHVJqTxjqpdjtDf+RimrkyI4/cw5av0OjHxpkHQTMLkJAK1
         R2q6G5wd/a/xaU8HosV2er5VumaFi9KzcSVJIxR4FbI+dPMbKqYCEz6D9fHuL+Dkgf16
         A0h+lo939gv0Dm+VXZT91NDaHxX5nYfQLJWR6mkUN/U67u/e7SlVauf1tzkDeE5QJ+Mc
         4nvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770722106; x=1771326906;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZSAYORMyK0PsRntDbPFNKD2d4UOZsLZplo2+nFOE3f0=;
        b=ZoIHKAbvxDMtemVFd3JU4tLbjlrZKwP3qQjlV9BVGRoS1F0/epbhIR1FhDURjWjp/v
         b+NmK75fNIJ6qJrVDyu6BjyakyCmytAVZ2n2MVTRJ1EPfZrUQAz/em9ToDYUrzIwMnUW
         I8k8rCKKxveojag4vgfEbqKlVvDD6Co3EPRReBTdXS38PON4SqbFTgJz+485hNcI1IAS
         tMaOYdY1+nCADQpAOgtXGwXQ1/3MuRjdbyEZcQ2zuGAU2G8fQQn7xXetK7wHRPY8GVub
         ewKs/2WO+mWr9uJQ6Zz6iFmfxCR+UQzcqQt+v6oO5BIqgBnXFx4+qAoi1wWWRqnleOMW
         ADEg==
X-Forwarded-Encrypted: i=1; AJvYcCXJLExtFoAqk0dmN64UElRC6wWFhC72TLSog0mQW5ps+zIelHnZqeW0W0vRGXQGMe/i6cbGo6tKwg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwN6xGmvnQs/RfNeXCGr0Y4W8GP0vsJe2nBhGyn3E/Tq8dWSMvW
	LZPGnQDEWhYV3eJycDg8m3mGNelj5r6ESSygm7nqvcAdhmzQn7jeXLUW+xqoAkiQ9BjSz2m/ZK8
	BykiJCoYyhySlfLKrUyHUAJ4tmQrqDF4=
X-Gm-Gg: AZuq6aJDf0neSefyn9PcvZQEEa2Sx8CiOL+VywtpknS+mET4lykWyVin6qpcLkfb3H6
	yPLNvj7Zs2posUYGkcMOEdYrmolMzLCXmtgMg4yaEthjDmZqjgOawdgZtjts58GEzURW4WUUxFD
	nUWP1Ed/o5U5BGDgNdi0m/lrPYBX017jyKxEIyk0BsvMqMeC6G7uKYus4Li5rMXUGStLYlQ5Yds
	ofO6rO8bcKaFQyWBiaT+VrfNBuPEbs+aVezh1tRHnRH7oEKKJl64F8M092sFjqkrPD9BRLKmmT0
	gWuyrnQAnWeMzuVcn50=
X-Received: by 2002:a05:6000:613:b0:437:678b:83cd with SMTP id
 ffacd0b85a97d-43779ead3ecmr3197089f8f.15.1770722105549; Tue, 10 Feb 2026
 03:15:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260209104407.116426-1-clamor95@gmail.com> <20260209104407.116426-4-clamor95@gmail.com>
 <20260210-sexy-grumpy-sambar-44edd2@quoll> <CAPVz0n3fizf=r58Fr4YQ6pnjHq5p-7yFz95obss6w6x0bfgnDg@mail.gmail.com>
 <d1973810-d3f5-4ed7-ba0f-6bf93c1c7f3d@kernel.org> <CAPVz0n1foyy9g7MAurSAyLCUHTzrPPu0ceqy9YpcDA9uzgjGng@mail.gmail.com>
 <cb91898e-10f1-4d64-bace-41bbed08179b@kernel.org>
In-Reply-To: <cb91898e-10f1-4d64-bace-41bbed08179b@kernel.org>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 10 Feb 2026 13:14:54 +0200
X-Gm-Features: AZwV_QjE-AzqhPkZWgl4Q7_crb7bzCw5fMSH51bvzWcCqyTypBK83ZwA3GpjXGc
Message-ID: <CAPVz0n0O_uSAPYFtg8s+Ni0buyGJys6d0jEMob6SNWx-aeKUEw@mail.gmail.com>
Subject: Re: [PATCH v2 3/9] dt-bindings: mfd: document ASUS Transformer EC
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Sebastian Reichel <sre@kernel.org>, =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, 
	Ion Agorria <ion@agorria.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42440-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[clamor95@gmail.com,linux-pm@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,arndb.de,linuxfoundation.org,rere.qmqm.pl,agorria.com,vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid]
X-Rspamd-Queue-Id: 3D63D11A063
X-Rspamd-Action: no action

=D0=B2=D1=82, 10 =D0=BB=D1=8E=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 13:04 Krzy=
sztof Kozlowski <krzk@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On 10/02/2026 11:59, Svyatoslav Ryhel wrote:
> >>>>> +  asus,clear-factory-mode:
> >>>>> +    type: boolean
> >>>>> +    description: clear Factory Mode bit in EC control register
> >>>>
> >>>> Why would this be a static/fixed property over lifecycle of all devi=
ces?
> >>>>
> >>>
> >>> Specify pls.
> >>
> >> Provide rationale why we need to clear it every time, not once. Or any
> >> other rationale why we would accept that property.
> >>
> >
> > Cause it is done by original Asus code and Asus did not provide
> > schematic or any data apart from downstream source regarding this EC.
>
> So that's a no. downstream code which is poor quality, not following DT
> rules at all, is never an argument for a DT property.
>

This property indicates that this controller on every reset restores
factory bit hence it must be cleared. Bit is write only and cannot be
detected. EC remains in factory mode which blocks its functions.

> >
> >>>
> >>>>> +
> >>>>> +  battery:
> >>>>> +    type: object
> >>>>> +    $ref: /schemas/power/supply/power-supply.yaml
> >>>>> +    unevaluatedProperties: false
> >>>>> +
> >>>>> +    properties:
> >>>>> +      compatible:
> >>>>> +        const: asus,ec-battery
> >>>>> +
> >>>>> +    required:
> >>>>> +      - compatible
> >>>>> +
> >>>>> +  charger:
> >>>>> +    type: object
> >>>>> +    $ref: /schemas/power/supply/power-supply.yaml
> >>>>> +    additionalProperties: false
> >>>>> +
> >>>>> +    properties:
> >>>>> +      compatible:
> >>>>> +        const: asus,ec-charger
> >>>>> +
> >>>>> +      monitored-battery: true
> >>>>> +
> >>>>> +    required:
> >>>>> +      - compatible
> >>>>> +
> >>>>> +  keyboard-ext:
> >>>>> +    type: object
> >>>>> +    description: top row of multimedia keys
> >>>>> +    additionalProperties: false
> >>>>> +
> >>>>> +    properties:
> >>>>> +      compatible:
> >>>>> +        const: asus,ec-keys
> >>>>> +
> >>>>> +    required:
> >>>>> +      - compatible
> >>>>> +
> >>>>> +  led:
> >>>>> +    type: object
> >>>>> +    additionalProperties: false
> >>>>> +
> >>>>> +    properties:
> >>>>> +      compatible:
> >>>>> +        const: asus,ec-led
> >>>>> +
> >>>>> +    required:
> >>>>> +      - compatible
> >>>>> +
> >>>>> +  serio:
> >>>>
> >>>> All of these children are pointless - no resources. Drop all of them=
,
> >>>> it's btw explicitly documented rule in writing bindings.
> >>>>
> >>>
> >>> They are all needed to be able to disable them individually from the
> >>> device tree if needed.
> >>
> >> They should not be disabled from DT, so they are not valid here. The
> >> given EC for given device is fixed/static. Does not change.
> >>
> >
> > Have you considered a possibility that function may be
> > disabled/unrouted within the controller. By the vendor.
>
> And then it is implied by the compatible, so no need for any of that.
> Otherwise, if it is not specific per device, then specifying it for DTS
> for all devices would make no sense.
>

So you propose introduce a compatible for every single ec used in
transformers instead of simply disable unpopulated functions? And how
then battery and charger can reach monitored cell if they have no
dedicated node?

> Best regards,
> Krzysztof

