Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBE6632B320
	for <lists+linux-pm@lfdr.de>; Wed,  3 Mar 2021 04:53:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352422AbhCCDp6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 2 Mar 2021 22:45:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379914AbhCBKL4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 2 Mar 2021 05:11:56 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F1C3C061788;
        Tue,  2 Mar 2021 02:10:40 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id 18so21821166lff.6;
        Tue, 02 Mar 2021 02:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yCsFHJ11jeCeG9OEz0Pdb1yteRXMTBLqS2b+YDxwST4=;
        b=o1Ysj7I+rI06anT9mhbxdL0d+M8/rvb03atQ1fIAjT5HTRD/A64NToXrlzf38JCm2D
         ZAcBfyQIT8YEIlsV0LPZ9KnBZlf0ZTCHXBl/yVaUSifUqzbPH17zTla1cjUQXq/hElUb
         rjwJuttdUqiP4Ng5Oe7EuS5ceIhxxYGNQVA+EXznCWq0bGl7dC5Kg4TO5b1BtnkmSjUg
         3OLhJ4+CY0BoCoaMm9hxW9A0129So5NI4EsEv14AqAg6U+c0wltNLn83e3sgvFdKnxhI
         qmIC72Paz5wPrbS+6PoTUhUfBl6dwclCkbyPTtInrIJj0nj0dVjmQtDG274OUf2u3+Cf
         c/ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yCsFHJ11jeCeG9OEz0Pdb1yteRXMTBLqS2b+YDxwST4=;
        b=B/oo+IHmsvWrboerEi+/Fjgc4U68zw2Uq+9s9jRTkvzV4CX9MNptDUBl/ROB1WvVh6
         xvj3BJp6j131t3656jvcf9z3dIDMVMB/Wo3t2dpucPIiKf/Uxb63KNGUVwb2yHoy3BW/
         3xQjLhkq9zykPM56/1MEimGNO1oTdodAwqAiinyWRD4/926QXobM2LSEbJSB1BCVuTRr
         dkTVLZtBsHFaAcjoujel3tQeW0MmgMAbOLAZ9+buv2f5l8MB4jZdaf4ACVGYPS115m+a
         soBrJYbLZrlRZcL1/L7xqgeB8+rhtAZikIKV/ZcUgTlWal0ilWc3ZnmIUrQVTgg3wpof
         YkMw==
X-Gm-Message-State: AOAM531gk5rNmMR542J5WLWGWd4NFwOSTKEvQEZ5b0vKDyQAT29B01K8
        aUjSNjzvkZ6DrpvLhJYszIU=
X-Google-Smtp-Source: ABdhPJzY6UGBGPfd6CI/QgJaSmEpo7dC9wb0UfkpuRgOS+l4TGm2M8h81N3tme2YjEaNlN3p4oB0IQ==
X-Received: by 2002:a19:ec1a:: with SMTP id b26mr11334102lfa.610.1614679839124;
        Tue, 02 Mar 2021 02:10:39 -0800 (PST)
Received: from localhost.localdomain (109-252-193-52.dynamic.spd-mgts.ru. [109.252.193.52])
        by smtp.gmail.com with ESMTPSA id c16sm2571001lfb.36.2021.03.02.02.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 02:10:38 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] power: supply: smb347-charger: Clean up whitespaces in the code
Date:   Tue,  2 Mar 2021 13:10:27 +0300
Message-Id: <20210302101027.4505-2-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210302101027.4505-1-digetx@gmail.com>
References: <20210302101027.4505-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Improve formatting of the code by removing unnecessary whitespaces.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/power/supply/smb347-charger.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/smb347-charger.c b/drivers/power/supply/smb347-charger.c
index ee13cd5d2b04..3376f42d46c3 100644
--- a/drivers/power/supply/smb347-charger.c
+++ b/drivers/power/supply/smb347-charger.c
@@ -1401,11 +1401,10 @@ static struct i2c_driver smb347_driver = {
 		.name = "smb347",
 		.of_match_table = smb3xx_of_match,
 	},
-	.probe        = smb347_probe,
-	.remove       = smb347_remove,
-	.id_table     = smb347_id,
+	.probe = smb347_probe,
+	.remove = smb347_remove,
+	.id_table = smb347_id,
 };
-
 module_i2c_driver(smb347_driver);
 
 MODULE_AUTHOR("Bruce E. Robertson <bruce.e.robertson@intel.com>");
-- 
2.29.2

