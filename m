Return-Path: <linux-pm+bounces-12664-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE2195A6E3
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 23:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1583A1C22913
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 21:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9AA17B4FE;
	Wed, 21 Aug 2024 21:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="Q3BGSdC3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8456179652;
	Wed, 21 Aug 2024 21:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724276499; cv=none; b=N87hfZ6nLkbPDQUmVXFq8gY762dKoq0SJRXmSL0nmHTNTNx86pIahC9bEPyZZWxzhJShaKWb7l9oIjsjk/u0M9Gz4yLd88z0fjvfSnIGHZkcJSYfjuaYTsskcVXJ/fTrmmW/qeS1pNbAYIu1NVp6ZD3OxegKtuRkk2fyvsK/EpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724276499; c=relaxed/simple;
	bh=AxOFsGr28cfcbNC+h6Dftg8EXbp86i+W3CwA3JRfN74=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hWOzI1bu0n+8/X1ECmGHGgIqk0bu5Crzff3UjrbicMyTk7xftmPNctpx/mTMC7VbcVo9wK4vl6gQcm0gszZy4Traewk7sjvOmK0OU5Avfy3G2kuL8hJIGtPoYvBnQh96ZxJBn2kEqrZEkLtjgtXcasMo0JM3GJEgRk8h4L4X+vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=Q3BGSdC3; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1724276466; x=1724881266; i=wahrenst@gmx.net;
	bh=cQY4hRDbG/mN48nwz0CKJd9xVLzJCWuo9bxt0VUNn7M=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Q3BGSdC33AdlS6K3Wjc6qL3k8rkqCxFIjApQmQZtLA8bZNKO5lBeePM/AW6+vPnj
	 7tmveOOaisZXn61VZzcrsln7vheDCE/l402/awC3j13XTW7RV8nuYwZGVFt+IhBAG
	 OYQoSOA+1saXQghSbgACYDk2klyQCFupP33779uAUy+uIGODvnwN9la+1tMF67ExE
	 EKgEn2/rlnAbg6tk6nzrRnTaAgMVxyFEwD/UXZZaCaicWQ7abSxrJc5cnJf2BTu/K
	 yesB+NnQVQyMfg1IRIyVgw6dOg6rdUWKVcmKcIqaKkiqzGVZq1aesUYaOggiG+0PE
	 oFKR9r4IKkdBBUZSfQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M9o1v-1skRRX0OZx-004SBn; Wed, 21
 Aug 2024 23:41:06 +0200
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
Subject: [PATCH V3 2/9] drm/vc4: hdmi: Handle error case of pm_runtime_resume_and_get
Date: Wed, 21 Aug 2024 23:40:45 +0200
Message-Id: <20240821214052.6800-3-wahrenst@gmx.net>
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
X-Provags-ID: V03:K1:SYu0atATSJi2LLtaA7iRfrykbMjC2ntZZhlC8BBQR4Dd43fm7p+
 QGnzklCAc4BcEn73hukgPfVICFvTqZthCMrwpPOCva73I95NfjwMBDE3E3GwbGlLDiKfWYg
 wJ96yCe1GE5wrSAaynrcM3SFwQ+Yd09Hjd8cq6HUQDPk8hcInxZhinJ8tpE3IgkbeVWMoPW
 c47SpLu7fWMhRl+HKmLLQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:m6ph2I7d/Tw=;IQD2wlv8W4JjTviZyvck0CjTTpP
 IORoRISPPUYiEiPw6NpEQrCRxLivACeKQ0K8UAG5syeleRnTuYCqY7xotNFXVPex3tL5abDI8
 6fjTqrnrpeplbdzzynv+qAVzFCDF2ZgObTVeMjSgZWz8E9hFwrws4v8wVyE1GDWuo1rv91iPO
 ta5EWGuU+NyqtUZgJGqj8KuJ4HKmzdHnaiM6UF2TvmT+XDRFmHwfefH0mz6kG1ofvKgNF2C3B
 ORPvT99rIJvKrFqHhm+0fSLTpEPSekDm4uxI1wWWaSL/6myffjIaYdY+kTHMX+sQvDDEqHAhZ
 RfFFZr+wm2gn+vueXHtJmMQHY6RP5Ko8yGnb5jhwWopdUkx4mFUEkCs3UWl9CdOhYKA/Hk7E9
 nDcmbrSSwnuKHdnpiAOi84KO650WyTCNCzFYtc1FWsGPXZgr/uVlZufKZMJT440G8Uo9YbkQJ
 R+nLfXE/p7bLYniYyfAnkMzwxHNpIzpwAFWpQQfMiWG2x8KpQ2j3Fa0p4ZqFqtcy35UA1RKZ4
 h9ktNqF/cydg0G03AdA0bGS50UdOM2PxHc5UZ1rCT13M3jV0InulmIURsfMosnmlog7hYQ9Lz
 wEePvecFIcCJyyIXDxIEOf2YKlRQdssOTcc7k4kr/XNvz3U1Ka4K6YL53eDNySPtRBAxuif4G
 g0fjf4I0O2BamvlVYDMi9Dqlkq/LvI7dXNKX0x2Y6I0sPq91Pmp1zq1Uvl9F9gmHEs7YQGHae
 TrrwfmUpW/U6U1e2SdKOKxjVO6JcJHU+SsMhtn+y6zpRtNCmK6LKqnEc8ZxTARhzLzIKDLiXO
 v2az4Ax0zYQX9CmaFXDo5V2g==

The commit 0f5251339eda ("drm/vc4: hdmi: Make sure the controller is
powered in detect") introduced the necessary power management handling
to avoid register access while controller is powered down.
Unfortunately it just print a warning if pm_runtime_resume_and_get()
fails and proceed anyway.

This could happen during suspend to idle. So we must assume it is unsafe
to access the HDMI register. So bail out properly.

Fixes: 0f5251339eda ("drm/vc4: hdmi: Make sure the controller is powered i=
n detect")
Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
Reviewed-by: Ma=C3=ADra Canal <mcanal@igalia.com>
Acked-by: Maxime Ripard <mripard@kernel.org>
=2D--
 drivers/gpu/drm/vc4/vc4_hdmi.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi=
.c
index d57c4a5948c8..cb424604484f 100644
=2D-- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -429,6 +429,7 @@ static int vc4_hdmi_connector_detect_ctx(struct drm_co=
nnector *connector,
 {
 	struct vc4_hdmi *vc4_hdmi =3D connector_to_vc4_hdmi(connector);
 	enum drm_connector_status status =3D connector_status_disconnected;
+	int ret;

 	/*
 	 * NOTE: This function should really take vc4_hdmi->mutex, but
@@ -441,7 +442,12 @@ static int vc4_hdmi_connector_detect_ctx(struct drm_c=
onnector *connector,
 	 * the lock for now.
 	 */

-	WARN_ON(pm_runtime_resume_and_get(&vc4_hdmi->pdev->dev));
+	ret =3D pm_runtime_resume_and_get(&vc4_hdmi->pdev->dev);
+	if (ret) {
+		drm_err_once(connector->dev, "Failed to retain HDMI power domain: %d\n"=
,
+			     ret);
+		return connector_status_unknown;
+	}

 	if (vc4_hdmi->hpd_gpio) {
 		if (gpiod_get_value_cansleep(vc4_hdmi->hpd_gpio))
=2D-
2.34.1


