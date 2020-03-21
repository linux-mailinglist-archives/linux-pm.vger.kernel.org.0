Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF3518DDE7
	for <lists+linux-pm@lfdr.de>; Sat, 21 Mar 2020 05:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725840AbgCUEy6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 21 Mar 2020 00:54:58 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40041 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbgCUEy6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 21 Mar 2020 00:54:58 -0400
Received: by mail-qt1-f196.google.com with SMTP id c9so61216qtw.7
        for <linux-pm@vger.kernel.org>; Fri, 20 Mar 2020 21:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:reply-to:organization:content-transfer-encoding;
        bh=I/XnTtEOOERi3D2WEAN9amBfI5sIcheB3m2CASX7uDY=;
        b=uS0Y50q14fFyvj5jjSDnOsup71IOkOiHI2cXxChidgRYAF6PGOUzAwKC0ZNL2dhlj8
         7SqcmQlIB32eLx1S/BCfR6Dh23h8gWW+UIMOfkWmflK07efyRoickcAXPhSg2cLkl0bw
         qLJ00WlaPlPO5XZK5IodXnWK8RjdXaaHlKw103/0InvnI2GdV0VPBButdXyP7a53lyIO
         rDNUZAX/mVX+fI7d4LGT2zo8egn/QRFJ92fqp7KqlHJ1OfVNcIKcZxWdFXkyKGiNoGsP
         1WOf8n8MDuaP3g625kuxMcNjc4dwI//T/MFGcjggyCznTrQtZqS3XtzNTCsqj2SjZzws
         y9Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:reply-to:organization
         :content-transfer-encoding;
        bh=I/XnTtEOOERi3D2WEAN9amBfI5sIcheB3m2CASX7uDY=;
        b=EGH6VFbNOSM6alCuLRZF2kTK4SVhTU0gxqAhpVk9JlGn3V23BfIdtuotUFvyNuXfZS
         LM+gWioQI20CFmcjn3X6+vrCvdtg0Sf8k9kH1uZUY6S5e+k+Pf+7+lvpClh+ngBqOfbT
         FaDEdPpF+utO0qvB6p3i2egxbkVSAcjnU2AOd+3xOb3VlTdLhQymyKcJDW4DIR827Q7n
         BSxQBNUvh3zXgKP4R9QAn6mduId4caelDmpIEeKGVIDQYzD+Q+nma5t6ToK9qmQF01cX
         38/uW7Dg7ziPi/MVuPZGlLih8RXdPp0rV1olXew+Jopjp/c87uZG33HZaWiuHrOybzxv
         d8pQ==
X-Gm-Message-State: ANhLgQ0Iap1JpAxPXIjS8cOYywfvXBj4eiQzY1GADmMJBaoWB9H5/fCd
        Oe9dHupKMvRs06LZXN5efqWpzGcf
X-Google-Smtp-Source: ADFU+vu8wYY6/gfQ2QTaNt5bA8tscRivI34WWaQC/BcvquQHN8fGM6Cl8qIK/xNqfSlOPvOt4zWkfQ==
X-Received: by 2002:ac8:24a7:: with SMTP id s36mr11867794qts.357.1584766496487;
        Fri, 20 Mar 2020 21:54:56 -0700 (PDT)
Received: from localhost.localdomain (h96-61-82-19.cntcnh.dsl.dynamic.tds.net. [96.61.82.19])
        by smtp.gmail.com with ESMTPSA id 128sm6132081qki.103.2020.03.20.21.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 21:54:55 -0700 (PDT)
From:   Len Brown <lenb@kernel.org>
To:     linux-pm@vger.kernel.org
Cc:     Len Brown <len.brown@intel.com>,
        Antti Laakso <antti.laakso@linux.intel.com>
Subject: [PATCH v2 09/10] tools/power turbostat: Print cpuidle information
Date:   Sat, 21 Mar 2020 00:54:37 -0400
Message-Id: <abdcbdb265264f736df316622a695ad30019c05f.1584766216.git.len.brown@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <081c54323b27d8d4b40df6b2375b9e1f6846d827.1584766216.git.len.brown@intel.com>
References: <081c54323b27d8d4b40df6b2375b9e1f6846d827.1584766216.git.len.brown@intel.com>
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Len Brown <len.brown@intel.com>

Print cpuidle driver and governor.

Originally-by: Antti Laakso <antti.laakso@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 77f89371ec5f..05dbe23570d4 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -3503,6 +3503,23 @@ dump_cstate_pstate_config_info(unsigned int family, unsigned int model)
 	dump_nhm_cst_cfg();
 }
 
+static void dump_sysfs_file(char *path)
+{
+	FILE *input;
+	char cpuidle_buf[64];
+
+	input = fopen(path, "r");
+	if (input == NULL) {
+		if (debug)
+			fprintf(outf, "NSFOD %s\n", path);
+		return;
+	}
+	if (!fgets(cpuidle_buf, sizeof(cpuidle_buf), input))
+		err(1, "%s: failed to read file", path);
+	fclose(input);
+
+	fprintf(outf, "%s: %s", strrchr(path, '/') + 1, cpuidle_buf);
+}
 static void
 dump_sysfs_cstate_config(void)
 {
@@ -3516,6 +3533,15 @@ dump_sysfs_cstate_config(void)
 	if (!DO_BIC(BIC_sysfs))
 		return;
 
+	if (access("/sys/devices/system/cpu/cpuidle", R_OK)) {
+		fprintf(outf, "cpuidle not loaded\n");
+		return;
+	}
+
+	dump_sysfs_file("/sys/devices/system/cpu/cpuidle/current_driver");
+	dump_sysfs_file("/sys/devices/system/cpu/cpuidle/current_governor");
+	dump_sysfs_file("/sys/devices/system/cpu/cpuidle/current_governor_ro");
+
 	for (state = 0; state < 10; ++state) {
 
 		sprintf(path, "/sys/devices/system/cpu/cpu%d/cpuidle/state%d/name",
-- 
2.20.1

