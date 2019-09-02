Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA31BA56D9
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2019 15:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731001AbfIBNAO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Sep 2019 09:00:14 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44130 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730415AbfIBNAO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Sep 2019 09:00:14 -0400
Received: by mail-wr1-f66.google.com with SMTP id 30so2992365wrk.11;
        Mon, 02 Sep 2019 06:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CR+WyZAA9xMYW0zZtGve7PJv/lFxf7k0Ilvhu1URmfo=;
        b=LxuOHy9CeNfh66hew9jbYLP7/yrWYuvIjk+SQAw37alTfS0HlaA59hIpg/f2JhdVTh
         TxVntIVZdxc0g611JfMqOq+Vh0jqMXHfpBFkNeMTcTmiocTXdqXbYx41rfDj+6ev6wEZ
         OcGXnB3hgSJ/mBZNzuhbIScHPA+FlhEPx3wRhoXyz7lfqYQblCRpwMGcDVHkPebOmRXy
         Zxrh3nZN95i0WE59peE0/PnZBokMo8mcaDBP0kNXc6Kwu+/ywTT/s/PokxNmRsUwvE5z
         kXaWoT/XTdRzebZTQrjYvB5ke/c5R4HYlJ23TAQjcHXe84FeEnb+D+z8xvEalqkVmgw5
         ldvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CR+WyZAA9xMYW0zZtGve7PJv/lFxf7k0Ilvhu1URmfo=;
        b=DeN6EsG6OOdBXBIurB0oryg6vFxntxARxQ4NoAbvvIAzLnOnZXaFjD82y/5dFXZC7f
         iTCNiWIiFnrv6yW0GzsSMZ01pjd0oihzpaVKBQfnXX9j14RfmrshTksM8+My1bNxFSfr
         51sJKL1pGzYjio/axEzPLiQ+dZVdzbjubi/JErKfBXDeanXboiHwcENbg6HI03MrdWNy
         l7/cjkJjdRKwta/lbM4fVdLXufJ2h72SC25zIy1MjN87XDrD0aOCLNn/YlQQT6/7YH6U
         +XRWKDEUGcHm2BFey3u8RcmOBqBbzVbfOkA4DF69yg52hMgRAmze45gWecct0F1A43TT
         TkSQ==
X-Gm-Message-State: APjAAAW1T1/PupYje9Vwuf7Wady32700650QXVupAlYoFpk7vVUqxGeF
        p2WTgivPjDbaM/B05jsqAxo=
X-Google-Smtp-Source: APXvYqy2E//Dcr0bFJY8gdWVaU6D1gsWSGVoa5CLXjgU5KRe7Z2OSvATAvGTqQrq1pFA6i5bByfd/w==
X-Received: by 2002:adf:aa85:: with SMTP id h5mr23089367wrc.329.1567429211920;
        Mon, 02 Sep 2019 06:00:11 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e34:eecb:7400:8425:c99f:73d7:9637])
        by smtp.gmail.com with ESMTPSA id y14sm35168809wrd.84.2019.09.02.06.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2019 06:00:11 -0700 (PDT)
From:   Erwan Velu <erwanaliasr1@gmail.com>
X-Google-Original-From: Erwan Velu <e.velu@criteo.com>
Cc:     Erwan Velu <e.velu@criteo.com>, Len Brown <lenb@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] tools/power/x86/turbostat: Fixing PKG_MIN_PWR_LVL{1|2} values
Date:   Mon,  2 Sep 2019 15:00:07 +0200
Message-Id: <20190902130007.14854-1-e.velu@criteo.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

As per Intel's documentation, those 2 registers are starting from offset 47 and not 48.
As a result, the reported values were incorrect.

Signed-off-by: Erwan Velu <e.velu@criteo.com>
---
 tools/power/x86/turbostat/turbostat.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 75fc4fb9901c..76456de6b140 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -2370,7 +2370,7 @@ dump_config_tdp(void)
 	get_msr(base_cpu, MSR_CONFIG_TDP_LEVEL_1, &msr);
 	fprintf(outf, "cpu%d: MSR_CONFIG_TDP_LEVEL_1: 0x%08llx (", base_cpu, msr);
 	if (msr) {
-		fprintf(outf, "PKG_MIN_PWR_LVL1=%d ", (unsigned int)(msr >> 48) & 0x7FFF);
+		fprintf(outf, "PKG_MIN_PWR_LVL1=%d ", (unsigned int)(msr >> 47) & 0xFFFF);
 		fprintf(outf, "PKG_MAX_PWR_LVL1=%d ", (unsigned int)(msr >> 32) & 0x7FFF);
 		fprintf(outf, "LVL1_RATIO=%d ", (unsigned int)(msr >> 16) & 0xFF);
 		fprintf(outf, "PKG_TDP_LVL1=%d", (unsigned int)(msr) & 0x7FFF);
@@ -2380,7 +2380,7 @@ dump_config_tdp(void)
 	get_msr(base_cpu, MSR_CONFIG_TDP_LEVEL_2, &msr);
 	fprintf(outf, "cpu%d: MSR_CONFIG_TDP_LEVEL_2: 0x%08llx (", base_cpu, msr);
 	if (msr) {
-		fprintf(outf, "PKG_MIN_PWR_LVL2=%d ", (unsigned int)(msr >> 48) & 0x7FFF);
+		fprintf(outf, "PKG_MIN_PWR_LVL2=%d ", (unsigned int)(msr >> 47) & 0xFFFF);
 		fprintf(outf, "PKG_MAX_PWR_LVL2=%d ", (unsigned int)(msr >> 32) & 0x7FFF);
 		fprintf(outf, "LVL2_RATIO=%d ", (unsigned int)(msr >> 16) & 0xFF);
 		fprintf(outf, "PKG_TDP_LVL2=%d", (unsigned int)(msr) & 0x7FFF);
-- 
2.21.0

