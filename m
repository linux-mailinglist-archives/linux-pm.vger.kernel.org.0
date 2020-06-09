Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF70B1F4983
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jun 2020 00:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728364AbgFIWps (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Jun 2020 18:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728108AbgFIWps (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Jun 2020 18:45:48 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E0EC05BD1E;
        Tue,  9 Jun 2020 15:45:47 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id w3so274909qkb.6;
        Tue, 09 Jun 2020 15:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bnajTCsYo//0LX6v48OVudY2hoQxnR0lPhAu3BVle9c=;
        b=J8DftvE3CnS7ZKX6nz4fGSSQWd5bh0hJqetE9b7SOKmSp94WHGu8gsy92YCXxo8FNo
         WC5PK/UaJZRC9YoL7WKrBKqmyIRcPCDFpnQMB3LXIaNXVCLljAjAqp/CkdNF3Nl6cq9U
         wtoYooGY7WxWT8C2PMvAR257F3NUY8goeaoSAehXAyDZlFUM17EwmfCtzBCZ05x8yG2x
         +119SZGLWC2I5lns6fzL2xjykKv8VV2NXPL4LfDX3+W6zxn05HlqRBHZqNGl4Xw6DE48
         CadmMPWu/eCeTs5LK9qhw0IqXdGsopGzJqomdGGsARyfQZad2X8MxLs3aTXiYxw/81oV
         9xKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bnajTCsYo//0LX6v48OVudY2hoQxnR0lPhAu3BVle9c=;
        b=IoRY+MLqjOJGokqiBPl08qQQx/maw3u6p01eXA1hlcRgVPos+eMcuSRhBolDVUcW+q
         qYxivyFLyozVrNI6B9uV9yG2TH0bI3c7+BPfuMroonS7jRWSeJsbGFP341BYu7LtMd0+
         ND9QErhUVYsDcQHR4X9KyPw4xruDO+dvtR81G2CsHnCfKQOVxR77kiyGQtFMkXVckHjz
         ZAMzhDteXLo1kHapd9vbXZWaJNtuj93tI/YtvepyI6nC5HqQOoRSCDBDZuijNYV4PFG4
         C3tG1JaDIkp/PTmNFSGjXcIx4I306l1jTu5myFQKrPmGMITQCP/HlvXOoGpIVbT9wg5H
         DCJA==
X-Gm-Message-State: AOAM530IcBNMv/AYPTxs/Nt3YyWAqQkLj1YDyFCruouG1KmmgdaTdPe1
        Qu6EUB1Ztc3d98BZg6cKmQ==
X-Google-Smtp-Source: ABdhPJy3OkPGQRSZZPsiFZzPVaGRJb/o3iSXN4EkyJCA80OAb7iK0e/0V0u0IDcCUZkx+xMzdQ9hzw==
X-Received: by 2002:a37:a20c:: with SMTP id l12mr232487qke.34.1591742746924;
        Tue, 09 Jun 2020 15:45:46 -0700 (PDT)
Received: from localhost.localdomain ([142.119.96.191])
        by smtp.googlemail.com with ESMTPSA id j5sm12698804qtc.72.2020.06.09.15.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 15:45:46 -0700 (PDT)
From:   Keyur Patel <iamkeyur96@gmail.com>
Cc:     Keyur Patel <iamkeyur96@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] power: supply: axp20x_usb_power: fix spelling mistake
Date:   Tue,  9 Jun 2020 18:45:23 -0400
Message-Id: <20200609224524.108092-1-iamkeyur96@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fix typo: "tigger" --> "trigger"

Signed-off-by: Keyur Patel <iamkeyur96@gmail.com>
---
 drivers/power/supply/axp20x_usb_power.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
index 4fde24b5f35a..d01dc0332edc 100644
--- a/drivers/power/supply/axp20x_usb_power.c
+++ b/drivers/power/supply/axp20x_usb_power.c
@@ -78,7 +78,7 @@ static bool axp20x_usb_vbus_needs_polling(struct axp20x_usb_power *power)
 	/*
 	 * Polling is only necessary while VBUS is offline. While online, a
 	 * present->absent transition implies an online->offline transition
-	 * and will triger the VBUS_REMOVAL IRQ.
+	 * and will trigger the VBUS_REMOVAL IRQ.
 	 */
 	if (power->axp20x_id >= AXP221_ID && !power->online)
 		return true;
-- 
2.26.2

