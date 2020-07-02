Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93055211B78
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jul 2020 07:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726003AbgGBFTn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Jul 2020 01:19:43 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:14466 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbgGBFTn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Jul 2020 01:19:43 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200702051939epoutp0139b8236a6e0e74e235a87d0d67c51fb7~d19sssWMP0259602596epoutp01m
        for <linux-pm@vger.kernel.org>; Thu,  2 Jul 2020 05:19:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200702051939epoutp0139b8236a6e0e74e235a87d0d67c51fb7~d19sssWMP0259602596epoutp01m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1593667179;
        bh=zmF5QSVq5UDkoxb9qTSNo2o/MBAjk8aZ5xjOTRB3H8A=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=pks2l2phggkyoMEereq8AxmzSr0u5wyrjLvRTLhHllxwoEtCoxaxMerbFvIlfLPoG
         0BD9BYJ0ZetlyM0peTf7ojmot6Ii8RYHJhiZjmt1zLKybEcS6ew6RvyqXJ7xlWOLwu
         aZeSDZ1t2o5ZbNq3aDCWt6Fua4Xumvtd0q7ZE4T4=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200702051938epcas1p114a89014ed1c5753e604e8e55cef0b92~d19rWOBnO0552605526epcas1p1K;
        Thu,  2 Jul 2020 05:19:38 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.153]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 49y5xg5f68zMqYlv; Thu,  2 Jul
        2020 05:19:35 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        97.DC.28578.56E6DFE5; Thu,  2 Jul 2020 14:19:33 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200702051933epcas1p111c52c4ed9fa37e9a1648335dba5e479~d19m_21WD0520905209epcas1p1E;
        Thu,  2 Jul 2020 05:19:33 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200702051933epsmtrp2102f67d785e96f30fcb2bae48e5ab982~d19m957ZE1271712717epsmtrp2e;
        Thu,  2 Jul 2020 05:19:33 +0000 (GMT)
X-AuditID: b6c32a39-e6f5da8000006fa2-9c-5efd6e65d48b
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B7.BE.08382.56E6DFE5; Thu,  2 Jul 2020 14:19:33 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200702051932epsmtip25824646da779bcc1c979a726e713af94~d19mmeBft2184521845epsmtip2f;
        Thu,  2 Jul 2020 05:19:32 +0000 (GMT)
Subject: Re: [PATCH v4 12/37] PM / devfreq: tegra20: Use MC timings for
 building OPP table
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>
Cc:     =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@samsung.com>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <2069fb51-f043-795d-7768-0024fc9a9f4e@samsung.com>
Date:   Thu, 2 Jul 2020 14:30:48 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <4b22d3ee-f303-d81d-e261-187d4a46e749@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHJsWRmVeSWpSXmKPExsWy7bCmgW5q3t84g9OLbCzuz2tltHj36Smr
        xfwj51gtVn98zGhx5et7NovpezexWbTMWsRicbbpDbvF5V1z2Cw+9x5htOj8MovN4uIpV4vb
        jSvYLCatncpo0br3CLvFv2sbWSx+7prH4iDo8f5GK7vHzll32T0unfvD7LFpVSebx51re9g8
        7ncfZ/LobX7H5tG3ZRWjx+dNcgGcUdk2GamJKalFCql5yfkpmXnptkrewfHO8aZmBoa6hpYW
        5koKeYm5qbZKLj4Bum6ZOUC/KCmUJeaUAoUCEouLlfTtbIryS0tSFTLyi0tslVILUnIKLAv0
        ihNzi0vz0vWS83OtDA0MjEyBChOyM27e/8decFuyYv1e9gbG1yJdjJwcEgImEjubbjJ2MXJx
        CAnsYJTYcWoCG4TziVHiZM9JdgjnG6PEm/v32WBaHr27ygSR2Msoce/LRRYI5z2jxI8nW5lB
        qoQFYiQmdc8AS4gIHGGWWN15HGwLs8BlRomzbV/AZrEJaEnsf3EDzOYXUJS4+uMxI4jNK2An
        8eTGBRYQm0VARWL9qSawGlGBMImT21qgagQlTs58AlbDKWArcfX1PbAaZgFxiVtP5jNB2PIS
        zVtnM0Pc3c4pse5EPoTtInHq3i8mCFtY4tXxLewQtpTE53d7of6sllh58gg4NCQEOhgltuy/
        wAqRMJbYv3QyUDMH0AJNifW79CHCihI7f89lhNjLJ/Huaw8rSImEAK9ER5sQRImyxOUHd6HW
        Skosbu9km8CoNAvJN7OQfDALyQezEJYtYGRZxSiWWlCcm55abFhgihzdmxjBCV3Lcgfj9Lcf
        9A4xMnEwHmKU4GBWEuE9bfArTog3JbGyKrUoP76oNCe1+BCjKTB8JzJLiSbnA3NKXkm8oamR
        sbGxhYmhmamhoZI4r5P1hTghgfTEktTs1NSC1CKYPiYOTqkGps1zXktMkLJsv+MR1nhC6viM
        8KAPiokuS8L+/TieW27IxaR07lY2Y88yf/POZJMlU1UMnfrPvZvxotDjrX3DizWh75/9i/T8
        Y3aUL/tz6JJD3vkaLItuyqnxPl5buDbXKcxcJP6BoKCvXOJ5zacXLXtk08VY1b8lvp5/33Xv
        1ZbGXHVh3bOsO59mtm76YqPhU+q45FdIb+hUpcOrDa/dtPnyirOzi2nqj4uX5mpFOcgrZO0y
        myl8rLnKplYx657d/zc7lmWtv+puqXd40sYjDNLMHL+uHu7343pZU7fzonVaM/sJI+4D/+Sv
        JPIsPxywdq1dl8y5/ScKW48u2xTFe/Ua261df91dT27Zty4lWYmlOCPRUIu5qDgRACnbDORx
        BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBIsWRmVeSWpSXmKPExsWy7bCSvG5q3t84g0tzeS3uz2tltHj36Smr
        xfwj51gtVn98zGhx5et7NovpezexWbTMWsRicbbpDbvF5V1z2Cw+9x5htOj8MovN4uIpV4vb
        jSvYLCatncpo0br3CLvFv2sbWSx+7prH4iDo8f5GK7vHzll32T0unfvD7LFpVSebx51re9g8
        7ncfZ/LobX7H5tG3ZRWjx+dNcgGcUVw2Kak5mWWpRfp2CVwZN+//Yy+4LVmxfi97A+NrkS5G
        Tg4JAROJR++uMnUxcnEICexmlJi+tpURIiEpMe3iUeYuRg4gW1ji8OFikLCQwFtGib4H3CC2
        sECMxKTuGSwgvSICx5glNp0+DTaIWeAyo8SOzq9sEFPnMUlcmH6fBaSFTUBLYv+LG2wgNr+A
        osTVH4/BtvEK2Ek8uXEBrIZFQEVi/akmsBpRgTCJnUseM0HUCEqcnPkErIZTwFbi6ut7YDXM
        AuoSf+ZdYoawxSVuPZnPBGHLSzRvnc08gVF4FpL2WUhaZiFpmYWkZQEjyypGydSC4tz03GLD
        AsO81HK94sTc4tK8dL3k/NxNjODI1tLcwbh91Qe9Q4xMHIyHGCU4mJVEeE8b/IoT4k1JrKxK
        LcqPLyrNSS0+xCjNwaIkznujcGGckEB6YklqdmpqQWoRTJaJg1OqgSl4mQOrZOLPdbOtygTZ
        rO4t5fvAXum4c4Ho1qP9PwP6m+ReMfBuOCe7pmLfzeYDCUe0Tnm2M1+aoPwqUPuy/my9N6lb
        p18vEHBlUpG3cFiTtsX2j9KOHOubYkVWzPV1k3nXnTl+1HZJlavx+UPKk/5eO/F2Dc/yOyHf
        pqTdnTF1VY60g8dJ27uZG7dtCxTVmOCv3bDBKEl7lkJizUkOF2P+buNXy9iO5ubMTVGd/Nx3
        qeC3C4kBdrs5f39KNHiiG6s4qdmsLValyqzzXH7Vtcbim+dCz/1b+nuiYcGOabP830Td26Qs
        2R0a/n7lpOtMzlz2GRqmoXvmyMfsLFU5f0v20pXWrY/uJWn1H/ji1KTEUpyRaKjFXFScCACf
        kFbgWwMAAA==
X-CMS-MailID: 20200702051933epcas1p111c52c4ed9fa37e9a1648335dba5e479
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200609131458epcas1p2c774a0302bcef2c02790c2cb8cad57a0
References: <20200609131404.17523-1-digetx@gmail.com>
        <CGME20200609131458epcas1p2c774a0302bcef2c02790c2cb8cad57a0@epcas1p2.samsung.com>
        <20200609131404.17523-13-digetx@gmail.com>
        <4ea7fe00-7676-3186-8222-6e0d0eb8ed1f@samsung.com>
        <4b22d3ee-f303-d81d-e261-187d4a46e749@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 7/2/20 2:07 PM, Dmitry Osipenko wrote:
> 02.07.2020 07:18, Chanwoo Choi пишет:
>> Hi Dmitry,
>>
>> On 6/9/20 10:13 PM, Dmitry Osipenko wrote:
>>> The clk_round_rate() won't be usable for building OPP table once
>>> interconnect support will be added to the EMC driver because that CLK API
>>> function limits the rounded rate based on the clk rate that is imposed by
>>> active clk-users, and thus, the rounding won't work as expected if
>>> interconnect will set the minimum EMC clock rate before devfreq driver is
>>> loaded. The struct tegra_mc contains memory timings which could be used by
>>> the devfreq driver for building up OPP table instead of rounding clock
>>> rate, this patch implements this idea.
>>>
>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>> ---
>>>  drivers/devfreq/tegra20-devfreq.c | 18 +++++++++++-------
>>>  1 file changed, 11 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/devfreq/tegra20-devfreq.c b/drivers/devfreq/tegra20-devfreq.c
>>> index 6469dc69c5e0..bf504ca4dea2 100644
>>> --- a/drivers/devfreq/tegra20-devfreq.c
>>> +++ b/drivers/devfreq/tegra20-devfreq.c
>>> @@ -123,8 +123,7 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>>>  {
>>>  	struct tegra_devfreq *tegra;
>>>  	struct tegra_mc *mc;
>>> -	unsigned long max_rate;
>>> -	unsigned long rate;
>>> +	unsigned int i;
>>>  	int err;
>>>  
>>>  	mc = tegra_get_memory_controller();
>>> @@ -151,12 +150,17 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>>>  
>>>  	tegra->regs = mc->regs;
>>>  
>>> -	max_rate = clk_round_rate(tegra->emc_clock, ULONG_MAX);
>>> -
>>> -	for (rate = 0; rate <= max_rate; rate++) {
>>> -		rate = clk_round_rate(tegra->emc_clock, rate);
>>> +	if (!mc->num_timings) {
>>
>> Could you explain what is meaning of 'num_timing?
> 
> The num_timings is the number of memory timings defined in a
> device-tree. One timing configuration per memory clock rate.

OK. I understand.

> 
>> Also, why add the opp entry in case of mc->num_timings is zero?
> 
> Timings may be not defined in some device-trees at all and in this case
> memory always running on a fixed clock rate.

You mean that 'timings' information is optional?

> 
> The devfreq driver won't be practically useful if mc->num_timings is
> zero since memory frequency can't be changed, but anyways we'd want to
> load the devfreq driver in order to prevent confusion about why it's not
> loaded.
> 
> For example, you may ask somebody to show contents of
> /sys/class/devfreq/tegra20-devfreq/trans_stat and the person says to you
> that this file doesn't exist, now you'll have to figure out what
> happened to the devfreq driver.

I understand why add OPP entry point when timing is not defined on DT.
But, actually, I think that you better to change 'timings' info is mandatory
instead of optional. Because the devfreq driver is for DVFS
and the driver supporting DVFS have to have the frequency information
like OPP.

Or, 
If you want to keep 'timing' is optional on DT,
I recommend that you add one timing data to tegra mc driver
when DT doesn't include the any timing information
I think that is it more clear.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
