Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5DA82DF88F
	for <lists+linux-pm@lfdr.de>; Mon, 21 Dec 2020 06:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbgLUFOK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Dec 2020 00:14:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727340AbgLUFOJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Dec 2020 00:14:09 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE50C0613D3;
        Sun, 20 Dec 2020 21:13:29 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id x22so8712516wmc.5;
        Sun, 20 Dec 2020 21:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=lLDJBIJ2YYNuh2CnTnkqFja+9uBc8NH5OZ465zjG1e0=;
        b=kPNDbFnpD7iBvL8GXzD68h40CmDNoKVu8BoXOP80o6fMKA/DKJvljX7bNE9nq9da0o
         gNWuBK0whcPuN26S4JlpDQUslAw5VTRF3bwqqLA7tqfj/NLaFncpkUjQunj/lETzyLT6
         VgfkWOYLDBFuviCrmoMu7VYQLaJ8guzVe+NaiD7j5xSNrLar0EmgnKDNfANz7x8J01AI
         ef4FZBmwnZGS3XbfyetlnY1H7bq5qyvrpAe2641+rJKevlco5V4JqzGoJuXA72XClgJR
         0yVTaW/GgMBV59+5IIg/xDZ26mVo29onoMDgDNAf70xHZ3WdWnEiudAc7feObqq4IrBB
         FyUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lLDJBIJ2YYNuh2CnTnkqFja+9uBc8NH5OZ465zjG1e0=;
        b=IxH3oKEExiKzolG3f43pSqpPwdrWnC9urw3PSV/H3aaFMVFmFlTwIUYA6PeXayzmrL
         Fx4Hr5QsFOF5NBPVQhyWTfnbbUUUNPUmlbF2azSBsHw8N1RBadMqzx2IR7uiN0W4HADt
         iwClh56F2lLySfTlr8SE4eJ5VVrfhpuEDCNvSPMQ/ANA1YhJBnUK7SFKZQl9h5d32eF4
         A8yNG9u39/FSFpaFVja4DTKex7XZJbX3HB3KD1UFfJ0yuoIxnutuQ7Cz4kRFGhG/FB44
         fo0TP2JW0IUVIlTQUfiU9Vw1idEB7ABFkTmUqZAjhTEkglGqaO6lnyxP/2sIHtKJPH8P
         PcAA==
X-Gm-Message-State: AOAM533UUFgjX3YmA6VAgdUsusfWCQLxA/5jsP6PUgExjhArAG5jF/BC
        k5V5b5jF4FvLmR5lNelyZNA=
X-Google-Smtp-Source: ABdhPJxilLxWAa1GB0cvaXvue0KuVY/Q1aXIWqgyYMiKucCJaNaWS7R/N3pkOeVwn/QfOzZBDCJiIg==
X-Received: by 2002:a7b:cb54:: with SMTP id v20mr8483618wmj.148.1608527608118;
        Sun, 20 Dec 2020 21:13:28 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2dcc:3600:8456:e09e:aa48:2c57])
        by smtp.gmail.com with ESMTPSA id p8sm21341535wru.50.2020.12.20.21.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Dec 2020 21:13:27 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Tom Rix <trix@redhat.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] cpufreq: intel_pstate: remove obsolete functions
Date:   Mon, 21 Dec 2020 06:13:20 +0100
Message-Id: <20201221051320.18391-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

percent_fp() was used in intel_pstate_pid_reset(), which was removed in
commit 9d0ef7af1f2d ("cpufreq: intel_pstate: Do not use PID-based P-state
selection") and hence, percent_fp() is unused since then.

percent_ext_fp() was last used in intel_pstate_update_perf_limits(), which
was refactored in commit 1a4fe38add8b ("cpufreq: intel_pstate: Remove
max/min fractions to limit performance"), and hence, percent_ext_fp() is
unused since then.

make CC=clang W=1 points us those unused functions:

drivers/cpufreq/intel_pstate.c:79:23: warning: unused function 'percent_fp' [-Wunused-function]
static inline int32_t percent_fp(int percent)
                      ^

drivers/cpufreq/intel_pstate.c:94:23: warning: unused function 'percent_ext_fp' [-Wunused-function]
static inline int32_t percent_ext_fp(int percent)
                      ^

Remove those obsolete functions.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
applies cleanly on current master and next-20201221

Srinivas, Len, Rafael, Viresh, please pick this minor non-urgent cleanup patch.

 drivers/cpufreq/intel_pstate.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 2a4db856222f..0e35dd247986 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -76,11 +76,6 @@ static inline int ceiling_fp(int32_t x)
 	return ret;
 }
 
-static inline int32_t percent_fp(int percent)
-{
-	return div_fp(percent, 100);
-}
-
 static inline u64 mul_ext_fp(u64 x, u64 y)
 {
 	return (x * y) >> EXT_FRAC_BITS;
@@ -91,11 +86,6 @@ static inline u64 div_ext_fp(u64 x, u64 y)
 	return div64_u64(x << EXT_FRAC_BITS, y);
 }
 
-static inline int32_t percent_ext_fp(int percent)
-{
-	return div_ext_fp(percent, 100);
-}
-
 /**
  * struct sample -	Store performance sample
  * @core_avg_perf:	Ratio of APERF/MPERF which is the actual average
-- 
2.17.1

