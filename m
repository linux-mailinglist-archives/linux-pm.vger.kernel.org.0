Return-Path: <linux-pm+bounces-10257-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F01091D2D4
	for <lists+linux-pm@lfdr.de>; Sun, 30 Jun 2024 18:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BF8FB20B77
	for <lists+linux-pm@lfdr.de>; Sun, 30 Jun 2024 16:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B16154C07;
	Sun, 30 Jun 2024 16:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="co+khgJL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5842413CFB8;
	Sun, 30 Jun 2024 16:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719766442; cv=none; b=KbzySNF46Z8iiIitffMi+0+klZSaTUff/zO2A/xOM9COaZJf1EyTTiUUThCN+msIrkV/Hb0mGA4SROPX6KqTE2q6qKfCiO/ptTdYMmp9FojTuYQClEudD1VcCzSgeI2aiDRRymztPba9Fbe4fl9zG7kv9VUiTafqAgkVCFVCk6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719766442; c=relaxed/simple;
	bh=IDz8sfG2rJ2XDtyV9KlADYXg9I6EzDZ4IZkpSVQew7o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IDDWRlrdtwEG1tQ9hMm36bTL6nHkjVQ9cbHFPUoA4ZCTAa7pD1i7XnyOHw3M1p8kqoVP6zVpw9Gc5JdqScNCmt9znHQugd1sj6eSinQ6eU34QBczAV9TIZtJoJTegpEUJHYebCQjWtxmtcuPJ1LqtBFO8QAHGYkyZcnwC1zjTbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=co+khgJL; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1719766404; x=1720371204; i=wahrenst@gmx.net;
	bh=x6X/JBGaDbXhfz2zCdgdBC9Xbw9KpBWry+heZSf/vYw=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=co+khgJLL3I35VMjh/AKMVnmw3JPmoSsHTQRnoawNenZfKo4FyiEzMwGWe1Sy5ww
	 hR6AIrhO3oh4hFkXrLHHIVlDKTHomfo+fUc9AghNyCeJ9vhJOlIY+y4cEWcsYXoKN
	 jJbugRnYLl3ly/aZKQDKzTEYtRCDlHfOntQcuuyl6f5rbhfgOLi8pvDqJomIT+rIN
	 rFJ0n/l1jY4QzzL+QQQYkR7VMcTigBfxsxmffxDjXVcLlK1pXB6B2Ap5yPDs1pt6O
	 gxTquMIZsvzELOGK3xlLE2qJiFGQqMyLJs8dMXlWkq+zpeE2nf/ZQnNSWhPr3O/q8
	 73J0RYsy35yFwRUTzw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M3lcJ-1sOEv12IFf-002P3U; Sun, 30
 Jun 2024 18:53:24 +0200
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
Subject: [PATCH RFT 10/11] serial: 8250_bcm2835aux: add PM suspend/resume support
Date: Sun, 30 Jun 2024 18:53:04 +0200
Message-Id: <20240630165304.323095-1-wahrenst@gmx.net>
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
X-Provags-ID: V03:K1:4gFUJsAqzBEe0Ecm192F+EOC5bzkfojzIoxo17BhwwQMZSUayGA
 aoHR3ququVF0cAZgp0qNUz+67nJI3An977H1iEQn0dvfqUUSZAkNJd0Cge4khmOjgHPODAW
 3fxZ+TBPZSHDWvrKdOb4YOn8Fkz6nb9woQGsYOtRjr1UmI7SgLZLatvKan1jOGJjZvJFbI6
 7huOwk+6E0lfTHXsikFhg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:RC+tt6aEpOI=;1EW8hiWdl4BGJhJ4wQfv5AMukc5
 ZEeVMD/okghGbmPzVHi0APqS3iWRMF1wKmhloRCbelkkAJn1Sm/Vvn98lJFrOzCO8urP9Ygwf
 gTGkYWjIAoUo8NoZxBxrnGWJ0joi+LCicWuTtMarXVr9yCRFBjr+kbHObjc/yjO+7UKcTz3WZ
 0py2ifYsEsJaE/bLO/eRuYgiAQOP6nNhG0gb0vuEwzd5k7VA+lZ0FmqdBtIj5CAI4KqwGpxSb
 Jyfyb6rmrTvDA9fC59hAa8gIXjwklPT087BiLt5G4Fgv5w1vimzAwe/IoKJbOCSSzGKUhnvVJ
 XHyjbnG5Pd8CEJzi7YHIxwgNJj57kAYuki3Xkdij4zXwkXmWFKaCPpL/SJJ7gkJAsnGQgKmkF
 poizMB35wx89493MKT/E+8eV4pOz2sVuvfjBHdNtc1SeeMnVCYrzw+2TIm1ZpTTRixdX4pbuE
 VUZQl2RvlJXPD1tjKhRxKik0gCjl/T5Hk1YBLRr1c9fwlU0pXl3VhEGLxbcVNEJruDnfezGtQ
 iqOhszlDM/1ldUPLzejAS8R5LT5rqeIu9FYPuU1okh2BR9ub3faug8JzYAG6IsomotgU2Zmpd
 ATf0m6AoTiMqz1pzNBy4tvJAdviKXJxbJT56dx1kr+uMEGFpvVI4j2+wce8zFCDtlv/csnJ4h
 eKP62EVipAK/KdjNrNwXfDPhTxngwEcTpbIrC+pvGnEjeXWTPjYQcTniJfZZ+dDMVzN9cupV4
 54a+7MHBLu69HLRnHUiGt6VepISknaHu2CTqbxPxaV8jqRQgv6KmwFuGunm9LdtKqTKcvsbW8
 2ku5nTDp+OHzRjSaFTyFL3dYB3fj1Xy2+wJgUs1cWGQnE=

This adds suspend/resume support for the 8250_bcm2835aux
driver to provide power management support on attached
devices.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--

Since i don't have a RS485 setup, any test feedback would be great.

 drivers/tty/serial/8250/8250_bcm2835aux.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_bcm2835aux.c b/drivers/tty/seria=
l/8250/8250_bcm2835aux.c
index 121a5ce86050..cccd2a09cb6f 100644
=2D-- a/drivers/tty/serial/8250/8250_bcm2835aux.c
+++ b/drivers/tty/serial/8250/8250_bcm2835aux.c
@@ -213,11 +213,34 @@ static const struct acpi_device_id bcm2835aux_serial=
_acpi_match[] =3D {
 };
 MODULE_DEVICE_TABLE(acpi, bcm2835aux_serial_acpi_match);

+static int __maybe_unused bcm2835aux_suspend(struct device *dev)
+{
+	struct bcm2835aux_data *data =3D dev_get_drvdata(dev);
+
+	serial8250_suspend_port(data->line);
+
+	return 0;
+}
+
+static int __maybe_unused bcm2835aux_resume(struct device *dev)
+{
+	struct bcm2835aux_data *data =3D dev_get_drvdata(dev);
+
+	serial8250_resume_port(data->line);
+
+	return 0;
+}
+
+static const struct dev_pm_ops bcm2835aux_dev_pm_ops =3D {
+	SET_SYSTEM_SLEEP_PM_OPS(bcm2835aux_suspend, bcm2835aux_resume)
+};
+
 static struct platform_driver bcm2835aux_serial_driver =3D {
 	.driver =3D {
 		.name =3D "bcm2835-aux-uart",
 		.of_match_table =3D bcm2835aux_serial_match,
 		.acpi_match_table =3D bcm2835aux_serial_acpi_match,
+		.pm =3D &bcm2835aux_dev_pm_ops,
 	},
 	.probe  =3D bcm2835aux_serial_probe,
 	.remove_new =3D bcm2835aux_serial_remove,
=2D-
2.34.1


