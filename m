Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F03E20DAFC
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jun 2020 22:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732708AbgF2UCc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Jun 2020 16:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387655AbgF2UC1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Jun 2020 16:02:27 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C4EC03E979
        for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2020 13:02:26 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id w17so8751432otl.4
        for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2020 13:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w8kvw01QtTGGnsYhL3inZ/4k+CD9olJ2CUCa3W61+0s=;
        b=h1L1Z7dCrx47MCg268EgH0SJuOWCGNJVYK3LrZsWGdpQSI8cXVvV77KMlhMRwkXl+5
         5h1ZObJbPaMgUG071GI4uGPvN/JpsOIq1j302pkxd768GBERzyTzZYqMyV0ncuu27CI3
         uSwpLhh/RwPv04MiUhVNRC07ZflqVrx0sZYNU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w8kvw01QtTGGnsYhL3inZ/4k+CD9olJ2CUCa3W61+0s=;
        b=UXs6MKuw+ub6WT5Hvqu1udPuE0DabdfroS6Mb+aOKy1pYiAA3VK42TyUnZkihnhfKu
         +ZFxqjcrjXmzz0D7Kd2Yq2SWyVst70Du8zETaq5EhEy6PYZ3ZWTLzHcD4ZXzr0pTfkeM
         lRTubpARzPHD1Liv1m5h6tZlLQIQkqfisD06LgGm2+LQQJCbxlLm+gwezumywnsegTB/
         S4yk7jfMG4/1dIP1CwnI62j9Ew7PiFhMZd3skOM8WHN7zu+te2E7t2y+LRrcd+kDnySQ
         Q/b22ROCE08nNOHNhAIfVAHPIsZqpGAkFUHp2DXBjsiWPVn7ij335ZiK4exzu/tZZ61V
         0ssA==
X-Gm-Message-State: AOAM5335PUWFY0mIFjsr6QDFgnG6yAJC7FuieFQHIMxKyHgbYtpQMOJk
        k265J2GqW6dlq+Fo5c45jvlXmQ==
X-Google-Smtp-Source: ABdhPJy2ZGQSMxPZ9QL1oqxm59wX+vcuGd8XulqX+fkUvR7Vkg2vUHQVJYME6VOTN++A2JPcd7OKJg==
X-Received: by 2002:a9d:4810:: with SMTP id c16mr2708947otf.197.1593460946248;
        Mon, 29 Jun 2020 13:02:26 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id p73sm213895oop.36.2020.06.29.13.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 13:02:25 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     trenn@suse.com, shuah@kernel.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] cpupower: Fix comparing pointer to 0 coccicheck warns
Date:   Mon, 29 Jun 2020 14:02:22 -0600
Message-Id: <20200629200223.27322-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fix cocciccheck wanrns found by:
make coccicheck MODE=report M=tools/power/cpupower/

tools/power/cpupower/utils/helpers/bitmask.c:29:12-13: WARNING comparing pointer to 0, suggest !E
tools/power/cpupower/utils/helpers/bitmask.c:29:12-13: WARNING comparing pointer to 0
tools/power/cpupower/utils/helpers/bitmask.c:43:12-13: WARNING comparing pointer to 0

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/power/cpupower/utils/helpers/bitmask.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/power/cpupower/utils/helpers/bitmask.c b/tools/power/cpupower/utils/helpers/bitmask.c
index 6c7932f5bd66..649d87cb8b0f 100644
--- a/tools/power/cpupower/utils/helpers/bitmask.c
+++ b/tools/power/cpupower/utils/helpers/bitmask.c
@@ -26,11 +26,11 @@ struct bitmask *bitmask_alloc(unsigned int n)
 	struct bitmask *bmp;
 
 	bmp = malloc(sizeof(*bmp));
-	if (bmp == 0)
+	if (!bmp)
 		return 0;
 	bmp->size = n;
 	bmp->maskp = calloc(longsperbits(n), sizeof(unsigned long));
-	if (bmp->maskp == 0) {
+	if (!bmp->maskp) {
 		free(bmp);
 		return 0;
 	}
@@ -40,7 +40,7 @@ struct bitmask *bitmask_alloc(unsigned int n)
 /* Free `struct bitmask` */
 void bitmask_free(struct bitmask *bmp)
 {
-	if (bmp == 0)
+	if (!bmp)
 		return;
 	free(bmp->maskp);
 	bmp->maskp = (unsigned long *)0xdeadcdef;  /* double free tripwire */
-- 
2.25.1

