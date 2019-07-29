Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1774F78884
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2019 11:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387419AbfG2Jft (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Jul 2019 05:35:49 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45007 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387416AbfG2Jfs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Jul 2019 05:35:48 -0400
Received: by mail-pf1-f196.google.com with SMTP id t16so27699309pfe.11
        for <linux-pm@vger.kernel.org>; Mon, 29 Jul 2019 02:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9x4q40YNu8PZPNIMOeH6iHYV/NmKq4shqC8DBZn6n2U=;
        b=psnZBQy5CgQsotR4fjYCVbWm7lutJhGnn3FiudticeJjy8OTsBbRe5kJQF/0SLksPF
         +DCS0kbRS1PtOXIM06h4Zun8Hs0X42Sa4GCi7iNowPoK5X4BtcDqMC/JjTmrCvt+/d8v
         5kS9pj9ElrVzNRiPBNUeML71Zhfp9QytXreocsBrrUfMNMhfR6KdH33Jm6eLW8O+8o3m
         4Ic1xMZw30pKqBBm9StqhcPddXoBnkvCXoIJ9FnqFWYJdnKQ7BKVoXrj1R9erq/zualR
         S5U1dBfR4Ylz10h8cUeXHA23eZ3zRCpfPly0Ii96aXm58AFxqsU4gJhLVDpnm2TceAMx
         R6Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9x4q40YNu8PZPNIMOeH6iHYV/NmKq4shqC8DBZn6n2U=;
        b=HFOMebvlU/7qhtyq2JGTa3LyXJXXMSwzxX2TC2vLeti8o0JPQmdyn8DiKwS0mBQE6A
         wn8sCZnpCAUPDcY4g2HC29hOQ4/Z/sjVOtcbEwwgyp8el9amt4JmPhCtS4wZavsPf6CF
         jylXa+dbtK8yiZzZscUTcoelwQDGA3sPghw19mGrIm3/zBgZmbUtMFaeZv62Y+jy1XNz
         TyKzkugCGtXbbV47rF1r2xJ+6CGj384RsiJnlGhSTWU7sMAV8oU5p123pzgp2cttlsmJ
         bxEZTj/2j9WFNbfzUin71KEXzgzgfSsvxWChH9Vk5hrph25uQoqSBP1K3IHjuY/1v1KV
         Qlfw==
X-Gm-Message-State: APjAAAXEVFC0ffY+hFCfbKYUdjMd0RqG/femQQNkUXQ/Yba5Ar0czU6A
        vrzugLLPPyvCRcsrsecaV+hu9A==
X-Google-Smtp-Source: APXvYqwqE1NvATylQ7IseTvLry6NpXjoeNxFl451clxTeXz3oSDy1YnxOVHkLgnx4/YzllHFERrdoQ==
X-Received: by 2002:aa7:8b10:: with SMTP id f16mr36090070pfd.44.1564392948016;
        Mon, 29 Jul 2019 02:35:48 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id c70sm6172721pfb.36.2019.07.29.02.35.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 02:35:47 -0700 (PDT)
Date:   Mon, 29 Jul 2019 15:05:45 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        vincent.guittot@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, adharmap@codeaurora.org,
        Rajendra Nayak <rnayak@codeaurora.org>, sibis@codeaurora.org,
        bjorn.andersson@linaro.org, evgreen@chromium.org,
        kernel-team@android.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/3] Introduce Bandwidth OPPs for interconnects
Message-ID: <20190729093545.kvnqxjkyx4nogddk@vireshk-i7>
References: <20190726231558.175130-1-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190726231558.175130-1-saravanak@google.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 26-07-19, 16:15, Saravana Kannan wrote:
> Interconnects and interconnect paths quantify their performance levels in
> terms of bandwidth and not in terms of frequency. So similar to how we have
> frequency based OPP tables in DT and in the OPP framework, we need
> bandwidth OPP table support in DT and in the OPP framework.
> 
> So with the DT bindings added in this patch series, the DT for a GPU
> that does bandwidth voting from GPU to Cache and GPU to DDR would look
> something like this:
> 
> gpu_cache_opp_table: gpu_cache_opp_table {
> 	compatible = "operating-points-v2";
> 
> 	gpu_cache_3000: opp-3000 {
> 		opp-peak-KBps = <3000000>;
> 		opp-avg-KBps = <1000000>;
> 	};
> 	gpu_cache_6000: opp-6000 {
> 		opp-peak-KBps = <6000000>;
> 		opp-avg-KBps = <2000000>;
> 	};
> 	gpu_cache_9000: opp-9000 {
> 		opp-peak-KBps = <9000000>;
> 		opp-avg-KBps = <9000000>;
> 	};
> };
> 
> gpu_ddr_opp_table: gpu_ddr_opp_table {
> 	compatible = "operating-points-v2";
> 
> 	gpu_ddr_1525: opp-1525 {
> 		opp-peak-KBps = <1525000>;
> 		opp-avg-KBps = <452000>;
> 	};
> 	gpu_ddr_3051: opp-3051 {
> 		opp-peak-KBps = <3051000>;
> 		opp-avg-KBps = <915000>;
> 	};
> 	gpu_ddr_7500: opp-7500 {
> 		opp-peak-KBps = <7500000>;
> 		opp-avg-KBps = <3000000>;
> 	};
> };
> 
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
> 
> gpu@7864000 {
> 	...
> 	operating-points-v2 = <&gpu_opp_table>, <&gpu_cache_opp_table>, <&gpu_ddr_opp_table>;
> 	...
> };

One feedback I missed giving earlier. Will it be possible to get some
user code merged along with this ? I want to make sure anything we add
ends up getting used.

That also helps understanding the problems you are facing in a better
way, i.e. with real examples.

-- 
viresh
