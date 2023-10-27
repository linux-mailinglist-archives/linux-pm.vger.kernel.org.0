Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26FC57D90A6
	for <lists+linux-pm@lfdr.de>; Fri, 27 Oct 2023 10:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235059AbjJ0IEn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 27 Oct 2023 04:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235125AbjJ0IEd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 27 Oct 2023 04:04:33 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C171BE
        for <linux-pm@vger.kernel.org>; Fri, 27 Oct 2023 01:04:18 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-5079f3f3d7aso2753646e87.1
        for <linux-pm@vger.kernel.org>; Fri, 27 Oct 2023 01:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698393857; x=1698998657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c18WsKqkMLxlFb2kxy1TvqZw0mGllHhrI7E/VCZUkXM=;
        b=q/hXih+d/oCm2aSJa4q02OZKkW1RVmFrLh1IxuBe0NS8MK1lPFBQxs1qnKHV66sqWN
         ZohVFDk9Fy7SxPXr4CgkXE62CTCSwLokru99Ir7CgPg1eppEgeDjmVRGg57qR0t7CdxD
         gVcpsr1HauYsCItYCXmlsbJ7D5H1nEOp/MVFmjfoGGQKOwrZGle4tjNGKkb7R3EQPWAG
         h6re274P+wmBwUOxaZK97BKffAmFeLqeTlGgpC0jjUprR6itqqEUSzSFbCvoCa5aKc5K
         VuUOxt+HOWB/VeTQuNAfW5KqlVvqg8k4ADKMJOpNwkBAfUnW7AQcBE4LQPMAL4jNFqzo
         jGNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698393857; x=1698998657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c18WsKqkMLxlFb2kxy1TvqZw0mGllHhrI7E/VCZUkXM=;
        b=CK/1s7tQze2+yuaTNJxl2kIQfLnCUS174d4wMJCtYU6AEfdF/2Ig25j6xVPH+XRHQ7
         tVqkN4B9pJ36wlYWOF31/IJuR2AeCyBrJSSp0bK2yVz0BtLgfNcus0kJRq9qMUmqlnDk
         I5FUpFOMpv2hks4RYfmutmhGQlrT67alRABZjnjKCcV7JsEt0wrB2f1TYuMJYXbC45mX
         yhalN72v8SmRpF1JaAICzabJKeciEPgoKHpKkaM3hOBReTSiDRyCBXBAuBkHSi7f1Nbg
         QI6fVdZq1jfOL1whyVp4IuIpaORB9BWi2QfmaMyVFxJbFWinUrSO6t2eG35670taovJt
         Dstw==
X-Gm-Message-State: AOJu0YxJMoIyMyX2trOD6iWQ6MZsFPdo79wwY7/Oh5arF1KUKu50GMh1
        khuE4Wj50FBkRk5pIV3E4CA+ug==
X-Google-Smtp-Source: AGHT+IHpcSQk7VGAghux/3WEwWVJDF1pL/epq9owFA/njCZANYAUuDKZLjuGtdumKBq3GHr3rbcd2A==
X-Received: by 2002:a05:6512:3287:b0:500:aed0:cb1b with SMTP id p7-20020a056512328700b00500aed0cb1bmr1288833lfe.24.1698393856230;
        Fri, 27 Oct 2023 01:04:16 -0700 (PDT)
Received: from vingu-book.. ([2a01:e0a:f:6020:c5e:e24e:ad0b:58c6])
        by smtp.gmail.com with ESMTPSA id 17-20020a05600c025100b004083729fc14sm4397488wmj.20.2023.10.27.01.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 01:04:15 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, sudeep.holla@arm.com,
        gregkh@linuxfoundation.org, rafael@kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        viresh.kumar@linaro.org, lenb@kernel.org, robert.moore@intel.com,
        lukasz.luba@arm.com, ionela.voinescu@arm.com,
        pierre.gondois@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        acpica-devel@lists.linuxfoundation.org
Cc:     conor.dooley@microchip.com, suagrfillet@gmail.com,
        ajones@ventanamicro.com, lftan@kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v4 6/7] cpufreq/cppc: set the frequency used for computing the capacity
Date:   Fri, 27 Oct 2023 10:03:59 +0200
Message-Id: <20231027080400.56703-7-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231027080400.56703-1-vincent.guittot@linaro.org>
References: <20231027080400.56703-1-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Save the frequency associated to the performance that has been used when
initializing the capacity of CPUs.
Also, cppc cpufreq driver can register an artificial energy model. In such
case, it needs the frequency for this compute capacity.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 drivers/base/arch_topology.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 9a073c2d2086..d4bef370feb3 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -349,6 +349,7 @@ bool __init topology_parse_cpu_capacity(struct device_node *cpu_node, int cpu)
 
 void topology_init_cpu_capacity_cppc(void)
 {
+	u64 capacity, capacity_scale = 0;
 	struct cppc_perf_caps perf_caps;
 	int cpu;
 
@@ -365,6 +366,10 @@ void topology_init_cpu_capacity_cppc(void)
 		    (perf_caps.highest_perf >= perf_caps.nominal_perf) &&
 		    (perf_caps.highest_perf >= perf_caps.lowest_perf)) {
 			raw_capacity[cpu] = perf_caps.highest_perf;
+			capacity_scale = max_t(u64, capacity_scale, raw_capacity[cpu]);
+
+			per_cpu(capacity_ref_freq, cpu) = cppc_perf_to_khz(&perf_caps, raw_capacity[cpu]);
+
 			pr_debug("cpu_capacity: CPU%d cpu_capacity=%u (raw).\n",
 				 cpu, raw_capacity[cpu]);
 			continue;
@@ -375,7 +380,15 @@ void topology_init_cpu_capacity_cppc(void)
 		goto exit;
 	}
 
-	topology_normalize_cpu_scale();
+	for_each_possible_cpu(cpu) {
+		capacity = raw_capacity[cpu];
+		capacity = div64_u64(capacity << SCHED_CAPACITY_SHIFT,
+				     capacity_scale);
+		topology_set_cpu_scale(cpu, capacity);
+		pr_debug("cpu_capacity: CPU%d cpu_capacity=%lu\n",
+			cpu, topology_get_cpu_scale(cpu));
+	}
+
 	schedule_work(&update_topology_flags_work);
 	pr_debug("cpu_capacity: cpu_capacity initialization done\n");
 
-- 
2.34.1

