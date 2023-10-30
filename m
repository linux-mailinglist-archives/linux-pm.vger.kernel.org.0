Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A719E7DB800
	for <lists+linux-pm@lfdr.de>; Mon, 30 Oct 2023 11:25:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233114AbjJ3KZB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Oct 2023 06:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233141AbjJ3KYr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Oct 2023 06:24:47 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C461995
        for <linux-pm@vger.kernel.org>; Mon, 30 Oct 2023 03:24:23 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1cc4f777ab9so4657825ad.0
        for <linux-pm@vger.kernel.org>; Mon, 30 Oct 2023 03:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698661463; x=1699266263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1N/2Vj2C4PIiKfPHSCW4+mtkbqzibb/OcJadYL0Oz5c=;
        b=yHEycjEW0VG2+u+jLQ13QzBh5JafkHVbuiYlSPXGgZa5v7ZhEJrcJ2CU5lb8dn8DOe
         xUgkLljiPcOKXkfgTsgBkTDZsg9YOGNWEWQi+5Aqssd3Ivj2gVUDE0r4v2Wocj8umKRo
         joLmnmckRiDnwXrhmDoyTlVGAl4hHMTY6e3bjYa2IpMqHzHxO7/3dBptqbokvAqMGHh4
         7NLvsMA86pxIxSHi04zJZV1ewtoRX/LpZrrBddIiFCo6hH19JuiCN8TmOZPV4NB3ls0D
         p9lSueXKkioW5lPQXgicZubvPciDA76/zQ/+14Q+Rwi09xOV8nX49HPBdWB9hUBUj/ul
         p3Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698661463; x=1699266263;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1N/2Vj2C4PIiKfPHSCW4+mtkbqzibb/OcJadYL0Oz5c=;
        b=HmDXTnRLkNDIPZaNa57comUoJ+FXOBoNc9miuU58IVKuQTVAzmcXPbP40VzJsdKkPw
         PB8preAXxJ1iWFYjR/HiDALpwMb+mvYuyD5lT+V7/IBDCprMaF9gKjkqNKB1UR4zSrs2
         gnxim1Fh3ggW39A94pX6zOqd5aQCE4Dh2iNwy6lvVmv8JlfjEsyzw9t89VStNSB2es+R
         7jAob9/fDFgyH+OkRveWhL7Vc5pVyfbSCO7N5Nki0FypOOQQqGmODop9VMtZ3jMbfkW5
         a/fuxmZr/l9tjxdKRNB1134vwBaAt9CQIWckm3MDDKPi7mGOB26cKiHvuDTs4xaxZ+4B
         ebRQ==
X-Gm-Message-State: AOJu0YwLCzlqc+MfGjrFSin6AnLuOT8SmX+PPONTyooaITWOOGXVPscD
        kceJbQk1NdYNod//iRgVP6LDAw==
X-Google-Smtp-Source: AGHT+IELQz5vCIEIK/PxKIFaPg7UmdGIp1vUHtveCLRcztnmaIm2nPugxTN1VWQQOzrKZy73LLrrBw==
X-Received: by 2002:a17:90b:1904:b0:280:16bb:8169 with SMTP id mp4-20020a17090b190400b0028016bb8169mr4115127pjb.40.1698661463214;
        Mon, 30 Oct 2023 03:24:23 -0700 (PDT)
Received: from localhost ([122.172.80.14])
        by smtp.gmail.com with ESMTPSA id s63-20020a17090a69c500b00263b9e75aecsm5641272pjj.41.2023.10.30.03.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 03:24:22 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Nishanth Menon <nm@ti.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 0/3] OPP: Simplify required-opp handling
Date:   Mon, 30 Oct 2023 15:54:14 +0530
Message-Id: <cover.1698661048.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello,

I wasn't able to test this locally (despite trying to hack it around) and need
help from someone who is `virt_devs` field of `struct dev_pm_opp_config`.

Pushed here:

git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git opp/required-opps

-------------------------8<-------------------------

Configuring the required OPP was never properly implemented, we just
took an exception for genpds and configured them directly, while leaving
out all other required OPP types.

Now that a standard call to dev_pm_opp_set_opp() takes care of
configuring the opp->level too, the special handling for genpds can be
avoided by simply calling dev_pm_opp_set_opp() for the required OPPs,
which shall eventually configure the corresponding level for genpds.

This also makes it possible for us to configure other type of required
OPPs (no concrete users yet though), via the same path. This is how
other frameworks take care of parent nodes, like clock, regulators, etc,
where we recursively call the same helper.

V1->V2:
- Support opp-level 0, drop vote i.e..
- Fix OPP pointer while calling dev_pm_opp_set_opp() recursively.
- Minor checks and fixes.
- Add Reviewed-by from Ulf.

--
Viresh

Viresh Kumar (3):
  OPP: Level zero is valid
  OPP: Use _set_opp_level() for single genpd case
  OPP: Call dev_pm_opp_set_opp() for required OPPs

 drivers/opp/core.c     | 176 ++++++++++++++++++++++-------------------
 drivers/opp/of.c       |  48 ++++++++---
 drivers/opp/opp.h      |   8 +-
 include/linux/pm_opp.h |  12 ++-
 4 files changed, 145 insertions(+), 99 deletions(-)

-- 
2.31.1.272.g89b43f80a514

