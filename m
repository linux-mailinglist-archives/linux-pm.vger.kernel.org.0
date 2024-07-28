Return-Path: <linux-pm+bounces-11502-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9BE493E4F7
	for <lists+linux-pm@lfdr.de>; Sun, 28 Jul 2024 13:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8525D280E83
	for <lists+linux-pm@lfdr.de>; Sun, 28 Jul 2024 11:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D397E3A1DB;
	Sun, 28 Jul 2024 11:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="LfxGG3lO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EB3EAD0;
	Sun, 28 Jul 2024 11:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722167457; cv=none; b=CpV+93wvFeSrw0f671GpAJkVcX3At6YnlBBkBj+FGM2X4p9bMXL66pY1bruB5FtG6l7J7MLeuQpyPbQJF54J4uu6fN6QveUya6pvPxihY2g2kWgN3rtGgRC+J3CMuyG0/4khvPNTwhPtac44e4Uj5nNwuNyShCbfrNwL15LwXIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722167457; c=relaxed/simple;
	bh=hYV+TDr2SjVWw1zW4/vekSjFk8HOwZnHep+WUb6ve6s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lljA7sAAs38kXin/ZqSRpJTau+QomG1rNWbFAVwV5KmCRbBlDL8iOhLCU9x+QvGrRsc58yVOyiGvvByIz4mQdvkerdPhuH5b4ObZd/TntkFYPvgf13Xi8YEVNMKRgUhOOeWmb1I4NkPgCTLhzO6GRi2WHTARJwJB/rdoDYRBktw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=LfxGG3lO; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1722167429; x=1722772229; i=wahrenst@gmx.net;
	bh=mAP5K6rjjZ9h+Kyxjb/TLxq8qO4pvkW+IrtXzsPAOy0=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=LfxGG3lOy6OxRESct9xiOlbE9Z2Y7Nr1g7apwiIVOPtmlfyXpEGmRGAF4LVJXdfm
	 e9xl9QbkbyD89gE7aw9p2pfUPkzydUiX6xiLz2OfbiRy58Z/np2LeSoC2xU/zyRkP
	 S74j/EZ76q1ZWncvp86yp3zwcL72rTSY1pYeTnMLS5ZZ6VfHJV4P06UCjnalHIm60
	 N/mk1g+3s0cxFMtRLjSCFAzhHzb6kHGltNSpvqLlFCDGsxCXgc2soOcAWd/KoJMBy
	 KWvDBAgQwozvg3R0aTEslbrwwO3UGuwpD9mZiV2gZs6LkqkpEMyKm20xkn/3W8rSB
	 /9eNns3wUz/Po9OnOw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MNsw4-1swITV0az2-00TM6x; Sun, 28
 Jul 2024 13:50:29 +0200
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
Subject: [PATCH V2 08/16] drm/vc4: hdmi: add PM suspend/resume support
Date: Sun, 28 Jul 2024 13:41:52 +0200
Message-Id: <20240728114200.75559-9-wahrenst@gmx.net>
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
X-Provags-ID: V03:K1:6d0dGDGm+dLjlwAyJtKK5CyUIflHh+zg4bpcrw5lentD0RqV+R1
 BBYSPoh7fGH4pcoJ7loQRU3lQ9Fj9HRVJRjj92jVXX4mBACK3HAr6Y8CWN+g48h5EsSUVRR
 3ngzvujax5a1GJEEcrVre8N3PmMKCp4W+Xeu8LH6NhOPMP3wO5ZRyb/O1s5TUC/pbJbgpYo
 Xi8a2Y2V4HYfkNGVXID6Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3fXImmlf+gA=;2OZ4akwS2nqG/5zVHPHoAraiCK+
 skDAInbpKJEO9b6cdbrtpQCGtX7esVnV1uKbTnWfnMpK3at1CcyS+FFtNf3qV0Hp3UiNtB9lx
 CsmODXFfmsqc+LxnwxHxMLn2RRfxU3HFw9zidk65IRlsCNhv4ia7r4VUynLafkkyga6k2jhrB
 bmwy+slj4yYL09a2Aiv7spuHAZPI9i2Za0pgOU3UOq1AMKsTREkfO8sEPeRGxZwHmsBDLwz0z
 cSAqgk0OiR1PyjTX/ks0HfDZeUTDKFp3JboK76ggi2EQDSHPwcoBFelm39oq0nBOj/ceG71RL
 b2kBUnqkMZxsXTRBpIPDSDFk4NA1SjbEQDVDr6TXcBLghnQGjGz/OmSbDsBsnuMi1gVezdOGs
 YUla1A9n3EyeKNo8LDaLKsyLGVMhgGa/3+oM8TRzHcVMPRUKhNvYbfKvrO8k4sdva5zwTJlmW
 qE7UwFkBLlgBwKPgdUuiq9dYRl3VhnBFphxI+se8gXYf+1zoQdl6pDcRlb/epnW5exFFmFrKO
 B+nD0UrQWc1oNmfCmrP09ow1gYsN53+YtCZU8P1bwc7nKT71oVxEfgcjCqrKX3m9nr9jZ69dg
 gckazYUylKJkNBrGbAcGsT82fEZmggIKEb25QJoWoKz6BkTxeAXB8Yd6cQjSUqOShhJczO280
 fH7YNLu5vbE12Stt1cdICidCZMgYZ0a0LvgUnDQdn7vNqCrvuwZnXambSBj48KxQXPbtZWOd7
 YQnMxI5c3LIgZBgA+RhunTOXAV9kxFKPD6dTqQXZU+ymGNGd2yIgqLHfxLR47jwQXiV7UPvGu
 bthSAKzbrTVOL14sBy8K1hxg==

Add suspend/resume support for the VC4 HDMI component in order
to handle suspend to idle properly. Since the HDMI power domain
is powered down during suspend, this makes connector status polling
pointless.

Link: https://lore.kernel.org/dri-devel/7003512d-7303-4f41-b0d6-a8af5bf8e4=
97@gmx.net/
Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 drivers/gpu/drm/vc4/vc4_hdmi.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi=
.c
index 6611ab7c26a6..f7a4ed16094e 100644
=2D-- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -3104,6 +3104,31 @@ static int vc5_hdmi_init_resources(struct drm_devic=
e *drm,
 	return 0;
 }

+static int vc4_hdmi_suspend(struct device *dev)
+{
+	struct vc4_hdmi *vc4_hdmi =3D dev_get_drvdata(dev);
+	struct drm_device *drm =3D vc4_hdmi->connector.dev;
+
+	if (drm && drm->mode_config.poll_enabled)
+		drm_kms_helper_poll_disable(drm);
+
+	return pm_runtime_force_suspend(dev);
+}
+
+static int vc4_hdmi_resume(struct device *dev)
+{
+	struct vc4_hdmi *vc4_hdmi =3D dev_get_drvdata(dev);
+	struct drm_device *drm =3D vc4_hdmi->connector.dev;
+	int ret;
+
+	ret =3D pm_runtime_force_resume(dev);
+
+	if (drm && drm->mode_config.poll_enabled)
+		drm_kms_helper_poll_enable(drm);
+
+	return ret;
+}
+
 static int vc4_hdmi_runtime_suspend(struct device *dev)
 {
 	struct vc4_hdmi *vc4_hdmi =3D dev_get_drvdata(dev);
@@ -3405,6 +3430,7 @@ static const struct dev_pm_ops vc4_hdmi_pm_ops =3D {
 	SET_RUNTIME_PM_OPS(vc4_hdmi_runtime_suspend,
 			   vc4_hdmi_runtime_resume,
 			   NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(vc4_hdmi_suspend, vc4_hdmi_resume)
 };

 struct platform_driver vc4_hdmi_driver =3D {
=2D-
2.34.1


