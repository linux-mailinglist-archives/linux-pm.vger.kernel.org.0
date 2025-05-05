Return-Path: <linux-pm+bounces-26655-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C1BEAA97EA
	for <lists+linux-pm@lfdr.de>; Mon,  5 May 2025 17:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65EB1189C538
	for <lists+linux-pm@lfdr.de>; Mon,  5 May 2025 15:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B32263F5E;
	Mon,  5 May 2025 15:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WHRWY+f5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5666B264FA6;
	Mon,  5 May 2025 15:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746460205; cv=none; b=FoTEEyHxZJI/RIe857mrOX4vHoit1pmLFANV1Q3+ZJaOJSz8ilL4vbRhczTXuOF9qa7S0ysMVZF4WJEnlm2T9YeiFYsVTFayf2pajt6QoDQLSh6DiyxomGljlgQ6gue52i3Ds4wmAs8lffz1bHOgtQsjwiI8s8y32wRYdHaVROA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746460205; c=relaxed/simple;
	bh=kYiHN+nVO56jpSLDAYAFIb8zFBmSTO/Xrj6sX4vDXQ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n1dDOCefOaOuCWqnjz1VMpIO2zJJfKxQlzrpcoJUcO8Bn3MryBn8HXDCj/qoaZIinmq/8cLwZs9YNiauTUglGSacmmMnlAhHm7gNzNHBua2u58cZrkqyXtC6O8otcB9YWx37x3dDPgOQSAHmLdn1f9aDfp9lv0rpcvNNgLaNT3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WHRWY+f5; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-60634f82d1aso1259313eaf.3;
        Mon, 05 May 2025 08:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746460203; x=1747065003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QzxoNjX13i4eG31sNq5COpLdWdwplkA/ut9vzb6w+YA=;
        b=WHRWY+f5hDH7Ku+c+S2VKu2igtVUB+TfhDs2F3G/5tQNlpBwfQiu0Mywjps2hAlvcT
         +mPgEnlhI59qRQPxmk7d/0GG7sS+AGnkHtwyKUepLuIBcBt12tYEI0vIBhcsvndH8ahE
         n78i8WxHZiugErvicRkXr0FbahNfQ1SANFmh+asV84U4tbf0ZEF35yietjdFmTI/H+Ep
         bEOytD2K/ntzPcVE0P5LNuJSBY2LKb5pFevKTwc0jFHXq4FpnQSpSVIUS2vkfvDrlwtN
         HfciZ4wq1MgLRenNPlDzXveD++hT7L/S/IBM6oj2376NXbl9NBIQSSwQaHKBBIsnpRd2
         XQpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746460203; x=1747065003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QzxoNjX13i4eG31sNq5COpLdWdwplkA/ut9vzb6w+YA=;
        b=X4pjdIestnd/XW/1ChUteGzxioX4ObpDxFdKp1KLC9vQMWWV6MYCZAhkM2ue8C4/XH
         AVWGarzpV6Ja8MVje62NfP5kii5+JIzX+6XZux3Pre2QgaVA7cssvRGiJb4Hd5ISN2VK
         0yLy/pfFPvnBkjd8RgEwkka6ik5k4NF0p87o3By66PZJq8RTOQ3IfdksqgmdWu5ivgxb
         w/SZ96oE1F4s13NELE/y9yk71rMO1vJ7Y18+z/stDFzfM9tHJ3o2E+99pyfqobqK1VzL
         Nf/yCT8grJU9Tjn2MnDORUgvWFtmtdBboWe/MRwD3jBP1IZOXifezJR9Yafkk8Cvdkhn
         E66A==
X-Forwarded-Encrypted: i=1; AJvYcCW5K8CrXbVxz9Ux34pw6Ymt1RNaiD7qBOO3s10Lc5myRJTkcviOY9D41UOv80FhqSgLHfWhs7wqCoipOXo=@vger.kernel.org, AJvYcCWo+HX/rzo1Gtr+IiEmLpfxkl97MU6DvTPCQ85AuREJRzhK1C+52UEYgU+qqGNMQYuj9Ns89ULxVG4=@vger.kernel.org, AJvYcCXgnKHepCYxqgKVTss4HRsqIwvaK2HMJCj2Lns+nnJja1iuow3UUg5CwDFCjohXIILXWVd7kQUp7LIcqwtdIT+pzw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwdDTuWNz3ClP3R+RadwlWgnZ4wU0HkCCDvBKrNfzhAL31OQSya
	JSAK0BhgHA1AYvUVQWjl9CaeR7KiM+INJrwfHV8IddfTbh6vMnUO
X-Gm-Gg: ASbGncvrdLUhTu+7e0KHV8jX46Qc0AM83EgbQGnupQE8MJIqT7gs0u+l28GHwPGAh/b
	Mcw0VN6P6pGnYk/S+JiUQ/cKZdkn8OnRRCenEVgTJoqhdEqZ0l4iITcbD6tTmCrPDvklbTkXVux
	2vLfUiigH5VF+36Av7ktcoWwmMT7oU1AYUfvSfIpNx6IlrwgIPgCeLFz0npvc9WNu3Zl2nEDxvX
	IEO9az0YTb2kikh0il+3FPYKjH8spjSyO9ttaY3GEMZP/+4RKwvVyRct/MBIivpVZZIACCMgyWg
	LRsjWFj/fKpxgf/xUKqoH1nY893r/fexE+q5gjF5FHYRYn7vxea4staYGzuFHsU=
X-Google-Smtp-Source: AGHT+IFmXHRAfXFJOCHFZobnyaZvTqkwxSNtmF5ex7yON9mHi0l4M2n37VTw9ZY8eHmQoifZiTSQ/g==
X-Received: by 2002:a4a:ec44:0:b0:607:e293:95b2 with SMTP id 006d021491bc7-607fab26b1emr5755194eaf.8.1746460203351;
        Mon, 05 May 2025 08:50:03 -0700 (PDT)
Received: from hiagof-nb.corp.toradex.com ([67.159.246.222])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-607e7fe84a8sm1606217eaf.36.2025.05.05.08.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 08:50:02 -0700 (PDT)
From: Hiago De Franco <hiagofranco@gmail.com>
To: Mathieu Poirier <mathieu.poirier@linaro.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-remoteproc@vger.kernel.org
Cc: Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Bjorn Andersson <andersson@kernel.org>,
	Hiago De Franco <hiago.franco@toradex.com>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@oss.nxp.com>,
	daniel.baluta@nxp.com,
	iuliana.prodan@oss.nxp.com,
	Fabio Estevam <festevam@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH 3/3] remoteproc: imx_rproc: add power mode check for remote core attachment
Date: Mon,  5 May 2025 12:48:49 -0300
Message-Id: <20250505154849.64889-4-hiagofranco@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505154849.64889-1-hiagofranco@gmail.com>
References: <20250505154849.64889-1-hiagofranco@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hiago De Franco <hiago.franco@toradex.com>

When the remote core is started before Linux boots (e.g., by the
bootloader), the driver currently is not able to attach because it only
checks for cores running in different partitions. If the core was kicked
by the bootloader, it is in the same partition as Linux and it is
already up and running.

This adds power mode verification through the SCU interface, enabling
the driver to detect when the remote core is already running and
properly attach to it.

Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>
Suggested-by: Peng Fan <peng.fan@oss.nxp.com>
---
 drivers/remoteproc/imx_rproc.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index 627e57a88db2..86541d9d8640 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -8,6 +8,7 @@
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/firmware/imx/sci.h>
+#include <linux/firmware/imx/svc/misc.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/mailbox_client.h>
@@ -906,6 +907,21 @@ static int imx_rproc_attach_pd(struct imx_rproc *priv)
 	return ret < 0 ? ret : 0;
 }
 
+static bool imx_rproc_is_on(struct device *dev, struct imx_sc_ipc *ipc,
+			    u32 resource)
+{
+	int ret;
+
+	ret = imx_sc_pm_get_resource_power_mode(ipc, resource);
+	if (ret < 0) {
+		dev_err(dev, "failed to get power resource %d mode, ret %d\n",
+			resource, ret);
+		return false;
+	}
+
+	return ret == IMX_SC_PM_PW_MODE_ON;
+}
+
 static int imx_rproc_detect_mode(struct imx_rproc *priv)
 {
 	struct regmap_config config = { .name = "imx-rproc" };
@@ -949,6 +965,13 @@ static int imx_rproc_detect_mode(struct imx_rproc *priv)
 			if (of_property_read_u32(dev->of_node, "fsl,entry-address", &priv->entry))
 				return -EINVAL;
 
+			/*
+			 * If remote core is already running (e.g. kicked by
+			 * the bootloader), attach to it.
+			 */
+			if (imx_rproc_is_on(dev, priv->ipc_handle, priv->rsrc_id))
+				priv->rproc->state = RPROC_DETACHED;
+
 			return imx_rproc_attach_pd(priv);
 		}
 
-- 
2.39.5


