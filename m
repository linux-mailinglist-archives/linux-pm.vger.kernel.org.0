Return-Path: <linux-pm+bounces-11506-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F21E093E540
	for <lists+linux-pm@lfdr.de>; Sun, 28 Jul 2024 15:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70FE6B21342
	for <lists+linux-pm@lfdr.de>; Sun, 28 Jul 2024 13:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155D347A4C;
	Sun, 28 Jul 2024 13:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="kc9pymxl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF22B3D556;
	Sun, 28 Jul 2024 13:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722171865; cv=none; b=TF8h/jN73l+1eSaKkUHm4lCLwrpsponYsUjhnYB85Opi+qj9Zmty42zK0kiUUTS2y9PIirJVIkzBSHvG17jxtbAnB96sMGHs+fKpSV/AwwEmC+Wi6O4AwpoEPjUZzj/uWIxwc+IDyFpR1KX8DX0flkxEqf2OH+FXl+04hvLuny4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722171865; c=relaxed/simple;
	bh=HMjFJtI+u2C215k4q8qd9sKCbIbjpxZPRtmBLVvy73k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jClNr4ukE8S1U2MCrCjSMZYrzf4Kld6mafguZtsFJ//KnlJf4PC+8gsDba3fZHl44OSfba15p3SnqU5I6GMBMYoRdUdRRyaLItVW4L8A/oFFGOeWAOCqAcfQFf5f/OQF6zfeJQ0qVLo2YvGCvkwUScE/Ns7oZATGc1BI5TYFqUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=kc9pymxl; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1722171835; x=1722776635; i=wahrenst@gmx.net;
	bh=QW57IYRI4P68nR61yVnC7GlYDX8vXW5afRYotl24vJI=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=kc9pymxlFrlBSeObMYYT9G63wvPKtH0GXvEFSq5sDbYKdGTs+gvcyLEk26P8O8Uo
	 yN7yzLFxZZnOb5RT/NWuhhRghY6B7nEh3mLBjnoAztdK32mTCny4TNEVU6yIwSbU7
	 OnX8vqhFh2WVLI8AA6P2FNzbP/XmWu94wBvz8JgPltUmiF1+poBn5m/LBwevN73d0
	 /UrkaPVjxWLHq+OPV+aTwgydOGZRyywuVgNTe38bBxjqfKwuIN4cdh4qVpOPoUG1x
	 csIweff28y5YqLZ+KsF2q44esj393NoNMLqhnEfRxl6d2EIuTkMhYzSlR5X6Vs/uP
	 5urS6sOgsTEeNrL1yA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MDysg-1sOCC718Gi-002vRi; Sun, 28
 Jul 2024 15:03:55 +0200
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
Subject: [PATCH V2 12/16] usb: dwc2: Add comment about BCM2848 ACPI ID
Date: Sun, 28 Jul 2024 15:00:25 +0200
Message-Id: <20240728130029.78279-4-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240728130029.78279-1-wahrenst@gmx.net>
References: <20240728114200.75559-1-wahrenst@gmx.net>
 <20240728130029.78279-1-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:I4iTnkxVmX6uCQRToKN4nNo2sp1GwSRVzLmPfzX9E41Z5v2gKe3
 09kkOASd7hPTla9HDIsXgsQct1ZccQtC6iSYyfd7lNnrcM5NZz47+0An+wFa3hqj29GcmAq
 JCuL8i5F5dtNHYbU2gPSqqEVFc1gqiA4vywMCyJ7bRvRQ4ee1RoNnEfu5jS62AP0+nVZRQY
 jQPkg18RFRY3QpLZuqlIw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:5XIu6/O8icM=;YGRkMRhm0fCWytJNRUyvf50XTp3
 Rw8QCYLQveoSrvVCvfRfc9cvpAbrdg0IbXTAHKTLkt48t0etdP/aK24sYDi5SU8GmXkVRnsuO
 n/v3CCG159Lwp7R+4IrAagYGYUXZb/o+Rq+gNkeJ13v1tqHoBtDoXxKJY7+yDfda/XQ4Pkb+x
 l7vG+vadiN9E1S0rdkPUQkJEYGSONkABLlX+yOh0coLogrOYzw/FEZqZcKfqgBHy/g0NZ/nS9
 j0CC4Clc/E0sF4sXNQwcv8JD/cnDpRyQ1zvTd0En53UTyixlZcwYNZxnm425py5aJvljSeIgo
 KiIKLHA3dtoP8JSF5Rmx94ZLpPTxth9bvpUn0Q4NHVcpPAF2FZEWdBFHIeVWuzv9xXcCEGkxJ
 C4yA/vx5lncYHfqN+4c7LF4yYh6LBUvwZx4QAZUUoeY8rv4LdGvwx7pNftHGacGVWkCzjrzqI
 ukr2Mb0hednxGB1rS2VQay7tHtJGi8eVegiOpYGem2Tk5I81tawVwLgTS9dNlalnrrRVKme5S
 ZX4GOW0kYRFxViHgdZU3bZqWvRea7L77oUig1rZWOcw5vIrU+tkLqlwY2LniULBF5a/aT24JR
 X0vppAVa2tUZvIfuzKlVnCMinJ4Ona6qRylyMINObzxaQUnN76kD5ONuUot35oZHk2WgSeoe4
 rtcBqop3TzTBT5pxvDmyxjgXv2UCyz3YgRXyuDf63YpVkRuFEO45zn/wqNvSGDavX0hTNtYZs
 SuQSaZWwD0ONIvq2X2Ggcqx4x5DGkpCMPBkFqvfgi6iqGGO6931ioj8s23+po6w1z7eppP+30
 Efoy8ZlbWWcBhtiLuT75ABWg==

During recent code review the different naming between ACPI and OF
IDs led to confusion. So add a clarifying comment.

Link: https://lore.kernel.org/linux-usb/38e46b44-6248-45e8-bdf9-66008a2fe2=
90@arm.com/
Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 drivers/usb/dwc2/params.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/dwc2/params.c b/drivers/usb/dwc2/params.c
index a937eadbc9b3..4d73fae80b12 100644
=2D-- a/drivers/usb/dwc2/params.c
+++ b/drivers/usb/dwc2/params.c
@@ -352,6 +352,7 @@ const struct of_device_id dwc2_of_match_table[] =3D {
 MODULE_DEVICE_TABLE(of, dwc2_of_match_table);

 const struct acpi_device_id dwc2_acpi_match[] =3D {
+	/* This ID refers to the same USB IP as of_device_id brcm,bcm2835-usb */
 	{ "BCM2848", (kernel_ulong_t)dwc2_set_bcm_params },
 	{ },
 };
=2D-
2.34.1


