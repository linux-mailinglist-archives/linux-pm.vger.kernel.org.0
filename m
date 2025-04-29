Return-Path: <linux-pm+bounces-26344-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E22A9FE6E
	for <lists+linux-pm@lfdr.de>; Tue, 29 Apr 2025 02:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA2043B4CF4
	for <lists+linux-pm@lfdr.de>; Tue, 29 Apr 2025 00:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B4F18DB13;
	Tue, 29 Apr 2025 00:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="VjWNSKdg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E815E17A2E2;
	Tue, 29 Apr 2025 00:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745886989; cv=none; b=IQZRBvYsKtUhwGJ+e4hU8JNERcyKnRYKNtudUhkDPCK+hOnDn6lrLFfe7cLWsXnk6b1VgoA5KLvcChYX92TOLhJeyGEA5SROC7F2f0ExD1tPVad/EDVAZN1yoEvETH3RKguCqi1r7E1YZiOuyj2RfXAOKTPkaqOJAWNbzZBpqkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745886989; c=relaxed/simple;
	bh=KRZF4AimC4ir70M6J+ICGlCcbbzHC9tV5OlMioEtp7o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f+vE8DcandhLTtq18BxI5+Da/t+joSnAxaWi8JRYQZ8uNhNA1nwthCj0uHoqg9LwDSPjlY2U8B103ZU6/Sp6rDqr7aZtJ5MdzMaLXyYHT4+4pMKS9Job6u6FzPFABfgTaS54FYwexAMG5rzlNb1SpL7Nf2uJK9lq32ht1tJS7YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=VjWNSKdg; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1745886978; x=1746491778; i=w_armin@gmx.de;
	bh=VGRq0MaqT5yVpxK/8Ryqn4LVg8ze7XpG9UtDh6/J4UU=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=VjWNSKdgZ6TrfpQPgS+UzcSx1SVx3HqP2MJ9XYW1aw/Ejup/WhQK1die3D/iwcgc
	 k+pvi8HztQI7rljGdGu0v+xXRVaAMkGYT84eIDhjQGJy8LFPpz2/JcT0F7b6DWGaR
	 EchNaIKns+LtZWPhwlClewSw0LBNFfKQU1iz8ptTxtiFT9dgrXDIgxJiXlsDqjqR8
	 YgSfGzTm5MnEHwisWixzKjc9F1OgowpLcDqL0RFExa5EzrDg1Re9/wQ9ZhqtZ6kjZ
	 3rirCZ4wHQLjRRd0R/ZvtXpIiSGecgoFtnvuHJrRHmNXCFRivGA9t2tPOIzC45Wg8
	 p7SPqxTvL+nEItxUMg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.fritz.box ([87.177.78.219]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1M2O2Q-1uDOiC0xwM-00C7yM; Tue, 29 Apr 2025 02:36:18 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: sre@kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] power: supply: core: Add additional health status values
Date: Tue, 29 Apr 2025 02:36:03 +0200
Message-Id: <20250429003606.303870-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pdHDwMJ1+w0c4m6E6Wqxh/4mKPhG107SCRtPqrJUYYzltsf+xTl
 o1iLhupyEXzg9xmLNbKTRTkrvDpqZzPeX/vSwUtyJheaG44qgTZmLgm5TnFYYp9vbqMnqBX
 xnCi+V3kM0s+Pni1sHUDq6dILHk+yL2nGTgOYNVh5iVVVtiXhmhQI/Uy+gALC330IHilUtG
 hd04nU4YHKic9gLh4+kPw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:EfjctNjd2Y8=;F+rIxBWIZSKLzrunzhA2aa52RAg
 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
 TMbCjyKIMfPoPjy2JIMBGhXoj6xiV3mcBp

Some batteries can signal when an internal fuse was blown. In such a
case POWER_SUPPLY_HEALTH_DEAD is too vague for userspace applications
to perform meaningful diagnostics.

Additionally some batteries can also signal when some of their
internal cells are imbalanced. In such a case returning
POWER_SUPPLY_HEALTH_UNSPEC_FAILURE is again too vague for userspace
applications to perform meaningful diagnostics.

Add new health status values for both cases.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
Changes since v1:
 - rename "Fuse blown" to "Blown fuse"
 - rename "Cell imbalanced" to "Cell imbalance"
=2D--
 Documentation/ABI/testing/sysfs-class-power | 2 +-
 drivers/power/supply/power_supply_sysfs.c   | 2 ++
 include/linux/power_supply.h                | 2 ++
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/A=
BI/testing/sysfs-class-power
index 2a5c1a09a28f..be8be54b183d 100644
=2D-- a/Documentation/ABI/testing/sysfs-class-power
+++ b/Documentation/ABI/testing/sysfs-class-power
@@ -456,7 +456,7 @@ Description:
 			      "Over voltage", "Under voltage", "Unspecified failure", "Cold",
 			      "Watchdog timer expire", "Safety timer expire",
 			      "Over current", "Calibration required", "Warm",
-			      "Cool", "Hot", "No battery"
+			      "Cool", "Hot", "No battery", "Blown fuse", "Cell imbalance"
=20
 What:		/sys/class/power_supply/<supply_name>/precharge_current
 Date:		June 2017
diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/sup=
ply/power_supply_sysfs.c
index edb058c19c9c..2703ed1dd943 100644
=2D-- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -110,6 +110,8 @@ static const char * const POWER_SUPPLY_HEALTH_TEXT[] =
=3D {
 	[POWER_SUPPLY_HEALTH_COOL]		    =3D "Cool",
 	[POWER_SUPPLY_HEALTH_HOT]		    =3D "Hot",
 	[POWER_SUPPLY_HEALTH_NO_BATTERY]	    =3D "No battery",
+	[POWER_SUPPLY_HEALTH_BLOWN_FUSE]	    =3D "Blown fuse",
+	[POWER_SUPPLY_HEALTH_CELL_IMBALANCE]	    =3D "Cell imbalance",
 };
=20
 static const char * const POWER_SUPPLY_TECHNOLOGY_TEXT[] =3D {
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 888824592953..69df3a452918 100644
=2D-- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -71,6 +71,8 @@ enum {
 	POWER_SUPPLY_HEALTH_COOL,
 	POWER_SUPPLY_HEALTH_HOT,
 	POWER_SUPPLY_HEALTH_NO_BATTERY,
+	POWER_SUPPLY_HEALTH_BLOWN_FUSE,
+	POWER_SUPPLY_HEALTH_CELL_IMBALANCE,
 };
=20
 enum {
=2D-=20
2.39.5


