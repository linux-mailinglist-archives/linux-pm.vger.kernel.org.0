Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C01E55D7C
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2019 03:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726077AbfFZBbZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Jun 2019 21:31:25 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:63529 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfFZBbZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Jun 2019 21:31:25 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190626013122epoutp02449455ea271d9fc0d054242778814633~rm4MA4Ydq2340623406epoutp02e
        for <linux-pm@vger.kernel.org>; Wed, 26 Jun 2019 01:31:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190626013122epoutp02449455ea271d9fc0d054242778814633~rm4MA4Ydq2340623406epoutp02e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1561512682;
        bh=Il1LdZLD5oiDYRYYiHJZH9tmhj0oCguKH8iBAMUtDsw=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=HaforL3OyyziafSE3AAtuohzicPbMPvhX3ryMAR6mirWtN5K/PEXErW2EwHBj++rs
         pbtTm3JSausyrsmmQaK+J933xUHYLf7zn5RsmsIPf1/G/rIj/taFp2y85szyRHlkzL
         qC/SkGCWbu/OFhQNjtSEf2nNeBPoHarr8EzKHJD0=
Received: from epsmges1p1.samsung.com (unknown [182.195.40.157]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190626013120epcas1p156adfe77f254edb4f6509c5c7c5937f9~rm4JyOLXn0228102281epcas1p13;
        Wed, 26 Jun 2019 01:31:20 +0000 (GMT)
X-AuditID: b6c32a35-973ff7000000102b-58-5d12cae21491
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        4F.C9.04139.2EAC21D5; Wed, 26 Jun 2019 10:31:14 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH v2 4/4] PM / devfreq: Add required OPPs support to
 passive governor
Reply-To: myungjoo.ham@samsung.com
From:   MyungJoo Ham <myungjoo.ham@samsung.com>
To:     Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC:     Saravana Kannan <saravanak@google.com>,
        "kernel-team@android.com" <kernel-team@android.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20190625213337.157525-5-saravanak@google.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20190626013114epcms1p16c69c10cd3af6265a9efa2f9db8a2b3b@epcms1p1>
Date:   Wed, 26 Jun 2019 10:31:14 +0900
X-CMS-MailID: 20190626013114epcms1p16c69c10cd3af6265a9efa2f9db8a2b3b
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA12SbVBMYRTHPXvv3r3J8liLR4zNNYzMbHVldaMwwuxMoZk+ZWRddafSvtm7
        2whjdpC0ZKLIpDcjasJoN3Y3DR9WSW3rQ4iGmjTRmLHeivEyXnbbjca333Pmf87/nPMcEpNY
        iTAyR2vkDFpWTRFTcfu9CLl8qEuSHt3atYx544pgno6NCBmnQ8p4Dr8VMY9uVxLMaHEbYN5+
        9QiYbnePkLG4fhLMr14rzjQP3ifWhyrtrXahstZmUtoaiwjlzSeFuPLUzUag7HjmEChHbQtT
        RNtz47M5NpMzhHPaDF1mjjYrgUpKVSWqFKuiaTkdx8RS4VpWwyVQG5NT5Jtz1L4OqfA8Vm3y
        hVJYnqei1sYbdCYjF56t440JFKfPVOvj9JE8q+FN2qzIDJ1mNR0dvULhE+7KzX50oQHXl+L7
        PpSewczAgVlACIngSuRtb8YtYCopgU6A6quqRRZAkmI4E/10zvJrZsE0VGIbxv0sgRQy993F
        AvEodHzQDvxMQDm61dQ/XkcKhwCy148R/gcGnwPU8rtIGHATo/OFr/AAz0eO+lvj2SFwDbJe
        /ygKxGejvqvev/z+fg0IsBQVDHiCXc9Eg99awUSd82W/gzUPoN7ySyK/MYJHASq+WhYURaHu
        qk7Cz2K4Bbkt3vGGcLgEORuuBc02ok/tTwV+xqAMObyVmH8TGIxAN25HBSSLUMuPKjAxi9n6
        Q/Q/Y3A6evf55N95ndXDggAvRa7WuqB+AXKXX8RKAFXxb9cVk4wr/hnXAqwRzOH0vCaL42k9
        Pfl7bWD8XJcrnKDsYbILQBJQ08RmmSRdImTz+HyNCyASo6TiyyxMl4gz2fz9nEGnMpjUHO8C
        Ct/8p7Gw2Rk63/FrjSpasSImJoZZSa9S0DQ1V6wK7dshgVmskcvlOD1nmMgTkCFhZrDzYHNb
        t+XKpukyz7SWQs/A2kPnnuS6v3bfpTpjmx7o4oe/WG/sKoq7NwIGOvobjh1GHbLV1jcnei7X
        PG9qI+cltYtH+ns33EmqUyx7vPXAPPLlq0szug5FLp5St+3ite97rHXE6xO93oGhfJF6cWqB
        tLpZths7cnav271uc1ri4IsxCuezWXo5ZuDZP66QIeDEAwAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190625213358epcas4p2391bcf70b54646880cbb60eae8b73acf
References: <20190625213337.157525-5-saravanak@google.com>
        <20190625213337.157525-1-saravanak@google.com>
        <CGME20190625213358epcas4p2391bcf70b54646880cbb60eae8b73acf@epcms1p1>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

>Look at the required OPPs of the "parent" device to determine the OPP that
>is required from the slave device managed by the passive governor. This
>allows having mappings between a parent device and a slave device even when
>they don't have the same number of OPPs.
>
>Signed-off-by: Saravana Kannan <saravanak@google.com>
>---
> drivers/devfreq/governor_passive.c | 20 +++++++++++++++-----
> 1 file changed, 15 insertions(+), 5 deletions(-)

Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>

Cheers,
MyungJoo


