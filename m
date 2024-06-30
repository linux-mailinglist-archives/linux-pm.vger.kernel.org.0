Return-Path: <linux-pm+bounces-10247-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF9F91D25F
	for <lists+linux-pm@lfdr.de>; Sun, 30 Jun 2024 17:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D177B20B1B
	for <lists+linux-pm@lfdr.de>; Sun, 30 Jun 2024 15:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5BD615381C;
	Sun, 30 Jun 2024 15:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="QvvW/ybf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85256282F1;
	Sun, 30 Jun 2024 15:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719761872; cv=none; b=cPLbruhGvrVQoF2KhFcDoX+Wa5kK/EHj1YT5fGcIubYGps4RMwdAN4n4BP7dQpG+9EWDcz7wwigDC1ds8DlyVuhBXy8JVN8CgMDaHi7bDjVd14X06lSOj6jagTZ8OeF3JlBA6MrrUuzsxglgyydiUUYTnhfXkYLU55rNPt9HTWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719761872; c=relaxed/simple;
	bh=BSj48tqmwm05Ljg1q373LCH2MRpwkN2xpcXLoYF9JBk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iGv5urRlkNl1iYh/pCpv1y4uHXh3xe+37yDWRzpBXcQBSLsAMT6SKmyYBiY15A1uNJmeOJMIKB6RNNfX/9pPSwsUftsnxwxdX3OpO+KNlAB77pqPvxfouoFEzMQ0BoYCaJUeXqQf7Ljrrs/4VIHihfB0CUl2Lt3gVF6jEXCcNQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=QvvW/ybf; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1719761840; x=1720366640; i=wahrenst@gmx.net;
	bh=y0qOLaYt6Eo8pJE0miDoGlJ+NVS4slEP6icBdDJRzuc=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=QvvW/ybf2mOaJVc47VoFjn+kLT6bKRPFOjLl0FDbezZaLxxyN6lLxLjXyQ07vuCi
	 DCfeBS1pvGZLmG0PpLkxBjT9CpN+nxV0h0FdKJya1xZ/EMjYi9fGZUmowOW7NAkvJ
	 JlYImhGuYqgtad8Zro9iUE2ZkUrdglkWXry3b5D43cbUDnmlrQW02s24sRulFc6NC
	 IeRs47HrkkjFhVuAeae4bh0cpndAzSjpM6wLcRDXnFuguJDvI+MkF/mKPPFQmABqN
	 mI9ve3qe/83QzeNqggYw7sdX+mNht9ysFqdkbdvpivRv+xwAvX4Kf30xzjynSLN/S
	 38Q+ymP3RWGOTWT1UQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MbirE-1rsj7x3VPS-00bUUz; Sun, 30
 Jun 2024 17:37:19 +0200
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
Subject: [PATCH 03/11] pmdomain: raspberrypi-power: Adjust packet definition
Date: Sun, 30 Jun 2024 17:36:44 +0200
Message-Id: <20240630153652.318882-4-wahrenst@gmx.net>
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
X-Provags-ID: V03:K1:QqYv8SsOHT/MdLbf9Bg/MkzNBJG3Ti02c5AdTTzhzh8KgfY/TO6
 3GFk7ubmP9O8Y4OUQ9hmMPTYH1NRskbpJDnJPWbArtxybb4hoSw1mpWG+0YoPbMXehp9GeM
 FWTieW1h9rm3rwusEyK+2Xp4MZ9ZriuTi1lrNJ9r3ybTnlFX/yDh1vNGShEmg5ofsX/3WLN
 ARP1dJaV7XPPYz/YxVdBA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:NDh8fTVKp4k=;hNyq0VO06cMK9NCcVctv1X4zGj1
 Lsa76eLuUXzK+u19YqKuQtSsZ9kqIVkE8/Npmfc/Cdl9bkk3QYcpzkivL5eYKfSUPcSeP2p24
 73kDPH82x8Dbj1Vvev/dzZgGZAgE3A1DAC7Nf0+liOt3Hubi9kVQY9J89swAXtoc35WhbEG5e
 tSw7SI386FITof9+BS1m1D0HA0Q4tMRrIhLsWCcWgBOHQ9EZhodD87sSXzD84+TPbROMh9wv9
 xoFkqGdj4s4rjaEhMp1lZFJZ+JysTPugwKRUzLD0lJQW4ru8Z6VZfzZ+PejfrwzmEXZRkrD0m
 Jimeo8Qr7/SWJS2lRRW8lHcKhYAVe0gxnYC+tqerlwyF+I9TXVPuNeSqAVKKj02gZ6lXcbAT1
 w6iLzP9fdp7VAsLEROx041KZeIeFKnvA1ZeFc1PLpvTf3ts1gj59fDp0pEW5Iy0e8yISqEFSY
 mQsi3m3HPqgZZkzQeX8tkILdQaTznSz9KHL/3eupcNFHA2zXZL/5p8IZGvBvZFn61IBvp+3V1
 QEMbECsb688qUCD5tqoM2ouE7sHKc4g8QjSSBwDmnxjQ2/41yeabJR3cVd5eeqHV1g7duEfMe
 q/N7QBkoUFpnIbRzMUatQ1DQvd7oB8DjSpVzPuXQ83C6bkZcvwXRJ6kJGH45f3fP3ih7Ur0L4
 XNwTSK/DzBhqL1fm6BBvmNjfQ/7AYoFfKBqZYB/mly47QGbA9gw5sPxTYojuGMxIrn/Bi/v/i
 IyE3eCsF5M1wieNgX3WDPueQ8ReTfa0NS96c8YbHD0wjUAktGze0O2eGVMiU0i/eVBmrIqIdX
 bUCT9+V4eIVDB7MCPndCD9+T82xuMpVvtwNnoODyJupVQ=

According to the official Mailbox property interface the second part
of RPI_FIRMWARE_SET_POWER_STATE ( and so on ...) is named state because
it represent u32 flags and just the lowest bit is for on/off. So rename it
to align with documentation and prepare the driver for further changes.

Link: https://github.com/raspberrypi/firmware/wiki/Mailbox-property-interf=
ace
Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 drivers/pmdomain/bcm/raspberrypi-power.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pmdomain/bcm/raspberrypi-power.c b/drivers/pmdomain/b=
cm/raspberrypi-power.c
index 06196ebfe03b..39d9a52200c3 100644
=2D-- a/drivers/pmdomain/bcm/raspberrypi-power.c
+++ b/drivers/pmdomain/bcm/raspberrypi-power.c
@@ -41,7 +41,7 @@ struct rpi_power_domains {
  */
 struct rpi_power_domain_packet {
 	u32 domain;
-	u32 on;
+	u32 state;
 };

 /*
@@ -53,7 +53,7 @@ static int rpi_firmware_set_power(struct rpi_power_domai=
n *rpi_domain, bool on)
 	struct rpi_power_domain_packet packet;

 	packet.domain =3D rpi_domain->domain;
-	packet.on =3D on;
+	packet.state =3D on;
 	return rpi_firmware_property(rpi_domain->fw,
 				     rpi_domain->old_interface ?
 				     RPI_FIRMWARE_SET_POWER_STATE :
@@ -142,13 +142,13 @@ rpi_has_new_domain_support(struct rpi_power_domains =
*rpi_domains)
 	int ret;

 	packet.domain =3D RPI_POWER_DOMAIN_ARM;
-	packet.on =3D ~0;
+	packet.state =3D ~0;

 	ret =3D rpi_firmware_property(rpi_domains->fw,
 				    RPI_FIRMWARE_GET_DOMAIN_STATE,
 				    &packet, sizeof(packet));

-	return ret =3D=3D 0 && packet.on !=3D ~0;
+	return ret =3D=3D 0 && packet.state !=3D ~0;
 }

 static int rpi_power_probe(struct platform_device *pdev)
=2D-
2.34.1


