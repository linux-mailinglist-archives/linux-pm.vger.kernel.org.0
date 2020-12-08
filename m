Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C52F2D3003
	for <lists+linux-pm@lfdr.de>; Tue,  8 Dec 2020 17:43:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730524AbgLHQnB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Dec 2020 11:43:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730258AbgLHQnB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Dec 2020 11:43:01 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A832AC061794
        for <linux-pm@vger.kernel.org>; Tue,  8 Dec 2020 08:42:20 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id m19so25419677ejj.11
        for <linux-pm@vger.kernel.org>; Tue, 08 Dec 2020 08:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lRHO/dd4K0+UmYNDK5G5hy4CRUx6ajfflGnapOkGJI0=;
        b=KfCs9sjAhAbjk8EjSJ+o/JIZLkCTlFFa6i1SDAFCvTt3CMQenAzLbZmWIbp2J5LpAz
         TWJE5PIb62HUICjXTqLY7vd+iWm1o5jE3e4e7Cq3lfG/XAJB/FORTRhHtf95Kn2WnN5f
         qcy+Ly6jEtjQTWB5nGlnImjenkVO2bigsyuRmFdsTYsV2ooYgKPUm/hd+iX3s5Fa/+c/
         alfhsezXjo/FdmbmRZYaI36Ti6BNUdCN8Cciiu5/KIw356FarV+W0tC5715BB0uFab/D
         EW9275UxkpxG9OzjiruKMCYHT2qEVPtSLJsJ8sue42sP5jMJpCxCirdpy0tcngvhRGJo
         LF4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lRHO/dd4K0+UmYNDK5G5hy4CRUx6ajfflGnapOkGJI0=;
        b=J71oIgnwNHjbPPP78pHNJ82owXWw1Irh0p3QmsPj0E8NBYxFzIOVkSTL3PRReLGDvp
         Wbgh7iqI/n7sZKQEYtIQ6b45uhIlbCDzQtZxmJodUM7liw7rSwY/jMmVen87lMUS9BDR
         Is/zn3UzKlFH8JJnIkDiv93g9u0bDLoXPR+5VdBz40JqwPeFsDPNMkvvIO6eWTSA2ssf
         qR1SRAiMmtXa1E0HDErlqIx9+wV79EWpFOnpo42nUdrZlzoj83n0+5ASKt2qeyxAfydp
         C6cw7ZHF6ZaJYuwMOOBBALddU6Sh0t9nFw/zfU+kIW2DU3HQXkvEychs5KffgM5xInBD
         HOog==
X-Gm-Message-State: AOAM530+1e/8bxUAH2WSgflRM1fq53GTuux7kleD2+/QTM20bW81qfr3
        4r4IFwN9+JKKxRvs+nIu26EY11aj3cuu9A==
X-Google-Smtp-Source: ABdhPJwuTYn2PCtf27aYV9lEwk/hkNPq/4oVElXDbSYN5MnVac0/xmcuysMZmnFAgoFeiwgJ0CtkLw==
X-Received: by 2002:a17:906:1102:: with SMTP id h2mr15819717eja.296.1607445739255;
        Tue, 08 Dec 2020 08:42:19 -0800 (PST)
Received: from localhost.localdomain (lns-bzn-59-82-252-158-132.adsl.proxad.net. [82.252.158.132])
        by smtp.gmail.com with ESMTPSA id t19sm16150546eje.86.2020.12.08.08.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 08:42:18 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rjw@rjwysocki.net
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Ram Chandrasekar <rkumbako@codeaurora.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>
Subject: [PATCH v5 0/4] powercap/dtpm: Add the DTPM framework
Date:   Tue,  8 Dec 2020 17:41:41 +0100
Message-Id: <20201208164145.19493-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The density of components greatly increased the last decade bringing a
numerous number of heating sources which are monitored by more than 20
sensors on recent SoC. The skin temperature, which is the case
temperature of the device, must stay below approximately 45°C in order
to comply with the legal requirements.

The skin temperature is managed as a whole by an user space daemon,
which is catching the current application profile, to allocate a power
budget to the different components where the resulting heating effect
will comply with the skin temperature constraint.

This technique is called the Dynamic Thermal Power Management.

The Linux kernel does not provide any unified interface to act on the
power of the different devices. Currently, the thermal framework is
changed to export artificially the performance states of different
devices via the cooling device software component with opaque values.
This change is done regardless of the in-kernel logic to mitigate the
temperature. The user space daemon uses all the available knobs to act
on the power limit and those differ from one platform to another.

This series provides a Dynamic Thermal Power Management framework to
provide an unified way to act on the power of the devices.

Changelog:
 V5:
  - Fixed typos in documentation
  - Added a dtpm NULL pointer check in the dtpm_register() function
 V4:
  - Changed fine grain spinlocks by global tree mutex lock
    - Dropped tested by tag from Lukasz
  - Fixed rollback routine in dtpm_cpu
  - Checked freq_qos_request_active() when releasing the dtpm_cpu node
 V3:
  - Fixed power-limit computation in addition with the hotplugging
  - Improved the encapsulation
  - Added specific ops for the leaves of the tree
  - Simplified API and self-encapsulation
  - Fixed documentation and generated it to check the content
 V2:
  - Fixed indentation
  - Fixed typos in comments
  - Fixed missing kfree for dtpm_cpu
  - Capitalize letters in the Kconfig description
  - Reduced name description
  - Stringified section name
  - Added more debug traces in the code
  - Removed duplicate initialization in the dtpm cpu

Daniel Lezcano (4):
  units: Add Watt units
  Documentation/powercap/dtpm: Add documentation for dtpm
  powercap/drivers/dtpm: Add API for dynamic thermal power management
  powercap/drivers/dtpm: Add CPU energy model based support

 Documentation/power/index.rst         |   1 +
 Documentation/power/powercap/dtpm.rst | 212 ++++++++++++
 drivers/powercap/Kconfig              |  13 +
 drivers/powercap/Makefile             |   2 +
 drivers/powercap/dtpm.c               | 473 ++++++++++++++++++++++++++
 drivers/powercap/dtpm_cpu.c           | 257 ++++++++++++++
 include/asm-generic/vmlinux.lds.h     |  11 +
 include/linux/cpuhotplug.h            |   1 +
 include/linux/dtpm.h                  |  77 +++++
 include/linux/units.h                 |   4 +
 10 files changed, 1051 insertions(+)
 create mode 100644 Documentation/power/powercap/dtpm.rst
 create mode 100644 drivers/powercap/dtpm.c
 create mode 100644 drivers/powercap/dtpm_cpu.c
 create mode 100644 include/linux/dtpm.h

Cc: Thara Gopinath <thara.gopinath@linaro.org>
Cc: Lina Iyer <ilina@codeaurora.org>
Cc: Ram Chandrasekar <rkumbako@codeaurora.org>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Lukasz Luba <lukasz.luba@arm.com>

--
2.17.1
