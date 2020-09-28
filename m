Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C54827B5CA
	for <lists+linux-pm@lfdr.de>; Mon, 28 Sep 2020 21:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbgI1T7B (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Sep 2020 15:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbgI1T7A (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Sep 2020 15:59:00 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 092B9C061755;
        Mon, 28 Sep 2020 12:59:00 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id y15so2383044wmi.0;
        Mon, 28 Sep 2020 12:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R40nrCDfhihDaBak/buX8nywTFdAEmU4Ja2xlgkMpqk=;
        b=qrDsEFA0vYMYm2cs78HiC7HnifY6UfEh5tE99eHZRifsMoXiOe8pimSaKCxFpIyss+
         Xn2F4HfK6ESIgX81k0Li/LIO0d5y1O5Z5a+8RZ6gxr7bh1Et1i/PliJidTKZ9f1LHbxU
         9yxCM04Gnfs+5ZGev8a8CZzw+JpV7nBB7YzEaEFnOwNVVUjnevqDDI6E0KJCsz/xlD7p
         humPbko98hUZ4ENqkQo18eQdlJWOXtb0R0ui+ltQxTx35IAiNkagqqE0SB1YodXJXbwM
         4EkSdpYwf9nvecNfUWkb/XmXyhNgkLaIPGsn9vlOvNPgjPtjDDwio53YSAxpqsuJr+PK
         YxQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R40nrCDfhihDaBak/buX8nywTFdAEmU4Ja2xlgkMpqk=;
        b=Iof8fhXwJzP8jwIeWvfTL2zCnAr9FjzSolH/w2HWtUTZ+IzSjD/BY9osTCqyHSTc9+
         0jzF5f018upDeN/SJK0HU+fFZzUnfto4kUNHU8UI4c7mXxjF7I2I8o/kSp9Ze1uN8twj
         gCCPB0UfThvAG0aCgpNzX6neBkK2oT5G0QiEg0j7GLBC8XHqZRTNz6Ux5RCbnTaVyIrt
         a/aB2MXqcyHIcHsYJIch1RIXX3jmxnNYca0mv5SKWBk0YGOu97wEN8o7y51c9CVRfsQs
         HwlWqwriLzX7MLXqmYjyb52BAMoq0ycLPYwhMxM5U78o9ZgIAbzYEwRYkD4tWjJov+o+
         UTyA==
X-Gm-Message-State: AOAM531y/bU5CCPx7jEgb5B8JqmryTIUe1CKvLTnLwFXlRJ97Hzisql9
        B0USWquri6RRejLeKPYBBds=
X-Google-Smtp-Source: ABdhPJwku5+xhjSNPN+gwulBq1wbSl0jOpoz06nnz0x0xvjXyMrJzi6pLqvi6Ba61eMBP2aBpLE8gg==
X-Received: by 2002:a05:600c:220f:: with SMTP id z15mr751487wml.87.1601323138479;
        Mon, 28 Sep 2020 12:58:58 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu ([2.237.20.237])
        by smtp.gmail.com with ESMTPSA id q4sm2607434wru.65.2020.09.28.12.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 12:58:57 -0700 (PDT)
From:   kholk11@gmail.com
To:     bjorn.andersson@linaro.org
Cc:     robh+dt@kernel.org, agross@kernel.org, georgi.djakov@linaro.org,
        kholk11@gmail.com, marijns95@gmail.com, konradybcio@gmail.com,
        martin.botka1@gmail.com, linux-arm-msm@vger.kernel.org,
        phone-devel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] Add SDM630/636/660 interconnect driver
Date:   Mon, 28 Sep 2020 21:58:51 +0200
Message-Id: <20200928195853.40084-1-kholk11@gmail.com>
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

AngeloGioacchino Del Regno (2):
  interconnect: qcom: Add SDM660 interconnect provider driver
  dt-bindings: interconnect: Add bindings for Qualcomm SDM660 NoC

AngeloGioacchino Del Regno (2):
  interconnect: qcom: Add SDM660 interconnect provider driver
  dt-bindings: interconnect: Add bindings for Qualcomm SDM660 NoC

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

