Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7564744759D
	for <lists+linux-pm@lfdr.de>; Sun,  7 Nov 2021 21:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbhKGUXE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 7 Nov 2021 15:23:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234821AbhKGUXD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 7 Nov 2021 15:23:03 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17FC0C061570;
        Sun,  7 Nov 2021 12:20:20 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id v15so18342605ljc.0;
        Sun, 07 Nov 2021 12:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Miq+mhOzOpalgOG5eb9uZUTGfxnJu+vdifXqmJ+tEI4=;
        b=kUG9ysK4aCvjFYqVrRaOYahd/9OjvYFqsRRCN2GgUNrwJFgApg9+3tEyLRLo1LxuQM
         Eb+b9+wBGrTMclRrtZTsuKll6wZU/5n1FwusyBrzhW2SEAbnyX5+exucLHJuem5hzKQm
         SW1RYGWDVsEdfqYM7LTW0wSfLS1RD4nDb5jycFjCWqYfdn2v0txTwfHy/sQpILuFxNEY
         61dxHZlil1PzzCcBgx2+L6elUClewLETlzt0v8+Hth6HPN6bcAIhqB5LCEjqQWSY0kKc
         k6NP7ZUL8VcScX0lV4miAh9r6adbqbfg9/DKQUPnIjypeUpEaZ5r70a51B5GG1JgAwyh
         Lpgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Miq+mhOzOpalgOG5eb9uZUTGfxnJu+vdifXqmJ+tEI4=;
        b=PPq1qXgkO3Z7Bb5pSg9/tXf2Wkd6uwZ2tTWv8dafJzYhkSECQPUm250REpExpz5qfV
         mmS1dsppG3GlpRpKxF1c3vJL+04z3qL9oNiIIb871nJ0mMKesoXLzDaqbyIsz4uJ7xcG
         0C9z0ruxFGtsq/am3tHqGrODRCg9O6Ma09l2QGp3ZrtiNFziHOtxNF1U+lCvcqqIw25H
         I8hvAXsX139IN9e72Fhqr5WbL12gz2H1HRMNdaosL/Vwer6IDoTxeKMuBYA5alf5QoUT
         MOID942sCYXCc8+6JWM703t/qi2A5LDA7lYd384GojjwHZa3YzsQJfw74E9gAx15FUMB
         bDpQ==
X-Gm-Message-State: AOAM533Ie1IZXROIV7qA1MTXqYD8Pag0uJnsjB6cVmaVSzi6XNr9zf6u
        RsTMj0hhW2w9DmLr39g0Mcw=
X-Google-Smtp-Source: ABdhPJw2icRKGfQLcxUSBGBPxkcopQdnVW419IZ03fOcfovwsn53de/7YF9+w84RunaT332ZcdWpmg==
X-Received: by 2002:a2e:890d:: with SMTP id d13mr138339lji.396.1636316418386;
        Sun, 07 Nov 2021 12:20:18 -0800 (PST)
Received: from localhost.localdomain ([37.45.143.17])
        by smtp.gmail.com with ESMTPSA id i11sm1563673lfe.128.2021.11.07.12.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Nov 2021 12:20:18 -0800 (PST)
Received: from jek by localhost.localdomain with local (Exim 4.95)
        (envelope-from <jekhor@gmail.com>)
        id 1mjoeH-000ECq-F6;
        Sun, 07 Nov 2021 23:20:17 +0300
From:   Yauhen Kharuzhy <jekhor@gmail.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Yauhen Kharuzhy <jekhor@gmail.com>
Subject: [PATCH 2/4] bq25890: Add max input current limit property
Date:   Sun,  7 Nov 2021 23:19:59 +0300
Message-Id: <20211107202001.54579-2-jekhor@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211107202001.54579-1-jekhor@gmail.com>
References: <20211107202001.54579-1-jekhor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add property 'ti,input-max-current' to define input current limit if
needed. It will be applied if automatic charger type detection is
disabled and using of ILIM pin is disabled or such pin defines greater
limit than IINLIM field.

Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>
---
 drivers/power/supply/bq25890_charger.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index 34467bfb9537..1c43555d5bd8 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -85,6 +85,7 @@ struct bq25890_init_data {
 	u8 treg;	/* thermal regulation threshold */
 	u8 rbatcomp;	/* IBAT sense resistor value    */
 	u8 vclamp;	/* IBAT compensation voltage limit */
+	u8 iinlim_max;	/* maximum input current limit allowed */
 };
 
 struct bq25890_state {
@@ -657,6 +658,7 @@ static int bq25890_hw_init(struct bq25890_device *bq)
 		{F_TREG,	 bq->init_data.treg},
 		{F_BATCMP,	 bq->init_data.rbatcomp},
 		{F_VCLAMP,	 bq->init_data.vclamp},
+		{F_IINLIM,	 bq->init_data.iinlim_max},
 	};
 
 	ret = bq25890_chip_reset(bq);
@@ -870,11 +872,13 @@ static int bq25890_fw_read_u32_props(struct bq25890_device *bq)
 		{"ti,thermal-regulation-threshold", true, TBL_TREG, &init->treg},
 		{"ti,ibatcomp-micro-ohms", true, TBL_RBATCOMP, &init->rbatcomp},
 		{"ti,ibatcomp-clamp-microvolt", true, TBL_VBATCOMP, &init->vclamp},
+		{"ti,input-max-current", true, TBL_IINLIM, &init->iinlim_max},
 	};
 
 	/* initialize data for optional properties */
 	init->treg = 3; /* 120 degrees Celsius */
 	init->rbatcomp = init->vclamp = 0; /* IBAT compensation disabled */
+	init->iinlim_max = 0x3f;
 
 	for (i = 0; i < ARRAY_SIZE(props); i++) {
 		ret = device_property_read_u32(bq->dev, props[i].name,
-- 
2.33.1

