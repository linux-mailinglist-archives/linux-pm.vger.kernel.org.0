Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8D53A06DA
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jun 2021 00:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234643AbhFHWcg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Jun 2021 18:32:36 -0400
Received: from mail-qt1-f179.google.com ([209.85.160.179]:46078 "EHLO
        mail-qt1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234613AbhFHWcg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Jun 2021 18:32:36 -0400
Received: by mail-qt1-f179.google.com with SMTP id l17so12395708qtq.12
        for <linux-pm@vger.kernel.org>; Tue, 08 Jun 2021 15:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tzGX9fCwBa/GCHza5uoWn4deXxt6OaL//ssg+qUDOEo=;
        b=D7PNmOWjCmF8+3mFiGGTqNTIUWlfHeFkDtHsNekzwL+AYtd5b2C2igUsryUEAOK1uz
         /JkNiwMvs0RT/HznC/08bGC4/0QWrjnzDZtaT1wceonkgDm25xnmPduKvzo9PMrqa1sA
         tVt2H1hyEYltb+45GCQlcp7hWTOz3iunBd7RTBRUemLpLzsA4HmiNalUeBXkPtzZ4DsP
         NQ43JWRhW1CPoLF79KpXhoYgKqevlKoBLYB1noUAyH16aeVs2QlLeL08Hcu/HIM8+q+W
         ACtgWEfXJb97oOkVdO2SxfQTX8U1qBZ1/2XF6rzvUaohMLSXrD91LcALk8HgNnNPS4eD
         Oz5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tzGX9fCwBa/GCHza5uoWn4deXxt6OaL//ssg+qUDOEo=;
        b=XUai01PKXpOKAuIrStQcyjS7LnQuckHbBEtLfXi8/kKxrpJeaRrXG5oQuyx8WxMHXB
         nIMW7khJjgV4AO56UPwvbio7/x+iaDAKyjFdg4HxkV9ACaokuQRUkRBK7NdCEqxO7S0C
         rpnVEveT+OQ7QTfNbusn/wn211vY67z3qzs0488SJjCMkic4ai9r6JRsSS+oVJ0YPFEH
         R5yJrN+xqsH25ch0xmDJBQtjp1YywIvbGdlaS8Mgp+hhKm0GZkPcfbDx59l+DB5l0lj/
         fpysyK3nvKQzmAQkWQ8dhcewQ1XcqbAIKa7m/Swu4pPhR0CccNjaI0PthCrUJ4F9f7EW
         mSrw==
X-Gm-Message-State: AOAM532T8ai9Vk6D5imZ5Vk58TDlaj+L3rCsH7UVGL8kiDuDfyigJ62U
        vYVKBm4itwFK06bq1+iZdEK4jQ==
X-Google-Smtp-Source: ABdhPJxbwnFt1DfjxCZC3qMn+TbSldnacV1TMWu10I0frpYsRYfLipKNMEXkMuMjDsR8xulCl6pjxg==
X-Received: by 2002:ac8:1286:: with SMTP id y6mr4073535qti.58.1623191367897;
        Tue, 08 Jun 2021 15:29:27 -0700 (PDT)
Received: from pop-os.fios-router.home (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.googlemail.com with ESMTPSA id h19sm10450736qtq.5.2021.06.08.15.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 15:29:27 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        rjw@rjwysocki.net, robh+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 0/5] Introduce LMh driver for Qualcomm SoCs
Date:   Tue,  8 Jun 2021 18:29:21 -0400
Message-Id: <20210608222926.2707768-1-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Limits Management Hardware(LMh) is a hardware infrastructure on some
Qualcomm SoCs that can enforce temperature and current limits as programmed
by software for certain IPs like CPU. On many newer SoCs LMh is configured
by firmware/TZ and no programming is needed from the kernel side. But on
certain SoCs like sdm845 the firmware does not do a complete programming of
the h/w block. On such SoCs kernel software has to explicitly set up the
temperature limits and turn on various monitoring and enforcing algorithms
on the hardware.

Introduce support for enabling and programming various limit settings and
monitoring capabilities of Limits Management Hardware(LMh) associated with
cpu clusters. Also introduce support in cpufreq hardware driver to monitor
the interrupt associated with cpu frequency throttling so that this
information can be conveyed to the schdeuler via thermal pressure
interface.

With this patch series following cpu performance improvement(30-70%) is
observed on sdm845. The reasoning here is that without LMh being programmed
properly from the kernel, the default settings were enabling thermal
mitigation for CPUs at too low a temperature (around 70-75 degree C).  This
in turn meant that many a time CPUs were never actually allowed to hit the
maximum possible/required frequencies.

UnixBench whets and dhry (./Run whets dhry)
System Benchmarks Index Score

		Without LMh Support		With LMh Support
1 copy test	1353.7				1773.2

8 copy tests	4473.6				7402.3

Sysbench cpu 
sysbench cpu --threads=8 --time=60 --cpu-max-prime=100000 run

		Without LMh Support		With LMh Support
Events per
second			355				614

Avg Latency(ms)		21.84				13.02

Thara Gopinath (5):
  firmware: qcom_scm: Introduce SCM calls to access LMh
  thermal: qcom: Add support for LMh driver
  cpufreq: qcom-cpufreq-hw: Add dcvs interrupt support
  arm64: boot: dts: sdm45: Add support for LMh node
  arm64: boot: dts: qcom: sdm845: Remove passive trip points for thermal
    zones 0-7

 arch/arm64/boot/dts/qcom/sdm845.dtsi | 246 +++------------------------
 drivers/cpufreq/qcom-cpufreq-hw.c    | 100 +++++++++++
 drivers/firmware/qcom_scm.c          |  47 +++++
 drivers/firmware/qcom_scm.h          |   4 +
 drivers/thermal/qcom/Kconfig         |  10 ++
 drivers/thermal/qcom/Makefile        |   1 +
 drivers/thermal/qcom/lmh.c           | 244 ++++++++++++++++++++++++++
 include/linux/qcom_scm.h             |  13 ++
 8 files changed, 440 insertions(+), 225 deletions(-)
 create mode 100644 drivers/thermal/qcom/lmh.c

-- 
2.25.1

