Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 879DF75C712
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jul 2023 14:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbjGUMq5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Jul 2023 08:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbjGUMq4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Jul 2023 08:46:56 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D2830E6
        for <linux-pm@vger.kernel.org>; Fri, 21 Jul 2023 05:46:53 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-666e97fcc60so1292696b3a.3
        for <linux-pm@vger.kernel.org>; Fri, 21 Jul 2023 05:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689943613; x=1690548413;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6zQgah8l1vKz74ZiyPPiZTC9+SEnB68j607ayO7edRA=;
        b=G5KHo2h7G9koTCqzvveoMDhaPAToLg33uPVR0zIYq9xq90wAyZB69U1A4hXYSk4G1s
         m6bH9R8jXTepmJrFdG/Ot567RV92EoZeHdxmdiRoLhwQNhHEq8kJ030s+AnUNo7xwosB
         9/MqVpZ7L6Wo8rPu5LVoEHWAgNA2eT07704LvVrH62DGbmeGrQopx+nQ6hFACLWPd3gF
         zHJgEpG3kb3pUUhd+2Kx7kgf6YQjcrqYZv+8BCNB02fNJITd4mosVnBzBwVbGrNnen6S
         MrlNfw8kgdRvv0S+4V3TeFZ98dANT3BuLn6BGdE2wkYiEof5AQcWXjBk+LML5WbY/1nk
         VYEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689943613; x=1690548413;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6zQgah8l1vKz74ZiyPPiZTC9+SEnB68j607ayO7edRA=;
        b=dd/itPnaqTkiAMoF+JegOichnlqAiTAn1cg7u2xIHPvUHFpO8YUXbCncqBPzARZPJW
         kWcRSP4bfoMgnvE8NpW1IDr5m+RR9CPkQdKqt44/o130Nl/bOQBnHjtIjBAPPU4H7bwb
         EZOuMWs0QHOs7jN6b08qeDcn09MQjEesPbEttUnR16KmEYo9hVrTSJz5MG461SC8EsaA
         T9e9Jlex0ccDwSbZf47d4dw3Xc0rWRs9I5KQzOLVQhbNCfvjuSEhTDg546DyyJqedqTX
         xpBLkJeQdiSxC0sOr2hjp/xg3ZqbFTZxplUIq3TlqgcXxLlP9uL35o1d6YnrKH01T/Px
         IWjw==
X-Gm-Message-State: ABy/qLZcneWJnc7BuWVxNLT24w5a67cMLdkLsn/j92lsTj+6dZ99dmZ4
        Z0IwQyuJQnGVFpZcwEMf8Lz9
X-Google-Smtp-Source: APBJJlFrrA1VhQAe+ixoM1tRDS6vS/Qi3n96dpLcI+I35eOO23hrH0zqseX3c53/iEZ0t1GRnk1oiA==
X-Received: by 2002:a17:902:6b05:b0:1a6:b496:4053 with SMTP id o5-20020a1709026b0500b001a6b4964053mr1284504plk.59.1689943612820;
        Fri, 21 Jul 2023 05:46:52 -0700 (PDT)
Received: from localhost.localdomain ([117.206.118.181])
        by smtp.gmail.com with ESMTPSA id ix7-20020a170902f80700b001b8b2fb52d4sm3369828plb.203.2023.07.21.05.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 05:46:48 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 0/2] OPP: Couple of smatch warning fixes
Date:   Fri, 21 Jul 2023 18:16:32 +0530
Message-Id: <20230721124634.63612-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Viresh,

This series has a couple of fixes spotted by smatch tool in the OPP core.
This is on top of v6.5-rc1, so could be merged separately.

- Mani

Manivannan Sadhasivam (2):
  OPP: Fix potential null ptr dereference in
    dev_pm_opp_get_required_pstate()
  OPP: Fix passing 0 to PTR_ERR in _opp_attach_genpd()

 drivers/opp/core.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

-- 
2.25.1

