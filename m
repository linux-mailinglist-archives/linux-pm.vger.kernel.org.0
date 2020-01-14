Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09BE313A76A
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2020 11:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729399AbgANKey (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Jan 2020 05:34:54 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37088 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727285AbgANKey (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jan 2020 05:34:54 -0500
Received: by mail-pf1-f196.google.com with SMTP id p14so6385744pfn.4
        for <linux-pm@vger.kernel.org>; Tue, 14 Jan 2020 02:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6WEFAP/ApgeJPueS6Gwwt3D0c6EozVsVjbD7xwCYDMU=;
        b=jwYJRLnx31hznR5hOFu8AioG9hqIqaf7k2DcfPbD3O8HfcTL9Q4y5r7HAQ7I5Rd/JX
         nq08HH8qf7mLFDLvXFIY6+ZPUZSzszeUAy0KJOKzW6+2HqLumlMhF0FdUiCRe+10goY5
         +zbSgzWFwO21bcTFU/LWVACI19dkAwqLmY/2JmPN4k/zzHFUVsEYoRSZI/ZR/mF6nCqZ
         vOLikz16Cx7JZFlC4SiZzzott0saT9FrIynGeQxSYHERd9Whw3B5FGclUPkbn4Q/IQhI
         Vvlinrd6GIxLe4Z9JSG022SbvfOqP6rziyhdl9ki1hPjHscOyYJm4iIE4Qt7590Bzhfk
         9W6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6WEFAP/ApgeJPueS6Gwwt3D0c6EozVsVjbD7xwCYDMU=;
        b=n5PwtxPSTP4DkZlKpJWL+SANzauRGOa9kkhaM4Uh85r1P6YKJ3su/SL6HHkX6tBdh3
         uPQbzi/P3kdQHKi5l9YS6xToa6J6hx7sPp7tX+CsGP45gM/VQka+IvwPDQp9lkYr50p0
         57ynwQNRRR6ebe3UbQqDmaQVrtN9bWdXhcnbxPaYpnMqHJnBYmlsXyB8rU1SdKLGuMgP
         X0AkEwYJraeeXB4YWPQWo1vhxiWvszFRHAOyoHtvbSE7OS/LNJ42NZAwzhuMT1S32bRt
         yM/YchpHvJagybbNruvKVIfW9+qUv2aLNkNSnTrhenYwk7DzHj2qXXnaxmqqLvqpvBNm
         4Qew==
X-Gm-Message-State: APjAAAX9ZZl9B01g3pxBFP2lDufoVVVQquvsHsgifaVVWJlztweRz64N
        vkphYjtJtX8FuJbfeyGQ1ASEwA==
X-Google-Smtp-Source: APXvYqxyC3sfXYgjfIHc/g5DWfKMYs4YAP31hjMYEZtc13r8kBnIiS+sBTrIKQKYIA9GFDXA3LMrEw==
X-Received: by 2002:a63:6e04:: with SMTP id j4mr25629136pgc.175.1578998092064;
        Tue, 14 Jan 2020 02:34:52 -0800 (PST)
Received: from localhost ([122.172.140.51])
        by smtp.gmail.com with ESMTPSA id m19sm16555830pjv.10.2020.01.14.02.34.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Jan 2020 02:34:51 -0800 (PST)
Date:   Tue, 14 Jan 2020 16:04:48 +0530
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
Subject: Re: [PATCH v6 0/3] Introduce Bandwidth OPPs for interconnects
Message-ID: <20200114103448.odnvqawnqb3twst5@vireshk-i7>
References: <20191207002424.201796-1-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191207002424.201796-1-saravanak@google.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 06-12-19, 16:24, Saravana Kannan wrote:
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

Okay, I got confused a bit again after some interaction with Sibi
today. The multiple phandle thing in the operating-points-v2 property
is there specifically for nodes that can provide multiple devices,
like PM domains where the provider may end up providing multiple
domains.

But I am not sure what you are going to do with the list of phandles
you have set for the GPU here.

We can not add multiple OPP tables for a single device right now.

-- 
viresh
