Return-Path: <linux-pm+bounces-29715-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2108AEC17D
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jun 2025 22:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A29B51C226E2
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jun 2025 20:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CAAD2309BE;
	Fri, 27 Jun 2025 20:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="kdq94R90"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF4B1E48A;
	Fri, 27 Jun 2025 20:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751057502; cv=none; b=l3QMMaf4x9m9Al06XV4e7U2u3c9S+tWGJe75zqqs7nVb0ufUcr7mrxNGQOr6FTJ9FrzeyCfG6tsIF8w7ixoGLc28vRvUAaNMBeF8In+7v+a9CCUgCBoQNkXsmSaujVRtHwvIN459sGfMgGRvrxV+Ur7iJLDERqqTU7ZTHl25iaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751057502; c=relaxed/simple;
	bh=7bBkr7vOy93+eqGqvYWVbUJzuDZHDCdQa+v7bLkdR0c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VeU6VGk7DyDtXxrFxXeJulA43F8BU6zLaFzsDnromgxhqghtyaD48n5SRGICRWLOwxQZMBtGRgZYQZbbSq28qBXjFvk7RNNGO4K+NtNZAshnXa0Wb7UOuvpIKiian19Hdbu4PhPPd+Vz2nYDpGQKGqpT7EGY5CPuv/TlNd/u730=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=kdq94R90; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1751057493; x=1751662293; i=w_armin@gmx.de;
	bh=wBbodj4U8PSmgG+umKsS8wnN/yuTYmb0Sf8A08BFjT4=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=kdq94R90RsDvk9Dht+U5AC5wFOYXFLDk7ypf7ulp1RUD01akarlm3EyqsSaI4Fq6
	 DLybp0DbEDkzbNl/OgYJYpjwJNDH+XAOumVnmhJJoRx0qk1kHCgECZLr1QRvsIjPB
	 48v9RqFLmPZFX8gPEBveeJZFedkk+D9XLNFnwPIb82vI5iJoulKjaFeTMrDorR5sg
	 Nw3o5S51Kq8PwBK0bcCawNKCPUqUILEl9Qfvv2DLwQgP+oTdgQedStFPCKkvd5Lff
	 4is+qDFHrF1ETsVsjcsKJFkmpRJRgHEjKrQfUHUgT5Pn9bkJqajX4BtnFzle7PcSe
	 QBShHrHB4oRjrXFtWA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.fritz.box ([87.177.78.219]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MlNpH-1v9rGT2WY1-00k9yT; Fri, 27 Jun 2025 22:51:32 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: sre@kernel.org,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: linux-pm@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] power: supply: test-power: Test access to extended power supply
Date: Fri, 27 Jun 2025 22:51:23 +0200
Message-Id: <20250627205124.250433-2-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250627205124.250433-1-W_Armin@gmx.de>
References: <20250627205124.250433-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xhigeZFB7z9FKNrADOTFMSbGd0tKLXDlvaV6NJpbCVGIxowdUPL
 P89b96jDh0eqZDAmdTfPMraUbcHxVLGzeDjvWwxF3m9CUOhZ1zMmpjg2HRF5b0T+LY8N6Qp
 ArhO1iX8c17iwxhh+LAx3ZH5G2/zKs9kv/4q10usCSxKpFFf63WYNpoHMTz9KgZ9/pNvMBD
 HxjeRSI6UglglgPm9mfdg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:iAyAiuplWYA=;Lla+UW3/zMdGm/01nAfCqDUi17c
 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
 RK4iAUiQPOZXUlFIF4fXD7velMouthYE=

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


