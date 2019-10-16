Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC8C5D9A50
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2019 21:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394443AbfJPThb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Oct 2019 15:37:31 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44209 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728779AbfJPThb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Oct 2019 15:37:31 -0400
Received: by mail-qt1-f194.google.com with SMTP id u40so37844375qth.11
        for <linux-pm@vger.kernel.org>; Wed, 16 Oct 2019 12:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=mJHOakKVvshLG3Rzud38KEbOaNx+SThGCVNUUHA+c8k=;
        b=w5G4rO6cnoFzj2kF84Hr/GZtHT1Zve5j9WyjVpVK9JFX1mk/AvbZfE6glsJsrQ2bHZ
         d5BOsKSptJU5C1rkmoLn0qoBb/KDjamoVhNZQGaVK8YXrI5KcY4G4SHD3Y4lnNwXm4zd
         NmfTkknFJgHcYV9nVtUW8GTl+JrglpLjDPrfw5xC5bCBkIMICrkq32IqMFGPeZ+Rzc7t
         VZrraGhKRx+Z7vFexQpkgnUDhj+9WXA2uS/1/4J+kd1U2cQhs9M1HOwkxln44HNgMUiW
         GJ/mMZoochmYSU5FNxeRWPETGriXjfl6QqyVWhLFx8gwcRWSDYZb6/Wn+LJrVuDrsRtW
         /v7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mJHOakKVvshLG3Rzud38KEbOaNx+SThGCVNUUHA+c8k=;
        b=Zn8ecp6KNiLCuBwmc0T28JURQX+zonPSwgqN/utcip9tuFVc9qlV85mnHGTRbxqmyR
         drfPfV48u3FcmHLwPPI4k0WUmGVMSEE4nBgsCgfUT5BTXhrkExTGoL7zqwo4DCGdpdTS
         BWlx+Lt4X7N/H6fRq9qOJc5WlVsNoCrYcX7NuCgHti9VyAJEYJCPSnnr+GNA6tHMEjcd
         gr4R3t3alPNzwaa1PF6nKIHKWgt6s4SMRvQXskYOJ3Uqdt7O3xXdA8VY5KGu1c24BOex
         sYMoUvRV+1LiANvtXEB4kzs4yFMmo1x4UNkTcUk3Aiqpo0HQEqmWRxU8uGphmb+ZSoQ9
         BJTw==
X-Gm-Message-State: APjAAAVmGlYSfGcksmeMPlzQzy6NMveJS9MUeBTCvz06l3TwZtPySwr+
        4eDypnmJZlhxoXHGVTTwISDfN9cb9joeag==
X-Google-Smtp-Source: APXvYqxksfg5j666p6bPfX8pfqyE2zz9v/AOGwzl9RkscOjeUr/PexA0qh0wHbZrIjzQkfl9oeTToQ==
X-Received: by 2002:a0c:c10d:: with SMTP id f13mr44317850qvh.88.1571254648443;
        Wed, 16 Oct 2019 12:37:28 -0700 (PDT)
Received: from Thara-Work-Ubuntu.fios-router.home (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.googlemail.com with ESMTPSA id 54sm16246030qts.75.2019.10.16.12.37.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 Oct 2019 12:37:27 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     edubezval@gmail.com, rui.zhang@intel.com, ulf.hansson@linaro.org,
        daniel.lezcano@linaro.org, bjorn.andersson@linaro.org,
        agross@kernel.org
Cc:     amit.kucheria@verdurent.com, mark.rutland@arm.com,
        rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/7]Introduce Power domain based warming device driver
Date:   Wed, 16 Oct 2019 15:37:14 -0400
Message-Id: <1571254641-13626-1-git-send-email-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.1.4
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Certain resources modeled as a generic power domain in linux kernel
can be used to warm up the SoC (mx power domain on sdm845)
if the temperature falls below certain threshold. These power domains
can be considered as thermal warming devices.
(opposite of thermal cooling devices).

In kernel, these warming devices can be modeled as a
thermal cooling device. Since linux kernel today has
no instance of a resource modeled as a power domain acting as a
thermal warming device, a generic power domain based thermal warming device
driver that can be used pan-Socs is the approach taken in this
patch series. Since thermal warming devices can be thought of as the
mirror opposite of thermal cooling devices, this patch series re-uses
thermal cooling device framework. To use these power domains as warming
devices require further tweaks in the thermal framework which are out of
scope of this patch series. These tweaks have been posted as a separate
series[1].

The first patch in this series extends the genpd framework to export out
the performance states of a power domain so that when a power
domain is modeled as a cooling device, the number of possible states and
current state of the cooling device can be retrieved from the genpd
framework.

The second patch implements the newly added genpd callback for Qualcomm
RPMH power domain driver which hosts the mx power domain.

The third patch introduces late init ops for thermal cooling device that
is called after the cooling device is created and registered but before
binding it to a thermal zone for specific initializations.

The fourth patch introduces the generic power domain warming device driver.

The fifth patch extends Qualcomm RPMh power controller driver to register
mx power domain as a thermal warming device in the kernel.

The sixth patch describes the dt binding extensions for mx power domain to
be a thermal warming device.

The seventh patch introduces the DT entreis for sdm845 to register mx power
domain as a thermal warming device.

v1->v2:
        - Rename the patch series from
        "qcom: Model RPMH power domains as thermal cooling devices" to
        "Introduce Power domain based thermal warming devices" as it is
        more appropriate.
        - Introduce a new patch(patch 3) describing the dt-bindings for
	generic power domain warming device.
        - Patch specific changes mentioned in respective patches.

v2->v3:
	- Changed power domain warming device from a virtual device node
	entry in DT to being a subnode of power domain controller binding
	following Rob's review comments.
	- Implemented Ulf's review comments.
	- The changes above introduced two new patches (patch 3 and 4)

1. https://lkml.org/lkml/2019/9/18/1180
Thara Gopinath (7):
  PM/Domains: Add support for retrieving genpd performance states
    information
  soc: qcom: rpmhpd: Introduce function to retrieve power domain
    performance state count
  thermal: core: Add late init hook to cooling device ops
  thermal: Add generic power domain warming device driver.
  soc: qcom: Extend RPMh power controller driver to register warming
    devices.
  dt-bindings: soc: qcom: Extend RPMh power controller binding to
    describe thermal warming device
  arm64: dts: qcom: Add mx power domain as thermal warming device.

 .../devicetree/bindings/power/qcom,rpmpd.txt       |  10 ++
 arch/arm64/boot/dts/qcom/sdm845.dtsi               |   5 +
 drivers/base/power/domain.c                        |  37 ++++++
 drivers/soc/qcom/rpmhpd.c                          |  30 ++++-
 drivers/thermal/Kconfig                            |  10 ++
 drivers/thermal/Makefile                           |   2 +
 drivers/thermal/pwr_domain_warming.c               | 136 +++++++++++++++++++++
 drivers/thermal/thermal_core.c                     |  13 ++
 include/linux/pm_domain.h                          |  13 ++
 include/linux/pwr_domain_warming.h                 |  31 +++++
 include/linux/thermal.h                            |   1 +
 11 files changed, 287 insertions(+), 1 deletion(-)
 create mode 100644 drivers/thermal/pwr_domain_warming.c
 create mode 100644 include/linux/pwr_domain_warming.h

-- 
2.1.4

