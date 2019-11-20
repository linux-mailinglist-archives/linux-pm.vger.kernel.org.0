Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0A0103A65
	for <lists+linux-pm@lfdr.de>; Wed, 20 Nov 2019 13:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbfKTM4k (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Nov 2019 07:56:40 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:39162 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727644AbfKTM4k (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Nov 2019 07:56:40 -0500
Received: by mail-qk1-f195.google.com with SMTP id o17so1092393qko.6
        for <linux-pm@vger.kernel.org>; Wed, 20 Nov 2019 04:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=VNlZ/FAha3iKWfOhIc4DYO2pJ9QefE2nLob44SiCntU=;
        b=m8Dcg7cpqnDtL5rhRGExV+fgeA7iO2Gwq0VxT5xB/ugruHtNtExvdqZYHlEwjx5Xqq
         nzHy0TuXEEXJZL6DN7e+xvQIj4UaBePSaQ1P21paHUf9uaGFDbH3acXMl1Td3ufZNGBP
         1vjxK4TGIFHRiVWtc32RW4X/ezDJC7aahvg7wpqG5B0GaxXDcqFgHDsg3edDhp5uTlq2
         5DOpjO8fu27p3K0YdsjlQhaxffYNXHuCpCcBSteBBbTWKvuuHMBIjILSiLiGLRXyOhRf
         hfQZumVuwLZlacHZbVnEpb9vZVcFvLAItwiqLnCwVIYGIT7QXAC7rlWhAumk92zHEMug
         Y9wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VNlZ/FAha3iKWfOhIc4DYO2pJ9QefE2nLob44SiCntU=;
        b=nfRzZ+cwwMwJPTckM5yjJ7eUt1JANV5q7NCxMS7S11cHnYM3GShfy+Q8USsNzD4ZgB
         cQ37HtQYQtKGhh/X1Xj4NEWWUswhZUHxSTxlStQUrHYsMy50ycsUezKyD/M+ZY61pUW5
         V3MKoOijPMV4AshlloN2RJB6DePqAFGbh/qfUb0shbGrEas5Go4bTom7RLPIdASnqzgc
         EeW0RGFAH7ItuNdN5aqLPIlK3JcTDBNAqNV4MIGS9PeqP4X1+pL7k9atjWxpF0MFHt19
         pj7DwJNsq+E8LR0n8krGkzONyfNa+AC/6naVmGSzULdCl0/CH237SC81poVrEJ/pi6Uh
         ToRQ==
X-Gm-Message-State: APjAAAUliXL6J1bvfWD09fzoFynXOc7MLLP9Hfoh9wjJZ/IYEkat1MbH
        k8ei3RSKu4lvKZCqap6wAZZ+8A==
X-Google-Smtp-Source: APXvYqzVdnLKCTQuz42URSFlj8vvD4cR9tivufHNr/dclj9E8ApdhZDS2EsED/hEVq4k8S9GyrRzLA==
X-Received: by 2002:a37:7f02:: with SMTP id a2mr2101242qkd.111.1574254598759;
        Wed, 20 Nov 2019 04:56:38 -0800 (PST)
Received: from Thara-Work-Ubuntu.fios-router.home (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.googlemail.com with ESMTPSA id r2sm14109637qtc.28.2019.11.20.04.56.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Nov 2019 04:56:36 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     edubezval@gmail.com, rui.zhang@intel.com, ulf.hansson@linaro.org,
        daniel.lezcano@linaro.org, bjorn.andersson@linaro.org,
        agross@kernel.org
Cc:     amit.kucheria@verdurent.com, mark.rutland@arm.com,
        rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [Patch v4 0/7] Introduce Power domain based warming device driver
Date:   Wed, 20 Nov 2019 07:56:26 -0500
Message-Id: <1574254593-16078-1-git-send-email-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.1.4
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Certain resources modeled as a generic power domain in linux kernel can be
used to warm up the SoC (mx power domain on sdm845) if the temperature
falls below certain threshold. These power domains can be considered as
thermal warming devices.  (opposite of thermal cooling devices).

In kernel, these warming devices can be modeled as a thermal cooling
device. Since linux kernel today has no instance of a resource modeled as
a power domain acting as a thermal warming device, a generic power domain
based thermal warming device driver that can be used pan-Socs is the
approach taken in this patch series. Since thermal warming devices can be
thought of as the mirror opposite of thermal cooling devices, this patch
series re-uses thermal cooling device framework. To use these power
domains as warming devices require further tweaks in the thermal framework
which are out of scope of this patch series. These tweaks have been posted
as a separate series[1].

The first patch in this series extends the genpd framework to export out
the performance states of a power domain so that when a power domain is
modeled as a cooling device, the number of possible states and current
state of the cooling device can be retrieved from the genpd framework.

The second patch implements the newly added genpd callback for Qualcomm
RPMH power domain driver which hosts the mx power domain.

The third patch introduces a new cooling device register API that allows
a parent to be specified for the cooling device.

The fourth patch introduces the generic power domain warming device
driver.

The fifth patch extends Qualcomm RPMh power controller driver to register
mx power domain as a thermal warming device in the kernel.

The sixth patch describes the dt binding extensions for mx power domain to
be a thermal warming device.

The seventh patch introduces the DT entreis for sdm845 to register mx
power domain as a thermal warming device.

v1->v2:
	- Rename the patch series from "qcom: Model RPMH power domains as
	  thermal cooling devices" to "Introduce Power domain based
thermal warming devices" as it is more appropriate.
	- Introduce a new patch(patch 3) describing the dt-bindings for
	  generic power domain warming device.
	- Patch specific changes mentioned in respective patches.

v2->v3:
	- Changed power domain warming device from a virtual device node
	  entry in DT to being a subnode of power domain controller
binding following Rob's review comments.
	- Implemented Ulf's review comments.
	- The changes above introduced two new patches (patch 3 and 4)
v3->v4:
	- Dropped late_init hook in cooling device ops. Instead introduced
	  a new cooling device register API that allows to define a parent
for the cooling device.
	- Patch specific changes mentioned in respective patches. 

1. https://lkml.org/lkml/2019/9/18/1180

Thara Gopinath (7):
  PM/Domains: Add support for retrieving genpd performance states
    information
  soc: qcom: rpmhpd: Introduce function to retrieve power domain
    performance state count
  thermal: core: Allow cooling devices to register a parent.
  thermal: Add generic power domain warming device driver.
  soc: qcom: Extend RPMh power controller driver to register warming
    devices.
  dt-bindings: soc: qcom: Extend RPMh power controller binding to
    describe thermal warming device
  arm64: dts: qcom: Add mx power domain as thermal warming device.

 .../devicetree/bindings/power/qcom,rpmpd.txt       |   5 +
 arch/arm64/boot/dts/qcom/sdm845.dtsi               |   5 +
 drivers/base/power/domain.c                        |  37 ++++++
 drivers/soc/qcom/rpmhpd.c                          |  47 ++++++-
 drivers/thermal/Kconfig                            |  10 ++
 drivers/thermal/Makefile                           |   2 +
 drivers/thermal/pwr_domain_warming.c               | 138 +++++++++++++++++++++
 drivers/thermal/thermal_core.c                     |  22 +++-
 include/linux/pm_domain.h                          |  13 ++
 include/linux/pwr_domain_warming.h                 |  29 +++++
 include/linux/thermal.h                            |  15 +++
 11 files changed, 319 insertions(+), 4 deletions(-)
 create mode 100644 drivers/thermal/pwr_domain_warming.c
 create mode 100644 include/linux/pwr_domain_warming.h

-- 
2.1.4

