Return-Path: <linux-pm+bounces-21116-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A7EA229F9
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jan 2025 10:00:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DAC21882414
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jan 2025 09:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0127A1ABEAC;
	Thu, 30 Jan 2025 09:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crpt.ru header.i=@crpt.ru header.b="duwaHRn6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.crpt.ru (mail1.crpt.ru [91.236.205.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC92881E;
	Thu, 30 Jan 2025 09:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.236.205.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738227652; cv=none; b=Jz5gCfzcnL1pe819mSLyiTKFCxF7XifDnhuymQic8zDnLdziaTXRi88x8/EPixV0upCww1i+SV+i1256JCSe5OdUlh8jEh1OU58qOkkxNvtpiiXLFV8W16hOntVajJrs3lGoHjbay2/qeFBv+FBM4NjlXnbA0BAMjrcyvzuFOxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738227652; c=relaxed/simple;
	bh=/PrXWxohQ205RW/ae0fQlLa42s0+6zVNBySmFktGVTw=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=lu2C007leddw3fsol2zA3a7xK6EplYdlguRk1NiB7CTUnYIdYfFSZUi/Hp7mwGRSQ8EHE+CtWeU8jk/6CK1ArLNK6Ya8NR7YzpuXHpWr/QARrTqS2TdrCfylILERqkG4THL4YfGFGwiOnnfKuzkyx388j4QiPEv432r17l6RViw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crpt.ru; spf=pass smtp.mailfrom=crpt.ru; dkim=pass (2048-bit key) header.d=crpt.ru header.i=@crpt.ru header.b=duwaHRn6; arc=none smtp.client-ip=91.236.205.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crpt.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crpt.ru
Received: from mail.crpt.ru ([192.168.60.3])
	by mail.crpt.ru  with ESMTP id 50U90Zgn005319-50U90Zgp005319
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=OK);
	Thu, 30 Jan 2025 12:00:35 +0300
Received: from EX2.crpt.local (192.168.60.4) by ex1.crpt.local (192.168.60.3)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Thu, 30 Jan
 2025 12:00:34 +0300
Received: from EX2.crpt.local ([192.168.60.4]) by EX2.crpt.local
 ([192.168.60.4]) with mapi id 15.01.2507.044; Thu, 30 Jan 2025 12:00:34 +0300
From: =?koi8-r?B?98HUz9LP0MnOIOHOxNLFyg==?= <a.vatoropin@crpt.ru>
To: Support Opensource <support.opensource@diasemi.com>
CC: =?koi8-r?B?98HUz9LP0MnOIOHOxNLFyg==?= <a.vatoropin@crpt.ru>, "Sebastian
 Reichel" <sre@kernel.org>, Adam Thomson
	<Adam.Thomson.Opensource@diasemi.com>, Lee Jones <lee@kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Subject: [PATCH] power: supply: da9150-fg: fix potential overflow
Thread-Topic: [PATCH] power: supply: da9150-fg: fix potential overflow
Thread-Index: AQHbcvVskkaaNoCx5ECWTkugta3T2Q==
Date: Thu, 30 Jan 2025 09:00:34 +0000
Message-ID: <20250130090030.53422-1-a.vatoropin@crpt.ru>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-kse-serverinfo: EX1.crpt.local, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 1/29/2025 10:00:00 PM
x-kse-attachment-filter-triggered-rules: Clean
x-kse-attachment-filter-triggered-filters: Clean
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-FEAS-Client-IP: 192.168.60.3
X-FE-Policy-ID: 2:4:0:SYSTEM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=crpt.ru; s=crpt.ru; c=relaxed/relaxed;
 h=from:to:cc:subject:date:message-id:content-type:mime-version;
 bh=o54c9MrkUFXn90FGbRmy5zFWqtUULMfirflS/ppsvvI=;
 b=duwaHRn6/D8wlbZcYcIk+99RcTwIlw0VAvIV6C1nsLUEsMgLGlelLiNcsVA8WccodBWXuF0LiErL
	X1fEWqK6gfWjQBnSoUKs10u7oPP27IuBwIY+sZ9bO+O1hbM/xfqoxdGkSUzkVH51RVgOGX4o00w8
	4FRTrAyklHnUW52KEZldKGYXDpw1sTcVKISamUxFwNZ0+XxpwNaiWfJhe6EmvcyBdExl7ftIfWwW
	8XIBBn5o9p/b3BUYk6IgBaTtrjoErsU/GlSW8R/5Gtnun8qNJzxruv6X3ypnwxJdyAPeZDd0aMt3
	vJA54QyScXpftzlseMNQVUmdLE4MuYmC4VDE9w==

From: Andrey Vatoropin <a.vatoropin@crpt.ru>

Size of variable sd_gain equals four bytes - DA9150_QIF_SD_GAIN_SIZE.
Size of variable shunt_val equals two bytes - DA9150_QIF_SHUNT_VAL_SIZE.

The expression sd_gain * shunt_val is currently being evaluated using
32-bit arithmetic. So during the multiplication an overflow may occur.

As the value of type 'u64' is used as storage for the eventual result, put
ULL variable at the first position of each expression in order to give the
compiler complete information about the proper arithmetic to use. According
to C99 the guaranteed width for a variable of type 'unsigned long long' >=
=3D
64 bits.

Remove the explicit cast to u64 as it is meaningless.

Just for the sake of consistency, perform the similar trick with another
expression concerning 'iavg'.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: a419b4fd9138 ("power: Add support for DA9150 Fuel-Gauge")
Signed-off-by: Andrey Vatoropin <a.vatoropin@crpt.ru>=20
---
 drivers/power/supply/da9150-fg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/da9150-fg.c b/drivers/power/supply/da9150=
-fg.c
index 652c1f213af1..63bec706167c 100644
--- a/drivers/power/supply/da9150-fg.c
+++ b/drivers/power/supply/da9150-fg.c
@@ -247,7 +247,7 @@ static int da9150_fg_current_avg(struct da9150_fg *fg,
 				      DA9150_QIF_SD_GAIN_SIZE);
 	da9150_fg_read_sync_end(fg);
=20
-	div =3D (u64) (sd_gain * shunt_val * 65536ULL);
+	div =3D 65536ULL * sd_gain * shunt_val;
 	do_div(div, 1000000);
-	res =3D (u64) (iavg * 1000000ULL);
+	res =3D 1000000ULL * iavg;
 	do_div(res, div);
--=20
2.43.0

