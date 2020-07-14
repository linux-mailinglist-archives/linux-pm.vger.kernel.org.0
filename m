Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C906C21F55A
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jul 2020 16:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728418AbgGNOu4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Jul 2020 10:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728300AbgGNOuy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jul 2020 10:50:54 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947BFC061794
        for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2020 07:50:54 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id q5so22194932wru.6
        for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2020 07:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PyDCzRLu9Rp5ffLvCZoaXuGAE+qn3bcIj12X3rgDaY8=;
        b=mPwQpN+Qu91QZ2MKryhuGiiJzJqon/gMYBCzo8EhqXVyHMQU0f+SMVudmHG3byrsFK
         JJYM1icU5EgZZbY6UYqyJwH565d2EsGYC3ePxJSqwzt3Sa2srbEpSqLjlpkYKxWjp1tw
         ujqOlhVyy3Yhl2YAiVxMF+wEXe1nzyw7RUCYva3xlELef2BJOfsvWrUonzTeAAs2K2cl
         +OI1ZY/+TGOGmYtPt09UgSnQS0g97Lw8dAr+PkDKclYLsAo6vPt4dQpPqsTDRb+XCLLN
         +QPntCH68/N596jApxTdK3oGeuqqT+RPWpopbMCXmfq3KHiUYiEjhSsk2tsn5jF4REAr
         5jDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PyDCzRLu9Rp5ffLvCZoaXuGAE+qn3bcIj12X3rgDaY8=;
        b=QsyEyZr2vkEJeMJvcAKkOkm5xzSxopDZJY5n44Cdi8ng+r9YeGX6mpKxNeR4Ib2k/t
         t1/jKjUMCtH2LADfypDUyZRkWTU1AlVXZLV3AZxrZKxg9wbtx7jPCLrBHp046UWlDHJf
         Tjyc2OLEHESUmC8BpL2wt0hLBKP4pRPepWDJPHOg8XnVLDukHwoGyufUmJfB3ABMqECt
         99X2RxBzdAPh8OzEnp9CapZeWra88oLGKK8OAM7AFE10Mp2YUrBccmdvOD5jy1Fl4lyp
         FnFRu80g/bpAvNXm1kXBzF86IbivfwWqmHO3jtUrqA25Xfgd3oJJIEB/WCZmVXVpL8hq
         3Plg==
X-Gm-Message-State: AOAM533cU6R9ZeZ694YNLh62pLa1PPFjc+5pL09CIHycO5eYNnG7u16s
        YZRt67hwG5YNPxS6+PlPEVaJ+Vo0sA8=
X-Google-Smtp-Source: ABdhPJyfB1Tf3EHgK0lx0lDBNPNcHN0//kJ4X5HF1TFk9KcRccYA9FoOD6xF1iEC2VIyddc1Jc7SAA==
X-Received: by 2002:a5d:4c82:: with SMTP id z2mr5923643wrs.287.1594738253227;
        Tue, 14 Jul 2020 07:50:53 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id a84sm4653305wmh.47.2020.07.14.07.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 07:50:52 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Dominik Brodowski <linux@brodo.de>
Subject: [PATCH 01/13] cpufreq: freq_table: Demote obvious misuse of kerneldoc to standard comment blocks
Date:   Tue, 14 Jul 2020 15:50:37 +0100
Message-Id: <20200714145049.2496163-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200714145049.2496163-1-lee.jones@linaro.org>
References: <20200714145049.2496163-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

No attempt has been made to document any of the demoted functions here.

Fixes the following W=1 kernel build warning(s):

 drivers/cpufreq/freq_table.c:229: warning: Function parameter or member 'policy' not described in 'show_available_freqs'
 drivers/cpufreq/freq_table.c:229: warning: Function parameter or member 'buf' not described in 'show_available_freqs'
 drivers/cpufreq/freq_table.c:229: warning: Function parameter or member 'show_boost' not described in 'show_available_freqs'
 drivers/cpufreq/freq_table.c:269: warning: Function parameter or member 'policy' not described in 'scaling_available_frequencies_show'
 drivers/cpufreq/freq_table.c:269: warning: Function parameter or member 'buf' not described in 'scaling_available_frequencies_show'
 drivers/cpufreq/freq_table.c:281: warning: Function parameter or member 'policy' not described in 'scaling_boost_frequencies_show'
 drivers/cpufreq/freq_table.c:281: warning: Function parameter or member 'buf' not described in 'scaling_boost_frequencies_show'

Cc: Dominik Brodowski <linux@brodo.de>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/cpufreq/freq_table.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
index e117b0059123e..f839dc9852c08 100644
--- a/drivers/cpufreq/freq_table.c
+++ b/drivers/cpufreq/freq_table.c
@@ -221,7 +221,7 @@ int cpufreq_frequency_table_get_index(struct cpufreq_policy *policy,
 }
 EXPORT_SYMBOL_GPL(cpufreq_frequency_table_get_index);
 
-/**
+/*
  * show_available_freqs - show available frequencies for the specified CPU
  */
 static ssize_t show_available_freqs(struct cpufreq_policy *policy, char *buf,
@@ -260,7 +260,7 @@ static ssize_t show_available_freqs(struct cpufreq_policy *policy, char *buf,
 struct freq_attr cpufreq_freq_attr_##_name##_freqs =     \
 __ATTR_RO(_name##_frequencies)
 
-/**
+/*
  * show_scaling_available_frequencies - show available normal frequencies for
  * the specified CPU
  */
@@ -272,7 +272,7 @@ static ssize_t scaling_available_frequencies_show(struct cpufreq_policy *policy,
 cpufreq_attr_available_freq(scaling_available);
 EXPORT_SYMBOL_GPL(cpufreq_freq_attr_scaling_available_freqs);
 
-/**
+/*
  * show_available_boost_freqs - show available boost frequencies for
  * the specified CPU
  */
-- 
2.25.1

