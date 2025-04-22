Return-Path: <linux-pm+bounces-25886-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7311A96521
	for <lists+linux-pm@lfdr.de>; Tue, 22 Apr 2025 11:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA40D17B2BF
	for <lists+linux-pm@lfdr.de>; Tue, 22 Apr 2025 09:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38408214A7F;
	Tue, 22 Apr 2025 09:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OR7w5rkM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22142147E6
	for <linux-pm@vger.kernel.org>; Tue, 22 Apr 2025 09:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745315654; cv=none; b=WmSOCRnhqS3XPp5soHH1O847hISyPVasbUu2UPbkRNQ6cg2XIKp3qV+U0mrC1E99jmrCdzNoGskNMCIGNMlq/I4NlbVaSORZ+02JdXeSll4k93fl96rSh6rhW+lB0J67KLFiK7XCMNIv6nNbq9E8haN9sqTHtbZJkHblGqYirPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745315654; c=relaxed/simple;
	bh=eyplrmpjKFTUa1W5e9N6rta3lu/Fv+NYAacdGEUT+Oo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cxpwNSZ8LoRzmO2O1ao7cJdIH30dMyeO62BSPgiXUr4WI9poURXibuxdBde1xfjA0p80d/9aI/aZm4BVqc3lAX5lJhOCaERRChzkHfgnZxeDcokzN0bNFDRjW4/FeakZVDPjY4HjvwZkMLGPxDbOC8siO3szGmOvHr7llPUZQDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OR7w5rkM; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22c3407a87aso73012935ad.3
        for <linux-pm@vger.kernel.org>; Tue, 22 Apr 2025 02:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745315651; x=1745920451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8abPOzFQPY6uZ841DkjOq7rR24N5GWsR8imwcJtx7Uk=;
        b=OR7w5rkM6Abf8NVSwca/9JCEU18uf3LmpX7M5NXLhCnFolnFWA8uy4ydQf+nFV8b7v
         Sz8ckJU1Rhf1dDiCRTI5AmaicaUBERNEJfbcxIf7/UOhCkEV2Z7FCnUA6LEojK9rEn3A
         izyXn/jeTx7Q9JiqyM/9N87C9hp4j05hyyz6j/0bclOdvWy280+dXypOiHltuNd3viq4
         ePqm4OQgR2srZSzONmAWtnUV0rWdVEpI1gx3KjaPcv+ELvL0V/sO1DLbWH8NP7zuDfHO
         mDthE1oly5GYP4vBjnBB6la8GHt66oMjuhm6ldDmmYscfzYwcIAc0rLWDc5ZGALzr0u3
         dCig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745315651; x=1745920451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8abPOzFQPY6uZ841DkjOq7rR24N5GWsR8imwcJtx7Uk=;
        b=FKtti3+yuR3AaFFVL4m+7N1TzrbkbvIi7CFJ520I+UMURgp5R+KXvnk+h0Y465GGFz
         2r3TSC1y2jlikjKrRTuXX7Hai7Gj051fNV2tCjjAkhuExe638gRX9guLRZ4FNvumH6JF
         CEY6HeVf7dG1lm7V5uHWMlP5dalYsTOpS6nozHclQE8ILcMdS5P058Hb9vF2Rgc9mFmS
         nYDF3R7/56wK9R7FSIj7cVCWMKvQt5v1icN9xV3inBfuAvvUx+KUIHOOCsJbJzVkFW5d
         lB4BtJygA+Kkv8+cYAQ6TZ89qve6piLxNfuygACelw020AoNF4Vx6Ao98+PvnVZqGF43
         he9w==
X-Gm-Message-State: AOJu0YyZCLc8eeMVSPthKM9N5sO76Y0ebqp3SUpDfBM1fN1XA0+rkpEA
	Oe0u5tEsdkH+VgWYRHm/3c7Smei6y8w5DrqVfQvVLTt5mEPoFf7b1vWnvgIj5Js=
X-Gm-Gg: ASbGnct9Elh5BaT5TK91E9he8rONNJBhCDB9MTbJV3/O0uyzUEGwL3iBN0o3y4JXRpc
	ARDc6k77pGFelQJBNIb1A9DB/tNxOVqUsKmoORTJeSlLqnWwoT1bBzNWop8rr78+bb5/XuGzJbz
	vRe/Bb3er3HW8UlJfCmeBCp+D4zoQEcWMcI9U718UJdJyvmBJHcHxS+UcdRqcbhxkTr4D0rrcli
	Nvu56rLLay2mOOezOuJzElCMv/SX3n/81mGjNAwKwYCnvkNBMHlNnp0+9t2vZwcjvBWjrUbv78s
	f/NSEdxH8jOn8RLRcAzzDUE33uVtxDNiYrTxiHuGCA==
X-Google-Smtp-Source: AGHT+IEmg8Z6gimIDf9VigivlpBZ67Mu4d5PLElT55+RwEMc1P1qEQb5nY9a+EPjX0zXw8UepdGUvw==
X-Received: by 2002:a17:902:e806:b0:229:1cef:4c83 with SMTP id d9443c01a7336-22c5356797emr251125215ad.4.1745315651107;
        Tue, 22 Apr 2025 02:54:11 -0700 (PDT)
Received: from localhost ([122.172.83.32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50bf5549sm80701565ad.94.2025.04.22.02.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 02:54:10 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Lifeng Zheng <zhenglifeng1@huawei.com>
Cc: linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Nicholas Chin <nic.c3.14@gmail.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] cpufreq: acpi: Re-sync CPU boost state on system resume
Date: Tue, 22 Apr 2025 15:23:52 +0530
Message-Id: <d8651db6d8687a0e37d527267ebfec05f209b1b7.1745315548.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1745315548.git.viresh.kumar@linaro.org>
References: <cover.1745315548.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

During suspend/resume cycles, platform firmware may alter the CPU boost
state.

If boost is disabled before suspend, it correctly remains off after
resume. However, if firmware re-enables boost during suspend, the system
may resume with boost frequencies enabled—even when the boost flag was
originally disabled. This violates expected behavior.

Ensure the boost state is re-synchronized with the kernel policy during
system resume to maintain consistency.

Fixes: 2b16c631832d ("cpufreq: ACPI: Remove set_boost in acpi_cpufreq_cpu_init()")
Reported-by: Nicholas Chin <nic.c3.14@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220013
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/acpi-cpufreq.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index 7002e8de8098..0ffabf740ff5 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -893,8 +893,19 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	if (perf->states[0].core_frequency * 1000 != freq_table[0].frequency)
 		pr_warn(FW_WARN "P-state 0 is not max freq\n");
 
-	if (acpi_cpufreq_driver.set_boost)
-		policy->boost_supported = true;
+	if (acpi_cpufreq_driver.set_boost) {
+		if (policy->boost_supported) {
+			/*
+			 * The firmware may have altered boost state while the
+			 * CPU was offline (for example during a suspend-resume
+			 * cycle).
+			 */
+			if (policy->boost_enabled != boost_state(cpu))
+				set_boost(policy, policy->boost_enabled);
+		} else {
+			policy->boost_supported = true;
+		}
+	}
 
 	return result;
 
-- 
2.31.1.272.g89b43f80a514


