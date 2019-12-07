Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFDAB115A0E
	for <lists+linux-pm@lfdr.de>; Sat,  7 Dec 2019 01:24:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbfLGAYa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Dec 2019 19:24:30 -0500
Received: from mail-pg1-f202.google.com ([209.85.215.202]:56233 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbfLGAY3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Dec 2019 19:24:29 -0500
Received: by mail-pg1-f202.google.com with SMTP id v30so4679716pga.22
        for <linux-pm@vger.kernel.org>; Fri, 06 Dec 2019 16:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=5QskUqrSs8tfhni9O8M9nfwm0gn25mamJ/N+0daOZSo=;
        b=GgYr0rmgQ4SIfZj52ZzHe23Vh0wuhLbhsjx5x0yvFHjxMONRS4whndS8mkm0Mhgg3d
         Jz3P7AZTOF2bdV4BLiJP3zKP8ruj3NdC6kBl7SCzdwU5s5yG9XCLJYOFj9jUuvD1zsir
         jfWv2cHws+AFbw1RIYCY9hHp6xSYDvQ66WombrhSUT92tJUylngUKaaScJp39VHIieUT
         V3TznRF8MhDUny61c8jU4pGlLiWd8XGIRKKocNEChkh36F93f6zu/PY1FiqDBZPXAJnv
         0fsR7MDwR9ikXI9xTGElm0wsbM4F6hH8qxpmMYEJ+B6S54qMMaLzk3FTT3/C1oCCv7gw
         iuJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=5QskUqrSs8tfhni9O8M9nfwm0gn25mamJ/N+0daOZSo=;
        b=ENRnEofIZ24sgglVTORRmYT9HQ6ecffLpX7W4CTmlnlu0ygN2g+xzKxoLmNKtD1l4B
         QJEIMSeRfhEC+e+owWy4GwLJeSqZiSVIsjkA/RACwz2DIHed178nUngCvdnxFq2tQw5x
         3up2EYo7lN8EKM4fbckXtU8eb+dEsULCzjYxTW+yeYtS6PpgzN1W87A/IlBD+xkPuYm0
         SUG0A/AdbG/YUPwSCA60zRyaEOQTk4SoTXBlbDmAU1Gf1WxWvKj30oMM+GP07qACw5we
         I+gnHmCJnoIZST5RES7CAkw5V67oDmigwSRlUjc4HwxPnxS+mZDrjOs4mUWPoxMUUIgR
         +zWg==
X-Gm-Message-State: APjAAAUyw2vc+FFM6MwX0Qt7Q8Qls0jGHqJ/jABJX8u2U+ISRQZ4Lkqx
        dezjUxVISoR+qSzHIZM65TmX/vODLPO65Hw=
X-Google-Smtp-Source: APXvYqwv2cS8roXs3o61C/0Z4Ss478NxQoub4UVFi4s0qZCzqLSz5ySy4LZM+5VlBHusfRzpt91TN0FrLJLWvtA=
X-Received: by 2002:a63:4723:: with SMTP id u35mr6378799pga.194.1575678268770;
 Fri, 06 Dec 2019 16:24:28 -0800 (PST)
Date:   Fri,  6 Dec 2019 16:24:21 -0800
Message-Id: <20191207002424.201796-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
Subject: [PATCH v6 0/3] Introduce Bandwidth OPPs for interconnects
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

Viresh/Stephen,

I don't think all the additional code/diff in this v6 series is worth it
to avoid using the rate field to store peak bandwidth. However, since folks
weren't too happy about it, here it is. I prefer the v5 series, but not
too strongly tied to it. Let me know what you think Viresh/Stephen.

Btw, I wasn't sure of opp-hz = 0 or opp-level = 0 were allowed. Also,
it's not clear why the duplicate check isn't done for opp-level when
_opp_add() is called. Based on that, we could add opp-level comparison
to opp_compare_key(). That's why you'll see a few spurious
opp_key.level = 0 lines. Let me know how you want to go with that.

I could also add a opp.key_type enum field to store what key type the
opp entry is. But looks like I can get away without adding an
unnecessary variable. So, I've skipped that for now.

------

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
v5->v6:
- Added Rob's reviewed-by for the DT patch
- Rewrote OPP patches to use separate field for peak_bw instead of
  reusing rate field.
- Pulled in opp-level parsing into _read_opp_key
- Addressed minor code style and typo comments

Cheers,
Saravana

Saravana Kannan (3):
  dt-bindings: opp: Introduce opp-peak-kBps and opp-avg-kBps bindings
  OPP: Add support for bandwidth OPP tables
  OPP: Add helper function for bandwidth OPP tables

 Documentation/devicetree/bindings/opp/opp.txt |  15 +-
 .../devicetree/bindings/property-units.txt    |   4 +
 drivers/opp/core.c                            | 316 +++++++++++++++---
 drivers/opp/of.c                              |  63 ++--
 drivers/opp/opp.h                             |   5 +
 include/linux/pm_opp.h                        |  43 +++
 6 files changed, 383 insertions(+), 63 deletions(-)

-- 
2.24.0.393.g34dc348eaf-goog

