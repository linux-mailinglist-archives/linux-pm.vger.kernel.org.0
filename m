Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD3E318F8
	for <lists+linux-pm@lfdr.de>; Sat,  1 Jun 2019 04:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbfFACMj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 31 May 2019 22:12:39 -0400
Received: from mail-vs1-f74.google.com ([209.85.217.74]:40125 "EHLO
        mail-vs1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbfFACMj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 31 May 2019 22:12:39 -0400
Received: by mail-vs1-f74.google.com with SMTP id s124so2358828vsb.7
        for <linux-pm@vger.kernel.org>; Fri, 31 May 2019 19:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=08mjM/33fuAqClzZoa7YUqdS1ySMCsNBKI12UqOjWzk=;
        b=XU+pKjLjCREmIBEMxtJFIuXHdFTwxOwud1WuUBFVM/dIo2ugghEu8frk5STuW6Ba5X
         sl+zeuOutVq74dkKsF8vRIABDKcSElkUh8RjD6BNxGAB+lxazRNlgWEoJ5Z7znW5Kw81
         Kky7qO0kD/7H1w3E5t6b5/pD/4qeE8nMajfcqDgwpGjo01ZteNYb156IoMwCXtY+ISKy
         p8pG0CSF3ULO7WtN20Y7tCtpZoKv+/yzn1rDcbCka/j2ixifbrz4SP2x7kCb1zYsGRbJ
         uuoCgNifI0hwYZcLlvqKfXAHyOOnJkHvtikvnxGbGK/HHfOFUOe/zTJmDCwfP2ExJoDD
         wyHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=08mjM/33fuAqClzZoa7YUqdS1ySMCsNBKI12UqOjWzk=;
        b=LIi7MtpZ1lQVc6rhtrEX8dKZalonagyInKa0huz2aQf9aLVbfBRSw7379fDLqLw+77
         VdwMFFvMCU6DJR1OmmW6j9bE8rELpJ0GFMhjoYjlORMk/p/2fJrsrkT0FN1DQx9GMVcO
         fJt+fgYRKg1z9guPKWburnQ7U7pYhiFCOpxCc0KkmWUoCVhwUwFeLrMm7E/Th78UH7CV
         iYIRG8IGjPGrmNwnQBXQarNdjmdHT6b7GyqbpzXehVk4YiQHcQkZ41x6i71N6QfUAL2i
         DeekynV/H7OqkCFLjfjjnQptNc5aXgA8W5Xwas9Bl6UexwFY0BMP7uVPx8pwNDHUonr8
         AUhQ==
X-Gm-Message-State: APjAAAVCCaqwuFicO6MAitfurdMpakKieA1buo62k7zWfN1WzhBgwI2T
        5epvUjclEDOjb/aKPCN+WHuoXQGvfqBhPnM=
X-Google-Smtp-Source: APXvYqyZctxOLLcNqdJz4F8qgSoryrsfzX9pcTmEDGxkkTcjvAc7STsB97HnlgnuSCfsvxcZBuyiP5a9mw7ZzC4=
X-Received: by 2002:a67:ea03:: with SMTP id g3mr6750699vso.212.1559355157607;
 Fri, 31 May 2019 19:12:37 -0700 (PDT)
Date:   Fri, 31 May 2019 19:12:28 -0700
In-Reply-To: <20190423132823.7915-1-georgi.djakov@linaro.org>
Message-Id: <20190601021228.210574-1-saravanak@google.com>
Mime-Version: 1.0
References: <20190423132823.7915-1-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
Subject: Re: [PATCH v2 0/5] Introduce OPP bandwidth bindings
From:   Saravana Kannan <saravanak@google.com>
To:     georgi.djakov@linaro.org
Cc:     amit.kucheria@linaro.org, bjorn.andersson@linaro.org,
        daidavid1@codeaurora.org, devicetree@vger.kernel.org,
        evgreen@chromium.org, jcrouse@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, mark.rutland@arm.com, nm@ti.com,
        rjw@rjwysocki.net, robh+dt@kernel.org, sboyd@kernel.org,
        seansw@qti.qualcomm.com, sibis@codeaurora.org,
        vincent.guittot@linaro.org, vireshk@kernel.org,
        saravanak@google.com, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

I'll have to Nack this series because it's making a couple of wrong assumptions
about bandwidth voting.

Firstly, it's mixing up OPP to bandwidth mapping (Eg: CPU freq to CPU<->DDR
bandwidth mapping) with the bandwidth levels that are actually supported by an
interconnect path (Eg: CPU<->DDR bandwidth levels). For example, CPU0 might
decide to vote for a max of 10 GB/s because it's a little CPU and never needs
anything higher than 10 GB/s even at CPU0's max frequency. But that has no
bearing on bandwidth level available between CPU<->DDR.

There needs to be a separate BW OPP table describing the bandwith levels
available for the CPU<->DDR path and then a separate mapping between CPU OPP to
CPU<->DDR BW OPP. That way, the mapping decision (policy or voltage based
config decision) doesn't affect the description of what the hardware really is
capable of.

Put another way, if someone comes around and decides the CPU0's max freq should
ask for 15 GB/s because some shared voltage rail would already be pushed to a
voltage sufficient to support 15 GB/s, then it shouldn't change the HW
description of what bandwidth levels are available between CPU<->DDR. If the
CPU<->DDR path supports 20 GB/s, it always does independent of the CPU OPP
table mapping.

By splitting out the available bandwidth levels of the CPU<->DDR path into a
separate BW OPP table, we avoid these kinds of issues.

Also, one could easily imagine using a bandwidth counter or some other means of
BW measurement hardware to vote for bandwidth between CPU<->DDR and CPU<->L3.
That entity should be able to know/learn all the available bandwidth levels in
the CPU<->DDR path without forcing bandwidth levels to be listed in CPU OPP
table. And if it's measuring bandwidth at a point common for all CPUs, what CPU
OPP table is it even supposed to look at to learn all the available bandwidth
levels. It just doesn't make sense.

It's also easy to envision having multiple policies or devfreq governors voting
for an interconnect path. The mapping you are talking about in this series is
just an input for one of them (the cpufreq-map governor I sent out a while
ago).

Secondly, when it comes to bandwidth OPP tables, the peak bandwidth should be
the key/first element (similar to how frequency is now). Long explanation
follows.

All the sensible frequency combinations of all the hardware interconnects
between the master and slave port (Eg: GPU -> MMNOC -> BIMC -> DDR) determine
the peak bandwidth levels available in that interconnect path.

If multiple devices (GPU, CPU, etc) vote for different peak bandwidths for an
interconnect (say BIMC), the interconnect provider picks the max peak bandwidth
amongst all the requests and then picks the lowest interconnect frequency that
can support the max peak bandwidth. 

So the devices (GPU, CPU, etc), actually have some control on what interconnect
frequencies are picked by asking for a specific peak bandwidth -- so there's
actually a notion of useful levels.

Average bandwidth is an additive property -- so if CPU and GPU ask for 5 GB/s
and 3 GB/s respectively for an interconnect, the interconnect provider adds
them up and configures the interconnect for 8 GB/s. So if GPU asks for 5 GB/s
average bandwidth, it has no idea what frequency the interconnect will actually
get configured to. So, average bandwidth really doesn't provide a sense of
levels to pick from for a given interconnect path.

So peak bandwidth is a much better pick than average bandwidth for being a key
to the bandwidth OPP table.

So what I think we need is:
* Bandwidth OPP support in the kernel
* Bandwidth OPP DT binding to describe the bandwidth levels available for
  different interconnect paths.
* A new "interconnect-opp" property that can point to different BW OPP
  tables for each of the interconnect paths listed under interconnects
  property.

Then for mapping from device OPP to interconnect path bandwidth OPPs, you
just used the existing required-opps binding to link an entry in GPU OPP to
an entry in GPU<->DDR bandwidth OPP table. That way the hardware is
actually described correctly and the mapping is kept separate.

So, in the end, it'll look something like this in DT.

gpu_cache_opp_table: gpu_cache_opp_table {
	compatible = "operating-points-v2";

	gpu_cache_3000: opp-3000 {
		opp-peak-mbps = <3000>;
		avg-mbps = <1000>;
	};
	gpu_cache_6000: opp-6000 {
		opp-peak-mbps = <6000>;
		avg-mbps = <2000>;
	};
	gpu_cache_9000: opp-9000 {
		opp-peak-mbps = <9000>;
		avg-mbps = <9000>;
	};
};

gpu_ddr_opp_table: gpu_ddr_opp_table {
	compatible = "operating-points-v2";

	gpu_ddr_1525: opp-1525 {
		opp-peak-mbps = <1525>;
		avg-mbps = <452>;
	};
	gpu_ddr_3051: opp-3051 {
		opp-peak-mbps = <3051>;
		avg-mbps = <915>;
	};
	gpu_ddr_7500: opp-7500 {
		opp-peak-mbps = <7500>;
		avg-mbps = <3000>;
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
	operating-points-v2 = <&gpu_opp_table>;
	interconnects = <&mmnoc MASTER_GPU_1 &bimc SLAVE_SYSTEL_CACHE>,
			<&mmnoc MASTER_GPU_1 &bimc SLAVE_DDR>;
	interconnect-names = "gpu-cache", "gpu-mem";
	interconnect-opps = <&gpu_cache_bw_opp>, <&gpu_ddr_bw_opp>
};

It's very clear what the HW supports vs what the mapping chooses to use. It's
also very clearer what the mapping is doing because it actually points to
entries in appropriately names OPP tables. There's no confusion on what mapping
corresponds to what interconnect paths -- which is why this doesn't need a
comment to clarify the intent here whereas in this patch series, the mappings
needed comments on which interconnect they are referring to.

Sorry about the long email and jumping in out of nowhere. The need for
something like this has been in my mind for a long time and my situation has
also changed where I can be more active upstream compared to before.

Thanks and have a nice weekend.

-Saravana

-- 
