Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6641C1E9B
	for <lists+linux-pm@lfdr.de>; Fri,  1 May 2020 22:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgEAUdU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 May 2020 16:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbgEAUdU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 May 2020 16:33:20 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C5FC061A0C;
        Fri,  1 May 2020 13:33:20 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id x18so12896466wrq.2;
        Fri, 01 May 2020 13:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4eZpjuAbgedGLqd0zcY8AWOFA9Ev3IFgEsVVjt4li3g=;
        b=TdfKbVIAEPlBX93YrzNAL8/fETOV7kpnIzyx0q4OJ14zm0LgWpf5dZwpOfOZuxXRFy
         tFs+4foImIcus1EhDNbPl48QHD0FtfJeii4T5aW8dJNWP/H6pgKt4+BNDnvyXZLq9X/f
         1diq/o7yQT1SA3R9zthTy/Xtrx+QJWjErT7K031rxde8Me+XgTSQl3wk1AQIW541fhFj
         qRbvqdnhpqJeMcLzL6PrniqHV47kRBa8Ib55r7r5xUjj9bADgEaN3CSG0r6H4MW20KN1
         Go2NyZEDIn3957md9qVzkwwHrnBca1uU8Hc0kX/FKkfG+yT7r4VFEgiLMu1yao3+ffBh
         us2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4eZpjuAbgedGLqd0zcY8AWOFA9Ev3IFgEsVVjt4li3g=;
        b=hMXCQW+OSypZO04mJ0Ip+WC74V8hNSg0WHcidiio6o8pfADfyP1XKM8FjeUwsSQNAW
         b4b+RpOEJH+11LkgfuzDpo7D29POeWSClZMVreRL5/LWOlf+snm+9oPsBwwXvJnKWeBq
         OTybHTtxfemzWBEb7wVG6ABhNaVd/vveFWoLHrCYSgjFxEUJb0Yk6GPYhAsPmBGDg4LD
         DmRU4W175H+24WwyyyW9CAAmGGx4oWyCfaNt/F/mLsAa3cFvnCV3/7KoX9FIROXcsHhS
         Z1GJjclHG+MF22Ufc+x8V9EZTgL8EBY8FU3BOiffDKbwQrPcXdCf2BXLJ/FGj9aA+UJ7
         VCvA==
X-Gm-Message-State: AGi0PuZZ8mWAbwukIs5JZNH8cAAmD+zZYwK0iBxhFekHBihjURfkd1iC
        BSn6JBJGqMUz4BG6YShBRCE=
X-Google-Smtp-Source: APiQypIU/7mBOtxost+nDaUEm2kIH3rOUGDat8vOtQZzAwoo9HcxRG3IA4/JGBrBv7eSKpVA07K4+A==
X-Received: by 2002:adf:a704:: with SMTP id c4mr5713811wrd.303.1588365198711;
        Fri, 01 May 2020 13:33:18 -0700 (PDT)
Received: from localhost.localdomain (abag125.neoplus.adsl.tpnet.pl. [83.6.170.125])
        by smtp.googlemail.com with ESMTPSA id i129sm1104341wmi.20.2020.05.01.13.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 13:33:18 -0700 (PDT)
From:   Konrad Dybcio <konradybcio@gmail.com>
To:     skrzynka@konradybcio.pl
Cc:     Konrad Dybcio <konradybcio@gmail.com>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Add msm8939 tsensv0_1 support
Date:   Fri,  1 May 2020 22:33:09 +0200
Message-Id: <20200501203311.143934-1-konradybcio@gmail.com>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Konrad Dybcio (2):
  thermal: qcom: tsens-v0_1: Add support for MSM8939
  dt-bindings: tsens: qcom: Document MSM8939 compatible

 .../bindings/thermal/qcom-tsens.yaml          |   1 +
 drivers/thermal/qcom/tsens-v0_1.c             | 142 +++++++++++++++++-
 drivers/thermal/qcom/tsens.c                  |   3 +
 drivers/thermal/qcom/tsens.h                  |   2 +-
 4 files changed, 146 insertions(+), 2 deletions(-)

-- 
2.26.1

