Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 202B419A258
	for <lists+linux-pm@lfdr.de>; Wed,  1 Apr 2020 01:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731460AbgCaXOp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 31 Mar 2020 19:14:45 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:44909 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731325AbgCaXOp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 31 Mar 2020 19:14:45 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200331231443epoutp02add88864c40fbb1f413a7197355bf3fd~Bho0B153h0076200762epoutp02X
        for <linux-pm@vger.kernel.org>; Tue, 31 Mar 2020 23:14:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200331231443epoutp02add88864c40fbb1f413a7197355bf3fd~Bho0B153h0076200762epoutp02X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1585696484;
        bh=LGCiXSzwL29uEOvUs57CBZYFKXnjKRtagnRw/a+sNls=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=IBOn0eE+FuM5nDO4LRULROjMVRXYNDfs6jz8BYh0gGaQJRbxGppNTljSpnevddSew
         V0ZpA1CWt6QwLldqbrAmU9WqsNkWwdng4i3uhD9WAreZ8ndjcvJe1pLmW39xkC+JF5
         gfi4nARe8TWaIBuMPnICNDWLdNsL4jNubdhILxzY=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200331231443epcas1p12a151696df0264d80dc2a0c2789b5122~BhozhjRnW2330523305epcas1p1_;
        Tue, 31 Mar 2020 23:14:43 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.155]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 48sQC430DMzMqYkl; Tue, 31 Mar
        2020 23:14:40 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        A8.BB.04160.0EEC38E5; Wed,  1 Apr 2020 08:14:40 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200331231440epcas1p1ef07a220370a1bb296719bad79b7d312~BhowVnWaB2328023280epcas1p1E;
        Tue, 31 Mar 2020 23:14:40 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200331231440epsmtrp279d2bc0c5fe5629ac1eb76f18b30abb1~BhowUnsWv1277512775epsmtrp2b;
        Tue, 31 Mar 2020 23:14:40 +0000 (GMT)
X-AuditID: b6c32a38-2afff70000001040-d2-5e83cee09456
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        0C.B5.04158.FDEC38E5; Wed,  1 Apr 2020 08:14:39 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200331231439epsmtip2a3bb481684f737c2b1c273b69eae404a~BhowE8R5Z1875018750epsmtip22;
        Tue, 31 Mar 2020 23:14:39 +0000 (GMT)
Subject: Re: [PATCH v1 4/5] PM / devfreq: tegra30: Use
 clk_round_rate_unboundly()
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Organization: Samsung Electronics
Message-ID: <870e9436-34c0-4de3-4414-ac931532ed27@samsung.com>
Date:   Wed, 1 Apr 2020 08:23:45 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <147b571a-bae1-8a58-942c-579a5297299b@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01TbUhTYRTm3e7urtXqNjNPK2xdg9Dw4zZnt0gN+lolZUn9iHJd3E3NfbE7
        Iw3K0mxWimEGDctSi1qRtMT8mFgmyuxL+zDJFFGp0FLMEiWItl0j/z3POc9zznvO+76EWN6A
        K4g0o5WzGFk9hc/Bap6FRIT1v8pJinxwS87cGx9ETK69HGNenvkmZcYv9kmYt/WlODNR0IKY
        /J92nOls38L0nL6DM3+6HmLMdP11bONczVj3Wammzt4r1Tgd+bimIGcU1xRWO5BmwhmUgB9I
        35DKsTrOouSMySZdmjElhtqZqN2kVUdH0mH0OmYtpTSyBi6G2hyfELY1Te85HqU8xuozPKEE
        luepiNgNFlOGlVOmmnhrDMWZdXrzOnM4zxr4DGNKeLLJsJ6OjFyj9ggPp6eWD2SZG+THvxTE
        ZaPcBecRQQAZBa8L4s+jOYScrEVwo+S+RCA/ELQ6v3qIn4dMIsi17/Bir6H1sRsTRI0I8vpG
        cIGMIXjeaBN5Vf5kIpy7/AL3YpwMhaav3T7RIrJCBCOPrmHehJi0QsOlFp9hAbkC3k8NIi+W
        kbHgKKr0mTFyJTR9+eTTBJD7wV2TO6NZCO6rQ746fmQcuPrPztQMhI9DZSIBL4fH30vF3sZA
        FkvB1vxGLMywGVz3r+MC9ofhtmqpgBUwMdo4Ez8Bd90tuGC2Iahu6pAICRU03SoWebcnJkOg
        qj5CCK+Aut/XkNB4Poz+uigRFiwDW55ckATD2/5ekYCXQMW5fLwIUfZZ49hnjWCfNYL9f7Mb
        CHOgxZyZN6RwPG2Omn3XTuR7uKFMLXK9im9GJIGoeTLl+pwkuYQ9xmcamhEQYmqRDN+dnSSX
        6djMLM5i0loy9BzfjNSebV8SKwKSTZ5vYLRqafUalUrFRNHRapqmAmUlH/RJcjKFtXLpHGfm
        LP98IsJPkY2CAjUuR9kq/+jBNmXX/jzCOCl5ktZ4ULXvqq7u5FPbpj5ONLVl8lH/wnftA86y
        Hr9CVVxC0DLDoQs1k67pE9rC8is3g2Pbb/+kkmvdx0NKxy9ULN/ocuiU27OKlxYdHOeP9AQU
        Kp9c+VwZPrwHX23b9qCjulN1VFGlCegb2XVq7yCF8aksHSq28OxfT9vrUc4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOIsWRmVeSWpSXmKPExsWy7bCSvO79c81xBsenW1is/viY0aJl1iIW
        i7NNb9gtPvbcY7W4vGsOm8Xn3iOMFp1fZrFZXDzlanG7cQWbxb9rG1ksfu6ax+LA7fH+Riu7
        x85Zd9k9Nq3qZPPobX7H5tG3ZRWjx+dNcgFsUVw2Kak5mWWpRfp2CVwZix5VFewWqnjea9/A
        2MLfxcjJISFgInFs+0mWLkYuDiGB3YwS/RfXsEAkJCWmXTzK3MXIAWQLSxw+XAxR85ZR4tzM
        +YwgNcICwRLtU86wgdhsAloS+1/cYAMpEhFYyiSx4uYXdpAEs0CJxIln/1ghul8xSjx7cI8Z
        JMEvoChx9cdjsEm8AnYSqyYsAZvEIqAisf/5HSYQW1QgTGLnksdMEDWCEidnPgG7jlPAXmLP
        g1YWiAXqEn/mXWKGsMUlbj2ZzwRhy0tsfzuHeQKj8Cwk7bOQtMxC0jILScsCRpZVjJKpBcW5
        6bnFhgVGeanlesWJucWleel6yfm5mxjB0aeltYPxxIn4Q4wCHIxKPLyKVs1xQqyJZcWVuYcY
        JTiYlUR42fwb4oR4UxIrq1KL8uOLSnNSiw8xSnOwKInzyucfixQSSE8sSc1OTS1ILYLJMnFw
        SjUwOuaVzo9h3uD8ROXlnWg30bu8nzNbTwjX8HoV9jEmFW0LfXZxldTUWIHZoabL7krOaOOr
        mydXKrPoTBUXn+6Ml3d/b7k1Lby66tDcvFaZt2F/t/gUnQk78v5v04NNr/j7/q8MuN3Td+1d
        xLctnJ96nCy4wnokXvs9vvVi7xfOb0K+HWtd045XKbEUZyQaajEXFScCAMZY1PS6AgAA
X-CMS-MailID: 20200331231440epcas1p1ef07a220370a1bb296719bad79b7d312
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200330232025epcas1p37cf026c6e46723d416f94b1f005ac5ab
References: <20200330231617.17079-1-digetx@gmail.com>
        <CGME20200330232025epcas1p37cf026c6e46723d416f94b1f005ac5ab@epcas1p3.samsung.com>
        <20200330231617.17079-5-digetx@gmail.com>
        <147b571a-bae1-8a58-942c-579a5297299b@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 4/1/20 8:22 AM, Chanwoo Choi wrote:
> On 3/31/20 8:16 AM, Dmitry Osipenko wrote:
>> The clk_round_rate() doesn't work for us properly if clock rate is bounded
>> by a min/max rate that is requested by some other clk-user because we're
>> building devfreq's OPP table based on the rounding.
>>
>> In particular this becomes a problem if display driver is probed earlier
>> than devfreq, and thus, display adds a memory bandwidth request using
>> interconnect API, which results in a minimum clock-rate being set for
>> the memory clk. In a result, the lowest devfreq OPP rate is getting
>> limited to the minimum rate imposed by the display driver.
>>
>> Let's use new clk_round_rate_unboundly() that resolves the problem by
>> rounding clock rate without taking into account min/max limits imposed by
>> active clk users.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/devfreq/tegra30-devfreq.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
>> index 28b2c7ca416e..34f6291e880c 100644
>> --- a/drivers/devfreq/tegra30-devfreq.c
>> +++ b/drivers/devfreq/tegra30-devfreq.c
>> @@ -834,7 +834,7 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>>  
>>  	reset_control_deassert(tegra->reset);
>>  
>> -	rate = clk_round_rate(tegra->emc_clock, ULONG_MAX);
>> +	rate = clk_round_rate_unboundly(tegra->emc_clock, ULONG_MAX);
>>  	if (rate < 0) {
>>  		dev_err(&pdev->dev, "Failed to round clock rate: %ld\n", rate);
>>  		return rate;
>> @@ -849,7 +849,7 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>>  	}
>>  
>>  	for (rate = 0; rate <= tegra->max_freq * KHZ; rate++) {
>> -		rate = clk_round_rate(tegra->emc_clock, rate);
>> +		rate = clk_round_rate_unboundly(tegra->emc_clock, rate);
>>  
>>  		if (rate < 0) {
>>  			dev_err(&pdev->dev,
>>
> 
> Firstly, patch2 have to be reviewed for this patch.
> I have no any objection. It looks good to me.
> 
> If patch1 get the confirmation from clock maintainer,

Sorry. I mean the patch2 about clk_round_rate_unboundly() function.
instead of patch1.

> feel free to add my acked tag:
> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
