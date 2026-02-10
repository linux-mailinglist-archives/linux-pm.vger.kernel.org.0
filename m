Return-Path: <linux-pm+bounces-42421-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2HoDCXj8imlyPAAAu9opvQ
	(envelope-from <linux-pm+bounces-42421-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 10:38:00 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C275118F68
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 10:37:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6C02230098AF
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 09:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F00534165B;
	Tue, 10 Feb 2026 09:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CL5CIkkK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2258333F8B8
	for <linux-pm@vger.kernel.org>; Tue, 10 Feb 2026 09:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770716278; cv=pass; b=guOGu77hSXVwv65Q+N+d65gJctoOBSZ3F1IR05qbIEM+XrtKMg3oMZgm0UfYjmohLYf6QIuiI4TqiG0m5XdmL7vCV4PmwAE9KbBAP23QmL91nNY4r4HXXtqTVmw9JAC7s6p6kLgos0rDLBIZ0SfigfV7S09cFo4XCAfvqP32m0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770716278; c=relaxed/simple;
	bh=7DIMjFeeo3eAla/lQXJGSagwHaW1sDqxPorzkJ5QBmY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FlpaudkbFGcwxBwU5YsR/3mD+Zi9CgtUixs8wg4JjwGcokZkzIHEandK0GeG8tEVk7Q1wZfS3cxKt5VtGMFSid4gJaTlmKxiLncu/vWQii/arROa3PnpKJpnEO7MLZ8GsmYvr3uSGP66rjWN//7zDtdPUuxBwGqxqW71o6eqdxM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CL5CIkkK; arc=pass smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43638a3330dso2122513f8f.0
        for <linux-pm@vger.kernel.org>; Tue, 10 Feb 2026 01:37:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770716274; cv=none;
        d=google.com; s=arc-20240605;
        b=LUlaYqx1SbHySfpAthlMjScq0LqDeXIuYQ4A1VIgdvY6h4isWUmNnL5zbNAOSvsyb8
         RIDLflKmqLM6Vng3dcNvXRDYdMzBFQ3diQTRUz2k06/S+cnRZPA5dM/1HVvcCB+nh0/m
         2POqs7Mfuiq4iAAK6hwmy2sNrQfIpz5a8fmxtWBpVJEsDKx9wIW0ljbNeP607p4dBuR1
         booNNn0Fu9mkWyLnATeZVf1A5in6X2piPHorS9+EQm+34J8XZpGknlorfMRC5WCZ0W9x
         s4aTqyc0uoZlyq7KesSLmUCczefniKS/IAgiK8kkAxFjS6cX7db8u36LXhw1uoxmAzdk
         JQfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=u9Y37ln8xuGFDWitJXwAsleyIOk7cbpvtjoxWooyXWE=;
        fh=44nh/LD2kgH+9Liv9o3byrz28Sy3dMJU1rkcGKQxg7c=;
        b=g2p8kFkR+FierMsEZsz+ouL95PxEPWZ0IuRHW9YH9jOKYNGAHilPEiKMth3g6cuJLO
         vcuwlp0qUO0R+OhxiTIOE3OVTDC2T6aJ3fDLQX9qvIrZJpSvH2/8lwY66vRoJ/74V1bZ
         EA/AM6ICPzS1auS/e3hS1dXAPzbnS2z19Y6jk0YRRLjD25JeFCokZUCAUFHQkDkCnUEj
         MZv4FuZ2zOI9a8kpOudzX2alvJtL5aszMdZqUst6BOqlmy/cMgcIvGCG2bbnTWEzpfxV
         k/M3oNcJuPO32fCOAQ/09VYVAYZenl01ov4MXkvPYsQc47aVb4TTXZvCWiKcYFVwIq7z
         7F4A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770716274; x=1771321074; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u9Y37ln8xuGFDWitJXwAsleyIOk7cbpvtjoxWooyXWE=;
        b=CL5CIkkK5e2UxEC7ncV9OTJi2bZl+QdhePyt+67TuSigo1gDjCyMbV7q9S3UPR9/3K
         55KqN1UTcCBw8Fg+3njGkLNfZTuWEhfQVmkeyOaXOwdMlop7uV1/SpA5I9u2KQV0CChN
         wb1QOKo6OO6hpbkrETmxdRE0W3jd7Xe/kTpUA3pQuG0R3CMma4UJXUo512OYyOcl/rV7
         m317H8PGsd+So0hcIwnESjlK2yRB3idQYtx3+ntJ77oHK3hvWIlZJPlviimoIHNLSJTr
         qj3vkqD0Cirj/mvNz8tOSpkpuGaEFef7snlEMPmUaXuCtv94eWS64RcBZyIn0L2/+eld
         Eyxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770716274; x=1771321074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u9Y37ln8xuGFDWitJXwAsleyIOk7cbpvtjoxWooyXWE=;
        b=bRIdWwAJrSNM+r3AMVEgK1aVfqstoWokAG65Rw9U88BNI7eABgIlgQSs7ubeBC33xh
         JhmKHyhxwLJ/3omwCJDADneX5PUW+uZ0Ug65F3QzbhUpphClhET0iaFwL30N2hiM3KHO
         M3Ei+A2zF0eOtrHHibI5DN4lGQV6Aq7mYSZz3rAptOqs6g3qv8rk9bOFXPJNw0ArsZir
         zY0yS3DefHJS5xdepzHy1a3NIU8unsBueYVC3hzRj3Qhr02fVEfSm0jLvPOXfPXHKeed
         cIPdJp8sEho6kzqrAZqtvyQ8ZpJr2ELh99WlbwlAEz5fnc9JhdAKlMFvDvUhjVu/NmNB
         4wvw==
X-Forwarded-Encrypted: i=1; AJvYcCW1+RFNfX3rKGNqpsMg3ufiYH6TBNa0S1CXn7A83fA0HIVOR6VPARygWOkpl7q+0+I61NftZtV8Qw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8D7D0Idx6xPqixxrNIgTnGa3JmVzw5tHzLzkCFnTs76A4tdsP
	4vEAshx1c1OP8FMhlcdxITsO43HzKzglyD8lUd7Cks9rc2mDYhXixmL82B/xNcHSEOpn4KrlER4
	jTGIHFG2oSJBm5MTJa1ppf5WRh2/0RV8=
X-Gm-Gg: AZuq6aJkSG2CTR7z3Miaw61MUdxPemctbKgA1gIenU49bLl5Q7LYCqelqzAIdQLvwSJ
	hIdNbElnWdJB0+FzZEmE37m4Iu81lfUH8Hih+lX6Yepq4JjMvo62/Nv02mKpasqOMUdqWmPoGuN
	kUPfkvmbO/ASj26lqWxfAgxDJ4V6HTqcW4p6+jAsBQt5grp/M+UrvASMvLe/byStz151xYMlSz2
	wTccgV8cukhocII82B34Gxe/AnNWlZg7zGej/Rvz7AercIynRAukFAjtX9eeqthuVa0+nx1mRnO
	gt+1MFurxpNDZ7Y9ES4=
X-Received: by 2002:a5d:5f88:0:b0:435:8e14:9877 with SMTP id
 ffacd0b85a97d-436293b11bcmr21266056f8f.60.1770716274221; Tue, 10 Feb 2026
 01:37:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260209104407.116426-1-clamor95@gmail.com> <20260209104407.116426-4-clamor95@gmail.com>
 <20260210-sexy-grumpy-sambar-44edd2@quoll>
In-Reply-To: <20260210-sexy-grumpy-sambar-44edd2@quoll>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 10 Feb 2026 11:37:42 +0200
X-Gm-Features: AZwV_QgL826wb_3IChyEYnKxPyG1ZElirm7op-wvlPZ1EK88mg4sg0InNYKSJlk
Message-ID: <CAPVz0n3fizf=r58Fr4YQ6pnjHq5p-7yFz95obss6w6x0bfgnDg@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42421-lists,linux-pm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,devicetree.org:url,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 0C275118F68
X-Rspamd-Action: no action

=D0=B2=D1=82, 10 =D0=BB=D1=8E=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 11:22 Krzy=
sztof Kozlowski <krzk@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Mon, Feb 09, 2026 at 12:44:01PM +0200, Svyatoslav Ryhel wrote:
> > Document embedded controller used in ASUS Transformer device series.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  .../devicetree/bindings/mfd/asus,ec.yaml      | 152 ++++++++++++++++++
> >  1 file changed, 152 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mfd/asus,ec.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/mfd/asus,ec.yaml b/Docum=
entation/devicetree/bindings/mfd/asus,ec.yaml
> > new file mode 100644
> > index 000000000000..1d1a62761b71
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mfd/asus,ec.yaml
>
> EC do not go to MFD, but to dedicated directory (there is such).
>

Noted

> > @@ -0,0 +1,152 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/mfd/asus,ec.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: ASUS Transformer's Embedded Controller
> > +
> > +description:
> > +  Several Nuvoton based Embedded Controller attached to an I2C bus,
> > +  running a custom ASUS firmware, specific to the Asus Transformer
> > +  device series.
> > +
> > +maintainers:
> > +  - Svyatoslav Ryhel <clamor95@gmail.com>
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
>
> Drop oneOf
>

Noted

> > +      - enum:
> > +          - asus,ec-pad  # Pad part of Asus Transformer
> > +          - asus,ec-dock # Dock part of Asus Transformer
>
>
> Compatibles are way too generic. "ec" basically means you document all
> Asus EC, which is for sure not true. You need specific compatible for
> this specific model.
>

Asus were not so generous to provide more specific data, they call
there controllers asusdec and asusped in their sources.

> Missing blank line.
>

noted

> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  request-gpio:
>
> gpio is deprecated. gpios, look at any other binding.
>

noted

> > +    maxItems: 1
> > +
> > +  asus,dockram:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description: I2C device used to access power related functions.
> > +
> > +  asus,clear-factory-mode:
> > +    type: boolean
> > +    description: clear Factory Mode bit in EC control register
>
> Why would this be a static/fixed property over lifecycle of all devices?
>

Specify pls.

> > +
> > +  battery:
> > +    type: object
> > +    $ref: /schemas/power/supply/power-supply.yaml
> > +    unevaluatedProperties: false
> > +
> > +    properties:
> > +      compatible:
> > +        const: asus,ec-battery
> > +
> > +    required:
> > +      - compatible
> > +
> > +  charger:
> > +    type: object
> > +    $ref: /schemas/power/supply/power-supply.yaml
> > +    additionalProperties: false
> > +
> > +    properties:
> > +      compatible:
> > +        const: asus,ec-charger
> > +
> > +      monitored-battery: true
> > +
> > +    required:
> > +      - compatible
> > +
> > +  keyboard-ext:
> > +    type: object
> > +    description: top row of multimedia keys
> > +    additionalProperties: false
> > +
> > +    properties:
> > +      compatible:
> > +        const: asus,ec-keys
> > +
> > +    required:
> > +      - compatible
> > +
> > +  led:
> > +    type: object
> > +    additionalProperties: false
> > +
> > +    properties:
> > +      compatible:
> > +        const: asus,ec-led
> > +
> > +    required:
> > +      - compatible
> > +
> > +  serio:
>
> All of these children are pointless - no resources. Drop all of them,
> it's btw explicitly documented rule in writing bindings.
>

They are all needed to be able to disable them individually from the
device tree if needed.

> Best regards,
> Krzysztof
>

