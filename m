Return-Path: <linux-pm+bounces-10249-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D2191D265
	for <lists+linux-pm@lfdr.de>; Sun, 30 Jun 2024 17:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5821A1C209A9
	for <lists+linux-pm@lfdr.de>; Sun, 30 Jun 2024 15:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F22154BFE;
	Sun, 30 Jun 2024 15:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="qGzzQJuB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99813152E06;
	Sun, 30 Jun 2024 15:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719761873; cv=none; b=kvC4tiGRxnbJw+r9drpe1xsRp2fH1mG/xhsRantfrvWmb24Ww1QrEjNNPWCpb6YDIELCxrSaXll51jmzK3Sm41+eP55fzlIU3sUmKeVyVBoiPXP2/fHKvigZIM6bwgDhRMuJxzWXQJgtdvWfjVbqd4UgSjyh/pcL3RPJfRAq0MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719761873; c=relaxed/simple;
	bh=3Z/M5cg/J/IA9+p9ob+z7Y78E58DUBaEpY5pEblPWjk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UkdQelP9OmMA6RDQkLGu4oRleB6GdXXhvQrslqjrT4g3+R9XDcvWXpHS3dZQM5zU0OfksMMHBks8eoiI+t4O+XkaEYMyrvWiUoypNlCct3pJ73Up1tKteHAvP4IqvMklQ5HI4/jvrJ1vIJY/K2Y4o+LijzkNFNfvW4vDCeRnsFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=qGzzQJuB; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1719761843; x=1720366643; i=wahrenst@gmx.net;
	bh=g8bLwDV9vv1b9MjKzssmd/pW+2/RUfnLBRsyg8CTzsY=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=qGzzQJuBaoggAKtGrq8PdHltRSA+ZJEhsqNuVhNzZ7MQcWP8si8dNNOFewgGaY2V
	 gWpQ00aFkvrLUmT0LBVQ+F4yCN13o4Tz1Y3UKNJRDjdCjSSsDZC1BH735Kai3h3w+
	 rk3PMPpUEgDIQiSkPhkC/hfNCOTtFzDvlUR3Z4cA7L/D5JGH2uW7bOrJY0vb4+XLA
	 V7qg7FixqNeYnMJG2D8YBiRu+HVuQctHjVzNFxK/eVuJn7GwAAMMiwKjrDHJ4DKbC
	 GYlvj5QwZoXr53rdnD7ZeRDj2Kjv5xYcittddBB3CkdGU6ajJ3ppiiMAKI3tONvW1
	 92nnXAbToM6oKfs0sg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MoO2E-1s4DqU34eG-00qLoN; Sun, 30
 Jun 2024 17:37:22 +0200
From: Stefan Wahren <wahrenst@gmx.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Minas Harutyunyan <hminas@synopsys.com>
Cc: Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Lukas Wunner <lukas@wunner.de>,
	Peter Robinson <pbrobinson@gmail.com>,
	dri-devel@lists.freedesktop.org,
	bcm-kernel-feedback-list@broadcom.com,
	linux-pm@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel-list@raspberrypi.com,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH 06/11] drm/vc4: hdmi: Handle error case of pm_runtime_resume_and_get
Date: Sun, 30 Jun 2024 17:36:47 +0200
Message-Id: <20240630153652.318882-7-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240630153652.318882-1-wahrenst@gmx.net>
References: <20240630153652.318882-1-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:o69+hBbDReia1Doo4Ua3Ap4tjIE5FyVFPvweuwOPKrNdWE2Eyje
 By+/XWKIkUjXGa4HdY4rDd0THstR9kLGO9WtHySi849Aq8O8XA0QTYI1kuLhjGrc2pDXAxV
 Rnq+qCbeXhbq0oaML/vuatyAXa3F2q54Y4s7gx1Ss/AqUnBGUfUaCMExkbfCYl2qMowQT6N
 WX1CXhGE/fU4mw+tKg2WQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:NDt+LCOQYCA=;vGODWVysfJmV2IQbHHklMS9vJx+
 SH7O3KrTaP3EhoIqV9fGlnhmH1+b2Vsd5E8JUkyUXWNuYj49dgZEmD3sVKNIfy0rGA+BnSlWw
 bohaFfTzLm2qMSEk7ZVuTxI2/4Lj9Turh4sXwHzZXbDKwGryOu9G4Wn1K6nM9DLGWI8fYKni+
 JB1iC8/9Z9V7TRVxIflCDnThLTRzTaTdD5fo2j5y7gt+B45duZ31yTl/TNDteYbb60A93rUFH
 zOCUwgZDoeXomGbFRSmQMWoGsvSW+BFrctwUI2hb5w09h1HmDv6/y3e489MdKlzdIInBbgjXM
 t1mQaOl9TK5roixBzDXdkfI6mTKUyVKe94lF8ZFhhvhMSvyduUyQ4rD597w4HxpL1b4/EuhK7
 QuuYuAaaOwjes5WRORS7XYJ2mz3ESub7m2b0usrX60HKbN5rwnB2LRg5OKYEcSsiEw9BLyC+6
 Er/CwjWf+DKk46xsVdblADf8B69FeIzmorRUxV7Er69s3IFCsqVXdd0BqdmR7dYIdVSlUsdb7
 iHmz7H2iOPnXWNjGivMU1ywfwOhhXj60wPm+KyPeb18Zsu6TFstx8ygeAFs/LT2AY0JYsQnoT
 W9rJTjSXavcMUUJv1YKPHKrEimrOvJaTexrnQe0FjRthC/A+CS18vSrvYaDllq2ORmwb5S8iW
 Vuc5ROWWSMRUMA6svk6Sr/jXiTvbHgGt3snp/5FxNbj6wQggN2s8MMOmirkmiASRY4qwkbZXh
 KnidWOdaabSuyzvjoHdtonCXhTOf0CLtU/4ma2QsW25f1YffG/OGbbQUdgfgHhGOXF54/yu92
 pXmAaYiNa1gDdD9DzH8TFRt8ve4lC2EZI2XvW8a9g4ZVQ=

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
 drivers/gpu/drm/vc4/vc4_hdmi.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi=
.c
index d57c4a5948c8..b3a42b709718 100644
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
@@ -441,7 +442,11 @@ static int vc4_hdmi_connector_detect_ctx(struct drm_c=
onnector *connector,
 	 * the lock for now.
 	 */

-	WARN_ON(pm_runtime_resume_and_get(&vc4_hdmi->pdev->dev));
+	ret =3D pm_runtime_resume_and_get(&vc4_hdmi->pdev->dev);
+	if (ret) {
+		DRM_ERROR("Failed to retain HDMI power domain: %d\n", ret);
+		return status;
+	}

 	if (vc4_hdmi->hpd_gpio) {
 		if (gpiod_get_value_cansleep(vc4_hdmi->hpd_gpio))
=2D-
2.34.1


