Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25C9A1CF501
	for <lists+linux-pm@lfdr.de>; Tue, 12 May 2020 14:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729436AbgELMxx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 May 2020 08:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729382AbgELMxx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 May 2020 08:53:53 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2A4C061A0F
        for <linux-pm@vger.kernel.org>; Tue, 12 May 2020 05:53:53 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id w7so15225497wre.13
        for <linux-pm@vger.kernel.org>; Tue, 12 May 2020 05:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ku6Mk/Al7SQIBJBCIdteQf7kevlDKUx0+YkyJTe4la0=;
        b=D4cMg89ykEUGNXqfHTzDCR6YYBvlCtdWKW71BwUd9HbOBSs52YRFWqdhvUGzGF9Gvn
         wNo8RV13CCExoSnw3n2UYWEXPT9AeZHbf933b3b6h1E41s4D3QJDC448C8vinsHTuyah
         XZBbvAge8YIXBuIo8+dXz3SenVIcAZQxnPfCAZQu+RPMtCxTpxPiBsxuJV0IRbYWRXoj
         hwYz1eZG3Ji2W1jUUaCXZqNC0IcSVwSrJfPgJLzz03hTJpI+FmnHxPOEXCG1RtvaKCQn
         tkOw2+BPIc/e9uTR72LvOM6HwKe0lxvuZUhw7V27lzSrKveofBCK25bVPNeETgZYEtnX
         oqlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ku6Mk/Al7SQIBJBCIdteQf7kevlDKUx0+YkyJTe4la0=;
        b=tuE+Yw0FUNxSYWZKZqae1N3BWWDKaph+gF4T/Wd0dP2FGlx97KukBkHgAAvAJvhiJQ
         DMyzfI99rgfp27MM9NtqL4s7fFk3moxZlcSxEmXkGLiYryMcRIC7RYSi6nn3Aivjb5tp
         PeM7rVbNxgF/8/HQOxxtHiejs5AE0TYqGYojdaFxV4KHR2wGSW9hwnwsm/EMtIy7K52s
         Yi40zFyxzD9NgaSNn82CJV1ACkSr+jbB7UBC2Z8HxArb1V5FqFdi3kQgOEQdCoi6J+Rx
         uslyzm6sW94ZAAamMIPZ9UrShOwvBPYhUvDH+wJQms2NlauENMfnToVidJGyAuFEAQfX
         RcwA==
X-Gm-Message-State: AGi0PuZAx/Xy0bIz8qDmM8eD5DRkpp6MF5NSivm+KSYfCb8FUdL5EEc3
        dvufdt6Cggy08HLvmqNUax2l3A==
X-Google-Smtp-Source: APiQypL9YPc4HLVRC80LEbJoBfHK6TzF23U0aO/nzu0F2Fpj+PFOPai5gAhMv1nNLBXsftpFUnQjTA==
X-Received: by 2002:adf:b30f:: with SMTP id j15mr26774429wrd.394.1589288031506;
        Tue, 12 May 2020 05:53:51 -0700 (PDT)
Received: from localhost.localdomain (212-39-89-66.ip.btc-net.bg. [212.39.89.66])
        by smtp.googlemail.com with ESMTPSA id n13sm2433938wrs.2.2020.05.12.05.53.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 May 2020 05:53:50 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org, rjw@rjwysocki.net,
        saravanak@google.com, sibis@codeaurora.org, mka@chromium.org
Cc:     robh+dt@kernel.org, rnayak@codeaurora.org,
        bjorn.andersson@linaro.org, vincent.guittot@linaro.org,
        jcrouse@codeaurora.org, evgreen@chromium.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, georgi.djakov@linaro.org
Subject: [PATCH v8 00/10] Introduce OPP bandwidth bindings
Date:   Tue, 12 May 2020 15:53:17 +0300
Message-Id: <20200512125327.1868-1-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Here is a proposal to extend the OPP bindings with bandwidth based on
a few previous discussions [1] and patchsets from me [2][3] and Saravana
[4][5][6][7][8][9].

Changes in v8:
* Addressed review comments from Matthias, Sibi and Viresh.
* Picked reviewed-by tags.
* Picked Sibi's interconnect-tag patches into this patchset.

Changes in v7: https://lore.kernel.org/r/20200424155404.10746-1-georgi.djakov@linaro.org
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

Georgi Djakov (6):
  interconnect: Add of_icc_get_by_index() helper function
  OPP: Add support for parsing interconnect bandwidth
  OPP: Add sanity checks in _read_opp_key()
  OPP: Update the bandwidth on OPP frequency changes
  cpufreq: dt: Add support for interconnect bandwidth scaling
  cpufreq: dt: Validate all interconnect paths

Saravana Kannan (2):
  dt-bindings: opp: Introduce opp-peak-kBps and opp-avg-kBps bindings
  OPP: Add helpers for reading the binding properties

Sibi Sankar (2):
  dt-bindings: interconnect: Add interconnect-tags bindings
  OPP: Add support for setting interconnect-tags

 .../bindings/interconnect/interconnect.txt    |   5 +
 Documentation/devicetree/bindings/opp/opp.txt |  17 +-
 .../devicetree/bindings/property-units.txt    |   4 +
 drivers/cpufreq/Kconfig                       |   1 +
 drivers/cpufreq/cpufreq-dt.c                  |  54 +++++
 drivers/interconnect/core.c                   |  72 +++++--
 drivers/opp/Kconfig                           |   1 +
 drivers/opp/core.c                            |  55 ++++-
 drivers/opp/of.c                              | 189 ++++++++++++++++--
 drivers/opp/opp.h                             |  10 +
 include/linux/interconnect.h                  |   6 +
 include/linux/pm_opp.h                        |  12 ++
 12 files changed, 380 insertions(+), 46 deletions(-)

