Return-Path: <linux-pm+bounces-12666-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 263CF95A6E5
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 23:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2CF81F23960
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 21:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F036D17B50D;
	Wed, 21 Aug 2024 21:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="Cvg0iNSD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86CE17967F;
	Wed, 21 Aug 2024 21:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724276499; cv=none; b=fxjQDJvsaScEd7MbY4hbqASetXfTQvH2DdsUFZTYCvgIq8+ec8sbq0pd6keCRkEWi3V0GobHoGHJZ95stDqB/zUf45skQUvjIXAxXAfFgUBDFfTG49HOiluwdXRs3XkQ9AgSkph8Kka9kD6Ib+HgefwYklU0UwgxroAj83bMRD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724276499; c=relaxed/simple;
	bh=MM8bCrHr3sp1qPuqI9phx9Elttw36dc+mou3lvRBSJs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BgEjnSuaClZ9ybFifWg/Ltz2dZ1PtQaHMXDvoml/RUd0OVA43A1H1jscA8X+R9RBtyF3SthCzYp7snWhBXa7Vz3XY953K0I2LNAacdW+FeYCrIOdoLgC4hGxnlr1HL5i6MrnK2PdRMYtx9/wzabv/4/SX+wgJYi4Ya9m1xDTH48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=Cvg0iNSD; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1724276469; x=1724881269; i=wahrenst@gmx.net;
	bh=CYaxw6OqWnumzsOX4pTskLMeKldjXRkPxVS7XND9ynA=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Cvg0iNSD3lobwyOQRxY3291ZvZ3RzXe8nCiwTo+VaSa+C2WrqN41eduqE3ScOQq/
	 Soz+iMTaoNbAT+n5tia/IPtaPCi+xQxhR36xtlwq4rh3nJ8iYm2wz0hT4aT8X2Mkg
	 ogUTSXaMQUpvRfKYTK97HMxbh0iuEq9cAIJMFb2+RGLrtWrBV+c1gknboUS2fmCHO
	 Ba/+tmlqXlNR0VLfVGBmThLT/SiE2/toGRaajt6BhwtMRM5M969XVx4xikoVNO45f
	 YJ+1hAfOKYp3sImcq+7hRi2bw4z/HnYYEF5ZflBT1cUZadm4VJXVisoer5L33ITEM
	 4Pc6c4ePXzwBVypdxA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M2O2W-1shQF919va-0034DI; Wed, 21
 Aug 2024 23:41:09 +0200
From: Stefan Wahren <wahrenst@gmx.net>
To: Russell King <linux@armlinux.org.uk>,
	Doug Anderson <dianders@chromium.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Maxime Ripard <mripard@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
	linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel-list@raspberrypi.com,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH V3 5/9] drm/vc4: v3d: simplify clock retrieval
Date: Wed, 21 Aug 2024 23:40:48 +0200
Message-Id: <20240821214052.6800-6-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240821214052.6800-1-wahrenst@gmx.net>
References: <20240821214052.6800-1-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:h/VZtsIWcUY12L1wpbcwbKWJ694UX0+mLRWUIBBvEgAAesXyQrv
 1s3VjliBqbjqDa7UOwwHdMamlBfrLd8f1xAnXbC8rBDV6XiJrIrMkSaY5cX6o/LXt4Kq7+R
 RCqB8+/HahurNItDvIwMTOy5x36m8UgUNUD2J0bPyDoI7F1jNYD1w3ozSBFpIpnOay0M26X
 QIJ5OdwUtJCb15T5xWk7g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Fc0XG+t8WVo=;0+sC399aSpdqdN6OijPXgeXP1lM
 37ojsJGp+Or4UHep3zHle090l7QrITFyo28t/VW1ePLPcOuMcNJPHBONnn3DMeZkovivi/71s
 xmuCe043h+oXZANUaOi9rKuMXHfpaUXfCqJjQwN5d3n0sgTiGAHLx2m7FFyDMLqEP6PR3BLBU
 J6cxTMM00Jex/qAqkD7cqI9ruwzt7GdFqlQIFJ3OZTJZesaJZtZYcztR63sKl7xOqUzGMY7Mu
 XJhjRKzPmk7KQXWAGBkWNv8TW+wCH/v7wFZkqDaM/c1+q7BNwa3ixs5+a5IuwKIL9JPZnrUBd
 ZXhFVY5K/viwOuSOMCVWR44YPXDdGcx3iAOmLdJpJeOTLIxcogLrulESd5aRE/WF2zQFsc3Tw
 Vr0m4IBxFiVS3V0MkLN5wvGMvtcWhsw2IBHmr6atzE96p23mL8LSn9FrdRdl49UPtSwT48eFr
 9kQL4fQvObVhxoAsH2v0miTqqywBQxIwleOKEP/giUQ7nDyobOk4+TMy/4Th0Bu8fQOYPoH4r
 i3KSutvsSH7N6kb+tD2Wf1PQOk12/FRO9oUQL/hbfgzMQzDY43ieCwTgJQ6mdkZDrwHNP4rhC
 /l8kgE37R4POrxo5/uA8WvBYssaBtKX1Ot3pErcyOySLra+7hPwFcdD7Hq/3fDzv/2HntXw/J
 AiSklyGe8UK7Q5OFC27NHsEA65DLJJlHmkBKRnhvLhdaSI9HoL9NZQBpqivv7QApfoMpxIV76
 2d5+fleTg3XGCcTP0cW/flpTX26aXEIgKeJY9oSYvUcMcRbG4J8SkFl66mfEDJEUtz+5KGp06
 mQcgX0o1fLnCqQ1f526evBEA==

Common pattern of handling deferred probe can be simplified with
dev_err_probe() and devm_clk_get_optional(). This results in much
less code.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
Reviewed-by: Ma=C3=ADra Canal <mcanal@igalia.com>
=2D--
 drivers/gpu/drm/vc4/vc4_v3d.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_v3d.c b/drivers/gpu/drm/vc4/vc4_v3d.c
index 6e566584afbf..bf5c4e36c94e 100644
=2D-- a/drivers/gpu/drm/vc4/vc4_v3d.c
+++ b/drivers/gpu/drm/vc4/vc4_v3d.c
@@ -441,21 +441,9 @@ static int vc4_v3d_bind(struct device *dev, struct de=
vice *master, void *data)
 	vc4->v3d =3D v3d;
 	v3d->vc4 =3D vc4;

-	v3d->clk =3D devm_clk_get(dev, NULL);
-	if (IS_ERR(v3d->clk)) {
-		int ret =3D PTR_ERR(v3d->clk);
-
-		if (ret =3D=3D -ENOENT) {
-			/* bcm2835 didn't have a clock reference in the DT. */
-			ret =3D 0;
-			v3d->clk =3D NULL;
-		} else {
-			if (ret !=3D -EPROBE_DEFER)
-				dev_err(dev, "Failed to get V3D clock: %d\n",
-					ret);
-			return ret;
-		}
-	}
+	v3d->clk =3D devm_clk_get_optional(dev, NULL);
+	if (IS_ERR(v3d->clk))
+		return dev_err_probe(dev, PTR_ERR(v3d->clk), "Failed to get V3D clock\n=
");

 	ret =3D platform_get_irq(pdev, 0);
 	if (ret < 0)
=2D-
2.34.1


