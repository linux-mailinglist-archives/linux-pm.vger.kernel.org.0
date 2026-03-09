Return-Path: <linux-pm+bounces-43929-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +PxeKel5rmm2FAIAu9opvQ
	(envelope-from <linux-pm+bounces-43929-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 09 Mar 2026 08:42:33 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA584234EC2
	for <lists+linux-pm@lfdr.de>; Mon, 09 Mar 2026 08:42:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1968B3055DF6
	for <lists+linux-pm@lfdr.de>; Mon,  9 Mar 2026 07:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA8B366DB7;
	Mon,  9 Mar 2026 07:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="MofstRi3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A42367F27
	for <linux-pm@vger.kernel.org>; Mon,  9 Mar 2026 07:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773041961; cv=pass; b=BrE2oF22UBiZAWM+GPgH9YX/+EX+6Vg9QITe+vBCDI4VuEikadi7aXNI6Tq53iXjG6asQQDtou/TVwsn2dijkgvt7cySMniCtrKn5YoklbwIRfsbeuZ3hzOI0ZWjirTVCAeXzPgfdzlZACw1aPO/PprveuI91epKTodQBJpZr90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773041961; c=relaxed/simple;
	bh=QeN6GpIdj1+GFkHjKmwA1WMLMo+3lnYFbA/ivhvcUqE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kqILLpASlHFb/QffcUAKdYIA7XdhJrXZViI00rFnImg1onyuWgU1fUgh3PBuqWlKwLA4h+AaRQwIeOCoVdHgi3391FYYFUp/o6nnllvOobE12am/FjyjZkHcmdax7KWJJgprEbFPfSRfDx0H75YxEfgxZYymTNFi/GWhv7edu+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=MofstRi3; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b966a7b1908so185850666b.1
        for <linux-pm@vger.kernel.org>; Mon, 09 Mar 2026 00:39:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773041958; cv=none;
        d=google.com; s=arc-20240605;
        b=X36H4R+E/XcEj3mZZsaF8NcL4kiWntcQ26JtO3yNAGfh/1/rAVBfGuGP84xF2+wo83
         Q0s6cGelOdq88whGLn/mU1GFw962U+Zv5kqyvz4slpVLMik1seg8QjpRufknbsa4SNYE
         Tt0lgiXqAAEiv+Tm/ow/23gk8H/vDs44y8iKsY8p7dYYUrOagQ6Tp/O6R5r10XGfii4j
         J+NtLV/lFUx4RAQIwqhA04dkyLmIadWtSvPZ94SCbrD25eXinUX8R6IaiBH6hWKEHeIP
         hhDBI9L2J9cU/nq/h9Nsg1a4Yo41tZvoP9MX2KPxGYVvWjSHzAJ3rPpYobkLpuigJiQd
         KYIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZZxQV4lJDzLHey1T0g/ZUdvj0+WObWIH2mF1XtFb9lI=;
        fh=7n7mH1mr6hIKrb14HODCFXOwhIj//OaLSzXEUmdXPqE=;
        b=dBYOZSp92S4zF/fagVPbSaRWK8hzZ4Q9EMG99sFa/TjAKeR3uZU46VYiaSWZf/D2ee
         sBXwvkPptPIcYTs0E5hYQTCiaMFZJibLUQdVZGT6EQS0op8KFDQEHdtfAjNZCqT3cXkZ
         GHEsVJjzZAsAooFvbiOu9+X+6qM5ojYIDFx+Ew6Wphb3vxRvGZo7MPwoHcLD9B7jm1CQ
         FYZOpoZn+QIwfdHOkP44NFTkutvh1lO38I62nugeUUwQ2aoNy1ViyUgV9qlMSop9gHgE
         g3pnX6uZnqpdcVULWFY6vboOkNo+1KTuOl4hUHuR6YOgzvKTon47XZkBdzLH0WKuyb5E
         Hc+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1773041958; x=1773646758; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZZxQV4lJDzLHey1T0g/ZUdvj0+WObWIH2mF1XtFb9lI=;
        b=MofstRi3xZEecv4sJ9DYgAjCDV6SD99KcdA8dHw8EITCPPImilk6deTafpyCk2Qp9k
         CvQUL6R4OV8BkD2/2mvtXz9KRARnIv76fzNvApPhtk1Y9coSvlAGmg85VD1mMEQO/Nyj
         EDOmzTZK3w0OX+gbRuz72PLzSjrvB8WmqE/2KodLotXV8cDh4vSng8gypK0MsZcTV0xo
         +WeWa6QxsYharQ6AYrc0CdAG5i9fcvNkDPvGcsT42cJJ7ZN72DlcTbmD2BTlYK5HINN5
         9l8o/WjHXmkNV9FHHgqsQ+Zn3tKnNcjjQ0n6EAp0DRT3NJ0s9Qy0ACz8EmkqlKSBLOW6
         v9Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773041958; x=1773646758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZZxQV4lJDzLHey1T0g/ZUdvj0+WObWIH2mF1XtFb9lI=;
        b=jC5J5q/wy5yDUu5dyfl1psNViGoaJFgiELX1CUnAX692S15cEPqkUqEOMGRTiGMkVA
         32JfatC9kOSQSE8QQIIORPcdPbwKsPbfoKPysiKm8f8PnaGGfvhwGzDNgOKdhfKnE0qB
         fI7pipaMCqCpQM6DAfzZ8Do4PCq3Ufiqi+M+peL4sa8xXcwfKyez9lls5e04i8ByAQH2
         Q5UakqA672fN48vfkfuryVsR8GQ3VvNXLq5aq9WoSrDxe8cpw1kQmj5gRfCjrFRjXi9Y
         m9fHNMD6Q3KtQPZ6vYwGdEo7TWklBBMiMwyQo5yhfVxvoLqlVevN6R+deyzpcnlSJbKd
         IrHw==
X-Forwarded-Encrypted: i=1; AJvYcCXQJpRLruOhHzlyCdRKqrFWotB+ftB0liqTyMv935MUSy8Mua+C7nk6u+c1TZH2aUG9t2dnIMX1XQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxVvukgH/Pg0PPNKdSFfZUOP686DutWl9KImqz7DXUJXSABtV2n
	HHaqrMI4hj2MDydhyHGC+CrXGTapk7MShO7raIV5WKWIUz+2EWgnJBt7B5rVE0D0HXZt6KIDkip
	e8tXF4Oq4hD8TJDpMWSexzE2UliDBHOh9+SslbMntMg==
X-Gm-Gg: ATEYQzycq+xpIyWVrpjDuKMrC0qrb1sOC8NPbcvfHLK2Ug8sb78K3cH50+mxdqAX3re
	RQhtqkELuJEPeBY878ryXp1jFThKbBfeliF8UmGhPYrYcZXfS6t6lAzM/9Gq/6t4zvJL/UEzSmM
	Y3sHAYCOtsC00irxg2OBr3lvaLJeioVat9kq1oeY4TTNwp6ZmqDL1p2i29NGFrEcWSMI+ShzLju
	l3UEQ2O4xWKjPezwuMBYdbJuQMLolW5dv3Blu/qeObnofpOyIkfdE/fdAI0NFkwYYh+Cdo8LH5/
	jxXOevnFdUHKZg3BXg==
X-Received: by 2002:a17:906:9f88:b0:b93:722b:f7c5 with SMTP id
 a640c23a62f3a-b942df7eb6cmr627858666b.29.1773041958288; Mon, 09 Mar 2026
 00:39:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260303-bq25792-v1-0-e6e5e0033458@flipper.net>
 <20260303-bq25792-v1-9-e6e5e0033458@flipper.net> <20260306141541.GP183676@google.com>
In-Reply-To: <20260306141541.GP183676@google.com>
From: Alexey Charkov <alchark@flipper.net>
Date: Mon, 9 Mar 2026 11:39:10 +0400
X-Gm-Features: AaiRm5104XhGOW-J_13frBQZh5T5BSocJtleW8XWylE3jcKvvEUsQUPIIi1o86U
Message-ID: <CAKTNdwHq=XQmTwVwU6U0q4uqTx5dXd+0ET1EizQOVR8izo6FRA@mail.gmail.com>
Subject: Re: [PATCH 09/11] mfd: bq257xx: Add BQ25792 support
To: Lee Jones <lee@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Chris Morgan <macromorgan@hotmail.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Sebastian Reichel <sre@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sebastian Reichel <sebastian.reichel@collabora.com>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: EA584234EC2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[flipper.net,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[flipper.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43929-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[kernel.org,hotmail.com,gmail.com,vger.kernel.org,collabora.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alchark@flipper.net,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[flipper.net:+];
	NEURAL_HAM(-0.00)[-0.991];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Fri, Mar 6, 2026 at 6:15=E2=80=AFPM Lee Jones <lee@kernel.org> wrote:
>
> On Tue, 03 Mar 2026, Alexey Charkov wrote:
>
> > Add register definitions and a new 'type' enum to be passed in MFD
> > platform data to support the BQ25792, which is a newer variant of the
> > BQ257xx family.
> >
> > BQ25792 shares similar logic of operation with the already supported
> > BQ25703A but has a completely different register map and different
> > electrical constraints.
> >
> > Signed-off-by: Alexey Charkov <alchark@flipper.net>
> > ---
> >  drivers/mfd/bq257xx.c       |  60 ++++++-
> >  include/linux/mfd/bq257xx.h | 417 ++++++++++++++++++++++++++++++++++++=
++++++++
> >  2 files changed, 472 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/mfd/bq257xx.c b/drivers/mfd/bq257xx.c
> > index e9d49dac0a16..a6776c8c94f2 100644
> > --- a/drivers/mfd/bq257xx.c
> > +++ b/drivers/mfd/bq257xx.c

[...]

> >  static int bq257xx_probe(struct i2c_client *client)
> >  {
> > +     const struct bq257xx_match_data *md =3D device_get_match_data(&cl=
ient->dev);
> > +     const struct mfd_cell cells[] =3D {
> > +             MFD_CELL_BASIC("bq257xx-regulator", NULL, &md->plat, size=
of(md->plat), 0),
> > +             MFD_CELL_BASIC("bq257xx-charger", NULL, &md->plat, sizeof=
(md->plat), 0),
>
> Please keep these out of the functions.
>
> IOW, please put them back where you found them.

Thanks Lee, will address in v3.

Out of curiosity, are there lifecycle implications here, or is it more
of a convention to keep them out of functions? I've been thinking
that, given they are only accessed during the initial probe, it would
be neat to keep them const and initialize once, when the matched
variant is known. It works in my testing, but I can't vouch I've put
it through every possible corner case, especially various
built-in/module combinations or probe deferrals.

Best regards,
Alexey

