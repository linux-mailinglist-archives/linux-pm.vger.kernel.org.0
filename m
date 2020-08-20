Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5318E24B6FB
	for <lists+linux-pm@lfdr.de>; Thu, 20 Aug 2020 12:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731423AbgHTKpo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Aug 2020 06:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731914AbgHTKo4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Aug 2020 06:44:56 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD48C061344
        for <linux-pm@vger.kernel.org>; Thu, 20 Aug 2020 03:44:39 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id d19so926920pgl.10
        for <linux-pm@vger.kernel.org>; Thu, 20 Aug 2020 03:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=haHH6xEEDXJD3ODlka0BS0C5wOsHmEx6Ewo0XdB15Uc=;
        b=vU9PtiBP/HMww5OYiXpQ2L/p3G067TEgmGB7o6dGutqO8yILjlrEn53ex/u3faTp52
         ThF1jzECs2i+5ZuE8HPnXkwi1aAQCfu6hJ3ejTDZJCHMwWvI24LXzKm7M6x0ciFr72wP
         OeCydEUBElA1g0WqGWGlncp53UuL1I87DeVH1eZFO72pv0o51t5tbD5Q6MeBqYVUD+H7
         Jd5mg7xLagn5+maXyf+J/zdNvyHv4YKZBrHEpAQcZq2SVRJ1twUFTsCOBkh1s5BEXekM
         oMqeaBRysQ0+4BQkjjfkXpTamNlPKKFFx49eG0LPOFE31HjXMu1q2lb/0yvVUnWmuvi1
         GQLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=haHH6xEEDXJD3ODlka0BS0C5wOsHmEx6Ewo0XdB15Uc=;
        b=AGnYC9JQwMMSCVKIEp3yS4nD2lVVQSVBGHAYUFu0EnfPxNiQ0uhtPTZb/kbysHhc90
         9GSLPAJ1j8DVPqTWoNcz+qrwu680kU7AfOHPBfut0CvGSG6umZzSQZyMBK/0kHHA9p0y
         E3E1ASpByYpAPY+F4sPAwAXR09LV8dZorgx+LDsTJI6I5VFXdYuHnPnLUsrynQMHkUOq
         wirj2MYAA1ru5ISJ34ZoF6zkIDYTwaO6ynsUCYOpxD2L4h1Xfdm3aAy/MdsFOZxuzzcD
         kDR9WR7P2QgU0qUj+STXojeUXd5O12WAskQ7eB0TmVFGwOfFlHkRtHDXU5ivWpop79Yf
         GX/A==
X-Gm-Message-State: AOAM531IOouDPr+aV/GUT4+MdsdmMB0Swk3D52uUWYivPSsM1xkpFkJ+
        uZUya/Xl6PX18N5pusCHN6rbng==
X-Google-Smtp-Source: ABdhPJwv7H3K1Z9BH0dMOP+jy6GalrbBJ8Rh28BkScE3yXgCSBp3BcAdC3SvV+YLonsYVB8/uNM5hg==
X-Received: by 2002:a05:6a00:847:: with SMTP id q7mr1769819pfk.172.1597920279519;
        Thu, 20 Aug 2020 03:44:39 -0700 (PDT)
Received: from localhost ([122.172.43.13])
        by smtp.gmail.com with ESMTPSA id s125sm2338382pfb.125.2020.08.20.03.44.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Aug 2020 03:44:39 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     rnayak@codeaurora.org
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] qcom-geni-se: remove has_opp_table
Date:   Thu, 20 Aug 2020 16:13:57 +0530
Message-Id: <4e27260253fdda236562f8bed9ec30a75e03f97c.1597919647.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <cover.1597919647.git.viresh.kumar@linaro.org>
References: <cover.1597919647.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

has_opp_table isn't used anymore, remove it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 include/linux/qcom-geni-se.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/qcom-geni-se.h b/include/linux/qcom-geni-se.h
index 8f385fbe5a0e..02d1417c8ecf 100644
--- a/include/linux/qcom-geni-se.h
+++ b/include/linux/qcom-geni-se.h
@@ -48,7 +48,6 @@ struct geni_icc_path {
  * @clk_perf_tbl:	Table of clock frequency input to serial engine clock
  * @icc_paths:		Array of ICC paths for SE
  * @opp_table:		Pointer to the OPP table
- * @has_opp_table:	Specifies if the SE has an OPP table
  */
 struct geni_se {
 	void __iomem *base;
@@ -59,7 +58,6 @@ struct geni_se {
 	unsigned long *clk_perf_tbl;
 	struct geni_icc_path icc_paths[3];
 	struct opp_table *opp_table;
-	bool has_opp_table;
 };
 
 /* Common SE registers */
-- 
2.25.0.rc1.19.g042ed3e048af

