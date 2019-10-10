Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68963D2817
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2019 13:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbfJJLkI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Oct 2019 07:40:08 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35229 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbfJJLkI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Oct 2019 07:40:08 -0400
Received: by mail-lj1-f195.google.com with SMTP id m7so5871336lji.2
        for <linux-pm@vger.kernel.org>; Thu, 10 Oct 2019 04:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=2IJCjxfMEpSRJkS++DhjtARW+QNPbTjOBtr+8H3u40A=;
        b=uYRdsI8te0eaDiHtkdh5R/+OqlHAVSLkJADtZJTeFydF4Y47RT8kzwre6xDI4j34zl
         5HdWus2lQAcfjCbqzA71PLvMUI4AYSLWiGgnnZqbibnE62hQ8JnUzXgn/rNxo6+zo6iw
         jH/WkAqyIFtaq1HQNOxSYIrHxWjmHDKbl+WLr/QN7nMcYTJy2KeLDkee8hDbdKsI2c5j
         a2tnpwEyTOk3T7hb9nG8eEJ3MnvNNy1cPuO5XbOWSoEggnlYpeVSWElDz5deVQphhAyR
         8AyvY9N8sSWnidCRIVsMkEy+ojIPLYkB3CvUJJXGtHXVFQk9gOpakS3USZiLR4i9KtsC
         5vFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2IJCjxfMEpSRJkS++DhjtARW+QNPbTjOBtr+8H3u40A=;
        b=gY7S2zglTBL8kWIWg6JDMKJkqVR3G4o8i0efUHXhxh5dfUmHYpTUwY+tocIGs8Fur1
         uNuzkZMLEwR1OWrJEbpXKy9EDBmYf4BGHF84PBWQCuZvGjVIv+0iKOZ9jQ8pYdpIGmxu
         Y5oEZkyVdylZ2C0FKEuE0rXsbC5Q3W9zE5HgUe3Lkymtybh0ZkUG/C5O01O7a3oL5pxR
         QDUsc6xPMBggcyzvYZ2mOL5J0q0HbX09PtiB71c79BiyIBdDIX4cC2ZgzGWAGuQrLVkO
         UnHS7vXFMjtKbFAx9nus5goGM3dRi9vYlWf3uOg30dGweEG4RFQOmLwqsRG7IKKe6liC
         6Nfw==
X-Gm-Message-State: APjAAAVJ3xaN6qskOCNZYC+As2OWdAlAnmWX5Fo8eWlNRQ6pIAIAWAOG
        ymrnp9jMYtxvUfk0YEqyZNzw7A==
X-Google-Smtp-Source: APXvYqyHTS+mn7MuuwFxGUfhX8Q5zKTf6UWlXj64K9gUalKuMXGaZnYWVktevenm33lDHwfKhHe5vg==
X-Received: by 2002:a2e:2bc8:: with SMTP id r69mr6210726ljr.147.1570707604133;
        Thu, 10 Oct 2019 04:40:04 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id p3sm1168937ljn.78.2019.10.10.04.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 04:40:03 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lina Iyer <ilina@codeaurora.org>, linux-pm@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH 00/13] cpuidle: psci: Support hierarchical CPU arrangement
Date:   Thu, 10 Oct 2019 13:39:24 +0200
Message-Id: <20191010113937.15962-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This series enables initial support for hierarchical CPU arrangement, managed
by PSCI and its corresponding cpuidle driver. It's based on using the generic
PM domain (genpd), which nowadays also supports devices belonging to CPUs.

The last DTS patch enables the hierarchical topology to be used for the Qcom
410c Dragonboard, which supports the PSCI OS-initiated mode.

Do note, most of the code in this series have been posted earlier, but from the
latest version being reviewed, we agreed on that it was better to re-work the
PSCI backend driver as a first step, simply to get a clean interface towards the
cpuidle driver.

Summary of the main-changes since the last submission [1]:

 - Moved implementation from the psci FW dricer into cpuidle-psci.

 - Re-requesting review of the DT bindings, as we have moved to yaml. No
   changes as such, but tried to clarify a few things in the text.

 - Drop the patch enabling support for CPU hotplug, postponing that to the next
   step.

 - Respect the hierarchical topology in DT only when OSI mode is supported.
   This is to start simple and we can always extend the support on top.

The series is also available at:
git.linaro.org/people/ulf.hansson/linux-pm.git next

Kind regards
Ulf Hansson

[1]
https://lwn.net/Articles/788306/


Lina Iyer (1):
  cpuidle: dt: Support hierarchical CPU idle states

Ulf Hansson (12):
  cpuidle: psci: Fix potential access to unmapped memory
  dt: psci: Update DT bindings to support hierarchical PSCI states
  firmware: psci: Export functions to manage the OSI mode
  of: base: Add of_get_cpu_state_node() to get idle states for a CPU
    node
  cpuidle: psci: Simplify OF parsing of CPU idle state nodes
  cpuidle: psci: Support hierarchical CPU idle states
  cpuidle: psci: Prepare to use OS initiated suspend mode via PM domains
  cpuidle: psci: Add support for PM domains by using genpd
  cpuidle: psci: Add a helper to attach a CPU to its PM domain
  cpuidle: psci: Attach CPU devices to their PM domains
  cpuidle: psci: Manage runtime PM in the idle path
  arm64: dts: Convert to the hierarchical CPU topology layout for
    MSM8916

 .../devicetree/bindings/arm/psci.yaml         | 153 +++++++++
 arch/arm64/boot/dts/qcom/msm8916.dtsi         |  57 +++-
 drivers/cpuidle/Makefile                      |   4 +-
 drivers/cpuidle/cpuidle-psci-domain.c         | 302 ++++++++++++++++++
 drivers/cpuidle/cpuidle-psci.c                | 106 ++++--
 drivers/cpuidle/cpuidle-psci.h                |  17 +
 drivers/cpuidle/dt_idle_states.c              |   5 +-
 drivers/firmware/psci/psci.c                  |  18 +-
 drivers/of/base.c                             |  36 +++
 include/linux/of.h                            |   8 +
 include/linux/psci.h                          |   2 +
 11 files changed, 673 insertions(+), 35 deletions(-)
 create mode 100644 drivers/cpuidle/cpuidle-psci-domain.c
 create mode 100644 drivers/cpuidle/cpuidle-psci.h

-- 
2.17.1

