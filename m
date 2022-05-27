Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 924775357A8
	for <lists+linux-pm@lfdr.de>; Fri, 27 May 2022 04:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbiE0CfO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 May 2022 22:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235956AbiE0CfN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 May 2022 22:35:13 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEDE1E7300;
        Thu, 26 May 2022 19:35:12 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id t26so3880250edt.0;
        Thu, 26 May 2022 19:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=33mv8EaBI1zM629Xj/kVmXIYGAzhKnFwO0nYllphfAQ=;
        b=MkT2UaMH5+BElHtJP2OUJi9BQMBKUe78q5K3VMuLTWFcANblXvQ7DvvH3raL3LRDNQ
         +f+1916RJABa/TdhOPm6x5FaqklvDRamPIkftlf3LURnJavW2EF3MRw9fnvfz3saRcn6
         m1zU/GKUUJX2F5XVYOdtiAhBXbr9qDdZNVIB0rd6monHaSF6n6Ncp6cyTWwEa602R2eu
         ndg7JrVLTsI6cjqiOcZw6QT4athU8T66SffPR50q0+BAPvfNWtfxc6t9x3F0dqJAtKw3
         db/YbGS5yx+Trv+ZfsIt7Dv/srrDRm4QpQ3ukev5xJyol9L74yG59FoTy0V8sHuEsx/Q
         I/5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=33mv8EaBI1zM629Xj/kVmXIYGAzhKnFwO0nYllphfAQ=;
        b=D3Il7FVjIjhdMaV78qshl7nB/4XtwxrMIiTw6mCKvAaa6wDRdHM6do2BZ/aQfNJ/Zr
         3lnvIT+40dg0kZQmFVjhZcOQaBpc+iz1JluUIv3bpfPaY6xWkwJ3WfbhA95Q0WNP3U4q
         Bv9F4VvI43FtAm/BmAwUGZbQGCGb33DNf+AQ/+6SXPo5mEPjYI3njEys+0D+3dTuF7H+
         CQrmF/jsDzIoCPtXmwdsT2+/Ku6oAiExWaJGe+tRsqErnKajAv/Mmi3ogARR26T+Nfq7
         6i7HpHdWrkza6saciu2vXeLE889DgBsk8wNBrXPHfoXN8u2WxZFH55zFsbSk8hHos2UZ
         Faqg==
X-Gm-Message-State: AOAM530f9gVuPaM4xzhAuCfFGAdIT4i6uNYApBlC//gPCn69pp14O9/9
        Sr4tom8Bo1wrUZnXqN2pMyQ=
X-Google-Smtp-Source: ABdhPJxu3oZtHaLBwLoCpKzElRIa+HUI8j6WkGhM0JTe2qUXc1o8vrlbbrKvvrqxG3syRBg+Z+14pw==
X-Received: by 2002:a05:6402:43c4:b0:41d:9403:8dca with SMTP id p4-20020a05640243c400b0041d94038dcamr3400494edc.184.1653618911513;
        Thu, 26 May 2022 19:35:11 -0700 (PDT)
Received: from xws.localdomain ([37.120.217.83])
        by smtp.gmail.com with ESMTPSA id qn12-20020a170907210c00b006fe89cafc42sm1025167ejb.172.2022.05.26.19.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 19:35:11 -0700 (PDT)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Sebastian Reichel <sre@kernel.org>
Cc:     Mark Gross <markgross@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        platform-driver-x86@vger.kernel.org, linux-input@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-doc@vger.kernel.org,
        Maximilian Luz <luzmaximilian@gmail.com>
Subject: [PATCH v2 08/12] platform/surface: aggregator: Add comment for KIP subsystem category
Date:   Fri, 27 May 2022 04:34:43 +0200
Message-Id: <20220527023447.2460025-9-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220527023447.2460025-1-luzmaximilian@gmail.com>
References: <20220527023447.2460025-1-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The KIP subsystem (full name unknown, abbreviation has been obtained
through reverse engineering) handles detachable peripherals such as the
keyboard cover on the Surface Pro X and Surface Pro 8.

It is currently not entirely clear what this subsystem entails, but at
the very least it provides event notifications for when the keyboard
cover on the Surface Pro X and Surface Pro 8 have been detached or
re-attached, as well as the state that the keyboard cover is currently
in (e.g. folded-back, folded laptop-like, closed, etc.).

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---

Changes in v2:
  - none

---
 include/linux/surface_aggregator/serial_hub.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/surface_aggregator/serial_hub.h b/include/linux/surface_aggregator/serial_hub.h
index c3de43edcffa..26b95ec12733 100644
--- a/include/linux/surface_aggregator/serial_hub.h
+++ b/include/linux/surface_aggregator/serial_hub.h
@@ -306,7 +306,7 @@ enum ssam_ssh_tc {
 	SSAM_SSH_TC_LPC = 0x0b,
 	SSAM_SSH_TC_TCL = 0x0c,
 	SSAM_SSH_TC_SFL = 0x0d,
-	SSAM_SSH_TC_KIP = 0x0e,
+	SSAM_SSH_TC_KIP = 0x0e,	/* Manages detachable peripherals (Pro X/8 keyboard cover) */
 	SSAM_SSH_TC_EXT = 0x0f,
 	SSAM_SSH_TC_BLD = 0x10,
 	SSAM_SSH_TC_BAS = 0x11,	/* Detachment system (Surface Book 2/3). */
-- 
2.36.1

