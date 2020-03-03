Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C945C178418
	for <lists+linux-pm@lfdr.de>; Tue,  3 Mar 2020 21:36:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731559AbgCCUgV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Mar 2020 15:36:21 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39694 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730081AbgCCUgV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Mar 2020 15:36:21 -0500
Received: by mail-lj1-f196.google.com with SMTP id f10so3207566ljn.6
        for <linux-pm@vger.kernel.org>; Tue, 03 Mar 2020 12:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3+0UYj3qVJZMwBRFalwhwumi1SLOyZkXHX2X4PQigTk=;
        b=M6nT4o+PaOt0lluB6TctZ125cHNRlgBI/C3zswdbS6bE4Vor6LpM3xul+GzDk3LYMc
         qw+N/dL5nSOCxpgekkdUlti+upKi21MCbPGU/bH9dA31iwdJrjuUmx50lvX4KtVd47p/
         lGSRoDHKlev29S/7Vs+Z/wjbkDTdKZJ3qP6cAKGHBQ4J3m5MJ3pL5+jtoffHYIz8rb/D
         LyJGPV8uyzka1C/i7OsLZ1YfXnjmIl1B6XuEbzK8VLlbznNOGVRIOhySviyL9ZP5yMhT
         CFX4hcgpE/r3MtTYFG9uc6R3sKXfs0gMaoa5+35Hr17dAW1rceC8NKY5fQ9zkfbSVx2u
         Md3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3+0UYj3qVJZMwBRFalwhwumi1SLOyZkXHX2X4PQigTk=;
        b=XCpqsShqUwc1D6caUko1AOECJ2KZqVUnRunR36knV/aHe95Q3VtpZIPaOeOELFRplb
         b5QHugKmK2T0/+RUPkO4Gd/3+KHAFUBQKxzyIZtf0t1qQ10imgNXVjJ7ZouadhqNeaF+
         cZlhQlTpZZv1Jj4YgNxKRUc03i/Z5MB08XmYPv71LjBTTsrREHeeZb/UBu+ePlvCZsrq
         n8Yw2PdWlk+ztEs2AJMwCtkTno6AY5bGrJziOXpOuvEa7qgDwSq6rK8NHmXJ7snCrVmJ
         HS50oxl8jJFNxIG/TXmdnkdN29Q9CyG7vhtJOpW6aINFRYyHqNwA4E6kbJO1x9F/rotm
         hbNQ==
X-Gm-Message-State: ANhLgQ3OJmsb1etfOB59H7C9UZu81L5DHehtQ4RBWFom0ZvBeAxpIzbG
        v/qILWWg5R1BkOqynIW2HlRAbxQLvTo=
X-Google-Smtp-Source: ADFU+vtxH5Gk3A2TqaasCf1CsCDxKPfx3AYiuDLFIZjyb++K4u0hf79plZcWKxwzcA4xfdBGagw2Yg==
X-Received: by 2002:a2e:b442:: with SMTP id o2mr3427232ljm.261.1583267779037;
        Tue, 03 Mar 2020 12:36:19 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id t195sm1339532lff.0.2020.03.03.12.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 12:36:18 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        linux-pm@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Subject: [PATCH v2 1/4] PM / Domains: Allow no domain-idle-states DT property in genpd when parsing
Date:   Tue,  3 Mar 2020 21:35:56 +0100
Message-Id: <20200303203559.23995-2-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200303203559.23995-1-ulf.hansson@linaro.org>
References: <20200303203559.23995-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Commit 2c361684803e ("PM / Domains: Don't treat zero found compatible idle
states as an error"), moved of_genpd_parse_idle_states() towards allowing
none compatible idle state to be found for the device node, rather than
returning an error code.

However, it didn't consider that the "domain-idle-states" DT property may
be missing as it's optional, which makes of_count_phandle_with_args() to
return -ENOENT. Let's fix this to make the behaviour consistent.

Reported-by: Benjamin Gaignard <benjamin.gaignard@st.com>
Fixes: 2c361684803e ("PM / Domains: Don't treat zero found compatible idle states as an error")
Cc: <stable@vger.kernel.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 959d6d5eb000..0a01df608849 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2653,7 +2653,7 @@ static int genpd_iterate_idle_states(struct device_node *dn,
 
 	ret = of_count_phandle_with_args(dn, "domain-idle-states", NULL);
 	if (ret <= 0)
-		return ret;
+		return ret == -ENOENT ? 0 : ret;
 
 	/* Loop over the phandles until all the requested entry is found */
 	of_for_each_phandle(&it, ret, dn, "domain-idle-states", NULL, 0) {
-- 
2.20.1

