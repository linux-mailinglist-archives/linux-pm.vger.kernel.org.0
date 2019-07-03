Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7D815E252
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2019 12:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfGCKtD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 3 Jul 2019 06:49:03 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35078 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbfGCKtD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 3 Jul 2019 06:49:03 -0400
Received: by mail-pf1-f196.google.com with SMTP id d126so1083172pfd.2
        for <linux-pm@vger.kernel.org>; Wed, 03 Jul 2019 03:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QeijeBF/Qq0/nML/DtAOMmhYfGGWZIRxXZGOcQopUnU=;
        b=Qi4zf9WQujuGXGVIJoG6eWj2Pgvm21/zrxiMelr/f2zI3C/QwOhBn+8AUUtz3nW1AY
         wPKQOYUHatNMwwVgMC3pE22nQgNEcFB6LorsBY0VlN3WjxFNXd6e0bwyrgid5iROQOC8
         09tObKBC7H7YghbX7IHHDO4Z3SweUAOf/xRhLKRr5T44tQJpMksrrQOPVtG1KfFBN5f/
         3+jAHaMfeFB+jG/Ji2lTNIlnGcCZ/Q6TmL9k0gAHpDHDnDs4rHqQJ2mMawAMDSR5s6SX
         ghj+sanueFZP2mfw1vCvCOTwL8lRsnQOHeIRmv4KZlauDzIInFpl5FjGTQdiiuikfu9x
         ke8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QeijeBF/Qq0/nML/DtAOMmhYfGGWZIRxXZGOcQopUnU=;
        b=kIbrVsEGfmVG9RYCpz84iYGs/5olwdwZD3AB9r0cFVH5Kt6egbeQ2fAuBoN6HsXYUy
         MHURMQ2ANy/0XDj+NyzXXruf/y2zS9iqv6rPqrlAuxyfD7u0nVYzfIZgtAag4AuO/dEV
         X9lkrZGOw1QRzZ4gVaOl5Fx9aSRKWc6NwjtqUlbOkztJZPSbiErnVjXNzJOTmj4kYUZt
         4L/E5meoMzxTB0MX8rk3itL+WYPKhkhNOBNOUHfccD2Tq/jpSoM7R1e39M1O1TCdtVoo
         Xr/VKotpz7IAazRf+gW4YjvcW1dju3050pcWOsx93h+z/55OoX1fWTmsxLiSFmFXbJAD
         znsg==
X-Gm-Message-State: APjAAAX6MWvuO4UUP7WpXrKzMBWWfZ8f+//+SEXFtFGEw7LauB3AtQmv
        VG+EHSRr/BfndrVHeG1CFEM1Tg==
X-Google-Smtp-Source: APXvYqzrFWXg8XGMJ2ISqEo0zJ5AUs+evuDH+RaUD38Hyux/TRUXDH7QCeUapEJk7K5nTUR4irngrg==
X-Received: by 2002:a65:6541:: with SMTP id a1mr35899681pgw.409.1562150942519;
        Wed, 03 Jul 2019 03:49:02 -0700 (PDT)
Received: from localhost ([122.172.21.205])
        by smtp.gmail.com with ESMTPSA id g92sm6303648pje.11.2019.07.03.03.49.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 03:49:01 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] opp: Don't decrement uninitialized list_kref
Date:   Wed,  3 Jul 2019 16:18:47 +0530
Message-Id: <b7f4da2895bff6c96a43ffcfd685a2a74e7e878e.1562150899.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The list_kref was added for static OPPs and to track their users. The
kref is initialized while the static OPPs are added, but removed
unconditionally even if the static OPPs were never added. This causes
refcount mismatch warnings currently.

Fix that by always initializing the kref when the OPP table is first
initialized. The refcount is later incremented only for the second user
onwards.

Fixes: d0e8ae6c26da ("OPP: Create separate kref for static OPPs list")
Reported-and-tested-by: Rajendra Nayak <rnayak@codeaurora.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c |  1 +
 drivers/opp/of.c   | 21 ++++-----------------
 2 files changed, 5 insertions(+), 17 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 89ec6aa220cf..2958cc7bbb58 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -943,6 +943,7 @@ static struct opp_table *_allocate_opp_table(struct device *dev, int index)
 	BLOCKING_INIT_NOTIFIER_HEAD(&opp_table->head);
 	INIT_LIST_HEAD(&opp_table->opp_list);
 	kref_init(&opp_table->kref);
+	kref_init(&opp_table->list_kref);
 
 	/* Secure the device table modification */
 	list_add(&opp_table->node, &opp_tables);
diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index a637f30552a3..bf62b357437c 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -665,8 +665,6 @@ static int _of_add_opp_table_v2(struct device *dev, struct opp_table *opp_table)
 		return 0;
 	}
 
-	kref_init(&opp_table->list_kref);
-
 	/* We have opp-table node now, iterate over it and add OPPs */
 	for_each_available_child_of_node(opp_table->np, np) {
 		opp = _opp_add_static_v2(opp_table, dev, np);
@@ -675,17 +673,15 @@ static int _of_add_opp_table_v2(struct device *dev, struct opp_table *opp_table)
 			dev_err(dev, "%s: Failed to add OPP, %d\n", __func__,
 				ret);
 			of_node_put(np);
-			goto put_list_kref;
+			return ret;
 		} else if (opp) {
 			count++;
 		}
 	}
 
 	/* There should be one of more OPP defined */
-	if (WARN_ON(!count)) {
-		ret = -ENOENT;
-		goto put_list_kref;
-	}
+	if (WARN_ON(!count))
+		return -ENOENT;
 
 	list_for_each_entry(opp, &opp_table->opp_list, node)
 		pstate_count += !!opp->pstate;
@@ -694,8 +690,7 @@ static int _of_add_opp_table_v2(struct device *dev, struct opp_table *opp_table)
 	if (pstate_count && pstate_count != count) {
 		dev_err(dev, "Not all nodes have performance state set (%d: %d)\n",
 			count, pstate_count);
-		ret = -ENOENT;
-		goto put_list_kref;
+		return -ENOENT;
 	}
 
 	if (pstate_count)
@@ -704,11 +699,6 @@ static int _of_add_opp_table_v2(struct device *dev, struct opp_table *opp_table)
 	opp_table->parsed_static_opps = true;
 
 	return 0;
-
-put_list_kref:
-	_put_opp_list_kref(opp_table);
-
-	return ret;
 }
 
 /* Initializes OPP tables based on old-deprecated bindings */
@@ -734,8 +724,6 @@ static int _of_add_opp_table_v1(struct device *dev, struct opp_table *opp_table)
 		return -EINVAL;
 	}
 
-	kref_init(&opp_table->list_kref);
-
 	val = prop->value;
 	while (nr) {
 		unsigned long freq = be32_to_cpup(val++) * 1000;
@@ -745,7 +733,6 @@ static int _of_add_opp_table_v1(struct device *dev, struct opp_table *opp_table)
 		if (ret) {
 			dev_err(dev, "%s: Failed to add OPP %ld (%d)\n",
 				__func__, freq, ret);
-			_put_opp_list_kref(opp_table);
 			return ret;
 		}
 		nr -= 2;
-- 
2.21.0.rc0.269.g1a574e7a288b

