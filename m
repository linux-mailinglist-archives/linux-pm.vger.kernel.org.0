Return-Path: <linux-pm+bounces-26654-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC336AA97E8
	for <lists+linux-pm@lfdr.de>; Mon,  5 May 2025 17:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 927633A5AD3
	for <lists+linux-pm@lfdr.de>; Mon,  5 May 2025 15:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE0D2641CA;
	Mon,  5 May 2025 15:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TVw+WWRT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDE6263F5E;
	Mon,  5 May 2025 15:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746460201; cv=none; b=YUnGSEGOyH9ZXwTP+mqxJkEEO6OBjY2+BEizjY/M3vTAISz/VlIsnNVp1M7Uf2BxprTTm9iYoiZDh0GGyE5QMg9I8+zZnOblWvHy5QCt6grrsH2+jy/KvA1tZGVuoKkgl28L9rRY+32KOQu14acxaEdGWQ7KSWekP2tMMhZ87wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746460201; c=relaxed/simple;
	bh=oBMozJskEtvEjWYaahWUrCheNux/pXEF9fkwgtqsPEo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TxqhWk0DCCUbp9bMcrmSkbAQ6lshmlb2jyxmR7wNynCrTkYslq4IcymbBpbef7XqWhujgVM+7nP4BQRqvPqjaV+gFr4fp7Fu29u/1lUwweq3MJRojMGeFX7Q9QeGjZnGCHB/IDxgPm2fZ70hzuVE3D3DkCVO3/97zhYApJl3/h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TVw+WWRT; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-60634f82d1aso1259287eaf.3;
        Mon, 05 May 2025 08:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746460198; x=1747064998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bF/eU9zOanUVVZXeOgSfSnbo986yXdUGTIPTl3NGixQ=;
        b=TVw+WWRTdXvrCX3/dWOUWD570jUij4+6XxA2gL5dL+XHUmv2UHJ3sYgvLIXOeznOIl
         VchoiHFNuE0HuL9xRwzoIG+RiGT8Jxkmze8y+9fQdlU0Q4dMF+HfYWMoYRYpMXjhQSzo
         Li7sAHFfTWdh1xeQJIe4tkU5AIngwwgpYw6cdTPvJjdJY5QuAiJ2v8KU0uE0p74CAXYh
         XCZJn6Fc1tAJufFip3AXuxcfx2N/0UqwJD8sMj5DETAZ/jlE1VdTCSzTg1Vqabh+Yc/K
         05q0e2gb3abK/c0ME5pGzLi3l0iN7qW2mvUZkJCdSAq8q8trshbJfB72W2PrmB2Cwjl1
         SBhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746460198; x=1747064998;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bF/eU9zOanUVVZXeOgSfSnbo986yXdUGTIPTl3NGixQ=;
        b=ODLjPnnD++ErWXsTcyWOQtchT2GO3zHIVekf6BodZqfLmymIuG/V3T6zXEsptdrYaS
         oQjDpEnHkpCut9+sclPBzmmosr8HBhsDJlMrqmWvsoQOdiyzVFrhhZe/27J7DaarQAtW
         9kthz+q0EksQLuwLM7auiD51C1ZhPOdtpLO9KDqihhaifBDuzIBi9O8CmjYnf6gReFDN
         yez7BGVsRraGl8tzjdlFsJ9bi8wmrLIuVAcmKS2ZWqWRG9blwtz4RcQQWnfMBeIDlmz3
         POKn+slJBhxB0ztF+C/vprHFkUMjyk3egq3i8rGx4EyZcbTmTqZkElZU1zXqHxgDy2QB
         Udzg==
X-Forwarded-Encrypted: i=1; AJvYcCUHmfNtEwQb8UO72Zd0dDI2s/RzzuE74SvDuAG+F1bjVT0z6d3QFT92SitXYIH69CuOFzhSIe3dtEYkoUs=@vger.kernel.org, AJvYcCUW9hSW24ri09I+MdoeOYiqsXW99umo5xx5IehFShHJKqRc8n42xiEO6VOduxKRXqC4q3BD68OHlco=@vger.kernel.org, AJvYcCX8GCMdHRoleYz78YowbZT1CZP0aPNsJfHZMPE2dOHhJ9y1rrT9E3omzzQhERDNtUTJ6WECNgB4uDmgkyBCsDxvBg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyJCCwt3ocoCpOA7QNvGC9al4GfA5dTbmzoF0MqdHaXkvp5dEJf
	RY952cc+nKkhyEP3PfRJay/Nqmjkkc0RC2o4mGWPKP8fhIhlgamC
X-Gm-Gg: ASbGncsoZYCOCDAeQfAdUqW2i8/bVMmL+K+58Rt1DZVpJPHcIB73/p5csemvgmToMa3
	eAVaxWWiu2ecULXW9otM8Rfx5wpZoDudGdG369ipNpYoc9nsgSq0SevMaklRAlkFCxEIUnpKszq
	R2kDRo52/ARqndQS2DtRBHlb3pw+MU3VOo8UOvzsrKSHMSRi+EcDuerXqvrwT2BHArvjo4W3zn0
	8m5KyINRD3A47ypYU0SzoiGGXCcd2lv1t4NiekVuxJkmykaXWgW9khG1CRQoHo8qXihFagncDzM
	KAzPrXFPewGOoCqmRxH+HiZlGado0EiWdW0KfldwHdOTpJOkfW/Vug8Wc2hed68=
X-Google-Smtp-Source: AGHT+IFxOKSARBqkkegTT/BsbuPFrrDgx1ik3eNh9a8qIMK8qDnzx+rY6GvlMdOoHHyHuHjMiQD4vQ==
X-Received: by 2002:a05:6820:208:b0:603:f973:1b3 with SMTP id 006d021491bc7-607fa81c1f3mr5567422eaf.0.1746460198572;
        Mon, 05 May 2025 08:49:58 -0700 (PDT)
Received: from hiagof-nb.corp.toradex.com ([67.159.246.222])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-607e7fe84a8sm1606217eaf.36.2025.05.05.08.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 08:49:57 -0700 (PDT)
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
Subject: [PATCH 2/3] firmware: imx: move get power mode function from scu-pd.c to misc.c
Date: Mon,  5 May 2025 12:48:48 -0300
Message-Id: <20250505154849.64889-3-hiagofranco@gmail.com>
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

Move imx_sc_get_pd_power() from pmdomain/imx/scu-pd.c to
firmware/imx/misc.c and rename it to imx_sc_pm_get_resource_power_mode()
to maintain the same naming logic with other functions in misc.c.

This makes the API available for other use cases. For example,
remoteproc/imx_rproc.c can now use this function to check the power mode
of the remote core.

Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>
---
 drivers/firmware/imx/misc.c           | 47 +++++++++++++++++++++++++++
 drivers/pmdomain/imx/scu-pd.c         | 29 ++++-------------
 include/linux/firmware/imx/svc/misc.h |  8 +++++
 3 files changed, 62 insertions(+), 22 deletions(-)

diff --git a/drivers/firmware/imx/misc.c b/drivers/firmware/imx/misc.c
index d073cb3ce699..61fcb0066ec9 100644
--- a/drivers/firmware/imx/misc.c
+++ b/drivers/firmware/imx/misc.c
@@ -37,6 +37,18 @@ struct imx_sc_msg_resp_misc_get_ctrl {
 	u32 val;
 } __packed __aligned(4);
 
+struct imx_sc_msg_req_get_resource_power_mode {
+	struct imx_sc_rpc_msg hdr;
+	union {
+		struct {
+			u16 resource;
+		} req;
+		struct {
+			u8 mode;
+		} resp;
+	} data;
+} __packed __aligned(4);
+
 /*
  * This function sets a miscellaneous control value.
  *
@@ -135,3 +147,38 @@ int imx_sc_pm_cpu_start(struct imx_sc_ipc *ipc, u32 resource,
 	return imx_scu_call_rpc(ipc, &msg, true);
 }
 EXPORT_SYMBOL(imx_sc_pm_cpu_start);
+
+/*
+ * This function gets the power mode from a given @resource
+ *
+ * @param[in]     ipc         IPC handle
+ * @param[in]     resource    resource to check the power mode
+ *
+ * @return Returns < 0 for errors or the following for success:
+ * IMX_SC_PM_PW_MODE_OFF  0	Power off
+ * IMX_SC_PM_PW_MODE_STBY 1	Power in standby
+ * IMX_SC_PM_PW_MODE_LP   2	Power in low-power
+ * IMX_SC_PM_PW_MODE_ON   3	Power on
+ *
+ * These are defined under firmware/imx/svc/pm.h
+ */
+int imx_sc_pm_get_resource_power_mode(struct imx_sc_ipc *ipc, u32 resource)
+{
+	struct imx_sc_msg_req_get_resource_power_mode msg;
+	struct imx_sc_rpc_msg *hdr = &msg.hdr;
+	int ret;
+
+	hdr->ver = IMX_SC_RPC_VERSION;
+	hdr->svc = IMX_SC_RPC_SVC_PM;
+	hdr->func = IMX_SC_PM_FUNC_GET_RESOURCE_POWER_MODE;
+	hdr->size = 2;
+
+	msg.data.req.resource = resource;
+
+	ret = imx_scu_call_rpc(ipc, &msg, true);
+	if (ret)
+		return ret;
+
+	return msg.data.resp.mode;
+}
+EXPORT_SYMBOL(imx_sc_pm_get_resource_power_mode);
diff --git a/drivers/pmdomain/imx/scu-pd.c b/drivers/pmdomain/imx/scu-pd.c
index 01d465d88f60..945f972e636f 100644
--- a/drivers/pmdomain/imx/scu-pd.c
+++ b/drivers/pmdomain/imx/scu-pd.c
@@ -54,6 +54,7 @@
 #include <dt-bindings/firmware/imx/rsrc.h>
 #include <linux/console.h>
 #include <linux/firmware/imx/sci.h>
+#include <linux/firmware/imx/svc/misc.h>
 #include <linux/firmware/imx/svc/rm.h>
 #include <linux/io.h>
 #include <linux/module.h>
@@ -328,27 +329,6 @@ static void imx_sc_pd_get_console_rsrc(void)
 	imx_con_rsrc = specs.args[0];
 }
 
-static int imx_sc_get_pd_power(struct device *dev, u32 rsrc)
-{
-	struct imx_sc_msg_req_get_resource_power_mode msg;
-	struct imx_sc_rpc_msg *hdr = &msg.hdr;
-	int ret;
-
-	hdr->ver = IMX_SC_RPC_VERSION;
-	hdr->svc = IMX_SC_RPC_SVC_PM;
-	hdr->func = IMX_SC_PM_FUNC_GET_RESOURCE_POWER_MODE;
-	hdr->size = 2;
-
-	msg.data.req.resource = rsrc;
-
-	ret = imx_scu_call_rpc(pm_ipc_handle, &msg, true);
-	if (ret)
-		dev_err(dev, "failed to get power resource %d mode, ret %d\n",
-			rsrc, ret);
-
-	return msg.data.resp.mode;
-}
-
 static int imx_sc_pd_power(struct generic_pm_domain *domain, bool power_on)
 {
 	struct imx_sc_msg_req_set_resource_power_mode msg;
@@ -438,7 +418,12 @@ imx_scu_add_pm_domain(struct device *dev, int idx,
 	if (imx_con_rsrc == sc_pd->rsrc)
 		sc_pd->pd.flags = GENPD_FLAG_RPM_ALWAYS_ON;
 
-	mode = imx_sc_get_pd_power(dev, pd_ranges->rsrc + idx);
+	mode = imx_sc_pm_get_resource_power_mode(pm_ipc_handle,
+						 pd_ranges->rsrc + idx);
+	if (mode < 0)
+		dev_err(dev, "failed to get power resource %d mode, ret %d\n",
+			pd_ranges->rsrc + idx, mode);
+
 	if (mode == IMX_SC_PM_PW_MODE_ON)
 		is_off = false;
 	else
diff --git a/include/linux/firmware/imx/svc/misc.h b/include/linux/firmware/imx/svc/misc.h
index 760db08a67fc..376c800a88d0 100644
--- a/include/linux/firmware/imx/svc/misc.h
+++ b/include/linux/firmware/imx/svc/misc.h
@@ -55,6 +55,8 @@ int imx_sc_misc_get_control(struct imx_sc_ipc *ipc, u32 resource,
 
 int imx_sc_pm_cpu_start(struct imx_sc_ipc *ipc, u32 resource,
 			bool enable, u64 phys_addr);
+
+int imx_sc_pm_get_resource_power_mode(struct imx_sc_ipc *ipc, u32 resource);
 #else
 static inline int imx_sc_misc_set_control(struct imx_sc_ipc *ipc,
 					  u32 resource, u8 ctrl, u32 val)
@@ -73,5 +75,11 @@ static inline int imx_sc_pm_cpu_start(struct imx_sc_ipc *ipc, u32 resource,
 {
 	return -ENOTSUPP;
 }
+
+static inline int imx_sc_pm_get_resource_power_mode(struct imx_sc_ipc *ipc,
+						    u32 resource)
+{
+	return -ENOTSUPP;
+}
 #endif
 #endif /* _SC_MISC_API_H */
-- 
2.39.5


