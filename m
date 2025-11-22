Return-Path: <linux-pm+bounces-38404-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4D7C7D857
	for <lists+linux-pm@lfdr.de>; Sat, 22 Nov 2025 23:08:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 984D33A9C3E
	for <lists+linux-pm@lfdr.de>; Sat, 22 Nov 2025 22:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF33A29D28F;
	Sat, 22 Nov 2025 22:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="0mJkOLua"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728CD29A322;
	Sat, 22 Nov 2025 22:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763849287; cv=none; b=jElZfe7TbRCSn374WSokfB2kUe7+kEYHOo6siuYOnQ7IsnRZknBP8wBD29QoSOwvqCMI4tW2sR9CkNUZJPra/TtGF6ImZiGa0JghNNAvdmbR/HObs7Ubv6WJo6oolHKfanW0M4LFvVvmIjU/i03vw3J5uZV+8+ZnOYzrFC7hwr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763849287; c=relaxed/simple;
	bh=H0YhLBJNDKnh70szgpRZKJV1nVSzQIUHXWSG/4APVDk=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=o9Ra99PJzn8X2tAvObfXuiRRbU0K0eS9897p5Y0EBrN3NN4pzx5Zv4IRoLgypG5lPizx8BveYhEFOqI5u/qTj5WOvh1c9TB+ivE9Iy524H8Jsh++v8goAqEG8dCFZ+aPqS/w+itzN7MJmBduyxVYkfinOvBripnNKWgLAIWQg8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=runbox.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=0mJkOLua; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=runbox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight@runbox.com>)
	id 1vMvlt-00Fvwh-Qa; Sat, 22 Nov 2025 23:07:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-ID:Subject:To:From:Date;
	bh=sVu7lS+rAWqbSbOlgcTkOLhnVtwii8y1KZQCSwPS4UE=; b=0mJkOLuaCbcaIwgSZ+GrSBmEa7
	OpCaKap0ah1eAPrrLCablHK6EpBGbd4igDOiGNGpgkC/bIaPnNZRCyvdOAwjvyygUiZuaKoERFLsn
	jFp/8a0Tx5aKkLh2xScih7VcFJl2z9l/MexpWiSV9zQ+Es5yLYGUVDQylb5zhwGHtbEIunV4RlpeS
	X2hRU6YKUroS9KPhjUcW2XIygBI/zEmJx7ELIXNV3uE8U8cM1xg7xBV5cp4OGJXbVthB4wxrnMXbL
	4YHe/MoLWwAR8Xz9CaCnClN1/E7H3lijN7orROU7Q2GSmm/9tdmbPTVw5xbkMQQFM5PkUc6zInSAW
	uyoI2mog==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight@runbox.com>)
	id 1vMvlt-0004A1-HC; Sat, 22 Nov 2025 23:07:57 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vMvll-004mkp-JC; Sat, 22 Nov 2025 23:07:49 +0100
Date: Sat, 22 Nov 2025 22:07:47 +0000
From: david laight <david.laight@runbox.com>
To: rafael@kernel.org, rafael@kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, ansuelsmth@gmail.com
Subject: thermal/drivers/airoha: Fix low trip temperature setting
Message-ID: <20251122220747.70c51d9d@pumpkin>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

There is a 'cut&paste' error in the code that sets the 'low' limit.
The clamp() calls contains 'high' instead of 'low'.

While FEILD_MAX() ought to be (and probably is) a compile-time constant.
it isn't constant enough for the range check I'm adding to clamp_t().
Additionally (and probably accidentally) it has a 64bit unsigned type
which propagates through RAW_TO_TEMP() causing a 'signedness error'.
Hit it at the root cause with an (int) cast of FIELD_MAX().
(Alternatively arrange for RAW_TO_TEMP() to always return a signed value.)

Fixes: 42de37f40e1b ("thermal/drivers: Add support for Airoha EN7581 therma=
l sensor")

Signed-off by: David Laight <david.laight.linux@gmail.com>

---
This is a diff because I've not even contemplated committing the nearly 500
files I changed.

diff --git a/drivers/thermal/airoha_thermal.c b/drivers/thermal/airoha_ther=
mal.c
index b9fd6bfc88e5..75afc94fea5f 100644
--- a/drivers/thermal/airoha_thermal.c
+++ b/drivers/thermal/airoha_thermal.c
@@ -261,8 +261,8 @@ static int airoha_thermal_set_trips(struct thermal_zone=
_device *tz, int low,
=20
 	if (high !=3D INT_MAX) {
 		/* Validate high and clamp it a supported value */
-		high =3D clamp_t(int, high, RAW_TO_TEMP(priv, 0),
-			       RAW_TO_TEMP(priv, FIELD_MAX(EN7581_DOUT_TADC_MASK)));
+		high =3D clamp(high, RAW_TO_TEMP(priv, 0),
+			       RAW_TO_TEMP(priv, (int)FIELD_MAX(EN7581_DOUT_TADC_MASK)));
=20
 		/* We offset the high temp of 1=C2=B0C to trigger correct event */
 		writel(TEMP_TO_RAW(priv, high) >> 4,
@@ -273,8 +273,8 @@ static int airoha_thermal_set_trips(struct thermal_zone=
_device *tz, int low,
=20
 	if (low !=3D -INT_MAX) {
 		/* Validate low and clamp it to a supported value */
-		low =3D clamp_t(int, high, RAW_TO_TEMP(priv, 0),
-			      RAW_TO_TEMP(priv, FIELD_MAX(EN7581_DOUT_TADC_MASK)));
+		low =3D clamp(low, RAW_TO_TEMP(priv, 0),
+			      RAW_TO_TEMP(priv, (int)FIELD_MAX(EN7581_DOUT_TADC_MASK)));
=20
 		/* We offset the low temp of 1=C2=B0C to trigger correct event */
 		writel(TEMP_TO_RAW(priv, low) >> 4,


