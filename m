Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15274A8317
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2019 14:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729910AbfIDMhp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Sep 2019 08:37:45 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:52671 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbfIDMhp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Sep 2019 08:37:45 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190904123743euoutp0299a9ff1a92714af63643479e68ea6a63~BPH_AZDUF0786307863euoutp02I
        for <linux-pm@vger.kernel.org>; Wed,  4 Sep 2019 12:37:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190904123743euoutp0299a9ff1a92714af63643479e68ea6a63~BPH_AZDUF0786307863euoutp02I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1567600663;
        bh=yZLCbqKVi9Hs06e9qc3/1f9Heb7upU8Fu+6TMyHC/vo=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=dHjeXkVM8Gw2Kk5MqD3+92QtRGeF91rT5l7SZ5aBrmfy3ZFoAx3KlwidQka33jRG5
         WbsFbXcMpie/O552ErZTanOHDaX3lA9XqqUiY0xJbFbOZsvoHzFvfYzruTVDV+WhVe
         Q1CUhkTMqGoZq8b+DBJjIK4Ooti6lFw50wc5hqzw=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190904123742eucas1p28bd5e121274d4c892f407674c960308f~BPH9UZ89C0909709097eucas1p2z;
        Wed,  4 Sep 2019 12:37:42 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id DB.1D.04374.610BF6D5; Wed,  4
        Sep 2019 13:37:42 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190904123741eucas1p1cdc036f1d841accce579f762d1130c96~BPH8ddrDr0994209942eucas1p1G;
        Wed,  4 Sep 2019 12:37:41 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190904123741eusmtrp2262ad688f2a83690e15b780748b3bed5~BPH8PVgeT1156311563eusmtrp2j;
        Wed,  4 Sep 2019 12:37:41 +0000 (GMT)
X-AuditID: cbfec7f5-92d689c000001116-e2-5d6fb016f89c
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id F4.D1.04166.510BF6D5; Wed,  4
        Sep 2019 13:37:41 +0100 (BST)
Received: from [106.120.51.75] (unknown [106.120.51.75]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190904123740eusmtip1c12d0a0433e2d181c1b4ae6b5ae4e5dd~BPH7i7pLO0237302373eusmtip1e;
        Wed,  4 Sep 2019 12:37:40 +0000 (GMT)
Subject: Re: [PATCH v2 0/9] Exynos Adaptive Supply Voltage support
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>, krzk@kernel.org,
        robh+dt@kernel.org, vireshk@kernel.org, devicetree@vger.kernel.org,
        kgene@kernel.org, pankaj.dubey@samsung.com,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, b.zolnierkie@samsung.com
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-ID: <4e6379a7-0d4b-8e0d-c225-49976b2587e0@samsung.com>
Date:   Wed, 4 Sep 2019 14:37:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190820092113.gojhe3romdnvm7eu@vireshk-i7>
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUhTURzGO7svu66uHKfpH5OiJYRFlrYPNxKpCBpBYVQQysiVFzPn226z
        rA+uQst36U0bC0XE5bB8mWnZMpjmssJZkSQaDZ3gS/viHGGG5rxKfvs9z/855/wfOAwh76PC
        mbTMK7wuU6NV0DKyo29+YE9oS5Z6X7NhO9da3UxxNb0DFFcxPkNwTmeLlGsbH6K4r10mmvOW
        9SKu2tkt4Z71/pBydS/mpFzBm14p1+pTcVZXH32IVbVZimjV6JCNVlnr81Xl7Rak8rZtTaAS
        ZXEpvDYtl9ftjU+WXaqfcaPsX/iax2xGBvSBLUYBDGAlWMcKiGIkY+T4KYKKiZFVMYfgo62T
        EoUXgf2HQ7p2ZKqiTyIOzAiMPVYkCg8C63wp7U8F4yNgW/AtM8OE4F0wNcz7bQJ/k0CXb4Vp
        HANl78qRn1kcD/emKwk/kzgSuusGV/zN+BzMunooMRME/Y/dpJ8D8AEwOmZp8c4wuDXXSIm8
        DTo9JkJcdEwKhps5Ih+FWusHWuRgmHa0r5aJgKVXNStlAN9GUPp6RCqKSgQ/HbVITB2EHsdn
        yl+GwFHQ3LVXtA9DQ9Mo8tuAA+G7J0jcIRDudVQRos3C3UK5mI6EBUuVRORwKHEvkZVIYVzX
        zLiujXFdG+P/d2sRaUFhvF7ISOWF/Zn81WhBkyHoM1OjL2ZltKHl3/Vx0eF7ibr/XrAjzCDF
        Jtb1JEstpzS5Ql6GHQFDKELYszatWs6maPKu87qs8zq9lhfsaAtDKsLYGxtcSXKcqrnCp/N8
        Nq9bm0qYgHAD2l12ejSRJzfPAR3rDl1MmGyQNeME3/AjidQVt3/nn2rTUODxfki+rHyvHdh4
        wHVCOXWqxjGoL4ltGmedTtPxyZTRabP39EvWE9VYKKnLM5vsN858OmnjnXdytOnH4pT38y8K
        E0X7nA/0O9S/+zvVg/FfcpPUg89DJx6SEW8VpHBJE7OL0Amafztk4alZAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJIsWRmVeSWpSXmKPExsVy+t/xu7qiG/JjDVadU7XYOGM9q8X8I+dY
        Lfofv2a2OH9+A7vFpsfXWC0u75rDZvG59wijxYzz+5gs1h65y26xaOsXdovWvUfYLTZ+9bDY
        /OAYmwOvx6ZVnWwed67tYfPYvKTeo2/LKkaPz5vkAlij9GyK8ktLUhUy8otLbJWiDS2M9Awt
        LfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DKWvH7CWPBGoOLt8uWMDYyneLsYOTkkBEwk
        XvYfY+pi5OIQEljKKPH150zWLkYOoISUxPwWJYgaYYk/17rYIGpeM0psODSJCSQhLOAksef3
        VzaQehEBLYmXN1NBapgFrjJJLN5ziQWioYFV4vK5G+wgDWwChhK9R/sYQWxeATuJSa8mMIPY
        LAIqEvsWXQCLiwpESBzeMQuqRlDi5MwnLCA2p4ClxKzjn9hAbGYBdYk/8y4xQ9jiEk1fVrJC
        2PIS29/OYZ7AKDQLSfssJC2zkLTMQtKygJFlFaNIamlxbnpusaFecWJucWleul5yfu4mRmC0
        bjv2c/MOxksbgw8xCnAwKvHwPpibHyvEmlhWXJl7iFGCg1lJhDd0T06sEG9KYmVValF+fFFp
        TmrxIUZToOcmMkuJJucDE0leSbyhqaG5haWhubG5sZmFkjhvh8DBGCGB9MSS1OzU1ILUIpg+
        Jg5OqQZGjsnlN97LNMpl/syrEX79RkMi6aJfVlX2doWpQnPqO91ZHib/nVyivCzpzds3ZuyM
        82Zt/ftTMf7158h5xz8/97e80BB+o0PlrLeLyb6jZ34xBggUmpk9Fnrb8pBZOvTynsap3x6l
        7Zc+4isns83oiMn26SprCqtO2XPMLji029Ar/SO/zpnlSizFGYmGWsxFxYkAkCSn4+wCAAA=
X-CMS-MailID: 20190904123741eucas1p1cdc036f1d841accce579f762d1130c96
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190820092123epcas2p2170ae19467a5fb19fcfc1acdbecf9381
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190820092123epcas2p2170ae19467a5fb19fcfc1acdbecf9381
References: <20190723020450.z2pqwetkn2tfhacq@vireshk-i7>
        <5ef302a4-5bbf-483d-dfdf-cf76f6f69cee@samsung.com>
        <20190725022343.p7lqalrh5svxvtu2@vireshk-i7>
        <562dd2e7-2b24-8492-d1c1-2dc4973f07be@samsung.com>
        <20190819090928.pke6cov52n4exlbp@vireshk-i7>
        <b831d7c5-c830-fd65-20cf-02e209889c28@samsung.com>
        <20190819112533.bvfyinw7fsebkufr@vireshk-i7>
        <b7093aaf-ea56-c390-781f-6f9d0780bd8e@samsung.com>
        <20190820030114.6flnn2omeys3lih3@vireshk-i7>
        <06ccff05-2152-4bcc-7537-8f24da75f163@samsung.com>
        <CGME20190820092123epcas2p2170ae19467a5fb19fcfc1acdbecf9381@epcas2p2.samsung.com>
        <20190820092113.gojhe3romdnvm7eu@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 8/20/19 11:21, Viresh Kumar wrote:
> On 20-08-19, 11:03, Sylwester Nawrocki wrote:
>> On 8/20/19 05:01, Viresh Kumar wrote:
>>> Sorry but I am unable to understand the difficulty you are facing now. So what I
>>> suggest is something like this.
>>
>> The difficulty was about representing data from tables asv_{arm,kfc}_table[][]
>> added in patch 3/9 of the series in devicetree.  If you have no objections
>> about keeping those tables in the driver then I can't see any difficulties. 
> 
> The problem with keeping such tables in kernel is that they contain too much
> magic values which very few people understand. And after some amount of time,
> even they don't remember any of it.
>
> What I was expecting was to remove as much of these tables as possible and do
> the calculations to get them at runtime with some logical code which people can
> understand later on.

It might be indeed far from a good design but this is all what we get from the 
SoC vendor. AFAIU those tables are generated based on data from the production
process, likely from some measurements.

I am afraid I will not get more information for that fairly old SoCs in order to 
replace those tables with some sensible code generating the data programmatically,
I'm not sure it would be at all possible to do.

I could add some more comments, similar to description as in my previous RFC 
DT binding (https://patchwork.kernel.org/patch/10886013).

The tables are rather simple, it's mostly all voltage values, only selecting 
values per each frequency and chip revision might get a bit complex. 
I'm not sure we could change that now though.
>> Then IIUC what I would need to change is to modify exynos_asv_update_cpu_opps() 
>> function in patch 3/9 to use dev_pm_opp_adjust_voltage() rather than 
>> dev_pm_opp_remove(), dev_pm_opp_add().
> 
> That and somehow add code to get those tables if possible.

I have changed the code to use dev_pm_opp_adjust_voltage(). I was wondering 
though, what did you mean by "triplet" when commenting on this patch
https://patchwork.kernel.org/patch/11092245 ?

-- 
Regards,
Sylwester
