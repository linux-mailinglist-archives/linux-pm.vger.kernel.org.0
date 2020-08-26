Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4937252DB3
	for <lists+linux-pm@lfdr.de>; Wed, 26 Aug 2020 14:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729673AbgHZMFI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Aug 2020 08:05:08 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42821 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729677AbgHZMFB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Aug 2020 08:05:01 -0400
Received: by mail-wr1-f67.google.com with SMTP id q14so1528555wrn.9;
        Wed, 26 Aug 2020 05:05:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yeR3qMxY8QK4/wvsoj5cuxH3mWn/t2ot23DexX4h7MA=;
        b=IxdmjIAk61phj86Vx2aVeUtyV1ZPH6KSc6YbsU2upSKiejQ2+9+5qYpeJ0vwQ1Ft4K
         yBA/x5JdIzT2RFVMchiz886iNCuDWnEyLHUHakwU3eL9BNqVIQGscVT6s/uhE7zHPeyZ
         1Peh8dJwsx6AgyoXqQkD6BVloLi9NBXaLjv0z9xgAKm9EF+d62CaFjPNm7ifPMrfgxzF
         Lt3RKsbOBJNyf9ZFCrLIRKpfeshH0BFblASsrNDaY5gKMIkxRGKi8GyDlLW/VtlG3S9A
         sQl674qG4AUx1TxijPipxKuofwQyhfGH1BofPnrl+xkzqvyWbYaxo5smqopN51ieUnWm
         E0oA==
X-Gm-Message-State: AOAM532RTMuiB3z/59l1yZhmZQCDDr5vZLxbi5MTtxhb0hWRedR50Qi8
        5RWPrFjQLB55qJTyzQgffj6b+4oQm6983A==
X-Google-Smtp-Source: ABdhPJzsVm84CbbIOidcz8nD79LPK/Ny1lXC+ZG5qTLEMI14VHYwfiCaAadaxv6yHSvDMychEJr93w==
X-Received: by 2002:adf:e452:: with SMTP id t18mr14333704wrm.109.1598443498258;
        Wed, 26 Aug 2020 05:04:58 -0700 (PDT)
Received: from localhost.localdomain (static-176-175-69-188.ftth.abo.bbox.fr. [176.175.69.188])
        by smtp.googlemail.com with ESMTPSA id k24sm4728420wmj.19.2020.08.26.05.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 05:04:57 -0700 (PDT)
From:   Guilhem Lettron <guilhem@barpilot.io>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guilhem Lettron <guilhem@barpilot.io>
Subject: [PATCH] intel_idle: Add ICL support
Date:   Wed, 26 Aug 2020 14:04:21 +0200
Message-Id: <20200826120421.44356-1-guilhem@barpilot.io>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Use the same C-states as SKL

Signed-off-by: Guilhem Lettron <guilhem@barpilot.io>
---
 drivers/idle/intel_idle.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 8e0fb1a5bdbd..1bb539f09a4f 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -1145,6 +1145,8 @@ static const struct x86_cpu_id intel_idle_ids[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE_L,		&idle_cpu_skl),
 	X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE,		&idle_cpu_skl),
 	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_X,		&idle_cpu_skx),
+	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE,		&idle_cpu_skl),
+	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_L,		&idle_cpu_skl),
 	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X,		&idle_cpu_icx),
 	X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNL,	&idle_cpu_knl),
 	X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNM,	&idle_cpu_knl),
-- 
2.27.0

