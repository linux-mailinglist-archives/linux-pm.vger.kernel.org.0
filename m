Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A77C1F3AF7
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jun 2020 14:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729665AbgFIMqo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Jun 2020 08:46:44 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:54322 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729633AbgFIMqn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Jun 2020 08:46:43 -0400
Received: from Q.local (cpc89242-aztw30-2-0-cust488.18-1.cable.virginm.net [86.31.129.233])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3D1C61942;
        Tue,  9 Jun 2020 14:46:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1591706798;
        bh=IVJbkKSA3nwijksI90SOHTVUzDelDAqxTGP00p3RZP4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bhVVUs5yfKtNLvnMkgmH0YgIp/kJ9qvg3VdsJYoP15iABTZdUaFOde/I7JcpMe6IQ
         CBUt8Z4nFqbX3uitfCp2xbRAyBiFECNuXCZnlQjl3PmoNLkmF+Y5+XJs9pAmHBrSo4
         klNYLKOpeewxwHewo/5By9RdtOTCtBXF41mR3atQ=
From:   Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
To:     Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     linux-renesas-soc@vger.kernel.org,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Jiri Kosina <trivial@kernel.org>,
        linux-pm@vger.kernel.org (open list:DEVICE FREQUENCY EVENT
        (DEVFREQ-EVENT)), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 12/17] drivers: devfreq: Fix trivial spelling
Date:   Tue,  9 Jun 2020 13:46:05 +0100
Message-Id: <20200609124610.3445662-13-kieran.bingham+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200609124610.3445662-1-kieran.bingham+renesas@ideasonboard.com>
References: <20200609124610.3445662-1-kieran.bingham+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The word 'descriptor' is misspelled throughout the tree.

Fix it up accordingly:
    decriptors -> descriptors

Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
---
 drivers/devfreq/devfreq-event.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/devfreq/devfreq-event.c b/drivers/devfreq/devfreq-event.c
index 8c31b0f2e28f..56efbeb7851e 100644
--- a/drivers/devfreq/devfreq-event.c
+++ b/drivers/devfreq/devfreq-event.c
@@ -293,7 +293,7 @@ static void devfreq_event_release_edev(struct device *dev)
 /**
  * devfreq_event_add_edev() - Add new devfreq-event device.
  * @dev		: the device owning the devfreq-event device being created
- * @desc	: the devfreq-event device's decriptor which include essential
+ * @desc	: the devfreq-event device's descriptor which include essential
  *		  data for devfreq-event device.
  *
  * Note that this function add new devfreq-event device to devfreq-event class
@@ -385,7 +385,7 @@ static void devm_devfreq_event_release(struct device *dev, void *res)
 /**
  * devm_devfreq_event_add_edev() - Resource-managed devfreq_event_add_edev()
  * @dev		: the device owning the devfreq-event device being created
- * @desc	: the devfreq-event device's decriptor which include essential
+ * @desc	: the devfreq-event device's descriptor which include essential
  *		  data for devfreq-event device.
  *
  * Note that this function manages automatically the memory of devfreq-event
-- 
2.25.1

