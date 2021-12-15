Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40AF6475D83
	for <lists+linux-pm@lfdr.de>; Wed, 15 Dec 2021 17:34:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244879AbhLOQeF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Dec 2021 11:34:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244870AbhLOQeD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Dec 2021 11:34:03 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C2CC06173F
        for <linux-pm@vger.kernel.org>; Wed, 15 Dec 2021 08:34:03 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id m6so3620168qvh.10
        for <linux-pm@vger.kernel.org>; Wed, 15 Dec 2021 08:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uSBn+Ips2mtFKmkest40VuG2t1Y4Y842E21N7HcVLJw=;
        b=AuJDAJ/Dm/I4pWZrejRCiQb38wy5EUv97cL2VOe6ddPEGnzKBga495AftanAv9BWrL
         R0Di5GIEb9ed9XrlOpMe2/f11NnYMD5Ww3d8vzsHCgsKPNTQaPCR/kXYcl29QEnVJK9e
         R6GSDiXu7WvsxhMtGQKTsgT1rACFubi8eBQRWDOUpO9t+3w7+pnZUWl2Hj10PD0o+buR
         50kuY+Hb7g6uZumilOXcx81Zq3bzev+78uitlQ1jMgPGgLowJjPMQmxGKDPw9buHthq3
         DrmztaKRhYmzlFSAx5eUioHeAvXg1oV+SXE6wzILxCmPVfpDm6N3nFdSAJ0yEEsERBz/
         CePA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uSBn+Ips2mtFKmkest40VuG2t1Y4Y842E21N7HcVLJw=;
        b=uX5pnyv7uEhQpAHCMNlv/7SySKsz2XN3YBit3NBs2LYztMS3+/gnXO6HG1FhZNremm
         rjoswx1LrsHBRlfuoWiagZer8oqTa462FcydhVX6RwD8tbZVD4vIPBPc9y7wPuPcmZaT
         isOANFlGr/N4Eb386rrzqIhONcrWUsE+aTcmEEfhcQzc5wxl4/zUWO7j5dqToltvGQ9z
         bUEZ3larjfSVhyEQCMHD+WeOmoV7QHI4pMbhN2of+li4f0C+PAyRhcV5r+fFXE/9c3ox
         QPB7PhpaSzNEs/7HNDPYe/FL9BijzS1L90OjfGy2aKqrrM9uzsnqQlOWRsEMeqRauCOp
         cffA==
X-Gm-Message-State: AOAM531qMqqPrdQwx2obe0KEvkRBHRF67klTdfkJofnoJHHgEYG07oEO
        3BoiGWSq6FCPIZR8c0yuYtSDDg==
X-Google-Smtp-Source: ABdhPJyiKLF7wZnf7umAu+GGDwDicxwcCM2dHGFo9/dKB6KrjsFBQxX5uzudiiLY94/5f5Ls1u2oGQ==
X-Received: by 2002:a05:6214:c83:: with SMTP id r3mr11747166qvr.110.1639586042259;
        Wed, 15 Dec 2021 08:34:02 -0800 (PST)
Received: from pop-os.fios-router.home (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.googlemail.com with ESMTPSA id w10sm1824832qtj.37.2021.12.15.08.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 08:34:01 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        daniel.lezcano@linaro.org, rafael@kernel.org, rui.zhang@intel.com,
        robh+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [Patch v2 0/3] Extend LMh driver to suppot Qualcomm sm8150 SoC.
Date:   Wed, 15 Dec 2021 11:33:57 -0500
Message-Id: <20211215163400.33349-1-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add support for sm8150 in the Qualcomm Limits Management Hardware(LMh)
driver. Also add required device tree entries and dt-binding.

Thara Gopinath (3):
  thermal: qcom: lmh: Add support for sm8150
  arm64: dts: qcom: sm8150: Add support for LMh node
  dt-bindings: thermal: Add sm8150 compatible string for LMh

 .../devicetree/bindings/thermal/qcom-lmh.yaml |  1 +
 arch/arm64/boot/dts/qcom/sm8150.dtsi          | 24 +++++++
 drivers/thermal/qcom/lmh.c                    | 62 +++++++++++--------
 3 files changed, 60 insertions(+), 27 deletions(-)

-- 
2.25.1

