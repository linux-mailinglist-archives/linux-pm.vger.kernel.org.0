Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD5BD2CAC55
	for <lists+linux-pm@lfdr.de>; Tue,  1 Dec 2020 20:31:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404298AbgLAT3Q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Dec 2020 14:29:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731332AbgLAT3P (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Dec 2020 14:29:15 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A20E1C0613D6
        for <linux-pm@vger.kernel.org>; Tue,  1 Dec 2020 11:28:29 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id e7so4493451wrv.6
        for <linux-pm@vger.kernel.org>; Tue, 01 Dec 2020 11:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j6p+YMiEvGfgWgVK/fiYx7nOD3W8UrG8hGOfhdHXGiI=;
        b=YcO+UAwgPbAZUN9l6ANWKfXf98JG2Unun5RS1Y1ijBw05/ZQ0B+FBs3I26GMRDH5jA
         xoR04H00/HPRZY9tMCVACgJqYELvtu0BpNNRqmVN1/eEIybMleBoI1+BLum2p0yTW2jF
         H9rV+GQ9YQHq35Z33iiuj++jqMJgNF8/eCtwLcmVA4NVQ3kNVyC64+aRoFd6pB7bMQDV
         u++Qfx3A4J0hErdb3ZP4Sg2evRREnuLyHsdYhCjOxUzAhhdy/A/KIkfgMjuTYLKKnTl0
         xABlPjbaXxY202bS9jodew5KTOC0RujrnzEmtrkLm0ycYVxThqsCBGeq2XlaLuju+YKI
         qPJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j6p+YMiEvGfgWgVK/fiYx7nOD3W8UrG8hGOfhdHXGiI=;
        b=XES+B2lFe4ZLu2dovKbcW4JTh4yxgUfdOn4FkJg8wGaSA0r+QEvWMj7jqbmWH3Ppdp
         t5UJQUq7QdlCH8xkSrsKMroX7TvjIvhtgdm2eq0Onodo4eLd30GD0ZESmNcHufV14SA5
         EoKAUbBW7pgAX/UCerzswwAuz8tEjKSY2pAdiHKgrLY46rce8mYQVxzHojhtNfgcEGeX
         kJneh3pvZC59KIopGvhDxQ4CdcAjqkLyXAdihEaZ1tWJLOjLiCWor7pFujm20X5nCI8C
         QjyAnwx2M3+1uL1qlXJ0MEVzyd3pBImy3yC5EX1Sbq4pVYnGb7b2Dh4jP1QrGMNNlEkP
         HULg==
X-Gm-Message-State: AOAM5319PW/UKF9bZCdR7ybQ3KQSVWvloN3K3onrmnHnpIUvhZ1ErSYE
        GvRw7kTf6RL6+hCEdK2iohPFOw==
X-Google-Smtp-Source: ABdhPJzQPqbaCP9NKer6xelrMlYEebBk9sgU1X6QkLDnLZwWnBamWc5zPvRBU1s1vyc/lTdiY5Pwow==
X-Received: by 2002:a5d:5107:: with SMTP id s7mr6035081wrt.148.1606850908207;
        Tue, 01 Dec 2020 11:28:28 -0800 (PST)
Received: from localhost.localdomain (lns-bzn-59-82-252-140-184.adsl.proxad.net. [82.252.140.184])
        by smtp.gmail.com with ESMTPSA id n123sm1317922wmn.7.2020.12.01.11.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 11:28:27 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rjw@rjwysocki.net
Cc:     ulf.hansson@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org,
        lukasz.luba@arm.com, Thara Gopinath <thara.gopinath@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Ram Chandrasekar <rkumbako@codeaurora.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH V4 0/4] powercap/dtpm: Add the DTPM framework
Date:   Tue,  1 Dec 2020 20:27:57 +0100
Message-Id: <20201201192801.27607-1-daniel.lezcano@linaro.org>
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
 Documentation/power/powercap/dtpm.rst | 210 ++++++++++++
 drivers/powercap/Kconfig              |  13 +
 drivers/powercap/Makefile             |   2 +
 drivers/powercap/dtpm.c               | 470 ++++++++++++++++++++++++++
 drivers/powercap/dtpm_cpu.c           | 257 ++++++++++++++
 include/asm-generic/vmlinux.lds.h     |  11 +
 include/linux/cpuhotplug.h            |   1 +
 include/linux/dtpm.h                  |  77 +++++
 include/linux/units.h                 |   4 +
 10 files changed, 1046 insertions(+)
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
