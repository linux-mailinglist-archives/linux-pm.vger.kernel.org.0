Return-Path: <linux-pm+bounces-10251-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF65791D26D
	for <lists+linux-pm@lfdr.de>; Sun, 30 Jun 2024 17:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CD8FB210D4
	for <lists+linux-pm@lfdr.de>; Sun, 30 Jun 2024 15:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686D3155726;
	Sun, 30 Jun 2024 15:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="fVdknZ5m"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEF0153509;
	Sun, 30 Jun 2024 15:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719761874; cv=none; b=c0xfvw8hBJrsU1K2aBQj55tpNCq1QrIcHopZl8wdnmkeYF2UXHjXP8WJEuWt4+NlPFuFvoW7i4x4NGsY6eYyRmSXegux17Jyx+o3S222t/c13AzIWM+EyBdRH6IGdCWCXRGBaTlGWIF0Xh5ct4iD5evA/li/gaa4Zl3CI0hzmxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719761874; c=relaxed/simple;
	bh=2zWnTrB0QP7kA65GnHCUHymZBdeqdF6gXuwowGyI+og=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=akxCzZEYaGQ1DdJ78yqg4nYulX77PfULi9PLSzg0fV889MnhrDsM1q2vwT+fxCjGGXKfrhGaA9x8JlUU3Pp08WOQX/EiWvMHBRtV9hUC7JLPj/Pnt1IhBNe9pWkGap1q6PlbjLcAVPsuTQycOM6iUQNuta7saYKa7SCwyxMzrcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=fVdknZ5m; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1719761843; x=1720366643; i=wahrenst@gmx.net;
	bh=jR2qUoYJWjo62ss14f32ABLuwKjco/WEcCrvFX1iwUQ=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=fVdknZ5mjA66HYdyBZ1DkGQaXT1SWXB65A7CaQGtGJCzBR3QToSHQr5r5B09qGYt
	 G8/Po3Lt0aO6l54ZSXR+GYw8CNwgdWQ15sOcBRGnkvUULa5JXF0fUUFn+ztWmP32Q
	 I96YP5NZoVEc5zi8sEcxwRidcCTyA63bethzXNmlmI++nnzxYAGvyLzYSOt5O66M8
	 rgVH6dap01enPILApRp5myHV42WB1+uWMkpiewrDSHAVMh9Q+zLenIA3zkOS9wi6K
	 pll2eFx9a+L3JWpZVtp/4xSMG8eLecAaCm2FrBulde/nDfXTPi7thiRAaf96r22BK
	 J62yRkV/D6ZFmn6R+w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M6Ue3-1sUF4c2wHZ-008jJu; Sun, 30
 Jun 2024 17:37:23 +0200
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
Subject: [PATCH 07/11] drm/vc4: hdmi: Disable connector status polling during suspend
Date: Sun, 30 Jun 2024 17:36:48 +0200
Message-Id: <20240630153652.318882-8-wahrenst@gmx.net>
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
X-Provags-ID: V03:K1:16Ngb9tSxp2iZwHbx5dqk16AQEKX8kLcRlkqIw9cY3Qs9QzfZno
 XUBl7sn846cccKtsEHGyLm7q5kzaqH90IJ8JhAqcwRSCXHyTQ/DrwFhPNE5q3XMfEO9LpX4
 UqsN5Ie+oAMtdG/IpeKtp5/GiHPbugvdU8ZZkjpvdkZcCfLb8CqLsZD2odXAP2AzNekfdOR
 W55XynRw/dHEi6zCgg2FA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:75eQMN8yRdA=;haDMuV5WnSJ3HWguPxybuI47jn1
 e4lnr87wp77Gm16QAmleCGaZxLNO8UADI6b+3GHMbw8T70H8BaaETJzGOYaSEumgQ1zAyPBHp
 whCKx3IaXlR99Jto1W+YBWWMoM3+gB/0CnPOGYWUvQVbCKpCPcLGkXHzoiCBnTJ8VfYyj1vOR
 nEFO2xKx/UB1QjUcOpBYYDPs5uQ46ufs/WEWzoVr+sJer6FHSisICR4k0aXz0YXM9ltGhm3i4
 VUaupQ7XCkMHi77rpWLTFw4ZDtMt0sdQuCVH+FcWqzLSFGzidhUBg0Z9PCZw1qgsVHXo3eJsa
 ehOxUR4RsD7LK2DhS/HWQLfU/EYAlZRN2rqMoc/79LEGhlD38XK7QYhDLrDxZEhC4236NFFHU
 vQm3dqi9zkQVh6u7OWqD1lacC2Pn1n+mKANxv1oid7QjuP9QKceGByCyOHbzvHMa2bfTeToNM
 Ya1YjdXYiZb5supX0l4tWBuzEI5nKm419FkiGDVzYYLSsHvNI4hJQ+M6u0mwzmf/FUlzszXML
 0q3ETBjs93rhiom3cv5s8OoWtHuT0IwJ2pnNMZfii+2uRvNeYZvKbsf4oVmG41A6yqU0U/vcn
 vy0JDfubHvUehe9EKHSXPPPBlhJbBFQjWz6YFk8fujUbLOnl+fnYR4GtPf0wIDEKDGyxfyvb/
 NIhztcr86voQaj6e4oxNaTwfZvL7XizyCUsr7pnxGgcJ6ZlhorN2/YvuiYocNpWMpHGtUiCLb
 OQFqSCezyx/m2r67/6HWhfzcgML/FhOXYig2GJmsnjdyIK4+h9yjWKA95tnRAaUXQvmNuNRL+
 Tg1HaAqYr3KYh3d5ChmNnibKOufTBfrq1wbwJKba4o7qQ=

Suspend of VC4 HDMI will likely triggers a warning from
vc4_hdmi_connector_detect_ctx() during poll of connector status.
The power management will prevent the resume and keep the relevant
power domain disabled.

Since there is no reason to poll the connector status during
suspend, the polling should be disabled during this.

It not possible to use drm_mode_config_helper_suspend() here,
because the callbacks might be called during bind phase and not all
components are fully initialized.

Link: https://lore.kernel.org/dri-devel/7003512d-7303-4f41-b0d6-a8af5bf8e4=
97@gmx.net/
Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 drivers/gpu/drm/vc4/vc4_hdmi.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi=
.c
index b3a42b709718..e80495cea6ac 100644
=2D-- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -3106,6 +3106,13 @@ static int vc5_hdmi_init_resources(struct drm_devic=
e *drm,
 static int vc4_hdmi_runtime_suspend(struct device *dev)
 {
 	struct vc4_hdmi *vc4_hdmi =3D dev_get_drvdata(dev);
+	struct drm_device *drm =3D vc4_hdmi->connector.dev;
+
+	/*
+	 * Don't disable polling if it was never initialized
+	 */
+	if (drm && drm->mode_config.poll_enabled)
+		drm_kms_helper_poll_disable(drm);

 	clk_disable_unprepare(vc4_hdmi->hsm_clock);

@@ -3115,6 +3122,7 @@ static int vc4_hdmi_runtime_suspend(struct device *d=
ev)
 static int vc4_hdmi_runtime_resume(struct device *dev)
 {
 	struct vc4_hdmi *vc4_hdmi =3D dev_get_drvdata(dev);
+	struct drm_device *drm =3D vc4_hdmi->connector.dev;
 	unsigned long __maybe_unused flags;
 	u32 __maybe_unused value;
 	unsigned long rate;
@@ -3159,6 +3167,9 @@ static int vc4_hdmi_runtime_resume(struct device *de=
v)
 	}
 #endif

+	if (drm && drm->mode_config.poll_enabled)
+		drm_kms_helper_poll_enable(drm);
+
 	return 0;

 err_disable_clk:
=2D-
2.34.1


