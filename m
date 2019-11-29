Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F058710DB2B
	for <lists+linux-pm@lfdr.de>; Fri, 29 Nov 2019 22:39:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbfK2VjY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 Nov 2019 16:39:24 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37779 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727175AbfK2VjW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 29 Nov 2019 16:39:22 -0500
Received: by mail-lj1-f193.google.com with SMTP id u17so5957663lja.4
        for <linux-pm@vger.kernel.org>; Fri, 29 Nov 2019 13:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HoCIkfIpHUEqxrpa5VNin8a9xzNcml7RJzBZOqUbMCI=;
        b=XhymOJiD3Z2aYsBi1GtNTmqv4cD8lZuV3n18svaQOYIQckWoHxOiES3GCLPpqqi9xF
         ElUzyTYZ/VPe8tY/gh9Fc7J0JDEg7fGZDsQji6Gy+g9cPS7yVWGpavdASwkXBmAJDo9M
         6DcZDgXVWSJDqEztf2bZcl8ELnuyOlYW7n1Jk8FnLYoK03OBlPNvo6Ycbn3HBeGzBtHm
         7r5nNgT4uFYwy6SdusagmXvIC8XfXg2xFDBtKfsLYtVnFoSblrT1l8DZD9NgPZNUGTpB
         7XNcVK1xyUEjbSFuaQUFZ2T/bWzgDCdIlWlzBqhDIOGiS/yhprw/RB1CRSLOHSV9KDgP
         Y6Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HoCIkfIpHUEqxrpa5VNin8a9xzNcml7RJzBZOqUbMCI=;
        b=t6lQattDuwJqcWJlfrxpKdc5UtlAXpa1bTvwlBqJ2GTC+HOlI/CSHSWntnf48A06X4
         umFyD5cVfQB3MviSxAtMIF8pN3w29aS0Rv1v6PEvrUPgmxbqYky3znSxyaQ5PDBtTUfd
         Rg71FN/W2Wq5Fe7y3DXVkPTMBZe+10cTCCUrHPWwmlMbGq7t3pGLVRaVmeKiXCEZD2wN
         gyg1ZjrqPs5kM8zBAjdg0rPb8k/n8khyil12KwbvjabEHfjEFtyBzBFNKE5iLEj8InHY
         zKYUbl50WOv4x95sXbHpql5IfiPDX820JSxkmRFkO6mwq9fdlObgvXaTWfsspLK9C7OB
         53sw==
X-Gm-Message-State: APjAAAUqPUdanIo4hbtDL7pOenqi8MOuBseUgeugwLlVjLbPUhxER9m5
        xEaEpRUZbTYs0SWMOfKwllTOLDidhwCZoA==
X-Google-Smtp-Source: APXvYqzNEPzDYPTg7B0zYEoaYUWO6O51RXUBdgXRZrq4wpucNmLYPHPSkvc02v5pkenXgOWZn5z0ng==
X-Received: by 2002:a2e:9549:: with SMTP id t9mr2600851ljh.148.1575063560250;
        Fri, 29 Nov 2019 13:39:20 -0800 (PST)
Received: from centauri.lan (ua-84-217-220-205.bbcust.telenor.se. [84.217.220.205])
        by smtp.gmail.com with ESMTPSA id b190sm10742234lfd.39.2019.11.29.13.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2019 13:39:19 -0800 (PST)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     amit.kucheria@linaro.org, sboyd@kernel.org, vireshk@kernel.org,
        bjorn.andersson@linaro.org, ulf.hansson@linaro.org,
        Niklas Cassel <niklas.cassel@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v7 0/5] Add support for QCOM Core Power Reduction
Date:   Fri, 29 Nov 2019 22:39:10 +0100
Message-Id: <20191129213917.1301110-1-niklas.cassel@linaro.org>
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
https://patchwork.kernel.org/project/linux-arm-msm/list/?series=207821
as well as that series' matching device tree changes:
https://patchwork.kernel.org/project/linux-arm-msm/list/?series=207831

For testing purposes, this patch series, including the dependencies
listed above, is available on the following git tag:
https://git.linaro.org/people/niklas.cassel/kernel.git/log/?h=cpr-v7

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

Changes since v6:
(Addressed comments from Ulf Hansson)
-Initialize mutex later.
-Take the mutex in cpr_pd_attach_dev(), in case we ever
implement async attach in the future.
-Add comment regarding why we get the cpu clock rate.
-Add comment how we handle unlisted frequencies.
-Clarify comment regarding why things related to virtual corners
are performed in cpr_pd_attach_dev().
-Removed the internal performance_state variable, the performance
state is instead calculated using the current corner pointer.
-Save a pointer to the first genpd dev that gets attached,
and use that rather than get_cpu_device(0), when getting the CPU
OPP table.

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
 drivers/power/avs/qcom-cpr.c                  | 1792 +++++++++++++++++
 7 files changed, 2072 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/avs/qcom,cpr.txt
 create mode 100644 drivers/power/avs/qcom-cpr.c

-- 
2.23.0

