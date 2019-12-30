Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D42E12D0ED
	for <lists+linux-pm@lfdr.de>; Mon, 30 Dec 2019 15:44:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbfL3OoL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Dec 2019 09:44:11 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42256 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727445AbfL3OoL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Dec 2019 09:44:11 -0500
Received: by mail-lf1-f68.google.com with SMTP id y19so25247439lfl.9
        for <linux-pm@vger.kernel.org>; Mon, 30 Dec 2019 06:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=sFfjg/yNHvgMOq/dY0SQeqxIZJHWCbLuEKyo3araOLs=;
        b=NP/bXJFLt86IBRjeVMel3EBAEvK8F7rBxQbMHOohl4CF2QNfY9trFGs+OHOfSomsVD
         tLeLIs8K3KwGEDz9U/J51c6YOE4ZzyNB2l72m/Lr/Jh3NQx591Q2w+1yXvAsRlLdZjnl
         5QXW17WOv65zyS/p8YBEVHpjlPuvKRrHn7p3KfGlgGVBth9MPppuf35rsX4oZcwU5UKP
         Mi1MImgE0NmiNE3eBREBzc+u9lB1OrsjhTDw0RGHMDK3BqGMZlW8dkg1HcygZxDr+o7V
         Nr9PFC4MivKEkhX6ZlcQwQSykROcCnzGVRAgj7mguDzbuk9pLT2GSMWjQ3HvDPzEE/3Y
         YPWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sFfjg/yNHvgMOq/dY0SQeqxIZJHWCbLuEKyo3araOLs=;
        b=mCxR6A0z2AmQStpm8l9hgiQkMXnft5AzVZ13RcHlOhUBD3rPvyk0LvZgUFcAtlV/6V
         FXmwAAPn3he2JCK5w9NSV6KH/jvPkhXHN5lSVOqREEdkZlS5LE0i/HZyLpV19qhIFjkf
         4gqAZnfs3gMMAeg66bYO/375ko/3fBn584FwTnGhP0V5KH2gIywhgpggbeiRzgZIdV3Y
         KcDTiyP9VgfyDBb9dRRY1rii/DYIPkZZnWArjbAl5i4jfvNgJyub5AnCpFKoaTRQN+sm
         Wo0Lnve+P2hwLNAsBgLGKbBTIdlGIJH3IRRbQ15MD+L4nkOcS4HdcLqxDdLQem8R1+1X
         GUhw==
X-Gm-Message-State: APjAAAWwZXcCRUzxcRkOjyp7wYKxrYz1viyERWTLOTk9mWN4vmUK7YAK
        0sgIx3dJ2R7UWakbN/4d9GKyjQ==
X-Google-Smtp-Source: APXvYqy4XidAIjxpwoiaO8eMYG36haXaoFRqDnDjYaeZWAaq8806N3mNSYv74D0HNG8dhm1F6TD5NQ==
X-Received: by 2002:a19:48c5:: with SMTP id v188mr38314593lfa.100.1577717048501;
        Mon, 30 Dec 2019 06:44:08 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id a21sm18744931lfg.44.2019.12.30.06.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2019 06:44:07 -0800 (PST)
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
Subject: [PATCH v5 00/15] cpuidle: psci: Support hierarchical CPU arrangement
Date:   Mon, 30 Dec 2019 15:43:47 +0100
Message-Id: <20191230144402.30195-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Changes in v5:
	- Remove PM domains in the error path, when failing to enable OSI.
	- Folded in a patch that adds a genpd OF helper to remove subdomains.
	- Added reviewed-by tags.

Changes in v4:
	- Move the check for OSI support from psci_dt_attach_cpu() to the
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

Ulf Hansson (13):
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
  PM / Domains: Introduce a genpd OF helper that removes a subdomain
  cpuidle: psci: Add support for PM domains by using genpd
  arm64: dts: Convert to the hierarchical CPU topology layout for
    MSM8916

 .../devicetree/bindings/arm/cpus.yaml         |  15 +
 .../devicetree/bindings/arm/psci.yaml         | 104 ++++++
 arch/arm64/boot/dts/qcom/msm8916.dtsi         |  57 +++-
 drivers/base/power/domain.c                   |  38 +++
 drivers/cpuidle/Makefile                      |   4 +-
 drivers/cpuidle/cpuidle-psci-domain.c         | 308 ++++++++++++++++++
 drivers/cpuidle/cpuidle-psci.c                | 161 +++++++--
 drivers/cpuidle/cpuidle-psci.h                |  17 +
 drivers/cpuidle/dt_idle_states.c              |   5 +-
 drivers/firmware/psci/psci.c                  |  18 +-
 drivers/of/base.c                             |  36 ++
 include/linux/cpuhotplug.h                    |   1 +
 include/linux/of.h                            |   8 +
 include/linux/pm_domain.h                     |   8 +
 include/linux/psci.h                          |   2 +
 15 files changed, 747 insertions(+), 35 deletions(-)
 create mode 100644 drivers/cpuidle/cpuidle-psci-domain.c
 create mode 100644 drivers/cpuidle/cpuidle-psci.h

-- 
2.17.1

