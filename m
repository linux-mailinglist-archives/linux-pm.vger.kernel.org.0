Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67AF988768
	for <lists+linux-pm@lfdr.de>; Sat, 10 Aug 2019 02:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbfHJA6u (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Aug 2019 20:58:50 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33505 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbfHJA6u (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Aug 2019 20:58:50 -0400
Received: by mail-qt1-f196.google.com with SMTP id v38so5218395qtb.0
        for <linux-pm@vger.kernel.org>; Fri, 09 Aug 2019 17:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=qV35lBGYXu/17vEOwiu+stH8NOwLsbZEES1POAZWDmw=;
        b=QNww/17CeUfJIyFz5+BrdkpIQzJ7RRhvmrayAvRKzZ/xwNShQ/kPUeW9JUiSwxOAPF
         37CGLv6zf6lknwkYZZAnqyZf9RhsXJ2JQPb4HNQI0CNQ8/867BBEKptmzp5J+Q50F8SC
         v7+6OjdCO4jlJmi1FqgtSeGtpb9whmzoNN0atg4439PLWich4YYoMJ1i/YcLelYY382x
         iYorQIBIp/UP5OBjT/S/+Fg5Rm14o230hbtnRABNMFGmlFTK3fKCe5TutgrCBXSsIiob
         YwK3eVA1a0z0hVYr4mTifJeczJSr0ehG8xNxwO+LlRWHglNi0+yDReQU22eLOs73XEE4
         HODQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qV35lBGYXu/17vEOwiu+stH8NOwLsbZEES1POAZWDmw=;
        b=huAMcjQvfskGoUUQNPmQifkCxmiYOxpONe1K5AEaQpg179fyqSXncFwJO+EC7K6o77
         dxNqAx03fV0GagQeKK7m+cBOOiRGUOPoIzJMsGZTCH9Mv32239BdsAUtaOnPeCTIBuI5
         ib01k1fyQKtgaIf+JG1UFDLq/wgyLwUmPlYy4suI+p1Ubac4eHYUXLQarewAQTJMbXQm
         MdoDMC3nRk5kKFOelLVISandcMCaVt2un0KS/uQkMxlE07Ue/8hMjiSy6sOK0MdvJZnm
         aDBIjw34ZJcnFBcrsgTNo9zKJgR/36sAVN7U9TjaLaDZcSICLHJO3bjT7s6e+w/nG3gR
         wTFA==
X-Gm-Message-State: APjAAAXfP2FskHWNiyRARCGqDW+RoPqjh9V8ETubUwqc2XGaneslTsPt
        CpjMno0/OCk9TdLv9/JEthk11sI3anQ=
X-Google-Smtp-Source: APXvYqz9A+GSGwzt20kaowYU0kIb9kblK9YJGersspim48Z6Sr3M77zOsAimPLTIxGpI7svhZz6yCQ==
X-Received: by 2002:a05:6214:32e:: with SMTP id j14mr9738129qvu.77.1565398729182;
        Fri, 09 Aug 2019 17:58:49 -0700 (PDT)
Received: from Thara-Work-Ubuntu.fios-router.home (pool-71-255-245-97.washdc.fios.verizon.net. [71.255.245.97])
        by smtp.googlemail.com with ESMTPSA id t9sm4603105qtr.29.2019.08.09.17.58.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 09 Aug 2019 17:58:48 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     qualcomm-lt@lists.linaro.org, linux-pm@vger.kernel.org
Cc:     bjorn.andersson@linaro.org, ulf.hansson@linaro.org,
        rnayak@codeaurora.org
Subject: [PATCH 0/4] qcom: Model RPMH power domains as thermal cooling devices
Date:   Fri,  9 Aug 2019 20:58:43 -0400
Message-Id: <1565398727-23090-1-git-send-email-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.1.4
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Certain RPMH power domains can be used to warm up the SoC (mx on sdm845)
if the temperature falls below certain threshold. These power domains
can be considered as thermal warming devices
(opposite of thermal cooling devices).

In kernel, these warming devices can be modeled as a 
thermal cooling device. To use these power domains as warming devices
require further tweaks in the thermal framework which are out of scope
of this patch series.

The first patch in this series extends the genpd framework to export out
the performance states of a power domain so that when the RPMH power
domain is modeled as a cooling device, the number of possible states and
current state of the cooling device can be retrieved from the genpd
framework.

The second patch implements the newly added genpd callback for RPMH power
domain driver.

The third patch implements the modeling of a RPMH power domain as
a cooling device and the final patch adds the device node entry for sdm845
to consider RPMHPD MX a cooling device.

Thara Gopinath (4):
  PM/Domains: Add support for retrieving genpd performance states
    information
  soc: qcom: rpmhpd: Introduce function to retrieve power domain
    performance state count
  thermal: qcom: Add RPMHPD cooling device driver.
  arm64: dts: qcom: Extend AOSS RPMHPD node

 arch/arm64/boot/dts/qcom/sdm845.dtsi    |   7 ++
 drivers/base/power/domain.c             |  38 +++++++++
 drivers/soc/qcom/rpmhpd.c               |  11 +++
 drivers/thermal/qcom/Kconfig            |   7 ++
 drivers/thermal/qcom/Makefile           |   1 +
 drivers/thermal/qcom/qcom-rpmhpd-cdev.c | 141 ++++++++++++++++++++++++++++++++
 include/linux/pm_domain.h               |  18 ++++
 7 files changed, 223 insertions(+)
 create mode 100644 drivers/thermal/qcom/qcom-rpmhpd-cdev.c

-- 
2.1.4

