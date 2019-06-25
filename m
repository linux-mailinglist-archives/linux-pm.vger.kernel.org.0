Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16409559F7
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2019 23:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbfFYVdq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Jun 2019 17:33:46 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:39835 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfFYVdn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Jun 2019 17:33:43 -0400
Received: by mail-pg1-f201.google.com with SMTP id v6so158475pgh.6
        for <linux-pm@vger.kernel.org>; Tue, 25 Jun 2019 14:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=c6hAycyMlxz47CFouFEVRVMQfFzVdquweZ4JkxM8rHY=;
        b=vEdbAftA62D7XRgIji4W8EBitFBZHh3LfoDOdtCDkUr/sLgCAReon/sLsp2TZCVwbg
         CkxOVs5hdloQkhFG/hMcJUpfmAmNc4IASleRLhQvbRZYIY++XI5FkjwlcmMn4PbIeVdg
         QKax3rsPgT6Skrr+8OIOif2cEWoB1PWxiMHrR4KinqV9JS1Hk7peMVLptfltiFvxWp2J
         Ux8LQQtZMShxqosksrqcue6KtFLfTRODveLJm3Clzv5UcDmSJL1YhVnwj9htFjezFvxU
         ROAUBKalSsVqLlFjvE9DrUeRs+j9SCuNFKlJMEEPs9J+tUU+7+/PmI90QnQRgLx17odv
         CMaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=c6hAycyMlxz47CFouFEVRVMQfFzVdquweZ4JkxM8rHY=;
        b=fRQ6tiWcwLe1rJfb0MnJ3G5VmMxr/iHQPnPT/BN8AIEaAXafboaU3oq07JyuBJZeu4
         SL1X62YS7iFCI1YeHCg1LWhEYMJNm+z02xvbNiZIhTX8q41mSA2SzPEgD00EHKQPdImt
         5+UHfb2dv7f20qibcJAyvKmVvWf+zk824VSqLgLMGwhN43FGmRG2Pg+qyc0PYvD44Gc2
         M+3hOmh8mF4axCCLmOiEyPZWRlGNMIPR4sFvfmY/4EG3jqyVfo/gqXBqtCMA851cyKbI
         aMmUBv5PGKaAXf86XA6RnLm24h9WZKLc1gVHZuBWXF7uWINz3ZuJPmcLwrneKQY9FISl
         jE2g==
X-Gm-Message-State: APjAAAWehFy30l4030WRJCTI5XxB/OQxrUDaKy7zdJU0+wd2gbRWD4DB
        QBx+DmL1sQsqNi6Kx4VnP9cxwf76bhbKSrw=
X-Google-Smtp-Source: APXvYqzdDqdZcIyyTCQpfYliTXh2485VcU9QWV+U4gKElHjTn2Njkd1hjk1Yn51n6lFbcANWiKh2qE7vcWUFtYc=
X-Received: by 2002:a63:dd53:: with SMTP id g19mr39414633pgj.3.1561498421863;
 Tue, 25 Jun 2019 14:33:41 -0700 (PDT)
Date:   Tue, 25 Jun 2019 14:33:33 -0700
Message-Id: <20190625213337.157525-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v2 0/4] Add required-opps support to devfreq passive gov
From:   Saravana Kannan <saravanak@google.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Saravana Kannan <saravanak@google.com>, kernel-team@android.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The devfreq passive governor scales the frequency of a "child" device based
on the current frequency of a "parent" device (not parent/child in the
sense of device hierarchy). As of today, the passive governor requires one
of the following to work correctly:
1. The parent and child device have the same number of frequencies
2. The child device driver passes a mapping function to translate from
   parent frequency to child frequency.

When (1) is not true, (2) is the only option right now. But often times,
all that is required is a simple mapping from parent's frequency to child's
frequency.

Since OPPs already support pointing to other "required-opps", add support
for using that to map from parent device frequency to child device
frequency. That way, every child device driver doesn't have to implement a
separate mapping function anytime (1) isn't true.

Some common (but not comprehensive) reason for needing a devfreq passive
governor to adjust the frequency of one device based on another are:

1. These were the combination of frequencies that were validated/screened
   during the manufacturing process.
2. These are the sensible performance combinations between two devices
   interacting with each other. So that when one runs fast the other
   doesn't become the bottleneck.
3. Hardware bugs requiring some kind of frequency ratio between devices.

For example, the following mapping can't be captured in DT as it stands
today because the parent and child device have different number of OPPs.
But with this patch series, this mapping can be captured cleanly.

In arch/arm64/boot/dts/exynos/exynos5433-bus.dtsi you have something
like this with the following changes:

	bus_g2d_400: bus0 {
		compatible = "samsung,exynos-bus";
		clocks = <&cmu_top CLK_ACLK_G2D_400>;
		clock-names = "bus";
		operating-points-v2 = <&bus_g2d_400_opp_table>;
		status = "disabled";
	};

	bus_noc2: bus9 {
		compatible = "samsung,exynos-bus";
		clocks = <&cmu_mif CLK_ACLK_BUS2_400>;
		clock-names = "bus";
		operating-points-v2 = <&bus_noc2_opp_table>;
		status = "disabled";
	};

	bus_g2d_400_opp_table: opp_table2 {
		compatible = "operating-points-v2";
		opp-shared;

		opp-400000000 {
			opp-hz = /bits/ 64 <400000000>;
			opp-microvolt = <1075000>;
			required-opps = <&noc2_400>;
		};
		opp-267000000 {
			opp-hz = /bits/ 64 <267000000>;
			opp-microvolt = <1000000>;
			required-opps = <&noc2_200>;
		};
		opp-200000000 {
			opp-hz = /bits/ 64 <200000000>;
			opp-microvolt = <975000>;
			required-opps = <&noc2_200>;
		};
		opp-160000000 {
			opp-hz = /bits/ 64 <160000000>;
			opp-microvolt = <962500>;
			required-opps = <&noc2_134>;
		};
		opp-134000000 {
			opp-hz = /bits/ 64 <134000000>;
			opp-microvolt = <950000>;
			required-opps = <&noc2_134>;
		};
		opp-100000000 {
			opp-hz = /bits/ 64 <100000000>;
			opp-microvolt = <937500>;
			required-opps = <&noc2_100>;
		};
	};

	bus_noc2_opp_table: opp_table6 {
		compatible = "operating-points-v2";

		noc2_400: opp-400000000 {
			opp-hz = /bits/ 64 <400000000>;
		};
		noc2_200: opp-200000000 {
			opp-hz = /bits/ 64 <200000000>;
		};
		noc2_134: opp-134000000 {
			opp-hz = /bits/ 64 <134000000>;
		};
		noc2_100: opp-100000000 {
			opp-hz = /bits/ 64 <100000000>;
		};
	};

-Saravana

v1 -> v2:
- Cached OPP table reference in devfreq to avoid looking up every time.
- Renamed variable in passive governor to be more intuitive.
- Updated cover letter with examples.

Saravana Kannan (4):
  OPP: Allow required-opps even if the device doesn't have power-domains
  OPP: Add function to look up required OPP's for a given OPP
  PM / devfreq: Cache OPP table reference in devfreq
  PM / devfreq: Add required OPPs support to passive governor

 drivers/devfreq/devfreq.c          |  6 ++++
 drivers/devfreq/governor_passive.c | 20 ++++++++---
 drivers/opp/core.c                 | 56 +++++++++++++++++++++++++++++-
 drivers/opp/of.c                   | 14 --------
 include/linux/devfreq.h            |  1 +
 include/linux/pm_opp.h             | 11 ++++++
 6 files changed, 88 insertions(+), 20 deletions(-)

-- 
2.22.0.410.gd8fdbe21b5-goog

