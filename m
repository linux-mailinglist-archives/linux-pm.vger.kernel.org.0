Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8ED8102869
	for <lists+linux-pm@lfdr.de>; Tue, 19 Nov 2019 16:46:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728419AbfKSPq0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Nov 2019 10:46:26 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45984 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728432AbfKSPq0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Nov 2019 10:46:26 -0500
Received: by mail-lj1-f194.google.com with SMTP id n21so23827314ljg.12
        for <linux-pm@vger.kernel.org>; Tue, 19 Nov 2019 07:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DWp/HKd8UEdzTcxXP25jTpL5m1vRpEu2EqbwctS2S6I=;
        b=dk9px5cDIJKORtjtml2SFVPhx29HNXcnTjWw5g4IITK1vBKPnebecnOHG3g9V8AjUw
         mlK9NvT1b6J7KHm86tfHghnF+aDHWyIlit7kros33Q2zdmPgnl09wM+DFKxzvCcRVhBC
         ErnWukGq/A+cqaWWM24Ll7wRo65fbmSi+yRPbC2V/q5/EuLGmzOAQJd/dk2tzJLvytmR
         S5pacexLX9HtHmThejcLL2n0WfhI0pySAzkJT3pGS2ng5eu76U++lGCMV4vdJMoiVLZr
         929X0NRtCAKxeXFhMjx4ntq/XAFqnuPLO9Gcf8KwVc/KY5TBdSssqwz2sWVt/Rb7+txj
         Skvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DWp/HKd8UEdzTcxXP25jTpL5m1vRpEu2EqbwctS2S6I=;
        b=d3Dv0pWFEwcEgQfWQTCboU8tdjoQynLap+V9PW0YFVcg3zWainquZK+s5xDa6o7fhM
         bfDax6DdIRVs3yw62SSKRccSoJZI/VuRoLGkFTQNT895spMyiJqYDfyTRjja4GJRK0Cb
         Lz9oLhGJUd/MPx80PAxBnU04oj9UZ/4aRxfu+lbYDaYTY4OBC2mHrpwjUaYhDSORJmS8
         B8/Z8b6CXa+2F0N2gqodDQXi/AqUNd+V7c6D9d4l301j1LyeGOpVKsMN7AjCPOH6T1Se
         kLky8heCcLH69gT/dxjkQ10GOoHFq0FQtzaML765APnhW0zGtwH7Kbmoj+6LGTlrRMPt
         a4ZA==
X-Gm-Message-State: APjAAAXC47JJPx7aGS3XrcofA7xUieeNxXx3QGTnKtDziLxYBS/gSq6o
        Fi9yg0FrGsUBMyRaiyKcdY2m+xDxZ+U5dA==
X-Google-Smtp-Source: APXvYqwsRAXzKKHohtayBA+twXWFwp1l6AdR8CirrZJeOWMtDwJ6LiQB/ogskDkybNlY4Mj4S/fPQw==
X-Received: by 2002:a2e:9156:: with SMTP id q22mr4390127ljg.166.1574178383838;
        Tue, 19 Nov 2019 07:46:23 -0800 (PST)
Received: from centauri.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id v10sm9886281ljc.6.2019.11.19.07.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 07:46:23 -0800 (PST)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     amit.kucheria@linaro.org, sboyd@kernel.org, vireshk@kernel.org,
        bjorn.andersson@linaro.org, ulf.hansson@linaro.org,
        Niklas Cassel <niklas.cassel@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v6 0/5] Add support for QCOM Core Power Reduction
Date:   Tue, 19 Nov 2019 16:46:15 +0100
Message-Id: <20191119154621.55341-1-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This series adds support for Core Power Reduction (CPR), a form of
Adaptive Voltage Scaling (AVS), found on certain Qualcomm SoCs.

This series is based on top of the qcs404 cpufreq patch series that
hasn't landed yet:
https://patchwork.kernel.org/project/linux-arm-msm/list/?series=173423
as well as that series' matching device tree changes:
https://patchwork.kernel.org/project/linux-arm-msm/list/?series=165457

For testing purposes, this patch series, including the dependencies
listed above, is available on the following git tag:
https://git.linaro.org/people/niklas.cassel/kernel.git/log/?h=cpr-v6

CPR is a technology that reduces core power on a CPU or on other device.
It reads voltage settings from efuses (that have been written in
production), it uses these voltage settings as initial values, for each
OPP.

After moving to a certain OPP, CPR monitors dynamic factors such as
temperature, etc. and adjusts the voltage for that frequency accordingly
to save power and meet silicon characteristic requirements.

This driver has been developed together with Jorge Ramirez-Ortiz, and
is based on an RFC by Stephen Boyd[1], which in turn is based on work
by others on codeaurora.org[2].

[1] https://lkml.org/lkml/2015/9/18/833
[2] https://source.codeaurora.org/quic/la/kernel/msm-4.14/tree/drivers/regulator/cpr-regulator.c?h=msm-4.14

Changes since v5:
-Removed pm_ops from platform_driver struct.
 (This was embarrassingly not properly removed in previous patch revision.)

Niklas Cassel (5):
  dt-bindings: power: avs: Add support for CPR (Core Power Reduction)
  power: avs: Add support for CPR (Core Power Reduction)
  arm64: dts: qcom: qcs404: Add CPR and populate OPP table
  arm64: defconfig: enable CONFIG_QCOM_CPR
  arm64: defconfig: enable CONFIG_ARM_QCOM_CPUFREQ_NVMEM

 .../bindings/power/avs/qcom,cpr.txt           |  130 ++
 MAINTAINERS                                   |    8 +
 arch/arm64/boot/dts/qcom/qcs404.dtsi          |  132 +-
 arch/arm64/configs/defconfig                  |    2 +
 drivers/power/avs/Kconfig                     |   15 +
 drivers/power/avs/Makefile                    |    1 +
 drivers/power/avs/qcom-cpr.c                  | 1754 +++++++++++++++++
 7 files changed, 2034 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/avs/qcom,cpr.txt
 create mode 100644 drivers/power/avs/qcom-cpr.c

-- 
2.23.0

