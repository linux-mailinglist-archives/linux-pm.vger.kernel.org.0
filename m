Return-Path: <linux-pm+bounces-29717-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 170B6AEC183
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jun 2025 22:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC14D1C22C19
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jun 2025 20:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840782ED856;
	Fri, 27 Jun 2025 20:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="YynT5htg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9F92ECEAE;
	Fri, 27 Jun 2025 20:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751057507; cv=none; b=GjW7G8mvaW9ZlOc6Ey93rr5D5qj6GxwgcNu5kcBNItLNM+lvo0DGr5D761GnhSGvym2WPcyhMlm4R1kb29HqXKDB0JWjdhqw99UZy7IXa9XnK99Cbe34xtukali1tJOJ/etXWhBWBhMORg/W2Z0KXOc9Sn8PhZ5kUGUYR7X9fT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751057507; c=relaxed/simple;
	bh=KjMUJVcwN4e2wA+enjyaCPLTrfrzx9wCh24MNovogHo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SxDTG4w/1tF4wOOqnTVa5dVAwanYqRLZXE9zULiIB3ZwlOa07nc0ITIK9caJABRAkfbDgLvDVRo+yeO7j65hemBSAw9tyvrOphBsn3S1H3Fe9czdykQ4k4nN+HTcCWu1NjrHZ+Mky7THoZJvALYt3usmcLe1snToDseErLDtIFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=YynT5htg; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1751057495; x=1751662295; i=w_armin@gmx.de;
	bh=GkpwTbp/au2bsPcIPtH+WBjZffEsEK9oTVTyL1IPBHU=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=YynT5htgPE8317tuZqKFJNC1uaxZKWER/cdAeUgZ3y1npGClsJ8KesPFgDmx2a9R
	 bIsA8eZADQ/UC99038GgF5OHUISl2ghtOYtM+lI4Ud+ZwcFkE3JN0UcU1nBr1v8O6
	 A/yDgNNhSxxq1q6RkgCwlUXGlxFegVk2oW4X+gHdYYxJc29ikjQWYwbpQyRrEi1rl
	 IgTqg4UJY8w/UpZq/80FZQROj8iOQNFOtGhbc6eLDgbk60cJSowJhTv6mGYIdSqfA
	 O1z1CwVsbu8KcR5VOnwSGBzgykuUrB6KoL1aWgo/ZkSvitcqfg12Pg0Em+pMel0oS
	 OHomx5rWpPmi+rm2IA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.fritz.box ([87.177.78.219]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1McYCl-1v11Yp1RoD-00b5Xd; Fri, 27 Jun 2025 22:51:34 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: sre@kernel.org,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: linux-pm@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] platform/x86: dell-ddv: Fix taking the psy->extensions_sem lock twice
Date: Fri, 27 Jun 2025 22:51:24 +0200
Message-Id: <20250627205124.250433-3-W_Armin@gmx.de>
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
X-Provags-ID: V03:K1:YYtU0Gp+p1hgigDy++sgnL5bdPxmPbN//p722amhc01dQ8hd5ga
 uWqaFi6LPNR776+onfaQO9a0XrmZnvrlSVf0HYlUlRhlmjxmRv1cIpYefSCtRJJxIJhJrCv
 ZULJSO2Em2SlRsw4j9HnrkVFDb8NIQs7H22ciIH3syKX809AM88ZmIMeCh5tzQ4P9iSGxd9
 2G6KTpibnYt6kUzcxWA8Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:RKO+pJ/AOfA=;YcLW8S4YG7rts4WQSj+gFOJp8Zp
 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
 /g==

Calling power_supply_get_property() inside
dell_wmi_ddv_battery_translate() can cause a deadlock since this
function is also being called from the power supply extension code,
in which case psy->extensions_sem is already being held.

Fix this by using the new power_supply_get_property_direct() function
to ignore any power supply extensions when retrieving the battery
serial number.

Tested on a Dell Inspiron 3505.

Reported-by: Hans de Goede <hansg@kernel.org>
Fixes: 058de163a376 ("platform/x86: dell-ddv: Implement the battery matchi=
ng algorithm")
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/dell/dell-wmi-ddv.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/dell/dell-wmi-ddv.c b/drivers/platform/x=
86/dell/dell-wmi-ddv.c
index 67f3d7158403..62e3d060f038 100644
=2D-- a/drivers/platform/x86/dell/dell-wmi-ddv.c
+++ b/drivers/platform/x86/dell/dell-wmi-ddv.c
@@ -689,9 +689,13 @@ static int dell_wmi_ddv_battery_translate(struct dell=
_wmi_ddv_data *data,
=20
 	dev_dbg(&data->wdev->dev, "Translation cache miss\n");
=20
-	/* Perform a translation between a ACPI battery and a battery index */
-
-	ret =3D power_supply_get_property(battery, POWER_SUPPLY_PROP_SERIAL_NUMB=
ER, &val);
+	/*
+	 * Perform a translation between a ACPI battery and a battery index.
+	 * We have to use power_supply_get_property_direct() here because this
+	 * function will also get called from the callbacks of the power supply
+	 * extension.
+	 */
+	ret =3D power_supply_get_property_direct(battery, POWER_SUPPLY_PROP_SERI=
AL_NUMBER, &val);
 	if (ret < 0)
 		return ret;
=20
=2D-=20
2.39.5


