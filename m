Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1CB1774D3
	for <lists+linux-pm@lfdr.de>; Sat, 27 Jul 2019 01:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbfGZXQF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Jul 2019 19:16:05 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:56245 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbfGZXQE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Jul 2019 19:16:04 -0400
Received: by mail-pg1-f201.google.com with SMTP id z14so26920811pgr.22
        for <linux-pm@vger.kernel.org>; Fri, 26 Jul 2019 16:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=cpXw17kbjpY+4NI0A8ywBRzRbBcUV30TBmJ29JFZSu8=;
        b=lGeUakeOQjQpoRbjD3eQTccJQgPrsvuP1WdT/liYx7Tq4s/KNjmGm7SiRV+T/GO/9u
         YWiGATr1gNWtXgVWidLbG4uLV5w27wVYiH72EFZ5EBpetALJZMJotGMiioYxzJ/7QXF4
         D3WPjrZ/bGa2vn4yHXpsDyijYQuJOgC8gJw3ebo9oU9IAzsEP+O84JwPlOy8yym3io0s
         OVIMEsVaCh7+brCgiFB87+mCAMmIs3QEmHlxASphKIK2SPhxWBgiNl9AhSiPneEENtWn
         cXwtId0Hz9cKJG0NRap3E9lfm4x0wdY+ycCU+1qZ5uEmAKpZyjh/uW242uPqyM4DaIet
         iY3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=cpXw17kbjpY+4NI0A8ywBRzRbBcUV30TBmJ29JFZSu8=;
        b=OhTKYhXEJE0vWpIhSqmO4ykomJYRSyDja8hCVzKt1tm6+X+d+A3v46JZW8IlihnAdS
         Y5d7L8VCBJd5tr3tmlBqnWMtCDBVjZcXjcXMygfN+KsxePGPylAWGCRYX0X9HWxuBt6b
         LHmeFUabId2TR7NIWlS0JXLClUrzDZ1gLDVFH+9kVixebDHf30wwa48dT6e1DklKnhek
         bJwvG171y0+ohu3vC2BMJi1jkW1JSuF03o2EBj08El6prloMtGq3k1fzA04RwFj8ZNUO
         fgbZHt9oyWSjB43FMvwXfMNETEwMIJ26MQT6eRMAGWZ3bC47UGjeEKMlIrV9N7UWhOrn
         6Olw==
X-Gm-Message-State: APjAAAUah31nJZFii+Rq5TMxH8trOp48A4dTwcvlJV72un/VWH6zOKMl
        M9KgI4lrkIZ7GTaHuf1Oy6/Wg/qj5sQXiaQ=
X-Google-Smtp-Source: APXvYqyLFXzg7wzzQqNVNsI8TFZ+iafyw/A7sv3S5RiRtNoVmsGtyF3JmmM3anWSx8u0e6UhM5jUYxwYZmhQdZo=
X-Received: by 2002:a63:c442:: with SMTP id m2mr95101718pgg.286.1564182963590;
 Fri, 26 Jul 2019 16:16:03 -0700 (PDT)
Date:   Fri, 26 Jul 2019 16:15:54 -0700
Message-Id: <20190726231558.175130-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
Subject: [PATCH v4 0/3] Introduce Bandwidth OPPs for interconnects
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

Cheers,
Saravana

Saravana Kannan (3):
  dt-bindings: opp: Introduce opp-peak-KBps and opp-avg-KBps bindings
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
2.22.0.709.g102302147b-goog

