Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FAE12C81FE
	for <lists+linux-pm@lfdr.de>; Mon, 30 Nov 2020 11:20:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbgK3KTH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Nov 2020 05:19:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727534AbgK3KTH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Nov 2020 05:19:07 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B26C061A04
        for <linux-pm@vger.kernel.org>; Mon, 30 Nov 2020 02:18:07 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id 3so20446113wmg.4
        for <linux-pm@vger.kernel.org>; Mon, 30 Nov 2020 02:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oNprQPHEZ5bCkTJhMC7KxuMdxZwrsH+cbZUBqg21pEI=;
        b=mA34uqaleLeOt7k18c52QcgFkQ20NkK2TIBEl/YDaxdq4YwAvKjGiz94TdRYzKE/5o
         7S0QoNpeMib4VwTk7bDWL6oVNXsaXHmujN1zYf/AcFo0bvye8jOnaEDKtxS9NEUendat
         rVnYd7yfT+GEPZRLVAcsHd31dk/aSXkmZQCAcH0ow9gbxdX9KKarIf4b7eg+oBB+H4a1
         8y9Jisu02bvmUs8Wi61etSba4RexxjWY1AriQY6xfC4khiVN2dUXkuutsFciZOgeiEwW
         opXA9bOu826Au3RSOWoKLglNongyejvFJC98YjsmljDpe2/vJEOg/1Cm8YOBmIBfq6yr
         sL1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oNprQPHEZ5bCkTJhMC7KxuMdxZwrsH+cbZUBqg21pEI=;
        b=efZkUbJrXGpgt1bi+JzJA7SGluSx1g0fkS7UHw2EDwuSb5D5/Pvm+719BffQb8W5cg
         QTz1g4KqqgTUItDGkp73KYa4WPHC47CjEgvNRWmdQmxicoZskKmaESi4U0n1ubnh4crX
         mk/jJI1akYX1+XmhW9kpfEDm7DsNZLfeyyKDdzsRr5SbhZwVxmMjOvEkBbGlPCjX3oHZ
         bel7BVvYUTVbRMLEMnlhFDJOoLHN0++XTrLkI+uZvIrpU3tKNh98WZmF3FjEDapj9p2c
         GNXwDbZuYZqgi1iD5Elf/CTWqkIv7anFB6tLuBCF8qveSHSe/tRC5Z9jKkShm35ItWOs
         RzfQ==
X-Gm-Message-State: AOAM53350PHPsWyi8xjPXhjDWWF1MSeWfA7QUAPPZUn5PF/KOQZHsQ6+
        nHSy12SNfFQqvoaxnlVulE9MUQ==
X-Google-Smtp-Source: ABdhPJzREwv+NuzCeP++K/eLsEIGSVsBqnNTI6okfCiBdZGVg/qqPZHaUi/MU3netn/wqPEMzZ+msQ==
X-Received: by 2002:a1c:e084:: with SMTP id x126mr3188715wmg.109.1606731486493;
        Mon, 30 Nov 2020 02:18:06 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id c187sm26314234wmd.23.2020.11.30.02.18.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Nov 2020 02:18:05 -0800 (PST)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     kholk11@gmail.com
Cc:     bjorn.andersson@linaro.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        georgi.djakov@linaro.org
Subject: [PATCH 2/2] interconnect: qcom: sdm660: Remove unused macros
Date:   Mon, 30 Nov 2020 12:18:08 +0200
Message-Id: <20201130101808.26472-2-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201130101808.26472-1-georgi.djakov@linaro.org>
References: <20201130101808.26472-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following is observed when compiling with -Wunused-macros:

sdm660.c:43: warning: macro "NOC_PERM_MODE_FIXED" is not used
sdm660.c:44: warning: macro "NOC_PERM_MODE_BYPASS" is not used
sdm660.c:39: warning: macro "NOC_QOS_MODE_LIMITER" is not used

These are not used anywhere in the code, so let's remove them.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/qcom/sdm660.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/interconnect/qcom/sdm660.c b/drivers/interconnect/qcom/sdm660.c
index dbcfc8f15738..bf7e544129c3 100644
--- a/drivers/interconnect/qcom/sdm660.c
+++ b/drivers/interconnect/qcom/sdm660.c
@@ -36,13 +36,9 @@
 
 /* Valid for both NoC and BIMC */
 #define NOC_QOS_MODE_FIXED		0x0
-#define NOC_QOS_MODE_LIMITER		0x1
 #define NOC_QOS_MODE_BYPASS		0x2
 
 /* NoC QoS */
-#define NOC_PERM_MODE_FIXED		1
-#define NOC_PERM_MODE_BYPASS		(1 << NOC_QOS_MODE_BYPASS)
-
 #define NOC_QOS_PRIORITYn_ADDR(n)	(0x8 + (n * 0x1000))
 #define NOC_QOS_PRIORITY_MASK		0xf
 #define NOC_QOS_PRIORITY_P1_SHIFT	0x2
