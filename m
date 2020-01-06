Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CFA31316AC
	for <lists+linux-pm@lfdr.de>; Mon,  6 Jan 2020 18:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbgAFRXC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Jan 2020 12:23:02 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43705 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgAFRXC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Jan 2020 12:23:02 -0500
Received: by mail-pg1-f194.google.com with SMTP id k197so27155243pga.10;
        Mon, 06 Jan 2020 09:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=1MK9kUc0jX8rAAIchK2uS4ItaDoeL81cSWlyOyK2j0s=;
        b=SNvT7iq8lECZ1X0YdoS1NvCMSUi4BP49DiLhty8aZ8UcBl2KYBO8M+edKmsW6f2yIa
         WFvpFxuHWiiYF6f68ivKNiXlnBxgb3dly5RshXXCLQ/uD5cE85LfGXSg4JQHMnMo+CkS
         p7WuKO0PoUEfNOtX982SNWOjVx8q5xPajHM0HSlL/cyZb/imeiC3bUWj4pApX9ME8ILW
         jdN+qWyRsyYPUjnQu8Ss7MANBR1COIwOvKPDy8xdFzevhcOrjqfbU15BxlNViFcOXbMq
         tB2wX2bieUO5XNSqPwznLejXP/3QXS/rtTI+Ib9os075D5GWFQzJKekZtt9HrCnpLG6H
         YjwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=1MK9kUc0jX8rAAIchK2uS4ItaDoeL81cSWlyOyK2j0s=;
        b=rjM8VWaEi4vioxzF8D6g8QblIqp0CSjo4RXl3Qawc8iO90a5vYYycpYhONjOveInif
         WRcp7N0Y6s8q1llT55Z4tUdzRHUWp/PMZe+FMVX8zyASot8v0WP+mCTNTBdfN/1uUwZS
         Fr8IdcuHKT7gAlrmjxXjtDG/r+bY7hmYDlZluXntyTGPV3hdWCeUpBR3pZ1TpN/9dcUj
         B1dlT5dYipHIQHrPu0GYpaOs4vKuz6Lx8WimoanLWRnAuhZjwSwf/9l3iI/Dm/CW30AN
         PO7iTjodbgKRVTRdSk4/2Wk/VKAt8BpUAkV7Bpps2LWY2hsWpBB2Ga0EMFWRvtDJ/fg9
         8GwQ==
X-Gm-Message-State: APjAAAXhFQrO0u0C3NR6zSygNBCJTtYF4E8ZxBml+zBGKZPPqzhyQjKC
        KbYKk72nPW/jISCUH9LqdkM=
X-Google-Smtp-Source: APXvYqx5UbsJIQe4FQTlo4Bt4g3zdXkXPsVMVY+y9pSKn2SCnT6wGXwes+jaWpECdIIRdftW0A5d2A==
X-Received: by 2002:a62:4d87:: with SMTP id a129mr108865731pfb.116.1578331381826;
        Mon, 06 Jan 2020 09:23:01 -0800 (PST)
Received: from localhost ([2001:19f0:6001:12c8:5400:2ff:fe72:6403])
        by smtp.gmail.com with ESMTPSA id r3sm79483499pfg.145.2020.01.06.09.23.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Jan 2020 09:23:01 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, mripard@kernel.org,
        wens@csie.org, anarsoul@gmail.com, tiny.windzz@gmail.com,
        rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amit.kucheria@verdurent.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH 1/2] thermal: sun8i: fix r40 ths number
Date:   Mon,  6 Jan 2020 17:22:53 +0000
Message-Id: <20200106172254.20271-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

According to the spec, r40 has 2 thermal sensors.
Sensor0 located in the CPU, another in the GPU.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
Tested-by: Corentin Labbe <clabbe.montjoie@gmail.com>
Tested-on: sun8i-r40-bananapi-m2-ultra
---
 drivers/thermal/sun8i_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
index 23a5f4aa4be4..c5661d7c3e20 100644
--- a/drivers/thermal/sun8i_thermal.c
+++ b/drivers/thermal/sun8i_thermal.c
@@ -565,7 +565,7 @@ static const struct ths_thermal_chip sun8i_h3_ths = {
 };
 
 static const struct ths_thermal_chip sun8i_r40_ths = {
-	.sensor_num = 3,
+	.sensor_num = 2,
 	.offset = 251086,
 	.scale = 1130,
 	.has_mod_clk = true,
-- 
2.17.1

