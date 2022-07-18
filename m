Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 831F4577DD0
	for <lists+linux-pm@lfdr.de>; Mon, 18 Jul 2022 10:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233911AbiGRIqd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Jul 2022 04:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233927AbiGRIqc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Jul 2022 04:46:32 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DEBEF1F
        for <linux-pm@vger.kernel.org>; Mon, 18 Jul 2022 01:46:32 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id o15so11115652pjh.1
        for <linux-pm@vger.kernel.org>; Mon, 18 Jul 2022 01:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y957zCpGlniV/Si1gB7hyzzV3GqFvEOSGpTrCkRJ3N4=;
        b=TS8oWTsNuIKrdwz7CdqkNr+Kyt2Fkt1mCq4Ny+Vw68yXzZfoO6nk5PfGIF2Vslrs9Q
         EYzquS26tAqK23AjcRIws+7QPlLihZjNPF472zGRnEorq852UPp1qrL1WzeXhy5VU7/j
         7JZxDDdj/8qS2cZBVMmkrUpIJUTd6SXj5fEWvo1MXFfovv6aivByO5jqhq7Jr0RHw5w9
         qL13T/B01oDW0cpgjGtu+2p/4Y3Y+P7R5LCBTlnU8RuSEOppyblLrsuvMD3XtiNarh0B
         rRhKoA+ktuLOw4zwOCrhtwCxXMis2U5gYd0IaJBSll6lFTdH/O1pPkNhiyvDOI3aewKl
         EVcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y957zCpGlniV/Si1gB7hyzzV3GqFvEOSGpTrCkRJ3N4=;
        b=qbiQxK5nvc4VGqGprv0bVbxBlwhrqC3Q0htxLV7CqKotia7lQhKTdc5ZdJQysTNNTF
         lZ4lA7vLDC5h2ZHFY2Nc0/FrqWj0NQDNZ6dg01QE3qo3QkLqwXudAjUKhij1pJzSM5ly
         c7eZQtHMFPWd2U3WAahXwcfsEPCrFnFrL9NXowUe+QWcQRdLwiqCle6NBWTjEquWZLPs
         +xGRDAG/O/5snVeoNWlc/IPCHhYxANPcz3Ls0jK7OZBvxOIZA7JLG82S9X+wArmxvFGd
         ve+s2yGGHnDkBBR3mmVsPKnMi063dwYBDHhLaY/zgDJeY9qbucur1qlyjqh/RJRL0pJd
         gjgA==
X-Gm-Message-State: AJIora8uSDm3udlBdVIENfGVNEiBag3rj837stm9geQ2OGFXfHReCjWs
        rGElIYQRKB0akfy3mWVyv7pVdA==
X-Google-Smtp-Source: AGRyM1v0lb2Qi2Gd06NKDrEvEWrU5c3+56Zc1hPsUTR+a7AE9/OC+/MnWmQuOOiqrIueE72+pTFq7Q==
X-Received: by 2002:a17:90b:4b50:b0:1f0:5643:fa5c with SMTP id mi16-20020a17090b4b5000b001f05643fa5cmr38855624pjb.131.1658133991458;
        Mon, 18 Jul 2022 01:46:31 -0700 (PDT)
Received: from anup-ubuntu64-vm.. ([122.171.37.148])
        by smtp.gmail.com with ESMTPSA id t6-20020a635f06000000b0040dffa7e3d7sm7556487pgb.16.2022.07.18.01.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 01:46:30 -0700 (PDT)
From:   Anup Patel <apatel@ventanamicro.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>, linux-pm@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH] cpuidle: riscv-sbi: Fix CPU_PM_CPU_IDLE_ENTER_xyz() macro usage
Date:   Mon, 18 Jul 2022 14:15:53 +0530
Message-Id: <20220718084553.2056169-1-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Currently, we are using CPU_PM_CPU_IDLE_ENTER_PARAM() for all SBI HSM
suspend types so retentive suspend types are also treated non-retentive
and kernel will do redundant additional work for these states.

The BIT[31] of SBI HSM suspend types allows us to differentiate between
retentive and non-retentive suspend types so we should use this BIT
to call appropriate CPU_PM_CPU_IDLE_ENTER_xyz() macro.

Fixes: 6abf32f1d9c5 ("cpuidle: Add RISC-V SBI CPU idle driver")
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 drivers/cpuidle/cpuidle-riscv-sbi.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle-riscv-sbi.c b/drivers/cpuidle/cpuidle-riscv-sbi.c
index 1151e5e2ba82..33c92fec4365 100644
--- a/drivers/cpuidle/cpuidle-riscv-sbi.c
+++ b/drivers/cpuidle/cpuidle-riscv-sbi.c
@@ -97,8 +97,13 @@ static int sbi_cpuidle_enter_state(struct cpuidle_device *dev,
 				   struct cpuidle_driver *drv, int idx)
 {
 	u32 *states = __this_cpu_read(sbi_cpuidle_data.states);
+	u32 state = states[idx];
 
-	return CPU_PM_CPU_IDLE_ENTER_PARAM(sbi_suspend, idx, states[idx]);
+	if (state & SBI_HSM_SUSP_NON_RET_BIT)
+		return CPU_PM_CPU_IDLE_ENTER_PARAM(sbi_suspend, idx, state);
+	else
+		return CPU_PM_CPU_IDLE_ENTER_RETENTION_PARAM(sbi_suspend,
+							     idx, state);
 }
 
 static int __sbi_enter_domain_idle_state(struct cpuidle_device *dev,
-- 
2.34.1

