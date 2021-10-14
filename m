Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C868942DAF0
	for <lists+linux-pm@lfdr.de>; Thu, 14 Oct 2021 15:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbhJNN7Y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Oct 2021 09:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbhJNN7X (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Oct 2021 09:59:23 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C73DC061753
        for <linux-pm@vger.kernel.org>; Thu, 14 Oct 2021 06:57:13 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id u18so19889496wrg.5
        for <linux-pm@vger.kernel.org>; Thu, 14 Oct 2021 06:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2PdtaPAjwY1HbFARxyeJr4Hhcr2WETWAgftpSE/ylQY=;
        b=LgYQr3bQkU/3FijQiZD5jUA0UY1jel7vEtTgG9l0/Ccio2VJFVPyJW9aEtroy9bpqS
         F/GWkYggAHgvd7gNhpSX208+aQ6rqEKPoyCPZDb8EUdwa3dBCiKBgGJd98GK249gBeQN
         mIhoH5HAuVqgfwNiCH70Q2d30qxBXPxIxpp5vEQQvBj8wqvMdkY6RTcO3zTXyEf8ULXg
         CMVdejZALtV1dugFT/aCeag19rm3dlRW3rIfTdDCa6g/7sYfxue1UtketluBnyxi82yQ
         3j+ZpZkbSkedGp6oSTefFIVGDLH3QtaLi1UnkVGB2mp8PTR87VRoKHuGXu2TrTnrNdq6
         HpMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2PdtaPAjwY1HbFARxyeJr4Hhcr2WETWAgftpSE/ylQY=;
        b=g1qfvAVmJ4UmBOs3vjva5Yirb4TnhsrUq+3IV2wcAaptXVi+cSbPwzXC0VOP83VodM
         H+Ike6ztzQO/zDLVLDTIMjgHxNdRExuqqIuYKF2fytFVWesgaIBWkseXuK+F/lSaJzCg
         3vLbEhdrEBpHTmao5pa2jsktJyX5RBkYxeYHSJAdEVOvAHPSc6DanvIJ4cQR6G/FcRSp
         oRswbD9BUw9Ou6urGdfOcuINDOFUjH/JagQbf0Ye3Tn6gnLXaxyMfPyLm23D/PgixQ2y
         6TQixuHs1EBI7/DIktsEg2rOMhCGU6H5hgIqpAY5myRfeOX58tZD9DMdmvbmPn7yJurh
         1NYw==
X-Gm-Message-State: AOAM531ciu5RbnLaHHtraUpFI0ObySc6glUmc7t9UdvthXyZ4IH+bf8c
        ue4EVwQQe1UVIbG0Tky2ooiVjw==
X-Google-Smtp-Source: ABdhPJxyk5nP1wBaYxGhuedyLU+0SDeCtC5cBN2hBIiu4CoLUTvAvG4FILymFzOyfeFDfCmElUbCag==
X-Received: by 2002:a1c:808e:: with SMTP id b136mr19498987wmd.178.1634219831347;
        Thu, 14 Oct 2021 06:57:11 -0700 (PDT)
Received: from blmsp.lan ([2a02:2454:3e6:c900::97e])
        by smtp.gmail.com with ESMTPSA id d1sm2596480wrr.72.2021.10.14.06.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 06:57:11 -0700 (PDT)
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, fparent@baylibre.com,
        khilman@baylibre.com, Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH 0/3] thermal: mediatek: Add mt8365 support
Date:   Thu, 14 Oct 2021 15:56:33 +0200
Message-Id: <20211014135636.3644166-1-msp@baylibre.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

this series adds a compatible to the bindings and a specific part for
the thermal driver.

Thanks for any feedback or comments.

Best,
Markus


Fabien Parent (1):
  thermal: mediatek: add MT8365 thermal driver support

Markus Schneider-Pargmann (2):
  dt-bindings: thermal: mediatek: Add mt8365
  thermal: mediatek: Fix apmixed error message

 .../bindings/thermal/mediatek-thermal.txt     |  1 +
 drivers/thermal/mtk_thermal.c                 | 93 +++++++++++++++++--
 2 files changed, 87 insertions(+), 7 deletions(-)

-- 
2.33.0

