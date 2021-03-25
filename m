Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB223485EE
	for <lists+linux-pm@lfdr.de>; Thu, 25 Mar 2021 01:34:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234955AbhCYAdc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Mar 2021 20:33:32 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:11778 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234959AbhCYAdF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Mar 2021 20:33:05 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210325003303epoutp0223c58c20cc40c453736d3f7cd9c65638~vbpZsdb0O1292112921epoutp02Z
        for <linux-pm@vger.kernel.org>; Thu, 25 Mar 2021 00:33:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210325003303epoutp0223c58c20cc40c453736d3f7cd9c65638~vbpZsdb0O1292112921epoutp02Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1616632383;
        bh=nA30aHeWl+8OzfpeBOWsnnXdbwmd4NgPDPSFz1H723A=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=RWzt6AAQszGAio2JxNpEYigsw2/fKU7upel6iif36I8JRxOOtlITPu2HnFGdH2u18
         B7NeweqzcGCdsi5kdzrEL2vKHm1UowkV6QqTsESMffxs8wb2k+B8xranzkNc6K2V1k
         5p2fElXE8sY24D2eQaW2o+bv9Q5S8rX926hXOV2E=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210325003302epcas1p18e8bec53f26d810d7b3be44c8144e5a1~vbpYr0jOd0042100421epcas1p1K;
        Thu, 25 Mar 2021 00:33:02 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.158]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4F5R0B57Spz4x9QH; Thu, 25 Mar
        2021 00:32:58 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        AE.EE.22618.A3ADB506; Thu, 25 Mar 2021 09:32:58 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210325003257epcas1p10e798a51137fc7f7fe0f4c772a68f609~vbpT4VJjT0044100441epcas1p1N;
        Thu, 25 Mar 2021 00:32:57 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210325003257epsmtrp210d1d865c0edcb7395da09725004c1ff~vbpT3jT5e3234032340epsmtrp2t;
        Thu, 25 Mar 2021 00:32:57 +0000 (GMT)
X-AuditID: b6c32a38-e4dff7000001585a-84-605bda3a54c6
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        8E.16.33967.93ADB506; Thu, 25 Mar 2021 09:32:57 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210325003256epsmtip183e07534b2cd153806210c6a2a83081e~vbpTf2f2e1902519025epsmtip1L;
        Thu, 25 Mar 2021 00:32:56 +0000 (GMT)
Subject: Re: [PATCH 1/2] extcon: extcon-gpio: Log error if work-queue init
 fails
To:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "sre@kernel.org" <sre@kernel.org>,
        "myungjoo.ham@samsung.com" <myungjoo.ham@samsung.com>,
        "wens@csie.org" <wens@csie.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <b465d250-3933-91ce-a686-f158ca3d0a53@samsung.com>
Date:   Thu, 25 Mar 2021 09:49:57 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <58298d5bdd026a492e4fa2ad6de25720c66710ff.camel@fi.rohmeurope.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOJsWRmVeSWpSXmKPExsWy7bCmga7VregEg68NfBbNi9ezWbw5Pp3J
        4vKuOWwWn3uPMFps//aIzeJ24wo2i9O7Syx+HjrP5MDhseHRalaP30cfs3tsWtXJ5rF/7hp2
        j/f7rrJ59G1ZxejxeZNcAHtUtk1GamJKapFCal5yfkpmXrqtkndwvHO8qZmBoa6hpYW5kkJe
        Ym6qrZKLT4CuW2YO0FFKCmWJOaVAoYDE4mIlfTubovzSklSFjPziElul1IKUnALLAr3ixNzi
        0rx0veT8XCtDAwMjU6DChOyMh+emMRVc4q+Y8m47WwPjYZ4uRk4OCQETiY+757B3MXJxCAns
        YJRo37yMEcL5xCjx/cBSVgjnG6PEhVndQA4HWMvMfnGI+F5Gid+N86A63jNKrOx+wQYyV1gg
        SKLr6nswW0QgU2LeyzXMIEXMAtuYJI7OWMEEkmAT0JLY/+IGWBG/gKLE1R+PGUFsXgE7ieYp
        x1hBbBYBVYm5J5eB1YsKhEmc3NYCVSMocXLmExYQm1PAX+LLpBawemYBcYlbT+YzQdjyEtvf
        zgFbLCGwhUNi4rkPzBBfu0h8vtXPBGELS7w6voUdwpaS+PxuLxuEXS2x8uQRNojmDkaJLfsv
        sEIkjCX2L53MBAoLZgFNifW79CHCihI7f89lhFjMJ/Huaw80uHglOtqEIEqUJS4/uAu1VlJi
        cXsn2wRGpVlI3pmF5IVZSF6YhbBsASPLKkax1ILi3PTUYsMCE+To3sQITrFaFjsY5779oHeI
        kYmD8RCjBAezkghvS3hEghBvSmJlVWpRfnxRaU5q8SFGU2AAT2SWEk3OByb5vJJ4Q1MjY2Nj
        CxNDM1NDQyVx3iSDB/FCAumJJanZqakFqUUwfUwcnFINTOJJRYmME645X/pd6jxJIPcqT4FR
        Er+gzO2STS0J4rNOKJsFnG2fNC8wu8g94eevKz+PzMk3M+xcfTNf0Xdn2aXvIsKLBH49U485
        v8PmY5GjQuuXRVenak/tLhO/o7Fp4dHNtxeJ3Tny4NQPq/QJapbC80TLlM4tMDr2b2rvQo9Z
        8uLSNr//Vr11EY2c36Dt98Hzy8MNu9/2sx/PefrgQ3uwv6Bcl/5Ur10XSt+8PrTh3tX3j0wZ
        Za9tDfV8ze05OfalZenBp9mGSbPyGHjMz+iZ7b1Qk6f72Delky31mMcv+R7Ha2fj56ycnxF9
        dmPntkNz5q9/brCt9/CWU2oHHLkNHW522xg+//Ur4/PkL8uVWIozEg21mIuKEwGNRewXOgQA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAIsWRmVeSWpSXmKPExsWy7bCSnK7lregEg+5vnBbNi9ezWbw5Pp3J
        4vKuOWwWn3uPMFps//aIzeJ24wo2i9O7Syx+HjrP5MDhseHRalaP30cfs3tsWtXJ5rF/7hp2
        j/f7rrJ59G1ZxejxeZNcAHsUl01Kak5mWWqRvl0CV8bDc9OYCi7xV0x5t52tgfEwTxcjB4eE
        gInEzH7xLkYuDiGB3YwSu1q+MXYxcgLFJSWmXTzKDFEjLHH4cDFEzVtGiVUXj7KC1AgLBEl0
        XX3PBmKLCGRK3Nt2iBGkiFlgB5PEg22XwRJCAu+ZJN5MFwGx2QS0JPa/uAEW5xdQlLj64zHY
        Ml4BO4nmKcfAhrIIqErMPbmMCcQWFQiT2LnkMRNEjaDEyZlPWEBsTgF/iS+TWsDqmQXUJf7M
        u8QMYYtL3HoynwnClpfY/nYO8wRG4VlI2mchaZmFpGUWkpYFjCyrGCVTC4pz03OLDQsM81LL
        9YoTc4tL89L1kvNzNzGCI01Lcwfj9lUf9A4xMnEwHmKU4GBWEuFtCY9IEOJNSaysSi3Kjy8q
        zUktPsQozcGiJM57oetkvJBAemJJanZqakFqEUyWiYNTqoHpmIWMj1F6xgmhXdLbG1mufm6q
        D7iapSIYmavlW6Pg6/ScIf++Yntf/IrKYu5/sS3/tFbdDNBdEHUw/8o3nYXREhddvmiJ1jUt
        D5Qq4JyblT9Z+c+hTR0POpdsDX9yy+1709QCbq+v982YEm/IzTl89f0DPatqYXetNYnNXFds
        e/+Zc2coTq/h+PU25mH5ClFLOatovosX9Dse1xfM/zY9Oi/epPzxti088pfftqz9Vap/KurV
        5cuFOz6wPtflzLzhWdbZYpO543dTHuve7XEXp7Ve35LTa/f+xfq7lgeOuQj3TMyeK3pPiU93
        cv0i/rOPSzKNl3fO+Hhmorew7aY9H9f4s/fOU3DxOaFlyavEUpyRaKjFXFScCAB1oMYIIwMA
        AA==
X-CMS-MailID: 20210325003257epcas1p10e798a51137fc7f7fe0f4c772a68f609
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210324095118epcas1p1ea1cb42f8341bbb972f591d9f5a63695
References: <cover.1616574973.git.matti.vaittinen@fi.rohmeurope.com>
        <bfd893701ac3d239fef856d2f589063983422100.1616574973.git.matti.vaittinen@fi.rohmeurope.com>
        <1860d4e8-2e3a-fe05-cab9-782f3e35b9ab@redhat.com>
        <CGME20210324095118epcas1p1ea1cb42f8341bbb972f591d9f5a63695@epcas1p1.samsung.com>
        <58298d5bdd026a492e4fa2ad6de25720c66710ff.camel@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 3/24/21 6:51 PM, Vaittinen, Matti wrote:
> Hello Hans, Chanwoo, Greg,
> 
> On Wed, 2021-03-24 at 10:25 +0100, Hans de Goede wrote:
>> Hi,
>>
>> On 3/24/21 10:21 AM, Matti Vaittinen wrote:
>>> Add error print for probe failure when resource managed work-queue
>>> initialization fails.
>>>
>>> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
>>> Suggested-by: Chanwoo Choi <cw00.choi@samsung.com>
>>> ---
>>>  drivers/extcon/extcon-gpio.c | 4 +++-
>>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/extcon/extcon-gpio.c b/drivers/extcon/extcon-
>>> gpio.c
>>> index 4105df74f2b0..8ea2cda8f7f3 100644
>>> --- a/drivers/extcon/extcon-gpio.c
>>> +++ b/drivers/extcon/extcon-gpio.c
>>> @@ -114,8 +114,10 @@ static int gpio_extcon_probe(struct
>>> platform_device *pdev)
>>>  		return ret;
>>>  
>>>  	ret = devm_delayed_work_autocancel(dev, &data->work,
>>> gpio_extcon_work);
>>> -	if (ret)
>>> +	if (ret) {
>>> +		dev_err(dev, "Failed to initialize delayed_work");
>>>  		return ret;
>>> +	}
>>
>> The only ret which we can have here is -ENOMEM and as a rule we don't
>> log
>> errors for those, because the kernel memory-management code already
>> complains
>> loudly when this happens.
> 
> I know. This is why I originally omitted the print. Besides, if the
> memory is so low that devres adding fails - then we probably have
> plenty of other complaints as well... But as Chanwoo maintains the
> driver and wanted to have the print - I do not have objections to that
> either. Maybe someone some-day adds another error path to wq
> initialization in which case seeing it failed could make sense.
> 
>> So IMHO this patch should be dropped.
> Fine for me - as well as keeping it. I have no strong opinion on this.

If it is the same handling way for -ENOMEM, don't need to add log ss Hans said. 
Thanks for Hans.

> 
> Br,
> 	Matti
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
