Return-Path: <linux-pm+bounces-12665-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E21AA95A6E4
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 23:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20C7C1C22781
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 21:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C8217B508;
	Wed, 21 Aug 2024 21:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="Z/MX8qAZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E872A17994F;
	Wed, 21 Aug 2024 21:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724276499; cv=none; b=afroiOn9Y72DCePzOoLMP4Ft7nOp+gabAibvlAxwGSVTkgXmhq68vwCmOS4ET11VaNSS72wZ97vXAlXcXHZk5DXZfkjri36TNqVxqwaJU0JALdcGi4ZVkxXc1KU0PGnb7MkI1xphhzPcRbt4KdTvXahd7F0uAukPAOfh9Y2vNLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724276499; c=relaxed/simple;
	bh=ibj0CC9kYkZBo2Ogqtrzi7iedyDjmLgyq1IbcoPK8Ww=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gTenJPuHPqueO4ak7ufMTCaSlFU++otCe9UfPzzPe/xg8lCxfOhqOCjJp6Iv2vHfcGMoULJCsxktymphnMGW/1fgxgX7QIHxU2J8YWFUt35YnorouhBj+8obJrVaq89XdGxvtNZspbXN+bGJqBSg8ETCYqej9/v7k/TLS8OAWmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=Z/MX8qAZ; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1724276470; x=1724881270; i=wahrenst@gmx.net;
	bh=xtr9kBJY4X3MX0Mx9EKJ4hQqPNtFCg//q2jcoGycQkI=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Z/MX8qAZtZxMtXrj8ZQNRCPMocCvwxqyKFs7ZMt2FgG2h5/bAoOt9ITT31AArOpe
	 Nxv32eCf4IYW2JoLIBHyqqNgE7DEClsj4subF5bQ8j4P7lPdd9gydte3yF4OcM5Ze
	 FBEgH4UUw4er9PJTxXzhxjmx7tljCA/iDkYOjcCUbp9PmXDS16zOLK3O6eExze9P2
	 8IhQHqdXjQnenNoyW8Ozz4r6+3d0OVeWbZPiTpAiIqLJASK0i8tBbx8KTZ+3QEf0y
	 Iyt/5XvRnu1UydlbRB6wNtlapW7HTaDTdnQ3238m54Rlw3qm39ZXZ5Z4fTIiuMtQu
	 is3RtH64Nz7oDvqhCQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MUowV-1sYKTH1bSD-00RZdv; Wed, 21
 Aug 2024 23:41:10 +0200
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
Subject: [PATCH V3 6/9] drm/vc4: v3d: add PM suspend/resume support
Date: Wed, 21 Aug 2024 23:40:49 +0200
Message-Id: <20240821214052.6800-7-wahrenst@gmx.net>
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
X-Provags-ID: V03:K1:iSPaP7dVaCfkDnoT7GUAk9j0q0tyJQzM/rwNmg7Z2xfsMGZbqOo
 VA+mt/reSmfRFLwT7nzqjzhmpYuv2iNAFU0WrfbBRh7oygmtYRDCPwt7gzZNz6178FYqj1Z
 MhwPj6dN/mZ8UP96bfTEYBY5VD/DtsNRcl8lZDGyqK1i02+LbIIVb5IdZZbYqrYTNVp/pfL
 DwJc9SCFAdLRdZf8Ue0RA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4UDfCApTLZQ=;aJrzXp9h9WhNB+elsrHTYRy3Md2
 r9kE2lmHUV26gNoEIb1tt2s2fVD7YJ1Ukbh8ty+TWHFUAUetbn1/b7VgoSHIaogfuASIOD/L3
 HKFJLnB0hFjf05wlawN39Z5waRP1p1s0o+BIEmXn9QUx4432EsU24dBw13sbs62BKqGxrNKcq
 RqxdVAFQmb+HSWbcwMj40CcWiT0ov+Cqmzza6G0ERu0skiGZYYCWTr4MGh76HPSiSBEAtcqYH
 1DU+gnxHAms6+5FjFxDdXigwG6kPlqTy3pu7ghG63eU65hQH5R4bLz6V7cUoBaua4sN/gr09S
 YS1POifAXIafYl2zp6jYhFv7BU2/XtC3u7ziHR9xkBLgsbLl7vBpTv0Y+PaTuMJwWRvaGyDdR
 mzl+eas2HYBd8k0Yg39hkG0auRrZGyYrKyYlBlhG+14wHYIGnH+YeJIuKWWQv8Xcizc+meqJF
 GrwjfWoI1xKeSQvEoPwf08BiOWwgJJ4tBjDuDgYDvqzu7uDv33KhR2//IjATUAN0a7Zw0rUvH
 rxAbX4dyoXrwGHj9dO0VxzvX9VTq2SglgGDpeCDVRjTk+grVpmXxFEXomR8Z08RzLEtYosBY/
 gKGlDXmj7UvWk3XskMzplcnOSIuYslJj8DTdltw6EaZctK8JDyROs13+HZbpyHqDA6T9QKa9c
 qeIlX1faYECptTsqdbSOnfaqSr2DLpQ8JM7PJhz0B1V11L6RV/UedmFfHR593FVUla3x54nDI
 5axOARxueG0DQHPDpBa3KCIbBbKUZQAYlcMH5mS9/pDnM105mM7acw/Uw51M70xtHZ6zDQAMy
 cRjssMTKltIdFrd2ZuQh0EJQ==

Add suspend/resume support for the VC4 V3D component in order
to handle suspend to idle properly.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 drivers/gpu/drm/vc4/vc4_v3d.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/vc4/vc4_v3d.c b/drivers/gpu/drm/vc4/vc4_v3d.c
index bf5c4e36c94e..03c790f7ffc6 100644
=2D-- a/drivers/gpu/drm/vc4/vc4_v3d.c
+++ b/drivers/gpu/drm/vc4/vc4_v3d.c
@@ -508,6 +508,8 @@ static void vc4_v3d_unbind(struct device *dev, struct =
device *master,

 static const struct dev_pm_ops vc4_v3d_pm_ops =3D {
 	SET_RUNTIME_PM_OPS(vc4_v3d_runtime_suspend, vc4_v3d_runtime_resume, NULL=
)
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				pm_runtime_force_resume)
 };

 static const struct component_ops vc4_v3d_ops =3D {
=2D-
2.34.1


