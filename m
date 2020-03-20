Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9B4C18C6CC
	for <lists+linux-pm@lfdr.de>; Fri, 20 Mar 2020 06:23:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbgCTFXM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 20 Mar 2020 01:23:12 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42753 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbgCTFXM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 20 Mar 2020 01:23:12 -0400
Received: by mail-qt1-f193.google.com with SMTP id t9so48010qto.9
        for <linux-pm@vger.kernel.org>; Thu, 19 Mar 2020 22:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:reply-to:organization:content-transfer-encoding;
        bh=9w31pVo9yQoAO2jOqhauobcS56RYPSJajRdXocwsTSg=;
        b=MN21bowByjC91bwqg3e2jOLTv06WM/ndv4qmWDEGfON2Ke7iG2aMvtnfiR+hy9Xop6
         woJA5DIlLGDavOiX0etaqSF0VXQEDhQ3ognUvtxOhGUkw3u9smEcYOT4rTV5MXzTv2sM
         KggfxOm2pvyR70jG7vxE4kwINUiuQu0cNuZKsCndcOndfMiOht2dnOGrG3qms9fohSWQ
         FgvAV72/1ebL6h5sl/vUmRkE8H5Oh9k995Vz0GaiBfeWLvERW16B3n6waXMqYiAcFm9u
         +az6rvEpYlHqqiIuKHi7+W6hRfTyq7mIeZOJUyhBZAtEZ26AfKZfsoeyNbofeCPNPLs9
         Bi6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:reply-to:organization
         :content-transfer-encoding;
        bh=9w31pVo9yQoAO2jOqhauobcS56RYPSJajRdXocwsTSg=;
        b=edX8j2V+2YhHr2bSVbW6b+oNCYlxv0XRTlLzmUdCXmg5ZffWVYQKPtwQouKn/SCfCs
         SBADlW1D1djG1PwIn2qj+4DfwSxCd42mwt2JcN7+aSK+1h4kSjGpkeuFY0rPlbKrjPfQ
         4omXRsmFM5rAq9WaUkFjCkPFzGoKeFjHMCJF1aTqiZcyuJaV+hFJ+bRjXs8+2xOpakT2
         IRKi3WwC2txvmmbWZbmLkx0ecbYOUX77UFOJgZPBGuLVhDmzPiuoavo284im/3jVosVH
         B59OFHB1glBTqWimNlOMbswdHW6TVqLP3dlSTz58+dYnGnVguB+RUp/9odxyMTDZn0nx
         tXxw==
X-Gm-Message-State: ANhLgQ1C7el0tLeWb3KGeG3xq1E0BOBFfEdMKwQn/Bw1LTzLTyRHtXh6
        8U5TEkwM8LL5F34Q3cBLzE9s0nPX
X-Google-Smtp-Source: ADFU+vsFQdR9pfxQvtaigjGlgs8oYJg/15SQp2gE33/TYYQzFUF8OPI7CjVk1XfBYzeTmQQJiWBjiw==
X-Received: by 2002:aed:21c5:: with SMTP id m5mr6403929qtc.42.1584681790605;
        Thu, 19 Mar 2020 22:23:10 -0700 (PDT)
Received: from localhost.localdomain (h96-61-82-19.cntcnh.dsl.dynamic.tds.net. [96.61.82.19])
        by smtp.gmail.com with ESMTPSA id w134sm3273383qka.127.2020.03.19.22.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 22:23:10 -0700 (PDT)
From:   Len Brown <lenb@kernel.org>
To:     linux-pm@vger.kernel.org
Cc:     Antti Laakso <antti.laakso@linux.intel.com>,
        Len Brown <len.brown@intel.com>
Subject: [PATCH 09/10] tools/power turbostat: Print cpuidle information
Date:   Fri, 20 Mar 2020 01:22:47 -0400
Message-Id: <7c3808082a40a96e95808864fe814b4e68238a46.1584679387.git.len.brown@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <081c54323b27d8d4b40df6b2375b9e1f6846d827.1584679387.git.len.brown@intel.com>
References: <081c54323b27d8d4b40df6b2375b9e1f6846d827.1584679387.git.len.brown@intel.com>
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Antti Laakso <antti.laakso@linux.intel.com>

Print cpuidle driver and governor.

Signed-off-by: Antti Laakso <antti.laakso@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 30 +++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 77f89371ec5f..c9e299e99c2f 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -3509,6 +3509,7 @@ dump_sysfs_cstate_config(void)
 	char path[64];
 	char name_buf[16];
 	char desc[64];
+	char cpuidle_buf[64];
 	FILE *input;
 	int state;
 	char *sp;
@@ -3516,6 +3517,35 @@ dump_sysfs_cstate_config(void)
 	if (!DO_BIC(BIC_sysfs))
 		return;
 
+	if (access("/sys/devices/system/cpu/cpuidle", R_OK)) {
+		fprintf(outf, "cpuidle not loaded\n");
+		return;
+	}
+
+	sprintf(path, "/sys/devices/system/cpu/cpuidle/current_driver");
+	input = fopen(path, "r");
+	if (input == NULL) {
+		fprintf(outf, "NSFOD %s\n", path);
+		return;
+	}
+	if (!fgets(cpuidle_buf, sizeof(cpuidle_buf), input))
+		err(1, "%s: failed to read file", path);
+	fclose(input);
+
+	fprintf(outf, "cpuidle driver: %s", cpuidle_buf);
+
+	sprintf(path, "/sys/devices/system/cpu/cpuidle/current_governor_ro");
+	input = fopen(path, "r");
+	if (input == NULL) {
+		fprintf(outf, "NSFOD %s\n", path);
+		return;
+	}
+	if (!fgets(cpuidle_buf, sizeof(cpuidle_buf), input))
+		err(1, "%s: failed to read file", path);
+	fclose(input);
+
+	fprintf(outf, "cpuidle governor: %s", cpuidle_buf);
+
 	for (state = 0; state < 10; ++state) {
 
 		sprintf(path, "/sys/devices/system/cpu/cpu%d/cpuidle/state%d/name",
-- 
2.20.1

