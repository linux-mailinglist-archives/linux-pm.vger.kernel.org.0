Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7001FE0DE
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jun 2020 03:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731796AbgFRB1J (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Jun 2020 21:27:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:35060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731791AbgFRB1J (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 17 Jun 2020 21:27:09 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDAFA20897;
        Thu, 18 Jun 2020 01:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592443628;
        bh=aIu6WKywcY2fBDSizvJuVK46Mwibxi9VcQs36OCkW9Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VAUaZ9M47Q/zQ3O0SRhW9/rb34E6CIlRhKSa2CNQZj0qV/tGqm3/xFB18tpEr+ob4
         O/DQypGFVL57/3GRnnl917ggPVP4W88m7ZZxYtLkrWLWW6yr4P8ffOrN1zeT9vjqrK
         SCQTp9MjcC8PnVyWxGIeTP9XKEbd4C1OWOVsuUjc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        David Heidelberg <david@ixit.cz>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sasha Levin <sashal@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 053/108] power: supply: smb347-charger: IRQSTAT_D is volatile
Date:   Wed, 17 Jun 2020 21:25:05 -0400
Message-Id: <20200618012600.608744-53-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618012600.608744-1-sashal@kernel.org>
References: <20200618012600.608744-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Dmitry Osipenko <digetx@gmail.com>

[ Upstream commit c32ea07a30630ace950e07ffe7a18bdcc25898e1 ]

Fix failure when USB cable is connected:
smb347 2-006a: reading IRQSTAT_D failed

Fixes: 1502cfe19bac ("smb347-charger: Fix battery status reporting logic for charger faults")

Tested-by: David Heidelberg <david@ixit.cz>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: David Heidelberg <david@ixit.cz>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/smb347-charger.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/supply/smb347-charger.c b/drivers/power/supply/smb347-charger.c
index 072c5189bd6d..0655dbdc7000 100644
--- a/drivers/power/supply/smb347-charger.c
+++ b/drivers/power/supply/smb347-charger.c
@@ -1141,6 +1141,7 @@ static bool smb347_volatile_reg(struct device *dev, unsigned int reg)
 	switch (reg) {
 	case IRQSTAT_A:
 	case IRQSTAT_C:
+	case IRQSTAT_D:
 	case IRQSTAT_E:
 	case IRQSTAT_F:
 	case STAT_A:
-- 
2.25.1

