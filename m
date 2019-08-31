Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A41AAA45ED
	for <lists+linux-pm@lfdr.de>; Sat, 31 Aug 2019 21:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728526AbfHaTfa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 31 Aug 2019 15:35:30 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:41362 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728477AbfHaTfa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 31 Aug 2019 15:35:30 -0400
Received: by mail-io1-f68.google.com with SMTP id j5so21051378ioj.8
        for <linux-pm@vger.kernel.org>; Sat, 31 Aug 2019 12:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:reply-to:organization:content-transfer-encoding;
        bh=YtAgTdw/rysthovZPX64XjklJsUxVge/haMZznY1gms=;
        b=Lz/E+JRiRVkEwgb419X69FWgmT/paqrh8oeJkaiAkpxodxwhoT0WzeM5Hd02ojyZ4o
         41+CPioXKyBYXIDXPRuW3+C9N/I/itToREcA6klAoRotOyitWIy1GkSAB+S5GJ8SJ4Ub
         OyO3nvOvClLuXFLPniM3nJr50n7BZfGQE4OS0dBMe4bijpNI1pdvkAxA9ZcwuQUWbZ7n
         r0VsOJvQcvMnLuXuV+y0VZ5J1ChgSFazu4aZm3gNO4vVu/iZYKGmxhJ8hZmLtJzBBMxM
         s9bMqGAKDVthdTJ5dRpSbrvUsePLwIaerLbDd2ejNAP+fshvfJR5vTxFJqwPWc6mhr56
         VdtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:reply-to:organization
         :content-transfer-encoding;
        bh=YtAgTdw/rysthovZPX64XjklJsUxVge/haMZznY1gms=;
        b=ajO6C1LO/VFgYKjwcq+BlOeDy7JtKBbQqo1IImG3xwdo9BcLnLotsaynn88P/iTkTM
         9imyKi/6nhYmZI2zCGIimkwJ6xyLm88tRRZumjztdlP+LlCTtdoQ6mvoXMgia6khiOo5
         WHm/8//pcTFzFQBWWs9bzP2Vha3ujEx4Jx3S4YTYQF1L4BEQsZoQj22rvNfuwKM8Ymjn
         nmIRM9xpiJJkqt7xpApsmklgbffUV1f/vSJJFFuBvYnf4K49RQEZLcFb9iZM4nUTfSBX
         Lyk5CKEIpdhAlgBS0T571GiiKcPZ9KCljWHPEgsDUhMTAX76TVjO3cX3gXiGKTneYtGA
         GoSw==
X-Gm-Message-State: APjAAAX6qKSFjLda4nhYTS2kj4Ptrb+exiWkzwfPAEzhlMmTBKByWzQi
        DFSjZynN9TRApU1/c7N3dYKvs5HJ
X-Google-Smtp-Source: APXvYqwHejdJJvMW3icPtoD11xRClVxBAN5hnFCvFLAhfJXb0eLGFSC08Z0jGwBFT3+ZTD4ipjBQkg==
X-Received: by 2002:a5d:8a10:: with SMTP id w16mr4605505iod.175.1567280129551;
        Sat, 31 Aug 2019 12:35:29 -0700 (PDT)
Received: from nuc8.tds (h69-131-112-51.cntcnh.dsl.dynamic.tds.net. [69.131.112.51])
        by smtp.gmail.com with ESMTPSA id r2sm6937376ioh.61.2019.08.31.12.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Aug 2019 12:35:28 -0700 (PDT)
From:   Len Brown <lenb@kernel.org>
To:     linux-pm@vger.kernel.org
Cc:     Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>
Subject: [PATCH 10/19] tools/power turbostat: add Jacobsville support
Date:   Sat, 31 Aug 2019 15:34:49 -0400
Message-Id: <b62b3184576b8f87ca655dd9bfd1ae02fd4e50a5.1567277326.git.len.brown@intel.com>
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

From: Zhang Rui <rui.zhang@intel.com>

Jacobsville behaves like Denverton.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index f8f4e1c130a6..35f4366a522e 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -4591,6 +4591,9 @@ unsigned int intel_model_duplicates(unsigned int model)
 
 	case INTEL_FAM6_ICELAKE_MOBILE:
 		return INTEL_FAM6_CANNONLAKE_MOBILE;
+
+	case INTEL_FAM6_ATOM_TREMONT_X:
+		return INTEL_FAM6_ATOM_GOLDMONT_X;
 	}
 	return model;
 }
-- 
2.20.1

