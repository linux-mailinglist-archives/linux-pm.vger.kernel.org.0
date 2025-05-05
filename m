Return-Path: <linux-pm+bounces-26653-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1605BAA97E1
	for <lists+linux-pm@lfdr.de>; Mon,  5 May 2025 17:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E09A17A037
	for <lists+linux-pm@lfdr.de>; Mon,  5 May 2025 15:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B4CE263C91;
	Mon,  5 May 2025 15:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J1VphmUL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9848261571;
	Mon,  5 May 2025 15:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746460196; cv=none; b=UA1wjlyNp/X0WT+hvlbeX82Gww/O9wGjVxNRqbe/MN7vkVKwQjDI83vZE8QDA4kVHPVwyNdV4yPHkkY3oONJB+dFPNwS5oJ8w+6mbNI2nIjEs1U5cB7uPPtI9S/yNoOrq9uZO06RbHfCa+mjPO+UzI8hM4hUC63dtVf4tFpI7yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746460196; c=relaxed/simple;
	bh=sBz0S7IFIbK4ZEXgBhD2c8M5U9d3QySQf/FYHBNgH4s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nlOz/l7e5g2l8vLIupJMjIjb6RlGWSzjg61fkRfwDkbpqCCmdhprNX4REo401qGzGVksRI6tWnJFAonFcRrHzdmvpinREKYuOeUQmri1RD515YJaUiVa1vAFZgPpe7RlzNJKH+2h2tMbMxRYUwYxkdGrXgf1Q41B5oD3Bgh3BEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J1VphmUL; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-6065803ef35so919839eaf.1;
        Mon, 05 May 2025 08:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746460194; x=1747064994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jrh837RVy54Gg6Y+qeX+8goZwlDp8QNNPgp6OA+KrOY=;
        b=J1VphmULFjrPMbsO+aBu+8QAqV3krNICPaxJ5kLnEryug2JaMi6BGBzYnva/WzJQRE
         01rsmdm6KQC1N3Uy0Ikzp3T2sJL6z8nDl1KyVsVNzQ/bdo7fL255kyj1JPbFfceAwddl
         UxqJJbH9A1l6QWanq8bRbAxZOjTE6wSKb6vU6LjYPUamrKvfksRN5HNNYc6z+zPd/zAO
         bkzbK5/a4T/d0JIVpW5Sl6wHs2E8kayaf73P5tolDWPbwYO/XTcNZjoX0mtiWCaXIaQ2
         CG33NE+QJaU3eziadwiUQpB3c3fdgshEE+0LUEor5lmfwbS0JZPFbvsn7z0CJgLgEZ91
         hXtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746460194; x=1747064994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jrh837RVy54Gg6Y+qeX+8goZwlDp8QNNPgp6OA+KrOY=;
        b=Im3z6V4vNfknnsTv6xFgRc+FAl1NocCi3S9wdRdn6hxONll42upU9CSMDiRi70aIzZ
         FaftY7bRIXpCsJ/eh3+76YUDyG95zca8VzaP+Vx0opSOjNNzhQllgNqLQHz8ku7ijfAq
         sq4nx0H6izCLkIsqMY6KAEZe+tH4df6QboTHfdHgEMCXt+tTwY5U4L+0GgCGPm+rfEWW
         UVWbUA717pJPVXbkyNtINOt5B5q9PHbsBPtacCi5OGXSTxKFbnHLc/+8aXyKZE+oYAyN
         frDrjXYwTPPUKXgJRsh5cvhevDviiHwgE++kUztqG2OGflgclWPVzHX2YI2ZI95SLBz9
         1l6w==
X-Forwarded-Encrypted: i=1; AJvYcCUMgL0SHS/LOF9kL9QSJLEqKjFClQcKh1WGlABw6vsQpMiBp+f7v1mFk3WuUDwOtettQxSVgyb/Jn/mDTE=@vger.kernel.org, AJvYcCXITt18JOaaoSY20hfFZ8Y73TYZEcCmIV9sL4Vc4oW2Hd9iFJt43T2HRJQleoM1HU5MHLfmhecH8os=@vger.kernel.org, AJvYcCXpHsqWlR9czOaz3TS7C3YRs4/t88tKNyB7f9xU5BYHhvSfR1NiK9GReqAFaQ9vemR1LBQr3EqJdHR+teOYtylauA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxK92jK4Skn4Cn5wpldcdgliONu4pWWPMpkNB7LxtdRyjwrHxeW
	NBYba2pSgXLRAoVEePEp/n/QStHJxrdg4T1hDeR47zYSEcu+r5W6
X-Gm-Gg: ASbGncuTzu2WwP6dcBHeQURkDR+gPvbRlUS/73Euim7+jMrV2XOt+9ynkBDabVYnUpf
	HPpzS3aYhekifo6n5/8Qcl9dEoFv0qFsTWnStaTW4J4dhO5gfuxZyECJ1WXR+eyRIAcqF3t6Eru
	s1Wh9HxNUsjgGrwZCXCcO1yZVrxkMf2zLYelZQJoTLZ+q3NgcOBtLEl7UHdZ6X9Orl6AGDHaFMP
	jkaNSZgPSFRV4wtWBgosnnqkbIjfc4pkphvBou2BQ2JabwkHoYo7pnmVOQ/e2qgns227KwZ+qIw
	ZHBQKLzkTgAOxvT8UNIJ9DVDvo1hMwk2aqbi6BTFKY5eOj0v21PtD4jqTpAT6tA=
X-Google-Smtp-Source: AGHT+IHzxBFSeMM74yjOto3P7ALY8hiN3bLZVvyyH/Nc6q5335Rn3C/QA8sNLRqmd/RLKdgG+WebEA==
X-Received: by 2002:a05:6820:1391:b0:607:cc1a:572f with SMTP id 006d021491bc7-6080030f9b9mr4884601eaf.6.1746460193770;
        Mon, 05 May 2025 08:49:53 -0700 (PDT)
Received: from hiagof-nb.corp.toradex.com ([67.159.246.222])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-607e7fe84a8sm1606217eaf.36.2025.05.05.08.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 08:49:52 -0700 (PDT)
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
Subject: [PATCH 1/3] remoteproc: imx_rproc: skip clock enable when M-core is managed by the SCU
Date: Mon,  5 May 2025 12:48:47 -0300
Message-Id: <20250505154849.64889-2-hiagofranco@gmail.com>
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

For the i.MX8X and i.MX8 family SoCs, when the M-core is powered up
before Linux starts (e.g., by the bootloader) and it is being managed by
the SCU, the SCFW will not allow the kernel to enable the clock again.
This currently causes an SCU fault reset when the M-core is up and
running and the kernel boots, resetting the system.

Therefore, add a check in the clock enable function to not execute it if
the M-core is being managed by the SCU.

This change affects only the i.MX8X and i.MX8 family SoCs, as this is
under the IMX_RPROC_SCU_API method.

Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>
Suggested-by: Peng Fan <peng.fan@oss.nxp.com>
---
 drivers/remoteproc/imx_rproc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index 74299af1d7f1..627e57a88db2 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -1029,8 +1029,8 @@ static int imx_rproc_clk_enable(struct imx_rproc *priv)
 	struct device *dev = priv->dev;
 	int ret;
 
-	/* Remote core is not under control of Linux */
-	if (dcfg->method == IMX_RPROC_NONE)
+	/* Remote core is not under control of Linux or it is managed by SCU API */
+	if (dcfg->method == IMX_RPROC_NONE || dcfg->method == IMX_RPROC_SCU_API)
 		return 0;
 
 	priv->clk = devm_clk_get(dev, NULL);
-- 
2.39.5


