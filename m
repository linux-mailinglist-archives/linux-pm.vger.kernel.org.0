Return-Path: <linux-pm+bounces-35769-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF34BC0A9A
	for <lists+linux-pm@lfdr.de>; Tue, 07 Oct 2025 10:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 296A74F4AE8
	for <lists+linux-pm@lfdr.de>; Tue,  7 Oct 2025 08:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CCAD2DF152;
	Tue,  7 Oct 2025 08:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="crNa8lLa"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537A72DF125
	for <linux-pm@vger.kernel.org>; Tue,  7 Oct 2025 08:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759825996; cv=none; b=jWT+YoNJzW9Nfy+Xre05NT4bN7WewkG5RE77C3Jf7MhyEvjDoFGSZ+F8FIKHRtMYidzwGRXMIuvz6hwvLBOesRQ1pdGIl0RtA8LKuHR0tTWHBbrgIUktJsObDQSuywwWEHsG0MnHGdyklxSlYwlT7HOxbYy4gEGRx4GifoWuZG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759825996; c=relaxed/simple;
	bh=7uAEAm51rLd1FKqy+L2ec4vQm8vIVZoQc5npaYHbk3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lgmXv97YAlDq2SWT6i2OIWXaNmgCg0VRfDs1HHBKbKnJ0UL/FfNJoj56r6ea4sEdd03//Vz4lBHQceDjXx9oDBmwVa0UWmuBdlYYN/osLnl4rBpmmegaikA+nbr8JfCHO8faaBiTd32KPX+UOfraOM/EWJoBEojzf9fG9SAD7gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=crNa8lLa; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-36bf096b092so56400961fa.1
        for <linux-pm@vger.kernel.org>; Tue, 07 Oct 2025 01:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759825992; x=1760430792; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gGiMbjmQn7XfKWV9vHi8Sy/mWp58kUDQTy/MiPcOTHY=;
        b=crNa8lLa8EjqTStdYaRKokAEtj6ea55hG7k/uRyNzMVqXy+uf10NN+PIG7uJG19Q5+
         xnUgyo/LMVKy1cPQlbUpP/GxRgpC3GvPg8DJLURlqRbnf3oPqzm5fujevlLZXND85LvA
         LJJaRC7/5XanRfYaMlFLgIG6CwIjcbXLYS525lycFtpyxpmazKfZ3W82ImhqmRhMOcVC
         /OnGgiNdl2Mz7tKKtXBKL7yYwosEqr0YvSj4w8WSHdmzM03UjHvEe6LL+UbSGYi87OOE
         C1gykKSVP+SPiDrw8cwSiKk3xqvNlT6+mt1pnpp9gbL2g5uvQb3gVSX9/V6x3S3LFtkM
         XwWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759825992; x=1760430792;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gGiMbjmQn7XfKWV9vHi8Sy/mWp58kUDQTy/MiPcOTHY=;
        b=Dmher++z+7J5n133lRGM+JKfoEPuS+yQ4EPd6AMMS6m8lcQfd0sFZtmfI30fkMKCYJ
         Jcf6D/S3nUGQfV8gEgocGm4eE2H83Z/yVQZYgy9vkCdvOWr0oSKNgCH3yzAvHdxIVkzE
         h52Sv7htqWC0+BsZRY+GBp4pewGWAQ/Q2mFc9w17SPxeDRtP8C1AVOtT1XJzieGcgBWU
         bYJEjp3NcMvY2OKS/cwEEUnXdhAYYlfsp9KsqHuZ1SD2Dq+A3V9oxfYARl2wJP1Sgc9m
         CGFxTowuL1nSJAbo+igRtsuCWfOLszrnc32axw9x3AeO39NtU/N8X4BkVYFulRWIFHRM
         zWWA==
X-Forwarded-Encrypted: i=1; AJvYcCXcvFFauNJth89IBK0N0r3LwYcXkbGmSKA/UmHup1CmP8DaL39FqM4I4q48VvHXP2VH2eIVbPlSVw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw30tzp4lp/tOesPCsWurJuwhlhIQl5vze/hfOnPbDEXDLAIsjs
	cS1jcSqsc31z7G+tv5uuuOF3/KicOhOV10ttkCnU8DGkgAIYfYwB4n/T
X-Gm-Gg: ASbGncu6VwCqQnOgdEwcpyFh8EYbfgJSVnGGhVjJCWphn/kXaa81FH4OLv5O7g9FMao
	/YsmIamLVLAheuqPOmxPNMH5R7mreFshBdPnhXe0huxFanc7I9xxBg3G1jXkGtgVR48I7GnYNz1
	2V/Bo7z08lrLGQLy5IRvyuvr6KiQBihuoNg17/iu5LL0RARaM5LP+/yB9Sag6mHc3GBsa1LF/Pq
	nb8+zYk1SzClz0dDDpPeRlvrY/0zk156ymidwJz3RdD6G3LY2vnQ3zeP+qyc5X/wxGFLBtLxO/b
	CeEuKHLcZti7e+F1gvd+86m9gjDDUppCFwz0J1PtQuC+54ubG/7B2I2uED9ExX0BymIOJNt8Han
	QaFYOK54vf8NS2F0knderzIauUoHlF8BKK6kzYAZvnn+hetwcIAsxsGdeCizlFqqH
X-Google-Smtp-Source: AGHT+IHuGRguErrXJP9h3pDzhOaJUtpac4R4MsXzz6Y0nXTmBHq4H3FCgsyuBlP6yhqsJfsGeldLBA==
X-Received: by 2002:a05:651c:4408:10b0:372:9505:725b with SMTP id 38308e7fff4ca-374c3837106mr35638181fa.34.1759825992192;
        Tue, 07 Oct 2025 01:33:12 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-375f3b64e6dsm7807951fa.39.2025.10.07.01.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 01:33:11 -0700 (PDT)
Date: Tue, 7 Oct 2025 11:33:07 +0300
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
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Andreas Kemnade <andreas@kemnade.info>, linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: [RFC PATCH 02/13] dt-bindings: Add trickle-charge upper limit
Message-ID: <072180743039027b8476525bfb3d04b3dd044be1.1759824376.git.mazziesaccount@gmail.com>
References: <cover.1759824376.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="v2C5QlrJAk9yRRw2"
Content-Disposition: inline
In-Reply-To: <cover.1759824376.git.mazziesaccount@gmail.com>


--v2C5QlrJAk9yRRw2
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


--v2C5QlrJAk9yRRw2
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmjk0EMACgkQeFA3/03a
ocXmPwgAxfL/bnwzJGbWAfYUHNKmQwT+fSbIu0KruqseE4yNXxdi24bAtxHIFSbw
+WR6S46YkHhtZXkD0Ew/skbhuRAaYjmP/NbJYVQdRBj6l5GUcmxtxs3uiadOmaGU
UWa3wakGNMZIdRrOguR7syzu7tq+gc6R0XS7v+EEksiFi9arXBXmknN012XK6x0E
Z/ywhwDzT05HmPuxGV1BtfUd2RlZhfx1w7M9PM4dcNWi0edfB4jgwKNPEUa3A2sR
SfcnNxz+lX34BASK6I2E+zqUfMmg0fBvNCDEC7xbxn98oTU9ceCuj5ADDG7c0wXd
gjb9SctkHZE5Cw67sS2Vg/Lu7E975A==
=b1vC
-----END PGP SIGNATURE-----

--v2C5QlrJAk9yRRw2--

