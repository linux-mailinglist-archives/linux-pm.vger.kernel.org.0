Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE8782A1E76
	for <lists+linux-pm@lfdr.de>; Sun,  1 Nov 2020 15:09:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgKAOJW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 1 Nov 2020 09:09:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51830 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726370AbgKAOJV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 1 Nov 2020 09:09:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604239760;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=FtJu5viXRiWAragdM4sGytq5nhMsF7DPJXYjp/+7e9I=;
        b=eCFAAyGNncNYkZ/INMZP88HApPyCPVqcyUQhN6M+U5Xz5QC82nQuN4hC9unsdaI0bLoH7f
        jK8kv+aFNsP8tHar/wvcp3nx6CfMtgPOH5wvdcxjEc9P6PeNsKSo3ktqHMOrlMI1e8Efv7
        xOcb6aQSR4KqqMl4k6EEIJPbNdDuqb0=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-595-SMuZbPGBOdiBu1Nhx4iovQ-1; Sun, 01 Nov 2020 09:09:16 -0500
X-MC-Unique: SMuZbPGBOdiBu1Nhx4iovQ-1
Received: by mail-ot1-f71.google.com with SMTP id n13so246271otk.22
        for <linux-pm@vger.kernel.org>; Sun, 01 Nov 2020 06:09:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FtJu5viXRiWAragdM4sGytq5nhMsF7DPJXYjp/+7e9I=;
        b=F1bp4RGQH/0r0uP84xJgzLY4C/iyxhMniBu9zrkBF+YMI7dkKiAoEXLcSRN1gEy6z9
         1kXHYsywICzcT6xjVM9jLare/D1B4RvfXclB+KMmPzK0vFrhFsL9Rw8IGMrbOyW9PAb6
         q1ORCCcKUXlcSekuzicZZ8mWF2IUxNLBSgZI1hVqx9mbUghJEXqJ8NEExxP63gJAuV7i
         41qyf/To9yWVo5cZOUiN5zyTfcPYt+WOTskxgkl5sLeYglVNa4mCnYM6KK5YaGj7Z1Mg
         HF5I5IsEIIskFAa0AJqvSYMjtbpWmZNxMsCuUfr5Mp9QnOGIJe1hCm9AGvWrlpiitmyX
         8R8w==
X-Gm-Message-State: AOAM530TpyoTbx1OTE0Q1UmOpSkOHvCcHIKyO6Gg5fPNzWixu6XIUCdT
        N7f31qRDQ2zZtsOlD6uS1Tshi+TAgkwgp5H/BblNc9wiNMJTxSPxUBw1OM3u6+KoExLsRY8Tu9T
        VXbmlreZelci1HB8GZcs=
X-Received: by 2002:a9d:6a0a:: with SMTP id g10mr9007327otn.44.1604239756201;
        Sun, 01 Nov 2020 06:09:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzhb4taNtmoBfA8FLCEMNs2fuRmmlHn8iafqln5wwbv/JVDLJMZYFI8QIOBsIwa6Ob4RtMItA==
X-Received: by 2002:a9d:6a0a:: with SMTP id g10mr9007317otn.44.1604239756051;
        Sun, 01 Nov 2020 06:09:16 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id c128sm2778508oob.23.2020.11.01.06.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2020 06:09:15 -0800 (PST)
From:   trix@redhat.com
To:     paul@crapouillou.net, sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] power: supply: ingenic: remove unneeded semicolon
Date:   Sun,  1 Nov 2020 06:09:10 -0800
Message-Id: <20201101140910.2280370-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A semicolon is not needed after a switch statement.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/power/supply/ingenic-battery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/ingenic-battery.c b/drivers/power/supply/ingenic-battery.c
index 32dc77fd9a95..8b18219ebe90 100644
--- a/drivers/power/supply/ingenic-battery.c
+++ b/drivers/power/supply/ingenic-battery.c
@@ -52,7 +52,7 @@ static int ingenic_battery_get_property(struct power_supply *psy,
 		return 0;
 	default:
 		return -EINVAL;
-	};
+	}
 }
 
 /* Set the most appropriate IIO channel voltage reference scale
-- 
2.18.1

