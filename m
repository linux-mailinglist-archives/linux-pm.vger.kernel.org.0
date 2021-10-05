Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90497421DBC
	for <lists+linux-pm@lfdr.de>; Tue,  5 Oct 2021 06:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbhJEE4q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Oct 2021 00:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbhJEE4p (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Oct 2021 00:56:45 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1973FC061745;
        Mon,  4 Oct 2021 21:54:56 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id v11so6057195pgb.8;
        Mon, 04 Oct 2021 21:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/9KVS503ubd0o0fKwUpqCErKIOfbGbeMs1zB/nt5caU=;
        b=A5krXoDt/X5DXz9f45jF//bjWC5nPtk+g0xzZ3sYmElgKnFoGdqNV7rX3ctIXQR6fg
         IfIUAsVHf1lrsy7jFAcJ4LHR2W4ImUREn94vpfN2ZpFf/xB0TNQhUHoDQitdalAgGf3u
         JM/rd5XvASAdminE7aZl2Unpi5n2L76OzmCGgc19JJ3+YsBbd0KTxXJUWtTYzU6d0soP
         6uVwiad8569ATbK0YIw4IQd8BSZWFE1ni34adZvklvSnjajmbyTFjq3ZsTulhZDGEmLE
         Dg1yEs9VkDY2M+mfbO2y2L8pkdeL7ZFEI0SNbmjZttOykXlZ83ugLTnaRy/LDmrcaSpf
         5qSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/9KVS503ubd0o0fKwUpqCErKIOfbGbeMs1zB/nt5caU=;
        b=3ihdmF3BtskNVOqlGAwDhcHruagQimtOE5ES4x1n6za+a6PyyEOWqt/toZMjz85rf2
         x1TIYTwNO0b8dcGnt5tuJAlwdgBIbctvQJzNFtwtTHhALy4hplLBHfet0TqazhcrZ3l0
         sdfUv2LDjv0c3PbWeBXjLg8zZL2GsjFc4jnoENcN/CxmIdFZliryuHoOFh8oAdhSB24o
         dBHIjW71NAcWc9TSUlDUURRH7c94gq1t++trdelBIxsT+YzlEYN6WHjtHa16HUupXl0+
         Krfe9Dkpfs5OMZUjpJsGJ26mPMSl07bBxZP6xkEdQ6l36fyvXVwU9OZdLHTARQhVDx9V
         7Slg==
X-Gm-Message-State: AOAM530xCC+Lcy29r/MU8PCd1IuuTDtw+/0kBQFaPVe1lhPk878i5y/h
        6zflW1it9MERF18kWYRxIt8g7XeSv7DdZQ==
X-Google-Smtp-Source: ABdhPJz8dDLGVGvzq1j53YZ5bhKCCiBSVC0+h4vCERy5/CAXXjlNYYraKcOYKfF5LlrGtCDAaSN2lg==
X-Received: by 2002:a63:205:: with SMTP id 5mr14249449pgc.433.1633409695309;
        Mon, 04 Oct 2021 21:54:55 -0700 (PDT)
Received: from unconquered.home.aehallh.com (24-113-252-168.wavecable.com. [24.113.252.168])
        by smtp.gmail.com with ESMTPSA id q18sm19554786pfj.46.2021.10.04.21.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 21:54:54 -0700 (PDT)
From:   "Zephaniah E. Loss-Cutler-Hull" <zephaniah@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "Zephaniah E. Loss-Cutler-Hull" <zephaniah@gmail.com>
Subject: [PATCH 1/2] tools/power turbostat: Allow -e for all names.
Date:   Mon,  4 Oct 2021 21:54:38 -0700
Message-Id: <20211005045439.1430114-1-zephaniah@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Currently, there are a number of variables which are displayed by
default, enabled with -e all, and listed by --list, but which you can
not give to --enable/-e.

So you can enable CPU0c1 (in the bic array), but you can't enable C1 or
C1% (not in the bic array, but exists in sysfs).

This runs counter to both the documentation and user expectations, and
it's just not very user friendly.

As such, the mechanism used by --hide has been duplicated, and is now
also used by --enable, so we can handle unknown names gracefully.

Note: One impact of this is that truly unknown fields given to --enable
will no longer generate errors, they will be silently ignored, as --hide
does.

Signed-off-by: Zephaniah E. Loss-Cutler-Hull <zephaniah@gmail.com>
---
 tools/power/x86/turbostat/turbostat.c | 49 +++++++++++++++++++--------
 1 file changed, 35 insertions(+), 14 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 47d3ba895d6d..f5d634ee5fee 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -686,7 +686,9 @@ unsigned long long bic_present = BIC_USEC | BIC_TOD | BIC_sysfs | BIC_APIC | BIC
 #define BIC_IS_ENABLED(COUNTER_BIT) (bic_enabled & COUNTER_BIT)
 
 #define MAX_DEFERRED 16
+char *deferred_add_names[MAX_DEFERRED];
 char *deferred_skip_names[MAX_DEFERRED];
+int deferred_add_index;
 int deferred_skip_index;
 
 /*
@@ -775,17 +777,23 @@ unsigned long long bic_lookup(char *name_list, enum show_hide_mode mode)
 		}
 		if (i == MAX_BIC) {
 			if (mode == SHOW_LIST) {
-				fprintf(stderr, "Invalid counter name: %s\n", name_list);
-				exit(-1);
-			}
-			deferred_skip_names[deferred_skip_index++] = name_list;
-			if (debug)
-				fprintf(stderr, "deferred \"%s\"\n", name_list);
-			if (deferred_skip_index >= MAX_DEFERRED) {
-				fprintf(stderr, "More than max %d un-recognized --skip options '%s'\n",
-					MAX_DEFERRED, name_list);
-				help();
-				exit(1);
+				deferred_add_names[deferred_add_index++] = name_list;
+				if (deferred_add_index >= MAX_DEFERRED) {
+					fprintf(stderr, "More than max %d un-recognized --add options '%s'\n",
+							MAX_DEFERRED, name_list);
+					help();
+					exit(1);
+				}
+			} else {
+				deferred_skip_names[deferred_skip_index++] = name_list;
+				if (debug)
+					fprintf(stderr, "deferred \"%s\"\n", name_list);
+				if (deferred_skip_index >= MAX_DEFERRED) {
+					fprintf(stderr, "More than max %d un-recognized --skip options '%s'\n",
+							MAX_DEFERRED, name_list);
+					help();
+					exit(1);
+				}
 			}
 		}
 
@@ -6138,6 +6146,16 @@ void parse_add_command(char *add_command)
 	}
 }
 
+int is_deferred_add(char *name)
+{
+	int i;
+
+	for (i = 0; i < deferred_add_index; ++i)
+		if (!strcmp(name, deferred_add_names[i]))
+			return 1;
+	return 0;
+}
+
 int is_deferred_skip(char *name)
 {
 	int i;
@@ -6156,9 +6174,6 @@ void probe_sysfs(void)
 	int state;
 	char *sp;
 
-	if (!DO_BIC(BIC_sysfs))
-		return;
-
 	for (state = 10; state >= 0; --state) {
 
 		sprintf(path, "/sys/devices/system/cpu/cpu%d/cpuidle/state%d/name", base_cpu, state);
@@ -6181,6 +6196,9 @@ void probe_sysfs(void)
 
 		sprintf(path, "cpuidle/state%d/time", state);
 
+		if (!DO_BIC(BIC_sysfs) && !is_deferred_add(name_buf))
+			continue;
+
 		if (is_deferred_skip(name_buf))
 			continue;
 
@@ -6206,6 +6224,9 @@ void probe_sysfs(void)
 
 		sprintf(path, "cpuidle/state%d/usage", state);
 
+		if (!DO_BIC(BIC_sysfs) && !is_deferred_add(name_buf))
+			continue;
+
 		if (is_deferred_skip(name_buf))
 			continue;
 
-- 
2.33.0

