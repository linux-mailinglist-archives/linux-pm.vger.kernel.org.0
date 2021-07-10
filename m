Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 811EC3C397C
	for <lists+linux-pm@lfdr.de>; Sun, 11 Jul 2021 01:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233419AbhGKAAu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 10 Jul 2021 20:00:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:41452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234163AbhGJX5x (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 10 Jul 2021 19:57:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D037661435;
        Sat, 10 Jul 2021 23:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625961175;
        bh=NP/7qNcVQSeEzTsA/o3WauCq/qHz9KK+mgy2AI7Bh20=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AA1+fzx02nZ8zB8ko61e3e2lZBRzPeK2ofAmdLy69RoTXJsd3xmc7O5oH+170Viog
         0Vvca+1JtwMqzs6hU4bC9GAR8/6lxNynFIyoqt1xxa3EnwnKSqJ368wh0AwUCfQBsh
         SNZbDjRVH4el1B0SpHBLzjT7x4AWZVGQkLzZVzL/7qIcU8GUQc1Y2ODrA+Vq8uTeso
         jlFjQkqFyidHyL4MG1BMCfomrtlK8xc9ncquZIs3C93KvFurLj559hMSzre90bGOyd
         jQywE7AypbfLs0+YvPYe1THc6NRfcPU/qmUaHXoc3bDVH7/UiQ1CQ+j3+qbLwyO+J+
         nmJsyP97EN6OA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Zou Wei <zou_wei@huawei.com>, Hulk Robot <hulkci@huawei.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sasha Levin <sashal@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 11/16] power: supply: charger-manager: add missing MODULE_DEVICE_TABLE
Date:   Sat, 10 Jul 2021 19:52:35 -0400
Message-Id: <20210710235240.3222618-11-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210710235240.3222618-1-sashal@kernel.org>
References: <20210710235240.3222618-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Zou Wei <zou_wei@huawei.com>

[ Upstream commit 073b5d5b1f9cc94a3eea25279fbafee3f4f5f097 ]

This patch adds missing MODULE_DEVICE_TABLE definition which generates
correct modalias for automatic loading of this driver when it is built
as an external module.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zou Wei <zou_wei@huawei.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/charger-manager.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/supply/charger-manager.c b/drivers/power/supply/charger-manager.c
index 13f23c00538b..043836e6d347 100644
--- a/drivers/power/supply/charger-manager.c
+++ b/drivers/power/supply/charger-manager.c
@@ -1489,6 +1489,7 @@ static const struct of_device_id charger_manager_match[] = {
 	},
 	{},
 };
+MODULE_DEVICE_TABLE(of, charger_manager_match);
 
 static struct charger_desc *of_cm_parse_desc(struct device *dev)
 {
-- 
2.30.2

