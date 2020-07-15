Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33D6D220703
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jul 2020 10:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729860AbgGOI0m (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jul 2020 04:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729857AbgGOI0l (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jul 2020 04:26:41 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A7EC061755
        for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2020 01:26:40 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id s10so1418888wrw.12
        for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2020 01:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1LJ0wihOBVHPIGemJGX58TPrv3uF5xWaa7cKhOONWPg=;
        b=ljxiYm+vN9KkU8J2YlA1xo2jW+OJL7zYylIepuzU7NoryNA4YAXH7bYPteN60yXtEn
         hfSFIN/cOX7tEUohsIXs0F/GgCd3GKKtuthbueKyvrI1U/lxQEF4VvR8A2tjQyvXbR2R
         VeSPnORSvMphuW5BfwzDDB5TIOmffT1Kk0oGb8oZbmBbVIvPtfWh6RXPfPZnfdrGylZs
         9b2iHT6/rWMNnkB9bbJbfe35FsmMQ5d1t09jupstSL7KFJx1lmivT8f3uPRgmmxso48w
         ATJ17hH8EV/Bpj6CFqYI2jgsmsxIlQy3Swwqkz4YM03QiYDyBspOyHnFL7VuYHDX83cp
         f2pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1LJ0wihOBVHPIGemJGX58TPrv3uF5xWaa7cKhOONWPg=;
        b=hWrRPnWnOVNfGMOb1UkEtWmTDjKF4WmISrFGR/xpjxmlw7Td9thTpqO2qWwiwNYLl2
         CFATYhJMJhqR0eKZqheGyY7cBEc5ndmrDGBQOM+NWlie9hTCy00Znw+xLRsAqdpEO9Sn
         XSkJqpP/0j7vV0YKO9hTngX4UH/z62FHM2Y2c/JB9mC99udiYNucMH7xL9K88J94OB4h
         I9BSLQ5jCUWYk/FbgbV4bZjfAYsYFGtRoss8qJImurtpWSdeNuMt4FGOwQIhbg6vSgRJ
         mejfGP+XhEJ+03GisTkR6FQPwE+X6QQlBtCCVkh4CzziG+Mq521YsQ6U2ZZkM5B6XRPn
         3aSw==
X-Gm-Message-State: AOAM5317CJgVEoNfDhU2dnC8dgvdlgk+MywCBMY8CrLO4vZLdfHnVNw4
        ak/UaphoKwlObRtnNDk+MsOxvg==
X-Google-Smtp-Source: ABdhPJzcOOGWhEpLdUwy55/6zbutR/7JAw/U/qyLamUdWJ+qquIDGdIzfYQX+nQnfGZXlKDRzrkowQ==
X-Received: by 2002:a5d:698e:: with SMTP id g14mr10754265wru.301.1594801599673;
        Wed, 15 Jul 2020 01:26:39 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id h13sm2400361wml.42.2020.07.15.01.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 01:26:38 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Dominik Brodowski <linux@brodo.de>
Subject: [PATCH v2 01/13] cpufreq: freq_table: Demote obvious misuse of kerneldoc to standard comment blocks
Date:   Wed, 15 Jul 2020 09:26:22 +0100
Message-Id: <20200715082634.3024816-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200715082634.3024816-1-lee.jones@linaro.org>
References: <20200715082634.3024816-1-lee.jones@linaro.org>
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
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
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

