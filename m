Return-Path: <linux-pm+bounces-29802-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ACC6AECF23
	for <lists+linux-pm@lfdr.de>; Sun, 29 Jun 2025 19:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 506923B02DB
	for <lists+linux-pm@lfdr.de>; Sun, 29 Jun 2025 17:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09FBF23C502;
	Sun, 29 Jun 2025 17:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eMpXJnSy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D62E23AB8D;
	Sun, 29 Jun 2025 17:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751217932; cv=none; b=W9jr6X1o8k6wxNF96nqRdWoNwBENOVJrqs4rNutw6BfAV5ugc8sn5yfyS1xEhFNac3+pUoMZljzQz6RU0b9iuTLQ72yQ74hz5QG3zImGv0M/OnuIbxff/jIV6HieIVVJulkC+TJlW8QkyOTbZpKq62qyll8ivJCnLjGlrFed5iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751217932; c=relaxed/simple;
	bh=5rPmU/1SFz7cRlhPi0gScXLXvzdOq4gVjt4wXadKySc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Xv2268/Y9YulFtQCZIMLBfHEanvXlIKg7sxT3GbOotcQ0YsDMllzI9AKDPdKRh/T2uEAAjC5kj4pjHPKwlQnlTdCJqM4K4WxoXLWsi3S/M3dPXoKNlT3cEr32vMGCeQXm8KjjAbe1HjqgwXz1ZBCgyPkXdlol+CTIxG59ng2Ioo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eMpXJnSy; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4a774209cf0so16896071cf.0;
        Sun, 29 Jun 2025 10:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751217930; x=1751822730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+KVaoc+bz5kdiOIdV934yo3sW+d4Kfk0i0tXAE4l4cI=;
        b=eMpXJnSynFxXPrTAbQg2XEzoLKRGZbMdu5HoPPCafe0ayFYfKsS+UDCXtUUXVKgsZn
         OGCJSs6B8G4v+44frQ38RSNJiDT289YEDTPOkqx5wbRQMoB3u4QX0NOg35QZ0vui9sH8
         PlKrWYHYwbtHpu7kZ0slC1U8f5njh4qBCKQWg1gXCI4sZm7skcGGXw+ZBOyZcO6AmXEx
         H1NhVScSnVg5nBxQzR0eRPcBrhGXLGuSPs9IJigJfhA1abXYi5Y1/lQhqSOS6I2qnXR8
         YmzjpCWfm9sSbJ6KnQviLa9jmy+lYXaKNX/m9amvR6N/BdGRbEM6LrHHZxs817WXQQlH
         rDpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751217930; x=1751822730;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+KVaoc+bz5kdiOIdV934yo3sW+d4Kfk0i0tXAE4l4cI=;
        b=t/4kzwfNVs9F3hyzCbrZDzjSC5KBbvY7znKrkMS+H+lrRO3ufMEpgYHdVmwg659wQN
         hsgutDcbCSjktcW9uU26wxYIzZi6hbP2xltL+2jQ1jsOQy+pyMgEUpw3T80W/lIOtm16
         8KnWe1fFm28AgvWJNPjykCINPUJ0kdjJ1YNbXmK/xfnjkMOuXGyPuRPEoKBRWKTy/t8s
         yNdCePz3NlIjI40t6fLifAns3tSgNM0JxbQCX9asVI1WU4FZsqyiqhKhVxh+WAwGjb8w
         AIBo9mdYkgG/NjiC8g192VIDwPYyPp8t2QUiE/JSc+4K4vuzoqmPl7jiEjicgD5DzWDq
         Wmxg==
X-Forwarded-Encrypted: i=1; AJvYcCUwCUdFoI3iVAVc9lb8UNeaCajUCwxG1ICHS9DwKdCVGXNOT21R+uWG5uw0GBl3X8j93zGGhBsNGqm9Yhs=@vger.kernel.org, AJvYcCWcieqLat2VwYpYDIEgE0dmxRcAkIzd1hGusGAnFzaUvzp953xRJnK/QgurQtWJVe+jZUoleL9ZBaw=@vger.kernel.org, AJvYcCXudQR4+TZS5z7AlIwuXgzJANPZ/3hyIQHXtNrA8qEfsD4fDC4LBtmg+WaquJMGxV4vFqiefgA3rI83aDIfO4hMoA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5hMU7Fg+i/WqT2g0XuTcyp7lXDjcpytVxE6xDFstPdnEGKxDy
	6gDlUi6xRELnd3lxuOTgBWgqeodokmwhsKpftMR29BVR4A1cln2y9gmU
X-Gm-Gg: ASbGncumoqITJE4qYL3QOMpsmGBsiQ4/XsV3RXf62skzdb35KUhmJH08mlRH6g+wDy9
	hm8zrwMzgoQntfJEJcHt2NiesxzdtNQmo3tXCCIZ6ryWBWyFX3D2q8y1pCKArLp2MiWGCqt34w/
	0IeoP2t6Sk5SdV32R+Mg8u+iIcXJvmdPxab/sHxkgitlb78MAj9e1yyN9Hhc2gxOFbZ87/3cWH/
	VggVt1upQRt1bJCgg/VUsYnR9kOuBiDtzuUpcXQkVWTTUyQGaLPiD2YW58Qe68oafPb80TfPKF9
	ALxb9PW6zpNc9uBaYXWYNC3jgdTh8eHCDQ8hZlupmI0KCNIAKbe+nrBiXNOTkrH5bcxj92dyut0
	IaQU=
X-Google-Smtp-Source: AGHT+IFFmSN+6Z++Qnb0w4wGv3WuFmOt+5FDFNfdU9u77RVcSCRV0E1frKS5TTT/Syii07URDiN3bA==
X-Received: by 2002:a05:622a:5292:b0:4a4:3606:cbec with SMTP id d75a77b69052e-4a7fca98a3fmr150607401cf.8.1751217930043;
        Sun, 29 Jun 2025 10:25:30 -0700 (PDT)
Received: from localhost.localdomain ([2804:1b3:a7c3:c88d:6da3:af6d:a237:3289])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a7fc57d7dcsm45549761cf.60.2025.06.29.10.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jun 2025 10:25:29 -0700 (PDT)
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
	"Rafael J . Wysocki" <rafael@kernel.org>
Subject: [PATCH v7 0/3] remoteproc: imx_rproc: allow attaching to running core kicked by the bootloader
Date: Sun, 29 Jun 2025 14:25:09 -0300
Message-Id: <20250629172512.14857-1-hiagofranco@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hiago De Franco <hiago.franco@toradex.com>

This patch series depends on Ulf's patches that are currently under
review, "pmdomain: Add generic ->sync_state() support to genpd" [1].
Without them, this series is not going to work.

For the i.MX8X and i.MX8 family SoCs, currently when the remotecore is
started by the bootloader and the M core and A core are in the same
partition, the driver is not capable to detect the remote core and
report the correct state of it.

This patch series implement a new function, dev_pm_genpd_is_on(), which
returns the power status of a given power domain (M core power domains
IMX_SC_R_M4_0_PID0 and IMX_SC_R_M4_0_MU_1A in this case). If it is
already powered on, the driver will attach to it.

Finally, the imx_rproc_clk_enable() function was also changed to make it
return before dev_clk_get() is called, as it currently generates an SCU
fault reset if the remote core is already running and the kernel tries
to enable the clock again. These changes are a follow up from a v1 sent
to imx_rproc [2] and from a reported regression [3].

[1] https://lore.kernel.org/all/20250523134025.75130-1-ulf.hansson@linaro.org/
[2] https://lore.kernel.org/lkml/20250423155131.101473-1-hiagofranco@gmail.com/
[3] https://lore.kernel.org/lkml/20250404141713.ac2ntcsjsf7epdfa@hiago-nb/

v7:
- Added Peng reviewed-by.
v6:
- https://lore.kernel.org/all/20250626215911.5992-1-hiagofranco@gmail.com/
v5:
- https://lore.kernel.org/all/20250617193450.183889-1-hiagofranco@gmail.com/
v4:
- https://lore.kernel.org/lkml/20250602131906.25751-1-hiagofranco@gmail.com/
v3:
- https://lore.kernel.org/all/20250519171514.61974-1-hiagofranco@gmail.com/
v2:
- https://lore.kernel.org/lkml/20250507160056.11876-1-hiagofranco@gmail.com/
v1:
- https://lore.kernel.org/lkml/20250505154849.64889-1-hiagofranco@gmail.com/

Hiago De Franco (3):
  pmdomain: core: introduce dev_pm_genpd_is_on()
  remoteproc: imx_rproc: skip clock enable when M-core is managed by the
    SCU
  remoteproc: imx_rproc: detect and attach to pre-booted remote cores

 drivers/pmdomain/core.c        | 33 +++++++++++++++++++++++++++
 drivers/remoteproc/imx_rproc.c | 41 ++++++++++++++++++++++++++++------
 include/linux/pm_domain.h      |  6 +++++
 3 files changed, 73 insertions(+), 7 deletions(-)

-- 
2.39.5


