Return-Path: <linux-pm+bounces-36719-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0E6C00D80
	for <lists+linux-pm@lfdr.de>; Thu, 23 Oct 2025 13:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 15D3F358AD0
	for <lists+linux-pm@lfdr.de>; Thu, 23 Oct 2025 11:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85CB430E0FD;
	Thu, 23 Oct 2025 11:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pa4OzDTF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A666930DED7
	for <linux-pm@vger.kernel.org>; Thu, 23 Oct 2025 11:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761219886; cv=none; b=Fvuqx3LjO0uF0mCrJSXmqlQNpPkMB+8fpP2VaAqUxuKRYkHywAQQ74ts7Sh1mIWJERigzmXEJ4XarEZ+0fjkf56eZUrUDE9Ok026XlimAut97MRFX1XTTaLFIK9LFPH32mcyy4dHqSKElCJ1paRhfj6OT4jB89K5z2/OQAXzM2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761219886; c=relaxed/simple;
	bh=7BTUf4I7UAyyJBU95Aw8mfxBH3NdumaLSw1nC41XKIo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fFfdda3DEPZzdDJjOaD1ieQQI3kFYtLHNIoC2QWyr5r6l4EJmFZgqbMeFz/EQu9yMjtzNgR7DISKoTOasIcYhtUr7fe/5yHdUSXQv4R+ifnB54iH9pDmfDB2wdnu5Bpf9IAO4NVoKARa26Jgc5SgiB8+i/U0cMirEzR8cPipObw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pa4OzDTF; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-592f3d2d068so525161e87.3
        for <linux-pm@vger.kernel.org>; Thu, 23 Oct 2025 04:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761219882; x=1761824682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qszteeIIfZdimRIQpgCn+/pEks4QjoflEtrgND3FgTs=;
        b=pa4OzDTFCNpw/Til+jDpAWaEn9tPBf36NRSP6BWTMFH5JPYVvgdQf8RXuvojdpzKyD
         uaWIBArDA8XITIRbDWlcQoYid9eLrZN+kqEElsO/OlOT+Dw0b189q1H78o04oloDwJmH
         FcG8BaTnv12hRzQJj2CR4wQ6VqhjowhoCMn+kSrNv7WO59er7v97vC1T+g+MerR8eKi0
         bP/ol6mm4YvDd3E40aSwrRczTJMusYAJOFKzfxGFm9p24xnSvFmuy+wfO4NmguD9qFKD
         XeLwyz3TFIkfwc+rmB2fZJRFI6s/vGLzfaNiMlin+ZaqAK6FAi1cPqMBNCh7zDWb6V5a
         KwUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761219882; x=1761824682;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qszteeIIfZdimRIQpgCn+/pEks4QjoflEtrgND3FgTs=;
        b=AcQPaqfi+MQTmUpGIeVjXtEQuAmiBoa9uew/+P2M8djDBxXoItUKB9WGkFe8N8bC/V
         oH1xnENzjZsQRQUzGq0fuHSefBtmNk139zYmEafC9UIt7SoX/6Lcoy2FSZrSs/OQjWaU
         BmxOqyiYw6orS7Ag/4ZhYlMxTZILatVPrh2rd5z6rFruK9YjPdzMN0YEFuPR5YmxMrPj
         mEr270C/9ItBozONtXMsNooLMSl9cieSRVFrU3nRsf9OtLBbcW3DwhjOfoidMUUJH4GH
         0XMG+GeXtDm+l6vByyaLOehTEbKXJUB68Ao0QAEawmgxDiTfRv8GK+GlUWKgw4hM8PXP
         7zhA==
X-Forwarded-Encrypted: i=1; AJvYcCWlDFYBfHnAXQ96lU+k9k5rRCSHJ/l3VeFAaY8yDas29BO48sZXS1ddXl5X/IJDBwTqbN+xv2+wHw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3DFbHsi7NyyU1qWLbtu0V/h7hRkYq7kv64LVqNuCGxpKonKWL
	WGZa5GAcYYWUPYpiVuciBITbLBTStSYnEdRCU6XVTIiKeD6V0yffUDdQls7wKIT5pYE=
X-Gm-Gg: ASbGncvs8eXMHUjPERDVaTw5U3/76oYnFKdsSAfFX6jfCcxut2Kvo2WUmDHE1sE4fGS
	bLZRUIgFQjsb9LPKw5PJZaYxtJxBD3my4uXovUvw+XUtz+O1BhGiC/LeO6ENL6N/mV5U1U3RJj8
	N5EUO1bhyfq21nLE2VVfiqH1R3mSDmAo5DBgtz6D+4B+N12+244quB8HD/c6pQTtw1jgcqaOc9g
	/z0mcMM+JBdNLJAZqMcsd6sNV0qLMoTJAYWh3KWLaE3FQ8N/7AOa5/pqX8k5zMx13aNJ0V5fYU1
	Il/8rr3DoqPkgECazaJyUBrm2+qr5F6OlLSjnbH5GfNOHwUvCZAuP1DaUAnsHOEG7ghikEC0/FZ
	wTaRYyAhGTMfW+nLwTiGXMTxGETei/C/6Nn6jKEQVHX1OvMC6p0/d6wSSsNlM65ySWDEsHItEzH
	E3wQi/Fmui/5ipCquf5eQyB0DiRzzYrO+DgYXUCyJz9RX39aKmbKwrHpek6Crg
X-Google-Smtp-Source: AGHT+IFbZ8ea+fRAWMZHdLU+mWJ2Ags/jNDklnyMrW7cZ1hIy3jawsjZE8i2C+6eDVs0jg2Q6h0Kww==
X-Received: by 2002:a05:6512:3da8:b0:57e:f60:2327 with SMTP id 2adb3069b0e04-591d85665e1mr7456130e87.49.1761219881746;
        Thu, 23 Oct 2025 04:44:41 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-592f4d1f26bsm687596e87.77.2025.10.23.04.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 04:44:40 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-pm@vger.kernel.org
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] pmdomain: mediatek: Fix build-errors
Date: Thu, 23 Oct 2025 13:44:36 +0200
Message-ID: <20251023114436.185320-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let's add the missing header to fix the reported build-errors.

Fixes: df4e9ec1ed86 ("pmdomain: mediatek: Add support for secure HWCCF infra power on")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202510231317.ZZxNaFG0-lkp@intel.com/
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/pmdomain/mediatek/mtk-pm-domains.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pmdomain/mediatek/mtk-pm-domains.c b/drivers/pmdomain/mediatek/mtk-pm-domains.c
index ac144ab8fce0..164c6b519af3 100644
--- a/drivers/pmdomain/mediatek/mtk-pm-domains.c
+++ b/drivers/pmdomain/mediatek/mtk-pm-domains.c
@@ -2,6 +2,7 @@
 /*
  * Copyright (c) 2020 Collabora Ltd.
  */
+#include <linux/arm-smccc.h>
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/init.h>
-- 
2.43.0


