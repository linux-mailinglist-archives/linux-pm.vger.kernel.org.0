Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 504633B99AE
	for <lists+linux-pm@lfdr.de>; Fri,  2 Jul 2021 01:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234833AbhGAXqu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Jul 2021 19:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234478AbhGAXqa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Jul 2021 19:46:30 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB246C0613E0;
        Thu,  1 Jul 2021 16:43:57 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id e3so2378832ljo.6;
        Thu, 01 Jul 2021 16:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BFXR8UJAJfYBsWt7j+dPhOe713FxNJqHeaZ6mJiooJo=;
        b=OUfsTB8bvlLJNIZhdqmNr++UFcXGH0jWJjdQMhOiMZDxIJ+oOW7xYX3hyo20nfWd7x
         5BWpr9NRU0XmjSR2fmXHU25hPm1UCvLGJcV7cE48RUGM3OB6Oz0wne0IGFaufpDDDyX2
         ynoQCzsL2SuwtC1nHLuzyfEacRFsWrlrRSmX/0d7SgPwZQgliSDy5cGoWs2ga343ZUGf
         gXpQ8lvGof7Lt0kVJovGC3oV0sRgxaaIjZdH5e/lqLnMKj8WZ7My78PbmOmzJYVqdwhH
         KJGktRs7Eux1pDN1YTotgAxSHSK65hpYUgj+fhw88UBveCjdawWFTNUi8NgZsIU4LLv7
         9BsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BFXR8UJAJfYBsWt7j+dPhOe713FxNJqHeaZ6mJiooJo=;
        b=KIdXRPKFho81KmIXr3e83DJ5UBnMPHRpv4zBB9ByrIvPGVbW3yvaZA6B7iW4EwBMbK
         njM+ku+305DSiogTlpUau4Fgyz1haOdrkTVt3rSz3LApH/HcW75ztWw4w/Qny07Ln67R
         r/wqz06gx1K60FghdjZyNc3Jk3hEFj2gvIREtis72nnsQRAlhRdNpohdL+XGMwiOgeat
         5qZ0NLhpc065/FdUyznXTTsbAFE0hwHz96exMbFvjwjWTAhY3JGP36tt2X7E9CVeahIn
         Pd0pOzkXapPOQV3NQxqe5T+TBMuVdFdD1kzJno1CGv1Lt3Oo7/Vulu55enr8jqfSR553
         oKQg==
X-Gm-Message-State: AOAM530uGSBYqDFhW2lNmj18vvBn2TilySQaQ/AUgi50Kty1QbeprLq7
        /Wdc0DOFsU4So3mhuV6Wk9Y=
X-Google-Smtp-Source: ABdhPJzMtsGaG5qcBU/pIh2Vxo8U0DoeGY3xa0hBfW7aaqPkvfVqJv/4RcD3HrWkjmJO0m7BYhI1oA==
X-Received: by 2002:a05:651c:2cb:: with SMTP id f11mr1539629ljo.174.1625183036211;
        Thu, 01 Jul 2021 16:43:56 -0700 (PDT)
Received: from localhost.localdomain (94-29-37-113.dynamic.spd-mgts.ru. [94.29.37.113])
        by smtp.gmail.com with ESMTPSA id e23sm60743lfq.221.2021.07.01.16.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 16:43:55 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Peter Chen <peter.chen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        David Heidelberg <david@ixit.cz>
Cc:     devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH v2 08/12] power: supply: smb347-charger: Remove caching of charger state
Date:   Fri,  2 Jul 2021 02:43:13 +0300
Message-Id: <20210701234317.26393-9-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210701234317.26393-1-digetx@gmail.com>
References: <20210701234317.26393-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Regmap already provides us with the caching, so remove caching of charger
state to make code cleaner.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/power/supply/smb347-charger.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/power/supply/smb347-charger.c b/drivers/power/supply/smb347-charger.c
index db1378b41f80..f81c60c679a0 100644
--- a/drivers/power/supply/smb347-charger.c
+++ b/drivers/power/supply/smb347-charger.c
@@ -135,7 +135,6 @@
  * @id: SMB charger ID
  * @mains_online: is AC/DC input connected
  * @usb_online: is USB input connected
- * @charging_enabled: is charging enabled
  * @irq_unsupported: is interrupt unsupported by SMB hardware
  * @max_charge_current: maximum current (in uA) the battery can be charged
  * @max_charge_voltage: maximum voltage (in uV) the battery can be charged
@@ -192,7 +191,6 @@ struct smb347_charger {
 	unsigned int		id;
 	bool			mains_online;
 	bool			usb_online;
-	bool			charging_enabled;
 	bool			irq_unsupported;
 
 	unsigned int		max_charge_current;
@@ -358,21 +356,13 @@ static int smb347_charging_status(struct smb347_charger *smb)
 
 static int smb347_charging_set(struct smb347_charger *smb, bool enable)
 {
-	int ret = 0;
-
 	if (smb->enable_control != SMB3XX_CHG_ENABLE_SW) {
 		dev_dbg(smb->dev, "charging enable/disable in SW disabled\n");
 		return 0;
 	}
 
-	if (smb->charging_enabled != enable) {
-		ret = regmap_update_bits(smb->regmap, CMD_A, CMD_A_CHG_ENABLED,
-					 enable ? CMD_A_CHG_ENABLED : 0);
-		if (!ret)
-			smb->charging_enabled = enable;
-	}
-
-	return ret;
+	return regmap_update_bits(smb->regmap, CMD_A, CMD_A_CHG_ENABLED,
+				  enable ? CMD_A_CHG_ENABLED : 0);
 }
 
 static inline int smb347_charging_enable(struct smb347_charger *smb)
-- 
2.30.2

