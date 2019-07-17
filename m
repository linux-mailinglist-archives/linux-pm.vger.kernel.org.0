Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2A566C311
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jul 2019 00:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727606AbfGQWXv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Jul 2019 18:23:51 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:39600 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727468AbfGQWXv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Jul 2019 18:23:51 -0400
Received: by mail-qk1-f202.google.com with SMTP id x1so21424763qkn.6
        for <linux-pm@vger.kernel.org>; Wed, 17 Jul 2019 15:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=39fzf43hDflkP+uYiNQxS6xaHQ083/QpMzmuyzPtUdY=;
        b=wFgStKALBEnEGt6LhTq/NEkpkuHrszbthkXReAklwB+fSi7678pDRTqdNzz1J4M7nQ
         ithAPBOwnlK/vKTUQ8NpZ2t9LBCBbrrJe3mw3JT0Dgfce1x2Q5MuyZtMXeSoOexQFeQV
         py46WEEyAGWvUX+KNIp/iqwcV0fa/fzpvLiC/4OQTxkpTvI5wRI9EHAYAtfoEDifD/GT
         /iNk5d/5wuI4iQBwCsijLBHpImT7oD4vEh2hK7wDETFJTR/pmnq0CBWdMndIj669gqKJ
         fuL9MWGkllNLV1YHMI9IXiPM9Fd8XTzkdEguRkLxJ8n+cyxQfOhUUrLsYskJyMXGyHJ6
         wFcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=39fzf43hDflkP+uYiNQxS6xaHQ083/QpMzmuyzPtUdY=;
        b=i2vEn+iBO1deOrfKS7meGZep/b+02II9bL2kjnwyZABDpUVpq9T7TlXF7mw5Iwf1ny
         igkwjHO1foR/4mBMXHOUIBgGkCa9lqOy+Fy4WvxTkZDRjkkNtV++IrMnSlKl/V/NkXIF
         Wy78EgNtsS47yqEHWDbOLWkmOhw/wvBQpIczdN9cl1ZVdLrN1t9wXWpHXd/sZXRVTtvz
         z9P+wAvK/nIiEMGnpk9qs1BmqRL3h4+gTEjgTgORU6pF4TWAed/lmoFm/IG/dINo55i7
         6HVB2ej7Y2wk+/V7gD9ZBp9xe4ZxJ0jGFg6+FBvfXVrDrdL7cMZUzTn8mLzc3Ipc+zJV
         eVIQ==
X-Gm-Message-State: APjAAAWOmtRGM4KL07A+g8TKmAEWqKT1K651cEsLHjoF8dX0IcCaTtwc
        s+2ENfl/cFvH4C4F/sZhN5P+7a6/yCw1Neg=
X-Google-Smtp-Source: APXvYqwwmRW+eTEOj6donm+FHv+AKebXI1S/kdC9w7+cgDZiZMcYPmje/plxm0cMIQaq2SjBbLWVGj32MbX3BsU=
X-Received: by 2002:a37:646:: with SMTP id 67mr26866101qkg.287.1563402229934;
 Wed, 17 Jul 2019 15:23:49 -0700 (PDT)
Date:   Wed, 17 Jul 2019 15:23:35 -0700
Message-Id: <20190717222340.137578-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH v3 0/5] Add required-opps support to devfreq passive gov
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
  OPP: Improve require-opps linking
  PM / devfreq: Cache OPP table reference in devfreq
  PM / devfreq: Add required OPPs support to passive governor

 drivers/devfreq/devfreq.c          |  6 ++
 drivers/devfreq/governor_passive.c | 20 ++++--
 drivers/opp/core.c                 | 84 ++++++++++++++++++++++---
 drivers/opp/of.c                   | 98 +++++++++++++-----------------
 drivers/opp/opp.h                  |  5 ++
 include/linux/devfreq.h            |  2 +
 include/linux/pm_opp.h             | 11 ++++
 7 files changed, 156 insertions(+), 70 deletions(-)

-- 
2.22.0.510.g264f2c817a-goog

