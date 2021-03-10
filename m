Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 832173334DB
	for <lists+linux-pm@lfdr.de>; Wed, 10 Mar 2021 06:24:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbhCJFYH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Mar 2021 00:24:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbhCJFXu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Mar 2021 00:23:50 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C09C061760
        for <linux-pm@vger.kernel.org>; Tue,  9 Mar 2021 21:23:50 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id q6-20020a17090a4306b02900c42a012202so6829258pjg.5
        for <linux-pm@vger.kernel.org>; Tue, 09 Mar 2021 21:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w6wCPUb8jc+iccj9hgb1LHjwvC5J45cqXfco5MhHDUE=;
        b=GcDUVEmOuOLJi1qjvT3xY70Q/VduglDQg/3OhVeOvPvJ9qfFdveFwVIIfQjIT/XdBW
         tM9lMLOWZDnsVZvmUUx9+A6PgmSp3B7LdL4z6GqjsUcM4UBcdeL8q1Tl0/2gEUoemmG4
         ECwBW+gzKTcWu4h17TLRON6jDRvwVTmkEB3NmVxBxq986TvJFpebyjMs7PisM1mtablQ
         y1TSdRSZ2m9URtC8qbht97oXOdmfmNwma0+CC0moeRV6dRc0rXpcJSogODML5hwMfW4j
         l9WayPudva/pFfzQlUf563yEkNeBgSjUn0+TcsKy/liKV6Z11cYKRAMT2KtqhdtjFM5J
         rojQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w6wCPUb8jc+iccj9hgb1LHjwvC5J45cqXfco5MhHDUE=;
        b=TPcQigxBi7flNtqRmmLUwfIH/0UO5vM5bUSwc/HtqaHQLPPwVWWVcmsobsk37MwMpT
         zGJf91GDiv82xnpSpJKjimhUlu5o3O5knug7lwyg7J9npuFaKzclWJGVFob1iRC82AyS
         XAa7FbjpJ7LkKFT8qqLZeBkawdy8B4w0wf0Dsigkbx0Wy+ylArlyQd5S2x++S4ggpvv0
         mDwU5ojmc4f6OcElIjy8wBP3eg2Kms3LgfTzLrb15hagtAluQhr3C7Q80fA394ihKKa7
         6XaiwlRw4ebxSoZbJl4hi70H9iZX7F0kFf2WxbXmySbklMnoY9gclN2o9sYAZfM0FGFC
         b33A==
X-Gm-Message-State: AOAM532zFg5RnQfcEhYuh/kcmcvKYnllQbw7kMlXY5W7RKX39HNDsQpm
        1YbQhQGmyDlNlZbuODn3pO7GNg==
X-Google-Smtp-Source: ABdhPJyCu/IJBazpcBzfHCKv5XISNe2XsVhsyMt7Keo6wwEF75q/J2xoclJuEMx1afLBb9iq7pplCg==
X-Received: by 2002:a17:90a:d78e:: with SMTP id z14mr1644954pju.221.1615353829821;
        Tue, 09 Mar 2021 21:23:49 -0800 (PST)
Received: from localhost ([122.171.124.15])
        by smtp.gmail.com with ESMTPSA id z9sm8755996pgs.32.2021.03.09.21.23.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Mar 2021 21:23:49 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V6 3/4] arch_topology: Export arch_freq_scale and helpers
Date:   Wed, 10 Mar 2021 10:53:25 +0530
Message-Id: <1b5c83549720da480b1e23e542f44b1edb2e4157.1615351622.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <cover.1615351622.git.viresh.kumar@linaro.org>
References: <cover.1615351622.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

It is possible now for other parts of the kernel to provide their own
implementation of sched_freq_tick() and they can very well be modules
themselves (like CPPC cpufreq driver, which is going to use these in a
later commit).

Export arch_freq_scale and topology_{set|clear}_scale_freq_source().

Reviewed-by: Ionela Voinescu <ionela.voinescu@arm.com>
Tested-by: Ionela Voinescu <ionela.voinescu@arm.com>
Tested-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/arch_topology.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index ebcd2ea3091f..995e52b9eca4 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -78,6 +78,7 @@ void topology_set_scale_freq_source(struct scale_freq_data *data,
 
 	update_scale_freq_invariant(true);
 }
+EXPORT_SYMBOL_GPL(topology_set_scale_freq_source);
 
 void topology_clear_scale_freq_source(enum scale_freq_source source,
 				      const struct cpumask *cpus)
@@ -96,6 +97,7 @@ void topology_clear_scale_freq_source(enum scale_freq_source source,
 
 	update_scale_freq_invariant(false);
 }
+EXPORT_SYMBOL_GPL(topology_clear_scale_freq_source);
 
 void topology_scale_freq_tick(void)
 {
@@ -106,6 +108,7 @@ void topology_scale_freq_tick(void)
 }
 
 DEFINE_PER_CPU(unsigned long, arch_freq_scale) = SCHED_CAPACITY_SCALE;
+EXPORT_SYMBOL_GPL(arch_freq_scale);
 
 void topology_set_freq_scale(const struct cpumask *cpus, unsigned long cur_freq,
 			     unsigned long max_freq)
-- 
2.25.0.rc1.19.g042ed3e048af

