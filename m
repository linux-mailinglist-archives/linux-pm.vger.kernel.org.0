Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3366F21F55D
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jul 2020 16:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728656AbgGNOvA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Jul 2020 10:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728559AbgGNOu6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jul 2020 10:50:58 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B57B9C08C5DD
        for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2020 07:50:57 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id o11so22218893wrv.9
        for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2020 07:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CMXxo9aOlmaJXA2Fa0TTzO8LQVMEninajvd8D9uCCWE=;
        b=vBZqRin9ErymR0h6YWFtX6OzZP7QsHPxUOwJ1TB67Z1qz2iAYJvnsWx2gcLuhJy4lb
         hDDc4aeOkm27SRzf8X1k2WIAObsAJND5revrzkP/m7ZCMP80546Bxq3T3UndYTS8OzUC
         JRsd6UB7YHbFJbx8g2t1uiz5Y+e8rX83mYC50waDpkpo5tPFH0kwV8nCXZvv/pkzP297
         KtwmqwGgdm6Um5BEKSCxhXmSf67vT0WeoxDQQEouLXVk2MTiwej9lYE4yeXcO2AgZFPY
         1n2hO29e3beuwFoHJWMa6cOWi5ut2YKBxpnhv1OpHJLS9ZZ8+unvn3Q7bOKY5dKnNGed
         ooaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CMXxo9aOlmaJXA2Fa0TTzO8LQVMEninajvd8D9uCCWE=;
        b=pLg73u8ja566ow76J7NuI0MUZyOlwhOINFmBvMzOENEEGGNf+WiYmmicoTn4pi6wSz
         dgXkmpKXzITF+QybhJGNZYNOqj1upv5xbN8RaSwhpfSIf4VBc/L03gwL6GymBNlXfdtN
         ATEf+JLW1c1fugMdJ1tQkZW7QaNbRXQn9MIApkN+Hrke3WurToRTI5hQIQnXWqCFBEBC
         GdU/1fnX6ipMEPAu4/FcZGA4w6XEiEdAFVYH1qTsH844g0Te4jnWIYXA20KonPnvVw7X
         PYtVW6lbrQDgXh3fmNJ0g2/vF/PWJ6UZpby263NbacbX8qULCBbmhcBcLrIKM/Flxg3N
         DHAQ==
X-Gm-Message-State: AOAM532WERj1LbTuPrdOJ+iXjr24vrpnZ+S/y9RO7t4LP+J/l/seHtBA
        zhcJt6NZ1Qh/PJ9QotjhrrWZ8mh1sXk=
X-Google-Smtp-Source: ABdhPJwYqf/NbTXIZQ6P2+Ae9aB7yAhOCiew0QjfGjYt6pXaaft/XHPCaQXykUjtuNfRA79JvHAIRA==
X-Received: by 2002:adf:81c8:: with SMTP id 66mr6172511wra.348.1594738256436;
        Tue, 14 Jul 2020 07:50:56 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id a84sm4653305wmh.47.2020.07.14.07.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 07:50:55 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Patrice Chotard <patrice.chotard@st.com>,
        Pal Singh <ajitpal.singh@st.com>
Subject: [PATCH 04/13] cpufreq: sti-cpufreq: Fix some formatting and misspelling issues
Date:   Tue, 14 Jul 2020 15:50:40 +0100
Message-Id: <20200714145049.2496163-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200714145049.2496163-1-lee.jones@linaro.org>
References: <20200714145049.2496163-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Kerneldoc format for attribute descriptions should be '@.*: '.

Fixes the following W=1 kernel build warning(s):

 drivers/cpufreq/sti-cpufreq.c:49: warning: cannot understand function prototype: 'struct sti_cpufreq_ddata '

Cc: Patrice Chotard <patrice.chotard@st.com>
Cc: Pal Singh <ajitpal.singh@st.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/cpufreq/sti-cpufreq.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/sti-cpufreq.c b/drivers/cpufreq/sti-cpufreq.c
index 8f16bbb164b84..a5ad96d29adca 100644
--- a/drivers/cpufreq/sti-cpufreq.c
+++ b/drivers/cpufreq/sti-cpufreq.c
@@ -40,11 +40,11 @@ enum {
 };
 
 /**
- * ST CPUFreq Driver Data
+ * struct sti_cpufreq_ddata - ST CPUFreq Driver Data
  *
- * @cpu_node		CPU's OF node
- * @syscfg_eng		Engineering Syscon register map
- * @regmap		Syscon register map
+ * @cpu:		CPU's OF node
+ * @syscfg_eng:		Engineering Syscon register map
+ * @syscfg:		Syscon register map
  */
 static struct sti_cpufreq_ddata {
 	struct device *cpu;
-- 
2.25.1

