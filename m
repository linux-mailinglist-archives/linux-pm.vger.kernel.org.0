Return-Path: <linux-pm+bounces-39277-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 26580CAB94B
	for <lists+linux-pm@lfdr.de>; Sun, 07 Dec 2025 20:02:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6FAD33016CD8
	for <lists+linux-pm@lfdr.de>; Sun,  7 Dec 2025 19:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23B2202963;
	Sun,  7 Dec 2025 19:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TNVc0t5h"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA8414EC73
	for <linux-pm@vger.kernel.org>; Sun,  7 Dec 2025 19:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765134146; cv=none; b=YIM4dVOkJ6zmRxbQ4EGIc7PL1lpX6HcH8fcakjDSz4QZebvtMY++ZRwJm/aHvixEHnPlXPneH87LbEyEAaJVCLBdxXDTr8ZRNU86zv+W/EzppyANpITWxLkfKz2RLnP4v8F0B1cghVZdASF0MW7JtoIYE3ZM1fyNm5SqA26sXAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765134146; c=relaxed/simple;
	bh=lMT2knLw9NGhbbZA5OxXLR5tc4Ea/OwoHRiasKhKQDI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BUfTx8v3Jv0wIgkq0DPEt+D8HlQWM6CsXxoWetLGfDUHPbvnzhf6zaVta0dWx4PcXha8JtcqSGTETk2RyvsmLvOGOivhYGi4IpCHfbP7w9Zu2r8ujK4BjwLuFOU4xe2YsyM3OdZsuYD+6fJHkuSXs+OSrwwIews7pD8DcC/veu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TNVc0t5h; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-29ba9249e9dso52652435ad.3
        for <linux-pm@vger.kernel.org>; Sun, 07 Dec 2025 11:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765134145; x=1765738945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CI7p9gBqBiOF+yyqZEH+5Bci1w311hgD/wpMcij+JiI=;
        b=TNVc0t5hJyrF8u2Gbv2MDIRyIj1a07OFLT2/a/LJvvLXfgzTpOYrTpHK3oDg9YCZLe
         W0DyN546Thq9hebpHLwYHhiP7ZlmcM0TmZzbJSZsGBqvajPe3UEr+hyyBIrkX7DTP1S8
         dDO27A2HlG1Z9fLGJI0vsAnbr4JivAAGtUkRSGxofyyuDnfV4E03PRqLQDhi00PF87mm
         LlEr08utgc9fZYjGE3NmSoCj4r64G6jMX81A3lzQRIaDTfUsX+XOK53tYCV8AQoMyeeO
         aW5NLUt7VHR9+U4UhXIy8J1eLdLi+jqnJ2HlSwNfchEkcDjmeh2iPWQys9DIry2JR7ft
         /USQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765134145; x=1765738945;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CI7p9gBqBiOF+yyqZEH+5Bci1w311hgD/wpMcij+JiI=;
        b=YO+wrVPG/0DXQkjna0yLRY6sKMbsF3mL/C3GRz/4/59fMV1y4wjkYRDbjYqdhfz+Dn
         Esil4yfyT11SxPDPwJejllsWMGtX7ZokBppKZUi1PhMNB0u2e2dnkvpNZMDRojEOZ6bs
         sTxlEbbn3AN90j4mbrOkbXsaVXKzvqyeLp/dcpwSKBcp9Km0CBWBQ3FO16aLsAPUFZVw
         m5yWY4MVXlJiRMQ5U/nnZm4BXt14qcwfAKvlNJA9iW99XE2rQvjF+UEvrR6A6G9shGpr
         GNFly21lEH39ggwSiJMnIFK4lncUxLWSpFQDTCilyArmQdOrEpiXZekoPJSazQvffQnE
         So4A==
X-Forwarded-Encrypted: i=1; AJvYcCWFZW1DsFlV43I8yxFPYlBx1okNYR2e7uhSMqjrld7tYShJflj2UIeqb81IwLDiCehxxRjWz2dCag==@vger.kernel.org
X-Gm-Message-State: AOJu0YySpkfZaTEmZe9v+xDefoyu5nyirbfSQHBlXPOJiuTioSP5sYWc
	Z8zofzIAwbCotP7lVYYQdS3zOS0KzlSlyAXTjGJfwHWKbbTc5TMzWAG5
X-Gm-Gg: ASbGnctHHfo5uZJpzIF2oz6cUQQvrL7JInTofBQLkkmtqo2cSOO5RfEvqJucJd3OA6w
	rWHfkrPJHSQyyaKeHWi4C2FxZVzeWqkZh/5seFjP3TN0vlaFmiN7BHJUYHkQSPZ8QRzOrALHseQ
	Ui96rbEju5bm5iie+dWGixxjTgT1PbHA4qvaHuXhJmjbjnDIMDAo3w/ZsMnSoVjg/04MRZtBz+F
	P9khfxYsWRoNDhOt1blFZT231wWboidZGLoOnwRqSlVtYDsbWACggqkZpeLLsPUdm8aOaBctWRG
	UKX3GyY++FEOPlnZP9MJxUlDEl4+UUMhY+GWh3tNPaTMw8MM6gWa+1Sv/b82XnROYayrH4oa29o
	65zZ72Sd2v384XFAPNRiG+Sku8Dx/VA8/XpTBxccvEaEC81le4WfYJAOcyWyGtjqfXezhETIPYv
	sbl1CGc47seOB3VW8=
X-Google-Smtp-Source: AGHT+IEDhVQaUpOSWRwGaxKvQe7pJ6rQhPxNknTpuZ3iKLBDGZGnh89cvumtUerdaS+dn+fzRi1Xfw==
X-Received: by 2002:a17:902:ccd0:b0:290:94ed:184c with SMTP id d9443c01a7336-29df56841c7mr45223755ad.15.1765134144675;
        Sun, 07 Dec 2025 11:02:24 -0800 (PST)
Received: from gmail.com ([2402:e280:3e9b:22f:9a46:840e:e346:f56a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29dae4cfaecsm101519405ad.27.2025.12.07.11.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Dec 2025 11:02:24 -0800 (PST)
From: Sumeet Pawnikar <sumeet4linux@gmail.com>
To: rafael@kernel.org,
	linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	sumeet4linux@gmail.com
Subject: [PATCH] powercap: fix memory leak in intel_rapl_common
Date: Mon,  8 Dec 2025 00:32:08 +0530
Message-ID: <20251207190210.471764-1-sumeet4linux@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The err_cleanup path in rapl_package_register_powercap() function
doesn't free rp->domains before returning when child domain
registration fails. Also, there is a missing the cleanup for the
parent package power zone which was successfully registered earlier.

When registration of child domains fails, now the previously
registered package domain (parent zone) is being unregistered.
This makes both parent and child powercap zones are properly
unregistered before returning the error.
Also, fix the rp->power_zone dangling pointer issue by setting it
to NULL.

Signed-off-by: Sumeet Pawnikar <sumeet4linux@gmail.com>
---
 drivers/powercap/intel_rapl_common.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index b9d87e56cbbc..5ea31433abf2 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -1406,6 +1406,13 @@ static int rapl_package_register_powercap(struct rapl_package *rp)
 					 &rd->power_zone);
 	}
 
+	/* Also unregister the package domain if it was registered */
+	if (rp->power_zone) {
+		powercap_unregister_zone(rp->priv->control_type,
+					 rp->power_zone);
+		rp->power_zone = NULL;
+	}
+
 	return ret;
 }
 
-- 
2.43.0


