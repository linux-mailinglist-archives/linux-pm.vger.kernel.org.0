Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1466055D306
	for <lists+linux-pm@lfdr.de>; Tue, 28 Jun 2022 15:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236449AbiF0NsK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Jun 2022 09:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236504AbiF0Nrk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jun 2022 09:47:40 -0400
Received: from mx.kernkonzept.com (serv1.kernkonzept.com [IPv6:2a01:4f8:1c1c:b490::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 764B460C0;
        Mon, 27 Jun 2022 06:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kernkonzept.com; s=mx1; h=Content-Transfer-Encoding:MIME-Version:Message-Id
        :Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=RaLW/vTZggRxBtrthi9D9DjaJGvkjLJCvLqTZlR4Mxs=; b=EN4kWiayfD/kHjAClOkkmbcEaU
        hpzP+03G2n7RcVkrbVBtjb8kHhl26G86wzCscMGBJJANaSCtyumh2KliCIIOrWBaFKaBEzMrFvO5G
        Y7AMz1zkUh+DCCQpb9uqu/IEte5HjvuubXWdeUN4Bc6dwg7tqkzqujMaXqJDP4OMo5SrvsbSPE2WZ
        tKq5wy0SbC0kmadr0jRbk/QIx/nx/ljvJNAaH8NJ60FqMdiKD5/pBx+BFZ+4p3QC7TBRNs0ShXdtC
        erKbj5zIBhx4X0NZCkLuROC+duqMYD/+9XdJuyQBYd/kYRwyhI3BjITfXsAFkOiJTfO5bJgWFCetQ
        1sC1PVeQ==;
Received: from [10.22.3.24] (helo=kernkonzept.com)
        by mx.kernkonzept.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2)
        id 1o5oa0-006Cqx-Ss; Mon, 27 Jun 2022 15:15:04 +0200
From:   Stephan Gerhold <stephan.gerhold@kernkonzept.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Subject: [PATCH 0/3] thermal: qcom: tsens: Add data for MSM8909
Date:   Mon, 27 Jun 2022 15:14:12 +0200
Message-Id: <20220627131415.2868938-1-stephan.gerhold@kernkonzept.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The MSM8909 SoC has 5 thermal sensors in a TSENS v0.1 block similar to
MSM8916. Add the data for MSM8909 to the existing tsens-v0_1.c driver
to make the thermal sensors work on MSM8909.

Stephan Gerhold (3):
  dt-bindings: thermal: qcom-tsens: Drop redundant compatibles
  dt-bindings: thermal: qcom-tsens: Add MSM8909 compatible
  thermal: qcom: tsens: Add data for MSM8909

 .../bindings/thermal/qcom-tsens.yaml          |   6 +-
 drivers/thermal/qcom/tsens-v0_1.c             | 119 +++++++++++++++++-
 drivers/thermal/qcom/tsens.c                  |   3 +
 drivers/thermal/qcom/tsens.h                  |   2 +-
 4 files changed, 123 insertions(+), 7 deletions(-)

-- 
2.30.2

