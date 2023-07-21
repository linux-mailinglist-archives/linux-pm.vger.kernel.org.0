Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7B3C75C710
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jul 2023 14:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbjGUMqm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Jul 2023 08:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbjGUMql (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Jul 2023 08:46:41 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A7E11FD2
        for <linux-pm@vger.kernel.org>; Fri, 21 Jul 2023 05:46:40 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1b895a06484so12300215ad.1
        for <linux-pm@vger.kernel.org>; Fri, 21 Jul 2023 05:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689943600; x=1690548400;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6zQgah8l1vKz74ZiyPPiZTC9+SEnB68j607ayO7edRA=;
        b=EkR48rlCylKbWRyFGflFdiqz4VIXbJ7CclwjpysY78JPhboowbWw+4rpIoQ9EOPWIY
         fM6cR/amj4Tk3yZRF4YEaXw7CpzYUaKus3T13xcAwdlX27Kou9JDn07P9ziFxSikGvNP
         otmr58g46bhRm2e/7nal98SnDUsxCdvk61luPL2Q2mgg0PdD3UZ7qL4L9088RabwNQZt
         r28hrukJyebHETVTr3mYywphyQqEYyRRsbMiZBL4zMpV5TneC4icWDb0i/sOoPrECc7P
         PKswr+06l25z8TAS31OVBm+SvsxK9nIltz1o4PQFp8vCO/cBUura6C8eJxFhmSU/8PVM
         oFzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689943600; x=1690548400;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6zQgah8l1vKz74ZiyPPiZTC9+SEnB68j607ayO7edRA=;
        b=kVQOYdGJSiN0F9Td+rtpOpMTJzN4/R9Y2D8lVg+sFNv293GqYH/HhULSi431Tp2yCK
         E1vgdqE44Dc3gKNtgUTvU7EctEYWn2L73mKtZCluEmrUlpBZW1HIss7sMrC27+2SYqZe
         x+R6v5JjmA43dtFPzdH/l/9xfJ/KBE7K6dbkWs4wZy6giWGRsJEuO57CB+0I0B+cGXGt
         8AntdKONAEreHeBfekd2k5uzpRoUU5CKfFIG6CQMA8Lr6n4FYo0X5LReCMOYlyiYpOtT
         JYzSX4uiNC+eci01jtRO8UQlgap5pfwgblCW7oEFFNCFUwoC+i8saebcWUlJ6rGiLc0Y
         814w==
X-Gm-Message-State: ABy/qLY+9sAuy/hVaGJm1f5oR8DFLYjuEhdKp5R09hFWuEkmPms0lPhY
        Pxqw5K8DhZSFurYynv88WgFo
X-Google-Smtp-Source: APBJJlF9JdPD5C4imn3/JC07LHYN8fPCwKjzTPD9OhuV0sgWEIRjyjoaQDYqpNMs1s4AwAldwbJb3g==
X-Received: by 2002:a17:902:cec3:b0:1b8:59f0:c748 with SMTP id d3-20020a170902cec300b001b859f0c748mr1683432plg.2.1689943600114;
        Fri, 21 Jul 2023 05:46:40 -0700 (PDT)
Received: from localhost.localdomain ([117.206.118.181])
        by smtp.gmail.com with ESMTPSA id 10-20020a170902c14a00b001bb3dac1577sm3385540plj.95.2023.07.21.05.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 05:46:11 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 0/2] OPP: Couple of smatch warning fixes
Date:   Fri, 21 Jul 2023 18:15:41 +0530
Message-Id: <20230721124543.63520-1-manivannan.sadhasivam@linaro.org>
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

