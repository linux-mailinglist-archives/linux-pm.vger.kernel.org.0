Return-Path: <linux-pm+bounces-11498-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5838193E4E5
	for <lists+linux-pm@lfdr.de>; Sun, 28 Jul 2024 13:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C28781F21CC9
	for <lists+linux-pm@lfdr.de>; Sun, 28 Jul 2024 11:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55CE44084D;
	Sun, 28 Jul 2024 11:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="mR3VAOxX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306853EA9B;
	Sun, 28 Jul 2024 11:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722167207; cv=none; b=fMOmjyCEmCWbOQjeTAnVWNMMAU9I329JPO2wNd1mz1nLpjmszKiSKFWOhV/VFuOF/VQ9JsrkkBwgedV17aaSzd2ffXNcXVtC6mmrmkcCvPHNGfi5O9rPg8f4pYjOV01djYq6IkY9CkQdq/M7cQKaLBaftyR4Fh4Gzs4QJghSv4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722167207; c=relaxed/simple;
	bh=qFY3vfMoKE10Rq8poh3ATZDeos6UriTblK0RtIhr9ac=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YwFJs4vkNNAxjieuxHp9UMrP1JBnEbr7zxnmq9gt7QRRlWkPYDoH8GNLmwRc3UEiuNFCH2ob1oxLxTkVmd05IZwEIPMp11M3j+1+Z+2UKK9ru3BW8h+aFixynpZqo//5shlZiNpYTyGmEPIIh2k4HNnappR3Qx/TS90u9Ud1rCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=mR3VAOxX; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1722167177; x=1722771977; i=wahrenst@gmx.net;
	bh=MUjx857aVJb3m/BIq/jv+muXKfBK4aj/UlImOJhlQl0=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=mR3VAOxXChhr2y7LUN+ckfBTyxpKYXrD+ni2xc2ekwneT+3Nxrve25RRfRAQseNg
	 iUxkajNMtobvAhjbZJ1avjqGnNz0V8sd4ruz/mucpDTeIIpWKEZ9PfK95sWEbM+Jh
	 bXWfezMbI1klArtufPyqG8jrw5q0GQXMJGDl6378a7zyyydP14l5iQoKJAjz4YTGu
	 fZH+0veWGv+PdlBFltGuMwkxMpIPp1X6HFqd3yp+sxUlyVSpMlEe+XWnhiV30ZHEX
	 uKvcTyoNeEF1qcFnyNPoSrgJ8YrGHsJvT+54b1fHQtrU4xWVy4bm/Ot4szevozmEl
	 XpOTbWm1eTzML45r6A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MmULr-1rqPsW0GtF-00dMDw; Sun, 28
 Jul 2024 13:46:17 +0200
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
Subject: [PATCH V2 04/16] pmdomain: raspberrypi-power: Add logging to rpi_firmware_set_power
Date: Sun, 28 Jul 2024 13:41:48 +0200
Message-Id: <20240728114200.75559-5-wahrenst@gmx.net>
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
X-Provags-ID: V03:K1:4Eq85eFpyWQtoeOdYaR/mTT65Ogz1QD7be1K3QBHel9skaxonHe
 OTAXpGmln6oRRCUb9/Rjlq7p4feQmQFbl/SAJNdc6K3tBfH/XwL5ySYhaCKHVJ8AMka+AEC
 naQazZaWITnN7A+4GI63w6/SbHKS+wDSJIyDfA+yD6aBDfPaPGJzhTyiTMuWA4FtsIBZsI4
 wk5HudZs94o39xgwnJGjA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:03uvZQHg528=;rz4aTT//fenmms3Woof0gGSTyw+
 lUV/3KaQ/BCAmeLvITzlwih6WwNbnrcURhbeg4m5FWFK2r6jDeedK9NBm3xZ/XGX3FIl8VS1D
 mrGK8YDTI1IGBE4pvS7kGT5U0WimMZiFIoKqyp0Z00slHWDIjE8Ze+MJoH7Spm5Ms/r0fXcZM
 njL62H6glutmu73XxUXlygIHZ5Nce3blNtbeK8uWtrkIx2e8StH0bSqFVGpoxmBZ4k5XLBbOS
 aiD96Py/08eaEmpcqj7DAxWB0KGepe3cwQrDUh70IC7xmqmfi07vNtb1pv/Pfrh8KRiqgLnLO
 n1HfV7C2zZzxocir3JTxbBiRIELTDi7yV5Z2HKpHbb2uCRLjypFi0iAqYlMuAvDLDKgFJ8ng3
 In1BfsCXLUodpIXQz0MoO5Aeox1SQ58C+cyKk7pBQV32iIZWtET/OK8zZxYiDHXXzvz/h6HY3
 9yEA8LpP0IukjoVdd9hAGjzDLvXI8YZ5dWL5OHVSOyywPJwgRTuZ91av9AJCQClXp0KHfwMtZ
 /FPHJy9UTtdRf6hls9swB3PZPRltlLoxijv4xnPGgYhGJU31d+WozfpGMZsCI2xmwLlmbv57S
 B7mfxwkQd/fTc4j9/wHGjIBemKIS+G2yxIYFv3ebtTWwZGrlnyAvInGQMCCLH3+7kFBOejscA
 AvfEfw7SmEYERxHS4uRAfqCeV0UwXOgsb/HqKRdnfjJyDzprpf0a/qlXGGiDnOm63T7SPizDV
 Y4QorlDonW3GAamN3z5HYbnOF9c+P3Gy23RND8UT+gVc7qtzMA0yHhx22uyuFlG8OB1pCRItU
 wyj+ZF+XipA3X6ye5dQDm2mg==

The Raspberry Pi power driver heavily relies on the logging of the
underlying firmware driver. This results in disadvantages like unspecific
error messages or limited debugging options. So implement the logging for
the most important function rpi_firmware_set_power.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 drivers/pmdomain/bcm/raspberrypi-power.c | 34 ++++++++++++++----------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/drivers/pmdomain/bcm/raspberrypi-power.c b/drivers/pmdomain/b=
cm/raspberrypi-power.c
index 39d9a52200c3..fadedfc9c645 100644
=2D-- a/drivers/pmdomain/bcm/raspberrypi-power.c
+++ b/drivers/pmdomain/bcm/raspberrypi-power.c
@@ -48,33 +48,39 @@ struct rpi_power_domain_packet {
  * Asks the firmware to enable or disable power on a specific power
  * domain.
  */
-static int rpi_firmware_set_power(struct rpi_power_domain *rpi_domain, bo=
ol on)
+static int rpi_firmware_set_power(struct generic_pm_domain *domain, bool =
on)
 {
+	struct rpi_power_domain *rpi_domain =3D
+		container_of(domain, struct rpi_power_domain, base);
+	bool old_interface =3D rpi_domain->old_interface;
 	struct rpi_power_domain_packet packet;
+	int ret;

 	packet.domain =3D rpi_domain->domain;
 	packet.state =3D on;
-	return rpi_firmware_property(rpi_domain->fw,
-				     rpi_domain->old_interface ?
-				     RPI_FIRMWARE_SET_POWER_STATE :
-				     RPI_FIRMWARE_SET_DOMAIN_STATE,
-				     &packet, sizeof(packet));
+
+	ret =3D rpi_firmware_property(rpi_domain->fw, old_interface ?
+				    RPI_FIRMWARE_SET_POWER_STATE :
+				    RPI_FIRMWARE_SET_DOMAIN_STATE,
+				    &packet, sizeof(packet));
+	if (ret)
+		dev_err(&domain->dev, "Failed to set %s to %u (%d)\n",
+			old_interface ? "power" : "domain", on, ret);
+	else
+		dev_dbg(&domain->dev, "Set %s to %u\n",
+			old_interface ? "power" : "domain", on);
+
+	return ret;
 }

 static int rpi_domain_off(struct generic_pm_domain *domain)
 {
-	struct rpi_power_domain *rpi_domain =3D
-		container_of(domain, struct rpi_power_domain, base);
-
-	return rpi_firmware_set_power(rpi_domain, false);
+	return rpi_firmware_set_power(domain, false);
 }

 static int rpi_domain_on(struct generic_pm_domain *domain)
 {
-	struct rpi_power_domain *rpi_domain =3D
-		container_of(domain, struct rpi_power_domain, base);
-
-	return rpi_firmware_set_power(rpi_domain, true);
+	return rpi_firmware_set_power(domain, true);
 }

 static void rpi_common_init_power_domain(struct rpi_power_domains *rpi_do=
mains,
=2D-
2.34.1


