Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC41521CD
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2019 06:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbfFYEK7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Jun 2019 00:10:59 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43282 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbfFYEK7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Jun 2019 00:10:59 -0400
Received: by mail-pl1-f193.google.com with SMTP id cl9so8061932plb.10
        for <linux-pm@vger.kernel.org>; Mon, 24 Jun 2019 21:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WhRE5I+VNZGCoUBaxMbI4Od/sWraEBpUeY2juijKEG0=;
        b=CweMukdbhQlsigDWluCViQbmqKgyaxfS34dX9w771cwI3Hf3xULECQBsU1EtuZhqhI
         zUZGLq58EjaE2vGXVecXMI2v08ZhIU4esluIgOM6pfTlUcs2reC9PQGFAu+GfLIyynZp
         N9Y6ZEkxKQc6WokUMgJ4s9woUnBdUfDzMl6XSV99/eaVQcumbkPibBMM4xE6iloG7lcD
         lGzKrrs3ef9lEeRR5rmgHja3fQeJUi6uj+EuSrUznfERnmBK9JzLHEzHsZgnArixJQfq
         m4/90jLs8Wcztgg7gF2UO98KTthInN+mz5z6OanA004gpxFQ02Ml/YGDKl8IFH3Sl8hg
         0T6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WhRE5I+VNZGCoUBaxMbI4Od/sWraEBpUeY2juijKEG0=;
        b=WNxbxUinRWF9vJjM2OMmAfgAjY0zu5K5Mavip2JtTjpwEspVtraKZBXwjeBoYXsbZX
         dE+zjfVataXF5s73WtbWWcuUO8Qxbq9LatKqLz3xtyDVGSpVsEPW8dN3l7s2uzty4vLh
         aB5FoXVZIxFt/BJ3NLeY67q/YDx9Awg2GVOze5+WPQ9iIsvmIE+YCXIrUu6YoXrXkGpa
         ipybpImTYiyqeKUCmDJEt1bATP4FcH/lc7tL93rZPxYLDkaqS75GethMBa7e4M6Va4rZ
         AzTvdEpAo598TAcbS6O2G4vzP9O7bJ3cV1ywKd9JD7JXd2zmI1nHrKV2o/iZtXnsUd3V
         0onQ==
X-Gm-Message-State: APjAAAVKGzIJsljf3a6lpfSnkf/HnHQl2K+JeP1/Wmk8JoxDJ+dkowYO
        suGwVbD5/eyorAuCzbAXfLmgXA==
X-Google-Smtp-Source: APXvYqwuvJ+cGsSoEVo728fguFKP5vudi02Rk2JQbkF6MKhfnZ3qgvM7yfLpmFMfkn8SLTCEKaA0RQ==
X-Received: by 2002:a17:902:7041:: with SMTP id h1mr5817739plt.133.1561435858318;
        Mon, 24 Jun 2019 21:10:58 -0700 (PDT)
Received: from localhost ([122.172.211.128])
        by smtp.gmail.com with ESMTPSA id l2sm11028290pff.107.2019.06.24.21.10.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 21:10:56 -0700 (PDT)
Date:   Tue, 25 Jun 2019 09:40:54 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Android Kernel Team <kernel-team@android.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 0/3] Add required-opps support to devfreq passive gov
Message-ID: <20190625041054.2ceuvnuuebc6hsr5@vireshk-i7>
References: <20190622003449.33707-1-saravanak@google.com>
 <20190624094349.rtjb7nuv6g7zmsf2@vireshk-i7>
 <CAGETcx_ggG8oDnAVaSfuHfip1ozjQpFiGs15cz8nLQnzjTiSTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGETcx_ggG8oDnAVaSfuHfip1ozjQpFiGs15cz8nLQnzjTiSTg@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 24-06-19, 15:17, Saravana Kannan wrote:
> Here's an example. This can't be done today, but can be done with this change.
> 
> In arch/arm64/boot/dts/exynos/exynos5433-bus.dtsi you have something
> like this with the following changes:
> 
>         bus_g2d_400: bus0 {
>                 compatible = "samsung,exynos-bus";
>                 clocks = <&cmu_top CLK_ACLK_G2D_400>;
>                 clock-names = "bus";
>                 operating-points-v2 = <&bus_g2d_400_opp_table>;
>                 status = "disabled";
>         };
> 
>         bus_noc2: bus9 {
>                 compatible = "samsung,exynos-bus";
>                 clocks = <&cmu_mif CLK_ACLK_BUS2_400>;
>                 clock-names = "bus";
>                 operating-points-v2 = <&bus_noc2_opp_table>;
>                 status = "disabled";
>         };

And what is the relation between these two busses ?

>         bus_g2d_400_opp_table: opp_table2 {
>                 compatible = "operating-points-v2";
>                 opp-shared;
> 
>                 opp-400000000 {
>                         opp-hz = /bits/ 64 <400000000>;
>                         opp-microvolt = <1075000>;
> +                       required-opps = <&noc2_400>;
>                 };
>                 opp-267000000 {
>                         opp-hz = /bits/ 64 <267000000>;
>                         opp-microvolt = <1000000>;
> +                       required-opps = <&noc2_200>;
>                 };
>                 opp-200000000 {
>                         opp-hz = /bits/ 64 <200000000>;
>                         opp-microvolt = <975000>;
> +                       required-opps = <&noc2_200>;
>                 };
>                 opp-160000000 {
>                         opp-hz = /bits/ 64 <160000000>;
>                         opp-microvolt = <962500>;
> +                       required-opps = <&noc2_134>;
>                 };
>                 opp-134000000 {
>                         opp-hz = /bits/ 64 <134000000>;
>                         opp-microvolt = <950000>;
> +                       required-opps = <&noc2_134>;
>                 };
>                 opp-100000000 {
>                         opp-hz = /bits/ 64 <100000000>;
>                         opp-microvolt = <937500>;
> +                       required-opps = <&noc2_100>;
>                 };
>         };
> 
>         bus_noc2_opp_table: opp_table6 {
>                 compatible = "operating-points-v2";
> 
> -               opp-400000000 {
> +               noc2_400: opp-400000000 {
>                         opp-hz = /bits/ 64 <400000000>;
>                 };
> -               opp-200000000 {
> +               noc2_200: opp-200000000 {
>                         opp-hz = /bits/ 64 <200000000>;
>                 };
> -               opp-134000000 {
> +               noc2_134: opp-134000000 {
>                         opp-hz = /bits/ 64 <134000000>;
>                 };
> -               opp-100000000 {
> +               noc2_100: opp-100000000 {
>                         opp-hz = /bits/ 64 <100000000>;
>                 };
>         };
> 
> Thanks,
> Saravana

-- 
viresh
