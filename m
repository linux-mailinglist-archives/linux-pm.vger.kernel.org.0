Return-Path: <linux-pm+bounces-1880-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8206182522C
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jan 2024 11:37:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C29DB25161
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jan 2024 10:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D53D2CCBA;
	Fri,  5 Jan 2024 10:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YXyxACKp"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E6D2D614
	for <linux-pm@vger.kernel.org>; Fri,  5 Jan 2024 10:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d3aa0321b5so10549175ad.2
        for <linux-pm@vger.kernel.org>; Fri, 05 Jan 2024 02:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704450919; x=1705055719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MgkvDd251Anuxsin8lOtI6fY5/rZr3zzcdi1k1L/6pI=;
        b=YXyxACKpT76JW57FcUM7yWvRsktG56leOE/rfxSR9i2fPPCEQbDOfK69aPHv/A388P
         Po+q9AraRBvD20gWVJmDAggHEtmZbW6GPDbEuQ6tjEU7opPo69DiOnoikG/79HpitTji
         zNsYEbNjUv6vY14pKgp6xKAPRbozA2MwspZznKpCspfdobAQ5+08qaoBwN1sbCNd3Kmr
         X1y8sm7D67SUaIVqng9dz+9YhCoruZfwKbQVxL36yStkDbkmgdlc8LMI9N9YHZ+NbGK/
         IcDoirC1CDpZ/dPv4vzHhdy6iT5d4lcDj6MpwQqdopsyezBDmDilgvLGt02Je+mN7qMp
         rq/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704450919; x=1705055719;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MgkvDd251Anuxsin8lOtI6fY5/rZr3zzcdi1k1L/6pI=;
        b=q47fCznSz+8T0tcqPM33XQbZAMpH6XmIOoixkUa4Cpvc5FHrJCp3ovdTmWJEPHRNYU
         KfGfeOSXSO9sHxMYlJi8fc/e4Z82KbBOHZC0eeqzcofVKuW1JXLiWEmL8xBVzMt++dFr
         wtAN3nu6R67Cf8fHXX0k0zx4avDIwtvZnXCWHTMtar0P5FR1hBd78JEPWu3N/AFE7wnb
         xtHCZ2u1oZqNOjzauLE8hSZMOhIkRwQbXNo4Uadk2hBXYDKPkXyGMbk3WsNtp3lQQ3JC
         vMlc3E9TlI2bwk6Wvt4eFNRxc3luMdy9gWnPRBpHCD0CqTFKOqWar2/Ytq8NUQ9mJANy
         74zw==
X-Gm-Message-State: AOJu0YwhC4blG4prYj5Swrn5cmNjQ9A2BJW+kcXwQAY/+qgfMwYJCr5Z
	r73BhK0IQxF/SkUgcA8ck2mZmYwgN43GAg==
X-Google-Smtp-Source: AGHT+IFsqfvz+55gSqZByNWxCCxnVEXLHi/buhhMRlmkjkHR9zjRw81loEDkUa/+0E1hvOxCaVxVOg==
X-Received: by 2002:a17:902:e747:b0:1d4:dec9:f0a6 with SMTP id p7-20020a170902e74700b001d4dec9f0a6mr2310239plf.30.1704450919337;
        Fri, 05 Jan 2024 02:35:19 -0800 (PST)
Received: from localhost ([122.172.86.168])
        by smtp.gmail.com with ESMTPSA id jf9-20020a170903268900b001d4910ff83dsm1084704plb.121.2024.01.05.02.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 02:35:18 -0800 (PST)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] OPP: Rename 'rate_clk_single'
Date: Fri,  5 Jan 2024 16:05:13 +0530
Message-Id: <dcfec12b67980cba139a6c3afba57ebd4936ebe8.1704450910.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The field's name isn't clear enough. Rename it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 4 ++--
 drivers/opp/opp.h  | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 5e6cfcbd2e87..c4e0432ae42a 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -963,7 +963,7 @@ _opp_config_clk_single(struct device *dev, struct opp_table *opp_table,
 		dev_err(dev, "%s: failed to set clock rate: %d\n", __func__,
 			ret);
 	} else {
-		opp_table->rate_clk_single = freq;
+		opp_table->current_rate_single_clk = freq;
 	}
 
 	return ret;
@@ -1352,7 +1352,7 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 		 * value of the frequency. In such a case, do not abort but
 		 * configure the hardware to the desired frequency forcefully.
 		 */
-		forced = opp_table->rate_clk_single != freq;
+		forced = opp_table->current_rate_single_clk != freq;
 	}
 
 	ret = _set_opp(dev, opp_table, opp, &freq, forced);
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index 558c9ac6a6fa..cff1fabd1ae3 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -170,7 +170,7 @@ enum opp_table_access {
  * @clock_latency_ns_max: Max clock latency in nanoseconds.
  * @parsed_static_opps: Count of devices for which OPPs are initialized from DT.
  * @shared_opp: OPP is shared between multiple devices.
- * @rate_clk_single: Currently configured frequency for single clk.
+ * @current_rate_single_clk: Currently configured frequency for single clk.
  * @current_opp: Currently configured OPP for the table.
  * @suspend_opp: Pointer to OPP to be used during device suspend.
  * @required_opp_tables: List of device OPP tables that are required by OPPs in
@@ -219,7 +219,7 @@ struct opp_table {
 
 	unsigned int parsed_static_opps;
 	enum opp_table_access shared_opp;
-	unsigned long rate_clk_single;
+	unsigned long current_rate_single_clk;
 	struct dev_pm_opp *current_opp;
 	struct dev_pm_opp *suspend_opp;
 
-- 
2.31.1.272.g89b43f80a514


