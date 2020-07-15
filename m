Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0EF322070B
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jul 2020 10:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgGOI0z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jul 2020 04:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729928AbgGOI0z (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jul 2020 04:26:55 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC9AC08C5C1
        for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2020 01:26:54 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id f139so4680215wmf.5
        for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2020 01:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xDE1zUX/1JKQBQmQqlPliyHfkazrkQ232Ej5nXmiXwM=;
        b=zXIpCOcYgYHp1oI/hNnk7zY9h2vzxnyGom+gI1qtkY9gm2GpNzrjfPEFEUBPJH5UV6
         B6KQaI1nRCVuI+yN6eORsPiXeZ1pz3BSHbCy72HLtafEThX0+RoPRLneZigsJABeab59
         zdzPVLTA85+sxS8iafLaTVvgxWdhYc/5554JhGgByGNiv1rSVi/h1HH0DjGavC9IpM/N
         xhOMe26zXLdwfZOhKkZEvOA9PdP5EnV5oe8Ib/cVIjRGbWpg9829J9rA3vpuOfklOYV8
         spprCi/ti3c2ZogtRgF35Z0LCQrJWosGr7Xz/eHYISvhYS+lP1v8pf+RlvdSSzpCWpaI
         jjiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xDE1zUX/1JKQBQmQqlPliyHfkazrkQ232Ej5nXmiXwM=;
        b=mCIpHHtCgL5iWX0DKPoTjrC+fdeK5LOrVz62YsrdwOUt0v5/A/wBdmMRRXQx0lApFB
         7No9KsuegJ43ietRpqnXhT1/FXGoutXuKG6wZG5qIEjASIoAXrNFIymuADlyKIresJg8
         WhdY5B2ALtJmYt+u4YQVNx40/NdS9+aIYk11JIRcl7GVi5N+CjyvuJeW6j/R6+B6dGcS
         zDC2BaZo/ORaxtDxnYvwcnrI+dhqt44EPAT1SDABo9KtWw0EhkkCiJUwH1/JKHI2roPv
         eCkWtL3OP1cCpCF1GAk1dXyp4y7y+OSq2ytXnB0Q1nIZq86oESOaXcwFbtclHwahef9R
         7tZQ==
X-Gm-Message-State: AOAM533qmW48JrLZ8TaxwiC+00uHFKRYEvFFt5YBIPhp2IbEpsHZ26sv
        wTH/xnd6gruBUL8QE08oeLZYuA==
X-Google-Smtp-Source: ABdhPJwYJSMFUV5PpASoPDrjaYIuPcrg9uZDlscqgtu4rQfld8dFTZRklyYJDtiqeHbOc4WUtFqVFg==
X-Received: by 2002:a1c:18b:: with SMTP id 133mr7513947wmb.178.1594801613334;
        Wed, 15 Jul 2020 01:26:53 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id h13sm2400361wml.42.2020.07.15.01.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 01:26:52 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Dirk Brandewie <dirk.j.brandewie@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v2 12/13] cpufreq: intel_pstate: Supply struct attribute description for get_aperf_mperf_shift()
Date:   Wed, 15 Jul 2020 09:26:33 +0100
Message-Id: <20200715082634.3024816-13-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200715082634.3024816-1-lee.jones@linaro.org>
References: <20200715082634.3024816-1-lee.jones@linaro.org>
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
Suggested-by: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/cpufreq/intel_pstate.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 44c7b4677675d..3960f971fdfb3 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -275,6 +275,8 @@ static struct cpudata **all_cpu_data;
  * @get_min:		Callback to get minimum P state
  * @get_turbo:		Callback to get turbo P state
  * @get_scaling:	Callback to get frequency scaling factor
+ * @get_aperf_mperf_shift: Callback to get the APERF vs MPERF frequency
+ *			   difference
  * @get_val:		Callback to convert P state to actual MSR write value
  * @get_vid:		Callback to get VID data for Atom platforms
  *
-- 
2.25.1

