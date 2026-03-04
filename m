Return-Path: <linux-pm+bounces-43564-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6FTtNFP9p2mlnAAAu9opvQ
	(envelope-from <linux-pm+bounces-43564-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 10:37:23 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B6A1FDB69
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 10:37:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D053730AD480
	for <lists+linux-pm@lfdr.de>; Wed,  4 Mar 2026 09:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7B738737B;
	Wed,  4 Mar 2026 09:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="83aNDBSu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C5E3822BE
	for <linux-pm@vger.kernel.org>; Wed,  4 Mar 2026 09:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772616876; cv=pass; b=m9rtCwAbzFMZ/MrqExanIbBvklxUf3wFZDE3ZbEIQExyW5BjxDVtpZm0hmx0HmeUMRzs2CGgCOpW4BLHkHWS7SqFCjx2HA/MVE9p3GB39WxBaYpOz87XNhjwWiOQWJvsXww08MS9kkpbOA13LNWAb4ZuX6zx9E195L1MvPnXtkU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772616876; c=relaxed/simple;
	bh=3r5U46JYIUoR2bl5Gkm/sJyECPpQWiCpRw6+O/Z2HYU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T0ivKKVXqbdhhINmHJ79HY2CT7Jbg5XehzsZ0kEMenUvzvunrXMoC8bHLNGH7iOHL2hKSy3jRR3g/I4vuF7+YMnIvquj3C67ORrrNLERTcerSz0zgwOXECth8GA8q8kVnyIKpc6E8vTFPiUqm4cQXDjgYPBcA/g34R3OIBl0cFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=83aNDBSu; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b8fa449e618so955940866b.0
        for <linux-pm@vger.kernel.org>; Wed, 04 Mar 2026 01:34:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772616873; cv=none;
        d=google.com; s=arc-20240605;
        b=QFRdvMSKTo0T86Zs6d7LdGltlZzWRRS8Xff4i2heye2ykhYGpSaY8Dyw6ooWIgrohU
         BZoQoz1cQyGV2LjwLnXZ8AT7W0bH31Mtku4RoT27gTNUlZ0/U0MhNAchFZgQ7QUKgIc1
         9EjeuPCkX5RJfm9pNrJSovs78ToUx2pFu4Zr9gMUcjhTF15lZWdpqbud32DDKfssv0Hh
         5ot6n/cbyIb8m5e5TAs+z/dpRJAaYBQSkibMj6JvVUNcEZZu9pXOxbp8AVRIAiYUKrLW
         DJ7iqwtcNUG1zgxkaX4xmU7ve2wGNCAoQjDhoI7WcwE9uaYObSeBpGP2/PQZr5FxFUu6
         +SwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5AUBDCy7nbW9VUhgHwbf6uyAyDJf03F0fUhfohAeZuA=;
        fh=uyM2tVOrw+ovRRys+rcHYdK18SPOJPMCtUzLh1Ad4j4=;
        b=MPEEA87H3eGEcuB3+A6RnewxlQ4qAKTXLB1PGWI0PNRFzxZiRVsoWeV4HdHpLAekPv
         sBn/yGFyFtb1AF1fbmGpZqMspQbNUvkOs/E+TwMZ/DnI88wgmPxUgWvSSFfddMJZcccS
         gW4JvHumFoZ1wUp60GwwPNdO90xwMSYs5aSC8ky8X602tzkiBvJHtfg3TUPf4OGFpFUE
         zjnQ5QlQ0N2mZ1Q2g4BA0L4GtySoLMB5rF4FAYUno4fKcEa8vq4pTt8lAFOtfnJoD1CT
         GNaEggmbl9SYR1qjmSZ+wdzjncrU0FPT5pgF8rNyizFqE0p47Qw9c7VHQ/D5e26UUTvG
         3xbg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1772616873; x=1773221673; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5AUBDCy7nbW9VUhgHwbf6uyAyDJf03F0fUhfohAeZuA=;
        b=83aNDBSu9p1AiqJW29lno3L/eA106DLRr4mK6WXX8ttYt53rylLt54CU3a6Qe6G1hL
         1FGGoTe7u75IpGTEKBGiIwg6PlEHfEgO3K8nxKdjCAqoYoZpawpxPDV9/QMSL+o5RMaa
         6MgKn3Jcx11lL1yjaCk++c+6TwqyCT/RmsX4V7Ycsq7ArrhcwEGK30zCIPaLNCMKiF7A
         tvxndWPyTiIT4mOoOH9aWHDAZjf6Ga0uRdyLU99PaWA1uc5tsfZ3YzkZIXw9evGHzvYX
         KoDqE23/+SLKNJKnbttbdl71H87Lofo/4zgan0b2kJ6J23lfzId/wGlk59HGjd/DrHI+
         USuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772616873; x=1773221673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5AUBDCy7nbW9VUhgHwbf6uyAyDJf03F0fUhfohAeZuA=;
        b=NJ3Lq6nYhh8ezkz/0jE+4C/Gp7b8e/1HuFTh6LESl6V8wM8NzyILEYX/ycb2GD2ZAN
         Kh998jDiJslFqwQwa+L4fRNdaYfcpgIH7/W3JGfAZIuk194z5zLyfpnSP8GPLxt8sPdp
         mLFLlW6TT7s5XIqfzz83m8uShn5BIzCadTkY1RSvq0Y7QvYl/Ol02rqRL5rZI+863Ipa
         MyyHwpfqI7e4UycypbsV/M9Mt2lSanhIysNnH5BgqosHXQVetdu7h14WA+uSCwt0Rc5v
         C21tHkOjz4Q6QxsJ5U4hC1qYBYcpk9BslyXKL2+QmtKbvL/I8ujWbC2psfISAavtRWoZ
         IDRg==
X-Forwarded-Encrypted: i=1; AJvYcCWZwhLhiqtzJbSLfom/9kOc49VPQRn+v3WLixXsK0WnbGubDj8I2uemElae/4cXgq5OM7P1uJQCPQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyHmF/PrDDQHW9fFhILsfDW1rLwENiJjxFNy/VHR8Q5vsGOjz9f
	0rXEq+St7OZZa1d1ousTvyD6UxZMmkHVY60oM6gVaRgdZvE+XrZlKpH8YbBYhFM+dj2ilv67l2R
	e6cSVdNYyqE3xwhS4oBjtln8TB7kHkjJrVFogVhfXxQ==
X-Gm-Gg: ATEYQzx9njT8tzV8OKZ9sH8W3ww+8qqg4oMrxZw1xePHA19NRl0JcklbX/fKTyK+bBC
	hG2L/m3m+fQZOh7p8pho9ip7AtvErXnrDXRXDDWaKxeMA6962hg9IPsQydSHesI33UFzkHYO3lh
	lZBDpDdayNV/Awo4dkNJ+Yc6LYqx+6KDtSFNSrd8z+1XHijXTpcdD7mEVyZRPiVW3wZeO/s2Jke
	3xxgyDQe9hWH4sYJSsebmIAU+0euZFV5xZ11CYBqQmA7aKyZYpt9bMrRCb/lnDD1zFybFW0N3f+
	a/0myA==
X-Received: by 2002:a17:907:980e:b0:b73:572d:3b07 with SMTP id
 a640c23a62f3a-b93f13f0948mr72180366b.28.1772616873304; Wed, 04 Mar 2026
 01:34:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260303-bq25792-v1-0-e6e5e0033458@flipper.net>
 <20260303-bq25792-v1-1-e6e5e0033458@flipper.net> <177255519061.3485716.8870568133764595988.robh@kernel.org>
In-Reply-To: <177255519061.3485716.8870568133764595988.robh@kernel.org>
From: Alexey Charkov <alchark@flipper.net>
Date: Wed, 4 Mar 2026 13:34:25 +0400
X-Gm-Features: AaiRm51Enl5LcXd6PAPQAWRhQIDDudWLZr4mU0k-EhYOjS9Inm3uW-TiPcT-vUI
Message-ID: <CAKTNdwGyrBihrL2hQgxZ7pyaYoRGTnNibLGnhKWEi-DsJn3==g@mail.gmail.com>
Subject: Re: [PATCH 01/11] dt-bindings: mfd: ti,bq25703a: Expand to include BQ25792
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Chris Morgan <macromorgan@hotmail.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Sebastian Reichel <sebastian.reichel@collabora.com>, 
	Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	Mark Brown <broonie@kernel.org>, Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 36B6A1FDB69
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
	TAGGED_FROM(0.00)[bounces-43564-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[kernel.org,hotmail.com,gmail.com,collabora.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alchark@flipper.net,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[flipper.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,flipper.net:dkim,flipper.net:email]
X-Rspamd-Action: no action

On Tue, Mar 3, 2026 at 8:26=E2=80=AFPM Rob Herring (Arm) <robh@kernel.org> =
wrote:
>
>
> On Tue, 03 Mar 2026 19:32:46 +0400, Alexey Charkov wrote:
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
>
> My bot found errors running 'make dt_binding_check' on your patch:
>
> yamllint warnings/errors:
>
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/m=
fd/ti,bq25703a.yaml: ignoring, error in schema: properties: allOf
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/m=
fd/ti,bq25703a.yaml: properties: 'allOf' should not be valid under {'$ref':=
 '#/definitions/json-schema-prop-names'}
>         hint: A json-schema keyword was found instead of a DT property na=
me.

Thanks bot, fixed in v2 along with further comments from Krzysztof.
Will wait for any further feedback and send out.

Best regards,
Alexey

