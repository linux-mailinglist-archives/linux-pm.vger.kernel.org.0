Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49F69227875
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jul 2020 08:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728311AbgGUGBy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 Jul 2020 02:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbgGUGBy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Jul 2020 02:01:54 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5183C061794;
        Mon, 20 Jul 2020 23:01:53 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id q17so10202920pfu.8;
        Mon, 20 Jul 2020 23:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v31UIEz3Dwtg5YacEjDmu57JbCXcygtQk9X1DgLN9BA=;
        b=OaqRnCNBbaOyf6gKkUaUpNXTA920VOonVO9JKbyrCKb9JnM6mbk6Y8rVHsiqJXI9cI
         4sNjlLANtDOBE4DarnVTpgB6vomXFgz/yRLodo3ehYAto4yEqnL3/zQyEJ3zZ1YnYHD5
         ZNfDulMhozXwCKDGmpdqbp7lSbMUGQPj8yVd31g+yOCxgKphbaPcXx8jnl7CalACOj3n
         TCsfgOXDQSHV2KH3bnttaE54z86au0lpHiX8dfD+FwinHnzc/fh5vWuJq7BA74AL+7ta
         7NXhmU7CNLrdsRUmZSMtFbycQl4vWlnCaf8unfV5lSwuL/MMOJ2Mkj7RPCWIHZNKnzLX
         sFkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v31UIEz3Dwtg5YacEjDmu57JbCXcygtQk9X1DgLN9BA=;
        b=bGRHTjE03HJ2TgGFAbkMH1rpBwqndRYtVkQWaM6G1AYqac1JWBiK3BtF48LGOP0W3t
         vDF00kRaJy1AbJx+ON49okpc+2z9J89Sjk0803UetQayS8vGMjtPmJDQvwRrUzDVUuEb
         /aUM797U1qC3qo9ChrsmqTVvBCKVc2sn2itpISail4suBw8owPyfMtK0peF3IZjdPeMs
         X6HbIjPmHDnbYq6eaTsZjDv/M0zs8B0hIKuFzp0GryxkVZ2y1uYauKJLreLjVP1c4XyP
         V5R1J4DFYa/tNpsXjbWFu9pE/fjBjuIYcMi5IsgTKC39KBGqXNwMMRRSauJCWch0xd7l
         b7gw==
X-Gm-Message-State: AOAM533XWJ23iaoxSFtQLZO839a6dD8GrjUuoXpldsc5NoYYH8Q7MfhJ
        8swBrC5z/7DXN/6Ai2Mmu87eZCOIGWw+bA==
X-Google-Smtp-Source: ABdhPJwTYSkbKwOevB5V24tO9MuY1cErnW4rjdcoHJGWyUrcHI3aa4abdanfOIWD8LkKChzhPBWP2w==
X-Received: by 2002:a63:1c61:: with SMTP id c33mr21269575pgm.350.1595311313373;
        Mon, 20 Jul 2020 23:01:53 -0700 (PDT)
Received: from xiaomi.mioffice.cn ([209.9.72.214])
        by smtp.gmail.com with ESMTPSA id 129sm18368833pfv.161.2020.07.20.23.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 23:01:52 -0700 (PDT)
From:   Qiwu Huang <yanziily@gmail.com>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, jiangfei1@xiaomi.com,
        Qiwu Huang <huangqiwu@xiaomi.com>
Subject: [PATCH v5 3/4] power: supply: core: add wireless signal strength property
Date:   Tue, 21 Jul 2020 13:59:36 +0800
Message-Id: <b383d79629d0afca00838fcbaad4458e383d7262.1595301250.git.huangqiwu@xiaomi.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1595301250.git.huangqiwu@xiaomi.com>
References: <cover.1595301250.git.huangqiwu@xiaomi.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Qiwu Huang <huangqiwu@xiaomi.com>

reports wireless signal strength.
The value show degree of coupling between tx and rx.

Signed-off-by: Qiwu Huang <huangqiwu@xiaomi.com>
---
 Documentation/ABI/testing/sysfs-class-power | 10 ++++++++++
 drivers/power/supply/power_supply_sysfs.c   |  1 +
 include/linux/power_supply.h                |  1 +
 3 files changed, 12 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
index 03ab449fae8a..75ec7de2fe78 100644
--- a/Documentation/ABI/testing/sysfs-class-power
+++ b/Documentation/ABI/testing/sysfs-class-power
@@ -757,3 +757,13 @@ Description:
 			13: ADAPTER_VOICE_BOX,
 			14: ADAPTER_PRIVATE_PD_50W.
 
+What:		/sys/class/power_supply/<supply_name>/signal_strength
+Date:		Jul 2020
+Contact:	Fei Jiang <jiangfei1@xiaomi.com>
+Description:
+		In PING phase, RX transmits a signal strength packet as the first
+		communication packet to instruct the base to keep power signal on.
+		The value reports wireless signal strength and show degree of coupling.
+
+		Access: Read-Only
+		Valid values: 0 - 100
diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index f2458e21d02b..e420a453095e 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -208,6 +208,7 @@ static struct power_supply_attr power_supply_attrs[] = {
 	POWER_SUPPLY_ATTR(SERIAL_NUMBER),
 	POWER_SUPPLY_ATTR(QUICK_CHARGE_TYPE),
 	POWER_SUPPLY_ATTR(TX_ADAPTER),
+	POWER_SUPPLY_ATTR(SIGNAL_STRENGTH),
 };
 
 static struct attribute *
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 0bbdec1630a4..346c6c9c0737 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -169,6 +169,7 @@ enum power_supply_property {
 	POWER_SUPPLY_PROP_SERIAL_NUMBER,
 	POWER_SUPPLY_PROP_QUICK_CHARGE_TYPE,
 	POWER_SUPPLY_PROP_TX_ADAPTER,
+	POWER_SUPPLY_PROP_SIGNAL_STRENGTH,
 };
 
 enum power_supply_type {
-- 
2.27.0

