Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6E6A45EF
	for <lists+linux-pm@lfdr.de>; Sat, 31 Aug 2019 21:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728529AbfHaTfd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 31 Aug 2019 15:35:33 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:46300 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728477AbfHaTfd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 31 Aug 2019 15:35:33 -0400
Received: by mail-io1-f66.google.com with SMTP id x4so20979451iog.13
        for <linux-pm@vger.kernel.org>; Sat, 31 Aug 2019 12:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:reply-to:organization:content-transfer-encoding;
        bh=S0OD9wVgE6v58M4Qw6sw2QVJIjux+G04iwcrpqNzrbs=;
        b=c8LPbumJpvJgcZ3HYonEdLFsm3D6vt7veJFpNsuQccDe9hOxM50VFzAVKu1V78DOsl
         501vT94V75CQoYnVQVzR9kAj2F5rhGaS3PyCOJR9qrmxTvRFFe5OimSxGCNeFqVhUym1
         /8+EW1H5XTYo04AVO7HrzDowFwHJIfyttuUH8TXICYshfvs0Fdn/X3CZzgtxWMYqy/Sv
         S/BfJNujpnjp3a7n3Vin10fVHLgFbY9Pz/e05fRXvvx4yOT/996Q/8Aq+EFn5Vmp5roN
         /LbmC6x2CXFKknd0/bcFe4pKnC1wBCeW6JlkHKqEqg+W+ogOP5xFX9v47QngD2kdSCeg
         C2pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:reply-to:organization
         :content-transfer-encoding;
        bh=S0OD9wVgE6v58M4Qw6sw2QVJIjux+G04iwcrpqNzrbs=;
        b=dFLc3msfo+6u9vMl13ZhnZ+Fkd9S//O23r1UTeMn+jHHz2yOBDDewewAdC785sJxTu
         yNQX8uMrykKoz39y8oLUujcZa9HWvke58kBrs4znKFcygvJ60Wvd/2dUB96AAY5PvtQh
         LiPukKjtBKc/rwMoP6E3D74n/bCVoHMwTigkAghPpAf9KgjdIm7mWZyggW/i79qXv7WT
         9r5sY6pUmAExoJAk/iSSsEK0QD2RmFi+gXtF50NsyKYzSOJHIgbtZkX5FHY81wGE5eXh
         NMzMNdm1TBcbS0Q12oU27+pnLPZoU1yHRICVjVZAd/wd9IfFJfJ0osh50HHJj504Y6H5
         6wtg==
X-Gm-Message-State: APjAAAWtH6LMzUzGb6iPGSIxtDU9i+TiXxI3+Y+UZRrLYwKKRyygEx4h
        sGBNWTcd5dSTetm4G81ZS1sgadJo
X-Google-Smtp-Source: APXvYqzrwImkwBJlIoQDqRwd8sOlsRxF1zob7vVBVqT7B1RhwroyIYkh90ycNTvUj2FBRA4quwS5GA==
X-Received: by 2002:a5d:8506:: with SMTP id q6mr11752441ion.43.1567280131821;
        Sat, 31 Aug 2019 12:35:31 -0700 (PDT)
Received: from nuc8.tds (h69-131-112-51.cntcnh.dsl.dynamic.tds.net. [69.131.112.51])
        by smtp.gmail.com with ESMTPSA id r2sm6937376ioh.61.2019.08.31.12.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Aug 2019 12:35:31 -0700 (PDT)
From:   Len Brown <lenb@kernel.org>
To:     linux-pm@vger.kernel.org
Cc:     Len Brown <len.brown@intel.com>
Subject: [PATCH 12/19] tools/power turbostat: rename has_hsw_msrs()
Date:   Sat, 31 Aug 2019 15:34:51 -0400
Message-Id: <570992fc5733b5e1b00a4bdb9272df1e25d63972.1567277326.git.len.brown@intel.com>
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

From: Len Brown <len.brown@intel.com>

Perhaps if this more descriptive name had been used,
then we wouldn't have had the HSW ULT vs HSW CORE bug,
fixed by the previous commit.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 78e7c94b94bf..51c739043214 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -4280,7 +4280,7 @@ int has_snb_msrs(unsigned int family, unsigned int model)
 }
 
 /*
- * HSW adds support for additional MSRs:
+ * HSW ULT added support for C8/C9/C10 MSRs:
  *
  * MSR_PKG_C8_RESIDENCY		0x00000630
  * MSR_PKG_C9_RESIDENCY		0x00000631
@@ -4291,7 +4291,7 @@ int has_snb_msrs(unsigned int family, unsigned int model)
  * MSR_PKGC10_IRTL		0x00000635
  *
  */
-int has_hsw_msrs(unsigned int family, unsigned int model)
+int has_c8910_msrs(unsigned int family, unsigned int model)
 {
 	if (!genuine_intel)
 		return 0;
@@ -4833,12 +4833,12 @@ void process_cpuid()
 		BIC_NOT_PRESENT(BIC_CPU_c7);
 		BIC_NOT_PRESENT(BIC_Pkgpc7);
 	}
-	if (has_hsw_msrs(family, model)) {
+	if (has_c8910_msrs(family, model)) {
 		BIC_PRESENT(BIC_Pkgpc8);
 		BIC_PRESENT(BIC_Pkgpc9);
 		BIC_PRESENT(BIC_Pkgpc10);
 	}
-	do_irtl_hsw = has_hsw_msrs(family, model);
+	do_irtl_hsw = has_c8910_msrs(family, model);
 	if (has_skl_msrs(family, model)) {
 		BIC_PRESENT(BIC_Totl_c0);
 		BIC_PRESENT(BIC_Any_c0);
-- 
2.20.1

