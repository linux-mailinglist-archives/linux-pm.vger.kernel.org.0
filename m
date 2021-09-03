Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08D9D40083C
	for <lists+linux-pm@lfdr.de>; Sat,  4 Sep 2021 01:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350748AbhICXZ0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Sep 2021 19:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350746AbhICXZ0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Sep 2021 19:25:26 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95FC2C061757
        for <linux-pm@vger.kernel.org>; Fri,  3 Sep 2021 16:24:25 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id i28so1150927ljm.7
        for <linux-pm@vger.kernel.org>; Fri, 03 Sep 2021 16:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IUwnbvSZ0rkQ9qg3kU6ANLBK6G3PxyD2rj1Sq6Ru594=;
        b=sUGNY1nPTcv0fVc209lJ/yYIFXgs5/3ZpdMTXfK6IkUFdSDaW4BtX+u5XrbRVE1UzF
         bcAKLSt9aucssUZqcQKTX0zkfFTAkQw+xunw0LKAJ8avPqlCa1irC8y5M8jAT2P2sDaz
         fbrHUaUhJhal8sC4tDVOcqzu89CqngfIxaDE0s31Cgx1LQ/L+8XD7ilUgc0nbUM5rZku
         OYTP5rRNdcuD9kcHB7RXGw6prZcCxD2zgAGBelnTHYYQj/defl81Jx4EOHJQ1Wl/GdVe
         jAajhz47/DvdoLtA6ovWWV2gA3d8vkZiyZiHUpGXJYUWsTGBGQRYNjmPTfevI9n49krD
         ziXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IUwnbvSZ0rkQ9qg3kU6ANLBK6G3PxyD2rj1Sq6Ru594=;
        b=m2+dsHrGvBNHvHX/p54w36bwVHYIsGdTff3P28tAbYNy4CwzvTS+PcY1QMiCebygcC
         Bmex72KN21miP/6E2yl1ccX3gbdQyI9fgQ+DYP5bf2eHUVVmqTM/OafGyGIlnD5HsDXE
         ORaPm6wOT+oZYDeu0PRuCjw4BCY5rXGTT3kF4y6e3tsaF/YeLTYguVwhFR8au1VhEb+V
         nkXU37tLxZxlbMD1/OA33nRxJNbem0eCYiW2btK1H2I/w62Sxqi6/k2a7c7e6bLxpDqX
         YzL5vXaWbWY9+uEsVCgZ9s/0qlqyRR1uwQlSPkyVOtwBvc4CimOHXle1ZASF/oeeUZCJ
         eRow==
X-Gm-Message-State: AOAM5327/o31AJy8lZe1oncVWCJWhHvlG70KSneB+1cl2CDQDefwtZJ/
        Ixq0a1mQR8mECMqQylYazNJStw==
X-Google-Smtp-Source: ABdhPJzzpHnQxaDu6ygc9KUcDwCLE7RpQUtyIhbADTpJPk97QOVDcVZPNTHXQUUr8nb0zb1mmpf0IQ==
X-Received: by 2002:a05:651c:225:: with SMTP id z5mr965852ljn.409.1630711463930;
        Fri, 03 Sep 2021 16:24:23 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id w3sm56924ljm.13.2021.09.03.16.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 16:24:23 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH v2 0/11] interconnect: merge AP-owned support into icc-rpm
Date:   Sat,  4 Sep 2021 02:24:10 +0300
Message-Id: <20210903232421.1384199-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch series merges support for AP-owned and bus QoS from SDM660
into common code (icc-rpm.c). MSM8916 and MSM8939 support code is
extended to support these features. As I was touching these drivers, per
Bjorn's suggestion expand DEFINE_QNODE macros (which makes adding
QoS support much easier to review).

Dependencies:
 - https://lore.kernel.org/linux-arm-msm/20210902054915.28689-1-shawn.guo@linaro.org/
 - https://lore.kernel.org/linux-arm-msm/20210823014003.31391-1-shawn.guo@linaro.org/
 - https://lore.kernel.org/linux-arm-msm/20210824043435.23190-1-shawn.guo@linaro.org/

Changes since v1:
 - Rebase on top a2noc clocks support patch.
 - Expand DEFINE_QNODE
 - Simplify struct qcom_icc_node by moving links to separate array

----------------------------------------------------------------
Dmitry Baryshkov (11):
      interconnect: icc-rpm: move bus clocks handling into qnoc_probe
      interconnect: sdm660: expand DEFINE_QNODE macros
      interconnect: sdm660: drop default/unused values
      interconnect: sdm660: merge common code into icc-rpm
      interconnect: icc-rpm: add support for QoS reg offset
      interconnect: msm8916: expand DEFINE_QNODE macros
      interconnect: msm8916: add support for AP-owned nodes
      interconnect: msm8939: expand DEFINE_QNODE macros
      interconnect: msm8939: add support for AP-owned nodes
      interconnect: qcs404: expand DEFINE_QNODE macros
      interconnect: qcom: drop DEFINE_QNODE macro

 drivers/interconnect/qcom/icc-rpm.c |  263 ++++-
 drivers/interconnect/qcom/icc-rpm.h |   56 +-
 drivers/interconnect/qcom/msm8916.c | 1214 ++++++++++++++++++++--
 drivers/interconnect/qcom/msm8939.c | 1283 +++++++++++++++++++++--
 drivers/interconnect/qcom/qcs404.c  |  967 +++++++++++++++--
 drivers/interconnect/qcom/sdm660.c  | 1940 ++++++++++++++++++++++++-----------
 6 files changed, 4815 insertions(+), 908 deletions(-)


