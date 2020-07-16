Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45C80221A55
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jul 2020 04:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbgGPCzD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jul 2020 22:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727034AbgGPCzC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jul 2020 22:55:02 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6524C061755;
        Wed, 15 Jul 2020 19:55:02 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: wlozano)
        with ESMTPSA id ED2ED2A3753
From:   Walter Lozano <walter.lozano@collabora.com>
To:     linux-pm@vger.kernel.org
Cc:     kernel@collabora.com, Walter Lozano <walter.lozano@collabora.com>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] opp: Increase parsed_static_opps on _of_add_opp_table_v1
Date:   Wed, 15 Jul 2020 23:54:52 -0300
Message-Id: <20200716025452.25761-1-walter.lozano@collabora.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Currently, when using _of_add_opp_table_v2 parsed_static_opps is
increased and this value is used on _opp_remove_all_static to
check if there are static opps entries that need to be freed.
Unfortunately this does not happens when using _of_add_opp_table_v1,
which leads to warnings.

This patch increases parsed_static_opps on _of_add_opp_table_v1 in a
similar way as in _of_add_opp_table_v2.

Signed-off-by: Walter Lozano <walter.lozano@collabora.com>
---

 drivers/opp/of.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 9a5873591a40..b2bc82bf8b42 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -917,6 +917,8 @@ static int _of_add_opp_table_v1(struct device *dev, struct opp_table *opp_table)
 		nr -= 2;
 	}
 
+	opp_table->parsed_static_opps++;
+
 	return ret;
 }
 
-- 
2.20.1

