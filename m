Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EFC52407C6
	for <lists+linux-pm@lfdr.de>; Mon, 10 Aug 2020 16:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbgHJOns (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 Aug 2020 10:43:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49246 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726111AbgHJOnr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Aug 2020 10:43:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597070625;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=JcBLOi3neeT1lIyBo7PfatBN0vwuswVUL6Gsq5h2/Cs=;
        b=fHLgm+QsGhtAlyR0MNHlEJzO0v75dV/bN7BPavIC7QusVylcvXXc5wCgIWk5XSI6HIo9gW
        wYG1iYr8aMPOkb/YEkoMvTge6B2g490irMtwiT7CtHWTR8NfakJ127xvSRVzfgMS647BVy
        G57dIvqBSJfr/v+iCphuJJ9JTW2+C5Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-ZtPwwEoJN0mE3uY2kLDSqg-1; Mon, 10 Aug 2020 10:43:41 -0400
X-MC-Unique: ZtPwwEoJN0mE3uY2kLDSqg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E04A659;
        Mon, 10 Aug 2020 14:43:40 +0000 (UTC)
Received: from dba62.ml3.eng.bos.redhat.com (dba62.ml3.eng.bos.redhat.com [10.19.176.128])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8063079CF3;
        Mon, 10 Aug 2020 14:43:40 +0000 (UTC)
From:   David Arcari <darcari@redhat.com>
To:     linux-pm@vger.kernel.org
Cc:     David Arcari <darcari@redhat.com>, Len Brown <lenb@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] tools/power turbostat: fix output formatting for ACPI CST enumeration
Date:   Mon, 10 Aug 2020 10:43:30 -0400
Message-Id: <20200810144330.75613-1-darcari@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

turbostat formatting is broken with ACPI CST for enumeration.  The
problem is that the CX_ACPI% is eight characters long which does not
work with tab formatting.  One simple solution is to remove the underbar
from the state name such that C1_ACPI will be displayed as C1ACPI.

Signed-off-by: David Arcari <darcari@redhat.com>
Cc: Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org
---
 tools/power/x86/turbostat/turbostat.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 33b370865d16..5f074879cc0a 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -3474,6 +3474,20 @@ int has_config_tdp(unsigned int family, unsigned int model)
 	}
 }
 
+static void
+remove_underbar(char *s)
+{
+	char *to = s;
+
+	while (*s) {
+		if (*s != '_')
+			*to++ = *s;
+		s++;
+	}
+
+	*to = 0;
+}
+
 static void
 dump_cstate_pstate_config_info(unsigned int family, unsigned int model)
 {
@@ -3559,6 +3573,8 @@ dump_sysfs_cstate_config(void)
 		*sp = '\0';
 		fclose(input);
 
+		remove_underbar(name_buf);
+
 		sprintf(path, "/sys/devices/system/cpu/cpu%d/cpuidle/state%d/desc",
 			base_cpu, state);
 		input = fopen(path, "r");
@@ -5597,6 +5613,8 @@ void probe_sysfs(void)
 		*sp = '%';
 		*(sp + 1) = '\0';
 
+		remove_underbar(name_buf);
+
 		fclose(input);
 
 		sprintf(path, "cpuidle/state%d/time", state);
@@ -5624,6 +5642,8 @@ void probe_sysfs(void)
 		*sp = '\0';
 		fclose(input);
 
+		remove_underbar(name_buf);
+
 		sprintf(path, "cpuidle/state%d/usage", state);
 
 		if (is_deferred_skip(name_buf))
-- 
2.27.0

