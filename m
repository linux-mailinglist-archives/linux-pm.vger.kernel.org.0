Return-Path: <linux-pm+bounces-36894-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BAD4C0D3D5
	for <lists+linux-pm@lfdr.de>; Mon, 27 Oct 2025 12:48:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4DFBA4F70E3
	for <lists+linux-pm@lfdr.de>; Mon, 27 Oct 2025 11:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED712580ED;
	Mon, 27 Oct 2025 11:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ODS30pIt"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2A72FE04C
	for <linux-pm@vger.kernel.org>; Mon, 27 Oct 2025 11:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761565514; cv=none; b=CZxfEfuqCAWYBPdPaozhfqpOfmb+s8xjEcRtjJIlrn9Auau4y4jUQMOFdjSiA2IUCo6oDaqf8mxhEE9dDb1RC2UxaeifRJP4X3MKxKdFfuoFrOLWKAZjLLHWk9HFsdFeblIUbbyX9Ffj2T3v4Tdec+yLJ2cxbjBrVZiR3Wh4qoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761565514; c=relaxed/simple;
	bh=IjpBU42ntX9XaYmyRucOHQzBqWEweHkDi9vYXmN8LMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UP9WhkAGt6ahWTyh4SQ58sl0L2D0pejsoxQejSl9qkOi0aMbl16igfvb54qdOU/awG/NWSO9pUBvYvyXlyfagob5wVTUs9E9mXL2QARpzD5KV+bl8Jx9l/xw/HgtIQoKu8IcybH49P5E8Qb+VVj8qf0t5dDo1pJlwVw2QQbe5Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ODS30pIt; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-3737d09d123so64342051fa.2
        for <linux-pm@vger.kernel.org>; Mon, 27 Oct 2025 04:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761565510; x=1762170310; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U3bvBuQH05UYV7qQeFG6dlKCPrhvCySjKkIncy7Gx44=;
        b=ODS30pItJia4v+EkFJTKwrB+i3DItT+o2TLpFP3zZnYPf30k+e3X/2CFVI3LZPYyMt
         /A3bOyjc+akTrbysEXVFYcA3GtLMHmOoCJfM/a65nt4ywNaerdGGp7ig883OMS7C+Rhw
         QTODaKXbrQhd9TQAhM/W0e4CJsp9wR2V7eHqemIgavolDfE54e43gllAbJ8UfIeis93x
         sTQGtT3tgwYUXWeYarCaWM6ZpfJ/Mjgv4jDsdDHvcntuB09SG2FdKVhnHVeswuhVyQOq
         SXxsSy5BwY5kw/DX1PNL/b/tJHKFWMYWPgwYMpI//dqEkWZkM3pzEe2QOam+okXFSWnf
         eYNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761565510; x=1762170310;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U3bvBuQH05UYV7qQeFG6dlKCPrhvCySjKkIncy7Gx44=;
        b=xOdlscg66DuMOErIu1m3S8bWkB67qeqR8TF6b8XiMACe7LlOC9ieuTyypt9UuiZPhe
         if4kTIz2sN46zGKAK/5olfGJa4TEuQ/QxWgyWIbnc5CAEDQdFjXGOE4aT1MiHoFOsBHn
         YoBdBJ+w2ctL6/X68FMSBvrmkbn1ah9BBIu/Po+PzQZo3upLx5SbGVHW1HPQoBbtIJMa
         0qNipA1OkwCm6CwsbPmobZav46/Ra2gPCuDNL1uMp0WkbI8+RYFcY4sibRbpIqsGyPW7
         EMYeT5fDBPbTq3uIp/1i6StP8BLxS6XT3SzHSlSmhfymNl3mTHjEHhzgdokG86hfUJSz
         P2ww==
X-Forwarded-Encrypted: i=1; AJvYcCW6IR/kC9lk6e+wRtff66Zx0t8tobR9BZfyJ7iv8Am8neRU6xFOaD8Q2BKO3ufEuzZd7rRnrE77Qw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5KnzqONnxdBa0Xb/JqshdIsJuFAzVs0mQJEj/hwBP3iz0kowy
	K9rc1gbZLxEDgXmMrgoV8DKiAMjEfWDaZ2/pnD1J/BY2F4Qa1or8VGt2
X-Gm-Gg: ASbGncuPzg9R42S8tjY3eD/CFKkRDmNBaYGJvIm9EwaIwta7flA0T2YxhcYLgHI3Zzm
	6vTdnwi4NQR3ioeCsf4nnSY+/v8wdLOXgB+ldbP17kYqwQWOB6t2W3aCVtcP+SefwjGRe3/+DXh
	hoErJGzKQlFtJG6xZscDnmiyOLjbdhSX9zxEeCaivudnPL9JqBKwSQaH/sFYiF08am5APdHrw3Z
	fKGTugkfLbULbvHvEXQbknGaozpJBMsIPCmkIuqSGhjWKGwyOo1csJChjYT8KDL2pyZH/4nPyEA
	QM9KVgs5yCM80oKxhQsDeXuL3cTyx7MbulHRaKvJ+lvpZ2BnP6fi/tvUiZlg9/eAE2syZIdHdzY
	5cmfG5r3BQKdpkttBM9LYy+1cV04WscNazMPnI2Ftwicc+FcrXtlhBc3UqwHJYPlwMcARzNJfpk
	wtyw3FYTc=
X-Google-Smtp-Source: AGHT+IG040q7cqWV71VuTHnX5coaOHS5RsTVRj/7BqmGOTBNKnaNhaPjcm0wBLEa4smz5wwn4wiKuQ==
X-Received: by 2002:a05:6512:4022:b0:592:f5a4:ece6 with SMTP id 2adb3069b0e04-592f5a4f458mr5888071e87.14.1761565510170;
        Mon, 27 Oct 2025 04:45:10 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59301f5fc75sm2207808e87.59.2025.10.27.04.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 04:45:09 -0700 (PDT)
Date: Mon, 27 Oct 2025 13:45:05 +0200
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andreas Kemnade <andreas@kemnade.info>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-rtc@vger.kernel.org
Subject: [PATCH v2 02/15] dt-bindings: Add trickle-charge upper limit
Message-ID: <b13b733e7e0fba05652f49f727412fed9e0ceb02.1761564043.git.mazziesaccount@gmail.com>
References: <cover.1761564043.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0aGnDoHzYmHLbrXY"
Content-Disposition: inline
In-Reply-To: <cover.1761564043.git.mazziesaccount@gmail.com>


--0aGnDoHzYmHLbrXY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Some of the chargers for lithium-ion batteries use a trickle-charging as
a first charging phase for very empty batteries, to "wake-up" the battery.
Trickle-charging is a low current, constant current phase. After the
voltage of the very empty battery has reached an upper limit for
trickle charging, the pre-charge phase is started with a higher current.

Allow defining the upper limit for trickle charging voltage, after which
the charging should be changed to the pre-charging.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

---
Revision history:
 RFCv1 =3D>:
 - No changes
---
 Documentation/devicetree/bindings/power/supply/battery.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/battery.yaml b/=
Documentation/devicetree/bindings/power/supply/battery.yaml
index 491488e7b970..66bed24b3dee 100644
--- a/Documentation/devicetree/bindings/power/supply/battery.yaml
+++ b/Documentation/devicetree/bindings/power/supply/battery.yaml
@@ -66,6 +66,9 @@ properties:
   trickle-charge-current-microamp:
     description: current for trickle-charge phase
=20
+  tricklecharge-upper-limit-microvolt:
+    description: limit when to change to precharge from trickle charge
+
   precharge-current-microamp:
     description: current for pre-charge phase
=20
--=20
2.51.0


--0aGnDoHzYmHLbrXY
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmj/W0EACgkQeFA3/03a
ocVHlwf/WmMG+VHvvbW2L2DZtJpJaw0EfC6PYPUNs9yBLXDr+CfL0pRslVccxRKB
Jmbbt/J+CQ5jhDcPysdGvd4gvl2XqZlNW74w9zBpGGeoAXN3RepiLjwPu07tbi3q
KsMyf0UBeVGeZMD89Z0iyf+i9uAPjIbL7jsJ67Im5cg7H5xWctMEjPmQSAYOZI3n
HLbSqG7+HsWQN/9V3fqNVE4g3O7gipBY8F0ZZQzdZcU0EEimtnwhpyUz1VHnQVIQ
R9MRt7+1ynYb/Hr3y/3yUjLfNmwvD5atDA2znKphM6acJ/LgYTJA4sg2Nvco36Xw
A5pNMofVjUgxD7NYCslLgrj9UeRj+Q==
=OPBq
-----END PGP SIGNATURE-----

--0aGnDoHzYmHLbrXY--

