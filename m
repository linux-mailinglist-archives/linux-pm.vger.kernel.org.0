Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 728151EF962
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jun 2020 15:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbgFENhf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Jun 2020 09:37:35 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:33190 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726553AbgFENhe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Jun 2020 09:37:34 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200605133732euoutp02edca7c1e7eaa5a67a871404ccc2d3d17~VqVtLk6e20283902839euoutp02r
        for <linux-pm@vger.kernel.org>; Fri,  5 Jun 2020 13:37:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200605133732euoutp02edca7c1e7eaa5a67a871404ccc2d3d17~VqVtLk6e20283902839euoutp02r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1591364252;
        bh=GqvW2tQC08sXw+G0mGmq/sXjJLEW03BVa+8mrEYgc44=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=QyKv1WS/gG3EZ6xV0YeYF8izriwUMTnMkzFTq3HxfO+ipR1aEFPqbryxC2xGhQczl
         o7WXmunjQS1VLmcDqJx1Tm7oF8dH/1aZBlDwtU956nNZMpho0GVrZVjSrcIRei6IPd
         ubkrlnfdcRu7RQqM7i+dYsYmKMRZdtCeLFYMmkk8=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200605133732eucas1p2a3620273c1748164a583ce681b2c53ee~VqVsjtB8k3269132691eucas1p2N;
        Fri,  5 Jun 2020 13:37:32 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 6C.A1.60698.C9A4ADE5; Fri,  5
        Jun 2020 14:37:32 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200605133731eucas1p1f1605330060112d0150b80384e91f0b9~VqVr2-pkM3012530125eucas1p1F;
        Fri,  5 Jun 2020 13:37:31 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200605133731eusmtrp2f7015bea0b46213130647a3f9118d36d~VqVr2KH722071820718eusmtrp2C;
        Fri,  5 Jun 2020 13:37:31 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-27-5eda4a9c1e71
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id A8.1C.08375.B9A4ADE5; Fri,  5
        Jun 2020 14:37:31 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200605133730eusmtip277d8900cc7df8fbb787106c575c52494~VqVrAD0Up1074310743eusmtip2P;
        Fri,  5 Jun 2020 13:37:30 +0000 (GMT)
Subject: Re: [PATCH] regulator: do not balance 'boot-on' coupled regulators
 without constraints
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Dmitry Osipenko <digetx@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, peron.clem@gmail.com,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        linux-samsung-soc@vger.kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Saravana Kannan <saravanak@google.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <2f0e021d-387a-4693-882d-aba66e20dd2b@samsung.com>
Date:   Fri, 5 Jun 2020 15:37:32 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200605102018.GA5413@sirena.org.uk>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01SbUhTYRTu3b27uxtOrrPaSfugWYFBpinxYhEV/bj0o8SIKNJcdjFpauz6
        WRRikbayT0SbWhaJOtPcktI+DIc5ZbplmqkpbmlakURpflRmbVfLf895znPOeR44NKEYEfvQ
        sfGJnDZerVFRMvJh45R9XcHOnshAx2cPbMy7L8Y5zkEKvxkbFuPyrwMI2+1VEuwo7Bbh8Y4s
        EW5/XEDh0ewGhPPsdSL8ebJVhN/ebCdxi/WVGOvM0xT+3WkkcVbDOIGN39mtXmytvk/CFpmS
        WJPhPMX2dj6l2MvTgWz160ySvVRtQKyl65GIHTUtD5MekG0+wmlikznt+i1RsqMDuY3o+LRH
        anNJE5mOKmU6JKWBCYGpziaxDsloBVOKYOjuICEUYwgeWMtEQjGKwPZ8mJgbye13IhdWMCUI
        +ir3CKIvCMqyW90Nb0YNGTUDEhdeyPjB64lnpAsTTAcJPeZwF6aYINCN6CgXljNboGim/i+m
        aZJZBdX6gy56ERMBl4qLZiVe0Hxj0L1GymyA2vFskbByBTwaKSAErISewVtu08DcoKHw+lWJ
        YHoHtL2/MBvAGz5Zqmf5pTBTOzdwBoHTViERiosI2jPykKDaBL22H253BOMP9x+vF+ht8CKn
        wk0D4wldI16CCU+49jCXEGg5ZJ1TCOo1oLdU/jtb//IVcQWp9POi6efF0c+Lo/9/twiRBqTk
        kvi4GI4PjudSAnh1HJ8UHxMQnRBnQn+f0Prb8r0G1f06bEYMjVQe8qrVPZEKsTqZT4szI6AJ
        1UL59lZrpEJ+RJ12gtMmHNImaTjejHxpUqWUB9/5GKFgYtSJ3DGOO85p57oiWuqTjixBYaF9
        xX0ThqhlbMRpcYiqpl/r/zSFP7k7dciWuMR4sDF/V2mxPFNjQr5NAS3deRc3hwe2EQbvSVNb
        vqOyJJIKXXBm6lu5NnrxVz+DciJ9lTOt9+TllB+7dT+xo36lo2pbpz3TPnr7neas48PGiv3G
        9IpT0qjme2XX9jYuebJPRfJH1UFrCS2v/gPivEQ8gAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgleLIzCtJLcpLzFFi42I5/e/4Pd3ZXrfiDHr3SFlsnLGe1WLqwyds
        Fte/PGe1WP3xMaPF+fMb2C0ezL3JZPHtSgeTxeVdc9gsPvceYbSYcX4fk8WbH2eZLG7Pu8xi
        ceb0JVaLrkN/2Sz+XdvIYtFx5BuzxcavHg6CHjtn3WX3WLCp1GPTqk42jzvX9rB59P818Nhy
        tZ3Fo2/LKkaP4ze2M3l83iQXwBmlZ1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwea2Vk
        qqRvZ5OSmpNZllqkb5egl/F4+jHGgr88FSeXn2BpYFzH1cXIySEhYCIx/f5Dxi5GLg4hgaWM
        EgcXzWWDSMhInJzWwAphC0v8udbFBlH0llHi0LpDYAlhgUSJph2P2UFsEQFliavf97KAFDEL
        XGORmLPkIhNIQkhgB6PEntlgDWwChhJdb7vANvAK2Eks+H8QyObgYBFQkdgyKwYkLCoQK/Ht
        3haoEkGJkzOfsIDYnAJGEju/9YKNZBYwk5i3+SEzhC0vsf3tHChbXOLWk/lMExiFZiFpn4Wk
        ZRaSlllIWhYwsqxiFEktLc5Nzy021CtOzC0uzUvXS87P3cQIjP1tx35u3sF4aWPwIUYBDkYl
        Ht4I5VtxQqyJZcWVuYcYJTiYlUR4nc6ejhPiTUmsrEotyo8vKs1JLT7EaAr020RmKdHkfGBa
        yiuJNzQ1NLewNDQ3Njc2s1AS5+0QOBgjJJCeWJKanZpakFoE08fEwSnVwBhwQOiik7PGQZ1J
        F5+4zjGY2ZLv/O/VmR15G57cn7JSx2Wi67qDu9g/xx25YVG4RlAxY+vOm7/c5qRJnXq8ZcqZ
        NQJnnYJ8Lwaes/6hdHuT3cqZ15l1tYue3F+8SjX3rFmLrvuduVd2R5u+5mZTjMw5sytvcpPQ
        hh1+J4+lGbEv53hwZWOvtdIMJZbijERDLeai4kQA9xXZ8hMDAAA=
X-CMS-MailID: 20200605133731eucas1p1f1605330060112d0150b80384e91f0b9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200605063729eucas1p288dd9d3acdb62cc86745cb6af5c31fc6
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200605063729eucas1p288dd9d3acdb62cc86745cb6af5c31fc6
References: <CGME20200605063729eucas1p288dd9d3acdb62cc86745cb6af5c31fc6@eucas1p2.samsung.com>
        <20200605063724.9030-1-m.szyprowski@samsung.com>
        <20200605102018.GA5413@sirena.org.uk>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Mark,

On 05.06.2020 12:20, Mark Brown wrote:
> On Fri, Jun 05, 2020 at 08:37:24AM +0200, Marek Szyprowski wrote:
>
>> Balancing of the 'boot-on' coupled regulators must wait until the clients
>> set their constraints, otherwise the balancing code might change the
> No, this is not what boot-on means at all.  It is there for cases where
> we can't read the enable status from the hardware.  Trying to infer
> *anything* about the runtime behaviour from it being present or absent
> is very badly broken.

Okay, what about the 'always-on' property? I don't think that we need 
another property for annotating this behavior, as in my opinion this is 
just an implementation issue on the Linux kernel and regulator 
framework. Alternatively I can drop the property check, but then it 
won't be possible to have a regulator without a consumer, which follows 
the other one (although we still don't have a real use case for it).

If you don't like this idea at all, I will try to move this logic to the 
custom coupler again, although it would mean some code copying.

> Saravana (CCed) was working on some patches which tried to deal with
> some stuff around this for enables using the sync_state() callback.
> Unfortunately there's quite a few problems with the current approach
> (the biggest one from my point of view being that it's implemented so
> that it requires every single consumer of every device on the PMIC to
> come up but there's others at more of an implementation level).
I'm not sure if we really need such complex solution for this...

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

