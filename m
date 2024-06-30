Return-Path: <linux-pm+bounces-10252-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B55DB91D270
	for <lists+linux-pm@lfdr.de>; Sun, 30 Jun 2024 17:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6034E1F21277
	for <lists+linux-pm@lfdr.de>; Sun, 30 Jun 2024 15:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9CB155A24;
	Sun, 30 Jun 2024 15:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="o7ZIFkdy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E047515383E;
	Sun, 30 Jun 2024 15:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719761874; cv=none; b=g9ch/67kYs3eSB1s3cn7jro1tfrnBScqc8lTDf7gH12s55SRdJxNIjtKce1nI6b89VP2S3bdGfl/i+QfBnt6LM+uNVTrDNTymjyM3tBozNr2XXjff3cV89H27mN6/0cnG2flhcqjWFFplAag4Z9YNnwKv0IRGeAJ77Nkvg+muns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719761874; c=relaxed/simple;
	bh=OepjnN1m7XIniciruK8E2vJ6wGJGpCI6r606OxLFd24=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l4Bp0Paw9E9uGsWJvulRJQB/jAeqWoq0WSw5kP4Ut9L0uwYu82iAoivLFJatR16eBo25/QuX2zjibpNTaIUINyYy+VgwmSQM2ocs6Jw991IWIX8x908SdAer4RcjiS23b6iTeBK7cA4RnHnciAqhOdddRjUdrunjMm+alWR8Zhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=o7ZIFkdy; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1719761840; x=1720366640; i=wahrenst@gmx.net;
	bh=uvy/JYKDHmXcPICPfORiHDhkAZe5s5Om1p3LDeO8diw=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=o7ZIFkdyeolSFgsqSlg9F/907y+3/o7oltU/Jq7EwFbSxRgN9WmwgYBH7zyUedaA
	 iX5zayU7f5hw1XFRSfb9dJzB2C4L0atfWCnUIEfmZHGbb7YnrQFDYKThhhlyaWmDX
	 Zfe4+6HdzhCMfMgdM6bqCm/DumILbrYhN3daXBiqKp2A2fWg0lNSV/qWv8daZ+Wxf
	 1XS3snIsP2fA4YDE7wBWZMQfnUC9/vmP3TFSBoZEw2KrK5q2dJasPZNgW1j8gSm8v
	 GEq5qLwVKmGWYqBPnG02Nwc42bd07SX5Zt7eZERafXerVIstRn862hdo4gu4rjLQt
	 9A/c57oZjPZ1k0BmJg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MdvmO-1rqXH42uNa-00ZIdt; Sun, 30
 Jun 2024 17:37:20 +0200
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
Subject: [PATCH 04/11] pmdomain: raspberrypi-power: Avoid powering down USB
Date: Sun, 30 Jun 2024 17:36:45 +0200
Message-Id: <20240630153652.318882-5-wahrenst@gmx.net>
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
X-Provags-ID: V03:K1:22tg+yWWqKf6rCi94aIzD/RkT7pXmbRAAhSxwf6W8WcCzyNMjbd
 j47KQebfJCVLSl1XFpvwPcIB8kmB6vxytQOXHOoKX8vpukqcVyRvtoMxZctNIgUXZrZsbyP
 M1Ez1s8XIAFhhBqA7HoCa2qTcc9wcGRMyyFUoiMebKnLHrL9JQpT3spS1oOrMAtG46pk3fq
 T3JonfyI1KZaJXlZvgoog==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:o0N5jBQm4iM=;q+71ifQ2Zv2GDZeVPGzKI9bBQMg
 ITd5Q5iGfSSBWp1p+vKU/AGRKQRK0/1CRitQt627JVfEC+5K6pRuadGo6eJOMsKAtbFZqNVeQ
 lhOHahQLH8rAycR2oLJcj0QWrzH5OOQU7p5oHeG7WHkQUjEV7W2HoPpZtw32Wv8AsteukZPvG
 a6wu0r60xiYh3Lam5CeGSMxW7GhxYmMT2zDlu7YJUDRmUcEHSBDoUgHZ+y7dTSQexufltzMTL
 emG8cSNkyd+S8kvewoKGpWsxttU/+FVoim/lSrB4Mm/mPkQD8FB8IcE0Ya+AJFZ9WW06WkfY1
 9Cm+rrfNlrIs3Q6DR5Q3G91yw2KJBgfJlu6bznnvx/y8FmfMXIN5Ygq4lr6UdN4ikQrc5H1xi
 PMGylNcIWhchhU0R+n7gFWY0CqlJ4uYg64gukNxTkjQBTj0yCYl3ZKNsFejBbArpGOl80JJh6
 5L5kNRFt2yD8M/OTHGO+AuxATLHgDbkr564L9MOXV1jEXJQF9F/mdQnumfsiG1HjsltqT9qDE
 4o/QkeaB4AINfhLyW3lHskid4rPKLH+PosKU4BEUgu6XKT2Y9tPCPifMB/EKQ/Rdy+qDeLl+t
 9yrd8eQqAUTSCoxynVkqNmNB4+q7CqSg4EFEvJlYPoVy6BSGJREeU0NBCl9HrvMCCwxfV6sgK
 /m8zFFKSppQdn1yn07r0fSXPNCxYYRMfXHEPNr0WzFarq3I+ceGxHfAn81QWO72P87aBTA314
 o0pgOZ6eaWF/eBiPrBqPlKePK0OPlurpagJ9qr/Wbgr6sxEX75mWLGZr2biwlnyHRmz4fUAz5
 tV4WK6UkzNRqhEgrwXuILugRk3uih7RHVUhbDt44Wg690=

During supend to idle any request to power off the USB domain
leads to a timeout. As a temporary workaround don't register
the relevant power off handler.

Link: https://github.com/raspberrypi/firmware/issues/1894
Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 drivers/pmdomain/bcm/raspberrypi-power.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/pmdomain/bcm/raspberrypi-power.c b/drivers/pmdomain/b=
cm/raspberrypi-power.c
index 39d9a52200c3..3e7b84006acc 100644
=2D-- a/drivers/pmdomain/bcm/raspberrypi-power.c
+++ b/drivers/pmdomain/bcm/raspberrypi-power.c
@@ -86,7 +86,14 @@ static void rpi_common_init_power_domain(struct rpi_pow=
er_domains *rpi_domains,

 	dom->base.name =3D name;
 	dom->base.power_on =3D rpi_domain_on;
-	dom->base.power_off =3D rpi_domain_off;
+
+	/*
+	 * During supend to idle any request to power off the USB domain
+	 * leads to a timeout. As a temporary workaround don't register
+	 * the relevant power off handler.
+	 */
+	if (strcmp("USB", name))
+		dom->base.power_off =3D rpi_domain_off;

 	/*
 	 * Treat all power domains as off at boot.
=2D-
2.34.1


