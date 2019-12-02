Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18B4910E41E
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2019 02:07:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbfLBBHl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 1 Dec 2019 20:07:41 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:21931 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727266AbfLBBHk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 1 Dec 2019 20:07:40 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20191202010736epoutp01864cf99c22f75951df18ab7b869b21da~caH0bH7kq1117611176epoutp01F
        for <linux-pm@vger.kernel.org>; Mon,  2 Dec 2019 01:07:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20191202010736epoutp01864cf99c22f75951df18ab7b869b21da~caH0bH7kq1117611176epoutp01F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1575248856;
        bh=UkE7utluuyMhSecKy49iKbgRKNukxrR8skMg1MOl7Ww=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=RCszI+nVZ6qzo13bLF/GH1l7Mxj6D0bUk2etrvBWdTxw9ytyBQ4uQvYZVbZaYw/QW
         HP1Vx7/IUgbr3cCDcKEYZTqHLDkeLHOFdx6jBxfgPHa2BMiPBD5cgGvpcaWbbGPCjB
         +TjOA3Q61Nz4H9rvl0uoyleMGWXDsfWbNtyO0qqY=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191202010735epcas1p179a0d92920493c03f14269115dac3963~caHzxPN502865628656epcas1p19;
        Mon,  2 Dec 2019 01:07:35 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.158]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 47R6R91FF0zMqYm2; Mon,  2 Dec
        2019 01:07:33 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        82.6E.52419.DC364ED5; Mon,  2 Dec 2019 10:07:25 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20191202010724epcas1p3da6a7e192a91dc8f84f9164f0d3b9bd5~caHprx-pr2599525995epcas1p3o;
        Mon,  2 Dec 2019 01:07:24 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191202010724epsmtrp2d101414b322de4f9db1da8f0b7f8e4e4~caHpq7J6Z2289222892epsmtrp2l;
        Mon,  2 Dec 2019 01:07:24 +0000 (GMT)
X-AuditID: b6c32a37-59fff7000001ccc3-ea-5de463cd4df8
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C2.DD.10238.CC364ED5; Mon,  2 Dec 2019 10:07:24 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191202010724epsmtip225c311be6e818f5cd1390a043a1048b5~caHpZThhA2242022420epsmtip2Z;
        Mon,  2 Dec 2019 01:07:24 +0000 (GMT)
Subject: Re: [PATCH RFC 1/2] PM / devfreq: Add PM QoS support
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Jacky Bai <ping.bai@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <4615f751-d5d6-887f-cc9d-ec802f3c9c31@samsung.com>
Date:   Mon, 2 Dec 2019 10:13:41 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <f186aee7e7cc8f055d6cdebafe42a6293d44364d.1574179738.git.leonard.crestez@nxp.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01TbUxTVxjO6W3vvciqZ/XrHVkY3O2PZGivpXowYrbIlruMHyQzm9PUegM3
        LaFf6W3NwGTrDFPonKgLMUPI8CtWzCJ0CNXAGutnYYAwraKSzRUH2WaJa3BMNFnbyzL+Pe/z
        PO9587znHJbSTdE5bJXDI7kdoo2jF6m7L68qLBysmDDph/6mSeTaeYbMDPQjcqQvSJPh4Q6G
        DO75kyGB8ScaEozHNMT/7AxFkl9dQSTZEUfk/ucBmpwdukSTHwdGU2rkBU06Z4S3lgjTd79g
        hKO+EbXQFvQKwfYGWngQ66WF709+JnQmQirhUqJXJXTd3qcWDnS1IyEZzC3P3la90SqJlZI7
        T3JUOCurHJYS7v0PzJvNxnV6vpAvJuu5PIdol0q40rLywnerbKkkXN4u0eZNUeWiLHNrNm10
        O70eKc/qlD0lnOSqtLmKXatl0S57HZbVFU77Bl6vX2tMGXdWW0OBG5SrSfPJ6PmtPtSi9qMs
        FnAR1IV8lB8tYnU4hKDz5wCjFH8huNoTmVeeIjh4+CzyIzbT4rsICt+HINr/m0YpphFM3hqm
        0ucuxSXww/GAJo2X4U/hn+P+jInCTyiI3zqXEWhcAOGpu3QaL8H5cHs2jtJYizdBU+uYKo3V
        +A048fRI5tDl+EOIdtfNe16G6DcTmRBZeAfMxqczfgqvhHsT387j16DncUsmAuAYA8n+q4yS
        uhS+65mjFLwUfr/eNc/nQDLRRyt4N5yJXqGV5noEXeGbGkUwQPjU16r0Lii8Cs5dXKPQ+XBh
        rhUpgxdDYma/RlmXFur36hTL6/DTL+MqBb8CJ/Y10AcR17wgTvOCCM0LIjT/P6wNqdvRCskl
        2y2SzLsMC287iDKvvGB9CHUMlUUQZhH3klY/FTfpNOIuucYeQcBS3DLtHe6hSaetFGtqJbfT
        7PbaJDmCjKltH6Jyllc4U3/G4THzxrUGg4EU8euMPM+t1LKzIyYdtogeqVqSXJL7vz4Vm5Xj
        Q0X6BlNu1DvGW2Sr/c2PEoN78r2TBz6Oj0we09LZh3Zm773mqT8Zndv2XrFu86Pnp2Oxw3Xv
        RHrJlzX3LzSOT/+xw1dEL94+FvYZbW3OfPbXY3OcYXR/6yOzJ/xwqzhQ1t346s2pt68frd3S
        dIppGXuuKm3E280bquXS3NoaJpfh1LJV5Asotyz+CwgC/ej7AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEIsWRmVeSWpSXmKPExsWy7bCSvO6Z5CexBlMuqVgcOraV3eLr6VOM
        FtP3bmKzOH9+A7vF2aY37BYr7n5ktdj0+BqrRdevlcwWn3uPMFp83vCY0eJ24wo2i9XnDrJZ
        nDl9CSh76C+bxcavHg78Hu9vtLJ7zG64yOKxYFOpx6ZVnWwed67tYfPYvKTeY+O7HUweB9/t
        YfLYcrWdxaNvyypGj8+b5AK4o7hsUlJzMstSi/TtErgydqw4wVwwlbXi0taIBsY5LF2MHBwS
        AiYSDbskuhi5OIQEdjNKNE0+zt7FyAkUl5SYdvEoM0SNsMThw8UQNW8ZJWYeus4GUiMsYCux
        b9EKVhBbRKBO4tPvA4wgRcwCH5klDi5azAzR8YhR4s3JFUwgVWwCWhL7X9wA6+YXUJS4+uMx
        I4jNK2AnMXXuTbAaFgEVicXfpjOD2KICYRI7lzxmgqgRlDg58wkLiM0pECfx4/F7sDizgLrE
        n3mXmCFscYlbT+ZDxeUltr+dwzyBUXgWkvZZSFpmIWmZhaRlASPLKkbJ1ILi3PTcYsMCw7zU
        cr3ixNzi0rx0veT83E2M4JjW0tzBeHlJ/CFGAQ5GJR7ejlePY4VYE8uKK3MPMUpwMCuJ8F5X
        ehgrxJuSWFmVWpQfX1Sak1p8iFGag0VJnPdp3rFIIYH0xJLU7NTUgtQimCwTB6dUA6NR+qWj
        J/a0bM+K/u61fGppGmvcigDV03Lhu06InBMLX/n+ZPqenhPRHalNTn5vFJ0/HXmxz1ajSK7q
        cuP0VWyP/qRI8QdmFRUcvzWD44XZ4xvuEZJGt8zZcvQK9EOmzzPcUnPjoXiOz/n7Qc+OnJWa
        de/Prmldc3ffF7quXfC+oPrQdNXzN72VWIozEg21mIuKEwFy9ch55QIAAA==
X-CMS-MailID: 20191202010724epcas1p3da6a7e192a91dc8f84f9164f0d3b9bd5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191119161307epcas1p485934ab601ca59fc979bf8d2e1961892
References: <cover.1574179738.git.leonard.crestez@nxp.com>
        <CGME20191119161307epcas1p485934ab601ca59fc979bf8d2e1961892@epcas1p4.samsung.com>
        <f186aee7e7cc8f055d6cdebafe42a6293d44364d.1574179738.git.leonard.crestez@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11/20/19 1:12 AM, Leonard Crestez wrote:
> Register notifiers with the PM QoS framework in order to respond to
> requests for DEV_PM_QOS_MIN_FREQUENCY and DEV_PM_QOS_MAX_FREQUENCY.
> 
> No notifiers are added by this patch but PM QoS constraints can be
> imposed externally (for example from other devices).
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> ---
>  drivers/devfreq/devfreq.c | 77 +++++++++++++++++++++++++++++++++++++++
>  include/linux/devfreq.h   |  5 +++
>  2 files changed, 82 insertions(+)
> 

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

(snip)

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
