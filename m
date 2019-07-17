Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD2C6BA3D
	for <lists+linux-pm@lfdr.de>; Wed, 17 Jul 2019 12:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbfGQKcY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Jul 2019 06:32:24 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34085 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbfGQKcY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Jul 2019 06:32:24 -0400
Received: by mail-pf1-f194.google.com with SMTP id b13so10635468pfo.1
        for <linux-pm@vger.kernel.org>; Wed, 17 Jul 2019 03:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Jp8lk+XdDHx/WRkU1D5GuTsiUq4pyzz7UbpMROhU2ZE=;
        b=MOmbQpeDaySamzTzRxIvnvpX4HkW3+1U/OzVaoTxLpP6WjNEghuOIG54DmhnLBEVUB
         Gv4MX0Yp1QzSU0H9tyF2pWpMZIzF0KJbCAupNNzEMzr68ZS9+WhIuQQmv28CL5DrsNmt
         C8ovN8ETD/P4jJcMkoMZEko1obD20GCi4h3BDU1Is/6IxqvWKZQfFGSVfOuuALec8LbJ
         fhX59w96WZTzCy79irx+IZYzVGnLMenGkRcY+72ECSzzAdmRqMlislssJbw3NlvMk2DX
         W0fKLSMLIekMkjKUi20BXVICF1dGLsuyPKeRyqsJjUdbtccs+DyB0eZFfr30N96xdA3J
         wDKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Jp8lk+XdDHx/WRkU1D5GuTsiUq4pyzz7UbpMROhU2ZE=;
        b=EsTVpk6rbkarEhsfk+ERvalseMNUWN8FIn5JV9OXNmXP+dIzwM3fktcmRz8d9veUmT
         O87d1Uzak6gplN5igY8uc2UCe968K4NJbKa0p1zg6ufOmf4vyoht8TUe7NGPJ7+T0pOa
         N8anD0XCRM0fsErO9iQO/VRtF7CnjR7VyI1PpMZtzWyDapoep2s1rMR9UKTAqtpJ92rK
         p7dRkbXo3HDDY4YpKL8yaP7rV9+Gy9eVanZhdnbilQtJpH/lGV13r9vqc31geFh/6JTc
         LWRRoQH/aphKItAZxmH9ZhQXbZXPnqSgqRMjvZeouL67dOU+iwffFuJ8mCy4tEs7qYTq
         VIUQ==
X-Gm-Message-State: APjAAAXz8vZFgzzZ8m4Xlf2w/e9VinooQNzSpdtQzkq4HA0objzqO/jH
        C/tjSCZrUCdYNAMSICcy1MQxmA==
X-Google-Smtp-Source: APXvYqwzL9mzp2aY/MeHimwmrGDIE6cQH+Ek0FFpxQTvAEuh2tG8JwxKx/eWT+sFX3kvqFizrjbQXg==
X-Received: by 2002:a63:f357:: with SMTP id t23mr7820293pgj.421.1563359543184;
        Wed, 17 Jul 2019 03:32:23 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id h1sm30377545pfo.152.2019.07.17.03.32.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Jul 2019 03:32:21 -0700 (PDT)
Date:   Wed, 17 Jul 2019 16:02:20 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        vincent.guittot@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, Rajendra Nayak <rnayak@codeaurora.org>,
        sibis@codeaurora.org, bjorn.andersson@linaro.org,
        evgreen@chromium.org, kernel-team@android.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/6] Introduce Bandwidth OPPs for interconnect paths
Message-ID: <20190717103220.f7cys267hq23fbsb@vireshk-i7>
References: <20190703011020.151615-1-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190703011020.151615-1-saravanak@google.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 02-07-19, 18:10, Saravana Kannan wrote:
> Interconnects and interconnect paths quantify their performance levels in
> terms of bandwidth and not in terms of frequency. So similar to how we have
> frequency based OPP tables in DT and in the OPP framework, we need
> bandwidth OPP table support in the OPP framework and in DT. Since there can
> be more than one interconnect path used by a device, we also need a way to
> assign a bandwidth OPP table to an interconnect path.
> 
> This patch series:
> - Adds opp-peak-KBps and opp-avg-KBps properties to OPP DT bindings
> - Adds interconnect-opp-table property to interconnect DT bindings
> - Adds OPP helper functions for bandwidth OPP tables
> - Adds icc_get_opp_table() to get the OPP table for an interconnect path
> 
> So with the DT bindings added in this patch series, the DT for a GPU
> that does bandwidth voting from GPU to Cache and GPU to DDR would look
> something like this:
> 
> gpu_cache_opp_table: gpu_cache_opp_table {
> 	compatible = "operating-points-v2";
> 
> 	gpu_cache_3000: opp-3000 {
> 		opp-peak-KBps = <3000>;
> 		opp-avg-KBps = <1000>;
> 	};
> 	gpu_cache_6000: opp-6000 {
> 		opp-peak-KBps = <6000>;
> 		opp-avg-KBps = <2000>;
> 	};
> 	gpu_cache_9000: opp-9000 {
> 		opp-peak-KBps = <9000>;
> 		opp-avg-KBps = <9000>;
> 	};
> };
> 
> gpu_ddr_opp_table: gpu_ddr_opp_table {
> 	compatible = "operating-points-v2";
> 
> 	gpu_ddr_1525: opp-1525 {
> 		opp-peak-KBps = <1525>;
> 		opp-avg-KBps = <452>;
> 	};
> 	gpu_ddr_3051: opp-3051 {
> 		opp-peak-KBps = <3051>;
> 		opp-avg-KBps = <915>;
> 	};
> 	gpu_ddr_7500: opp-7500 {
> 		opp-peak-KBps = <7500>;
> 		opp-avg-KBps = <3000>;
> 	};
> };

Who is going to use the above tables and how ? These are the maximum
BW available over these paths, right ?

> gpu_opp_table: gpu_opp_table {
> 	compatible = "operating-points-v2";
> 	opp-shared;
> 
> 	opp-200000000 {
> 		opp-hz = /bits/ 64 <200000000>;
> 	};
> 	opp-400000000 {
> 		opp-hz = /bits/ 64 <400000000>;
> 	};
> };

Shouldn't this link back to the above tables via required-opp, etc ?
How will we know how much BW is required by the GPU device for all the
paths ?

> gpu@7864000 {
> 	...
> 	operating-points-v2 = <&gpu_opp_table>, <&gpu_cache_opp_table>, <&gpu_ddr_opp_table>;
> 	interconnects = <&mmnoc MASTER_GPU_1 &bimc SLAVE_SYSTEM_CACHE>,
> 			<&mmnoc MASTER_GPU_1 &bimc SLAVE_DDR>;
> 	interconnect-names = "gpu-cache", "gpu-mem";
> 	interconnect-opp-table = <&gpu_cache_opp_table>, <&gpu_ddr_opp_table>
> };

-- 
viresh
