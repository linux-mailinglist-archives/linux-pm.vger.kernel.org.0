Return-Path: <linux-pm+bounces-43545-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YugxFxDzp2nImwAAu9opvQ
	(envelope-from <linux-pm+bounces-43545-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 09:53:36 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB551FCF86
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 09:53:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A6AFE3019E22
	for <lists+linux-pm@lfdr.de>; Wed,  4 Mar 2026 08:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431683822AC;
	Wed,  4 Mar 2026 08:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="RGvVfkki"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2DC375F6B
	for <linux-pm@vger.kernel.org>; Wed,  4 Mar 2026 08:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772614241; cv=pass; b=Uj7TFLxOBAZEw0HEj6wVe38yBlkYfAlAefyzzIr0YV/DlelFuDVT+plFqEFGsnQSJzRXX9raEN7hI77l7lEagVnU3MNCYWBs8tuFI+fnbsyeF1bqfdtxVsEi+x8peW5Q7M6c//+y9Ew5qFALXl+PyXyAwLy2vzOGywNvC5IHFYI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772614241; c=relaxed/simple;
	bh=EdTX5TuFkhXSLCBtncSiU2M1P0S7h1stnKyzhL2JZZk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dPzDuoftAWbMR31u/yi463fxX8MMn607zUrmGNARBsOKaCSELZWOM5tTjDpfNT5LAIqZNIwgDhlJ4jnMnkQ1eqAx6RE6Q1/SP4nypOXC56gk2vdbvR+EUUBtQgY16X4i/y/9pH5ckkQwDeezAGWO3BkDPW1i+8aDQnmrMG15R4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=RGvVfkki; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-65f767a8d62so11267186a12.2
        for <linux-pm@vger.kernel.org>; Wed, 04 Mar 2026 00:50:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772614238; cv=none;
        d=google.com; s=arc-20240605;
        b=O5YFaSBqghxAelQC3qKkammRPLdsHI+6v58HfhpVFv1ID91eAx9qTx2IiHTPc//N+g
         nvgBdMSgoo8AB14yznkQszsG2sYqHOCy04I6StgQc+pNkb7OOOSo1P87gzUMajNFcnZQ
         IsGdNDj49kkzlCQXIvyUHFwp58ArbGrsqMX+jm4vTLytnkZachH5px9OS2AxbRpQguk+
         Sw4FfqwpDFSOp81Ldr+CMkyUtlbhRro5foJd/uoy1kGVtI2rLJNw8fZVJLV3AlLlPuuH
         R209fZrXzci6X98DYfpVjlDU6Z7JPaDlTxVJQS2bPlsne94lP+tPMibFtwJ8ir0vMD42
         MCXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=O1AyqKB6U6McXYmXYuZ647o1s2nu0DxWk44GRlK2N3g=;
        fh=O1x3+lwA5h+RjehQsuoYCSz6ChZHCMFqQxapGYvCqIs=;
        b=lBx4zJ+6/dBaZIGIeFiqoeBxDhGWUQiLRc459xGoTmhtomxfxlsiHJC65jkWzib7bp
         UfqhOFQ8BHV+HRpIYFdny3WjarlirD8LNpbIIu9l0hxPvy/qoxKLyDP89PaxCrv5tF7J
         k8zy+kPKJfP5mXqPeyC8n1IO8/mUN4FcM4MXyPWUtyUgqCpPfKt8PY6u8FsS8W3/Dfwg
         WKWEomfEV3YP2/I9USVonLaOX2QitWD0ci2D/GVmfBpW+KEMKog5oAmQskDLdEKwvcdA
         1UVxB3AE4ilGzCFtGgswI41IGfeVcnkEZ9EhDTImR08SwCS5xq+u0/vwcgME7HbH2CBX
         0rlA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1772614238; x=1773219038; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O1AyqKB6U6McXYmXYuZ647o1s2nu0DxWk44GRlK2N3g=;
        b=RGvVfkkiXTHtAX6fOTZ+TKuamVKvdyEY9NPlfagSKRJKtt7MNYsRytzvTs79hEV49l
         tdD4QPg7m5pIDboqtfHAWw6AAv0oe3N3/ZDKGJt1Hnn/vCdnFAP/Ir/Fl8p95GNk496i
         KMWU+3GFqqlXEr8eJcrJ7mV5X8v0UmGx6dDH9VlDyewICXq1N+tOUKPpdWrmaf4YEIlu
         TuywfFkIOdubdS8Xxx/CeeZkuirpZrkHd7TuAT/KyaNpfQoVgNEfj/LQ9eePvaiZkRIF
         UGl/+KxSu0+gi7piDo63K2DYvnX2Hn0Gv8S9ctor2LMNaDQdDjPjkU4YkJfCtqrAh8Ft
         MoLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772614238; x=1773219038;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O1AyqKB6U6McXYmXYuZ647o1s2nu0DxWk44GRlK2N3g=;
        b=PEcEc9WF54huA+LGKMlJ3r3C9kuwE/N5sUqgbz5gqnseU0PQsnTIEcOhqXWKOzHNLh
         VvDZwQrxcDz2+LdL0LuOhE4wTzgU8ugJAIUsPWENQG2KCRtoo8sY6pj5eVFcHpfwozv/
         vX7+eE6NccR61zHJ8lonJu38aQ90XtZ8VRzAePvi5uebzKrzsJ+oOc5PuUlf7CR0HjYX
         He5NaclNEpj6VYUD23n/Sq1wMfzU253XvJEC97Ecein13WdkOqb9tLwHd86/xi135Mlw
         KdhhFh+Aid5J/cgB5+/oSMOeTzhgHT44yKrE1tRp3ZHw2pxoUAjE2+HawmH4X42L3aVC
         O5yg==
X-Forwarded-Encrypted: i=1; AJvYcCUxqYRQOUqRA1CoNdxV41bUHQMeY1OK+nxpfapyehbzl/zKrdmnISs1E935uMdMSbWYQHdw7boyug==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyvu5hkpUgQUEwfA66GgOse9RQIFIibrPUMtER4tDKmAsC5mSVD
	2TyoF43B5Ns8EaGdjyFj8W5JAQzlIip5UkiRyYCRRl9wsnZQiEo+76HPsQKILs5FIJlB9ASWfDU
	4BnSeuoWsHVZf9v/U2SHl41XJ+/y4Xs2qrUTzShtwwg==
X-Gm-Gg: ATEYQzwbFLxlMN+muJgew3HH4RrLkK3/Mz7leKIh56DT/hpQ+/DXCRwgUGJPwoSkFRu
	NOhifaFDlP9RLNejAMQWMjBtD+pJ6EYUNzUbiqowfZEbaW3h8aHdZjw1K3TUNJGRb0V7F7wQerf
	LD9A3/jlWAdLLpIZ410fhsyL1CRpdkCDrhAqK1kOvU9XkzaWoNENsMX0g+NtGg6R+VvxNbA57wJ
	thxToj3dWDnbFib3bE1c3hEj9fhgmyzUvAy96iOyYI4IluyN6GRMoLyuJIMXAZTs+OFYrgswXQD
	0royoQ==
X-Received: by 2002:a17:907:7b85:b0:b88:463e:b55f with SMTP id
 a640c23a62f3a-b93f11bbd56mr69256566b.6.1772614237849; Wed, 04 Mar 2026
 00:50:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260303-bq25792-v1-0-e6e5e0033458@flipper.net>
 <20260303-bq25792-v1-1-e6e5e0033458@flipper.net> <20260304-groovy-vicugna-of-energy-5efecb@quoll>
In-Reply-To: <20260304-groovy-vicugna-of-energy-5efecb@quoll>
From: Alexey Charkov <alchark@flipper.net>
Date: Wed, 4 Mar 2026 12:50:29 +0400
X-Gm-Features: AaiRm52DkQrujue5wgFei9bhXWlzoKAvUUxkgfM-1xZHXNkM71m37ecne7FCS9I
Message-ID: <CAKTNdwHadbJj5yYOGp4GK=LfAMFvOqCSXzVgEEkdxhm6YY6gmg@mail.gmail.com>
Subject: Re: [PATCH 01/11] dt-bindings: mfd: ti,bq25703a: Expand to include BQ25792
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chris Morgan <macromorgan@hotmail.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Sebastian Reichel <sre@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Sebastian Reichel <sebastian.reichel@collabora.com>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 5DB551FCF86
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[flipper.net,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[flipper.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43545-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[kernel.org,hotmail.com,gmail.com,vger.kernel.org,collabora.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alchark@flipper.net,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[flipper.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[devicetree.org:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,flipper.net:dkim,flipper.net:email,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Wed, Mar 4, 2026 at 12:32=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On Tue, Mar 03, 2026 at 07:32:46PM +0400, Alexey Charkov wrote:
> > TI BQ25792 is similar in operation to BQ25703A, but has a different
> > register layout and different current/voltage capabilities.
> >
> > Expand the existing BQ25703A binding to include BQ25792, and move the
> > voltage and current limits into per-variant conditional statements.
> >
> > Signed-off-by: Alexey Charkov <alchark@flipper.net>
> > ---
> >  .../devicetree/bindings/mfd/ti,bq25703a.yaml       | 79 ++++++++++++++=
+++-----
> >  1 file changed, 62 insertions(+), 17 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/mfd/ti,bq25703a.yaml b/D=
ocumentation/devicetree/bindings/mfd/ti,bq25703a.yaml
> > index ba14663c9266..99b4fba7c1d4 100644
> > --- a/Documentation/devicetree/bindings/mfd/ti,bq25703a.yaml
> > +++ b/Documentation/devicetree/bindings/mfd/ti,bq25703a.yaml
> > @@ -4,7 +4,7 @@
> >  $id: http://devicetree.org/schemas/mfd/ti,bq25703a.yaml#
> >  $schema: http://devicetree.org/meta-schemas/core.yaml#
> >
> > -title: BQ25703A Charger Manager/Buck/Boost Converter
> > +title: BQ257xx Charger Manager/Buck/Boost Converter
> >
> >  maintainers:
> >    - Chris Morgan <macromorgan@hotmail.com>
> > @@ -14,7 +14,9 @@ allOf:
> >
> >  properties:
> >    compatible:
> > -    const: ti,bq25703a
> > +    enum:
> > +      - ti,bq25703a
> > +      - ti,bq25792
> >
> >    reg:
> >      const: 0x6b
> > @@ -23,9 +25,6 @@ properties:
> >      description:
> >        Maximum total input current allowed used for both charging and
> >        powering the device.
> > -    minimum: 50000
> > -    maximum: 6400000
> > -    default: 3250000
>
> Broadest constraints allways stay. See writing bindings and writing schem=
a.

Ack, will make the common part a superset of both variants' allowed
ranges. Thanks for pointing this out.

Best regards,
Alexey

