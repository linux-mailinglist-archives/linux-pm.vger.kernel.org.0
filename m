Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67E73780011
	for <lists+linux-pm@lfdr.de>; Thu, 17 Aug 2023 23:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355402AbjHQVnV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Aug 2023 17:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355426AbjHQVnN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Aug 2023 17:43:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F013FE4F
        for <linux-pm@vger.kernel.org>; Thu, 17 Aug 2023 14:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692308548;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=mE+FGvFznuoQJloAz1CbWUzmKetF4jOWg9oG8Wm7sqQ=;
        b=hjAa++VBgZMfzKDnGDwsmc5TyunAsRs8VbRcGZfr8zL2IvN4Tlo2iUITpYV1vIeD5X58oR
        9iIH/p1WFoVexmbORPPzBMk/GjTWri9ZT07/SC/C33r0vZQmx0dBOezVbVCwmZ9yOwTEgY
        Wqbv9JpxHhOH4/em6ujiW72kihgB7Yg=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-308-lqArqhguNUuEy5ZnVoHXfQ-1; Thu, 17 Aug 2023 17:42:23 -0400
X-MC-Unique: lqArqhguNUuEy5ZnVoHXfQ-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-64a5264b91eso2158116d6.1
        for <linux-pm@vger.kernel.org>; Thu, 17 Aug 2023 14:42:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692308543; x=1692913343;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mE+FGvFznuoQJloAz1CbWUzmKetF4jOWg9oG8Wm7sqQ=;
        b=WN5A7Jvm2oxOBQEJ+QG5GPY3wvb/99m7fYG8ONjvC4/q8XkA7wCbcI9AFULfYpufQ6
         oVBC/s7ArvYfE7h1zUCyLGdHR/RABOiunIgt4z3VN3Hg4xUEhzJg+VYFL/SIVR7kSY9H
         amSmyxDCeyS73tNUqQ8NdMbDk1h+ekVTAw6vfaZiHjnf0pzHabHQkJI1r56XhI5k/lNZ
         igkEq7X04Yk3S1yweWYmAf90puHAMz6jhTZhuycPMx9RoWYIc2b+i0KaxwLMOTLpjmrc
         CNv/NEecIDqMBTyx3LCMPuFyyZ14DVHuIqK5mR+cvdVidz4YU8at6naLNKMwlH+wXo3X
         6Mkg==
X-Gm-Message-State: AOJu0YwYfz1yGabs4mcgkPbSmHlKY+B5BbC+qqIQNaJ0Y1hl34MB/0Gi
        eFGQuSqnrhrxmll9kBX3kNzvXATNqFDXJcl1A3b8K+mDmwrPq9+4xhplSEqhQXHCIIoM7pnUlrI
        O1WtcJNn8vZRItyS/uN8=
X-Received: by 2002:a0c:8cc6:0:b0:649:384f:edc with SMTP id q6-20020a0c8cc6000000b00649384f0edcmr842540qvb.2.1692308542968;
        Thu, 17 Aug 2023 14:42:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlQxlxTWCZWOGLc6QQ5U5oniNuq0Hqp5AacLbd+dKUHE7JSvkqhThXLmevZxKdTf9eo8v5pA==
X-Received: by 2002:a0c:8cc6:0:b0:649:384f:edc with SMTP id q6-20020a0c8cc6000000b00649384f0edcmr842529qvb.2.1692308542733;
        Thu, 17 Aug 2023 14:42:22 -0700 (PDT)
Received: from fedora.redhat.com ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id s26-20020a0cb31a000000b006375f9fd170sm175854qve.34.2023.08.17.14.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 14:42:22 -0700 (PDT)
From:   Andrew Halaney <ahalaney@redhat.com>
To:     sre@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        bmasney@redhat.com, Andrew Halaney <ahalaney@redhat.com>
Subject: [PATCH] power: reset: nvmem-reboot-mode: quiet some device deferrals
Date:   Thu, 17 Aug 2023 16:41:57 -0500
Message-ID: <20230817214218.638846-1-ahalaney@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Some errors are being logged that are really due to deferrals,
which is confusing to users. Use dev_err_probe() to handle when to log
at error level versus debug. This also has the added bonuses of logging
to devices_deferred and printing the error value.

Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---
 drivers/power/reset/nvmem-reboot-mode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/reset/nvmem-reboot-mode.c b/drivers/power/reset/nvmem-reboot-mode.c
index e229308d43e2..41530b70cfc4 100644
--- a/drivers/power/reset/nvmem-reboot-mode.c
+++ b/drivers/power/reset/nvmem-reboot-mode.c
@@ -45,8 +45,8 @@ static int nvmem_reboot_mode_probe(struct platform_device *pdev)
 
 	nvmem_rbm->cell = devm_nvmem_cell_get(&pdev->dev, "reboot-mode");
 	if (IS_ERR(nvmem_rbm->cell)) {
-		dev_err(&pdev->dev, "failed to get the nvmem cell reboot-mode\n");
-		return PTR_ERR(nvmem_rbm->cell);
+		return dev_err_probe(&pdev->dev, PTR_ERR(nvmem_rbm->cell),
+				     "failed to get the nvmem cell reboot-mode\n");
 	}
 
 	ret = devm_reboot_mode_register(&pdev->dev, &nvmem_rbm->reboot);
-- 
2.41.0

