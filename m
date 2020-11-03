Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25CEB2A3A3E
	for <lists+linux-pm@lfdr.de>; Tue,  3 Nov 2020 03:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbgKCCI6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Nov 2020 21:08:58 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:38129 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbgKCCI4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Nov 2020 21:08:56 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20201103020852epoutp0348431a02260334b9293657d84c079ee4~D3Who54tC0470504705epoutp03R
        for <linux-pm@vger.kernel.org>; Tue,  3 Nov 2020 02:08:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20201103020852epoutp0348431a02260334b9293657d84c079ee4~D3Who54tC0470504705epoutp03R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1604369332;
        bh=MFuZlfb/Yn1FfDXGe9nnnS1LaE1d3HqlFqTNLWzKXtQ=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=CJihPDzySQyauHEF3YXWgGmeizM0KrqlnK6pBZ1JsZ4PMUoklju5445YtsFPKNGgi
         w/edSsEWMNxETNU5LlAZoHxRcg6auV4cRCOwxKolGf24+hbfpSDhwyQdUG9wZeDUs/
         b9l4U+bV4Pbc4kKqYZ/pacuY03259vVp6YNG1DMw=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20201103020852epcas1p29e1f632a9e5f1609e8e29b88e395b492~D3Wg9BiC12965429654epcas1p23;
        Tue,  3 Nov 2020 02:08:52 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.153]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4CQCrK3zz1zMqYmB; Tue,  3 Nov
        2020 02:08:49 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        97.20.09582.6ABB0AF5; Tue,  3 Nov 2020 11:08:38 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20201103020838epcas1p4496f5796cb600465f05b19c1ebce1098~D3WUBQ4TJ1044310443epcas1p4E;
        Tue,  3 Nov 2020 02:08:38 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20201103020838epsmtrp2f3a72ca2f9749d3e5bfed43c02794da4~D3WUAV_0X2405724057epsmtrp2A;
        Tue,  3 Nov 2020 02:08:38 +0000 (GMT)
X-AuditID: b6c32a37-899ff7000000256e-ff-5fa0bba68383
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        FD.C7.08745.5ABB0AF5; Tue,  3 Nov 2020 11:08:38 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20201103020837epsmtip17f8c1cb8b99ebd7ff1794daf1912910d~D3WTkkBsw2593625936epsmtip1g;
        Tue,  3 Nov 2020 02:08:37 +0000 (GMT)
Subject: Re: [PATCH v6 49/52] PM / devfreq: tegra20: Convert to EMC_STAT
 driver, support interconnect and device-tree
To:     Dmitry Osipenko <digetx@gmail.com>, cwchoi00@gmail.com
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Viresh Kumar <vireshk@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-tegra@vger.kernel.org,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <7ee7e7bb-6c0d-dfd1-f00d-a718c06d7479@samsung.com>
Date:   Tue, 3 Nov 2020 11:22:35 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <bff3bf4a-8111-7c96-92f6-46343d85be0d@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLJsWRmVeSWpSXmKPExsWy7bCmge6y3QviDWbu1rd4dlTb4t2np6wW
        84+cY7VY/fExo8WVr+/ZLKbv3cRm0TJrEYvF+fMb2C22Pl3DZHG26Q27xeVdc9gsPvceYbTo
        /DKLzeLiKVeL240r2CwmrZ3KaHH2mbdF694j7Bb/rm1ksfi5ax6LxeYHx9gcRD3e32hl99g5
        6y67x6Vzf5g9Nq3qZPO4c20Pm8f97uNMHr3N79g8+rasYvT4vEkugDMq2yYjNTEltUghNS85
        PyUzL91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMH6DslhbLEnFKgUEBicbGSvp1N
        UX5pSapCRn5xia1SakFKToFlgV5xYm5xaV66XnJ+rpWhgYGRKVBhQnbGlwU5BZM4KzZ+ms3c
        wLiUvYuRk0NCwERi6tsvbF2MXBxCAjsYJZ5Me8QC4XxilJg3ZwZYlZDAZ0aJCSc0YDpmHDzG
        ClG0i1Hi6dJt7BDOe0aJiQdXMoFUCQuUS5ybuYURxBYRsJL49QqiiFmgmU1i9ZUtzCAJNgEt
        if0vbrCB2PwCihJXfzwGa+AVsJN4cO0KkM3BwSKgIrFiZy5IWFQgTOLkthaoEkGJkzOfsIDY
        nAK2EifXLwG7lFlAXOLWk/lMELa8RPPW2cwQV8/nlDh+2ALCdpF4P+UxC4QtLPHq+BZoWEhJ
        fH63lw3CrpZYefIIOFwkBDoYJbbsv8AKkTCW2L90MhPIbcwCmhLrd+lDhBUldv6eywixl0/i
        3dceVpASCQFeiY42IYgSZYnLD+4yQdiSEovbO9kmMCrNQvLNLCQfzELywSyEZQsYWVYxiqUW
        FOempxYbFhgjx/UmRnC61zLfwTjt7Qe9Q4xMHIyHGCU4mJVEeGsi58UL8aYkVlalFuXHF5Xm
        pBYfYjQFBu9EZinR5HxgxskriTc0NTI2NrYwMTQzNTRUEuf9o90RLySQnliSmp2aWpBaBNPH
        xMEp1cB06GqHZUbc528e/v9W1WUdzePrlY+dMDVh69pYtYqQ5O2RyyR2P56R+8RQoDtQ+uTm
        VruvnFOnLstiXmdiYJXJ6qQmpnebb9/nFR8WPloy71cB8+47u3XUCn1sS0U/dO89abjblfl4
        kTr3otkZ2voei0qT5+4wfMS/7Y3UhFP/e5sXLLlV4d1v63b0sESP0bTaDVs1T3lLLrn9KusD
        t87VzO8r18+OW6X38WumJJP21rL1zlWWzsVfz/GeqHmv9pXLXeblhoBEc9PCZUpbM8+3enjL
        fyh+f91dVWDmGfeblR3P2+SeCQtbef5U/etWfnu1ws+gEHuePhu3E6eZ5xXdtLw/uXphzqRQ
        eYUbt4KUWIozEg21mIuKEwHlsQPXgAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJIsWRmVeSWpSXmKPExsWy7bCSnO6y3QviDXZMYbZ4dlTb4t2np6wW
        84+cY7VY/fExo8WVr+/ZLKbv3cRm0TJrEYvF+fMb2C22Pl3DZHG26Q27xeVdc9gsPvceYbTo
        /DKLzeLiKVeL240r2CwmrZ3KaHH2mbdF694j7Bb/rm1ksfi5ax6LxeYHx9gcRD3e32hl99g5
        6y67x6Vzf5g9Nq3qZPO4c20Pm8f97uNMHr3N79g8+rasYvT4vEkugDOKyyYlNSezLLVI3y6B
        K+PLgpyCSZwVGz/NZm5gXMrexcjJISFgIjHj4DHWLkYuDiGBHYwSixefZoFISEpMu3iUuYuR
        A8gWljh8uBii5i2jxNmtT5hAaoQFyiXOzdzCCGKLCFhJ/Hq1jR2kiFmgk03i3ooGFoiOh0wS
        LXc3g61jE9CS2P/iBhuIzS+gKHH1x2Owbl4BO4kH164wgmxjEVCRWLEzFyQsKhAmsXPJYyaI
        EkGJkzOfgB3HKWArcXL9ErCRzALqEn/mXWKGsMUlbj2ZzwRhy0s0b53NPIFReBaS9llIWmYh
        aZmFpGUBI8sqRsnUguLc9NxiwwKjvNRyveLE3OLSvHS95PzcTYzg2NfS2sG4Z9UHvUOMTByM
        hxglOJiVRHhrIufFC/GmJFZWpRblxxeV5qQWH2KU5mBREuf9OmthnJBAemJJanZqakFqEUyW
        iYNTqoFJrNssde/O+z2xW4I4o9esXq29aCrj73f/OkMeOopZTw+38G1p/Rob4ungGVdwcsfh
        BU5H/Q/GMjLeXeAz8//3xxttmDJX/+laKJnnHHL1zpLFnbaCi8Laf9VIXnv6K9Yk5V6x6+nf
        jKaGJyMVDhZW/NSJ+7+arWXBRqfes3/jOU+9yTJa+XSye0do5mfBpV/SvWbGfJ71+EHb7rrg
        9Wxac4QkWyxuSK2/YN6Szsd7d2FLo23Vp4aDho9chPKXlLF4x99svc3mMetZa9S95SvfH5HQ
        sFV6L+Y5uUdq27tp547XP2mc67Tb7dVWo8ZbkUul9mwI9Zp4XMhmoXD2pN97rIJyzreXL1J6
        d8Pmbj2vEktxRqKhFnNRcSIAXdvuBWwDAAA=
X-CMS-MailID: 20201103020838epcas1p4496f5796cb600465f05b19c1ebce1098
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20201102200839epcas1p30a5235333319f7affbe0f0c814ec3308
References: <20201025221735.3062-1-digetx@gmail.com>
        <20201025221735.3062-50-digetx@gmail.com>
        <CAGTfZH0KxyZYLZ_AgM7Lr+4s35kaWJp1AenpZ-o_FRLCCHC+6A@mail.gmail.com>
        <0ffa84f6-625e-807c-e9af-7a67f0fe48e7@gmail.com>
        <CGME20201102200839epcas1p30a5235333319f7affbe0f0c814ec3308@epcas1p3.samsung.com>
        <bff3bf4a-8111-7c96-92f6-46343d85be0d@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11/3/20 5:08 AM, Dmitry Osipenko wrote:
> 01.11.2020 17:12, Dmitry Osipenko пишет:
> ...
>> We will probably move the Tegra20 EMC_STAT devfreq driver into the
>> memory driver and remove the older IMC_STAT driver in v7, like it was
>> suggested by Thierry Reding. This will be a much less invasive code change.
>>
>>> Also, if you want to get more responsiveness, you could use delayed timer
>>> instead of deferrable timer by editing the devfreq_dev_profile structure.
>>
>> Thanks, I'll try the deferrable timer.
> 
> I took a brief look at the delayed timer and I think the deferrable
> timer should be more a preferred option because this devfreq drive is
> more an assistance for the optimal bandwidth selection and it will be
> more preferred to keep system idling whenever possible.
> 
> My primary concern is the initial performance lag in a case of
> multimedia applications. But this will be resolved by hooking up
> performance voting to all drivers, once we will get around to it.

OK. You can choice the type of timer on both probe
and via sysfs file on the runtime.


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
