Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 820D310AD96
	for <lists+linux-pm@lfdr.de>; Wed, 27 Nov 2019 11:29:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbfK0K3V (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Nov 2019 05:29:21 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44033 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727085AbfK0K3T (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Nov 2019 05:29:19 -0500
Received: by mail-lf1-f68.google.com with SMTP id v201so15659269lfa.11
        for <linux-pm@vger.kernel.org>; Wed, 27 Nov 2019 02:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ix8gklYmB6UDNV/QC3c+tosxDnV18E4E+uiNnO6VScw=;
        b=WjmA9qLe/NecRbZ3fzetc0/1Nm2xYFXmf6V+NnuxS9t/I35sAGxJE5N2A/3ajU1how
         1tmTUhAQ8BZ2SL12A5B+pD1I7QQAgUKS/3lecivVvUrmS42uKZQOvokBmcaKA6fXiyhz
         71cGRHIkFcMNWPhnwTGyeJYz4qUUjDM9W9cgT8Gg6qRWI55mgOTpkJnwhsNeutE+NNbB
         Chcr7Pe9cW7ZF1uEAQMpz7qMtS/jK0OTWPq+BR3+MPTnPSq6HQyxyAAGny6hl2799QzJ
         /ipHdBqyNwQcDJ7CHr5feCfwYuQqGZkZS05veAwKx65zFqrQVAW1uiXiV8e2CU11dm2s
         wiSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ix8gklYmB6UDNV/QC3c+tosxDnV18E4E+uiNnO6VScw=;
        b=FHHljdAjiuMvsS+bjsTZCNtHM77QyUJQut5nxd7XDR4D/s2CQrxPA80Q5Fkkox9IbV
         cEwgGGyVNBPyxZNZx5lDfAkY2Fb9Ys8ak5ZdXKMx+T0RCJDORnJuoxy02onMSWKhRyiQ
         rmHEZeBbHerNKW2C+OVeqVdz+MDV7AMOX3JIeEGru15QCI294+xSY9AbKMJ+x1nNrT6i
         s02par5idLYlP4U9pwHqd7SnIX1C46dE016dMKhJ+UAU4CbPhTBRwySpjKarSS9031go
         8OmIz4rppw7VSfxhjP9Me4jwnj+O6/qlLhAqdHzPA8aEj6I8XeuRth3sfRtTJmXWpyFA
         Ukkg==
X-Gm-Message-State: APjAAAXUMDcnuu0rA/pVNZL/2TFlHN/vGTMxPU17XDHdIXU63zAGMtHI
        XtDM2spZeV+GWmIWCntCvS6AJA==
X-Google-Smtp-Source: APXvYqzwxSjoX0WePnCcqKWVwhIrIupw9nuRgrbFXnTzGgsvQBmMgqmcnl+RS0sDa/QqD5iVi1qHMA==
X-Received: by 2002:ac2:4312:: with SMTP id l18mr28284015lfh.38.1574850557532;
        Wed, 27 Nov 2019 02:29:17 -0800 (PST)
Received: from uffe-XPS-13-9360.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id t9sm6868260ljj.19.2019.11.27.02.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 02:29:16 -0800 (PST)
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
Subject: [PATCH v3 00/13] cpuidle: psci: Support hierarchical CPU arrangement
Date:   Wed, 27 Nov 2019 11:29:01 +0100
Message-Id: <20191127102914.18729-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Rob, Lorenzo, Sudeep - apologize for sending a new version in the middle of the
merge window, but I thought I might as well get this out, especially since
there are only a very small amount of updates. Please review, whenever you find
some time for it.

Kind regards
Ulf Hansson

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

Ulf Hansson (11):
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
  cpuidle: psci: Add support for PM domains by using genpd
  arm64: dts: Convert to the hierarchical CPU topology layout for
    MSM8916

 .../devicetree/bindings/arm/cpus.yaml         |  15 +
 .../devicetree/bindings/arm/psci.yaml         | 104 ++++++
 arch/arm64/boot/dts/qcom/msm8916.dtsi         |  57 +++-
 drivers/cpuidle/Makefile                      |   4 +-
 drivers/cpuidle/cpuidle-psci-domain.c         | 302 ++++++++++++++++++
 drivers/cpuidle/cpuidle-psci.c                | 114 +++++--
 drivers/cpuidle/cpuidle-psci.h                |  17 +
 drivers/cpuidle/dt_idle_states.c              |   5 +-
 drivers/firmware/psci/psci.c                  |  18 +-
 drivers/of/base.c                             |  36 +++
 include/linux/of.h                            |   8 +
 include/linux/psci.h                          |   2 +
 12 files changed, 647 insertions(+), 35 deletions(-)
 create mode 100644 drivers/cpuidle/cpuidle-psci-domain.c
 create mode 100644 drivers/cpuidle/cpuidle-psci.h

-- 
2.17.1

