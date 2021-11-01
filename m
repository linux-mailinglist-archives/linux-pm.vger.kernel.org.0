Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A14A8441590
	for <lists+linux-pm@lfdr.de>; Mon,  1 Nov 2021 09:45:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbhKAIrt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Nov 2021 04:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbhKAIrs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Nov 2021 04:47:48 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6158C061714;
        Mon,  1 Nov 2021 01:45:14 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id a9so6098031pgg.7;
        Mon, 01 Nov 2021 01:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=f1aM0liuQiUnZidsG25E4ygJDFmlMCmn077fjqBMsr4=;
        b=Zni+oJwmasb76gqTCs14hhZFS1yInjCuykHry5Hw0FUS6SGH0ZvvWDITIlctRG3pVh
         YH+jxTZDL7vWFNbkKVmO0Vz/mqfj4Fc/WBMB7D/UU3W0SNsQi0ROIap4LyMKa/TlgHAL
         hY8K6aU/ycrEFiGM6H1vFcEqD2poOu66+bT26MOEzPFxvoIueNl1wdZkwHG5ORhMxFiN
         MBAtxB31e0sCaj+fle8JLSAP2dpDRCmqZW3IbGLtV7sl/1vg+BpVSiMvmOWY326LcoS7
         t4g2tA4l0lm1HMYx/vS6f6nty/cpLNwZ/0tJMIiyT70YsmOHag1gIX0O7Eeb5tHIM+ns
         qNYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=f1aM0liuQiUnZidsG25E4ygJDFmlMCmn077fjqBMsr4=;
        b=c9oIvH/W6BPUD2DEec0wvNh54inEZETKd4VXw1mYcRkwC+PPUgwkMPK/s39EHqwtfP
         JCQQUzjf+gd4lxpSTTHrDzszAb90Sme+MEbdUVwOBnCJCQnt56r9NRqWveQS3Xoh2aIE
         AwdOYMuAaqxqFWXhMTCSXYmpZH36+86+HccS+6tOxLm/k2JrncLcrvOzPJ6aunydBKmo
         wjEwqOvi9vaJsksjyaQprSqeBm5kwMst4hmEEVsonWbY8+t6Cx8lM8rGPX62waBw8C92
         /n1/zZpdu5Bc8olcHjTfoomuSYVnSV7EaMqiYynwIzBuvgeZ4LEwLdXimlBB72/XvKRe
         mQBQ==
X-Gm-Message-State: AOAM530J4fT2DSm4fZucolSNrhucA4Ogvq26mk2+QA/AaYaWdbU6TbTw
        PHB2GWRmmuLhgTJniDrStiE=
X-Google-Smtp-Source: ABdhPJyieHWTTLi1/2UKr+UDFggR2CiUjE9KXutu6HsGJ5HjbZG0HbKvRojJfsaOGUYnv4K24gB6EQ==
X-Received: by 2002:a63:954a:: with SMTP id t10mr20910388pgn.89.1635756313992;
        Mon, 01 Nov 2021 01:45:13 -0700 (PDT)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id nv5sm13406574pjb.10.2021.11.01.01.45.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Nov 2021 01:45:13 -0700 (PDT)
From:   "LH.Kuo" <lhjeff911@gmail.com>
X-Google-Original-From: "LH.Kuo" <lh.kuo@sunplus.com>
To:     rafael@kernel.org, daniel.lezcano@linaro.org, amitk@kernel.org,
        rui.zhang@intel.com, robh+dt@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     qinjian@cqplus1.com, wells.lu@sunplus.com,
        "LH.Kuo" <lh.kuo@sunplus.com>
Subject: [PATCH 0/2] Add THERMAL control driver for Sunplus SP7021 SoC
Date:   Mon,  1 Nov 2021 16:45:08 +0800
Message-Id: <1635756310-25415-1-git-send-email-lh.kuo@sunplus.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This is a patch series for THERMAL driver for Sunplus SP7021 SoC.

Sunplus SP7021 is an ARM Cortex A7 (4 cores) based SoC. It integrates
many peripherals (ex: UART, I2C, SPI, SDIO, eMMC, USB, SD card and
etc.) into a single chip. It is designed for industrial control.

Refer to:
https://sunplus-tibbo.atlassian.net/wiki/spaces/doc/overview
https://tibbo.com/store/plus1.html

LH.Kuo (2):
  THERMAL: Add THERMAL driver for Sunplus SP7021
  devicetree bindings THERMAL Add bindings doc for Sunplus SP7021

 .../bindings/thermal/sunplus_thermal.yaml          |  52 ++++
 MAINTAINERS                                        |   7 +
 drivers/thermal/Kconfig                            |  10 +
 drivers/thermal/Makefile                           |   1 +
 drivers/thermal/sunplus_thermal.c                  | 287 +++++++++++++++++++++
 5 files changed, 357 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/sunplus_thermal.yaml
 create mode 100644 drivers/thermal/sunplus_thermal.c

-- 
2.7.4

