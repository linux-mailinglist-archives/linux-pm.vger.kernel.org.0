Return-Path: <linux-pm+bounces-27371-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C207ABC566
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 19:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 464463AEB81
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 17:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0364288C35;
	Mon, 19 May 2025 17:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iqMdd78a"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6F3288C36;
	Mon, 19 May 2025 17:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747674988; cv=none; b=u5jLjYxyyySvH7bg/qt28DlCETPjUKF3AOJNIRVwpa+jy/1zdpmA74jhkmZVnSzsLS7QBGSLsbnjoPEPj7De21F99/LxhyaWHns2zq2SaSPavt2S1lcujUAbwTkEOpe/D+ROrZXx9XoGtGvtY2vATwI7W4XNM6PcVZRD4yn3Oj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747674988; c=relaxed/simple;
	bh=PKBq78bzubgMQ/vHAE1CkKGTFKeq16OIfKRTurY/NKM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NmzKeVBkb58jCXngJ4ms75QTEn52nT7XSgA1ewCmWEIe5Ybz9Iazaz6TY87nclB6BVtVahXJQNO/JyMNZYrXYhfS/tbOACENzCJk+ElMk2uCFIJ8QRExdJTYhyrvOhmYifTMFCzWI9F9f9VEj1qDz9qivDA7B+7xnRLPd3T6Ob0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iqMdd78a; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-52446b21cfdso1456144e0c.1;
        Mon, 19 May 2025 10:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747674986; x=1748279786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7omkwwv22LywzPK9OnluDC1evnMI2mYZ/bT9rkSvGw8=;
        b=iqMdd78aXASG+Sjiu6scIMgX34l29vfHowqw2BlqyW5rCejD1FQ11pQP87G8vo+gPW
         YKDf+P7RsAJP8EKCxJnbgf6kVdFI2NnY6TlDePqYtGIzwklCMkRn76Pc5XQen4ulZxWX
         YyG/CXlPtBObQnoE1iug7u2u882Tl8CdQyIpo4auDO3wZMzrHiz+Q2ymmSi6FeVgGAxZ
         s6rizKSlVj0fZI3qWPAWh9eeOJ4e+ecGfHPf/UjSSxIgg0LVcKoQJUF1Slcawdo8selP
         QixCPmd5wpVdS1LVDEktifpfXbwy9vFXdsxkoqjq6GJmN8b/mt11eDkoyTx8m62uH/Mc
         LBOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747674986; x=1748279786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7omkwwv22LywzPK9OnluDC1evnMI2mYZ/bT9rkSvGw8=;
        b=H5UQavKQ2Lf1c/8MiZBvFZNzVP6MnjZxSgttaMACIgIgc3BBOLekiTUyqelMVeNnho
         KMXiFX8xHAViv5ReFsEOEcl3jQOKWFGPubi/79ZCCPgAK4eJYULMj/V9LyqX1F+ExCVO
         lqti/y1MOwjxj4CVFBd343djLdZg66oIUYZk8hVFWgtQ9kzQ4CmW5GktaXHH4qr2hGY/
         OqStJrfBt6jZxa6I4jg6ulILhUjpRXWDcA0NiV3hmID9wxjPdBkK3xUd06paunJldJSK
         LxhiJ+qjx3FwAOH3UnelpHBKaQTNS5SV25k1wMDQ2Nf5u/2PKd3BbARKR0LZNzVC19jz
         u1Hw==
X-Forwarded-Encrypted: i=1; AJvYcCUR/ppc6cDpsEmhR7w1VCldpMz0M/4EYE/okQjXdIPzMuoP0l2jZS58XVzJPDdO8Qx4VXV7s+rzwDSadeo=@vger.kernel.org, AJvYcCUe1ldpBTTor2bN0PBCPTI5NqoDDtn07lNDbr0mOobWa+C0I/TSNEyQWYznvCrGEbbrno45jLAYwP42+O/id4zc/Q==@vger.kernel.org, AJvYcCWuW57DKFcnoho6XECtAAmQa9rE4MI6vhs7pEDCmKFKZaoEB0ISXD3077z25HN7Z7Exvyk3Jhn/JGA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUcuuRl3sLGRgYmxuCUCTDhjZ2ydO+pQ3aJ/PWFgLnzboG0qT+
	V/tCFaP3LsqJ3ow2AvjoJ1VY7oi9kClgp2oRcB4gr3j9Vlgum3w+Ugnd
X-Gm-Gg: ASbGnctxwBFIQ3kQo6sga7VSF0jYJLj6lJqrHhpvMPs+E76XfAVsy00otOfK9tNH/aD
	5w1cHSTfIzMNw4MgtE3f9EIt8QnaXpgMQ8O5RB9SxYcQuYD7KGJKYvRTbkcwo7lvijOkQ5px7C0
	jdtl5asg4vMdtuTpzf8Qy64lzp6uwa3oXRzoDYXD4pOKlMQV218oQ5q0Wm3bT1Xhu3XQkpOy1mI
	z+pOi6ARJjYXX2QW1wKlJMdxBwkXC75o3uylY6PZjOgSl9B0am70qhbva6i7DjLyY76/wdujOCk
	cnkLWA5BMUilvHg6OrmrT9br588ZWCQCtcm5sSni46o0r+mITH34qJWeaG258M83dVEsiGBGLvl
	57AnHhShm
X-Google-Smtp-Source: AGHT+IE6q6gZqSe9Ip0nuMzYQBfcuFkViraMC2BkT8AsUnpaWIwgC9BeYahAGarm+vPPXTf/z60teQ==
X-Received: by 2002:a05:6122:8c0f:b0:520:3536:feb5 with SMTP id 71dfb90a1353d-52dba97c622mr12664280e0c.11.1747674985608;
        Mon, 19 May 2025 10:16:25 -0700 (PDT)
Received: from hiagof-nb.corp.toradex.com ([67.159.246.222])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-52dbab4e983sm7003647e0c.31.2025.05.19.10.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 10:16:25 -0700 (PDT)
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
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v3 3/3] remoteproc: imx_rproc: add power mode check for remote core attachment
Date: Mon, 19 May 2025 14:15:14 -0300
Message-Id: <20250519171514.61974-4-hiagofranco@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250519171514.61974-1-hiagofranco@gmail.com>
References: <20250519171514.61974-1-hiagofranco@gmail.com>
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
Suggested-by: Peng Fan <peng.fan@nxp.com>
---
v3: Unchanged.
v2: Dropped unecessary include. Removed the imx_rproc_is_on function, as
suggested.
v1: https://lore.kernel.org/lkml/20250505154849.64889-4-hiagofranco@gmail.com/
---
 drivers/remoteproc/imx_rproc.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index 627e57a88db2..9b6e9e41b7fc 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -949,6 +949,19 @@ static int imx_rproc_detect_mode(struct imx_rproc *priv)
 			if (of_property_read_u32(dev->of_node, "fsl,entry-address", &priv->entry))
 				return -EINVAL;
 
+			/*
+			 * If remote core is already running (e.g. kicked by
+			 * the bootloader), attach to it.
+			 */
+			ret = imx_sc_pm_get_resource_power_mode(priv->ipc_handle,
+								priv->rsrc_id);
+			if (ret < 0)
+				dev_err(dev, "failed to get power resource %d mode, ret %d\n",
+					priv->rsrc_id, ret);
+
+			if (ret == IMX_SC_PM_PW_MODE_ON)
+				priv->rproc->state = RPROC_DETACHED;
+
 			return imx_rproc_attach_pd(priv);
 		}
 
-- 
2.39.5


