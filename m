Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0A9DA45EC
	for <lists+linux-pm@lfdr.de>; Sat, 31 Aug 2019 21:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728519AbfHaTf3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 31 Aug 2019 15:35:29 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:33337 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728477AbfHaTf3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 31 Aug 2019 15:35:29 -0400
Received: by mail-io1-f66.google.com with SMTP id z3so21192865iog.0
        for <linux-pm@vger.kernel.org>; Sat, 31 Aug 2019 12:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:reply-to:organization:content-transfer-encoding;
        bh=ife59CansJdiuUBisqVTeUVM1g1vLhLaLfQdgHpFelc=;
        b=YW20kUuojr7RFMNv8I/JDd6DjUHGL8S3OzQf06g+tv+35fab1epRPSIKGGDf3yQYXt
         BUiPBSByWWIEBtpqtIa9bnDXTrgBHCfv72RZwC9lpjvHNTPLxDoL8mV4jaH9vHblSK4u
         Y2jHwH+rh8NoGRYYxHE31kmjYKL9yFKrZ5wqEOGQkuj4o1fW1toGv5NRo2F0BDnL8jLt
         Sbuhv62OktQ08SfkXntaoMsL9qyxL8EOEP28Sh48L9Ux7qbtFquzjOqE5LYWB8Slv4Vz
         PTOLfxivfD1Ag3osBv4+pk/UyyBn9IbLCs5pA5QuIdRY0AHP/QfQHUF9m1fsO59Jy6Vo
         SCNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:reply-to:organization
         :content-transfer-encoding;
        bh=ife59CansJdiuUBisqVTeUVM1g1vLhLaLfQdgHpFelc=;
        b=OBAgvd3KpWCQbCgBV2M7zyPl5If/Rvryb6+Rn3Bt+Tw2ZghB/d4G/DP9x3+h4o8dEQ
         dG8q1v/ju5rV5FXvS8EZ0dRfO5EO0cKqERKnpFQoEfiyNgiNkr8TUUEC2zh4ySINzLn/
         SZ0jfLH0Zb1V4KRTXoRk98i63/wp9wGFvtnAjUOnniKDPrT7kRwN+kobZx4u9Uutxt1s
         kgZdNXQ1m1EZyMZqcvsGK9IWPZ4TxoU4oj48jR51Prnk1ygtcV6w02rBkE5K2JNWGWRB
         vrNunvj3ZLpe+FTy0Dx+ceZEIjtgtUpnf2E0vzz7bUC+q5QtJDDuI2gnzw4qOdy9hCep
         QzCg==
X-Gm-Message-State: APjAAAXa3EUETnmzSadiz6wcGR6ijEtT6b/RAhVp+N90zXv8EPzFjQ9Y
        6IO2/Y53IVnhLD+8uypBHVoQ8E7V
X-Google-Smtp-Source: APXvYqwpLlvwxlwFXSI32Je8tI2O7F1WW17i8L78IW0EZrta8peIx8Ojg1ZjMBvXCgzxlP8236jMBQ==
X-Received: by 2002:a5d:9d49:: with SMTP id k9mr10822195iok.106.1567280128468;
        Sat, 31 Aug 2019 12:35:28 -0700 (PDT)
Received: from nuc8.tds (h69-131-112-51.cntcnh.dsl.dynamic.tds.net. [69.131.112.51])
        by smtp.gmail.com with ESMTPSA id r2sm6937376ioh.61.2019.08.31.12.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Aug 2019 12:35:27 -0700 (PDT)
From:   Len Brown <lenb@kernel.org>
To:     linux-pm@vger.kernel.org
Cc:     Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Len Brown <len.brown@intel.com>
Subject: [PATCH 09/19] tools/power turbostat: fix buffer overrun
Date:   Sat, 31 Aug 2019 15:34:48 -0400
Message-Id: <eeb71c950bc6eee460f2070643ce137e067b234c.1567277326.git.len.brown@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <adb8049097a9ec4acd09fbd3aa8636199a78df8a.1567277326.git.len.brown@intel.com>
References: <adb8049097a9ec4acd09fbd3aa8636199a78df8a.1567277326.git.len.brown@intel.com>
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>

turbostat could be terminated by general protection fault on some latest
hardwares which (for example) support 9 levels of C-states and show 18
"tADDED" lines. That bloats the total output and finally causes buffer
overrun.  So let's extend the buffer to avoid this.

Signed-off-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 2fb5c155289b..f8f4e1c130a6 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -5131,7 +5131,7 @@ int initialize_counters(int cpu_id)
 
 void allocate_output_buffer()
 {
-	output_buffer = calloc(1, (1 + topo.num_cpus) * 1024);
+	output_buffer = calloc(1, (1 + topo.num_cpus) * 2048);
 	outp = output_buffer;
 	if (outp == NULL)
 		err(-1, "calloc output buffer");
-- 
2.20.1

