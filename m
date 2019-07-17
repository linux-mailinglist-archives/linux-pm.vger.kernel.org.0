Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9A0C6B9F2
	for <lists+linux-pm@lfdr.de>; Wed, 17 Jul 2019 12:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725993AbfGQKTz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Jul 2019 06:19:55 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41016 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbfGQKTy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Jul 2019 06:19:54 -0400
Received: by mail-pg1-f196.google.com with SMTP id x15so592475pgg.8
        for <linux-pm@vger.kernel.org>; Wed, 17 Jul 2019 03:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=47h7mNoqO2yjIf+Awl5RozvneGnjTx6MR3XFMeu6eY4=;
        b=fciAn2pTVnVyE5s5FVXbRgH1XKNS9xOCpqD5H9fswkBPYdyiTkKHfBJv0kncocpENV
         MpYMoIyUn616Kd5L0p3GFB1WFSkm02dI2a2n7BPn0+/fr6xw/nLGhzLkOwC7DDtBweQr
         PEOBXwF9y9dJwMvqwMmxHtrcAoeomRVRjy9MEObaBEaGLJuPTROHEt125DzEZvuBTbA3
         pWjsGu2/Z8V4O+eFtVYpdoihmo6+1nT/yu1Jtw84lTURE63k2Pu591ftFL94w9iJgfGf
         QWzrJCuMwAwa+s/dZhiBNO+ZH40XA44CqyoP26vGQNoSSXVo9HkRa5mXIXtin7KOj19v
         TttA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=47h7mNoqO2yjIf+Awl5RozvneGnjTx6MR3XFMeu6eY4=;
        b=W4ErAXhtDoK4F5PpIg2YCStUERVUNFG9dFOeXubJthLB/50g8sGf8bWrcoyx1STBis
         Xh4V2TWVFEAxcncYXg0GuzWuZRaMGZWknEeFIHJE73KCXS05IIXdeaHPMp6H+zf55B0+
         /eZapl//PwCHjQwJZTvtrlBc91pmAHPf4rgfDQzdFMgq/Ltac2EoKgmQ/m+pkwHArlWZ
         kiOODGyqp84k7WL86Wt5wkoP9cjef8hWWxrUX7ifL9SRe9dVPPmmOFqtrJfy0KufJBKn
         fyqy+3Sv4nUORrLRk3GxnxVg4GKOzm0MqW7Y6fFykkRbFGKpjtgF5F/pgPzgoghwM1Su
         G7IQ==
X-Gm-Message-State: APjAAAXXotBVmvkm99BXiK5y3YzLCBt1zf+tcTAtrIPhV9mZSidqD1mF
        cxw5Ily2vjenSQfc4zHfxuPqSA==
X-Google-Smtp-Source: APXvYqx99DGNvMjwQ9E+nXYfGa8Bpdx3n8eMr1L+9m55nCd8gA3oMk/ssQiH9ob9gKOnQmAxabFGiQ==
X-Received: by 2002:a17:90a:2506:: with SMTP id j6mr7362792pje.129.1563358794014;
        Wed, 17 Jul 2019 03:19:54 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id i126sm23884866pfb.32.2019.07.17.03.19.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Jul 2019 03:19:53 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>, niklas.cassel@linaro.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] opp: Not all power-domains are scalable
Date:   Wed, 17 Jul 2019 15:49:46 +0530
Message-Id: <90ba3941b56e50ea5548dd1e90bf3bcd8c9da4fe.1563358721.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

A device may have multiple power-domains and not all of them may be
scalable (i.e. support performance states). But
dev_pm_opp_attach_genpd() doesn't take that into account currently.

Fix that by not verifying the names argument with "power-domain-names"
DT property and finding the index into the required-opps array. The
names argument will anyway get verified later on when we call
dev_pm_domain_attach_by_name().

Fixes: 6319aee10e53 ("opp: Attach genpds to devices from within OPP core")
Reported-by: Rajendra Nayak <rnayak@codeaurora.org>
Tested-by: Rajendra Nayak <rnayak@codeaurora.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 2958cc7bbb58..4e2a81698cd2 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1788,12 +1788,15 @@ static void _opp_detach_genpd(struct opp_table *opp_table)
  *
  * This helper needs to be called once with a list of all genpd to attach.
  * Otherwise the original device structure will be used instead by the OPP core.
+ *
+ * The order of entries in the names array must match the order in which
+ * "required-opps" are added in DT.
  */
 struct opp_table *dev_pm_opp_attach_genpd(struct device *dev, const char **names)
 {
 	struct opp_table *opp_table;
 	struct device *virt_dev;
-	int index, ret = -EINVAL;
+	int index = 0, ret = -EINVAL;
 	const char **name = names;
 
 	opp_table = dev_pm_opp_get_opp_table(dev);
@@ -1819,14 +1822,6 @@ struct opp_table *dev_pm_opp_attach_genpd(struct device *dev, const char **names
 		goto unlock;
 
 	while (*name) {
-		index = of_property_match_string(dev->of_node,
-						 "power-domain-names", *name);
-		if (index < 0) {
-			dev_err(dev, "Failed to find power domain: %s (%d)\n",
-				*name, index);
-			goto err;
-		}
-
 		if (index >= opp_table->required_opp_count) {
 			dev_err(dev, "Index can't be greater than required-opp-count - 1, %s (%d : %d)\n",
 				*name, opp_table->required_opp_count, index);
@@ -1847,6 +1842,7 @@ struct opp_table *dev_pm_opp_attach_genpd(struct device *dev, const char **names
 		}
 
 		opp_table->genpd_virt_devs[index] = virt_dev;
+		index++;
 		name++;
 	}
 
-- 
2.21.0.rc0.269.g1a574e7a288b

