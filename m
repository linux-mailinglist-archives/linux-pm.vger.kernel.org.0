Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48E9BFC0FC
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2019 08:48:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726002AbfKNHsu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Nov 2019 02:48:50 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:40297 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbfKNHsu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Nov 2019 02:48:50 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20191114074847epoutp0191315505911d94321bb0eb5d2cdf719a~W9_9uRvnA0469004690epoutp01T
        for <linux-pm@vger.kernel.org>; Thu, 14 Nov 2019 07:48:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20191114074847epoutp0191315505911d94321bb0eb5d2cdf719a~W9_9uRvnA0469004690epoutp01T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1573717727;
        bh=Zo2LtsYBvCAQzN8XtOm3sysCq+agWzbqkEVs1ThcjaU=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=RPKLAI2LhABdX1mh7h2SXaseQffm/pOwyvTiqdvWxGPcMXIQOHpl7SvmjumeOzyPm
         q8ypNbPwPsOpoJzpA23yzgSaNVB7JQzdGm6DxOQjNnKXFKq8jYbwzdTt8GKZP/T+Ip
         NOzWlI9l8NZ6+fRsCDeOXr8F+IIz2RGfu6747ULs=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191114074847epcas1p2cff82f5b66dc71331cbdd84d1afabc46~W9_9SWOtc3054830548epcas1p2V;
        Thu, 14 Nov 2019 07:48:47 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.152]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 47DDBN52LWzMqYkY; Thu, 14 Nov
        2019 07:48:44 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        62.14.04135.4D60DCD5; Thu, 14 Nov 2019 16:48:36 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20191114074836epcas1p4117c1cba6bb4a0c8ce6b5e18987208a9~W9_zQqRYD0104201042epcas1p4r;
        Thu, 14 Nov 2019 07:48:36 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191114074836epsmtrp245cdd17fed9e050c624ece63e737f819~W9_zP1K672878028780epsmtrp2s;
        Thu, 14 Nov 2019 07:48:36 +0000 (GMT)
X-AuditID: b6c32a36-7e3ff70000001027-b2-5dcd06d4cea3
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B6.FA.25663.4D60DCD5; Thu, 14 Nov 2019 16:48:36 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191114074836epsmtip13ae9eef1e627788cd5cd2f53a0496dc5~W9_y-hJMB1210112101epsmtip1D;
        Thu, 14 Nov 2019 07:48:36 +0000 (GMT)
Subject: Re: [PATCH v4 0/5] Add required-opps support to devfreq passive gov
To:     Saravana Kannan <saravanak@google.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Sibi Sankar <sibis@codeaurora.org>, kernel-team@android.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <cb0d4aad-81e4-0b8d-40f2-7f58ef1e38d9@samsung.com>
Date:   Thu, 14 Nov 2019 16:54:21 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190724014222.110767-1-saravanak@google.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGJsWRmVeSWpSXmKPExsWy7bCmru4VtrOxBtMfylvs2C5icbbpDbvF
        5V1z2Cw+9x5htLjduILN4s2Ps0wWZ05fYrXoOvSXzeLftY0sFtcWvme12PzgGJsDt8e23dtY
        PS739TJ5LNhU6rFpVSebx5ar7SwefVtWMXocv7GdyePzJrkAjqhsm4zUxJTUIoXUvOT8lMy8
        dFsl7+B453hTMwNDXUNLC3MlhbzE3FRbJRefAF23zBygO5UUyhJzSoFCAYnFxUr6djZF+aUl
        qQoZ+cUltkqpBSk5BZYFesWJucWleel6yfm5VoYGBkamQIUJ2RnzOo+zFuxTr3jYsJCxgXGi
        XBcjJ4eEgInEhCV97F2MXBxCAjsYJWY/WcwMkhAS+MQocXd6GETiG6PEln0/2WA6fva0MEIk
        9jJKTDp4iwXCec8ocfzkfkaQKmEBH4kXi2exgiREBHqZJK6eegvWzixQKfFq82sWEJtNQEti
        /4sbYHF+AUWJqz8egzXzCthJdN3eywRiswioSjxu2wh0EweHqECExOmviRAlghInZz4BG8Mp
        YC0x+ecKFojx4hK3nsxngrDlJba/ncMMcoOEwDx2icV/+xkhXnCReHbyGTuELSzx6vgWKFtK
        4vO7vVBvVkusPHmEDaK5A+j//RdYIRLGEvuXTmYCOYhZQFNi/S59iLCixM7fcxkhFvNJvPva
        wwpSIiHAK9HRJgRRoixx+cFdJghbUmJxeyfbBEalWUjemYXkhVlIXpiFsGwBI8sqRrHUguLc
        9NRiwwIj5NjexAhOw1pmOxgXnfM5xCjAwajEw3tA9EysEGtiWXFl7iFGCQ5mJRHeKW+BQrwp
        iZVVqUX58UWlOanFhxhNgYE9kVlKNDkfmCPySuINTY2MjY0tTAzNTA0NlcR5HZcvjRUSSE8s
        Sc1OTS1ILYLpY+LglGpg5GZVr1f5aX3V78vCplWX/AR+OF6ZHrXP7MPy9NlJFleXZgcVTpzS
        t/6sDJNC/eTcgzK6MtMFzUJkwlbwufUsnH5oYUroTWf72sQ58/8/2ibt8PiRd2L21LPvqldc
        ZIq9FzdtmmtM64WAGkXWffuW+EVaanQz2l0vUC/v7liq9a0xbd/0XrMTSizFGYmGWsxFxYkA
        d/YX+dkDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPIsWRmVeSWpSXmKPExsWy7bCSnO4VtrOxBrMO8Vns2C5icbbpDbvF
        5V1z2Cw+9x5htLjduILN4s2Ps0wWZ05fYrXoOvSXzeLftY0sFtcWvme12PzgGJsDt8e23dtY
        PS739TJ5LNhU6rFpVSebx5ar7SwefVtWMXocv7GdyePzJrkAjigum5TUnMyy1CJ9uwSujHmd
        x1kL9qlXPGxYyNjAOFGui5GTQ0LAROJnTwsjiC0ksJtR4uJDRoi4pMS0i0eZuxg5gGxhicOH
        iyFK3jJKLPvkBGILC/hIvFg8ixXEFhHoZ5L40SQBYjMLVEqs+/2eqYuRC6i+j1Fi/olbYEVs
        AloS+1/cYAOx+QUUJa7+eAy2i1fATqLr9l4mEJtFQFXicdtGZhBbVCBC4vn2G1A1ghInZz5h
        AbE5BawlJv9cwQKxTF3iz7xLzBC2uMStJ/OZIGx5ie1v5zBPYBSehaR9FpKWWUhaZiFpWcDI
        sopRMrWgODc9t9iwwCgvtVyvODG3uDQvXS85P3cTIzgatbR2MJ44EX+IUYCDUYmHV0LiTKwQ
        a2JZcWXuIUYJDmYlEd4pb4FCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeeXzj0UKCaQnlqRmp6YW
        pBbBZJk4OKUaGCtn/bWXmvP3i8/KnHmtZ1+JvfnPufrVyjMtq0/nREo75G5jeLzjkWW3gpdy
        0m9bk+mpAXxPeVRFuFiPe0yTSu+Rv8t4+vCXXabp3Z3pZw6oG6TGum7Sd3QKZ76b5Vm0Vbzo
        0+zyBuvcMrN5Oqf8pvkusj2ocXarQouy4zf+bg+DpqZK7dwUJZbijERDLeai4kQABIEq8cIC
        AAA=
X-CMS-MailID: 20191114074836epcas1p4117c1cba6bb4a0c8ce6b5e18987208a9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190724014230epcas5p371a5fdee330f91a646d619fbcc024acf
References: <CGME20190724014230epcas5p371a5fdee330f91a646d619fbcc024acf@epcas5p3.samsung.com>
        <20190724014222.110767-1-saravanak@google.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Dear Saravana,

Any other progress of this series?

Regards,
Chanwoo Choi

On 7/24/19 10:42 AM, Saravana Kannan wrote:
> The devfreq passive governor scales the frequency of a "child" device based
> on the current frequency of a "parent" device (not parent/child in the
> sense of device hierarchy). As of today, the passive governor requires one
> of the following to work correctly:
> 1. The parent and child device have the same number of frequencies
> 2. The child device driver passes a mapping function to translate from
>    parent frequency to child frequency.
> 
> When (1) is not true, (2) is the only option right now. But often times,
> all that is required is a simple mapping from parent's frequency to child's
> frequency.
> 
> Since OPPs already support pointing to other "required-opps", add support
> for using that to map from parent device frequency to child device
> frequency. That way, every child device driver doesn't have to implement a
> separate mapping function anytime (1) isn't true.
> 
> Some common (but not comprehensive) reason for needing a devfreq passive
> governor to adjust the frequency of one device based on another are:
> 
> 1. These were the combination of frequencies that were validated/screened
>    during the manufacturing process.
> 2. These are the sensible performance combinations between two devices
>    interacting with each other. So that when one runs fast the other
>    doesn't become the bottleneck.
> 3. Hardware bugs requiring some kind of frequency ratio between devices.
> 
> For example, the following mapping can't be captured in DT as it stands
> today because the parent and child device have different number of OPPs.
> But with this patch series, this mapping can be captured cleanly.
> 
> In arch/arm64/boot/dts/exynos/exynos5433-bus.dtsi you have something
> like this with the following changes:
> 
> 	bus_g2d_400: bus0 {
> 		compatible = "samsung,exynos-bus";
> 		clocks = <&cmu_top CLK_ACLK_G2D_400>;
> 		clock-names = "bus";
> 		operating-points-v2 = <&bus_g2d_400_opp_table>;
> 		status = "disabled";
> 	};
> 
> 	bus_noc2: bus9 {
> 		compatible = "samsung,exynos-bus";
> 		clocks = <&cmu_mif CLK_ACLK_BUS2_400>;
> 		clock-names = "bus";
> 		operating-points-v2 = <&bus_noc2_opp_table>;
> 		status = "disabled";
> 	};
> 
> 	bus_g2d_400_opp_table: opp_table2 {
> 		compatible = "operating-points-v2";
> 		opp-shared;
> 
> 		opp-400000000 {
> 			opp-hz = /bits/ 64 <400000000>;
> 			opp-microvolt = <1075000>;
> 			required-opps = <&noc2_400>;
> 		};
> 		opp-267000000 {
> 			opp-hz = /bits/ 64 <267000000>;
> 			opp-microvolt = <1000000>;
> 			required-opps = <&noc2_200>;
> 		};
> 		opp-200000000 {
> 			opp-hz = /bits/ 64 <200000000>;
> 			opp-microvolt = <975000>;
> 			required-opps = <&noc2_200>;
> 		};
> 		opp-160000000 {
> 			opp-hz = /bits/ 64 <160000000>;
> 			opp-microvolt = <962500>;
> 			required-opps = <&noc2_134>;
> 		};
> 		opp-134000000 {
> 			opp-hz = /bits/ 64 <134000000>;
> 			opp-microvolt = <950000>;
> 			required-opps = <&noc2_134>;
> 		};
> 		opp-100000000 {
> 			opp-hz = /bits/ 64 <100000000>;
> 			opp-microvolt = <937500>;
> 			required-opps = <&noc2_100>;
> 		};
> 	};
> 
> 	bus_noc2_opp_table: opp_table6 {
> 		compatible = "operating-points-v2";
> 
> 		noc2_400: opp-400000000 {
> 			opp-hz = /bits/ 64 <400000000>;
> 		};
> 		noc2_200: opp-200000000 {
> 			opp-hz = /bits/ 64 <200000000>;
> 		};
> 		noc2_134: opp-134000000 {
> 			opp-hz = /bits/ 64 <134000000>;
> 		};
> 		noc2_100: opp-100000000 {
> 			opp-hz = /bits/ 64 <100000000>;
> 		};
> 	};
> 
> -Saravana
> 
> v3 -> v4:
> - Fixed documentation comments
> - Fixed order of functions in .h file
> - Renamed the new xlate API
> - Caused _set_required_opps() to fail if all required opps tables aren't
>   linked.
> v2 -> v3:
> - Rebased onto linux-next.
> - Added documentation comment for new fields.
> - Added support for lazy required-opps linking.
> - Updated Ack/Reviewed-bys.
> v1 -> v2:
> - Cached OPP table reference in devfreq to avoid looking up every time.
> - Renamed variable in passive governor to be more intuitive.
> - Updated cover letter with examples.
> 
> 
> Saravana Kannan (5):
>   OPP: Allow required-opps even if the device doesn't have power-domains
>   OPP: Add function to look up required OPP's for a given OPP
>   OPP: Improve required-opps linking
>   PM / devfreq: Cache OPP table reference in devfreq
>   PM / devfreq: Add required OPPs support to passive governor
> 
>  drivers/devfreq/devfreq.c          |   6 ++
>  drivers/devfreq/governor_passive.c |  20 ++++--
>  drivers/opp/core.c                 |  83 +++++++++++++++++++---
>  drivers/opp/of.c                   | 108 ++++++++++++++---------------
>  drivers/opp/opp.h                  |   5 ++
>  include/linux/devfreq.h            |   2 +
>  include/linux/pm_opp.h             |  11 +++
>  7 files changed, 165 insertions(+), 70 deletions(-)
> 
