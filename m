Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E12DBBC274
	for <lists+linux-pm@lfdr.de>; Tue, 24 Sep 2019 09:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394452AbfIXHUs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Sep 2019 03:20:48 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:27487 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394397AbfIXHUs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Sep 2019 03:20:48 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190924072044epoutp0371c04da5439b16d7a7018a88d928f9dc~HTs6JM0sl1173711737epoutp03M
        for <linux-pm@vger.kernel.org>; Tue, 24 Sep 2019 07:20:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190924072044epoutp0371c04da5439b16d7a7018a88d928f9dc~HTs6JM0sl1173711737epoutp03M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1569309644;
        bh=saSSDc4xlsXQ/We3wuexCjzjZrXJpSPi6UGK1QUa7JY=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=q9csBnjnsULHiBDRuiyCwCVu97nzRnaQhqdHna2oDB24S9l5TS3d/I6BEWgTR8wJy
         yN2Q/Z+iQ5afMAuHmlJopWylcJMQyOxHrNOWiO7UOAWZaCwzPPAQoOBfeeL36et+0I
         vAaJ1Vj+xeua43wQ3vRutjPGzted7R+d1eS6kkH0=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190924072043epcas1p1f1773510d2d0a6cc41aa0200788673fa~HTs5ynO0P1907719077epcas1p1X;
        Tue, 24 Sep 2019 07:20:43 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.157]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 46cszY3yKHzMqYkh; Tue, 24 Sep
        2019 07:20:41 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        C1.2F.04144.9C3C98D5; Tue, 24 Sep 2019 16:20:41 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20190924072040epcas1p4b3dc4391e2dd396d219a7fda95e7d914~HTs3NWAMA1446914469epcas1p4g;
        Tue, 24 Sep 2019 07:20:40 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190924072040epsmtrp1083e95ba69dc7cb7bdce62c69e7559bb~HTs3MgaAy2530125301epsmtrp11;
        Tue, 24 Sep 2019 07:20:40 +0000 (GMT)
X-AuditID: b6c32a35-2dfff70000001030-85-5d89c3c94937
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        57.47.04081.8C3C98D5; Tue, 24 Sep 2019 16:20:40 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190924072040epsmtip14a983e1ec76c8042d4a41b0fe960e26f~HTs24zm1l2318723187epsmtip1S;
        Tue, 24 Sep 2019 07:20:40 +0000 (GMT)
Subject: Re: [PATCH] PM / devfreq: Check NULL governor in
 available_governors_show
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>
Cc:     =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Lukasz Luba <l.luba@partner.samsung.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <cf1d1470-e62c-84e4-a926-156baf8aed18@samsung.com>
Date:   Tue, 24 Sep 2019 16:25:05 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <VI1PR04MB70231013FC39AA9A4AD46AC0EE840@VI1PR04MB7023.eurprd04.prod.outlook.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOJsWRmVeSWpSXmKPExsWy7bCmvu7Jw52xBnfXSVocOraV3eL8+Q3s
        Fmeb3rBb3GqQsVhx9yOrxabH11gtPvceYbT4vOExo8XtxhVsDpwesxsusnhsWtXJ5rF5Sb3H
        xnc7mDwOvtvD5NG3ZRWjx+dNcgHsUdk2GamJKalFCql5yfkpmXnptkrewfHO8aZmBoa6hpYW
        5koKeYm5qbZKLj4Bum6ZOUCHKSmUJeaUAoUCEouLlfTtbIryS0tSFTLyi0tslVILUnIKLAv0
        ihNzi0vz0vWS83OtDA0MjEyBChOyM5ZencFUMFe4ovfLG8YGxsX8XYycHBICJhIPlq5h6WLk
        4hAS2MEoce/QVHYI5xOjxPdjN5lAqoQEvjFKHO5gh+nomH6DGaJoL6PE0eenmCCc94wSG3p6
        wDqEBUIkrh+7CDZXRGA1o8SUE1/A5jILLGKSuLO4A6yKTUBLYv+LG2wgNr+AosTVH48ZQWxe
        ATuJRZ+eA+3g4GARUJWYMTENJCwqECHx6cFhVogSQYmTM5+wgNicArESr2b8BLOZBcQlbj2Z
        zwRhy0s0b50NdqqEQDu7xIqep+wgMyUEXCRezSyEeEdY4tXxLVCvSUm87G+DsqslVp48wgbR
        28EosWX/BVaIhLHE/qWTmUDmMAtoSqzfpQ8RVpTY+XsuI8RePol3X3tYIVbxSnS0CUGUKEtc
        fnCXCcKWlFjc3sk2gVFpFpJvZiH5YBaSD2YhLFvAyLKKUSy1oDg3PbXYsMAQObY3MYITrZbp
        DsYp53wOMQpwMCrx8Bbs6IgVYk0sK67MPcQowcGsJMK7SastVog3JbGyKrUoP76oNCe1+BCj
        KTCsJzJLiSbnA7NAXkm8oamRsbGxhYmhmamhoZI4r0d6Q6yQQHpiSWp2ampBahFMHxMHp1QD
        o7BNx939r1fqL3rG+zPzoMut5jNl0Xtyc96/37kj4eC3mVX5NU+3vijKmLCWO3NX2WGJExua
        5KVOeRw41b5EZYvVpqPvYx4wa/CmHIrkznI8+pKZs8HX/ePVFxLZE3z49wRPOSbUYjRNLnGC
        2MXtaqt7v/65c0KtXL/ZMkNhZ3uu4M56/TJ/OyWW4oxEQy3mouJEAMfVPIfKAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIIsWRmVeSWpSXmKPExsWy7bCSnO6Jw52xBs3rTS0OHdvKbnH+/AZ2
        i7NNb9gtbjXIWKy4+5HVYtPja6wWn3uPMFp83vCY0eJ24wo2B06P2Q0XWTw2repk89i8pN5j
        47sdTB4H3+1h8ujbsorR4/MmuQD2KC6blNSczLLUIn27BK6MpVdnMBXMFa7o/fKGsYFxMX8X
        IyeHhICJRMf0G8xdjFwcQgK7GSV2vexlh0hISky7eBQowQFkC0scPlwMUfOWUWL9835WkBph
        gRCJ68cusoDYIgKrGSXe9PqD2MwCi5gkJh/Lh2jYySTRc/4/WBGbgJbE/hc32EBsfgFFias/
        HjOC2LwCdhKLPj0HW8YioCoxY2IaSFhUIELi8I5ZUCWCEidnPgEbwykQK/Fqxk8WiF3qEn/m
        XWKGsMUlbj2ZzwRhy0s0b53NPIFReBaS9llIWmYhaZmFpGUBI8sqRsnUguLc9NxiwwLDvNRy
        veLE3OLSvHS95PzcTYzgiNPS3MF4eUn8IUYBDkYlHt6CHR2xQqyJZcWVuYcYJTiYlUR4N2m1
        xQrxpiRWVqUW5ccXleakFh9ilOZgURLnfZp3LFJIID2xJDU7NbUgtQgmy8TBKdXAaFmVrpvD
        nMibUNvG+cNr5S5Pxgih9y8m5C8LW8Q3y6jyzWMOrQv8btbXe1z+nc05c79h7lpPV9+De5SC
        NgScKNp+Ush147/Ea5sfKq8X2R9ubX1ST7Lgwbp6U8PC31Hrf9nEvOPxWamrl6YtpXcr74jr
        1c9Xar6eMpSQlTvR6220r3pdzJoPSizFGYmGWsxFxYkAe/pa2bQCAAA=
X-CMS-MailID: 20190924072040epcas1p4b3dc4391e2dd396d219a7fda95e7d914
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190923163453epcas4p1f9cff7d9f1a33fabcf4c980560d6c27d
References: <CGME20190923163453epcas4p1f9cff7d9f1a33fabcf4c980560d6c27d@epcas4p1.samsung.com>
        <96f459015e6418cee4fa20fdbdb80c4caf417c19.1569256298.git.leonard.crestez@nxp.com>
        <d6ea004f-4fbb-9a16-407e-ad8542abe1dc@samsung.com>
        <VI1PR04MB70231013FC39AA9A4AD46AC0EE840@VI1PR04MB7023.eurprd04.prod.outlook.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19. 9. 24. 오후 4:17, Leonard Crestez wrote:
> On 2019-09-24 4:48 AM, Chanwoo Choi wrote:
>> On 19. 9. 24. 오전 1:34, Leonard Crestez wrote:
>>> The governor is initialized after sysfs attributes become visible so in
>>> theory the governor field can be NULL here.
>>>
>>> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
>>> ---
>>>   drivers/devfreq/devfreq.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> Found this by hacking device core to call attribute "show" functions
>>> from inside device_add.
>>>
>>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>>> index 00fc23fea5b2..896fb2312f2f 100644
>>> --- a/drivers/devfreq/devfreq.c
>>> +++ b/drivers/devfreq/devfreq.c
>>> @@ -1322,11 +1322,11 @@ static ssize_t available_governors_show(struct device *d,
>>>   
>>>   	/*
>>>   	 * The devfreq with immutable governor (e.g., passive) shows
>>>   	 * only own governor.
>>>   	 */
>>> -	if (df->governor->immutable) {
>>> +	if (df->governor && df->governor->immutable) {
>>>   		count = scnprintf(&buf[count], DEVFREQ_NAME_LEN,
>>>   				  "%s ", df->governor_name);
>>>   	/*
>>>   	 * The devfreq device shows the registered governor except for
>>>   	 * immutable governors such as passive governor .
>>>
>>
>> As you mentioned, it create sysfs and then initialize the governor instance
>> as following:
>>
>> 	device_register()
>> 		device_add()
>> 			device_add_attrs()
>> 				creating sysfs entries.
>> 	governor = try_then_request_governor(...)
>>
>>
>> Thanks for fix-up.
>> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
>>
>> Additionally, you have to add the following 'fixes' tag
>> and then send it to stable mailing list(stable@vger.kernel.org).
>> - Fixes: bcf23c79c4e46 ("PM / devfreq: Fix available_governor sysfs")
> 
> OK, but I'm not sure this meets the criteria for inclusion into linux 
> stable:
> 
> * It must fix a real bug that bothers people (not a, "This could be a 
> problem..." type thing).
> * No "theoretical race condition" issues, unless an explanation of how 
> the race can be exploited is also provided.

OK. If you think that it is not necessary to send it to stable mailing list,
don't send it. Thanks.

> 
> This patch fixes a theoretical race condition which has been there since 
> the start.
> 
> --
> Regards,
> Leonard
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
