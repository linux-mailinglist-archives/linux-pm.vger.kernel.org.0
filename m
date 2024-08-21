Return-Path: <linux-pm+bounces-12667-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D990A95A6EA
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 23:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22908B22781
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 21:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454D517BB38;
	Wed, 21 Aug 2024 21:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="KYdZ+9Ae"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BBA17AE01;
	Wed, 21 Aug 2024 21:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724276501; cv=none; b=L82tN7Qx3AAZdnAS6pTAAbpRmhavnGoy3atfvK44SS2dYDTWNfuOaS051K1W0ln4N6UXZxNuvKs6DOIKuuXz13EmqpDknD0A9emBAGeQXNJg5B+BpSHL6pf4Q/P1QoT0GyGzQCqNTkMcHGnnEf6r9bubTkmj0iVPRbFeeRKV9sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724276501; c=relaxed/simple;
	bh=KDeEenahIgWhKjQN4V6CoUVMaSXQrNWkMXKxiUt5U0k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RUxpDaGzCuW+CbgYtD4tL/5nU34YrUwbd9HrkIDFvRmfuD9NqPxQ0AFULRcv7/K+xszENpN7WtP/YRbF167xln3DMKlWrVLbdIsBvwDl+YsBTlNuo9uqfUk5QoF63lZR8EudAR/S5GP9gclHbJDHrsc4XY6p133lW0fh9i72KLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=KYdZ+9Ae; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1724276471; x=1724881271; i=wahrenst@gmx.net;
	bh=77csMFJ8HMyu75s9Qzq+i8SVljZuRltVYE5H7gqE+kQ=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=KYdZ+9AeoMxp4+mmVmTdHzqqXwqy9MyDBiVhm0L7Kp7iPH2fbbRBOV605RWvrBdr
	 gu5mcrRPWZ0pkB9I0oCxTEuKnRtfSATYeY0ntfK3fVtwNJxbH4MPDM3lhwD0/5l6Z
	 qQw4Edm6e1cj2yjOq2AbKEOYGw8tFOZun1HQGZI6en9S8tPlAmHggcfbIHudTSdil
	 6js2qwuPAwUhN68g2RkNBi3HfOsRQ7cI4Xc7RtTl7XR3dIIyZ7lBZ0SR+lFX5ivUo
	 wlmfKpxgF865ocgnGI+WXU8+HIjwlWU/gpq2J18N0sacBQfCbcY9PvX60BVr5QwvR
	 fHZ9vwrUyapF47QmTQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M6Ue3-1snjlW1ZZR-007lZf; Wed, 21
 Aug 2024 23:41:11 +0200
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
Subject: [PATCH V3 7/9] usb: dwc2: Refactor backup/restore of registers
Date: Wed, 21 Aug 2024 23:40:50 +0200
Message-Id: <20240821214052.6800-8-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240821214052.6800-1-wahrenst@gmx.net>
References: <20240821214052.6800-1-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:s3fMLZTBlQ9oc/i/DUOjMtIxSdyzEVKvfPsWo7uvqhR6L28bsSr
 b7zQcr7QVItzC/7M7163AUPfQlp5Zm8d78wdySPktOP9dooDIkk/XB9U7W53ICxe/AzNPZm
 +Nn8F2B4091UGxzM11UYDa5Zne3Vjk6G73WhGbHnaGQpgfxconYAacShKb9dMvtQouCLgHv
 FM8VXc0kCxeq+KA3WnqQg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:i5iTDL/SMAQ=;nR4FHaBNECev5NyOUtlgznVbLnb
 8DEru5WUjHu2kkQn93TT7uxF4+RyTexpq0bfNJOPAp9Ahz9HHy5C/2jbTXPk/yX8duK9sTQYg
 ioTHE3WDud8XtOfCOAScMghSXuwv12xqoXtXaNjl0GSNQqathXi9amLEd6LJAf5LIepMqcohR
 MBVHS2EUtbxrqNRrew2m9BnzpSCiOmOakXzrux1BvMzTc7LaBT0RC/HT+KvYb63rKl4eezbwh
 HC9KHz+mucdCG43QbaAB/I0DJcksVDRF7f7sZEYkAi116ZHxyt3j0V+X5HOCi59Zir3ez+w3H
 6CsBjB2uxdaDmAOZ4t6mRKDYWyXLBfTf9IfeDj2NxS4SoLiFYM0ZtJQDxgJaJO4Wqie/stFTn
 rzy6+70XgZlW/x5XizY99Fp1Dab4GRrGrL3byqFwHgWWtgT0eJ8AdE9lfGbds/pnnXMZzQqcK
 R6Z7wtZbIKwhAk3yoTp38RzyjPN2lwAwasXD02zURM2yX/6vGL5nP/WwvasDi0OkKvKYdAWyz
 jvKz9wxOIHy6NA7bG9exPrRC8GgVDlVe/k1pEnlMIHdZFypSaMXRSSpJ//lgcgCZk1k6vDci2
 gl4ElBuniXGYlLkcTDZUSYtjmvCeUcJ1x5DoWgmqx/QbvZCiCEE/9639retAxjpGXh13y+/tO
 T2VSL/eBRJveqjOy8AHfDZS/JFMcTrAMAaAb8gAY9+Urj+Fx6X7EfZuVzmFcfkBEkgONe4cwq
 48gMd2pEB0jEqC1KyV7ZQT/+7yf0Tr+9XyLPzt7BnwMPPzOvupTDOU6dNpA+493JwlKXr95s6
 WUj2yY9ZF1BIUf1+wYESXvEw==

The DWC2 runtime PM code reuses similar patterns to backup and
restore the registers. So consolidate them in USB mode specific
variants. This also has the advantage it is usable for further
PM improvements.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 drivers/usb/dwc2/core.h   |  12 +++++
 drivers/usb/dwc2/gadget.c | 101 +++++++++++++++++++-------------------
 drivers/usb/dwc2/hcd.c    |  99 +++++++++++++++++++------------------
 3 files changed, 114 insertions(+), 98 deletions(-)

diff --git a/drivers/usb/dwc2/core.h b/drivers/usb/dwc2/core.h
index 2bd74f3033ed..81e8632f29ed 100644
=2D-- a/drivers/usb/dwc2/core.h
+++ b/drivers/usb/dwc2/core.h
@@ -1435,6 +1435,8 @@ int dwc2_hsotg_tx_fifo_total_depth(struct dwc2_hsotg=
 *hsotg);
 int dwc2_hsotg_tx_fifo_average_depth(struct dwc2_hsotg *hsotg);
 void dwc2_gadget_init_lpm(struct dwc2_hsotg *hsotg);
 void dwc2_gadget_program_ref_clk(struct dwc2_hsotg *hsotg);
+int dwc2_gadget_backup_critical_registers(struct dwc2_hsotg *hsotg);
+int dwc2_gadget_restore_critical_registers(struct dwc2_hsotg *hsotg);
 static inline void dwc2_clear_fifo_map(struct dwc2_hsotg *hsotg)
 { hsotg->fifo_map =3D 0; }
 #else
@@ -1482,6 +1484,10 @@ static inline int dwc2_hsotg_tx_fifo_average_depth(=
struct dwc2_hsotg *hsotg)
 { return 0; }
 static inline void dwc2_gadget_init_lpm(struct dwc2_hsotg *hsotg) {}
 static inline void dwc2_gadget_program_ref_clk(struct dwc2_hsotg *hsotg) =
{}
+static inline int dwc2_gadget_backup_critical_registers(struct dwc2_hsotg=
 *hsotg)
+{ return 0; }
+static inline int dwc2_gadget_restore_critical_registers(struct dwc2_hsot=
g *hsotg)
+{ return 0; }
 static inline void dwc2_clear_fifo_map(struct dwc2_hsotg *hsotg) {}
 #endif

@@ -1505,6 +1511,8 @@ int dwc2_host_exit_partial_power_down(struct dwc2_hs=
otg *hsotg,
 void dwc2_host_enter_clock_gating(struct dwc2_hsotg *hsotg);
 void dwc2_host_exit_clock_gating(struct dwc2_hsotg *hsotg, int rem_wakeup=
);
 bool dwc2_host_can_poweroff_phy(struct dwc2_hsotg *dwc2);
+int dwc2_host_backup_critical_registers(struct dwc2_hsotg *hsotg);
+int dwc2_host_restore_critical_registers(struct dwc2_hsotg *hsotg);
 static inline void dwc2_host_schedule_phy_reset(struct dwc2_hsotg *hsotg)
 { schedule_work(&hsotg->phy_reset_work); }
 #else
@@ -1544,6 +1552,10 @@ static inline void dwc2_host_exit_clock_gating(stru=
ct dwc2_hsotg *hsotg,
 					       int rem_wakeup) {}
 static inline bool dwc2_host_can_poweroff_phy(struct dwc2_hsotg *dwc2)
 { return false; }
+static inline int dwc2_host_backup_critical_registers(struct dwc2_hsotg *=
hsotg)
+{ return 0; }
+static inline int dwc2_host_restore_critical_registers(struct dwc2_hsotg =
*hsotg)
+{ return 0; }
 static inline void dwc2_host_schedule_phy_reset(struct dwc2_hsotg *hsotg)=
 {}

 #endif
diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c
index e7bf9cc635be..0bff748bcf74 100644
=2D-- a/drivers/usb/dwc2/gadget.c
+++ b/drivers/usb/dwc2/gadget.c
@@ -5309,6 +5309,49 @@ void dwc2_gadget_program_ref_clk(struct dwc2_hsotg =
*hsotg)
 	dev_dbg(hsotg->dev, "GREFCLK=3D0x%08x\n", dwc2_readl(hsotg, GREFCLK));
 }

+int dwc2_gadget_backup_critical_registers(struct dwc2_hsotg *hsotg)
+{
+	int ret;
+
+	/* Backup all registers */
+	ret =3D dwc2_backup_global_registers(hsotg);
+	if (ret) {
+		dev_err(hsotg->dev, "%s: failed to backup global registers\n",
+			__func__);
+		return ret;
+	}
+
+	ret =3D dwc2_backup_device_registers(hsotg);
+	if (ret) {
+		dev_err(hsotg->dev, "%s: failed to backup device registers\n",
+			__func__);
+		return ret;
+	}
+
+	return 0;
+}
+
+int dwc2_gadget_restore_critical_registers(struct dwc2_hsotg *hsotg)
+{
+	int ret;
+
+	ret =3D dwc2_restore_global_registers(hsotg);
+	if (ret) {
+		dev_err(hsotg->dev, "%s: failed to restore registers\n",
+			__func__);
+		return ret;
+	}
+
+	ret =3D dwc2_restore_device_registers(hsotg, 0);
+	if (ret) {
+		dev_err(hsotg->dev, "%s: failed to restore device registers\n",
+			__func__);
+		return ret;
+	}
+
+	return 0;
+}
+
 /**
  * dwc2_gadget_enter_hibernation() - Put controller in Hibernation.
  *
@@ -5326,18 +5369,9 @@ int dwc2_gadget_enter_hibernation(struct dwc2_hsotg=
 *hsotg)
 	/* Change to L2(suspend) state */
 	hsotg->lx_state =3D DWC2_L2;
 	dev_dbg(hsotg->dev, "Start of hibernation completed\n");
-	ret =3D dwc2_backup_global_registers(hsotg);
-	if (ret) {
-		dev_err(hsotg->dev, "%s: failed to backup global registers\n",
-			__func__);
-		return ret;
-	}
-	ret =3D dwc2_backup_device_registers(hsotg);
-	if (ret) {
-		dev_err(hsotg->dev, "%s: failed to backup device registers\n",
-			__func__);
+	ret =3D dwc2_gadget_backup_critical_registers(hsotg);
+	if (ret)
 		return ret;
-	}

 	gpwrdn =3D GPWRDN_PWRDNRSTN;
 	udelay(10);
@@ -5483,20 +5517,9 @@ int dwc2_gadget_exit_hibernation(struct dwc2_hsotg =
*hsotg,
 	dwc2_writel(hsotg, 0xffffffff, GINTSTS);

 	/* Restore global registers */
-	ret =3D dwc2_restore_global_registers(hsotg);
-	if (ret) {
-		dev_err(hsotg->dev, "%s: failed to restore registers\n",
-			__func__);
-		return ret;
-	}
-
-	/* Restore device registers */
-	ret =3D dwc2_restore_device_registers(hsotg, rem_wakeup);
-	if (ret) {
-		dev_err(hsotg->dev, "%s: failed to restore device registers\n",
-			__func__);
+	ret =3D dwc2_gadget_restore_critical_registers(hsotg);
+	if (ret)
 		return ret;
-	}

 	if (rem_wakeup) {
 		mdelay(10);
@@ -5530,19 +5553,9 @@ int dwc2_gadget_enter_partial_power_down(struct dwc=
2_hsotg *hsotg)
 	dev_dbg(hsotg->dev, "Entering device partial power down started.\n");

 	/* Backup all registers */
-	ret =3D dwc2_backup_global_registers(hsotg);
-	if (ret) {
-		dev_err(hsotg->dev, "%s: failed to backup global registers\n",
-			__func__);
-		return ret;
-	}
-
-	ret =3D dwc2_backup_device_registers(hsotg);
-	if (ret) {
-		dev_err(hsotg->dev, "%s: failed to backup device registers\n",
-			__func__);
+	ret =3D dwc2_gadget_backup_critical_registers(hsotg);
+	if (ret)
 		return ret;
-	}

 	/*
 	 * Clear any pending interrupts since dwc2 will not be able to
@@ -5610,21 +5623,9 @@ int dwc2_gadget_exit_partial_power_down(struct dwc2=
_hsotg *hsotg,

 	udelay(100);
 	if (restore) {
-		ret =3D dwc2_restore_global_registers(hsotg);
-		if (ret) {
-			dev_err(hsotg->dev, "%s: failed to restore registers\n",
-				__func__);
-			return ret;
-		}
-		/* Restore DCFG */
-		dwc2_writel(hsotg, dr->dcfg, DCFG);
-
-		ret =3D dwc2_restore_device_registers(hsotg, 0);
-		if (ret) {
-			dev_err(hsotg->dev, "%s: failed to restore device registers\n",
-				__func__);
+		ret =3D dwc2_gadget_restore_critical_registers(hsotg);
+		if (ret)
 			return ret;
-		}
 	}

 	/* Set the Power-On Programming done bit */
diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
index cb54390e7de4..32fa606e5d59 100644
=2D-- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -5477,6 +5477,49 @@ int dwc2_restore_host_registers(struct dwc2_hsotg *=
hsotg)
 	return 0;
 }

+int dwc2_host_backup_critical_registers(struct dwc2_hsotg *hsotg)
+{
+	int ret;
+
+	/* Backup all registers */
+	ret =3D dwc2_backup_global_registers(hsotg);
+	if (ret) {
+		dev_err(hsotg->dev, "%s: failed to backup global registers\n",
+			__func__);
+		return ret;
+	}
+
+	ret =3D dwc2_backup_host_registers(hsotg);
+	if (ret) {
+		dev_err(hsotg->dev, "%s: failed to backup host registers\n",
+			__func__);
+		return ret;
+	}
+
+	return 0;
+}
+
+int dwc2_host_restore_critical_registers(struct dwc2_hsotg *hsotg)
+{
+	int ret;
+
+	ret =3D dwc2_restore_global_registers(hsotg);
+	if (ret) {
+		dev_err(hsotg->dev, "%s: failed to restore registers\n",
+			__func__);
+		return ret;
+	}
+
+	ret =3D dwc2_restore_host_registers(hsotg);
+	if (ret) {
+		dev_err(hsotg->dev, "%s: failed to restore host registers\n",
+			__func__);
+		return ret;
+	}
+
+	return 0;
+}
+
 /**
  * dwc2_host_enter_hibernation() - Put controller in Hibernation.
  *
@@ -5492,18 +5535,9 @@ int dwc2_host_enter_hibernation(struct dwc2_hsotg *=
hsotg)
 	u32 gpwrdn;

 	dev_dbg(hsotg->dev, "Preparing host for hibernation\n");
-	ret =3D dwc2_backup_global_registers(hsotg);
-	if (ret) {
-		dev_err(hsotg->dev, "%s: failed to backup global registers\n",
-			__func__);
-		return ret;
-	}
-	ret =3D dwc2_backup_host_registers(hsotg);
-	if (ret) {
-		dev_err(hsotg->dev, "%s: failed to backup host registers\n",
-			__func__);
+	ret =3D dwc2_host_backup_critical_registers(hsotg);
+	if (ret)
 		return ret;
-	}

 	/* Enter USB Suspend Mode */
 	hprt0 =3D dwc2_readl(hsotg, HPRT0);
@@ -5697,20 +5731,9 @@ int dwc2_host_exit_hibernation(struct dwc2_hsotg *h=
sotg, int rem_wakeup,
 	dwc2_writel(hsotg, 0xffffffff, GINTSTS);

 	/* Restore global registers */
-	ret =3D dwc2_restore_global_registers(hsotg);
-	if (ret) {
-		dev_err(hsotg->dev, "%s: failed to restore registers\n",
-			__func__);
+	ret =3D dwc2_host_restore_critical_registers(hsotg);
+	if (ret)
 		return ret;
-	}
-
-	/* Restore host registers */
-	ret =3D dwc2_restore_host_registers(hsotg);
-	if (ret) {
-		dev_err(hsotg->dev, "%s: failed to restore host registers\n",
-			__func__);
-		return ret;
-	}

 	if (rem_wakeup) {
 		dwc2_hcd_rem_wakeup(hsotg);
@@ -5777,19 +5800,9 @@ int dwc2_host_enter_partial_power_down(struct dwc2_=
hsotg *hsotg)
 		dev_warn(hsotg->dev, "Suspend wasn't generated\n");

 	/* Backup all registers */
-	ret =3D dwc2_backup_global_registers(hsotg);
-	if (ret) {
-		dev_err(hsotg->dev, "%s: failed to backup global registers\n",
-			__func__);
-		return ret;
-	}
-
-	ret =3D dwc2_backup_host_registers(hsotg);
-	if (ret) {
-		dev_err(hsotg->dev, "%s: failed to backup host registers\n",
-			__func__);
+	ret =3D dwc2_host_backup_critical_registers(hsotg);
+	if (ret)
 		return ret;
-	}

 	/*
 	 * Clear any pending interrupts since dwc2 will not be able to
@@ -5858,19 +5871,9 @@ int dwc2_host_exit_partial_power_down(struct dwc2_h=
sotg *hsotg,

 	udelay(100);
 	if (restore) {
-		ret =3D dwc2_restore_global_registers(hsotg);
-		if (ret) {
-			dev_err(hsotg->dev, "%s: failed to restore registers\n",
-				__func__);
-			return ret;
-		}
-
-		ret =3D dwc2_restore_host_registers(hsotg);
-		if (ret) {
-			dev_err(hsotg->dev, "%s: failed to restore host registers\n",
-				__func__);
+		ret =3D dwc2_host_restore_critical_registers(hsotg);
+		if (ret)
 			return ret;
-		}
 	}

 	/* Drive resume signaling and exit suspend mode on the port. */
=2D-
2.34.1


