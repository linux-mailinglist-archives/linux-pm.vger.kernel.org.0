Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08D2139B0A
	for <lists+linux-pm@lfdr.de>; Sat,  8 Jun 2019 06:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbfFHEnr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 8 Jun 2019 00:43:47 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:34039 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbfFHEnr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 8 Jun 2019 00:43:47 -0400
Received: by mail-pg1-f201.google.com with SMTP id y187so2753165pgd.1
        for <linux-pm@vger.kernel.org>; Fri, 07 Jun 2019 21:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=eH9fapKAJwolfX12q6qFY4CZH/Ll8SfSGTB5TLEBq1E=;
        b=TX6ck3Thsys8vR8ZnG1NNJCOVjJ6bQCRPH90VpAfp3KSB9AM3aULyOkDl1EaWkOqTc
         QnZEbSTY6tAGFzAFAYSfTN6CG8R3HvYBoZIp4Q3E2rWu76kB5PcUymL/8IiqmL7a5hNH
         TABCU/hgYQ8tE5NznIF4720eqTUGU/V/JVWCa5Xkw0+BJ8TcnkcV0GmJtz927Nvw49bj
         CCGvogxwcWjs+fmmXurVko5beuFSo3oCafhssGZ0GIWS3isVoOpHSYmhs9xaalC7BlI/
         ZmiFk7dQ8OQoV1MXMWSPc9Z8n0Jw+tLV0peVQgqX67FUCxfkwSinP5mqGuTq6psfvF2G
         /swg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=eH9fapKAJwolfX12q6qFY4CZH/Ll8SfSGTB5TLEBq1E=;
        b=OO3PFUImZLERUh55AN3lxiOAOZH7JxzAOLBfkCCoaJ0uRVTknecg3nsFglxIEmPbmJ
         RpyWb/aFoZqxJFT7FpMXBKafnT04ZdooH55hcwA6OINkVu8FQv1+SlAVo+KtWkd4dwV1
         KZDMqYqvOk7r7UbnAizur72lN5KmJbb8uu0Q7aioyShKeMmtrbjWsxT/tj8S+Y23AzIZ
         ls2f8m52mF/k7LdCD9TuBqutmyZlZosJeuLepAGak1j/JXoGLptQopb4pIBnOaCoofXk
         6SXFoDsQChX6iVI1m2i6I4pITW7CUWG5L4sY2wlx22vIh7HrBUt7FocRfbaC0au7hfu3
         CXEA==
X-Gm-Message-State: APjAAAUBIxT2vr+CWItVn7gtdRBKH3bVG0anOvIB48a1Qqyy+7qAKL3+
        knk8XfB4tX7oc2+BWr0fxuW35X6Ne3SYl5A=
X-Google-Smtp-Source: APXvYqzyuMJ13rtRIBQUEAtXcZjmhvphMToX8lIX0cyimVKucuf4Er3USxwQ5OENVm49MxHrQ6wgw16jkUJt7cE=
X-Received: by 2002:a63:2224:: with SMTP id i36mr6114353pgi.70.1559969025896;
 Fri, 07 Jun 2019 21:43:45 -0700 (PDT)
Date:   Fri,  7 Jun 2019 21:43:30 -0700
Message-Id: <20190608044339.115026-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
Subject: [PATCH v1 0/9] Introduce Bandwidth OPPs & interconnect devfreq driver
From:   Saravana Kannan <saravanak@google.com>
To:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Saravana Kannan <saravanak@google.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        vincent.guittot@linaro.org, bjorn.andersson@linaro.org,
        amit.kucheria@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, evgreen@chromium.org,
        sibis@codeaurora.org, kernel-team@android.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

I replied[1] to this patch series[2] and described how I think interconnect
bandwidth voting should be captured in DT and how it should work.

So sending out a patch series implementing that. This patch series does the
following:
- Adds Bandwidth OPP table support (this adds device freq to bandwidth
  mapping for free)
- Adds a devfreq library for interconnect paths

Interconnects and interconnect paths quantify they performance levels in
terms of bandwidth. So similar to how we have frequency based OPP tables
in DT and in the OPP framework, this patch series adds bandwidth OPP
table support in the OPP framework and in DT.

To simplify voting for interconnects, this patch series adds helper
functions to create devfreq devices out of interconnect paths. This
allows drivers to add a single line of code to add interconnect voting
capability.

To add devfreq device for the "gpu-mem" interconnect path:
icc_create_devfreq(dev, "gpu-mem");

With the future addition of a "passive_bandwidth" devfreq governor,
device frequency to interconnect bandwidth mapping would come for free.

If the feedback on this patch series is positive, I'll then add the
devfreq passive_bandwidth governor (or something similar) to v2 of this
patch series.

So with the DT bindings added in this patch series, the DT for a GPU
that does bandwidth voting from GPU to Cache and GPU to DDR would look
something like this:

gpu_cache_opp_table: gpu_cache_opp_table {
	compatible = "operating-points-v2";

	gpu_cache_3000: opp-3000 {
		opp-peak-KBps = <3000>;
		opp-avg-KBps = <1000>;
	};
	gpu_cache_6000: opp-6000 {
		opp-peak-KBps = <6000>;
		opp-avg-KBps = <2000>;
	};
	gpu_cache_9000: opp-9000 {
		opp-peak-KBps = <9000>;
		opp-avg-KBps = <9000>;
	};
};

gpu_ddr_opp_table: gpu_ddr_opp_table {
	compatible = "operating-points-v2";

	gpu_ddr_1525: opp-1525 {
		opp-peak-KBps = <1525>;
		opp-avg-KBps = <452>;
	};
	gpu_ddr_3051: opp-3051 {
		opp-peak-KBps = <3051>;
		opp-avg-KBps = <915>;
	};
	gpu_ddr_7500: opp-7500 {
		opp-peak-KBps = <7500>;
		opp-avg-KBps = <3000>;
	};
};

gpu_opp_table: gpu_opp_table {
	compatible = "operating-points-v2";
	opp-shared;

	opp-200000000 {
		opp-hz = /bits/ 64 <200000000>;
		required-opps = <&gpu_cache_3000>, <&gpu_ddr_1525>;
	};
	opp-400000000 {
		opp-hz = /bits/ 64 <400000000>;
		required-opps = <&gpu_cache_6000>, <&gpu_ddr_3051>;
	};
};

gpu@7864000 {
	...
	operating-points-v2 = <&gpu_opp_table>, <&gpu_cache_opp_table>, <&gpu_ddr_opp_table>;
	interconnects = <&mmnoc MASTER_GPU_1 &bimc SLAVE_SYSTEL_CACHE>,
			<&mmnoc MASTER_GPU_1 &bimc SLAVE_DDR>;
	interconnect-names = "gpu-cache", "gpu-mem";
	interconnect-opp-table = <&gpu_cache_opp_table>, <&gpu_ddr_opp_table>
};

Cheers,
Saravana

[1] - https://lore.kernel.org/lkml/20190601021228.210574-1-saravanak@google.com/
[2] - https://lore.kernel.org/lkml/20190423132823.7915-1-georgi.djakov@linaro.org/ 

Saravana Kannan (9):
  dt-bindings: opp: Introduce opp-peak-KBps and opp-avg-KBps bindings
  OPP: Add support for bandwidth OPP tables
  OPP: Add helper function for bandwidth OPP tables
  OPP: Add API to find an OPP table from its DT node
  dt-bindings: interconnect: Add interconnect-opp-table property
  interconnect: Add OPP table support for interconnects
  OPP: Add function to look up required OPP's for a given OPP
  OPP: Allow copying OPPs tables between devices
  interconnect: Add devfreq support

 .../bindings/interconnect/interconnect.txt    |   8 +
 Documentation/devicetree/bindings/opp/opp.txt |  15 +-
 drivers/interconnect/Makefile                 |   2 +-
 drivers/interconnect/core.c                   |  27 +++-
 drivers/interconnect/icc-devfreq.c            | 144 ++++++++++++++++++
 drivers/opp/core.c                            | 109 +++++++++++++
 drivers/opp/of.c                              |  75 +++++++--
 drivers/opp/opp.h                             |   4 +-
 include/linux/interconnect.h                  |  17 +++
 include/linux/pm_opp.h                        |  41 +++++
 10 files changed, 426 insertions(+), 16 deletions(-)
 create mode 100644 drivers/interconnect/icc-devfreq.c

-- 
2.22.0.rc2.383.gf4fbbf30c2-goog

