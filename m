Return-Path: <linux-pm+bounces-29718-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2617BAEC188
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jun 2025 22:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C96B01C227AC
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jun 2025 20:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0ADD2D3EFC;
	Fri, 27 Jun 2025 20:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="uEu6qiMj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8546A134AC;
	Fri, 27 Jun 2025 20:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751057618; cv=none; b=IclIv7cKI67RV0ba+zC+K9qB45cJq+fMxPq1xM+9zMSgEkKr5fiqjVyayRxQRCu0ENZzTIWXVthYWzhhDa0c7UnObC68QhDyID3+rVgIpANUz7VOx04dzd2pd/EIZmA5jgSxPeVk3d5qtgizo47fujEXTOBuZgSKn+EKzRr39tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751057618; c=relaxed/simple;
	bh=7bBkr7vOy93+eqGqvYWVbUJzuDZHDCdQa+v7bLkdR0c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CJquZAlo9Pn89JLTdqbph9E0+M0wRT+Y2fp1opkDWF7oJwv3/KZtzlc3JuSD+moiSG/zqQL5rKO4H6Z5SSuVfyhrqV4HVmasJowrxRImUL4AYTHoDn36csrdfoC1OKy1r9eacMYfkAHVJkcrMT1iFYcz4RTvP0IIey3YaMvyqP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=uEu6qiMj; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1751057613; x=1751662413; i=w_armin@gmx.de;
	bh=wBbodj4U8PSmgG+umKsS8wnN/yuTYmb0Sf8A08BFjT4=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=uEu6qiMjDPz17MFiAyZeCbo7CzCrHnMp1egYLyUsl5yFTLOoFKHu7N1Wjd9vYVgh
	 zwOpbKyBswPwRDGrnVI+Dpjj7sX/0PMz04IMG9O4enQSQRIZLnLnFOnEO1rPjnGQb
	 YaW9YXcm8Lpbabv584MQpDHuBlgkDj+6t42cFTdQfhXjQAa08vXDDF2pCYo8SjQNB
	 odvqgA+KOfnYhOYp+qSF8FQ8bUdet6f7klGKYs4pm0LjVbI/0V7vYvAlHF+6qbpEs
	 O44+9ZfsvU0bewubeFtxoTEuOudN9PxZSrEib3UpJTMUPjTzNnQ644V1aemJe0V2z
	 5Jy4wr++4hluKVC7Yg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.fritz.box ([87.177.78.219]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MD9X9-1udonU1ONt-00BdAG; Fri, 27 Jun 2025 22:53:33 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: sre@kernel.org,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: linux-pm@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@weissschuh.net
Subject: [PATCH 2/3] power: supply: test-power: Test access to extended power supply
Date: Fri, 27 Jun 2025 22:53:24 +0200
Message-Id: <20250627205325.250608-2-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250627205325.250608-1-W_Armin@gmx.de>
References: <20250627205325.250608-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hsLVzFy4XGIbkxbD0331eYTkwhkNqRVEGwT+5R/iRfzA6buflyf
 xnnSmKgXxwY4+u9h+W6Ip2tRu9CcULC8GnlQGt25PXQGNiMgeZFhXkrMuDNQOA+LRIq5RWp
 Z4HdkfB491clwdcNrfrFtiq5ZJsMd/FISkUqJi73Ldd9si/VOFe6Er4iRoMACQ+ZyZSoc3u
 /EDTuz0FEWH9T5J4z94Lw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ra284GPEdPg=;EnAh/g53jKuft6RWcmDX7uDwLTM
 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
 IxTbDZaTiCgzfrr/6Z8yHk5cpSaFhehA=

Test that power supply extensions can access properties of their
power supply using power_supply_get_property_direct(). This both
ensures that the functionality works and serves as an example for
future driver developers.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/power/supply/test_power.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/power/supply/test_power.c b/drivers/power/supply/test=
_power.c
index 5bfdfcf6013b..2c0e9ad820c0 100644
=2D-- a/drivers/power/supply/test_power.c
+++ b/drivers/power/supply/test_power.c
@@ -259,6 +259,7 @@ static const struct power_supply_config test_power_con=
figs[] =3D {
 static int test_power_battery_extmanufacture_year =3D 1234;
 static int test_power_battery_exttemp_max =3D 1000;
 static const enum power_supply_property test_power_battery_extprops[] =3D=
 {
+	POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW,
 	POWER_SUPPLY_PROP_MANUFACTURE_YEAR,
 	POWER_SUPPLY_PROP_TEMP_MAX,
 };
@@ -270,6 +271,9 @@ static int test_power_battery_extget_property(struct p=
ower_supply *psy,
 					      union power_supply_propval *val)
 {
 	switch (psp) {
+	case POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW:
+		return power_supply_get_property_direct(psy, POWER_SUPPLY_PROP_TIME_TO_=
EMPTY_AVG,
+							val);
 	case POWER_SUPPLY_PROP_MANUFACTURE_YEAR:
 		val->intval =3D test_power_battery_extmanufacture_year;
 		break;
=2D-=20
2.39.5


