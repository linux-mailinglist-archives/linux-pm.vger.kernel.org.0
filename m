Return-Path: <linux-pm+bounces-11479-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3694D93E084
	for <lists+linux-pm@lfdr.de>; Sat, 27 Jul 2024 20:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E77B1281D65
	for <lists+linux-pm@lfdr.de>; Sat, 27 Jul 2024 18:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A175187352;
	Sat, 27 Jul 2024 18:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CBeuZz3G"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D65B187357
	for <linux-pm@vger.kernel.org>; Sat, 27 Jul 2024 18:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722104817; cv=none; b=Ju43xSaEGifLt79QQr0lCK5qmTPOScqm+80UzXbRjeqaWrvJSwO/KlEgzpKrlF10K2Tk0E/NnM+raNjP04QTwJb0TFo/ltXi/IFTEq3DXfW66QBi/0/QJIjoNtSpCKsHAdHkUIWnXABfSZiu6Oz4S3v4z5Rcg5H6+bUAaGxVKhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722104817; c=relaxed/simple;
	bh=wkJDyMgpInvN7EL5wJXogZ3N0K8oWyY5J/ino0WRIPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pyG0EplbUBK+Tkatk/EN0WBh9IpHJBpYpcDJjbdXUHLnLL0u1D5UdZ5wrZGj7IHeF7AAGiKy6How/urp7MXvVpJt6pKYVB3plVOSFipSrHfV1KiSB2LR5v/kG4YWUPzqmNUVAfK/BiFt9o2qjrwVjAo2vFV6rFunKEG5hFP6gJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CBeuZz3G; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7092fb4317dso1779187a34.0
        for <linux-pm@vger.kernel.org>; Sat, 27 Jul 2024 11:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722104814; x=1722709614; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dGjy/NVUgtG7ALyImI40b6+2OPZ3hILseAcV9RuBqL4=;
        b=CBeuZz3GHtRjgLym0mCGlcGVWi4ED7c4R0IDGJtIauWPBXlbdYv209H6HKt70bvahi
         3lLx3TtikbOntNOASMlpUX+SKdOapNqyz7W56NU1Aed5m1Sy0LtDBiqFyKzHswoWeuW7
         wdkunfDkaM8J5Zu5Vqzkl6KNv2f37eyUzIh/J/zFAY5Izg0uAcQGz/Y+sQ8h9Aa2IGcc
         cA7+X+4uhBkAz1qLdpiBWYU9TPVG/Or9cWcIj78OGhC8mNvH/+JKh85TBi05rbWU+NdT
         nzwzvn1lQG4ACfEkBAMgaMe4dfqC+COKtl/jFDMDJCMm4/IiZwK+gAUl2h9w3vjIRya6
         0WQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722104814; x=1722709614;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dGjy/NVUgtG7ALyImI40b6+2OPZ3hILseAcV9RuBqL4=;
        b=rrhvKB8+McqNbPG8qEoI0VI1j0zBuSF9RT+b8iOCmE2Y4sGy5R/nTlrlQVhYPXcXnz
         hJtgUtts9lzWTL7TNcXz/w5tsgWRL8RHeWfk295DNYh3UkmabiUmPjVkVxH1aqFzjWne
         ATV46U7jmNdFRU1P4lD7hWnu9xaPAAj/nk/ElTRGC4jfC4IEznzSXGaQxGpBUNgm42v/
         qzlhcgeYdTHjb8v5XJ25GIN3fqnitJL/HKWV78wAC21fsypo31xvSJ93uZAEJax+gUMr
         7mV3M2S7LJEBlWUx6mu+jtERy21oMrDoxeH+OxTwyf4P9ZI/6LVm9e1/cBQ2oU8lKXDI
         Gfiw==
X-Gm-Message-State: AOJu0YwJ20R0hgJDl2Oe0cq1MPRYAIvkfAjpKmKiwaX7nB/SBNyzVXs9
	CF+hX+HQU/OUF5JigvKONGX+e7qEU2VYg6BVHLsO0OXK+NlDx4uNkD1jmw==
X-Google-Smtp-Source: AGHT+IHdEr+/Bi51BtFtfX6+4IAwcPCkuwoj/Vno8SML28IUmZgf2x5CL6IqcC3UkqBFyPfpvkJ2Yw==
X-Received: by 2002:a05:6830:6009:b0:709:410c:2c96 with SMTP id 46e09a7af769-709410c2ec1mr4117335a34.10.1722104814564;
        Sat, 27 Jul 2024 11:26:54 -0700 (PDT)
Received: from lenb-intel-nuc8i7hvkva.. (h75-100-80-185.cntcnh.broadband.dynamic.tds.net. [75.100.80.185])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7093050a35fsm1314136a34.6.2024.07.27.11.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jul 2024 11:26:54 -0700 (PDT)
Sender: Len Brown <lenb417@gmail.com>
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 09/18] tools/power turbostat: Fix typo in turbostat.8
Date: Sat, 27 Jul 2024 14:23:35 -0400
Message-ID: <478a01016c08d33635359254fc1ab61a8c83dd1a.1722019621.git.len.brown@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <1b3bf0747d4f1a963e59c26e602868bdce195318.1722019621.git.len.brown@intel.com>
References: <1b3bf0747d4f1a963e59c26e602868bdce195318.1722019621.git.len.brown@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit

From: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>

"After" was missing an "r", nothing to see here.

Signed-off-by: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.8 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.8 b/tools/power/x86/turbostat/turbostat.8
index 71ae2d5159ad..44cbc7cb382d 100644
--- a/tools/power/x86/turbostat/turbostat.8
+++ b/tools/power/x86/turbostat/turbostat.8
@@ -323,7 +323,7 @@ available on all processors.
 Here we limit turbostat to showing just the CPU number for cpu0 - cpu3.
 We add a counter showing the 32-bit raw value of MSR 0x199 (MSR_IA32_PERF_CTL),
 labeling it with the column header, "PRF_CTRL", and display it only once,
-afte the conclusion of a 0.1 second sleep.
+after the conclusion of a 0.1 second sleep.
 .nf
 sudo ./turbostat --quiet --cpu 0-3 --show CPU --add msr0x199,u32,raw,PRF_CTRL sleep .1
 0.101604 sec
-- 
2.43.0


