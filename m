Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB4EAEC8DB
	for <lists+linux-pm@lfdr.de>; Fri,  1 Nov 2019 20:07:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbfKATHX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 Nov 2019 15:07:23 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40320 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbfKATHX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Nov 2019 15:07:23 -0400
Received: by mail-qk1-f193.google.com with SMTP id y81so11670046qkb.7
        for <linux-pm@vger.kernel.org>; Fri, 01 Nov 2019 12:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YE7oISnKVk7mXz3OCRJJQp+KcsIdNkba4xrI7QohlOA=;
        b=ko9UsUUaKkDpPGy9+87wREy71m4qnhI+KWrvPjZiLorXMt5Va6LYv+XxS7WESN4RFJ
         L1Ef93N5AJPLRSZIJ+lH22m7t2vRpmGzSTx8kahC7U7pbfUqqFo47dpiIe/s7gtsbIeL
         JF3kuUeZGrBnkR5U9uApd5JuqBXUVZp0VsewtT0l3hPnBdhWnQeGv311cWpbXrYXFclL
         Qv7TRikvrs4oCogMDckZC/iZikUMloZXFLgHFsY1shrB5xGlpJnSWyK2Y3pc/GJCJUDY
         S5h7RSnL3VEHN0lRuNDcvDzheb+Erb6f4G/YSY8sqAUXV0Dn1FlyNWf9nkkeMWvfliVY
         0RLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YE7oISnKVk7mXz3OCRJJQp+KcsIdNkba4xrI7QohlOA=;
        b=rKAtuN2jJASaFZMBcEX/NiKNM+CQVi1pFboyACL1TuLa7AZZ7FYC0rkPVoBOeoQZDL
         LsL/kJMKyYYUDDiLFVGrpZ/zDXHtJcsytuOI8EQHv+IysAERwbnbUJxlNALsGx08OXrq
         qqnUbhHNSt/MeqdaqO21sVwRTrdxnv11CEaQmG1wHskZINseruo8cBJixX0C7K26M3zI
         UABTwBNB8hrdrNtd4cH2ozteHW6yO4Eo2KufhpiiXemW7TlbzFrlwVnGJsEydpKZlzfh
         lr+eOwFkGRKEpU9VUNNwtbSXPc/gg48mt+N7wkdmFOHQ4siNy1+xtiiKQ0Vl2RbEa1OO
         1Hhg==
X-Gm-Message-State: APjAAAXeYaYOh15WcJ5C9MM9kd2QIpGgMDtthRAc1O4QMQbJn6vRTxA3
        KniYN7MfsM5EFBlJlJDQdlo=
X-Google-Smtp-Source: APXvYqwXgwYkbT9Oiky1Or+CF4HptP4T9eNITYcSZXW2ijhOhoHcg7VQzFJivo77BWsEmDpVsgyoYw==
X-Received: by 2002:a05:620a:1244:: with SMTP id a4mr11840221qkl.208.1572635242092;
        Fri, 01 Nov 2019 12:07:22 -0700 (PDT)
Received: from jfddesk.Sonatest.net (ipagstaticip-d73c7528-4de5-0861-800b-03d8b15e3869.sdsl.bell.ca. [174.94.156.236])
        by smtp.gmail.com with ESMTPSA id d139sm5105905qkb.36.2019.11.01.12.07.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Nov 2019 12:07:21 -0700 (PDT)
From:   Jean-Francois Dagenais <jeff.dagenais@gmail.com>
To:     sre@kernel.org, linux-pm@vger.kernel.org
Cc:     Jean-Francois Dagenais <jeff.dagenais@gmail.com>
Subject: [PATCH 1/7] power: supply: sbs-battery: use octal permissions on module param
Date:   Fri,  1 Nov 2019 15:06:59 -0400
Message-Id: <20191101190705.13393-1-jeff.dagenais@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Symbolic permissions 'S_IRUSR | S_IRGRP | S_IROTH' are not
preferred. Use octal permissions '0444'.

Signed-off-by: Jean-Francois Dagenais <jeff.dagenais@gmail.com>
---
 drivers/power/supply/sbs-battery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
index 048d205d7074..0e66968dabc3 100644
--- a/drivers/power/supply/sbs-battery.c
+++ b/drivers/power/supply/sbs-battery.c
@@ -994,6 +994,6 @@ module_i2c_driver(sbs_battery_driver);
 MODULE_DESCRIPTION("SBS battery monitor driver");
 MODULE_LICENSE("GPL");
 
-module_param(force_load, bool, S_IRUSR | S_IRGRP | S_IROTH);
+module_param(force_load, bool, 0444);
 MODULE_PARM_DESC(force_load,
 		 "Attempt to load the driver even if no battery is connected");
-- 
2.23.0

