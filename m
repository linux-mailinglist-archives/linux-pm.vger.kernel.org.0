Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0541B7AC1
	for <lists+linux-pm@lfdr.de>; Fri, 24 Apr 2020 17:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbgDXPyI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 Apr 2020 11:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728128AbgDXPyH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 24 Apr 2020 11:54:07 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8550CC09B047
        for <linux-pm@vger.kernel.org>; Fri, 24 Apr 2020 08:54:07 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id e26so11060574wmk.5
        for <linux-pm@vger.kernel.org>; Fri, 24 Apr 2020 08:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ADrifka4jhigxTALfjwTYGfnpgXgMD4+a7Agmx5rILo=;
        b=o/w9qIEsR+jr/v3slfQCnrCxYARzCrPSp9pGgpkQYlXsYkQqTqh5Ji/+MpmCSaLS7v
         qKHbT2sNu/Pb2EjTHUgKbzkC/1MtWLpU3ixdlfcQZKcYuF26dD3heeBoqcTVwGATqcZl
         AcN32liN1kpIyZ+HvwHkiq3cux6jxRru7nZGyTjNy47N8qAtif6IiMo45FWa+L6zjq4m
         XLGqPlzFurqrLGpfGX0krk2zrVOCU5MhoV+9lfTJrk3gaT90QF23dKMEi7JaMBBLi7/W
         yaezqte/sAZIbTiDiu3SA8Iwa4hxtfQd+ZjgfOzOTvVjFliw2MSetKNqqA77YYdqNUk3
         cdkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ADrifka4jhigxTALfjwTYGfnpgXgMD4+a7Agmx5rILo=;
        b=ZAxoCiMpCKtAkOHvMzr/sV3Pp0pX0XuEtJoLuFRoqdXEcQq4J3bNE2Y/yDeZ0eUbt1
         isjAnkcVIGNXicII0ehwup7nW5y/0fm9P9hjDVKrXzAv2nIe64VDsOqFTHignHu9109n
         d3wXW9PI4HtoZ4L64FKzEwoLYx3hEB+AoyqzIUT6p9zSOt86KfUGBimxzSzXV+VwOSoU
         3TWHB6iYqGGeNBaiiZZ01Kt7A4IuIfJXSYTSWVqYkdBcFLAUfsqobN7U3mr+PFw/hecu
         HJ/dqLdao9ZPTLhpJFKSBL9yjObVSRijU8iqFA0vbIHXgAl4iN2x+IHZRe+NcW4QbL7O
         GMnQ==
X-Gm-Message-State: AGi0PuZXxgHHBb/Z6qVXTknojuIvKj9KEBs2EwFWV5Ncp2fLGf9gjOPZ
        Zko1HZU5jlkOw37EqJEEWySDUQ==
X-Google-Smtp-Source: APiQypI10LpqQHNiTVHYn+3Mk1k8a0b6tul7ntLB01e7r3o7yyKMm+eFZUqWmrr9UyT6X72zGWwYhQ==
X-Received: by 2002:a7b:ce09:: with SMTP id m9mr10474294wmc.156.1587743646215;
        Fri, 24 Apr 2020 08:54:06 -0700 (PDT)
Received: from localhost.localdomain ([87.120.218.65])
        by smtp.googlemail.com with ESMTPSA id z76sm3923583wmc.9.2020.04.24.08.54.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Apr 2020 08:54:05 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        robh+dt@kernel.org, rjw@rjwysocki.net, saravanak@google.com,
        sibis@codeaurora.org
Cc:     rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        vincent.guittot@linaro.org, jcrouse@codeaurora.org,
        evgreen@chromium.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        georgi.djakov@linaro.org
Subject: [PATCH v7 0/7] Introduce OPP bandwidth bindings
Date:   Fri, 24 Apr 2020 18:53:57 +0300
Message-Id: <20200424155404.10746-1-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Here is a proposal to extend the OPP bindings with bandwidth based on
a few previous discussions [1] and patchsets from me [2][3] and Saravana
[4][5][6][7][8][9].

Changes in v7:
* This version is combination of both patchsets by Saravana and me, based
on [3] and [9].
* The latest version of DT bindings from Saravana is used here, with a
minor change of using arrays instead of single integers for opp-peak-kBps
and opp-avg-kBps. This is needed to support multiple interconnect paths.
* The concept of having multiple OPP tables per device has been dropped,
as it was nacked by Viresh.
* Various reviews comments have been addressed and some patches are
split, and there are also some new patches. Thanks to Viresh, Sibi and
others for providing feedback!

With this version of the patchset, the CPU/GPU to DDR bandwidth scaling
will look like this in DT:

One interconnect path (no change from Saravana's v6 patches):

cpu@0 {
	operating-points-v2 = <&cpu_opp_table>;
	interconnects = <&noc1 MASTER1 &noc2 SLAVE1>,
};

cpu_opp_table: cpu_opp_table {
	compatible = "operating-points-v2";

	opp-800000000 {
		opp-hz = /bits/ 64 <800000000>;
		opp-peak-kBps = <1525000>;
		opp-avg-kBps = <457000>;
	};

	opp-998400000 {
		opp-hz = /bits/ 64 <998400000>;
		opp-peak-kBps = <7614000>;
		opp-avg-kBps = <2284000>;
	};
};

Two interconnect paths:

cpu@0 {
	operating-points-v2 = <&cpu_opp_table>;
	interconnects = <&noc1 MASTER1 &noc2 SLAVE1>,
			<&noc3 MASTER2 &noc4 SLAVE2>;
};

cpu_opp_table: cpu_opp_table {
	compatible = "operating-points-v2";

	opp-800000000 {
		opp-hz = /bits/ 64 <800000000>;
		opp-peak-kBps = <1525000 2000>;
		opp-avg-kBps = <457000 1000>;
	};

	opp-998400000 {
		opp-hz = /bits/ 64 <998400000>;
		opp-peak-kBps = <7614000 4000>;
		opp-avg-kBps = <2284000 2000>;
	};
};

------

Every functional block on a SoC can contribute to the system power
efficiency by expressing its own bandwidth needs (to memory or other SoC
modules). This will allow the system to save power when high throughput
is not required (and also provide maximum throughput when needed).

There are at least three ways for a device to determine its bandwidth
needs:
	1. The device can dynamically calculate the needed bandwidth
based on some known variable. For example: UART (baud rate), I2C (fast
mode, high-speed mode, etc), USB (specification version, data transfer
type), SDHC (SD standard, clock rate, bus-width), Video Encoder/Decoder
(video format, resolution, frame-rate)

	2. There is a hardware specific value. For example: hardware
specific constant value (e.g. for PRNG) or use-case specific value that
is hard-coded.

	3. Predefined SoC/board specific bandwidth values. For example:
CPU or GPU bandwidth is related to the current core frequency and both
bandwidth and frequency are scaled together.

This patchset is trying to address point 3 above by extending the OPP
bindings to support predefined SoC/board bandwidth values and adds
support in cpufreq-dt to scale the interconnect between the CPU and the
DDR together with frequency and voltage.

[1] https://patchwork.kernel.org/patch/10577315/
[2] https://lore.kernel.org/r/20190313090010.20534-1-georgi.djakov@linaro.org/
[3] https://lore.kernel.org/r/20190423132823.7915-1-georgi.djakov@linaro.org/
[4] https://lore.kernel.org/r/20190608044339.115026-1-saravanak@google.com
[5] https://lore.kernel.org/r/20190614041733.120807-1-saravanak@google.com
[6] https://lore.kernel.org/r/20190703011020.151615-1-saravanak@google.com
[7] https://lore.kernel.org/r/20190726231558.175130-1-saravanak@google.com
[8] https://lore.kernel.org/r/20190807223111.230846-1-saravanak@google.com
[9] https://lore.kernel.org/r/20191207002424.201796-1-saravanak@google.com

Georgi Djakov (5):
  interconnect: Add of_icc_get_by_index() helper function
  OPP: Add support for parsing interconnect bandwidth
  OPP: Add sanity checks in _read_opp_key()
  OPP: Update the bandwidth on OPP frequency changes
  cpufreq: dt: Add support for interconnect bandwidth scaling

Saravana Kannan (2):
  dt-bindings: opp: Introduce opp-peak-kBps and opp-avg-kBps bindings
  OPP: Add helpers for reading the binding properties

 Documentation/devicetree/bindings/opp/opp.txt |  20 ++-
 .../devicetree/bindings/property-units.txt    |   4 +
 drivers/cpufreq/Kconfig                       |   1 +
 drivers/cpufreq/cpufreq-dt.c                  |  15 ++
 drivers/interconnect/core.c                   |  68 +++++--
 drivers/opp/Kconfig                           |   1 +
 drivers/opp/core.c                            |  44 ++++-
 drivers/opp/of.c                              | 170 ++++++++++++++++--
 drivers/opp/opp.h                             |  10 ++
 include/linux/interconnect.h                  |   6 +
 include/linux/pm_opp.h                        |  12 ++
 11 files changed, 311 insertions(+), 40 deletions(-)

