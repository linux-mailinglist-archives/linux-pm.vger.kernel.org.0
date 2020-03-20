Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6168118C4AA
	for <lists+linux-pm@lfdr.de>; Fri, 20 Mar 2020 02:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbgCTBlL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Mar 2020 21:41:11 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35293 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727207AbgCTBlL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Mar 2020 21:41:11 -0400
Received: by mail-qk1-f195.google.com with SMTP id d8so5429117qka.2
        for <linux-pm@vger.kernel.org>; Thu, 19 Mar 2020 18:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eZP0u8ITunLiIIRvSTm1UDhFa2x+FOEr9rW1o7749xQ=;
        b=ch9QVTq4I67QoriwHaevg8GW7hXScd11/w/CBbCQ7WxRxps1cAMVtSS6fHp9gCncIZ
         S78U66ED8dfSrlv95xnu/Eyg5Z1Mnlg1sOfTgqTrxCmMGsPf3W9IGy1vAKNiIgXXbA0d
         BOSCBXlTGB66Kt8TKlqT4G9y43hVCO20Q8pvNBDnbJ/D3tbRjTlGGxl1CsWfy4+gj/kJ
         /ozhlhuSfH2+lcIEEdWAeQ+NDIBRv6Oks/lBViT0vCDcqDj1P4UZuev0K9cK5pMdvkIO
         wTO66o7+GMiKoRws/uakv1R3YiPY+SK0oZRTwUToFigy5QhCfpAASMlt2MywZ3943Avs
         TJ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eZP0u8ITunLiIIRvSTm1UDhFa2x+FOEr9rW1o7749xQ=;
        b=SPJXgB7e8Tbd8aVew4gl/XKKpBIZ9kmm0cqCxR+iWnACownN8VKNke1/FDCEfb1bsK
         yoC0XLdTLoSdB+3h0WBj3XeaD10XAgLHND5I7RPc7wctHVdJTKBOo5vKl7T2lMcFTJ7b
         waNVHDMOfkW2gOtjIg4165wxvZ+/cJj7PCGIEmIfIVwKM0w008OZV/loLpOjkKDv7bbZ
         k6Rz2cqjhXEwFcvT9HD0cTX1lLpxghXnoMM7LAmrC7zbrjYW/XiwrzHhnAWqlhX4nIti
         +pb3tWI+hrAaWIP+xcnqVxeVAwqVpTlfMU26kbCgBFXPraFl6C/d4dQgGnPHspxf7S8a
         p8Lg==
X-Gm-Message-State: ANhLgQ0n0Q32KfRYzysrmyK3yIJGMMawrHUDdhJQKOt0933/S2D8YJwo
        928zim4TpogXXC7kG7jRpryVtg==
X-Google-Smtp-Source: ADFU+vtHoEjmxDMNZ3DTXsUDWYUwN7WHrNIVQU4FEmg3Vg32kJaDK07DIpk0aYZpGhtYL0mspWm+WA==
X-Received: by 2002:a37:4bd1:: with SMTP id y200mr4044290qka.205.1584668469530;
        Thu, 19 Mar 2020 18:41:09 -0700 (PDT)
Received: from pop-os.fios-router.home (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.googlemail.com with ESMTPSA id 2sm2706287qtp.33.2020.03.19.18.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 18:41:08 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     rui.zhang@intel.com, ulf.hansson@linaro.org,
        daniel.lezcano@linaro.org, bjorn.andersson@linaro.org,
        agross@kernel.org, robh@kernel.org
Cc:     amit.kucheria@verdurent.com, mark.rutland@arm.com,
        rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [Patch v5 0/6] Introduce Power domain based warming device driver
Date:   Thu, 19 Mar 2020 21:41:01 -0400
Message-Id: <20200320014107.26087-1-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

v4->v5:
	- Dropped the patch that introduced the cooling device register
	  API with parent as per review comments from Ulf. 
	- Patch specific changes mentioned in respective patches.

1. https://lkml.org/lkml/2019/9/18/1180

Thara Gopinath (6):
  PM/Domains: Add support for retrieving genpd performance states
    information
  soc: qcom: rpmhpd: Introduce function to retrieve power domain
    performance state count
  thermal: Add generic power domain warming device driver.
  soc: qcom: Extend RPMh power controller driver to register warming
    devices.
  dt-bindings: power: Extend RPMh power controller binding to describe
    thermal warming device
  arm64: dts: qcom: Indicate rpmhpd hosts a power domain that can be
    used as a warming device.

 .../devicetree/bindings/power/qcom,rpmpd.yaml |   3 +
 arch/arm64/boot/dts/qcom/sdm845.dtsi          |   1 +
 drivers/base/power/domain.c                   |  37 ++++
 drivers/soc/qcom/rpmhpd.c                     |  46 ++++-
 drivers/thermal/Kconfig                       |  10 ++
 drivers/thermal/Makefile                      |   2 +
 drivers/thermal/pd_warming.c                  | 168 ++++++++++++++++++
 include/linux/pd_warming.h                    |  29 +++
 include/linux/pm_domain.h                     |  13 ++
 9 files changed, 308 insertions(+), 1 deletion(-)
 create mode 100644 drivers/thermal/pd_warming.c
 create mode 100644 include/linux/pd_warming.h

-- 
2.20.1

