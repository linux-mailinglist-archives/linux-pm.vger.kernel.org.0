Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF9E8205A2C
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jun 2020 20:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733119AbgFWSIk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Jun 2020 14:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732549AbgFWSIj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Jun 2020 14:08:39 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B34CC061573;
        Tue, 23 Jun 2020 11:08:39 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id v3so14029047wrc.1;
        Tue, 23 Jun 2020 11:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=31dgJUvqmMiUjr5/SjwepCwX7LHCXraRa5BeX61GTfI=;
        b=k0VX6SgyT10NYDAWWRGaAQ4zDZ0897r38KlzWcP1GetAhm91XVV9nJdPWE2BsqLg2F
         808WRCuE7mtgEExzwXNHd2FT9D8gQI1WeJRBVM17lZDxDARUvruTXOn7c3ecaflXhnWT
         6S64Yc8Tw0dkjWmbc95nOZI69oSDm+XRh4ZW6yqUe2l48pjwiBmce3IaV0akwGaEpTrw
         CvphJx0a9/CYS6wggA/U1x+PRW9yIuz5D9QXufQ3ZzNyYwNB1FwGSfjJKBumRBsL8UO6
         ZhUcQXUOofiPLbkuf3vuaO5G8jqTl00MTDXe1Ivc8tkVL5Ae6dIPh+m/9Uoht4HosoJO
         wG8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=31dgJUvqmMiUjr5/SjwepCwX7LHCXraRa5BeX61GTfI=;
        b=OscEEQ5uIBEXIGDl1wCT6flP4DlQWpSVgmrU2o6nFy00bPj4RE3HrYCysx8ML0cEze
         nOczcPpAZQnqpxbzHtHNASdWe9R2xRpbpvahrMELCqCtFEKBR8/+Ae1CQ2X2+xPE6KN0
         /FftZ07FV1bBn8UW5z4nK8uDs90l30ApG4LHel6j1n0WzLTGNysBotgQ+8A1axIqZMgH
         Bw+u7V7dq9FwXAss5eEo0R1fb2OmcztwJbDfzZ7I7QhZydiVtuDqkwqCfZXeeA7+FGCw
         NFtabTU3BCr9OSql/K/mXJBy2H+3WLfxGjJ1ufv4b5u1MkgVKbzM8Yhqpr/iTCtmRlLS
         FmNQ==
X-Gm-Message-State: AOAM531Novt8+q3kz36o5xkLqIazrWWeVj8F6FJhcCdA4wWuAUvcRRrq
        Q6dbCCUbUfc4GeYpqw1BSug=
X-Google-Smtp-Source: ABdhPJwQZQAeI0iwVIQ22Ds2N5g7OV0FSAPFVo01fCJvlE+RoPXOKXFaxNnSchApHq1eudJjsRD0rg==
X-Received: by 2002:a5d:6809:: with SMTP id w9mr27921394wru.182.1592935717856;
        Tue, 23 Jun 2020 11:08:37 -0700 (PDT)
Received: from localhost.localdomain (abag196.neoplus.adsl.tpnet.pl. [83.6.170.196])
        by smtp.googlemail.com with ESMTPSA id c16sm4719529wml.45.2020.06.23.11.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 11:08:37 -0700 (PDT)
From:   Konrad Dybcio <konradybcio@gmail.com>
To:     skrzynka@konradybcio.pl
Cc:     Konrad Dybcio <konradybcio@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH 0/8] SDM630 and Ninges fixes
Date:   Tue, 23 Jun 2020 20:08:24 +0200
Message-Id: <20200623180832.254163-1-konradybcio@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Disclaimer: Ninges = Nile&Ganges

This series brings support for RPMPD on 630/660,
initial tsens support (thermal-zones are WIP so
dont' want to send them yet), an urgent fix for
pinctrl (I have made a mistake that only showed
itself when I tried to add more GPIO-dependent
stuff...) and some stuff for Ninges, namely
enablement of BLSP1_UART2 (omitted it previously)
and temporary removal of Vol- on Nile (which is
a result of fixing the pinctrl driver so that
gpio-keys got to the point where it probed it
and then it died). Also with these changes come
some cosmetic updates (using phandles instead of
addresses as per Bjorn's Request).

Konrad Dybcio (8):
  soc: qcom: rpmpd: Add SDM660 power-domains
  arm64: dts: qcom: sdm630: Add RPM power domains support
  arm64: dts: qcom: sdm630: Add tsens node
  arm64: dts: qcom: sdm630: nile: Enable BLSP1_UART2
  arm64: dts: qcom: sdm630: Fix the pinctrl node
  arm64: dts: qcom: sdm630: nile: Reserve disabled GPIOs
  arm64: dts: qcom: sdm630: nile: Remove Volume Down gpio-key
  arm64: dts: qcom: sdm630: ganges: Change addresses to phandles

 .../devicetree/bindings/power/qcom,rpmpd.yaml |  1 +
 .../bindings/thermal/qcom-tsens.yaml          |  1 +
 .../dts/qcom/sdm630-sony-xperia-ganges.dtsi   | 22 +++---
 .../dts/qcom/sdm630-sony-xperia-nile.dtsi     | 67 +++++++++---------
 arch/arm64/boot/dts/qcom/sdm630.dtsi          | 69 +++++++++++++++++--
 drivers/soc/qcom/rpmpd.c                      | 33 +++++++++
 include/dt-bindings/power/qcom-rpmpd.h        | 12 ++++
 7 files changed, 155 insertions(+), 50 deletions(-)

-- 
2.27.0

