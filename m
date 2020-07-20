Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8E79225739
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jul 2020 07:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbgGTFtd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Jul 2020 01:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgGTFtc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Jul 2020 01:49:32 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E60EC0619D2;
        Sun, 19 Jul 2020 22:49:32 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id k71so9641783pje.0;
        Sun, 19 Jul 2020 22:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v31UIEz3Dwtg5YacEjDmu57JbCXcygtQk9X1DgLN9BA=;
        b=oVaibWsvo3nonV2lk4d4pRxGOY2MYqlXEbFCWmJ8P6y7HB6gVjXnRa82S/w2bAwwlw
         6xnYc08dAFTXXjEhsVzc61b9cSygrkNhgPWc4YXRqz9bLRINcA9MNNEwWrH5D4/oTuBf
         GzgGK5FzZKjkJxN5NhuRVznqh3HiEhYr3Ov8ZF5ZF0KhYWQ/R6FuysCbdb8JOx30ImbV
         NJENbWA9aOUnenPzNf9DtNOHINUqGqZZi8RDPyYkTPPyRSZBsrGQ9X+4n3i81cXvp7Ff
         4rYkMzD0XYvPzO8WyJhtcDJLxqoicA1AILI56IM0doy30NUZfjbOh2Bpuz9HCZ2kPSyi
         /wog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v31UIEz3Dwtg5YacEjDmu57JbCXcygtQk9X1DgLN9BA=;
        b=dEjMsW8oLKOxl6tZjQQ84IqUqOMpk4FPcVUXCzrn1fUXtNb4aeaZKT+a5PnhV0ASdg
         PF6IhLraSxcJIZ7aIekyIsybKGC2J1ndhi0GEzEo+IfHYu8wyQP2vWXpw35E8k+nBQKn
         OGcKEePUNtyJ4GwbRlameshN9y5R4bRp1ejJRlf2ye8m4PRtUqUJH/ydvCMMGPEFd5bY
         ncll1GdnGl+0n11Qsldf3c5uruRHNbll/QnG9JWPgeC4k7RAmF6ciTddaDcXrLQE+u2b
         zdGib+Y5vGw4oEpWe+UBMLs+Vt7A5RdKK+JJLVUfQhweCjDSJQNeU//AmbOhZadrw9mD
         XCEw==
X-Gm-Message-State: AOAM532D7aPDxi4/JFMBCUdHeBKYYSXyZi53JIidpAdte49L5u7+1QKx
        FF4hZvTQoUb5IAaFSY9aElm27sV9ypx/NInb
X-Google-Smtp-Source: ABdhPJzyh8irwIIyglKexcc0oB262gZmwo6vp7dJCN36UjtdxBKneKgaM2b6ecnGcvKmtywb2dlfsA==
X-Received: by 2002:a17:90a:ac06:: with SMTP id o6mr14541288pjq.219.1595224172197;
        Sun, 19 Jul 2020 22:49:32 -0700 (PDT)
Received: from xiaomi.mioffice.cn ([209.9.72.214])
        by smtp.gmail.com with ESMTPSA id i7sm13627833pgh.58.2020.07.19.22.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2020 22:49:31 -0700 (PDT)
From:   Qiwu Huang <yanziily@gmail.com>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, jiangfei1@xiaomi.com,
        Qiwu Huang <huangqiwu@xiaomi.com>
Subject: [PATCH v4 3/4] power: supply: core: add wireless signal strength property
Date:   Mon, 20 Jul 2020 13:47:16 +0800
Message-Id: <b9ee0342005957e2096b6d63eb5752cb3e1e3cc6.1595214246.git.huangqiwu@xiaomi.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1595214246.git.huangqiwu@xiaomi.com>
References: <cover.1595214246.git.huangqiwu@xiaomi.com>
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

