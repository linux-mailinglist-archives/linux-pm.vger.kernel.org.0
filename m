Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66D8475C71A
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jul 2023 14:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjGUMrf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Jul 2023 08:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbjGUMr0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Jul 2023 08:47:26 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E1A3A82
        for <linux-pm@vger.kernel.org>; Fri, 21 Jul 2023 05:47:13 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1b8bbcfd89aso11428295ad.1
        for <linux-pm@vger.kernel.org>; Fri, 21 Jul 2023 05:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689943633; x=1690548433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d4/eRoqwSAGdi8LJemKHI/V1OYM9+swXufBrZM0hUXk=;
        b=yFN3/VyHs01yi924BoKQA3rrgUaD/Hl40Ot0j1gpDRx8j29mKVke8EQvqAdLCaQK4M
         6f/l8ErfCvpGw5LQz/pZ3hjukF7r4W5iVON++Vf79UYo0WmTMnAYbYiGEycqWmdA12ex
         TciPBsADja5tXbs8y9Uz4bmZ6M34xoiPNRlaF/Wyhku9Dpx5XcuSndO5MIyTelSDWo7m
         spITXGKc6NN1OMKi7e+1/XE78Lstba3baS5pBazCY6r8aa2wCN3jPKZMNhWZo3GnhTCf
         QNhdJWhkXOmC7Cpyj8PoynwM48Px4H3uYHPxtug+Cc/QpumNbJ52USlirX5bijsDp2Bn
         jpBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689943633; x=1690548433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d4/eRoqwSAGdi8LJemKHI/V1OYM9+swXufBrZM0hUXk=;
        b=Cw50DSc/P/Pkb11zJFSZweCwM3XQukYrrxMSm0ubzdA31SXm3R7ZllQCm1Gpsy6oV7
         YOmFrsBNOksGKmTTEokF5nW6QonC1wcc7daqIoiLWcY2F1aAV2XHxE5+XHxWQAcxYI4O
         RJok1Hf01aN8rnNLqw8DTbOWVU/2liJPB0dLoZo3YZ+tBcTX4J1o1srdu4mkn5bNtw7M
         BvRGedzL5mds8APpRNIDxBPKD5qqtE0sDWCHBpS/jTonfAzq0FC3a1TTIealT2QC1w+A
         RO094ZJiWmQ5Z6Zq9kwBB5guEoZfsHiLy3GZTbCKiKqK5sN9RAHj35duJbxvKDuAOPJw
         0WHA==
X-Gm-Message-State: ABy/qLa3pajf8+uIueI5XyI1XSj5UIjgk4z2ZGPXjxHL8Chvqiv9BZNT
        q41xjf53gjGk5nXfRkJb/h7H
X-Google-Smtp-Source: APBJJlEVBYU2bNbC3uokjbALDALmMS2/XNNHqv6ry6lL/rTHYP0iAZpZI/LXnzDkoB4IkkGjt0gAsA==
X-Received: by 2002:a17:903:110c:b0:1b8:525a:f685 with SMTP id n12-20020a170903110c00b001b8525af685mr1631050plh.37.1689943633295;
        Fri, 21 Jul 2023 05:47:13 -0700 (PDT)
Received: from localhost.localdomain ([117.206.118.181])
        by smtp.gmail.com with ESMTPSA id ix7-20020a170902f80700b001b8b2fb52d4sm3369828plb.203.2023.07.21.05.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 05:47:11 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 2/2] OPP: Fix passing 0 to PTR_ERR in _opp_attach_genpd()
Date:   Fri, 21 Jul 2023 18:16:34 +0530
Message-Id: <20230721124634.63612-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230721124634.63612-1-manivannan.sadhasivam@linaro.org>
References: <20230721124634.63612-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

If dev_pm_domain_attach_by_name() returns NULL, then 0 will be passed to
PTR_ERR() as reported by the smatch warning below:

drivers/opp/core.c:2456 _opp_attach_genpd() warn: passing zero to 'PTR_ERR'

Fix it by checking for the non-NULL virt_dev pointer before passing it to
PTR_ERR. Otherwise return -ENODEV.

Fixes: 4ea9496cbc95 ("opp: Fix error check in dev_pm_opp_attach_genpd()")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/opp/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 98633ccd170a..ae359ed6a161 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -2377,7 +2377,7 @@ static int _opp_attach_genpd(struct opp_table *opp_table, struct device *dev,
 
 		virt_dev = dev_pm_domain_attach_by_name(dev, *name);
 		if (IS_ERR_OR_NULL(virt_dev)) {
-			ret = PTR_ERR(virt_dev) ? : -ENODEV;
+			ret = virt_dev ? PTR_ERR(virt_dev) : -ENODEV;
 			dev_err(dev, "Couldn't attach to pm_domain: %d\n", ret);
 			goto err;
 		}
-- 
2.25.1

