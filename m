Return-Path: <linux-pm+bounces-29622-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F48AEA926
	for <lists+linux-pm@lfdr.de>; Thu, 26 Jun 2025 23:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A1731C41221
	for <lists+linux-pm@lfdr.de>; Thu, 26 Jun 2025 21:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F0E2609C7;
	Thu, 26 Jun 2025 21:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EXLl+ccz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061D61DEFE9;
	Thu, 26 Jun 2025 21:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750975174; cv=none; b=odN0UimCXFXn1YjPa1Yw9/mnLkzt+r9nGnZhIfh5imOtbbWvZWT7u62efSqA2/9xtS9k5DG7LNF8H1O/vyPUJjKZmeq1gwFvfkTDRJD0XbAt+KUvqPDrqdPKQQkIrXkY+RbpheACIwOKJ7ej/PFNaLMSnBHpZgXrDvGjZqscuCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750975174; c=relaxed/simple;
	bh=slElE66aqfyyXEJlmGbMp+DNYQ2d7Dc7oDiwGqOqChE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=t/K/8ITpz6RJ+5+XcT0OcBSHKC0hirXwgmYoNyK8f2FRyXByXI/bvxRXLrQqI1LlM2f0FxaRn2v/nK2BzWmr/WC83BKuG9eIPF/B5Z1JTrxrNewXpYfkvpTt517osDFFTmB0+kI/jVY6vXlOMhG2LkqsSDhb0AeVNPxVP4G9/yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EXLl+ccz; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2360ff7ac1bso13183055ad.3;
        Thu, 26 Jun 2025 14:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750975172; x=1751579972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BIo+4tv6e0tJvJwfvRUmdX7OEB2USSJerM3U4tjrK2w=;
        b=EXLl+cczjFIDG+oTrph+8X+H2PcdMdHvzwELT9pTdLXY1IqCNvI8TX/s3WNnhLWFvu
         wfHBclfMokRMqw3gCbxnUFXgt28ae4rrnImUsuuyWy3L9HCeIbfHDCSewMA+B2ueI0Lx
         8Mlq5SMsepCvuj4WvROCyH8JJ+JygCHwChcxocIlri8AjdaNBGjOmdR0iEr7RN+IyVrb
         6S7fumNz+KJnLpqrJqNNjJR9gwveBfnPGDIoQmsdXgIgmLDJpChs8ePWlzB5VqndAB/r
         8nR2WcgN1za6KFxgi4Yqu1QHcq20rtB6Kdu+V19X0Pd8RhOUDVfok00lUMNAIy9KBlYI
         Cnvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750975172; x=1751579972;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BIo+4tv6e0tJvJwfvRUmdX7OEB2USSJerM3U4tjrK2w=;
        b=mqLUhFlD206UlNG/RqKQqOCp+CWTSJ+HUnc1l+SxP7BJhN6TNYCrBa5ebBFjzWf/Sf
         ExWMjza8sUI3OhP/NYkjoGb+c7cPqx0phBV2/yLfuOsg5Xr/mc9SIidhqhXYBnI2gPh3
         aXZq5VkM3h2/xHAzZNd79pwZHUFRTwbRclrh3cYDcIArov87RmsAlaicEXW42U84OwLD
         aimctib0A/nFdVcZLTCI+svUnx+Gwr7bskMRNwOWRiAsMCyrGqjh4jqfySPg+6kmJMhH
         XMeKih1yB1OGfjLIkm3xPw84CiVW2/2LSC4hX7nMTKX195A1SK5AFoVmkMtg/9lbXXeK
         VDtg==
X-Forwarded-Encrypted: i=1; AJvYcCUMyxBw4lW7y2+o3NDuaPxI0COwmKbSzahVigGST64ruP7vasQRiIylR61zosSEANo8ZkQ7pOQNNHyZ2tNITwQMrg==@vger.kernel.org, AJvYcCUXTtXm+2+DISpDPzPb1SQpIv6/CUewWMinJeBwpZsG48dW3Ltoh31eTOMK6Uxwm3kH4cjA1gYKXgU=@vger.kernel.org, AJvYcCWVqaOVsEPxSboEAF6GF/chQczMbqqgagP3CfDrU5Ev03wuJRcIsGAHNT4N9JY6S9/xRK3Ktzug/vJzAxo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+i9mcoWXOzMzB0jxIzzaq+xI6tZhuwco/I4rAJqWFV4jIU/KN
	cFVYovnj+kG4Xm8U2sSL7Cqg1GUWKtDEjcJZA5RLp7in9xvl+owmn+Pu
X-Gm-Gg: ASbGncvctERoZZwrpYoGkegH4kMzXBIxZe1KfpEZeudR0ckwF8voc5LpGTsbzQtUx5d
	hZKSJQlFrytnyGG9W9Ub4Jjc9NT9fiDiP8MLbxZDyaBSet2zaykFKLxCsbkP/TeaWtxmK88+5PC
	eww7q6CLHjJZpf8+rqJcktn6gMcaxRvcwypNre8zkJyuQHoZAXB7wGVYSSUJHm3CARr5Skflj1H
	POjeB34ANGW6Ke4o0VussqihUJA6a/SHHSSzO90PglLk04wo2QFjieqxzb/GsMjPCxdTFdBAvqh
	oz7T1yNJWOOzjLYzHi+tuAtHyeJmXIg667JFvzMnqClArQOdaQPYlUelW3J6761J3k0nk/9wZ+F
	YnLY=
X-Google-Smtp-Source: AGHT+IEWjshLgh07UmKjVXlymS2HdOEmftHmlKGMeQUGGSx7ixamCKXotE/1Lb9O5SdhP8Ay5EI28A==
X-Received: by 2002:a17:902:ce85:b0:234:1163:ff99 with SMTP id d9443c01a7336-23ac4609a61mr14225035ad.43.1750975172151;
        Thu, 26 Jun 2025 14:59:32 -0700 (PDT)
Received: from localhost.localdomain ([2804:1b3:a7c3:c88d:6da3:af6d:a237:3289])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb39b8b9sm585275ad.118.2025.06.26.14.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 14:59:31 -0700 (PDT)
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
Subject: [PATCH v6 0/3] remoteproc: imx_rproc: allow attaching to running core kicked by the bootloader 
Date: Thu, 26 Jun 2025 18:59:08 -0300
Message-Id: <20250626215911.5992-1-hiagofranco@gmail.com>
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

v6:
- Added "reviewed by" from Ulf and Bjorn.
- Fixed and improved commit descriptions of patches 2 and 3.
- Improved the comment inside imx_rproc.c file.
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


