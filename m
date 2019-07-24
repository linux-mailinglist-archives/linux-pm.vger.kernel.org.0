Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B611B723D8
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jul 2019 03:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728398AbfGXBm1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Jul 2019 21:42:27 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:45670 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728339AbfGXBm1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Jul 2019 21:42:27 -0400
Received: by mail-pf1-f201.google.com with SMTP id i27so27459097pfk.12
        for <linux-pm@vger.kernel.org>; Tue, 23 Jul 2019 18:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=RW3z74bdMJzDTGtz2VwJiLTUpXRTvYUzeWaG6+K3XV8=;
        b=vNJBiF/x6OHCcjwCOHbluPIl8E9mfj1/fOW0MrKGISKuPO8IhHo2qNzcurebvR82nK
         dqlzTf7VT1DWoGeS8gGDdsKgIJ0/ZslL6xo0xsTAsGC+8PzIBWHWoeuDXRVFnVcP6LmZ
         FsC8Cjf6JjX24Uv5ARw/vbdQ6c3Ob4XzzNN62dE6/C6FOfoyxMTykQ9YpQ0XNZM9wOE3
         zppn0MTMxA0U8dSv5AmsrWloImz4yc/9NOU9iiETG2AuRum/lVVkQRy/ef5YnBD18GBb
         EkpJOEv2Uu9UheyGucrCVKtNu6l5F8cnJxvukg9wtmBA3/N7AMJEVKQmgDKbas0Pkoa1
         91FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=RW3z74bdMJzDTGtz2VwJiLTUpXRTvYUzeWaG6+K3XV8=;
        b=PuAWUeSktl2444kOF5/IE6sm7qBPzW2f0co8NjmuAoNE+QNg3iZVi7kvsjWTFMH1Db
         00ju5dc6ASDyNHi3wObB1k/k1rIpktj1PRC+BjNQIZj2JL0QiAkle2T764n16G5lc5x/
         p6QPQBRMfvFzNhuQg88cGwTxpMAJRL/s0o9vABrvZpxkGNhRBIxcAvHROgo3gNpJiD1S
         eo2r/XvACgILrqM/RBVcpH4bvx46NoFBJan2tkLUkgMIl+G9GP4+3fhfnAKgl74iWAne
         MNl46/msCIjxMusInPiZiwVAuncSjU+ARDyrFt2+tbhi+sDMk3yZ9KNC11jk2Owhs4pj
         BDRQ==
X-Gm-Message-State: APjAAAXhAVB2oXLImAH5xMXD38LN0e2iVy92tRC1IqAWUs++3chUCgxm
        2ze3fb62LBbzZzd9WjlmTy+3R7jksAJO8y4=
X-Google-Smtp-Source: APXvYqyJ6rmRSMmpqO+pIAEVowap7BIjPFpMLo4a6RxHglx5k3LvlGrTrwVN1wOjB7wOGkYUfP//+q9zcmN1xcE=
X-Received: by 2002:a63:4404:: with SMTP id r4mr77918560pga.245.1563932546228;
 Tue, 23 Jul 2019 18:42:26 -0700 (PDT)
Date:   Tue, 23 Jul 2019 18:42:16 -0700
Message-Id: <20190724014222.110767-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
Subject: [PATCH v4 0/5] Add required-opps support to devfreq passive gov
From:   Saravana Kannan <saravanak@google.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Saravana Kannan <saravanak@google.com>,
        Sibi Sankar <sibis@codeaurora.org>, kernel-team@android.com,
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

v3 -> v4:
- Fixed documentation comments
- Fixed order of functions in .h file
- Renamed the new xlate API
- Caused _set_required_opps() to fail if all required opps tables aren't
  linked.
v2 -> v3:
- Rebased onto linux-next.
- Added documentation comment for new fields.
- Added support for lazy required-opps linking.
- Updated Ack/Reviewed-bys.
v1 -> v2:
- Cached OPP table reference in devfreq to avoid looking up every time.
- Renamed variable in passive governor to be more intuitive.
- Updated cover letter with examples.


Saravana Kannan (5):
  OPP: Allow required-opps even if the device doesn't have power-domains
  OPP: Add function to look up required OPP's for a given OPP
  OPP: Improve required-opps linking
  PM / devfreq: Cache OPP table reference in devfreq
  PM / devfreq: Add required OPPs support to passive governor

 drivers/devfreq/devfreq.c          |   6 ++
 drivers/devfreq/governor_passive.c |  20 ++++--
 drivers/opp/core.c                 |  83 +++++++++++++++++++---
 drivers/opp/of.c                   | 108 ++++++++++++++---------------
 drivers/opp/opp.h                  |   5 ++
 include/linux/devfreq.h            |   2 +
 include/linux/pm_opp.h             |  11 +++
 7 files changed, 165 insertions(+), 70 deletions(-)

-- 
2.22.0.709.g102302147b-goog

