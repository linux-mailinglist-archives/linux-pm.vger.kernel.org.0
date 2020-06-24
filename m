Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE1B2076EB
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jun 2020 17:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404275AbgFXPLi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Jun 2020 11:11:38 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:39122 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404135AbgFXPLh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Jun 2020 11:11:37 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200624151135euoutp01b4437904ede30da48680d559d51e73d9~bg4Pd26JY0582705827euoutp01d
        for <linux-pm@vger.kernel.org>; Wed, 24 Jun 2020 15:11:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200624151135euoutp01b4437904ede30da48680d559d51e73d9~bg4Pd26JY0582705827euoutp01d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1593011495;
        bh=vIfCBmSC+5GtsPYmRCTd8QesuVfaXVykkj6k7TxHWDA=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=d3Kbk6jeUH/b2U8aGb6xc4Ya2Uv1ARZ/vt/zcpb2yKnIdwyifNi/aogKF9wSFjcCY
         0UfDxG+a4xfJBK1wYPPkNn1fpcJoTsVSCoacjsNacSk8Wvt/SunvyW8qmvUbe6HS+j
         yKx9sbNPfvw1rxIj4PokZL2Z4apGM1W75Z0Drnp0=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200624151135eucas1p1335bb5b1799513a14a8efb3d455078b2~bg4PLTJKl1469014690eucas1p1P;
        Wed, 24 Jun 2020 15:11:35 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id BF.7B.06456.72D63FE5; Wed, 24
        Jun 2020 16:11:35 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200624151134eucas1p1c70eef4c8ed9fd2fb0275cbec6576f44~bg4O0FaiQ1265612656eucas1p1Q;
        Wed, 24 Jun 2020 15:11:34 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200624151134eusmtrp1dfb6c70903341241eeeae3dbab271a31~bg4OzaZn01873818738eusmtrp1I;
        Wed, 24 Jun 2020 15:11:34 +0000 (GMT)
X-AuditID: cbfec7f2-7efff70000001938-e6-5ef36d270ac2
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id D9.72.06017.62D63FE5; Wed, 24
        Jun 2020 16:11:34 +0100 (BST)
Received: from [106.210.123.115] (unknown [106.210.123.115]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200624151134eusmtip11cc243e141c704390f7521bb388feef3~bg4OEgzT22683126831eusmtip1N;
        Wed, 24 Jun 2020 15:11:33 +0000 (GMT)
Subject: Re: brocken devfreq simple_ondemand for Odroid XU3/4?
To:     Lukasz Luba <lukasz.luba@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Willy Wolff <willy.mh.wolff.ml@gmail.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kukjin Kim <kgene@kernel.org>, linux-pm@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-ID: <ef5184ed-00ff-4226-5ece-b0fc8eb16fb6@samsung.com>
Date:   Wed, 24 Jun 2020 17:11:33 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <85f5a8c0-7d48-f2cd-3385-c56d662f2c88@arm.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCKsWRmVeSWpSXmKPExsWy7djP87rquZ/jDPqv81hc//Kc1aL/8Wtm
        i/PnN7BbnG16w26x6fE1VovLu+awWXzuPcJoMeP8PiaLhU0t7Ba3G1ewWXw78YjRgdtjzbw1
        jB47Z91l99i0qpPNY/OSeo++LasYPT5vkgtgi+KySUnNySxLLdK3S+DKOHj1OGvBbr6KtdfX
        sTYw3uPuYuTkkBAwkdjZ+5Kli5GLQ0hgBaPEufOv2CCcL4wS75uamSGcz4wSfzZ0ssK0NP9b
        DNWynFGiv+k6E4TzkVFi8afjTCBVwgJ2EvOv7QLrEBGolLg18zvYXGaBt0wSe/7eZgNJsAkY
        SvQe7WMEsXmBGm63dQI1c3CwCKhKzPymBBIWFYiV6Fu6gA2iRFDi5MwnLCA2p4C1xJJZb8F2
        MQuIS9x6Mh/KlpfY/nYO2NkSArfYJb5fOQd1tovE6huNzBC2sMSr41vYIWwZidOTe1ggGpoZ
        JXp232aHcCYwStw/voARospa4s65X2wg1zELaEqs36UPEXaUeHvsDTNIWEKAT+LGW0GII/gk
        Jm2bDhXmlehoE4KoVpH4vWo6E4QtJdH95D/LBEalWUhem4XknVlI3pmFsHcBI8sqRvHU0uLc
        9NRiw7zUcr3ixNzi0rx0veT83E2MwLR1+t/xTzsYv15KOsQowMGoxMO74cHHOCHWxLLiytxD
        jBIczEoivE5nT8cJ8aYkVlalFuXHF5XmpBYfYpTmYFES5zVe9DJWSCA9sSQ1OzW1ILUIJsvE
        wSnVwDhb0UHT0/UAK3/VOm3V7m+XtZsTomtu/szcWuNd5620QvC4628e+TRr1TLX1pslDCbX
        mexyjjtzCuo2LTpkeIth46zQKQ83CRkFZq9bzn0lau39+tvZSS2MTkbpy542X72iufcMc/8e
        +dNFbKd8en9N2HLHOW/366qaaR/qJ2yw6knJcZ38UImlOCPRUIu5qDgRAI2LKFhXAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCIsWRmVeSWpSXmKPExsVy+t/xu7pquZ/jDN41m1hc//Kc1aL/8Wtm
        i/PnN7BbnG16w26x6fE1VovLu+awWXzuPcJoMeP8PiaLhU0t7Ba3G1ewWXw78YjRgdtjzbw1
        jB47Z91l99i0qpPNY/OSeo++LasYPT5vkgtgi9KzKcovLUlVyMgvLrFVija0MNIztLTQMzKx
        1DM0No+1MjJV0rezSUnNySxLLdK3S9DLOHj1OGvBbr6KtdfXsTYw3uPuYuTkkBAwkWj+t5il
        i5GLQ0hgKaPEm/5WIIcDKCElMb9FCaJGWOLPtS42EFtI4D2jxMzp7iC2sICdxPxru1hBbBGB
        Son7P+8wg8xhFnjPJPH3xEwmiKGrmSSOvVoJ1s0mYCjRe7SPEcTmBeq+3dbJBLKMRUBVYuY3
        sGWiArES3+5tYYMoEZQ4OfMJC4jNKWAtsWTWWyYQm1lAXeLPvEvMELa4xK0n86Hi8hLb385h
        nsAoNAtJ+ywkLbOQtMxC0rKAkWUVo0hqaXFuem6xkV5xYm5xaV66XnJ+7iZGYIxuO/Zzyw7G
        rnfBhxgFOBiVeHg3PPgYJ8SaWFZcmXuIUYKDWUmE1+ns6Tgh3pTEyqrUovz4otKc1OJDjKZA
        v01klhJNzgemj7ySeENTQ3MLS0NzY3NjMwslcd4OgYMxQgLpiSWp2ampBalFMH1MHJxSDYzp
        7T/VVRL5E0yePJPhEOwMUTx9xN9tRlaOpkfuKvfe6nk9xWdTMu4/WvYztTZm24Kfx5fbL1Ta
        F5F4Onf5hwtcU14WXl166ZFiyQxLVsnjLpdZNZZUMnTHfmc4eIHbXpnhf0Eow6RlDuZi9y34
        Um4HpEy8X1MSpCfxp8xPiWdeWtSMu6tfvVFiKc5INNRiLipOBACBoft/5wIAAA==
X-CMS-MailID: 20200624151134eucas1p1c70eef4c8ed9fd2fb0275cbec6576f44
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200624103308eucas1p188a5fe3cee1916d9430c9971c2dab3a3
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200624103308eucas1p188a5fe3cee1916d9430c9971c2dab3a3
References: <20200623164733.qbhua7b6cg2umafj@macmini.local>
        <CAJKOXPeLuq81NC2xZh3y32EB-_APbDAchZD4OW_eCgQKKO+p8w@mail.gmail.com>
        <20200623191129.GA4171@kozik-lap>
        <CGME20200624103308eucas1p188a5fe3cee1916d9430c9971c2dab3a3@eucas1p1.samsung.com>
        <85f5a8c0-7d48-f2cd-3385-c56d662f2c88@arm.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi All,

On 24.06.2020 12:32, Lukasz Luba wrote:
> I had issues with devfreq governor which wasn't called by devfreq
> workqueue. The old DELAYED vs DEFERRED work discussions and my patches
> for it [1]. If the CPU which scheduled the next work went idle, the
> devfreq workqueue will not be kicked and devfreq governor won't check
> DMC status and will not decide to decrease the frequency based on low
> busy_time.
> The same applies for going up with the frequency. They both are
> done by the governor but the workqueue must be scheduled periodically.

As I have been working on resolving the video mixer IOMMU fault issue
described here: https://patchwork.kernel.org/patch/10861757
I did some investigation of the devfreq operation, mostly on Odroid U3.

My conclusions are similar to what Lukasz says above. I would like to add
that broken scheduling of the performance counters read and the devfreq 
updates seems to have one more serious implication. In each call, which
normally should happen periodically with fixed interval we stop the counters, 
read counter values and start the counters again. But if period between 
calls becomes long enough to let any of the counters overflow, we will
get wrong performance measurement results. My observations are that 
the workqueue job can be suspended for several seconds and conditions for 
the counter overflow occur sooner or later, depending among others 
on the CPUs load.
Wrong bus load measurement can lead to setting too low interconnect bus 
clock frequency and then bad things happen in peripheral devices.

I agree the workqueue issue needs to be fixed. I have some WIP code to use
the performance counters overflow interrupts instead of SW polling and with 
that the interconnect bus clock control seems to work much better.

-- 
Regards,
Sylwester
