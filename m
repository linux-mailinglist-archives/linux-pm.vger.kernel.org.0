Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC5A19494A
	for <lists+linux-pm@lfdr.de>; Thu, 26 Mar 2020 21:36:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbgCZUgx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Mar 2020 16:36:53 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35188 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbgCZUgw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Mar 2020 16:36:52 -0400
Received: by mail-pf1-f196.google.com with SMTP id u68so3386199pfb.2;
        Thu, 26 Mar 2020 13:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t+UEiQ8yfqgCYbdamETpWg51SIJm0Evjj0FdT/Dr3I0=;
        b=bdO4KFhttrIM8xOkNnMb3OnmpOWJ5mHVX+21JOsGY0Oj0R9aU+gblAMAv8kB7eTCCC
         R3wUfUgx4jDPiL0tsu2L5j8g4TW8XyLtYqHrRg6k+V7vcrR7lgJ3uifzWFV6ySXCPYqL
         ZY8VxLeGHicm5J2YWmZHL9Xxd0EylAYRDLPmd8E3aDCYgAOyTwDedg/N44KDesBPOF+8
         oxKJZJuxvAuc24eF/Fqku0+UijjmLSZUjKnAEVhVGKgUFv/fCkyofgSrq+7vzbWxQbn0
         WZhHGPh+WWgGckBgnUebIcKS+qYnza92Bu5jGgIVy2GhD608M2+O9NoZckf1au4Wm2fY
         A46Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t+UEiQ8yfqgCYbdamETpWg51SIJm0Evjj0FdT/Dr3I0=;
        b=aO5EidQ9G2ANlesDktFymz+SiXn7bL/rfRzDtOWKdqx+oU1TTGee/6IVlJNMSGhOLz
         fxMzLeVFJwDbDMd9PftrqZ4He5bPdUvYVnRQAzQ40gnA52xvjQ2ZwUzvf0IX4fTwgapp
         JSTZR47hRvpaXmJKofky6BQX7tUZfoDsGbnl/yLmwTny6/Cg4hWLyu7vW2IbmcKw0MpJ
         0rRdaPAFzUQjgVptGpvqKgvA/EEPp1OtU/FjJOXMCY1oDjBH9Hbk/lWu4/uyKPQVEptE
         MNgeNm2wqAEM5l2Z5hoaMJAxB0WTUq83aZHL3ViwbdoJbeIYpYZ8i+V8MouSopDKKTy0
         ye7g==
X-Gm-Message-State: ANhLgQ2af+B9WgA53rjuGDvcbtu2puePCduJ52Zh7y1XR6ADm6ji81LV
        xxU5s879PIT++nKBR1XhGB3gU+ET
X-Google-Smtp-Source: ADFU+vvHmwCpydnpgZIzK6cQlPqAiKa3/mZDIHNnuNigmXRHJuXsHIje6L1r4syzRd5BhVwb4eZwJA==
X-Received: by 2002:a63:4e22:: with SMTP id c34mr10629783pgb.263.1585255010217;
        Thu, 26 Mar 2020 13:36:50 -0700 (PDT)
Received: from s15.smythies.com (mail.smythies.com. [173.180.45.4])
        by smtp.gmail.com with ESMTPSA id z16sm2373767pfr.138.2020.03.26.13.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 13:36:49 -0700 (PDT)
From:   Doug Smythies <doug.smythies@gmail.com>
X-Google-Original-From: Doug Smythies <dsmythies@telus.net>
To:     lenb@kernel.org
Cc:     dsmythies@telus.net, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH] tools/power/x86/turbostat: Always print idle in the system configuration header
Date:   Thu, 26 Mar 2020 13:36:37 -0700
Message-Id: <20200326203637.1892-1-dsmythies@telus.net>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

If the --quiet option is not used, turbostat prints a useful system
configuration header during startup. Inclusion of idle system configuration
information is a function of inclusion in the columns choosen to be displayed.

Always list the idle system configuration.

Signed-off-by: Doug Smythies <dsmythies@telus.net>
---
 tools/power/x86/turbostat/turbostat.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 33b370865d16..834b86676d00 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -3530,9 +3530,6 @@ dump_sysfs_cstate_config(void)
 	int state;
 	char *sp;
 
-	if (!DO_BIC(BIC_sysfs))
-		return;
-
 	if (access("/sys/devices/system/cpu/cpuidle", R_OK)) {
 		fprintf(outf, "cpuidle not loaded\n");
 		return;
-- 
2.25.1

