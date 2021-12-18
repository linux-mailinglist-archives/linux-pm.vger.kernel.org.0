Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C02E479AE1
	for <lists+linux-pm@lfdr.de>; Sat, 18 Dec 2021 14:00:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233204AbhLRNAe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 18 Dec 2021 08:00:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233022AbhLRNAe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 18 Dec 2021 08:00:34 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F67BC06173E
        for <linux-pm@vger.kernel.org>; Sat, 18 Dec 2021 05:00:33 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id y196so3423435wmc.3
        for <linux-pm@vger.kernel.org>; Sat, 18 Dec 2021 05:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JCbNL7RiUna5qq8DaSMW/coH4epXCMjSWD6ZnOXRFI0=;
        b=u4gwbRii2rQYALroefHK1y6OAg/PaB5d8cxYkVOxNfQfP/GSpkOTw4lM0b9sykdRGn
         I5+TfxMLFW4Yz9DjXmmwADnnilA4jAI3OuH+2kj279neBPdyczuIvIKan+BZxt1abCOC
         PYvHZoojRGkGcKQVmwOZVt1XScnzpH93n3cT0kdV+KDJ4QLvkVW8g+u48CO+9sCgVbi+
         IM8GXnnDHqRZPDHHNChAWlGub8OWoFq1V1IwRCwrtEzywv2SqESfkq3jDHxS/vHMIzCq
         Y/6l37BlHAuffQ5iGLgabgk+gX6l3IXwpC+2N3WfHvO+x+p5njBf0nTvVHjxH/2oigQn
         0Nrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JCbNL7RiUna5qq8DaSMW/coH4epXCMjSWD6ZnOXRFI0=;
        b=o5oj5Uup8ukoCpMsrnyxyHauBKDBSpFc3cRFgmzwNgqj1t57UF61Njs9pOTRM6LUcE
         dfToLfreYwiy/SFtpgknMnF/dRBN1P2yRpXSMrS0v8Zx4uAOMS1f5pw5zZwSJjyStunX
         wpp77ndJ7D5TcI+v+d/BdEJXZFzNG/pb6l0rhc2V7A/7gy2EzR9bblwgKKZX5qPE53Yd
         yrYFRAlOQAZZOPw2jgulz2itpPZbjT0iIUcF5b4SUwncXMYhIAltz7hKAyKB7ZX6tD8u
         LHTilBF7gc/E8dELyDokK9KJSY+pJ9NhGaZJCkzNUzberqL9FXo4l8XV9+3gQQws5fYM
         +6cA==
X-Gm-Message-State: AOAM531rxMLFty8/wUe/FgPxD1JDj7O2xaDTnSN3n3iyD5N4BSGYkmPB
        JTBF8063Oag3XH4vmUcyUCrl5Q==
X-Google-Smtp-Source: ABdhPJxXBs2crqxznWfWrplA3JeMlkC5cBhIFjXjof2wb1mGSFgRnncc6sy5NXR1PO3YD3c6rLebKQ==
X-Received: by 2002:a05:600c:a4c:: with SMTP id c12mr6702096wmq.60.1639832431971;
        Sat, 18 Dec 2021 05:00:31 -0800 (PST)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:1f0f:c9b8:ee5c:5c2f])
        by smtp.gmail.com with ESMTPSA id j16sm1465785wms.12.2021.12.18.05.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Dec 2021 05:00:31 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rjw@rjwysocki.net
Cc:     lukasz.luba@arm.com, robh@kernel.org, heiko@sntech.de,
        arnd@linaro.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, ulf.hansson@linaro.org,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arch@vger.kernel.org (open list:GENERIC INCLUDE/ASM HEADER FILES)
Subject: [PATCH v5 1/6] powercap/drivers/dtpm: Move dtpm table from init to data section
Date:   Sat, 18 Dec 2021 14:00:09 +0100
Message-Id: <20211218130014.4037640-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211218130014.4037640-1-daniel.lezcano@linaro.org>
References: <20211218130014.4037640-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The dtpm table is used to let the different dtpm backends to register
their setup callbacks in a single place and preventing to export
multiple functions all around the kernel. That allows the dtpm code to
be self-encapsulated.

The dtpm hierarchy will be passed as a parameter by a platform
specific code and that will lead to the creation of the different dtpm
nodes.

The function creating the hierarchy could be called from a module at
init time or when it is loaded. However, at this moment the table is
already freed as it belongs to the init section and the creation will
lead to a invalid memory access.

Fix this by moving the table to the data section.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 include/asm-generic/vmlinux.lds.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 42f3866bca69..50d494d94d6c 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -362,7 +362,8 @@
 	BRANCH_PROFILE()						\
 	TRACE_PRINTKS()							\
 	BPF_RAW_TP()							\
-	TRACEPOINT_STR()
+	TRACEPOINT_STR()						\
+	DTPM_TABLE()
 
 /*
  * Data section helpers
@@ -723,7 +724,6 @@
 	ACPI_PROBE_TABLE(irqchip)					\
 	ACPI_PROBE_TABLE(timer)						\
 	THERMAL_TABLE(governor)						\
-	DTPM_TABLE()							\
 	EARLYCON_TABLE()						\
 	LSM_TABLE()							\
 	EARLY_LSM_TABLE()						\
-- 
2.25.1

