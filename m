Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 272BE2F25CE
	for <lists+linux-pm@lfdr.de>; Tue, 12 Jan 2021 02:51:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729244AbhALBuZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Jan 2021 20:50:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728096AbhALBuY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Jan 2021 20:50:24 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B45B3C061794;
        Mon, 11 Jan 2021 17:49:44 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id z21so377506pgj.4;
        Mon, 11 Jan 2021 17:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=GJKvVFF6BG5j6jp3R+XRxhhlsqhgUNhX6xscnGvZtxE=;
        b=vAa+VrnKptoQghKEhMBe5DtquPscVcCJMSilw5x9UdJt8mKsrrbzxx7ASlokeAX7Dp
         NayahW7rgqgKLGSzgqWTg8WF3b09Jqy8vtJnmdg8qWoDxeUt44/DCdLcprRzRUZ5Pc3H
         CWfTFmYWcJ2WYi9G9KsL4GJUKrG6bNG0QiXAHqHdD6bv0iSF89mHl159wPVUbsHKsv0t
         H4aEslDDX3zWXf9VmWRsUHkBL/H8YsS79ccG3EDNd2ZwjG63fpAHAPPwthQQbVYkFUfU
         rLbfOkrbin42fRFl9+QlWzNv/vuw7o3pnDhHF5ABrd+n41cKBqhmtKm8/5TXX+yiZ7fM
         Hoxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GJKvVFF6BG5j6jp3R+XRxhhlsqhgUNhX6xscnGvZtxE=;
        b=XtaCpC3i/IGMgQl2StAMA1LCewFpGn8QN3cqn1CFYT1Z/IMOPp+PMYcV7Tvycf1QLK
         ukCk8upZqXlQm2pO5T+oM24MWiB9olH3z4mgsSf7fOStczys9MFkRJrJVLE6dtJSXao8
         ofIlpny2iNbFmwlRR622AX2KauQAEtRbKGehWjm3s55LLhfXAC759b6jeYmuxoGnA67f
         U9xlCy2T3vSmGvIlYJGyV/M12YLrFCdvXhGYNvccwCVNcAVy91sFBJpzKvrw4Mu/223U
         P305MbIMf4SMQG54hjImXTJk3xcR9/CiUnEMjzrhwD0bzvUWarNQzCqtoFoeHvYVX53D
         3HzA==
X-Gm-Message-State: AOAM531xbkrZNp5M9PilVKzkYjCkF5w+eNnUbhC82/qZW/xJXAHpiIjh
        Psvb1GB/p6wdHKcHvlnUS2tB7qiTahg=
X-Google-Smtp-Source: ABdhPJwTjSgLvOwSRrsPcUbkwVH3r3lSAG1j9I05aFHLjAEuvHTu/AiW7gtm+QJkZH4zdFVXE+hffA==
X-Received: by 2002:aa7:9f97:0:b029:1a5:94d8:9cbf with SMTP id z23-20020aa79f970000b02901a594d89cbfmr2113151pfr.79.1610416183868;
        Mon, 11 Jan 2021 17:49:43 -0800 (PST)
Received: from localhost.localdomain ([178.236.46.205])
        by smtp.gmail.com with ESMTPSA id u11sm734033pjy.17.2021.01.11.17.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 17:49:43 -0800 (PST)
From:   menglong8.dong@gmail.com
X-Google-Original-From: dong.menglong@zte.com.cn
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Menglong Dong <dong.menglong@zte.com.cn>
Subject: [PATCH] power: supply: remove duplicated argument in power_supply_hwmon_info
Date:   Mon, 11 Jan 2021 17:49:31 -0800
Message-Id: <20210112014931.5429-1-dong.menglong@zte.com.cn>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Menglong Dong <dong.menglong@zte.com.cn>

'HWMON_T_INPUT' and 'HWMON_T_MIN_ALARM' in power_supply_hwmon_info are
duplicated and can be removed.

Signed-off-by: Menglong Dong <dong.menglong@zte.com.cn>
---
 drivers/power/supply/power_supply_hwmon.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/power/supply/power_supply_hwmon.c b/drivers/power/supply/power_supply_hwmon.c
index 7fe4b6b6ddc8..bffe6d84c429 100644
--- a/drivers/power/supply/power_supply_hwmon.c
+++ b/drivers/power/supply/power_supply_hwmon.c
@@ -299,13 +299,11 @@ static const struct hwmon_channel_info *power_supply_hwmon_info[] = {
 			   HWMON_T_INPUT     |
 			   HWMON_T_MAX       |
 			   HWMON_T_MIN       |
-			   HWMON_T_MIN_ALARM |
 			   HWMON_T_MIN_ALARM,
 
 			   HWMON_T_LABEL     |
 			   HWMON_T_INPUT     |
 			   HWMON_T_MIN_ALARM |
-			   HWMON_T_LABEL     |
 			   HWMON_T_MAX_ALARM),
 
 	HWMON_CHANNEL_INFO(curr,
-- 
2.17.1

