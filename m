Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF07D11B3B0
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2019 16:44:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388265AbfLKPoD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Dec 2019 10:44:03 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37087 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388678AbfLKPnx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Dec 2019 10:43:53 -0500
Received: by mail-lf1-f66.google.com with SMTP id b15so17063498lfc.4
        for <linux-pm@vger.kernel.org>; Wed, 11 Dec 2019 07:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=QezpLoEmLm+pWssoQww7VDpy8yHjq0vuBcOFSjXa5GE=;
        b=P8O5lEVpe+ZO3x1D0AMi3L5afQw+fv5PZ6YUxcJBFCYq4SO3Q6S7ti8rr+zHrJvJ1q
         Sl3evW7V2s3EvpGsOvz1ZkV2MR7/k8607+xpR0ufo1Bs2yR4gYTd4nhPbtJ0nRbPahiy
         e6eoQynMs3JidBalYwxrDP8JjjzH7iY4tSG7o4DGPdqNQXtT15aCizsyoUc13nUFtEkA
         4t6ihL9CUjk03IBL5J9BBw9x5ai/uGRRpDQXVG9q/IoFfOU50BhrZ6viK+cu2QoYn+On
         iUfO/DmkQjdkPeF2LDReFCiIznyV3djwRi8DxddIyczo5drNeT5tU0UNtVl2Mjpr/BFa
         5y7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QezpLoEmLm+pWssoQww7VDpy8yHjq0vuBcOFSjXa5GE=;
        b=g0YVtZpbXMzQfUuaA1U3bD6pGAZE2+FXpPi1dEZecf4/uvjR2kHeZa3n4pf4cTRSgt
         TWteKHdAgIXcdpCns/ekYMvoGlODoyErdMXep+YENHy/zHI4qaEij8pfQXZDzZHxMLDB
         AYTT2gip3NSAhn8jpzlKzyhzn1j73FG0KfUY6elGi1YyeYZn9CLYOtzWxHznSwX9rwwZ
         7J3cQ7t9rT3S1i8+xIvNSFT2FMeTdb+bV1agkCBKC4/MEiUsA9hTDpyM8B68kvGMUHpT
         WXb1R7Unsy9q3lwZ4jhPo77GylSv58l+BoGTI0k/VcaoNpegFMuxTOmktM7ozFsTZfTD
         4ZWg==
X-Gm-Message-State: APjAAAW1drfp2/ZxW0jO6RRqdDq+LgQSKNrGpwLlSHejr85vbrN3QUdt
        vxFZSJajYEjYxAJtiaqG1Bj2aA==
X-Google-Smtp-Source: APXvYqw2OODZNzrYtdX2PqTZvRKg+ydXv1DAdVmcIzLeDqTTiGCyNqpsrjIdToasKLYVFPqVfMmnsg==
X-Received: by 2002:ac2:498e:: with SMTP id f14mr2615140lfl.172.1576079030830;
        Wed, 11 Dec 2019 07:43:50 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id b14sm1389608lff.68.2019.12.11.07.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 07:43:50 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lina Iyer <ilina@codeaurora.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v4 00/14] cpuidle: psci: Support hierarchical CPU arrangement
Date:   Wed, 11 Dec 2019 16:43:29 +0100
Message-Id: <20191211154343.29765-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Changes in v4:
	- Mover the check for OSI support from psci_dt_attach_cpu() to the
	caller's side of it.
	- Add comment in the code about using the deepest idle state as the
	triggering point for the domain state selection.
	- Folded in a patch to enable support for CPU hotplug.

Changes in v3:
	- Take one step further to completely avoid executing any OSI specific
	code from the ->enter() callback, while operating in the default PSCI
	Platform Coordinated mode.
	- Update example for the PSCI DT bindings to make it compile with
	"make dt_binding_check"

Changes in v2:
	- Avoid to affect the non-OSI path with specific changes for OSI. This
	forced me to re-order the series and a caused more or less minor changes
	to most of the patches.
	- Updated the DT bindings for PSCI to clarify and to include the "psci"
	name of the PM domain to attach to.
	- Replaced patch1 with another patch from Sudeep, solving the same
	problem, but in a different way.

This series enables initial support for hierarchical CPU arrangement, managed
by PSCI and its corresponding cpuidle driver. It's based on using the generic
PM domain (genpd), which nowadays also supports devices belonging to CPUs.

The last DTS patch enables the hierarchical topology to be used for the Qcom
410c Dragonboard, which supports the PSCI OS-initiated mode.

More detailed background can be found from previous submissions [1].

The series is also available at:
git.linaro.org/people/ulf.hansson/linux-pm.git next

Kind regards
Ulf Hansson

[1]
https://lwn.net/Articles/788306/


Lina Iyer (1):
  cpuidle: dt: Support hierarchical CPU idle states

Sudeep Holla (1):
  cpuidle: psci: Align psci_power_state count with idle state count

Ulf Hansson (12):
  dt: psci: Update DT bindings to support hierarchical PSCI states
  firmware: psci: Export functions to manage the OSI mode
  of: base: Add of_get_cpu_state_node() to get idle states for a CPU
    node
  cpuidle: psci: Simplify OF parsing of CPU idle state nodes
  cpuidle: psci: Support hierarchical CPU idle states
  cpuidle: psci: Add a helper to attach a CPU to its PM domain
  cpuidle: psci: Attach CPU devices to their PM domains
  cpuidle: psci: Prepare to use OS initiated suspend mode via PM domains
  cpuidle: psci: Manage runtime PM in the idle path
  cpuidle: psci: Support CPU hotplug for the hierarchical model
  cpuidle: psci: Add support for PM domains by using genpd
  arm64: dts: Convert to the hierarchical CPU topology layout for
    MSM8916

 .../devicetree/bindings/arm/cpus.yaml         |  15 +
 .../devicetree/bindings/arm/psci.yaml         | 104 ++++++
 arch/arm64/boot/dts/qcom/msm8916.dtsi         |  57 +++-
 drivers/cpuidle/Makefile                      |   4 +-
 drivers/cpuidle/cpuidle-psci-domain.c         | 298 ++++++++++++++++++
 drivers/cpuidle/cpuidle-psci.c                | 161 ++++++++--
 drivers/cpuidle/cpuidle-psci.h                |  17 +
 drivers/cpuidle/dt_idle_states.c              |   5 +-
 drivers/firmware/psci/psci.c                  |  18 +-
 drivers/of/base.c                             |  36 +++
 include/linux/cpuhotplug.h                    |   1 +
 include/linux/of.h                            |   8 +
 include/linux/psci.h                          |   2 +
 13 files changed, 691 insertions(+), 35 deletions(-)
 create mode 100644 drivers/cpuidle/cpuidle-psci-domain.c
 create mode 100644 drivers/cpuidle/cpuidle-psci.h

-- 
2.17.1

