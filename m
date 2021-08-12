Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34DAB3EA2DE
	for <lists+linux-pm@lfdr.de>; Thu, 12 Aug 2021 12:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235428AbhHLKOc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Aug 2021 06:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236614AbhHLKO3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Aug 2021 06:14:29 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5908AC0613D5;
        Thu, 12 Aug 2021 03:14:04 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id x27so12505652lfu.5;
        Thu, 12 Aug 2021 03:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K926lN1vSxEZqXxMsrjyNKmXx0wf4ELCe/h4HH8yuSA=;
        b=J6h3JD1ykWsqMxD9JhN9RMlv7lnar87y/XtgpQE393SUMqwEhJG0W5sOY9Ka+xIFEQ
         V6I6HCXNgKLh51F0MYMHcIsKCC197amXLFziKoc2bqXRp9GN2G92LxQHd2HMjgVHkGp6
         hgoJfGx3uZR0PnsfmkhD50h8cZswLZg+ZAcmw222sXaNZb6kGW/qft1kxNcmwlfCeS7u
         xecwrmYWG2iqYrNaOuteQd2bqWgLMDC9hXyHvjSzPOIgjGxH8R3EML0KscLFDv5Wk3sb
         vZXHQWKfH4hfAYcio/DjRIxCjGPFROYH1CHHtgFCsz47mZ00xX5FFR44oxEtaG0JXtm5
         6CXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K926lN1vSxEZqXxMsrjyNKmXx0wf4ELCe/h4HH8yuSA=;
        b=EpUsL7ZkGT8k8HtqDMds4e2PPh8baGryE/d0t1zEOTs1F872kNTM+tbXRrXsbfhKml
         Y+nK+1LoI99RAuJ1rDn2fbWuSfu+gEPeAZ312yAW9ECXUIAMQD+G5+KChAiqced1v+zz
         Kh1iXt7CjPco5BQcse1DFBObpaNOL7bw4+WeA04NOFXLVvHNLe5oRtrPp1JvN7rd6TNk
         EtpZt3j9h0kkQurhZfVB7a5xdNh1dT8PHpesLQpt5f1Ho5WLKGg2czN889p/yikz9lPn
         XhlctswnnXhHKIVluxB2CoPbsgbLtA1SJR2uWHCvvJ00HF2SUCVJt6g2/2CtYEzBmxHn
         awoQ==
X-Gm-Message-State: AOAM532Y/Lpnkepp8PqBN95xJbJtkyqWg2nJFmjl6HThG5jLNxFbmH+g
        VhcZFmiiDfSn/vTn9GoDl9Cp6R8pP44=
X-Google-Smtp-Source: ABdhPJzeE91uHUmY5tWQ4kJGseFX09r3UGSPbBgQD7EKuv7vBCWMRKHO6E8ot3K9ai+bzfoozFXhWg==
X-Received: by 2002:a05:6512:6d6:: with SMTP id u22mr793220lff.263.1628763242675;
        Thu, 12 Aug 2021 03:14:02 -0700 (PDT)
Received: from localhost.localdomain (46-138-117-53.dynamic.spd-mgts.ru. [46.138.117.53])
        by smtp.gmail.com with ESMTPSA id r25sm235269lfm.90.2021.08.12.03.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Aug 2021 03:14:02 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Viresh Kumar <vireshk@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Nishanth Menon <nm@ti.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH v1] opp: Release current OPP properly
Date:   Thu, 12 Aug 2021 13:13:53 +0300
Message-Id: <20210812101353.14318-1-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The current_opp is released only when whole OPP table is released,
otherwise it's only marked as removed by dev_pm_opp_remove_table().
Functions like dev_pm_opp_put_clkname() and dev_pm_opp_put_supported_hw()
are checking whether OPP table is empty and it's not if current_opp is
set since it holds the refcount of OPP, this produces a noisy warning
from these functions about busy OPP table. Release current_opp when
OPP table is removed to fix it.

Cc: stable@vger.kernel.org
Fixes: 81c4d8a3c414 ("opp: Keep track of currently programmed OPP")
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/opp/core.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index b335c077f215..73da968b5c86 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1378,9 +1378,6 @@ static void _opp_table_kref_release(struct kref *kref)
 	list_del(&opp_table->node);
 	mutex_unlock(&opp_table_lock);
 
-	if (opp_table->current_opp)
-		dev_pm_opp_put(opp_table->current_opp);
-
 	_of_clear_opp_table(opp_table);
 
 	/* Release clk */
@@ -2901,6 +2898,12 @@ void dev_pm_opp_remove_table(struct device *dev)
 	if (_opp_remove_all_static(opp_table))
 		dev_pm_opp_put_opp_table(opp_table);
 
+	/* Drop reference taken by _find_current_opp() */
+	if (opp_table->current_opp) {
+		dev_pm_opp_put(opp_table->current_opp);
+		opp_table->current_opp = NULL;
+	}
+
 	/* Drop reference taken by _find_opp_table() */
 	dev_pm_opp_put_opp_table(opp_table);
 }
-- 
2.32.0

