Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0895287D5F
	for <lists+linux-pm@lfdr.de>; Thu,  8 Oct 2020 22:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730617AbgJHUp3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Oct 2020 16:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728848AbgJHUp0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Oct 2020 16:45:26 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2687AC0613D2;
        Thu,  8 Oct 2020 13:45:24 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id z22so7553378wmi.0;
        Thu, 08 Oct 2020 13:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hlJS54LS1QeMz9CXsMLIWQSJKthUuahxWTnjdupvZw8=;
        b=Y/D49zWH50fLTwowZ62kkutY8OxokW5uA6tbVKMO713V0yNnGGONc7AA1u638bC0s4
         KTT9ceEdsiFWvyUU5OFSfKsmb7J10R2wU8EXTmKXR9NaaJeCVYYqyurGgaFqpB7o/tDh
         Oz4mRzh1eAARN4joHEojuYhmx81sk5yoif4x2Bsbycj3iKuqQnWwsrG8Jf6kwBbfc/Aw
         0gz3vcwaxCHEEyuwGxwKvR+9wgpCetGf0Lidyc6ZV/RlV99xV0ek1VRiyNDMDZbodLJD
         KLFmGT0yjhjx/36Lc72iDMBYwjRQXqdrA/6HTb0+VmpVFCmtTNFTFMmE9OfPR9fwDPXa
         GRzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hlJS54LS1QeMz9CXsMLIWQSJKthUuahxWTnjdupvZw8=;
        b=HmQVDVjx6J/wqIyl8n5Pv35SHzMknoFTe7pTSPwjS0VBcjVTO2jx1VHzcihMWRbIID
         23weXrCUZqX3vfseXBqLx5f4IGzCEW/h9Jfdar/wTJdJ4orKW7TYhVryrtfbCmDfNS9y
         8ab7NxSB1JUJv1gaSXv3j5JfpskoAPjSO0CZ98TcLmH60tjdINRkODOlvS8qdA0EOmpj
         UQo61f96KrvEVMAvmJtJ7WCjSQcPzhICXvBg/+v/nJU3T/P2EEK8zQH0VD4/nGOT6Qjq
         dCnsapVKYozIQKWpKlP3B+n7yugL0pqsWt9jq3u5Nf9OB36IaAPghrGy0ztjMOsYsdW6
         Rntw==
X-Gm-Message-State: AOAM530v8tNwwEtgEiR/nVCD4K9R3tSaXvHKuH2NPzsZ09XZSzmscFX+
        uvV4ChpaMO501X2NpRSKO9M=
X-Google-Smtp-Source: ABdhPJza7b1khwnjBmQP+L5sWLHROePRe7riFfCVoxP/UexYqgksh2pbERzzPt7d0zXz//IDCf0sdQ==
X-Received: by 2002:a1c:6457:: with SMTP id y84mr10320458wmb.36.1602189921783;
        Thu, 08 Oct 2020 13:45:21 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu ([2.237.20.237])
        by smtp.gmail.com with ESMTPSA id o14sm8640103wmc.36.2020.10.08.13.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 13:45:21 -0700 (PDT)
From:   kholk11@gmail.com
To:     bjorn.andersson@linaro.org
Cc:     robh+dt@kernel.org, agross@kernel.org, georgi.djakov@linaro.org,
        kholk11@gmail.com, marijns95@gmail.com, konradybcio@gmail.com,
        martin.botka1@gmail.com, linux-arm-msm@vger.kernel.org,
        phone-devel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] Add SDM630/636/660 interconnect driver
Date:   Thu,  8 Oct 2020 22:45:13 +0200
Message-Id: <20201008204515.695210-1-kholk11@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: AngeloGioacchino Del Regno <kholk11@gmail.com>

This patch series adds the SDM660 interconnect provider driver in
order to stop some timeouts and achieve some decent performance by
avoiding to be NoC limited.
It's also providing some power consumption improvement, but I have
only measured that as less heat, which is quite important when
working on thermally constrained devices like smartphones.

Please note that this driver's yaml binding is referring to a MMCC
clock, so this series does depend on the SDM660 MMCC driver that I
have sent separately.
The multimedia clock is required only for the Multimedia NoC (mnoc).

This patch series has been tested against the following devices:
 - Sony Xperia XA2 Ultra (SDM630 Nile Discovery)
 - Sony Xperia 10        (SDM630 Ganges Kirin)
 - Sony Xperia 10 Plus   (SDM636 Ganges Mermaid)

Changes in v2:
 - Added missing qcom,mmcc-sdm660.h dt-binding include in the
   interconnect/qcom,sdm660.yaml binding, as pointed out by
   Rob Herring

Changes in v3:
 - Moved the dt-bindings/interconnect/qcom,sdm660.h header
   to dt-bindings commit.

AngeloGioacchino Del Regno (2):
  dt-bindings: interconnect: Add bindings for Qualcomm SDM660 NoC
  interconnect: qcom: Add SDM660 interconnect provider driver

 .../bindings/interconnect/qcom,sdm660.yaml    | 147 +++
 drivers/interconnect/qcom/Kconfig             |   9 +
 drivers/interconnect/qcom/Makefile            |   2 +
 drivers/interconnect/qcom/sdm660.c            | 919 ++++++++++++++++++
 .../dt-bindings/interconnect/qcom,sdm660.h    | 116 +++
 5 files changed, 1193 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sdm660.yaml
 create mode 100644 drivers/interconnect/qcom/sdm660.c
 create mode 100644 include/dt-bindings/interconnect/qcom,sdm660.h

-- 
2.28.0

