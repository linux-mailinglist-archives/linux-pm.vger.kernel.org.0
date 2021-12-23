Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0E547E612
	for <lists+linux-pm@lfdr.de>; Thu, 23 Dec 2021 16:54:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244541AbhLWPyA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 23 Dec 2021 10:54:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244540AbhLWPx7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Dec 2021 10:53:59 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3475BC061756
        for <linux-pm@vger.kernel.org>; Thu, 23 Dec 2021 07:53:59 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id n14-20020a7bcbce000000b00332f4abf43fso3505906wmi.0
        for <linux-pm@vger.kernel.org>; Thu, 23 Dec 2021 07:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=FqMj15pr+a7HiZ0A1HaQ6YqXDt0s7H/sHdsb8xKr4DI=;
        b=KjLS/oRCjnl/V3wbZCyuVMKLyyjEG1xgl7FovVZoalSS+L3wAywJCY3k+UgrOcFnm0
         icwwA1BApWPPJ7OSs5O2D71S4FkckvbVITzTQHZ71VvFL6jTU9DyR6Z37YwDUR65xcgq
         PC6hqt/5Uaut8km/cFyDiiP7ovViBJKuwgS3RudBfxlNVkmp/PlUijbzdp/m3T5OWnnn
         rRwSMUoKtwdRgmW3ZbQ3LGZ7ASBcs87HmaD0e1FanLwAJJakEXvs+DbgVl2IijccjSL1
         Gw9uYUrevDg0PTrbMNKS+g+hj5Byi37jgUqlC7YdCzK2HsvL43z85h8f0HN2NA1okWuN
         lteQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=FqMj15pr+a7HiZ0A1HaQ6YqXDt0s7H/sHdsb8xKr4DI=;
        b=vQIx/jjmcsDDgTxxjjkN76Zb6iko8jbUWeuYYvOvMl/ZK8r1rEy7sJhtPgpcRthk33
         14uuXOFJOwjTuGZAldFKWoowM/HVrQdtC1qO21yTK64jwwAQK8P2fmMD5MPwzNGyzjcT
         qhf5A/xC73ZAyxVCDCpTlIZ0EndLUTOcFkWFSMpgELk49WbIr5Zw8d9MzdDJPacCGOZg
         YAn+okLNevCB/7Fph3Elpg/HssFBQ+9w6NYxSxT7y9SqM7IbkpGkOe8iB/RFMX426DaK
         OKViXy3H8s3z4++Npn4vQH/h4BVCALQcDzxyArpBd5xLva1a6tKEbCJrouK6PZui/xw/
         tpDQ==
X-Gm-Message-State: AOAM530owv4YKGwu5q3oBuunTPOzRFBIPX3xiPc8go8T+RTMfqrH2sUd
        5F7sedHfwpoLOoOn6MEQeIp41kkhO2BbiKa4
X-Google-Smtp-Source: ABdhPJzsOke/2QZSeNEQqHJrra2yODFAwrNHsArkj7UCuV9NATinz1PiIqpFz6r1TD1UA+3mvcjCaw==
X-Received: by 2002:a05:600c:1e8b:: with SMTP id be11mr2257567wmb.51.1640274837681;
        Thu, 23 Dec 2021 07:53:57 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:34ca:f67b:b782:1949? ([2a01:e34:ed2f:f020:34ca:f67b:b782:1949])
        by smtp.googlemail.com with ESMTPSA id c8sm5778726wmq.34.2021.12.23.07.53.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Dec 2021 07:53:57 -0800 (PST)
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Oleksij Rempel <linux@rempel-privat.de>,
        Paul Gerber <Paul.Gerber@tq-group.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        rikard.falkeborn@gmail.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT PULL] thermal for v5.17
Message-ID: <d393e7d8-b192-ff15-65f1-35f11e1a06bc@linaro.org>
Date:   Thu, 23 Dec 2021 16:53:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi Rafael,


The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:

  Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git
tags/thermal-v5.17-rc1

for you to fetch changes up to 8ee1c0f6526ce942b7595951c7bb0165010051c2:

  thermal/drivers/rz2gl: Add error check for reset_control_deassert()
(2021-12-09 15:58:09 +0100)

----------------------------------------------------------------
- Fix PM issue on the iMX driver when suspend/resume is happening by
  implementing PM runtime support (Oleksij Rempel)

- Add 'const' annotation to the thermal_cooling_ops in the Intel
  powerclamp driver (Rikard Falkeborn)

- Add TSU driver and bindings for the RZ/G2L platform (Biju Das)

- Fix the missing ADC bit set on iMX8MP to enable the sensor (Paul
  Gerber)

- Fix missing check when calling reset_control_deassert() (Biju Das)

----------------------------------------------------------------
Biju Das (3):
      dt-bindings: thermal: Document Renesas RZ/G2L TSU
      thermal/drivers: Add TSU driver for RZ/G2L
      thermal/drivers/rz2gl: Add error check for reset_control_deassert()

Oleksij Rempel (1):
      thermal/drivers/imx: Implement runtime PM support

Paul Gerber (1):
      thermal/drivers/imx8mm: Enable ADC when enabling monitor

Rikard Falkeborn (1):
      thermal/drivers/intel_powerclamp: Constify static
thermal_cooling_device_ops

 .../devicetree/bindings/thermal/rzg2l-thermal.yaml |  76 +++++++
 drivers/thermal/Kconfig                            |   9 +
 drivers/thermal/Makefile                           |   1 +
 drivers/thermal/imx8mm_thermal.c                   |   3 +
 drivers/thermal/imx_thermal.c                      | 145 +++++++-----
 drivers/thermal/intel/intel_powerclamp.c           |   2 +-
 drivers/thermal/rzg2l_thermal.c                    | 242
+++++++++++++++++++++
 7 files changed, 423 insertions(+), 55 deletions(-)
 create mode 100644
Documentation/devicetree/bindings/thermal/rzg2l-thermal.yaml
 create mode 100644 drivers/thermal/rzg2l_thermal.c

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
