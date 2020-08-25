Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5892525167B
	for <lists+linux-pm@lfdr.de>; Tue, 25 Aug 2020 12:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729800AbgHYKSe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Aug 2020 06:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729723AbgHYKSb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Aug 2020 06:18:31 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D46C061795;
        Tue, 25 Aug 2020 03:18:30 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id kx11so559069pjb.5;
        Tue, 25 Aug 2020 03:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1yYDGduReawbGncTrfFLyBmV4+qoSFljqqIYwSpLPpY=;
        b=c9DMslMRvwZIcO0IAfrrs4x3HqgMAnvrS5e+oKSxOePa8sEX4AiTU3GjwITbj8z8jh
         hLZpQ8QPaLk7E8mPSfav24HXzZJXbQtrIhwiuAOfEOzkfpoKQPxbcnQm0JSkprHcBhKe
         v1EickWioCyRU2TSwi0WRVGAPkFLu+5WV4wM8D1SG2mDhTpDeesmXxLsqNrDhpBSO0ZH
         Vc0QCeaHgVnB25iyUAYBC+rrmGna69byppxXKMBnvthpdbnGgug+TlOwDBzkez3rC5Xj
         oweebkBXvHfrnYX4zCogJwA+0BxldP0Ws8vn8UenRHnMpBuGK1Ok7YLoYvA7tRYgZb0E
         NT4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1yYDGduReawbGncTrfFLyBmV4+qoSFljqqIYwSpLPpY=;
        b=KLIqghgTZrHSy7gjFkIbKR3vIGOhctkZqr0eYk+uoZfXpSK4NrwkTYL8eM4V7RUESd
         3BqeAG+wYP+LUE3iS/lPmENeIev9V+Efkkzfodc6uTKEa/I54b6FkxZqSRGd/7pMd7Im
         0lcVSAffoO1EI+F+wFjq65O5nY2n0wyRgIOadUwZ02Ej0pLfci0cqpjnF6UWy2TWVuGj
         qE8F2ee+Gm0myJpgjTVw5OVfgRD6dnIYRVL19VZjidSCJ55xRBViRKS3TqK1FNCNfCS3
         Ij+6TH7sXnfKQgNB+nhYBrqlJMCo0XKeBFrt5RgJyMvIwxmYJ44BXy2iaEeXQE8H25fm
         7jMQ==
X-Gm-Message-State: AOAM532GGFfvIRal09+je+7NULXYV/V+I2X/28pknpW2qBPtCgeQs4b+
        Xrn5NspkfqurQwHOjtwLNjA=
X-Google-Smtp-Source: ABdhPJz+k84/9T2SWP0gPRPCfhr5da+WdWqbtzQ1kmniP2zWyUkRF5Ai3H60OnA5AdklR6SDpo627A==
X-Received: by 2002:a17:90a:df82:: with SMTP id p2mr1058792pjv.55.1598350710415;
        Tue, 25 Aug 2020 03:18:30 -0700 (PDT)
Received: from xiaomi.mioffice.cn ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id 19sm1788911pjk.28.2020.08.25.03.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 03:18:29 -0700 (PDT)
From:   Qiwu Huang <yanziily@gmail.com>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, Qiwu Huang <huangqiwu@xiaomi.com>
Subject: [PATCH v10 3/4] power: supply: core: add wireless signal strength property
Date:   Tue, 25 Aug 2020 18:16:16 +0800
Message-Id: <4290093486eb640e851bf2f4cdc579676855a479.1598349907.git.huangqiwu@xiaomi.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1598349907.git.huangqiwu@xiaomi.com>
References: <cover.1598349907.git.huangqiwu@xiaomi.com>
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
 Documentation/ABI/testing/sysfs-class-power | 22 +++++++++++++++++++++
 drivers/power/supply/power_supply_sysfs.c   |  1 +
 include/linux/power_supply.h                |  1 +
 3 files changed, 24 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
index 2850adbc8c58..c3a547037d07 100644
--- a/Documentation/ABI/testing/sysfs-class-power
+++ b/Documentation/ABI/testing/sysfs-class-power
@@ -758,3 +758,25 @@ Description:
 			13: ADAPTER_VOICE_BOX,
 			14: ADAPTER_PRIVATE_PD_50W.
 
+What:		/sys/class/power_supply/<supply_name>/signal_strength
+Date:		Jul 2020
+Contact:	Fei Jiang <jiangfei1@xiaomi.com>
+Description:
+		In PING phase, RX transmits a signal strength packet as the
+		first communication packet to instruct the base to keep power
+		signal on.The value reports wireless signal strength and show
+		degree of coupling.
+
+		The Qi Wireless Power Transfer System is published by the
+		Wireless Power Consortium.The ping phase is the necessary stage
+		for matching transmitter and receiver. In this phase,the Power
+		Transmitter executes a Digital Ping, and listens for a response.
+		If the Power Transmitter discovers a Power Receiver, the Power
+		Transmitter may extend the Digital Ping,i.e. maintain the Power
+		Signal at the level of the Digital Ping. This causes the system
+		to proceed to the identification & configuration phase. If the
+		Power Transmitter does not extend the Digital Ping, the system
+		shall revert to the selection phase.
+
+		Access: Read-Only
+		Valid values: 0 - 100
diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index 76de6ae199d3..64e6bdd91edf 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -212,6 +212,7 @@ static struct power_supply_attr power_supply_attrs[] = {
 	POWER_SUPPLY_ATTR(SERIAL_NUMBER),
 	POWER_SUPPLY_ATTR(QUICK_CHARGE_TYPE),
 	POWER_SUPPLY_ATTR(TX_ADAPTER),
+	POWER_SUPPLY_ATTR(SIGNAL_STRENGTH),
 };
 
 static struct attribute *
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 4e161d8961c1..496d1faecdd1 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -173,6 +173,7 @@ enum power_supply_property {
 	POWER_SUPPLY_PROP_SERIAL_NUMBER,
 	POWER_SUPPLY_PROP_QUICK_CHARGE_TYPE,
 	POWER_SUPPLY_PROP_TX_ADAPTER,
+	POWER_SUPPLY_PROP_SIGNAL_STRENGTH,
 };
 
 enum power_supply_type {
-- 
2.28.0

