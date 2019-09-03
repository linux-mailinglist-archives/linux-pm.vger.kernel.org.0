Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 461B0A611C
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2019 08:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbfICGOG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Sep 2019 02:14:06 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45071 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfICGOG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Sep 2019 02:14:06 -0400
Received: by mail-pl1-f194.google.com with SMTP id x3so2272135plr.12
        for <linux-pm@vger.kernel.org>; Mon, 02 Sep 2019 23:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=X56IDYGgH848OXVqS7siup3yiE3wR0xEVNMSreTqgdo=;
        b=y3AMEKKLSVUNqigZFRl6vqbivo8ONu2wWnALKLMDMc58mKXv8dt1WPoc5s1l7AoJkd
         bEd1/DYAizZBXBqpKoDvl0EwvbqFaBz5xRhAGLQZ7xmctZRSQ1LnS/PPfEZMDqiYjrOz
         J5oppKWr7CODmyaxen0zqJKrJYVK40EJM1RvSaQwkVQ0z3SBy6X41YZKS2wrAxRKC0gd
         B7bcAj3+Z9+/j+VwkhNq/gdzmyT5fuCFtrXdI1sANy1IuHwIolvMPMl9caZ6GZdzsGUf
         C4ByUzzvg9vWkZfp3cCL+GDvvMtxUe0f603Gm4VlXnGPwkXyFph0x0XaNn3I3vyu1b4Y
         uyrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=X56IDYGgH848OXVqS7siup3yiE3wR0xEVNMSreTqgdo=;
        b=s3ecBuYgnqt5gtF8YgGz2NxWqAiH3nDJXx8yxhL1QYkLtKS3+ZjkbDMFd4yRWvnoNe
         WdobtLCuy104JRgJclAhYtJB/3xsT5+eif2vKJOYUs/KuB0T8ZetuBxLwzQ/pDlghucE
         B+rZH9B7EO6DJuLBqbKTsJxnhPnvPvasLa1Yngzppttt+5aucKOyaJvGfa6NWTC8X3jO
         3R9Bj7wpnxsxzeLZ1ZZL5Ilk6+1j3iFNvlDxt6mQ9CYNzdC8/DQJMWdRpoX1K+og1luf
         WBKEaJRmAm/RIgGvqmvsXMCg1+4lGAxSszzqMXNuHh7zIU2uOnCgfIdGmzUQjXZ2wA62
         GZKw==
X-Gm-Message-State: APjAAAUtXS10BNel6R+GKW9sx5etgZEBARxV8Xs1Luz9pQ1rIBvMButT
        XCqLq/+YEabF8/Zvdk3wTNDMKw==
X-Google-Smtp-Source: APXvYqy2jgf96BPa+1HJhxpna1B7VYdeAxyhRykT9911XHflctDbHWllU730nibd82llGhzGl3E/gQ==
X-Received: by 2002:a17:902:1122:: with SMTP id d31mr34104469pla.254.1567491245848;
        Mon, 02 Sep 2019 23:14:05 -0700 (PDT)
Received: from localhost ([122.167.132.221])
        by smtp.gmail.com with ESMTPSA id p10sm18500683pff.132.2019.09.02.23.14.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Sep 2019 23:14:05 -0700 (PDT)
Date:   Tue, 3 Sep 2019 11:44:03 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Adam Ford <aford173@gmail.com>,
        =?utf-8?B?QW5kcsOp?= Roth <neolynx@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        letux-kernel@openphoenux.org, kernel@pyra-handheld.com
Subject: Re: [RFC 4/5] ARM: dts: omap3-n950-n9: remove opp-v1 table
Message-ID: <20190903061403.k3d333f54gj2kuxi@vireshk-i7>
References: <cover.1567421750.git.hns@goldelico.com>
 <2f978667c1533e46e3a5df58871e9048f3eb74e9.1567421751.git.hns@goldelico.com>
 <20190903023635.44yf32jowpm3hgfp@vireshk-i7>
 <8BC1AEC9-7B24-4C07-8659-16741D018164@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8BC1AEC9-7B24-4C07-8659-16741D018164@goldelico.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 03-09-19, 08:01, H. Nikolaus Schaller wrote:
> 
> > Am 03.09.2019 um 04:36 schrieb Viresh Kumar <viresh.kumar@linaro.org>:
> > 
> > On 02-09-19, 12:55, H. Nikolaus Schaller wrote:
> >> With opp-v2 in omap36xx.dtsi and ti-cpufreq driver the
> >> 1GHz capability is automatically detected.
> >> 
> >> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> >> ---
> >> arch/arm/boot/dts/omap3-n950-n9.dtsi | 7 -------
> >> 1 file changed, 7 deletions(-)
> >> 
> >> diff --git a/arch/arm/boot/dts/omap3-n950-n9.dtsi b/arch/arm/boot/dts/omap3-n950-n9.dtsi
> >> index 5441e9ffdbb4..e98b0c615f19 100644
> >> --- a/arch/arm/boot/dts/omap3-n950-n9.dtsi
> >> +++ b/arch/arm/boot/dts/omap3-n950-n9.dtsi
> >> @@ -11,13 +11,6 @@
> >> 	cpus {
> >> 		cpu@0 {
> >> 			cpu0-supply = <&vcc>;
> >> -			operating-points = <
> >> -				/* kHz    uV */
> >> -				300000  1012500
> >> -				600000  1200000
> >> -				800000  1325000
> >> -				1000000	1375000
> >> -			>;
> >> 		};
> >> 	};
> > 
> > This should be merged with 2/5 ?
> 
> Well, it bloats 2/5.

It is logically the right place to do this as that's where we are
adding opp-v2.

> What I hope (I can't test) is that this opp-v1 table
> is ignored if an opp-v2 table exists. So that it can be
> removed by a separate follow-up patch.

It should work as that's what we are doing in OPP core, but I still
feel this better get merged with 2/5.

-- 
viresh
