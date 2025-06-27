Return-Path: <linux-pm+bounces-29720-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C80B8AEC18F
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jun 2025 22:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 450713BAD48
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jun 2025 20:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F822E92DE;
	Fri, 27 Jun 2025 20:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="PqpSj+IY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9411F3FED;
	Fri, 27 Jun 2025 20:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751057625; cv=none; b=A+MJASS/dfFkZS2yjJvLXoxR2V9rnqpzrB/W3jS9WWlKVSKGxsuej2F++lTFJzFQSnw7lsHeext6mSLn/KWO+ZHG3B/6/Al/Th9Q8QVTq1N4TqtDTqKNYDDAlr26ha8aAtk7KRQgBENYrg34sIrpigYXiWBBONrk/9Zyk0B+evo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751057625; c=relaxed/simple;
	bh=KjMUJVcwN4e2wA+enjyaCPLTrfrzx9wCh24MNovogHo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RBR6+3I+hRXBBILQP3F0jrftL/0kzPXltC1ZTTJFXn+RIlwU6OOzqfaEaEOqudtvOl8RFK1acPe83S5xBRXsMrPy0pfg4JTXR2SS3Nuy5ZYMChk7rgzBZc5wgI4FCsUQzJKk+eReKa3lG9/KaNstPo5lzd8WLps4QiRrXnM2GNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=PqpSj+IY; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1751057616; x=1751662416; i=w_armin@gmx.de;
	bh=GkpwTbp/au2bsPcIPtH+WBjZffEsEK9oTVTyL1IPBHU=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=PqpSj+IYuJKRZltejQdm/ClhlYeYJ7gDcWBBcA9lfNN18tNItz5SfVsQf2LmeXKC
	 hIFz3RPnWxnvOqdLp74WF8K6sJNbD5KMvn2hziFRK6aupY2A54Cq/zvergITJ8QU9
	 kRbRHjGxWlTIZKGKqKAssS7x4h9F65ew4fr1ThIQz5cdyGgq/FMKw7h2+2mMmilqI
	 Naw3hFjsEkK87AnRtoSYLBlKju/a1icCjO0ajW0w/Zb+cpa7oc2jbSoS6i6Bn7UwJ
	 JBdLegBcWwCfcYehgQ9+1DhxuQdJQZ67i4UXKQvDHfCrLUJIlxyZFRJi0LQp/UpNr
	 39WT3CSKrz5P2Phf6Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.fritz.box ([87.177.78.219]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MryT9-1v7fNC2aHN-00qk0n; Fri, 27 Jun 2025 22:53:35 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: sre@kernel.org,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: linux-pm@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@weissschuh.net
Subject: [PATCH 3/3] platform/x86: dell-ddv: Fix taking the psy->extensions_sem lock twice
Date: Fri, 27 Jun 2025 22:53:25 +0200
Message-Id: <20250627205325.250608-3-W_Armin@gmx.de>
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
X-Provags-ID: V03:K1:JCugStu95WXZgYR3Yfsdp/fDtzzDoUJyjKCGa8Zpr8n0FOCDI9N
 vRTTBEvekDM2MnB7OfVbTlskTJ8CsPhbHCQiskRmLSikE/cAxaWxvFYG500aIlpF/TfqtiR
 LRGKAsYnY7FP3KDkjkI6cecP9TVMKsWgjmHRPj7G2Yj/yoq9DZpYcQmZCkOYLeAz+UCX6kL
 xxGnJyllorKdzMHQfStVw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3UZvYep2ZKs=;cw9TW/l5NcZj4fOnv5hyVmuILyP
 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
 6g==

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


