Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 110DFAF038
	for <lists+linux-pm@lfdr.de>; Tue, 10 Sep 2019 19:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394237AbfIJROj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Sep 2019 13:14:39 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42550 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387980AbfIJROj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Sep 2019 13:14:39 -0400
Received: by mail-qt1-f194.google.com with SMTP id c17so2297334qtv.9
        for <linux-pm@vger.kernel.org>; Tue, 10 Sep 2019 10:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=HbUIStHt9W/VIVERFYwcoKZrgnGZv23yOnmmJWnfWUc=;
        b=FjmYkULyMuJcFn7OokF8bYWgJVx6OD7aYCYCSC4Dqpj2ITrv4r5yGTCwjVijbaDYUu
         We/YcdS0ku60UXpQrNszmQVVnDD79Ay70tiYuCT3+S4VSUQV3DmyKfeifQHF4HU8S03J
         GD0OaCoNlipM/xrnjeL1Cqxx490vIOr1y3FICsO/9bPIeazxhgb8bRjQOD1SPoNBX2Yc
         WvY8JpScsb04OvYCiw0AxSgJLN0hPOOVYQuykM1XIBmppbJUdl7xKJs0QlqX2n+pK2xP
         S1ec721gVt9+qSGz+RiuI42Jjz41w8LxB+2VxEVYOVhytvSgi+CywF8UpAjALOYAZae2
         GDMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HbUIStHt9W/VIVERFYwcoKZrgnGZv23yOnmmJWnfWUc=;
        b=gOOx3ejinjJ3jtj2Jt07NM0dZmTIOuYkMWBnRyd2/vdZ0IiDg5drHUeHq1070qSn8/
         66jp6jwiIcvfvyztWrqHfxwM3tYbi4eENgQGgUbMMCres3QgVJy5MDTR8sD2reiza5Ao
         00zDhEvrjBenPFB4B5doFGIPf89M5exArsUOHh3f7+QxpiXeJiq03hf6w0HxesgDAhIL
         bSS7/07jfRM5buwaey/eLVhiaqPtCYpcBVTRfqxcUUm01MVCIj+gwZOE/7iJ6VZwi0Cz
         t3GJlqhZLGETgeDUB4FG41Ov9UW9Skr/3u5BXNO1rklCVbntDorjBxTBL9/wMyAwZyPN
         mKow==
X-Gm-Message-State: APjAAAUMDvLK7FKfIHghFfmNFRMeAS1r2uiQCdPrrSh6H6oNnt56kVYW
        dI42V4TBzZAsyGbdzMs70NuxqA==
X-Google-Smtp-Source: APXvYqygj73ABNv7vOyOOorsAJk5oGGfIsSa/ouC8yqhBl2cKmgH+hBRVUAQ4JHsBlgT4pb76Bt4fg==
X-Received: by 2002:ac8:647:: with SMTP id e7mr9928642qth.78.1568135678393;
        Tue, 10 Sep 2019 10:14:38 -0700 (PDT)
Received: from Thara-Work-Ubuntu.fios-router.home (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.googlemail.com with ESMTPSA id g45sm3400713qtc.9.2019.09.10.10.14.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Sep 2019 10:14:37 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     edubezval@gmail.com, rui.zhang@intel.com, ulf.hansson@linaro.org,
        daniel.lezcano@linaro.org, bjorn.andersson@linaro.org,
        robh+dt@kernel.org, agross@kernel.org
Cc:     amit.kucheria@verdurent.com, mark.rutland@arm.com,
        rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] Introduce Power domain based warming device driver
Date:   Tue, 10 Sep 2019 13:14:31 -0400
Message-Id: <1568135676-9328-1-git-send-email-thara.gopinath@linaro.org>
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
thermal cooling device. In fact, since linux kernel today has
no instance of a resource modeled as a power domain acting as a
thermal warming device, a generic power domain based thermal warming device
driver that can be used pan-Socs is the approach taken in this
patch series. Since thermal warming devices can be thought of as the
mirror opposite of thermal cooling devices, this patch series re-uses
thermal cooling device framework. To use these power domains as warming
devices require further tweaks in the thermal framework which are out of
scope of this patch series.

The first patch in this series extends the genpd framework to export out
the performance states of a power domain so that when a power
domain is modeled as a cooling device, the number of possible states and
current state of the cooling device can be retrieved from the genpd
framework.

The second patch implements the newly added genpd callback for Qualcomm
RPMH power domain driver which hosts the mx power domain.

The third patch describes the dt binding required for a generic
power domain based warming device

The fourth patch introduces the generic power domain warming device driver

The fifth patch introduces the DT entreis for sdm845 to register mx power
domain as a thermal warming device

v1->v2:
	- Rename the patch series from
	"qcom: Model RPMH power domains as thermal cooling devices" to
	"Introduce Power domain based thermal warming devices" as it is
	more appropriate.
	- Introduce a new patch(patch 3) describing the dt-bindings for generic power
	domain warming device.
	- Patch specific changes mentioned in respective patches.

Thara Gopinath (5):
  PM/Domains: Add support for retrieving genpd performance states
    information
  soc: qcom: rpmhpd: Introduce function to retrieve power domain
    performance state count
  dt-bindings: thermal: Add generic power domain warming device binding
  thermal: Add generic power domain warming device driver.
  arm64: dts: qcom: Add node for RPMH power domain warming device on
    sdm845.

 .../bindings/thermal/pwr-domain-warming.txt        |  32 ++++
 arch/arm64/boot/dts/qcom/sdm845.dtsi               |   7 +
 drivers/base/power/domain.c                        |  37 +++++
 drivers/soc/qcom/rpmhpd.c                          |   9 ++
 drivers/thermal/Kconfig                            |  11 ++
 drivers/thermal/Makefile                           |   2 +
 drivers/thermal/pwr_domain_warming.c               | 174 +++++++++++++++++++++
 include/linux/pm_domain.h                          |  13 ++
 8 files changed, 285 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/pwr-domain-warming.txt
 create mode 100644 drivers/thermal/pwr_domain_warming.c

-- 
2.1.4

