Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C19CC5357AF
	for <lists+linux-pm@lfdr.de>; Fri, 27 May 2022 04:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236048AbiE0CfR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 May 2022 22:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235956AbiE0CfQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 May 2022 22:35:16 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E48E7300;
        Thu, 26 May 2022 19:35:15 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id wh22so6239623ejb.7;
        Thu, 26 May 2022 19:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Zy1d2ezqRbCh9JcKRmIFanBdoA4iw+0RVQniOebSlbI=;
        b=o7c5rizxdlSg4zCoMXTO7h8ExlaKDY32yrM7tNAWTgJ8n5OtM6yqTlPlYRMlSskDbf
         Bg7waAvpkz0VrmXDf3jOebsIq+EsZBImsY1etPdSI4y2FgZLaSvWBdQ7J1MnupD+N55t
         cFGnil7SjK1zs1QAYGBOR2dhCtIb23hL4AQ8c1EUTocTURzOPdY1CvqQ5cqzph28hZsB
         3pSTjzUJCbj013bpz0FCinIOi8rsw/Xhjew25JlB/PLu4cAff7Lt7zjS+AXIznesJ0Zv
         J5iTZKs5TJSIymabVnBv59txjtudQawJyBfKwbG6joPHuQr9TVKIVWo6WZKV7crtSXkg
         IDgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zy1d2ezqRbCh9JcKRmIFanBdoA4iw+0RVQniOebSlbI=;
        b=jcgOjuC59wlSLHd8REugdjQmCAJBetdjDC9khRly5N5WBGKdVixBlHKnRDhvy5veE5
         Gdy2P0uB80vIauKkg1JltvtOCS2tvrEBDyPabWTJ0oHTrJbwbTgU2CvD+BNHjSy4c9bI
         7vfiIxJVqWw0m1wtFAbbfQCIGpCR98PzUQf3ddN6kykFban5V+YuGzQTtMJdje54IGnx
         1qtKI7xIA2gE98zBO7LY1PAf+88oiz2WQHgLYUy6+BypZWzFNEZWL31yiPBh6koaBbsg
         lPYLOuMbglCYWP+POgr+xleVicv4qYZZG78YIbFeUZhLrEdIzecDtE4wnOqQzkDsAQpY
         2fOQ==
X-Gm-Message-State: AOAM531VSgadBlvlN5t3LJ5FwmYGDXk97ZhNU0lMqQrK1tmePSnASPKa
        U8seorN42bZxNL/hI7JG1njiQFtG700=
X-Google-Smtp-Source: ABdhPJxQeopOufJYNWxbAWYUvVsnkPkH+HA9/7iD5tbD0MA4S0RMi2FxD8FYCld+Fkvf9eVMvquw8w==
X-Received: by 2002:a17:907:60d2:b0:6ff:1aa5:7ba1 with SMTP id hv18-20020a17090760d200b006ff1aa57ba1mr7804611ejc.239.1653618914211;
        Thu, 26 May 2022 19:35:14 -0700 (PDT)
Received: from xws.localdomain ([37.120.217.83])
        by smtp.gmail.com with ESMTPSA id qn12-20020a170907210c00b006fe89cafc42sm1025167ejb.172.2022.05.26.19.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 19:35:13 -0700 (PDT)
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
Subject: [PATCH v2 10/12] platform/surface: aggregator_registry: Change device ID for base hub
Date:   Fri, 27 May 2022 04:34:45 +0200
Message-Id: <20220527023447.2460025-11-luzmaximilian@gmail.com>
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

Use the target category of the (base) hub as instance id in the
(virtual) hub device UID. This makes association of the hub with the
respective subsystem easier.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---

Changes in v2:
  - Introduce this patch to improve hub device UID consistency.

---
 drivers/platform/surface/surface_aggregator_registry.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/surface/surface_aggregator_registry.c b/drivers/platform/surface/surface_aggregator_registry.c
index 09cbeee2428b..b11ce87c7184 100644
--- a/drivers/platform/surface/surface_aggregator_registry.c
+++ b/drivers/platform/surface/surface_aggregator_registry.c
@@ -43,7 +43,7 @@ static const struct software_node ssam_node_root = {
 
 /* Base device hub (devices attached to Surface Book 3 base). */
 static const struct software_node ssam_node_hub_base = {
-	.name = "ssam:00:00:02:00:00",
+	.name = "ssam:00:00:02:11:00",
 	.parent = &ssam_node_root,
 };
 
@@ -535,7 +535,7 @@ static int ssam_base_hub_probe(struct ssam_device *sdev)
 }
 
 static const struct ssam_device_id ssam_base_hub_match[] = {
-	{ SSAM_VDEV(HUB, 0x02, SSAM_ANY_IID, 0x00) },
+	{ SSAM_VDEV(HUB, 0x02, SSAM_SSH_TC_BAS, 0x00) },
 	{ },
 };
 
-- 
2.36.1

