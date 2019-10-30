Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85C01E9E9C
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2019 16:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbfJ3PPA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Oct 2019 11:15:00 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:55565 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727039AbfJ3PO7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Oct 2019 11:14:59 -0400
Received: by mail-qk1-f202.google.com with SMTP id a129so2319573qkg.22
        for <linux-pm@vger.kernel.org>; Wed, 30 Oct 2019 08:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/HqRs/4PEWSPeszy+1YAHTc+STOVRE/b7E+6UiQa8wQ=;
        b=oo64KFyI1zU+6X7Sie0S+Sy7aSaSGxL7Tik7Cn0/91ADmtEtara4n2Kolm9EI/foMZ
         mMaXKwG2iRl49s58iHNzgcLkgOXpgLWGSX40jUMYE9262H0RIHW0S3Hkr2sujoy6tH44
         mEMlhlDHiCKu+gWH6PGC+9vYJsjG61qELT/EmN6fB3RYlvTl/HDwc3LM0YEj4ouPPuy+
         ZkchuwEYvkaS9CPkLrmtWJC3ANGiOgRPEVkMr++md+C1CCgxGvBjVPLDVqizXb7DgDLA
         aiBks5l4eKewM2nfcIBvEsCG3EQSMcePE9vCbYaG53HY/QwQwAKFRzm7l6iiJjnlg90C
         hVKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/HqRs/4PEWSPeszy+1YAHTc+STOVRE/b7E+6UiQa8wQ=;
        b=jp63mrmEWMU6Qz4PN2T2fH68N1avYcZp4rbraJwtzGxB8Z4aN1XeY31YXzp23Txxdn
         YHdTvoRwpLjujn1Ek63o/c64i4mz/t3Chgzn8xoT8A9yI7diJEfYQvFca20/01Cifazk
         0OgkAZy5q57xbZ+VHGWdX+Jkn+YUPeIp3AIIevRfokpvF9VzzcN+5sTDuWZLWmKfPg3l
         Hpmr+IS4RqSwFpXN/lbbPIsVQ/ZMZX7fJepYBhCbNC8uDAKzksqSa/CE1aDviOOfx9Jh
         ExEY1hl9+ccoD/jTYnrRj20ywwZ7B2iRzcI3IC++mUPhLtWfTiKndI+CB4HPzsDVf7SP
         Qx3A==
X-Gm-Message-State: APjAAAUu2TA65OHkydXvfHl3PFuiv/3Qc2CcRm5/sGso/SzfPETKEww0
        ijTMtB8b0SWehogljlXJlm61jdzl65NG
X-Google-Smtp-Source: APXvYqysQ0+1S2Zh68bWrMa9cSXOxT8i2A4L1slKcj2AH6+yidC45+MzAoc80DTMdNvuNN35jEPpF8qIecZJ
X-Received: by 2002:ac8:244e:: with SMTP id d14mr547186qtd.388.1572448497275;
 Wed, 30 Oct 2019 08:14:57 -0700 (PDT)
Date:   Wed, 30 Oct 2019 15:14:48 +0000
In-Reply-To: <20191030151451.7961-1-qperret@google.com>
Message-Id: <20191030151451.7961-2-qperret@google.com>
Mime-Version: 1.0
References: <20191030151451.7961-1-qperret@google.com>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
Subject: [PATCH v9 1/4] arm64: defconfig: Enable CONFIG_ENERGY_MODEL
From:   Quentin Perret <qperret@google.com>
To:     edubezval@gmail.com, rui.zhang@intel.com, javi.merino@kernel.org,
        viresh.kumar@linaro.org, amit.kachhap@gmail.com, rjw@rjwysocki.net,
        catalin.marinas@arm.com, will@kernel.org, daniel.lezcano@linaro.org
Cc:     dietmar.eggemann@arm.com, ionela.voinescu@arm.com,
        mka@chromium.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, qperret@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The recently introduced Energy Model (EM) framework manages power cost
tables for the CPUs of the system. Its only user right now is the
scheduler, in the context of Energy Aware Scheduling (EAS).

However, the EM framework also offers a generic infrastructure that
could replace subsystem-specific implementations of the same concepts,
as this is the case in the thermal framework.

So, in order to prepare the migration of the thermal subsystem to use
the EM framework, enable it in the default arm64 defconfig, which is the
most commonly used architecture for IPA. This will also compile-in all
of the EAS code, although it won't be enabled by default -- EAS requires
to use the 'schedutil' CPUFreq governor while arm64 defaults to
'performance'.

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index c9a867ac32d4..89b4feced426 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -71,6 +71,7 @@ CONFIG_COMPAT=y
 CONFIG_RANDOMIZE_BASE=y
 CONFIG_HIBERNATION=y
 CONFIG_WQ_POWER_EFFICIENT_DEFAULT=y
+CONFIG_ENERGY_MODEL=y
 CONFIG_ARM_CPUIDLE=y
 CONFIG_ARM_PSCI_CPUIDLE=y
 CONFIG_CPU_FREQ=y
-- 
2.24.0.rc0.303.g954a862665-goog

