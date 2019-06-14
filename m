Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 796EA45341
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2019 06:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725819AbfFNERk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Jun 2019 00:17:40 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:44171 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbfFNERj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Jun 2019 00:17:39 -0400
Received: by mail-pl1-f202.google.com with SMTP id n1so837518plk.11
        for <linux-pm@vger.kernel.org>; Thu, 13 Jun 2019 21:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=sGT1sw20NjRQQwzZPLiKAFC3XafLsr2WQ0wwPIEim/o=;
        b=tCXPkAPax/VZHnTqMUdfT8OH8PVDFQqPnz6C/YHQYeIOjzyo8MIYTqyJXdysiQ2t6x
         DjukMcDCPff9GoAS7CqDQt1owOOgUgVltZfRULTMnfggmNs6fwAu6dzvGM3nH8siPFjx
         CTouHUYUf3PfTHEv9rkBNA7/3YCrDFWAlVYfcbjNUAp5fFehWmj+xYaZOrWMfDlYRZiq
         pWC9A6U5QWxSkFhIPtmj1TMbpfd19vqr2Y44YdCUZKFhpUWkYACKXqBQuqO71O1pgkpE
         yZcN+yGQi4E3xpMOsPby3BHch/2iylwqWc4H+7Q9QC7T7Z3eLKEw7SowO0eyfYEMsYoP
         IEXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=sGT1sw20NjRQQwzZPLiKAFC3XafLsr2WQ0wwPIEim/o=;
        b=C4A7s/3s85aWsGOtmyDP7YFh+IbLFmdfTEOinKzVHE193O3CBySeJtE9gRiRQ2lTO+
         pe4oRZzU+7pAKU9jXniLHsUcDZE7ea3keZZZqTcoFs1MVEykagITeJF5NZ9wYLdypcS9
         TaKYe5v73KFirBaNq1gyx8dJMXa49JXmLpil5ZbowIU3X07+bC2uuxnp6+oRsqWkuiS0
         5vjB4M9jWyNfoks+spzRu1zMJQDn0nIPDzUxa+2bl4FoX5HFwMm315rT/BP94Est7dwr
         T1/JMUufy7P+cJ/mZ4GKiWitQuMVpyNE+WuuTRBnLkt9WlzkXX+vpo9kHdlSuOCzsfXC
         XosQ==
X-Gm-Message-State: APjAAAWhX8xMemHTguaglCcj4WLi3sYUXffCyNClypc2quOmnZCgHfKB
        Vhf5Ahm1zgrCssEhB24ZAaTUpZsgBfVMpWw=
X-Google-Smtp-Source: APXvYqzUlYsCg9NeaN/PERsgLwAw3KyAYfCl6WExXyjvNXzeISVKpKtii/e5ZKrx8Nj2ZZuIcwvAEdIKPaCxaTI=
X-Received: by 2002:a65:5302:: with SMTP id m2mr33501735pgq.369.1560485858053;
 Thu, 13 Jun 2019 21:17:38 -0700 (PDT)
Date:   Thu, 13 Jun 2019 21:17:22 -0700
Message-Id: <20190614041733.120807-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
Subject: [PATCH v2 00/11] Introduce Bandwidth OPPs & interconnect devfreq driver
From:   Saravana Kannan <saravanak@google.com>
To:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
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
- Allow required-opps to point to any device's OPP
- Add support to devfreq passive governor to look at the "parent"
  devfreq's required-opps to decide the "slave" device's frequency
- Adds Bandwidth OPP table support
- Adds a devfreq library for interconnect paths

Interconnects and interconnect paths quantify they performance levels in
terms of bandwidth. So similar to how we have frequency based OPP tables
in DT and in the OPP framework, this patch series adds bandwidth OPP
table support in the OPP framework and in DT.

To simplify voting for interconnects, this patch series adds helper
functions to create devfreq devices out of interconnect paths. This
allows drivers to add a single line of code to add interconnect voting
capability.

To add devfreq device for the "gpu-mem" interconnect path and use
required OPPs to do decide gpu-mem bandwidth:
icc_create_devfreq(dev, "gpu-mem", gpu_devfreq);

To add devfreq device for the "gpu-mem" interconnect path and use some
other governor to device gpu-mem bandwidth:
icc_create_devfreq(dev, "gpu-mem", NULL);

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


Saravana Kannan (11):
  OPP: Allow required-opps even if the device doesn't have power-domains
  OPP: Add function to look up required OPP's for a given OPP
  PM / devfreq: Add required OPPs support to passive governor
  dt-bindings: opp: Introduce opp-peak-KBps and opp-avg-KBps bindings
  OPP: Add support for bandwidth OPP tables
  OPP: Add helper function for bandwidth OPP tables
  OPP: Add API to find an OPP table from its DT node
  dt-bindings: interconnect: Add interconnect-opp-table property
  interconnect: Add OPP table support for interconnects
  OPP: Allow copying OPPs tables between devices
  interconnect: Add devfreq support

 .../bindings/interconnect/interconnect.txt    |   8 +
 Documentation/devicetree/bindings/opp/opp.txt |  15 +-
 drivers/devfreq/governor_passive.c            |  25 ++-
 drivers/interconnect/Makefile                 |   2 +-
 drivers/interconnect/core.c                   |  27 ++-
 drivers/interconnect/icc-devfreq.c            | 156 ++++++++++++++++++
 drivers/opp/core.c                            | 115 ++++++++++++-
 drivers/opp/of.c                              |  90 +++++++---
 drivers/opp/opp.h                             |   4 +-
 include/linux/interconnect.h                  |  21 +++
 include/linux/pm_opp.h                        |  44 +++++
 11 files changed, 474 insertions(+), 33 deletions(-)
 create mode 100644 drivers/interconnect/icc-devfreq.c

-- 
2.22.0.rc2.383.gf4fbbf30c2-goog

