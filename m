Return-Path: <linux-pm+bounces-11500-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7B493E4EF
	for <lists+linux-pm@lfdr.de>; Sun, 28 Jul 2024 13:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C287D1F213AF
	for <lists+linux-pm@lfdr.de>; Sun, 28 Jul 2024 11:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F4B36AF5;
	Sun, 28 Jul 2024 11:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="Bf4mnsNp"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCCEEAD0;
	Sun, 28 Jul 2024 11:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722167343; cv=none; b=UsnX+JTbhpCKH49n9ACN/dAndjANiZe0+SEWau5BW5XOzYSp8p+pFv/bS8roryKcrpuyoy3PXoZquyPr3piLfINhFX520lPoT9ojvd7MabEZE93aVvslkE8419KQs2ci+IM5YXsQ4VQXdRUTPB3oHSWezc0lokzT0hodUwfpXHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722167343; c=relaxed/simple;
	bh=hdQGsNecjIHD7iUbTioH/2x92C9Kxuj8Xzwr06S7fiI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=absbbUww25HKf86pRGZC0Ff2uNztks+om0GYWPxJG2gZ5R7TfmZGOjfs3k5XrwEPj3q1DB2gBzS59bUJFaTuWg25TaxElGZVFHdNVziIF0vQ36HfDphWZeijHGcJmCjgpM9nnbMhKDeI5PY77nIWKY74Hn0TjfIqJBE30OiGymM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=Bf4mnsNp; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1722167305; x=1722772105; i=wahrenst@gmx.net;
	bh=+RSO60HpkoAR0KgK8nLHKjh1dUUkKYc0+NfSi30ZRwM=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Bf4mnsNpb7eas1zVdSt9O0PprDA5z01alB4vNWXihMPMCU38BakZXxnHECelpiMH
	 2kjmYl6h0EaS/ssuLHE7d0J+GP3K/zMjoguo4RvevFn9e9b83XiIVIZ+MInXhwIih
	 Wd9xYe3MJbWoCLqzOgdOSUSAXu3LdndrC3EqMuxGRyJVg6K/P+yGgPOvbTrfxHSvy
	 Gk3+d2av7WZheuE+llGET9W0drR73RISvn9qlMD7CbEkrMju48ifHNK4O2/JNQpGz
	 NdGyM2vmJcFWrGKGTUB2mFb5JHYTIXrnATKDvnvWUAa2bc/5Uk77NamxVQ5QBjL8J
	 UZ+DIh/ESW78Ms62KQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MBUqF-1sQ2qN3JSp-008ATd; Sun, 28
 Jul 2024 13:48:24 +0200
From: Stefan Wahren <wahrenst@gmx.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Maxime Ripard <mripard@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	Minas Harutyunyan <hminas@synopsys.com>
Cc: Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Lukas Wunner <lukas@wunner.de>,
	Artur Petrosyan <Arthur.Petrosyan@synopsys.com>,
	Peter Robinson <pbrobinson@gmail.com>,
	dri-devel@lists.freedesktop.org,
	bcm-kernel-feedback-list@broadcom.com,
	linux-pm@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel-list@raspberrypi.com,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH V2 06/16] drm/vc4: hdmi: Handle error case of pm_runtime_resume_and_get
Date: Sun, 28 Jul 2024 13:41:50 +0200
Message-Id: <20240728114200.75559-7-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240728114200.75559-1-wahrenst@gmx.net>
References: <20240728114200.75559-1-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:L7OrAzJpv8XxwcKtjfsgVpdvZhEK3mZJ0zOlR3NCxGwCNbbV5LC
 8cqO/xoX4g564Y7hTk0eAm3PoETG0D8w2dBEDeMSYKCeSCR4sini4theANuPxmpissjbvgY
 jszIeE9YldH+vBI4cyfjzh3g8NavBM+EZf1cTEcZUKng2IT+dSN04cUnsyTbc2fRUJOO2UF
 iYy/6Tvbb9HwH9/EQQlhw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:AkUL9GoOT/M=;JWUAOx/K56tKZf3lNCIdFDNa411
 a3BJlA29z65QTlZp1VV7P5OecrH6EtgTs1QxhRirqH4yJftA6EmHaaTHgUH1o+QPmMQR9TIws
 b3Zmc0y5k8N6Gy5ES9SRCwlLtKDaFPAVIknJYBQWwu1wGf4uHywl0ZU3VFLVyl3uVfDQxVw6j
 39PM6AuDu61lclmaWdJQ3z5mI0MhYC9TH8NmLzJkGq/oO9zrxYBtSk5RVs/n29fhSb/TU2Irh
 vW1n7S8IS9+eChB5CwueQsuiRE8PFKppR3/uSS07BSz7yGjuYcecTyRdh77H7r1NiWo9OF5Yi
 L3bOSbZdFcfprp99zfJQFb+6zZlGkLkh1zN+H0qJLR2OfkWjPlsgVF7AkTRHXKLQRiv9oIhDw
 os3dq717Z8lWQIFAr+qpUQbzui2gVBHQunPls36WvmJSyExoAF4KlZBo2Huc85bQTuyrR4txO
 swquAlNSMF6WqyNvZomeQBUMn9dum7M5FBDpTJ8qjRQzOPkW1jiz4nm08TQCegAu6YT8XpIIN
 NZED1j48KVunaXFZ+GZgpjuvFeH8ByJaXFn0Y/Xgt6QXbg9KcdXcERtfGARga82IOOpc8ov1m
 bc7PYRUhLmHLsUtU7UVNrE1r44KqlwYaXeTWpavkUOJQQsF58zrqCp2dBbj1cVb6LZwEOEEwA
 6OyC7xLwMDZ6ImFtaafim3/QNkz3JTHjV61GvujcQNdfuDyAdOyDsxI0dvRySdPA7nGosuHKB
 gLBxcSxjiXDuEzeooJ4ejojkXxyORJMtruh04uHvHwd27G3V1rjL6r77gXKz010FmQPrskNTq
 zzJYpbdp+9cfeMKeTZnl+Sag==

The commit 0f5251339eda ("drm/vc4: hdmi: Make sure the controller is
powered in detect") introduced the necessary power management handling
to avoid register access while controller is powered down.
Unfortunately it just print a warning if pm_runtime_resume_and_get()
fails and proceed anyway.

This could happen during suspend to idle. So we must assume it is unsafe
to access the HDMI register. So bail out properly.

Fixes: 0f5251339eda ("drm/vc4: hdmi: Make sure the controller is powered i=
n detect")
Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 drivers/gpu/drm/vc4/vc4_hdmi.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi=
.c
index d57c4a5948c8..cb424604484f 100644
=2D-- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -429,6 +429,7 @@ static int vc4_hdmi_connector_detect_ctx(struct drm_co=
nnector *connector,
 {
 	struct vc4_hdmi *vc4_hdmi =3D connector_to_vc4_hdmi(connector);
 	enum drm_connector_status status =3D connector_status_disconnected;
+	int ret;

 	/*
 	 * NOTE: This function should really take vc4_hdmi->mutex, but
@@ -441,7 +442,12 @@ static int vc4_hdmi_connector_detect_ctx(struct drm_c=
onnector *connector,
 	 * the lock for now.
 	 */

-	WARN_ON(pm_runtime_resume_and_get(&vc4_hdmi->pdev->dev));
+	ret =3D pm_runtime_resume_and_get(&vc4_hdmi->pdev->dev);
+	if (ret) {
+		drm_err_once(connector->dev, "Failed to retain HDMI power domain: %d\n"=
,
+			     ret);
+		return connector_status_unknown;
+	}

 	if (vc4_hdmi->hpd_gpio) {
 		if (gpiod_get_value_cansleep(vc4_hdmi->hpd_gpio))
=2D-
2.34.1


