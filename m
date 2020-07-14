Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8DCB21F567
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jul 2020 16:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728913AbgGNOvU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Jul 2020 10:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728833AbgGNOvI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jul 2020 10:51:08 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F775C08C5E2
        for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2020 07:51:07 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id r12so22119050wrj.13
        for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2020 07:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AqdFH5K7w1Gi1dVNyBHBLmEyEPDpMkPLQqFOgpWKb8k=;
        b=zNeMYDIHJED7se7OqmcmpxTYUyzehCUyRtWunJvcBfdAuICVelAnfmYtw7GuBPUBlc
         d/pXNoafB+fgqXtmn64mKrwZUYXTYjtMFTGUq0m9bhqCqfyPWpUaGr3WxPKCpSVkmTSY
         I+J/jDnePhbC2x0dIJzFW1sMHCnzz6NUnsO3VS0J9KbDeaWvpubida+OLoO33PkJ2MXo
         fmSqLnpptDjn4oQRgS69BQWwUpgKj7EGqA+PEo2vsGs3tVdEl5/gZkixdlC5Ebd2Ss9E
         izf49OWpwU7LNnFdDt3iddBnPoOU9ThybroR8ocRIEK/NwuMVN9KLWb3ziUx09mL/sOu
         q0fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AqdFH5K7w1Gi1dVNyBHBLmEyEPDpMkPLQqFOgpWKb8k=;
        b=iAAzWJ7zuv06YZ5hRyIP0jAD3ZPWnJMq4ProvRY7QIz68ugXCdR2N6L8ulFbCL9LtE
         v0cqMXKblKuzErKvyP5O4dS5I//EF1fW6KAdz3boT5hIeglQHXrwNPcPReLERKPLqBqB
         iE4gI+X6RWushNJyJ1Y+7RGFHyE5+W6JszEJshgYMsJupEgnnWEIPp34UWncNCMn/+pz
         fWRwTbrZz2yQmvbdnw9q7Sq0hlfwAugUq2I6z+OaAQDFyEedL987ksqxs3LezT0mWqOE
         B6laKAl6U/R4eVVEW+/EW1JncDMCPIBH6ZCWU0K6Nroz02WP5XtVXYt9TyEze5YkEd4F
         F68A==
X-Gm-Message-State: AOAM531xj9tnVM2ISz36Z6GWAnDD7jIYgKiwRqn19aI7/IvEtz0OL58v
        qSplwF2tp8rBxxaoCztAKbk4YtpOsTQ=
X-Google-Smtp-Source: ABdhPJz408nOqlOdcCH2rmaB0MOSljVm9QafGiYYQORYvAR+a4nRgn2T/Gr31RWc8hp64O0RPEjK1g==
X-Received: by 2002:a05:6000:1107:: with SMTP id z7mr6077015wrw.355.1594738265886;
        Tue, 14 Jul 2020 07:51:05 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id a84sm4653305wmh.47.2020.07.14.07.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 07:51:05 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Dirk Brandewie <dirk.j.brandewie@intel.com>
Subject: [PATCH 12/13] cpufreq: intel_pstate: Supply struct attribute description for get_aperf_mperf_shift()
Date:   Tue, 14 Jul 2020 15:50:48 +0100
Message-Id: <20200714145049.2496163-13-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200714145049.2496163-1-lee.jones@linaro.org>
References: <20200714145049.2496163-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/cpufreq/intel_pstate.c:293: warning: Function parameter or member 'get_aperf_mperf_shift' not described in 'pstate_funcs'

Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Len Brown <lenb@kernel.org>
Cc: Dirk Brandewie <dirk.j.brandewie@intel.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/cpufreq/intel_pstate.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 44c7b4677675d..f92fc69c87269 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -275,6 +275,8 @@ static struct cpudata **all_cpu_data;
  * @get_min:		Callback to get minimum P state
  * @get_turbo:		Callback to get turbo P state
  * @get_scaling:	Callback to get frequency scaling factor
+ * @get_aperf_mperf_shift: Callback to get the number of clock cycles after
+ *			aperf, merf is incremented
  * @get_val:		Callback to convert P state to actual MSR write value
  * @get_vid:		Callback to get VID data for Atom platforms
  *
-- 
2.25.1

