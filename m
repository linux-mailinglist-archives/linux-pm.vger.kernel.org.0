Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31FAF12C246
	for <lists+linux-pm@lfdr.de>; Sun, 29 Dec 2019 12:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbfL2LRP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 29 Dec 2019 06:17:15 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43517 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbfL2LRO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 29 Dec 2019 06:17:14 -0500
Received: by mail-pf1-f194.google.com with SMTP id x6so15904385pfo.10;
        Sun, 29 Dec 2019 03:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CWcFnXWGF5wNXnWL6+mku0hEs4gyByTrr98UCBl3J8k=;
        b=s6B6hYhmAqvRF/SCprnVyHpS6bysZxdnjpdCh+f14JrSZESME8pGx9OuMy4vz4uJJv
         wV8sGUlYu13+vM6rSlG5+B1f4PAXf1+L+fJsXv/pRbNqV2uxaYa+8PKZlGl9SAgiD0rt
         vfdttf4ORy+nrDCZxC6NA/wHrfEcArU9TL9hw4lyEmjPjV7Rui3akpKWED3KVNvXrIX/
         ioIc6CNj3YL8L/Q2QxFOIL379LRRDWJ4zxZf123HlK9GPTEa1CKdAC8VXmrZJdWNwHDM
         b9MJNvUvS+WUtm7lHALJa/9K9WFYv5RfX9uNFElGGWzRq0iAYokddATijdmAc0DmPl9S
         zCkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CWcFnXWGF5wNXnWL6+mku0hEs4gyByTrr98UCBl3J8k=;
        b=Kcu5H2Y/h9il7eNMg0Le8WvrZx1YAsUA3jIbEljt6s3iPyoNRMmVLZMUL3+nCW4KpK
         KI//WQZ242GgdpsIHFYB8AhmSsT10iF/gR32Tb2g/mIGjwkHfqiocCVFe+Pz5GRIL0k5
         s32U8clMJ0EFfI57EAbu/j3HWMpSNytoAPmV6J1zVvtinn93qTS1iIK5YKuK8lx7E7mp
         ejClX+j55hP9ulx3naVLq9DX7dTx1y3DLE/njeyzXI8NyZYfzol6YaEBLJ3HsRAMNAxq
         qKvAgMwrhyW311ivEStTzqoBhZEGSLKfsfL8WO4VkbHrq3OASgL+AiCHRmV+/I/c/qrx
         GekA==
X-Gm-Message-State: APjAAAWm4jfzqUTX7+fg6S+qG80dEvZ4VDuqZtFFC47xvs5L1pS5PUxl
        xl2BlNe3aFOwDn4+1gvyb3g=
X-Google-Smtp-Source: APXvYqwT9xK+ZGyFuhdZ2wLiXj9H1+mGiq49z7Hp29rcIkeDYbasZfv4ZBZcp7vOfBHA3DIC/zyigA==
X-Received: by 2002:a62:cece:: with SMTP id y197mr67311817pfg.9.1577618234053;
        Sun, 29 Dec 2019 03:17:14 -0800 (PST)
Received: from localhost ([2001:19f0:6001:12c8:5400:2ff:fe72:6403])
        by smtp.gmail.com with ESMTPSA id q7sm20794572pjd.3.2019.12.29.03.17.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Dec 2019 03:17:13 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     linux@armlinux.org.uk, mripard@kernel.org, wens@csie.org,
        catalin.marinas@arm.com, will@kernel.org,
        clabbe.montjoie@gmail.com, tiny.windzz@gmail.com, plaes@plaes.org,
        shawnguo@kernel.org, olof@lixom.net, Anson.Huang@nxp.com,
        dinguyen@kernel.org, leonard.crestez@nxp.com,
        marcin.juszkiewicz@linaro.org, aisheng.dong@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        anarsoul@gmail.com, rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amit.kucheria@verdurent.com, p.zabel@pengutronix.de
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH 2/2] ARM: sunxi: Enable CONFIG_SUN8I_THERMAL
Date:   Sun, 29 Dec 2019 11:17:07 +0000
Message-Id: <20191229111707.16574-2-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191229111707.16574-1-tiny.windzz@gmail.com>
References: <20191229111707.16574-1-tiny.windzz@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Many sunxi based board needs CONFIG_SUN8I_THERMAL for thermal support.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 arch/arm/configs/sunxi_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/sunxi_defconfig b/arch/arm/configs/sunxi_defconfig
index 3f5d727efc41..e9fb57374b9f 100644
--- a/arch/arm/configs/sunxi_defconfig
+++ b/arch/arm/configs/sunxi_defconfig
@@ -85,6 +85,7 @@ CONFIG_BATTERY_AXP20X=y
 CONFIG_AXP20X_POWER=y
 CONFIG_THERMAL=y
 CONFIG_CPU_THERMAL=y
+CONFIG_SUN8I_THERMAL=y
 CONFIG_WATCHDOG=y
 CONFIG_SUNXI_WATCHDOG=y
 CONFIG_MFD_AC100=y
-- 
2.17.1

