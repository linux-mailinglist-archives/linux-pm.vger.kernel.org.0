Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8C4399DEA
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jun 2021 11:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbhFCJhr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 3 Jun 2021 05:37:47 -0400
Received: from mail-lj1-f169.google.com ([209.85.208.169]:46060 "EHLO
        mail-lj1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbhFCJhr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 3 Jun 2021 05:37:47 -0400
Received: by mail-lj1-f169.google.com with SMTP id m3so6251689lji.12
        for <linux-pm@vger.kernel.org>; Thu, 03 Jun 2021 02:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lFoDekDYb/UgHdylIZARPBsEDFKjhn6BdLJDbtckeQE=;
        b=JwdfSDzJpLBesUo4+88/C3oqVb/3B86q53A6DEJr2ZBkKnyTIRPbDaSACI/sePRLIp
         gwg+b6LjuKTGQI/vxI2t9qZrQtdgJTaGhkMl02vSnx+QbSvvdaZn44F72bqAfLFY6wKo
         GFxgoPbOcNT8sJJd690+WTKApuI3sWs1NsKPt/HEqrPCJVmGrpfh46PaEp3eGZOKLN0d
         b5n3chr1U+LbMeJHTigal0Oc7hYVdmo6DwpAH4gkrBdIW0jBgiLFgDDFbvmn8K9uw+Pl
         uYkXHmfMTdXpFwK8IDnr68gi50LJ8pMRtBuotoQZo9dZ1lQPDJi8ldsN8OZLe6ay0DQy
         klnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lFoDekDYb/UgHdylIZARPBsEDFKjhn6BdLJDbtckeQE=;
        b=o3RrcYqPcV6KVPizZIgN/4o24dMwwfWgrpgxo0FSGRsdyqewRcztVt/5LZw4NvCY48
         1NMdODQ91OgPdeEfMCAAHCj5a28DxymwqiiUHl2iSCustXUX4xEkLO4tdZc4GwGv2YJW
         uJ21r+kyKHwjmxyA/1GhnpLP5RuHGqF/SvuWuhyldtxA+d7r7b02ZpCu9sRDFxid3LIy
         NbiG75DEXddH+5pAkIGaJB4qFYS9MMCFhKmd+YiJeHxwr2dCWmhlcbh+V3wK5uAczzsh
         3xilHbXcrBDhbZ6OtqnbIV9/5rRVS+r5VYP9Ltm6LMJboXO+W7uGJNzRRzFLq0bs9sz8
         6mxg==
X-Gm-Message-State: AOAM531VdkDsZN3Ed2NHPo3+MhbCjPbnEDbz5qQlDtwZjZj9tx7dd7Mu
        EBVir/q0FF5E+odBeq3AvlQJhA==
X-Google-Smtp-Source: ABdhPJwg8KCHV0Hm4Ebc/CXC0Dea/8+lkoKKVArxsAIppRYHAbwPcXW5vLK4PJ8lxuaB3Ecfq3EHaA==
X-Received: by 2002:a2e:a594:: with SMTP id m20mr29675302ljp.114.1622712888689;
        Thu, 03 Jun 2021 02:34:48 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-129-146.NA.cust.bahnhof.se. [155.4.129.146])
        by smtp.gmail.com with ESMTPSA id q4sm263373lfc.172.2021.06.03.02.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 02:34:47 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Roja Rani Yarubandi <rojay@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] PM: domains: Return early if perf state is already set for the device
Date:   Thu,  3 Jun 2021 11:34:36 +0200
Message-Id: <20210603093438.138705-3-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210603093438.138705-1-ulf.hansson@linaro.org>
References: <20210603093438.138705-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When dev_pm_genpd_set_performance_state() gets called to set a new
performance state for the device, let's take a quicker path by doing an
early return, if it turns out that the new state is already set for the
device.

Suggested-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v2:
	- New patch.

---
 drivers/base/power/domain.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 5c476ed1c6c9..ef25a5b18587 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -387,6 +387,9 @@ static int genpd_set_performance_state(struct device *dev, unsigned int state)
 	int ret;
 
 	prev_state = gpd_data->performance_state;
+	if (prev_state == state)
+		return 0;
+
 	gpd_data->performance_state = state;
 	state = _genpd_reeval_performance_state(genpd, state);
 
-- 
2.25.1

