Return-Path: <linux-pm+bounces-10248-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F7691D264
	for <lists+linux-pm@lfdr.de>; Sun, 30 Jun 2024 17:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F8FEB20C38
	for <lists+linux-pm@lfdr.de>; Sun, 30 Jun 2024 15:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49BF1153BFA;
	Sun, 30 Jun 2024 15:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="ep8yM1Uq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7211422A8;
	Sun, 30 Jun 2024 15:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719761873; cv=none; b=m/bbXBZ/x1cykIbglrP2eTwoXkSSZ9yoUwRnoSBPcN2cffaTkuhk1rgP+ip3HvN2WnoWoeVKe3wmM3vvBit2Zv884FQSzONUiuIpaizaxUs5Uu2cMobN6hUDbdehoHleXTO70nwjg/AjMy2Ztp7YDxKHe2mbYPdSAJ+VAuj2JCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719761873; c=relaxed/simple;
	bh=qQwi+KPDIZxW5GZlpRAbTobx32sUz3lKs/edcSv1W+w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cuXIHuF2cIFey1tC8ATcVZxcpMi9q8ve41Y4AfWad/RtRGSx2sevlGeySvK1ft03oTIYJW1A0nFed8235R1VJoRe+bVZ36omXcq4xsbLjUN4/OjeQiv/Z4GKJt12Au2PrGEYZ4XeVfg0MBFI1VlFot9bkkPspb9yAVjwwPQSfbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=ep8yM1Uq; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1719761838; x=1720366638; i=wahrenst@gmx.net;
	bh=+rxQ791ubcSxhOIK3kEqE6IzwyoFm1gQrUg4Eh9bhfg=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ep8yM1UqjNI4tYbUGxYXd3MWHdd7qpwG3ZkN+8Bb00WnDJx0khVHLkZA9LcxzS3R
	 ociMgBcDCGrxxvuHZfBWVtVaMGPj50QAer6BMcyerrpNVl0O/EhKDqt7gtstfLPtw
	 XIM/GvEGcubFQNYLTwAwZmiP9BwWtD/QoqY/cwjuFh72HdFpRcDisMlqKxTbM5+p0
	 M5pWJvFc8YD3FzEalcfoaX2NkMWlUGsvIjmi7GoWBw4dsJCIk0WFN87axKNCGdHzE
	 4KroQkD/cMQLzTbjpNJiUrc7woXa1KQjtRsY5F+hN0szsaSeOS7ihjbiqlatWeDT3
	 k2sEiCiyniboX57PbA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N1wq3-1sH5tc3gcb-013lvq; Sun, 30
 Jun 2024 17:37:18 +0200
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
Subject: [PATCH 01/11] firmware: raspberrypi: Improve timeout warning
Date: Sun, 30 Jun 2024 17:36:42 +0200
Message-Id: <20240630153652.318882-2-wahrenst@gmx.net>
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
X-Provags-ID: V03:K1:+fDSsr7/+1m0xx5jNNZO5K4aelCIX1oa9z/e7EF4bCJ/BqcX+/l
 GZB4P+Dbvny3hJik8esZBgJdKLMNoMLwRyuDU9g9cw7nCo6Niu37bmQS83d06fYvF821c51
 xt0tuKV93IfqN1Xco4x4g/807GrrMeshXjpmWMufSWbTQcuQ9m/i5yabx49vm/MS9bZWtD4
 QWgSi7beLjp8V/oAvMMKg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:qL3riX2MGg4=;D2/m4WXwE9Wy2ZsgCNs/qwYDp9R
 lSBIPwXiITay4NnuZ1BzTnJ6onPzOWqZ00kx5YARH9TP8jR0tjxOPf6a7VlPjbySxELwm0AlS
 R+CBtdyPakaNEQHdUaRdNkaeIyKqFnIud+Bpi6PqoOhyOKRMBv/0mu8GnY4C3JiEzuIdz+1EU
 LEhUirQ45fWoXvlx9u7jHbT4QHXQSSpgBA6bs7VN1KOwF2AP+9lbfAmEyDUBFM2nyJlQgSS+n
 e7cv+pFv/iQdaqD41ksPD3t6UaEHL6YLHPEzoICMpMIiYN7Y1jXoZRFn/3u4b7ctp1hNJRyJ+
 WboLv6atSIyjgrPCPDNXEADzkm5nrESe/2/MOGpp5nmHkhzYug+eHqPK73lzdmchS4LLm8Fr0
 +A0VkFy+VSOBl9qOaRKxog4ScP8Yf2IrvOj6oCuXsv5hxpiiOD2bt9L2yOcPr9T0enCW4o+gJ
 6sD+zcMzSEI4MBCKLVqJj7ueoX9kDfPOMuQ5kCCCnYmmGyZBsNTM0gePhzsTBMeiE8KUUPlB5
 awyGxW3T9NrvLGfpyyMVPC/vVq236X2tS4o6fwriTbIWYsbGmsxWfF/Q1crAFFKsp8Zv9Cz71
 9ZbOF0AzPlBDBrJuYPT7tAks0r3L3N/smARjTwD/Ua6FlYo0zek54GgroF7CFHMIuRWYMMstP
 nru+phMPCC8uYUcCOjixlBvp5lhTOgkQ8OyAsGuJDZouSG3Ln6ThWXcB04dWFidDhg/EcOylf
 F2Rsa8SulqGm/wOoyCclP1zhZnevUJBfPPrmiE48zbFnr/O16IaPuKJRM/gS0HWKECg7Ywzzv
 /pOMkfXgsHxNvJE5JzZpDu5oENBKoPLMf3phzmlUdypr8=

Recent work on raspberry-power driver showed that even the
stacktrace on firmware property timeout doesn't provide
enough information. So add the first tag name to the warning
to be in line with a status error.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 drivers/firmware/raspberrypi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/raspberrypi.c b/drivers/firmware/raspberrypi=
.c
index ac34876a97f8..18cc34987108 100644
=2D-- a/drivers/firmware/raspberrypi.c
+++ b/drivers/firmware/raspberrypi.c
@@ -62,7 +62,6 @@ rpi_firmware_transaction(struct rpi_firmware *fw, u32 ch=
an, u32 data)
 			ret =3D 0;
 		} else {
 			ret =3D -ETIMEDOUT;
-			WARN_ONCE(1, "Firmware transaction timeout");
 		}
 	} else {
 		dev_err(fw->cl.dev, "mbox_send_message returned %d\n", ret);
@@ -125,6 +124,8 @@ int rpi_firmware_property_list(struct rpi_firmware *fw=
,
 		dev_err(fw->cl.dev, "Request 0x%08x returned status 0x%08x\n",
 			buf[2], buf[1]);
 		ret =3D -EINVAL;
+	} else if (ret =3D=3D -ETIMEDOUT) {
+		WARN_ONCE(1, "Firmware transaction 0x%08x timeout", buf[2]);
 	}

 	dma_free_coherent(fw->chan->mbox->dev, PAGE_ALIGN(size), buf, bus_addr);
=2D-
2.34.1


