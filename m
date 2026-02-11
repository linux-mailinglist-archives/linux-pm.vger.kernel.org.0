Return-Path: <linux-pm+bounces-42498-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4DUYImhfjGmWlwAAu9opvQ
	(envelope-from <linux-pm+bounces-42498-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 11:52:24 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31906123A37
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 11:52:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F3A01301E21A
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 10:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB9436A025;
	Wed, 11 Feb 2026 10:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KRL4uY83"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D8B366DB6
	for <linux-pm@vger.kernel.org>; Wed, 11 Feb 2026 10:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770806912; cv=pass; b=htIjudTdmiSv6260YV5G6e4BKwnDFKeIBVY56DkfzPTTeBBE7wGfauO7f+fjU+hUky9+KnaQy6HI28mXVh2Wno1ER52YOxrsE2qVejtaLSYwzMc6kfjWh0H7WqkZpwBthpA9t9AlkKQPGQKB9jfC+8myJNRvIzTCVeVwa1CB2eI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770806912; c=relaxed/simple;
	bh=goC3mIbNohckiF5ZYjrfvjxXcyQ5EbfvCJ7/+85hUuY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NV7n2Pxk8vVTtpqBhq0S8VGXNVUPlpiqMTi4ap8QROWfwZSVWV2oF/SfADWgltpGQVU8liCqqy00MrGk+1p3GQG59gbFf2P34CBv1oxbw7f/Zfc7zmUiyHgP7kGtX1+8IsqqUfsn1O1M40NDPCGzZUERu0/RDVffmAugGmjiJ2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KRL4uY83; arc=pass smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4376acce52eso1251279f8f.1
        for <linux-pm@vger.kernel.org>; Wed, 11 Feb 2026 02:48:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770806909; cv=none;
        d=google.com; s=arc-20240605;
        b=XwxGWUcp9U9SesR3I7ZvC2uc5nIo7gGvReN/GBH3nevqskhHM8nuXPiDYg+aa/edmY
         rIc9apvQdvJmQLEgMxKladmy1M9tDe5sm9CLDv22kpbh9xWhWoy9L2zKJAjow66+Dv++
         nbQqYEAuhod5LGPf70MBX+LM21dO5PI7z/ocFn4RpSm3OOzaATbHDor8sa6gvnn6ySKb
         CacC7A2sY9dXiha5CNxPImm0A1ECnt4MfoZqpWJwI6OsngDM/LECTMG75Xb9RWcxlQFN
         tEyoHb07Vg5eeXfiS4QXFGuhVScVPiEBv7iSB9+pIE3xQQXe1eY9Poik8QdcTu8l1lqz
         mMHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=J2gBRwJor0x8FmOh8GyzyKNT5TNM+dtqzKR3kPMSD/A=;
        fh=w5W6gbsZGl24vSZCMY4LyDlWUw1d28saycTDj1qxo3Y=;
        b=jA3rMOi/Xw5igxE4ibu8+UyHKW3m2IrN74pk2nOPJP947d8PvahdQx3b4IV170Mp+p
         G60mc32+UsT49qxPf3zyeckQDZgMo1q8HRVXmQg8Z6t+bagvwjqrnW+n/7bLW4ULu1/R
         iAdseUhV+7MxV+wTxB/gDQYTHZWMllCwHqjk2feRWfVRaKP9zjTj5AzBZSD1jCz6dQUD
         Y4jnWDkBevcLyCJZg5zW7Q2DzsHVBatkADvXrHeLNstMmaf8gJ0MuRtcyhR+Dg6n8KiK
         qVUBInKvvoG9+jhS4f7vWHOW16fDnb+FaRDyVH/2+VbdPcsZh0zXnFTQAoOeNLfcSbjx
         g72A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770806909; x=1771411709; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J2gBRwJor0x8FmOh8GyzyKNT5TNM+dtqzKR3kPMSD/A=;
        b=KRL4uY83VFKh79eYwywSsflLk7UhcCxSBevCn+ooQ3zf/ZOiVyAwA7LsGqN75vtnD9
         Gp/OaQuqqH2HwbQi28TheijoUEfT5V0YzhJJL8d/yffptZ0AxU2///H7bSEX+fW5EIy+
         7nspB6NMe1SU/uBs4oBctjJqQMHnoOEOEue1qVy5Ow2IhS9mz1FKMlKz4ZOCi+hajr4t
         B9t1FLLZNpM7rsGXKfOb292YixpPnQSEzjmc/zviMEO43BR/qr9iUzn9P687zMn04ik0
         UO+6EYGsTfkfC2TjDCaLk8qVPKIGM+6GayJarcsKBzjrBP7tvAgQsKK6so+/Op5f/WKC
         9WCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770806909; x=1771411709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J2gBRwJor0x8FmOh8GyzyKNT5TNM+dtqzKR3kPMSD/A=;
        b=umlJGjaaSdILvmOmDFArQJzFwropWIqhdKXw6JhxBmldSlIYRHS9WyNIKC03Yzqtlj
         0UuI7X4oim+VplczsIvZr1E5DIsohjHPHEZCQj9W7K2zBfO5o0UpzYQTATfUJDtvkUCO
         mfXbTv4lUzFSWxihb0Cg4oq5TvtlUzXJFGm+q7V4O+QK+JSQKLaihIoK+v+nxmDrO2db
         cYz8hEuGG6ukDwj6uBmX76o3KnexbDHpQ4cJm47zERSYhA1Kxn7t8G5scjP3r3dhdbKZ
         cBctRi2eTt2Qz3pY9TFCrPljz5HFXViVvJU/F1l7vtJVenwWkaCPnDhmE6O21mfodeSW
         4u/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWYe4sL/LOkdosZ5Ry3qj8LYRESl73JUJTx+rlXszxD9UDsppneT8jgGlb/mRujaRAWtVCoHbHgnQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxM3xI0y0Ca3Uq76GfQbdMC+Up7SqxPCxDVVYh0N/Z2kbbtPn+L
	YWxzHSjiH8sr9Ee1eOoShwWQ2H7uQTYE8vvVXKyh4jw8g8i3i5F3S9DE52dgNGlf/lkeWHuWrhr
	dzTtsxQLOJdmbFfkTHdW2iHjCjkOUIJk=
X-Gm-Gg: AZuq6aIgk5xn9ja1hodG9G1v6HGZM8TgmrqUWTJFYvNw6DWvHNliWakM9DUBy48u17Q
	54Zds4H/gDNQRDkvLVs1Bj6GZLJsih9Ux5FL2WBxbTeabUIDeP2Cs9OXJHE/missrwlFVjxl1OB
	Ixl4hTkhhtokzlMrMKteXn4YYvP6sOiOlUx49CAgRsawbWJysComcNRjI32CXGFeheg18sHNJim
	tNHmmRU59iJ7OWLoySNsLTxI6smK5a7Oo7Y+BiyxBsieZCqAUYOXomeeAGDb4vFDAnMZN/1ervX
	mca03FJu
X-Received: by 2002:a05:6000:3107:b0:435:9770:9eb8 with SMTP id
 ffacd0b85a97d-4362923fc0emr28798812f8f.25.1770806909126; Wed, 11 Feb 2026
 02:48:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260209104407.116426-1-clamor95@gmail.com> <20260209104407.116426-4-clamor95@gmail.com>
 <20260210-sexy-grumpy-sambar-44edd2@quoll> <CAPVz0n3fizf=r58Fr4YQ6pnjHq5p-7yFz95obss6w6x0bfgnDg@mail.gmail.com>
 <d1973810-d3f5-4ed7-ba0f-6bf93c1c7f3d@kernel.org> <CAPVz0n1foyy9g7MAurSAyLCUHTzrPPu0ceqy9YpcDA9uzgjGng@mail.gmail.com>
 <cb91898e-10f1-4d64-bace-41bbed08179b@kernel.org> <CAPVz0n0O_uSAPYFtg8s+Ni0buyGJys6d0jEMob6SNWx-aeKUEw@mail.gmail.com>
 <dc7acd1e-91e8-492c-8665-cb680c6164fd@kernel.org> <CAPVz0n0u_0ZukcKXt0QpiyCMhWsg2VE-dE19wDCbRQvBvVOf+A@mail.gmail.com>
 <ec3b39d6-51ec-429d-b083-e5af2b4a9c65@kernel.org> <9dcc308d-f87d-4706-90ae-df3669aea224@kernel.org>
In-Reply-To: <9dcc308d-f87d-4706-90ae-df3669aea224@kernel.org>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Wed, 11 Feb 2026 12:48:16 +0200
X-Gm-Features: AZwV_QiRfznTx26RtaNIi_FievzuOy5_SC6hUakUwNSsN_ybyyiwQRTPmonDjZ8
Message-ID: <CAPVz0n0ULXAWnK0cJcuK-k9jO9JdqHutZ84bsgSDwGJUshgS+Q@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42498-lists,linux-pm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 31906123A37
X-Rspamd-Action: no action

=D0=B2=D1=82, 10 =D0=BB=D1=8E=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 14:48 Krzy=
sztof Kozlowski <krzk@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On 10/02/2026 12:54, Krzysztof Kozlowski wrote:
> > On 10/02/2026 12:40, Svyatoslav Ryhel wrote:
> >>>>
> >>>> So you propose introduce a compatible for every single ec used in
> >>>> transformers instead of simply disable unpopulated functions? And ho=
w
> >>>> then battery and charger can reach monitored cell if they have no
> >>>> dedicated node?
> >>>
> >>> Just like for other bindings for nodes without resources, fold into
> >>> parent. This is already explained in writing bindings, so you could h=
ave
> >>> just read that. I will pass with answering more questions till you re=
ad
> >>> that doc.
> >>>
> >>
> >> Unfolding asus,ec-pad and asus,ec-dock will result in this list:
> >>
> >> asus,tf101-dock-ec
> >> asus,tf101g-dock-ec
> >> asus,sl101-pad-ec
> >> asus,tf201-pad-ec
> >> asus,tf201-dock-ec
> >> asus,tf300t-pad-ec
> >> asus,tf300t-dock-ec
> >> asus,tf300tg-pad-ec
> >> asus,tf300tg-dock-ec
> >> asus,tf300tl-pad-ec
> >> asus,tf300tl-dock-ec
> >> asus,tf600t-pad-ec
> >> asus,tf700t-pad-ec
> >> asus,tf700t-dock-ec
> >> asus,tf701t-pad-ec
> >> asus,p1801-t-pad-ec
> >>
> >> with minor variations in populated cells. Is this acceptible?
> >
> >
> > Yes, this looks correct.
>
> Update: with fallback-expressed compatibility when same interface and/or
> superset of features.
>

I am removing separate DockRAM and merging it into this schema hence,
it should look like this

  reg:
    description:
      The ASUS Transformer EC has a main I2C address and an associated
      DockRAM device, which provides power-related functions for the
      embedded controller. Both addresses are required for operation.
    minItems: 2

  reg-names:
    items:
      - const: ec
      - const: dockram

How should I organize amount of regs? Would this example be acceptable
with minItems: 2 since EC requires both to work or should I set is as
items list or minItems: 2 maxItems: 2? Thank you.

> Best regards,
> Krzysztof

