Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C46583F47F7
	for <lists+linux-pm@lfdr.de>; Mon, 23 Aug 2021 11:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235704AbhHWJ5E (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Aug 2021 05:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232526AbhHWJ5E (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Aug 2021 05:57:04 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D99CCC061575
        for <linux-pm@vger.kernel.org>; Mon, 23 Aug 2021 02:56:19 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id z24-20020a17090acb1800b0018e87a24300so1421732pjt.0
        for <linux-pm@vger.kernel.org>; Mon, 23 Aug 2021 02:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=+HcYX4o3oYabXOVjOFPvNIFXnMCujvnBt9jGvMZEMNQ=;
        b=cmYV78ghXsy4hjtR3Z117IW2pU/YgW/Xlv/y/3eea6DCXCAMlwvzYmSE95Mi/znrIi
         sHc9IoOoV+KBpBu3EipOfMbPVtgYDExm+iM7aT9G5I5IZZqcZT5qpNjtpFHh7Y2ES/2P
         PQYeISUXrny4nVFTUrKh0PpPj2RI2dfkCHOJV4tLZFIwyn/UiidKHADujfYSbnqACWxB
         PGLVVZHTgmi3ltfXqczTKvC3wzVfkLqjdkYNVu1GUtjUY4tNOE4CWVtaj+qyWyq8XupV
         FN7kBqUMgRYF+EX0jKiEP2E89bSuHcqXao8QGczw0uEPC4O0NRrKFTyu3kI+Dum5LJ0F
         zcaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+HcYX4o3oYabXOVjOFPvNIFXnMCujvnBt9jGvMZEMNQ=;
        b=Iowixo/WtL88UY4YDYg2NlUWZ9GncNRg9L7B6iBue8kF5c6JBIZL4i/Bz7treWo7a3
         QC3TvUl0jjZTJA7KoMGJlJuauPx0W3JSbIMRODu0T3Cj23cB9tC/hhSnPyBTMIgTrWJ9
         44m3jx7ZN8Z2mnFDeFt15onKNI+hLO2oXH7twv0T9Dugh3g2XOGmnqRaq5BT1MNYEWxM
         79baqXAmJnB8Iw8ZMJh+kESjitZdnaGStYkCoXCmGPhyJQWvN6GaeZazfktHH6+4XoVs
         vFMuWGcZJ6dlGCg93OEiM4quO2GnDftUuxZLhP0h/2bAfq+S768BhkVJNf8aANKge/s0
         mYgQ==
X-Gm-Message-State: AOAM530UzKaoyTbq/6HWtmYf3fLqHCg+XwpS0iukbkFBWejg8X+FuR3t
        n5wvtVLjplDJCHoEmqLQvyVAvg==
X-Google-Smtp-Source: ABdhPJyojLzAIU8oA6E7pgKoWx1updv6tv/T/1Pj7USfwiU/5uJ/llsOkcLobIAW08B9ShwhwJQGwA==
X-Received: by 2002:a17:902:8d8a:b029:12d:3774:3630 with SMTP id v10-20020a1709028d8ab029012d37743630mr28229682plo.65.1629712579445;
        Mon, 23 Aug 2021 02:56:19 -0700 (PDT)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id z24sm18708230pjq.43.2021.08.23.02.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 02:56:19 -0700 (PDT)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Georgi Djakov <djakov@kernel.org>
Cc:     AngeloGioacchino Del Regno <kholk11@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 0/3] Add missing A2NoC QoS clocks for SDM660 interconnect driver
Date:   Mon, 23 Aug 2021 17:56:00 +0800
Message-Id: <20210823095603.5538-1-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The series updates SDM660 interconnect bindings, driver and device tree
to add A2NoC clocks required for QoS registers programming per downstream
kernel[1].  Otherwise, qcom_icc_noc_set_qos_priority() call on mas_ufs or
mas_usb_hs node will simply result in a hardware hang on SDM660 SoC.

[1] https://source.codeaurora.org/quic/la/kernel/msm-4.4/tree/arch/arm/boot/dts/qcom/sdm660-bus.dtsi?h=LA.UM.8.2.r1-04800-sdm660.0#n43

Shawn Guo (3):
  dt-bindings: interconnect: sdm660: Add missing a2noc qos clocks
  interconnect: qcom: sdm660: Add missing a2noc qos clocks
  arm64: dts: qcom: sdm630: Add missing a2noc qos clocks

 .../bindings/interconnect/qcom,sdm660.yaml    | 41 ++++++++++++++++++-
 arch/arm64/boot/dts/qcom/sdm630.dtsi          | 17 ++++++--
 drivers/interconnect/qcom/sdm660.c            | 14 +++++++
 3 files changed, 67 insertions(+), 5 deletions(-)

-- 
2.17.1

