Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 367E8975AA
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2019 11:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbfHUJIj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Aug 2019 05:08:39 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36804 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727037AbfHUJIj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Aug 2019 05:08:39 -0400
Received: by mail-pf1-f194.google.com with SMTP id w2so1025935pfi.3
        for <linux-pm@vger.kernel.org>; Wed, 21 Aug 2019 02:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=EpNyefDvziRpVKagmeTe6/DY7qk9smhH+f//3Sqbad0=;
        b=dQsp2Dw2bertAm4zumWxD9PMW6WBKigYQx9sgBL6jxtTVSIeEX98WKxQ4hPjNdkb2N
         CbtwwheE9joXr/a2e/xg0CdTt5ZlfsecT3J+FeeXP2a6QonRnp4J1RMPMrjm8ZSPLeHh
         nYeuIctAUIbJEK3C1IXTrvE+IyNiEAiY0AjVPHcIWeSpUKLfCv2NlRGsdRLxl3myZHeu
         qT65RPXcM+C+1ne4IF0+faAgxnpLc4zVbjnlvsQOSlY99IiFSSYFwbJjnelaFdISbU8s
         gzaIljkMD/hnJGPTEuJouI835NBnLV+7WXsfuNgZAPd8OFpJILPEVTCiQLazw19YNpPB
         S49Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=EpNyefDvziRpVKagmeTe6/DY7qk9smhH+f//3Sqbad0=;
        b=kPxJNr49XEjW/EyMxo15ZEcG5pGdzKQ1alsES1Dw1tJ/9QIN1VnXkePF9O+zyBZusR
         Olr8lnM+Ygaa1GojJR2/sAgabtA2VvrlNAGf/4LFoAz2KSaxh95lerw6iyd3ZfLlTA/L
         s8sRChSuSic4jkJk2UeNNdCY95cyEDGTGFrL8OcfccBRnmgy4GGV3ocbyTHS8ZA+KP4q
         EmLEea04L3cMoX4rVXToCuWfVFKY7r29H9V72oKzL1HWsV3y46oXqWXfKq1exwOA7Rn8
         e04ugqNqejYaZxcrvCA0UaaNZdo+HnG+WLA98WsTyvOtJealVxN34W+zTqGnJL8Avv4t
         soow==
X-Gm-Message-State: APjAAAXmpyEaBThzbHdt62/fDdhZGTj5aiatafMITnGEHObbYw7dw9z/
        cM+H1NZE5b0zLM3Nmsp5klJXFe+Ls8j71Q==
X-Google-Smtp-Source: APXvYqyKArjR2xo71GWtZw1TUowFuYt0l6yVGhFp4LeYfdoCxutYVSWM6jVKK2L6RPGuOF5l6U4+1g==
X-Received: by 2002:aa7:8602:: with SMTP id p2mr34278306pfn.138.1566378518653;
        Wed, 21 Aug 2019 02:08:38 -0700 (PDT)
Received: from localhost ([114.143.126.83])
        by smtp.gmail.com with ESMTPSA id x128sm39525090pfd.52.2019.08.21.02.08.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Aug 2019 02:08:37 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, edubezval@gmail.com,
        daniel.lezcano@linaro.org, rui.zhang@intel.com,
        linux-pm@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Add Amit Kucheria as reviewer for thermal
Date:   Wed, 21 Aug 2019 14:38:31 +0530
Message-Id: <dc11c8ac0892ac14f4fe66ed5336bf32d26e27c9.1566377984.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1566377984.git.amit.kucheria@linaro.org>
References: <cover.1566377984.git.amit.kucheria@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add Amit Kucheria as the reviewer for thermal as he would like to
participate in the review process effort for the thermal framework.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
Hi thermal maintainers, I'd like to help out with reviewing patches to the
thermal framework. I respectfully submit this patch for you to consider
adding me to the MAINTAINERS file as a reviewer so I get cc'ed on the
patches.

 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e81e60bd7c26..75c510270eb2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15896,6 +15896,7 @@ THERMAL
 M:	Zhang Rui <rui.zhang@intel.com>
 M:	Eduardo Valentin <edubezval@gmail.com>
 R:	Daniel Lezcano <daniel.lezcano@linaro.org>
+R:	Amit Kucheria <amit.kucheria@verdurent.com>
 L:	linux-pm@vger.kernel.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux.git
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal.git
-- 
2.17.1

