Return-Path: <linux-pm+bounces-23460-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FAA0A4F68A
	for <lists+linux-pm@lfdr.de>; Wed,  5 Mar 2025 06:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F0FF3A82C8
	for <lists+linux-pm@lfdr.de>; Wed,  5 Mar 2025 05:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2931D6DB4;
	Wed,  5 Mar 2025 05:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="HPTqzKAk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3CA192D97;
	Wed,  5 Mar 2025 05:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741152626; cv=none; b=ZzMC26Gi87Jlt9DBvkwF++yCdKukfDDDuO4PAvLtp82hYtqMFzdB6jptzwWZNImZJwL+KdLY1MmydKfayJndq3YuQNLbXVrU4NI8NeSIbU50XQrtvxYfyzK7VoYHwjIGNfCg7h3osYhFfUt5T7IEq1C9Z/Wjp2sqjlCphIPMpkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741152626; c=relaxed/simple;
	bh=Cu4aMMTSPnkinZYxHlGE0uO+4DCXUphDPMuHClD9W5E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IvORcDhuoRbSru/eLVnqoshgwZuZF+opPQ+thdjjUvDOsLzMngqX1XBFIuUK1T2rmVlIGPDr940+LfYuTzOySDFdQ+Hu9jlaa4UBVQOr7pKUuX49jcl++Y+irXyCV3NxNVOFGfz3jhcVGuElfPJOwQHuWk+vOw7Wufj6rZyxV8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=HPTqzKAk; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1741152622; x=1741757422; i=w_armin@gmx.de;
	bh=ZHyHXS2eq9YUdF65i2BBBNBkWwwkeESwiml5J84ESYE=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=HPTqzKAkT95GZ+y4lnXFlx215jz5JHLOeJWMzy5K6mViKa1/XaCiOJoIsye+DnLc
	 kWW+tcoJGKkHY4IeBy9B6HX3TFzD8I3T6b8qzUyA/C2Tib/GmjNihJluumkDQkVaL
	 CrZ7dXW8hMfDk6A5tioUCikded5rKmD96vAFK4QqRogfQbH+mZ+AfdYmoNbNihjD3
	 QbtkgA1FzboK3bH3iZJPPZGSKr1FjvUtUNHcZTsPY/ucsvsbE6xHfbFHHI3rZuQ9G
	 KqBbCJpS24vGEMc4+51S8TZM1ykyEsZb7fJ2lGbvVpDbfgOFSLrDEjpR7uYV5THHh
	 sc9cnuaOeSn1sS3sSg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.fritz.box ([87.177.78.219]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1Mn2aD-1tNCzy2uFr-00hjvn; Wed, 05 Mar 2025 06:30:21 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	sre@kernel.org
Cc: platform-driver-x86@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] platform/x86: dell-ddv: Use devm_battery_hook_register
Date: Wed,  5 Mar 2025 06:30:08 +0100
Message-Id: <20250305053009.378609-3-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250305053009.378609-1-W_Armin@gmx.de>
References: <20250305053009.378609-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kERdTMHOAJNAs1LzeC4QxeaeaSpx/Wnl3duXrBk1IqCZQzs1PL9
 x7y611wnvq1JS2iFk34MTnY7hkNSTjFN7wk7nrMgzmwW3mdkzhprZ40fitOVBkinRUmHyIf
 qj+HcjGAZV0yPig2zUG2sBXgqQJQzu+aR5QeshQC8Ehr6ZDMw2MWzJSIC2J9g3fLUMYtlTw
 jU+DkcOlLyWb9vorhkXrA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:a+p/RyqkFNk=;nn7gX4oA2VI7R7GohKLuLHhX/MA
 tnWePq14g9MqeZyXmtTj2dGXVUZCOPrGOGr4uGPxcR/Ut3h2SdRUC78mXaJkAwndTfWqqlT5q
 BjuAm7GhnGTlgs+IwX6AqxIkORLJvNXTCJgY5gw47XJzqKa+YBuYad8s852QATxVBuue0rq5l
 8cL5aXsSIE+7pk7ljSjXkTtokBMqS/jUy8pXpEqMJy9zGbEttAZgCQGjNrPGf/PIaI/VfJ4zc
 tjtK1MBP82PxIT50hX2WjB8Tohk7zqFOohBIxwFhrYwS9kkRfBgwqDjJf0dYcK1qDhcUO/rG8
 UvCoQXj44qqgCWpRQg85iP/3sCFnyKhpKDTXg5a04Pnkip5a+cbvZ0yUlpWGBZD8uve6mosLA
 kZZYbukdjzq8BublYWiY+C2u58VAD/p0bB69E85GAmQFk/cGwK+NF0/DiC/OJ+0IDLSv63tAD
 PrSNveDYUd2ZwBp3qGMRgOnIdnog8uf/z2YhXYVRenjy1UacHt8RVR27PhDGCYU0EKxu90xB9
 O+QwpVkKh26XtPVog5nCNIugTyD/svEtiS/bxjF7zXU18ZJvl084640EHBXvHZpF5fHNh0jWU
 zak5+BcFxRtsJmGHDCLmdkoqDR9rXhMTz34z6wB5I94GlwCgfrcILmUeJHwbhpo2issgWGncK
 mu7yp74YgYMbEfY28f5bzHaQk8yEx7/ihlheipBfP4VNRCKEYFgQHMFwMX9Y8ASfRd4+L4xrl
 +UGuXngMv5pSK8i4NdG7WYNXC8QAKNoxtC3NkS559EXOoixoI9ybtrKCe9E0VRtgvSlH5TI50
 TgWeT9+UOC+Fv4Ryb76yqykWVjU/h7Jl2S0UDhuBIyXytxFo9xIWFhq5z/9QydtDDeRurBX7S
 7gdPcSZudkWiHoFQSdjdKVWkkkI5TOL9Wz6EwBEKcxSrrav7KxKo+Ezk4I6X4xw1vHGP9SCNm
 GdQjUsY9HIDRoWTeCWQLtgww7U/2bMJekqSly0zcBS/K7hqKWZnZCrtF2YFExCBjgjX+Sz2RO
 ibNg9Ourc+vG0htpFs3lFkY9NcIi61woYx2gZ4+sfclTWR7CcGQXdV1+I78E1LILMCkptRPvV
 Crt+8CX9Mbax+ZoL4x9WC+xE0+FPOQAQ5T8Pnp+ApooV2e32YE/A2fyGEHH+BTkgYmuMJSl0m
 09Rf/qTIS+GRv1CjVJe7Od6WKyWMCts/34/+XwD6xpWUyPR7UfZDHyvpT6c42fNQDF0+q5IY6
 uMHf2O4TYgRMmIkRSCMk3vxMv7jS9zlSJOnmX0Gkf0U2mYJG2Io7p+dzUOoFMdeZAX9J7mxWc
 mCL3v4wUNJpQlkYU3tiZcZ0TqUUIOEwHbjdzunWj+wMU9X6JHsVyGIr7Pq3WxWTI8VhNkj0BV
 hXFGcQ1qYilBeOyyIsVSUNM2QYajIltVqyLaBWfBwJ1ye1o2cnfTVbjv481rZwLlArlFDw9N1
 WBAHXGQ==

Use devm_battery_hook_register() instead of manually calling
devm_add_action_or_reset() to simplify the code.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/dell/dell-wmi-ddv.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/platform/x86/dell/dell-wmi-ddv.c b/drivers/platform/x=
86/dell/dell-wmi-ddv.c
index ab5f7d3ab824..811cddab57fc 100644
=2D-- a/drivers/platform/x86/dell/dell-wmi-ddv.c
+++ b/drivers/platform/x86/dell/dell-wmi-ddv.c
@@ -732,13 +732,6 @@ static int dell_wmi_ddv_remove_battery(struct power_s=
upply *battery, struct acpi
 	return 0;
 }

-static void dell_wmi_ddv_battery_remove(void *data)
-{
-	struct acpi_battery_hook *hook =3D data;
-
-	battery_hook_unregister(hook);
-}
-
 static int dell_wmi_ddv_battery_add(struct dell_wmi_ddv_data *data)
 {
 	data->hook.name =3D "Dell DDV Battery Extension";
@@ -755,9 +748,7 @@ static int dell_wmi_ddv_battery_add(struct dell_wmi_dd=
v_data *data)
 	data->eppid_attr.attr.mode =3D 0444;
 	data->eppid_attr.show =3D eppid_show;

-	battery_hook_register(&data->hook);
-
-	return devm_add_action_or_reset(&data->wdev->dev, dell_wmi_ddv_battery_r=
emove, &data->hook);
+	return devm_battery_hook_register(&data->wdev->dev, &data->hook);
 }

 static int dell_wmi_ddv_buffer_read(struct seq_file *seq, enum dell_ddv_m=
ethod method)
=2D-
2.39.5


