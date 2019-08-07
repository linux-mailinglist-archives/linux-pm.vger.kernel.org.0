Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2CF855D2
	for <lists+linux-pm@lfdr.de>; Thu,  8 Aug 2019 00:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389423AbfHGWbQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Aug 2019 18:31:16 -0400
Received: from mail-vs1-f74.google.com ([209.85.217.74]:36275 "EHLO
        mail-vs1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388978AbfHGWbQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Aug 2019 18:31:16 -0400
Received: by mail-vs1-f74.google.com with SMTP id j77so23532085vsd.3
        for <linux-pm@vger.kernel.org>; Wed, 07 Aug 2019 15:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=cO1gXGOyS0gi4TQ5Wq0NWKmVpQwgP9l+EbKlT+h4gHU=;
        b=uuZtBdB/7qm120Nq4qybmRvPR+I9q9Ixj2SEs5qLEw7hCnWKJaIX7nHfzN05S8Vy4N
         epZt1M0q+U54DDnq2jYdBwqpJyjE0IPSPk29QdW4rpPRMHTSevRMRaNO3InbE5rrVdAt
         t3axTnksX9aJake09fiFXBtGmaOWP277JThdHw8b4/gR8nb/0UoWf06gDjhQcqBRK2Ml
         QuFI9Kv7ZSiPp9tnwhKBRXIo0rSrKFKp86U8aVh+u316HgpJmZ2j5OiG+DVtheQqEqeW
         bADKCYVbMb6k+xyfjFFIMI86n4ofrnNOKXzvwf3M9loIElQpTlHmu9VjWQUyx72b8yee
         6Hsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=cO1gXGOyS0gi4TQ5Wq0NWKmVpQwgP9l+EbKlT+h4gHU=;
        b=B3TDjixo5iTElFuPCbPGUb6nkotEF3lzwFLWzm8j3LDkR/BRD3Cn9rCRyfh0O9Oczd
         bJ1ebfRuQcSbeggpSVxAKSjRLItXyVdmcvDUsvQC7PJ/BwAkYZvD/WF3DoMC+VAwyvi8
         I5VLGPAFf5quNXxbRHoTHkQ6a0+PvKdeXX8XfaBliZh6cGesKKcckF+3JgRtJA2ZAEvE
         PmYs79FJZ9BfebHF4qPLTPOG8HpkMRzaRhqX0crdtMGvH0jQOftODhXwJrmLxdvT4g7A
         q287PTom5GH2iDThWxjc1H7T6SMu4CE8/PTCU4zMR0y47qMxJmybMhlDf+GdhuyzbJzX
         RHyg==
X-Gm-Message-State: APjAAAX9dJlk3CBs5bRQDLluPRLDHRuhuVg4ULZ6H4bx3AuJ44CV3Nvz
        9x2DRNhIQCAGdrv9q2aPK1uOuNR2octi2xI=
X-Google-Smtp-Source: APXvYqya79a8mTDjLu2/eYtzqZNc/blOum2HVA6RIc6UOhuB5YGHpARfWsXtxe4HrnBdTDDJj7wdN9IHAnOOlF8=
X-Received: by 2002:ac5:c4cc:: with SMTP id a12mr4618231vkl.28.1565217074937;
 Wed, 07 Aug 2019 15:31:14 -0700 (PDT)
Date:   Wed,  7 Aug 2019 15:31:08 -0700
Message-Id: <20190807223111.230846-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH v5 0/3] Introduce Bandwidth OPPs for interconnects
From:   Saravana Kannan <saravanak@google.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Saravana Kannan <saravanak@google.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        vincent.guittot@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, adharmap@codeaurora.org,
        Rajendra Nayak <rnayak@codeaurora.org>, sibis@codeaurora.org,
        bjorn.andersson@linaro.org, evgreen@chromium.org,
        kernel-team@android.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Interconnects and interconnect paths quantify their performance levels in
terms of bandwidth and not in terms of frequency. So similar to how we have
frequency based OPP tables in DT and in the OPP framework, we need
bandwidth OPP table support in DT and in the OPP framework.

So with the DT bindings added in this patch series, the DT for a GPU
that does bandwidth voting from GPU to Cache and GPU to DDR would look
something like this:

gpu_cache_opp_table: gpu_cache_opp_table {
	compatible = "operating-points-v2";

	gpu_cache_3000: opp-3000 {
		opp-peak-KBps = <3000000>;
		opp-avg-KBps = <1000000>;
	};
	gpu_cache_6000: opp-6000 {
		opp-peak-KBps = <6000000>;
		opp-avg-KBps = <2000000>;
	};
	gpu_cache_9000: opp-9000 {
		opp-peak-KBps = <9000000>;
		opp-avg-KBps = <9000000>;
	};
};

gpu_ddr_opp_table: gpu_ddr_opp_table {
	compatible = "operating-points-v2";

	gpu_ddr_1525: opp-1525 {
		opp-peak-KBps = <1525000>;
		opp-avg-KBps = <452000>;
	};
	gpu_ddr_3051: opp-3051 {
		opp-peak-KBps = <3051000>;
		opp-avg-KBps = <915000>;
	};
	gpu_ddr_7500: opp-7500 {
		opp-peak-KBps = <7500000>;
		opp-avg-KBps = <3000000>;
	};
};

gpu_opp_table: gpu_opp_table {
	compatible = "operating-points-v2";
	opp-shared;

	opp-200000000 {
		opp-hz = /bits/ 64 <200000000>;
	};
	opp-400000000 {
		opp-hz = /bits/ 64 <400000000>;
	};
};

gpu@7864000 {
	...
	operating-points-v2 = <&gpu_opp_table>, <&gpu_cache_opp_table>, <&gpu_ddr_opp_table>;
	...
};

v1 -> v3:
- Lots of patch additions that were later dropped
v3 -> v4:
- Fixed typo bugs pointed out by Sibi.
- Fixed bug that incorrectly reset rate to 0 all the time
- Added units documentation
- Dropped interconnect-opp-table property and related changes
v4->v5:
- Replaced KBps with kBps
- Minor documentation fix

Cheers,
Saravana

Saravana Kannan (3):
  dt-bindings: opp: Introduce opp-peak-kBps and opp-avg-kBps bindings
  OPP: Add support for bandwidth OPP tables
  OPP: Add helper function for bandwidth OPP tables

 Documentation/devicetree/bindings/opp/opp.txt | 15 ++++--
 .../devicetree/bindings/property-units.txt    |  4 ++
 drivers/opp/core.c                            | 51 +++++++++++++++++++
 drivers/opp/of.c                              | 41 +++++++++++----
 drivers/opp/opp.h                             |  4 +-
 include/linux/pm_opp.h                        | 19 +++++++
 6 files changed, 121 insertions(+), 13 deletions(-)

-- 
2.23.0.rc1.153.gdeed80330f-goog

