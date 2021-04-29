Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D53A36E2D7
	for <lists+linux-pm@lfdr.de>; Thu, 29 Apr 2021 03:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbhD2BJU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Apr 2021 21:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbhD2BJU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Apr 2021 21:09:20 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B23FC06138B;
        Wed, 28 Apr 2021 18:08:34 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id mu3so6253867ejc.6;
        Wed, 28 Apr 2021 18:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i3qk61v6/wN3MGlWoF+r4JwD22Y4XdPrwsgszsckLgU=;
        b=jC7wpQgmfQ5JUXQFCrctkS1fxj+Vj2en1tUWBDEBIcmLcA4VONXVsZUPESP5lJVJXc
         FSVcB/dBWvaA2THu4qghzHRd2unPdpB4K4IO1HYl1YovutjeN/nGKG/KpV4/d+z2B6L5
         luC9IBEJMPlp4I0cmbgkAfoWonnpBDkXU2FloRS5b5XXvrJhCuqZgZqneEeIDynGlNlL
         C5EIN19egyCdzbP8Jwy/5Dnwgw5ihhdC6loy9KfS+DLHOJI1AmfvB/a4SRt0u1X7gLH6
         ZgWazqlSS0q9mtXbGSghcKbcuZACvqAxRkjrXxVYZxxz797uaCX8xcGtSnKUPsxvfUnJ
         Pv0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i3qk61v6/wN3MGlWoF+r4JwD22Y4XdPrwsgszsckLgU=;
        b=rcwUZ2eG8a0dGS6G081DChrgOdA5zLBn2ABlBBO6ajyU2Xe3s9pHJ2OM1Ggi23yBqF
         cXZivS4vTrUguwqxJetlsfU4HfhIxKDKdhtqu5VMmoddwL2LDq6d8LvVhEWhG/lLFxKv
         J/4Ky/N4ECuRufZDAmX8y4xv5SAGhZXe+Lok+TS9sPrd3JzTck7Nbvy/AJln9421AZ/p
         3L/uTh/2L0AGjWj1kNqm0rcuYZwF2I16zP76MTDdeGlVgm2Py8upZ+ntVIqakrFXO6RI
         fYwTHKpW9HnzwL4YCwEVi0YcpGQjTTJb5o/+LuCmWMmjNBi9DMEMtvpfoNyFsGm9Y2Ik
         tXMg==
X-Gm-Message-State: AOAM532yD1P7Pxh028lLOn36AN+fECjYbD5kLDK2en07wsa0PfwiyZZo
        g6Bxyr/8cSmllYxSSEg1c/TaqDvbfwZMMA==
X-Google-Smtp-Source: ABdhPJymZvUW8c5gDKYNY62IKRVxMZqMpSBuTd7MOPlAcy9YbqBq3M90wQ8wveOqcogHhnYooztOCg==
X-Received: by 2002:a17:906:b253:: with SMTP id ce19mr16957336ejb.531.1619658512946;
        Wed, 28 Apr 2021 18:08:32 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-35-189-2.ip56.fastwebnet.it. [93.35.189.2])
        by smtp.googlemail.com with ESMTPSA id d5sm1113398edt.49.2021.04.28.18.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 18:08:32 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] Minor fix for qcom tsens driver
Date:   Thu, 29 Apr 2021 03:05:16 +0200
Message-Id: <20210429010518.13319-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This is a small series to fix some warning arised testing the 8960 tsens
driver. 8960 calibration function can return PROBE_DEFER and cause
reregistration of debugfs. Move debugfs registration deeper in the probe
function and fix a small problem with wrong tsens version reported. 

v2:
- Address review comments from Thara

Ansuel Smith (2):
  thermal: qcom: tsens: init debugfs only with successful probe
  thermal: qcom: tsens: simplify debugfs init function

 drivers/thermal/qcom/tsens.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

-- 
2.30.2

