Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DED25832B7
	for <lists+linux-pm@lfdr.de>; Wed, 27 Jul 2022 21:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbiG0TDi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Jul 2022 15:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbiG0TC6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Jul 2022 15:02:58 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF82262D
        for <linux-pm@vger.kernel.org>; Wed, 27 Jul 2022 11:20:36 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id k19so251128ljg.0
        for <linux-pm@vger.kernel.org>; Wed, 27 Jul 2022 11:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Pfz4ucLua8Uf/3c1EnbcfE9Jss18H9ObDxnKPg92bNA=;
        b=r3JdHvFvd/BmJ7+OQbTmw6h12geAftWU58MlN65plTwUZOZF8EKRclSeeaCcStmsdd
         Ifo9YqtCLjRQIh6jz/Xjb+A9FG2CUFWIGjdd2ovCNtgyjTdpl95LkiZJmgY3Wwws2sCj
         O/T3atapdONt77sd5xTCVqsOEibooq6GNJxwuafoss5tr9ZhX/Ph5wKEgAhBvXPHcI2r
         +HFoYIOIZejk4t+8Bb0R4vpRDMYeN9puN9bIvwinBimQMiy2ykXIa3f5JnllV5lcAPWz
         iJQ7IC4nJMPw5JJvxc4gdYC27e73XhYvbd5FLuiFH7PpJShrJS8XeyYMjU51aSQPQ9ul
         nhjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Pfz4ucLua8Uf/3c1EnbcfE9Jss18H9ObDxnKPg92bNA=;
        b=blMvRYbJiL2e1gyrmDarLQiFwFWcf6jdIH0sawylGiFeL46A86z0WYX9BIz4PwB7TS
         aAYdMkpaeYuOEWMW0M9SBsBtjuuo5NL/qigFdgx82oOWRNeIdmVaXIAvHsrqSVYj+IaQ
         HeebZHdvlyAVk1ajbaXap9RyEQiSITSBGWoT78huTDw689C8HxKyAGjJLVDpZXdn77lM
         OmlEDdQrntl2lPf2WAiw7JlB5k4/G+Tjmngt+7AqqB39HGnF5edVc2zDlYYDgET5kgSG
         yQenPlPv1QgqCw3QXoMWZY5ce80fnSfGtkRjUXNLmdOln3r5ztSTBfyVO//NhChuOxNi
         BBKg==
X-Gm-Message-State: AJIora/7UukxL6im3AHSHO0JUz7m8hnP2gCkhjHRt7sZ8Q/R4SG7rNjB
        DpX/gxuwJmKVyC8gLiQKdYc5POWPpWAezg==
X-Google-Smtp-Source: AGRyM1tvNOnLvQMG3h/BExaz3Z0xrLsDolUoR6VfIRtzQ2/GOVPeGc/UPBnV0muwc8DoKRc8SgnOxw==
X-Received: by 2002:a2e:b057:0:b0:25d:fc4a:5b6 with SMTP id d23-20020a2eb057000000b0025dfc4a05b6mr6878322ljl.24.1658946035272;
        Wed, 27 Jul 2022 11:20:35 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id bg35-20020a05651c0ba300b0025d2d495dc6sm1118764ljb.66.2022.07.27.11.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 11:20:34 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Subject: [PATCH] PSCI: Print a warning if PSCI doesn't accept PC mode
Date:   Wed, 27 Jul 2022 21:20:34 +0300
Message-Id: <20220727182034.983727-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The function psci_pd_try_set_osi_mode() will print an error if enabling
OSI mode fails. To ease debugging PSCI issues print corresponding
message if switching to PC mode fails too.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/firmware/psci/psci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index cfb448eabdaa..b907768eea01 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -597,7 +597,9 @@ static int __init psci_1_0_init(struct device_node *np)
 		pr_info("OSI mode supported.\n");
 
 		/* Default to PC mode. */
-		psci_set_osi_mode(false);
+		err = psci_set_osi_mode(false);
+		if (err)
+			pr_info("setting PC mode failed with %d\n", err);
 	}
 
 	return 0;
-- 
2.35.1

