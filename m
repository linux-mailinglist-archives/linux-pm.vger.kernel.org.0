Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9D3BA45E6
	for <lists+linux-pm@lfdr.de>; Sat, 31 Aug 2019 21:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728504AbfHaTfW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 31 Aug 2019 15:35:22 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:42353 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728477AbfHaTfW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 31 Aug 2019 15:35:22 -0400
Received: by mail-io1-f65.google.com with SMTP id n197so19118359iod.9
        for <linux-pm@vger.kernel.org>; Sat, 31 Aug 2019 12:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:reply-to:organization:content-transfer-encoding;
        bh=oI9aGM88Fs4bIGGOK6OU19vcrLkdBifiBfV7o5jmHIQ=;
        b=TFMZa8VMlAYhWJsaF81spJPY+NbTm6ikmV8zSKH/gxZoyU9Ke0wn3vVRdnQTqiPy8e
         2zbkZ71GFAAnAYN5PB2PkoHi2qso/ukVY4G5xtQvwbhCLcVf07HfAGoe3de5SgxYNIYe
         tR/l8XMPsNjW0Pf1rDKXr4XEGAXS2G2Mc0Y7N6wKeJjUs0pYo6M44h6FZNUoIKKoIRph
         QDOQGtOrkAyeGkoNJKmgTlk+p4FjzneU34rKEBD8ssw7hr/vWO/TbsgnEJt4kVe5wdCW
         txfhJ9UxB1IU38Srm5LeBN9NVS4F+X95Q4DirIcOmSOVZHVS/D+K17KJuG+XHgyZkK9V
         6HuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:reply-to:organization
         :content-transfer-encoding;
        bh=oI9aGM88Fs4bIGGOK6OU19vcrLkdBifiBfV7o5jmHIQ=;
        b=K+t2BRP6UosOJYbt4Li9Pda9IUfHC/VUpLwRSfrFRszzsSKYt9fiDkjgc/0Ul7OxIO
         QNtWpkJbEuTvRtc54zRgIM1XeUGkQgT4foDo+gwYg6dO7QaFkvPHKudCcM00RJnsF32m
         abXdr+IhtYcQ+C+1rcrz9mzzwnMuu1DzSuAc7vl1rTdKWy+Yy+RD9GYIUwBdoN2ynwg8
         h47lT1HfseLCzll85mOvJrvDVPo3VxWE5GgvTTH/ysVLA3USxXFlhWpZHaOzJTMsn744
         xYbU7z+RZNsM3WHcq/oodX5XKTCpiBIM9WtbSAFuAG8EfxSupHN8iNg9QLIrudH9XsX0
         jYiA==
X-Gm-Message-State: APjAAAUC8cGbbjQmO/gcJQB+z/ULIxmWxKgbNN2tytkqtP42TUiX6ZHq
        hZ1YyfVMUdtcvZCNewBWpMjn9Cpa
X-Google-Smtp-Source: APXvYqx6VyyKZqSIwqBdE75LjdnseyrPabFZjfaxMuKg5UgOw71Z5uutLDEsrWOw8xoHVwuvnXYMuw==
X-Received: by 2002:a5d:9282:: with SMTP id s2mr7476121iom.283.1567280121587;
        Sat, 31 Aug 2019 12:35:21 -0700 (PDT)
Received: from nuc8.tds (h69-131-112-51.cntcnh.dsl.dynamic.tds.net. [69.131.112.51])
        by smtp.gmail.com with ESMTPSA id r2sm6937376ioh.61.2019.08.31.12.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Aug 2019 12:35:20 -0700 (PDT)
From:   Len Brown <lenb@kernel.org>
To:     linux-pm@vger.kernel.org
Cc:     Matt Lupfer <mlupfer@ddn.com>, Len Brown <len.brown@intel.com>
Subject: [PATCH 03/19] tools/power: Fix typo in man page
Date:   Sat, 31 Aug 2019 15:34:42 -0400
Message-Id: <f3fe116a44fd02bc65dd312969697d06ca86b730.1567277326.git.len.brown@intel.com>
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

From: Matt Lupfer <mlupfer@ddn.com>

From context, we mean EPB (Enegry Performance Bias).

Signed-off-by: Matt Lupfer <mlupfer@ddn.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.8 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.8 b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.8
index 17db1c3af4d0..78c6361898b1 100644
--- a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.8
+++ b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.8
@@ -40,7 +40,7 @@ in the same processor package.
 Hardware P-States (HWP) are effectively an expansion of hardware
 P-state control from the opportunistic turbo-mode P-state range
 to include the entire range of available P-states.
-On Broadwell Xeon, the initial HWP implementation, EBP influenced HWP.
+On Broadwell Xeon, the initial HWP implementation, EPB influenced HWP.
 That influence was removed in subsequent generations,
 where it was moved to the
 Energy_Performance_Preference (EPP) field in
-- 
2.20.1

