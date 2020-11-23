Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A97442C17D3
	for <lists+linux-pm@lfdr.de>; Mon, 23 Nov 2020 22:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731435AbgKWVmW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Nov 2020 16:42:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727725AbgKWVmV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Nov 2020 16:42:21 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A22C061A4D
        for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2020 13:42:19 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id r3so1973467wrt.2
        for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2020 13:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FURT5aJ8Y84zCkcTMva4r1vaAztUoaAN182A6565glQ=;
        b=MTjtpKkU+YwmI1AycB693SeABSqeeKRW43pQSRko+D52FGBzBj5GQA495bL1s7YX7x
         K7eV7Ygp9x4KCPPuAIVfUQvIl+fXsghVLEzy1EQeEKmxP3eomyN17NrC9gLwGRij8uVY
         H64YyeDSPxfCk8JmoKDvdNQEhJmh78Fwy0FbjA/wOzfhlcoykJO70sDBeeVqO1GrImd0
         SXwohJ8duggSGepknmCxaVz/FYtI95mRECmdmwIjfW7NRiFqpVEEA+y5X9QHXppiHu2S
         04XMKUNZrxqc8MTl4PdO5tjAEobMUeKR9zaH4rNmJDi5TVJVpXmato9o3mqoVrncyaXd
         J9gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FURT5aJ8Y84zCkcTMva4r1vaAztUoaAN182A6565glQ=;
        b=lJ3y7T7/m6MqqT2FVKIJlTzSs6eqAa3eC4I9W6/RksMTH6v4puarfk9FUepoGbQ0i8
         japnNlpmB1l+tyaSz51QDfiJ3hw6Qv1aIJZW90hggCmAaXUyJ3JGtXIx1t8xatsQLSRn
         v6+Yx8p52T4keBFr3viwjyCH2PNUtW/ZKCHDXI0wwHjnu4yUKOFoAe6aHxVxSickOTIX
         JkqHYE1NpxHWdT5DBOYYP3QJQfgRNTPsF1X40nLWWsxvih1J2AJR70LBiHsK6ps1trU7
         hzvRdY20+Vdy12iTZ0e29qI6QEAaNK7Jb9lrPFj1FiTCSoNEUhiwgPYaQW1nxUOh4UsR
         C5OQ==
X-Gm-Message-State: AOAM530OEQKv2Rzb39xpVonBw/37Z2BOD4OTSrLHLXcTnzHhPhZmQ2t6
        lQCIf4OQ34CfNbqAS3C4aiX9/A==
X-Google-Smtp-Source: ABdhPJwqDNGVlTIdxmQ5yPFhXOgcm4zJ3MQNR1aBInJ/WQxwwPe2t5EPF1kQSngaK8GWo6pSSSX2Lw==
X-Received: by 2002:a5d:4084:: with SMTP id o4mr1665471wrp.278.1606167738095;
        Mon, 23 Nov 2020 13:42:18 -0800 (PST)
Received: from localhost.localdomain (lns-bzn-59-82-252-157-164.adsl.proxad.net. [82.252.157.164])
        by smtp.gmail.com with ESMTPSA id 35sm22400598wro.71.2020.11.23.13.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 13:42:17 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rjw@rjwysocki.net
Cc:     daniel.lezcano@linaro.org, corbet@lwn.net, ulf.hansson@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ilina@codeaurora.org, lukasz.luba@arm.com, rkumbako@codeaurora.org,
        rui.zhang@intel.com, linux-arm-kernel@lists.infradead.org
Subject: [PATCH V2 0/4] powercap/dtpm: Add the DTPM framework
Date:   Mon, 23 Nov 2020 22:42:04 +0100
Message-Id: <20201123214208.11007-1-daniel.lezcano@linaro.org>
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
 Documentation/power/powercap/dtpm.rst | 210 ++++++++++++
 drivers/powercap/Kconfig              |  13 +
 drivers/powercap/Makefile             |   2 +
 drivers/powercap/dtpm.c               | 441 ++++++++++++++++++++++++++
 drivers/powercap/dtpm_cpu.c           | 252 +++++++++++++++
 include/asm-generic/vmlinux.lds.h     |  11 +
 include/linux/cpuhotplug.h            |   1 +
 include/linux/dtpm.h                  |  78 +++++
 include/linux/units.h                 |   4 +
 10 files changed, 1013 insertions(+)
 create mode 100644 Documentation/power/powercap/dtpm.rst
 create mode 100644 drivers/powercap/dtpm.c
 create mode 100644 drivers/powercap/dtpm_cpu.c
 create mode 100644 include/linux/dtpm.h

--
2.17.1
