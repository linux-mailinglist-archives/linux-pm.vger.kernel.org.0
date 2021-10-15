Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 179C942EB0E
	for <lists+linux-pm@lfdr.de>; Fri, 15 Oct 2021 10:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236379AbhJOIKC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Oct 2021 04:10:02 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:64072 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236638AbhJOIKA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Oct 2021 04:10:00 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20211015080749epoutp04fbfdb6dba5642ee6654fd7473c5ae10a~uJcsoYsm30938909389epoutp046
        for <linux-pm@vger.kernel.org>; Fri, 15 Oct 2021 08:07:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20211015080749epoutp04fbfdb6dba5642ee6654fd7473c5ae10a~uJcsoYsm30938909389epoutp046
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1634285269;
        bh=7Byz6yHaFyOlmUCVCF6GE7hQH0GcypoytV5GiyWBWl4=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=prjZVTYvd0bWvtJhnYI4TToCigs/YMBfOH/sn9GagYDJJsFvc0DDq22AqnbqCXAod
         qMZDk1eGe+dCrvjXun6dqi/5YpIfEDJmMTottOS1URT2zZjGQGf+O2j8DI/qFgKZy4
         /7pbuEhYL8J5GORvzq6/SFnnwvP3BOlPyrw00P2A=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20211015080748epcas1p4761a8b0969435ed1eade41fe27965b98~uJcrrUD2b0145601456epcas1p4S;
        Fri, 15 Oct 2021 08:07:48 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.38.236]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4HVzQT0TbMz4x9Q8; Fri, 15 Oct
        2021 08:07:29 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        1E.42.24398.5B639616; Fri, 15 Oct 2021 17:07:17 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20211015080716epcas1p2a5d55913228043d0034623f33b8a2235~uJcORftPN1459114591epcas1p26;
        Fri, 15 Oct 2021 08:07:16 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20211015080716epsmtrp2cf6bfe09c3a7f4114f0e812204825dcb~uJcOLUyuv0472204722epsmtrp2c;
        Fri, 15 Oct 2021 08:07:16 +0000 (GMT)
X-AuditID: b6c32a35-0edff70000005f4e-88-616936b56761
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        A0.92.08750.4B639616; Fri, 15 Oct 2021 17:07:16 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20211015080716epsmtip2210df3418359de6cbbd6e6d521b23c98~uJcNx_eGJ1330313303epsmtip2d;
        Fri, 15 Oct 2021 08:07:16 +0000 (GMT)
Subject: Re: [PATCH v2 6/6] PM / devfreq: Add a driver for the sun8i/sun50i
 MBUS
To:     Samuel Holland <samuel@sholland.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <b6650bd2-7459-2604-f6ff-6eb6df739412@samsung.com>
Date:   Fri, 15 Oct 2021 17:28:45 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20211004012739.39053-7-samuel@sholland.org>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPJsWRmVeSWpSXmKPExsWy7bCmnu5Ws8xEg7k7ZC3mHznHavF8/jpG
        i7NNb9gtNj2+xmpxedccNovPvUcYLabs28Vm0da5jNXi4ilXi9uNK9gsWvceYbd4/qiTzeLf
        tY0sFj8PnWdy4PN4f6OV3WPDo9WsHjtn3WX32LSqk81j85J6jxebZzJ69G1Zxejx6utcRo/P
        m+QCOKOybTJSE1NSixRS85LzUzLz0m2VvIPjneNNzQwMdQ0tLcyVFPISc1NtlVx8AnTdMnOA
        bldSKEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX2CqlFqTkFJgW6BUn5haX5qXr5aWWWBkaGBiZ
        AhUmZGecm7OApeAuZ8XMFR2MDYw32bsYOTgkBEwkWvYmdjFycQgJ7GCUeLLqGROE84lRYu/9
        g+wQzmdGif4vbxm7GDnBOnp+vIdK7GKU+H56OSOE855RYlnzXzaQKmGBIIndd6aDVYkITGSS
        mH3/AAuIwyzwllFi4a4dzCBVbAJaEvtf3ADr4BdQlLj64zHYDl4BO4mPT08zgdgsAqoSjTNf
        sIPYogJhEie3tUDVCEqcnPmEBcTmFLCUmLC2D6yeWUBc4taT+VC2vMT2t3OYQRZLCLzgkNg4
        dzUbxBMuEqdv7WCCsIUlXh3fwg5hS0l8frcXqqZaYuXJI2wQzR2MElv2X2CFSBhL7F86mQkU
        fswCmhLrd+lDhBUldv6eywixmE/i3dceVkgQ80p0tAlBlChLXH5wF2qtpMTi9k62CYxKs5C8
        MwvJC7OQvDALYdkCRpZVjGKpBcW56anFhgWG8PhOzs/dxAhO2VqmOxgnvv2gd4iRiYPxEKME
        B7OSCO+7A+mJQrwpiZVVqUX58UWlOanFhxhNgQE8kVlKNDkfmDXySuINTSwNTMyMjE0sDM0M
        lcR5j722TBQSSE8sSc1OTS1ILYLpY+LglGpg6pPepX55gsrE8K0Na3ZoFalOe1pWdmzq/g+x
        q0RsDh14W3h2/1Hp5b/eKs22nqba+m6jvXsSg2BmiPincEPtkKQHbz/8MdNh99RODvk6b/nZ
        z/Im/pp/OK/2H0/c8IxBtJ87m4+jeuH6KuvN9cIv2xkPKSkcW5fr9PRHy4Mpb55wrZ3h8m7i
        1FuaJodKnFfu4fj6wsTDXPVp+iSmDdfDGLwarm/Z7VRVvbhnvkjnwYA7NxUjPh4Se2zk/e13
        K4v767y4iEuPii9ek13O6rDmcPVU4RMKGg/Z+gKl1aZmbd10Y9bPF/eufDj7fHZrp/yNlXO2
        rmP+qPfVY+N6XWX3zZ+aVvD+0DSNaWHWrOdpuaLEUpyRaKjFXFScCADjc84kYgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJIsWRmVeSWpSXmKPExsWy7bCSvO4Ws8xEg7lzJS3mHznHavF8/jpG
        i7NNb9gtNj2+xmpxedccNovPvUcYLabs28Vm0da5jNXi4ilXi9uNK9gsWvceYbd4/qiTzeLf
        tY0sFj8PnWdy4PN4f6OV3WPDo9WsHjtn3WX32LSqk81j85J6jxebZzJ69G1Zxejx6utcRo/P
        m+QCOKO4bFJSczLLUov07RK4Ms7NWcBScJezYuaKDsYGxpvsXYycHBICJhI9P96D2UICOxgl
        3vyNhYhLSky7eJS5i5EDyBaWOHy4uIuRC6jkLaPEiTvtTCA1wgJBErvvTGcHSYgITGaSOLn1
        OBOIwwxS9erCdUaIlt2MEltWXWUBaWET0JLY/+IGG4jNL6AocfXHY0YQm1fATuLj09NgY1kE
        VCUaZ74AO0lUIExi55LHTBA1ghInZz4Bm8MpYCkxYW0fWJxZQF3iz7xLzBC2uMStJ/Oh4vIS
        29/OYZ7AKDwLSfssJC2zkLTMQtKygJFlFaNkakFxbnpusWGBUV5quV5xYm5xaV66XnJ+7iZG
        cOxqae1g3LPqg94hRiYOxkOMEhzMSiK87w6kJwrxpiRWVqUW5ccXleakFh9ilOZgURLnvdB1
        Ml5IID2xJDU7NbUgtQgmy8TBKdXA1DRnTdana6fWnHf8ujBw7X350MXveLQ1RRs/mDmu4jT9
        Kq5oxLhgekzIc8O8y7EhQvLvG3dVO/+1XXKZLXpW2CmrzuOxNU+fainGPdrbfXJ12J+z9g6L
        9jyom/qu/rjousWbv3Xl+L2X0V5g4rggRKkvMUPl+hfBe9MVmgLuLZj2vWjHi4kr+sueR2tv
        /ph/4fnmeq7Htvlabv7PPhwxaem5+o2zJid+rnaB27NPQsb7TJYXN2grfvV2mv7G01jHmal5
        wtbpaxz6GqY+5ilINm6u+Xn6pgBLz7l435treD3ki2Iivda7LHkq+orhzsQNFn4rU42m2hv8
        T4+x+zEpubFgupQml9OEfM1HZXlLlFiKMxINtZiLihMByaHgWkwDAAA=
X-CMS-MailID: 20211015080716epcas1p2a5d55913228043d0034623f33b8a2235
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20211004012806epcas1p1ba8ec0edc024a14e520865f689773be8
References: <20211004012739.39053-1-samuel@sholland.org>
        <CGME20211004012806epcas1p1ba8ec0edc024a14e520865f689773be8@epcas1p1.samsung.com>
        <20211004012739.39053-7-samuel@sholland.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Samuel,

On 10/4/21 10:27 AM, Samuel Holland wrote:
> This driver works by adjusting the divider on the DRAM controller's
> module clock. Thus there is no fixed set of OPPs, only "full speed" down
> to "quarter speed" (or whatever the maximum divider is on that variant).
> 
> It makes use of the MDFS hardware in the MBUS, in "DFS" mode, which
> takes care of updating registers during the critical section while DRAM
> is inaccessible.
> 
> This driver should support several sunxi SoCs, starting with the A33,
> which have a DesignWare DDR3 controller with merged PHY register space
> and the matching MBUS register layout (so not A63 or later). However,
> the driver has only been tested on the A64/H5, so those are the only
> compatibles enabled for now.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>  drivers/devfreq/Kconfig          |   8 +
>  drivers/devfreq/Makefile         |   1 +
>  drivers/devfreq/sun8i-a33-mbus.c | 511 +++++++++++++++++++++++++++++++
>  3 files changed, 520 insertions(+)
>  create mode 100644 drivers/devfreq/sun8i-a33-mbus.c


(snip)

Looks good to me.

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
