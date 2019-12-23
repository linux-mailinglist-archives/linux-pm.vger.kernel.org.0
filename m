Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F745129080
	for <lists+linux-pm@lfdr.de>; Mon, 23 Dec 2019 01:44:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbfLWAoF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 22 Dec 2019 19:44:05 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:41465 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbfLWAoF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 22 Dec 2019 19:44:05 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20191223004403epoutp01ea6f4ec01fd40e2412e9c96ed2f644c3~i2WQErjGy0582405824epoutp01b
        for <linux-pm@vger.kernel.org>; Mon, 23 Dec 2019 00:44:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20191223004403epoutp01ea6f4ec01fd40e2412e9c96ed2f644c3~i2WQErjGy0582405824epoutp01b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1577061843;
        bh=/BYkN24xnlw6UcBJ3nGEmW3fcezz9fsfM7fQCxL25MI=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=gPoUhs6frtIcD+7d7/E/6Q1NW+PvgxOr17icvOtaYrdieku+SomQfzf7bTIdO2kWU
         E9/IgiEhDJgMtioAokI73ogjVUaE5qhaQmsj2vqJP4kLnDecYGB/pfS0CESqQAXRnX
         yaR+GPxLi3yuH2Va/Sb0emIo56CAtSekHMKk5OoU=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20191223004402epcas1p343eefff764d4d9fa500a0d4773279fa3~i2WPpJhut2358123581epcas1p3V;
        Mon, 23 Dec 2019 00:44:02 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.152]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 47h0wK4N0pzMqYkY; Mon, 23 Dec
        2019 00:44:01 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        5E.CF.51241.1DD000E5; Mon, 23 Dec 2019 09:44:01 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191223004400epcas1p1da1c5a6c74351f319b1c9fe2e6a614e6~i2WOCx4zM2973729737epcas1p1V;
        Mon, 23 Dec 2019 00:44:00 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191223004400epsmtrp262631a0367ab5f98f3e6c7f1f2fc9992~i2WOCJLzC1430114301epsmtrp2E;
        Mon, 23 Dec 2019 00:44:00 +0000 (GMT)
X-AuditID: b6c32a39-163ff7000001c829-12-5e000dd1ed2f
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D3.DC.10238.0DD000E5; Mon, 23 Dec 2019 09:44:00 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191223004400epsmtip1cdf80b5c76e0692add1279731b1b55ba~i2WN2Qixb2894928949epsmtip1S;
        Mon, 23 Dec 2019 00:44:00 +0000 (GMT)
Subject: Re: [PATCH v2 2/2] PM / devfreq: exynos-bus: Disable devfreq-event
 device when fails
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     Yangtao Li <tiny.windzz@gmail.com>, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, kgene@kernel.org, krzk@kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Organization: Samsung Electronics
Message-ID: <52c458b0-cc85-fd2d-7c89-39f2bbd39bda@samsung.com>
Date:   Mon, 23 Dec 2019 09:50:46 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <ca7f5eb8-d549-a170-f952-90e5882b233d@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNJsWRmVeSWpSXmKPExsWy7bCmnu5FXoY4gzNT5C36H79mtjh/fgO7
        xdmmN+wWmx5fY7W4vGsOm8Xn3iOMFjPO72OyuN24gs1i7u8JbA6cHjtn3WX32LSqk81j85J6
        j74tqxg9Pm+SC2CNyrbJSE1MSS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQwV1LIS8xNtVVy
        8QnQdcvMAbpHSaEsMacUKBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQklNgWaBXnJhbXJqXrpec
        n2tlaGBgZApUmJCd8ft5VcFy7ooD/auZGxgnc3YxcnBICJhIzJla0MXIxSEksINR4umtWcwQ
        zidGiZdbT7FDON8YJd73z2TrYuQE67h89SxUYi+jxLa+/WwQzntGiYMd81hBqoQF4iWav89g
        AbHZBLQk9r+4AVYkItDKJLF+ywSwBL+AosTVH48ZQQ7hFbCT2Pc/HyTMIqAqcfnQB3YQW1Qg
        TOLkthZGEJtXQFDi5MwnYK2cAvYSG15OANvFLCAucevJfCYIW15i+9s5zBCXfmeTuHM7BOJP
        F4nla1UgwsISr45vYYewpSQ+v9sL9Vi1xMqTR8DOlBDoYJTYsv8CK0TCWGL/0slMIHOYBTQl
        1u/ShwgrSuz8PZcRYi2fxLuvPawQq3glOtqEIEqUJS4/uMsEYUtKLG7vhFrlIfHpczvbBEbF
        WUgem4XkmVlInpmFsHgBI8sqRrHUguLc9NRiwwJT5KjexAhOqFqWOxiPnfM5xCjAwajEw5sw
        53+sEGtiWXFl7iFGCQ5mJRHe3bV/Y4V4UxIrq1KL8uOLSnNSiw8xmgLDfSKzlGhyPjDZ55XE
        G5oaGRsbW5gYmpkaGiqJ83L8uBgrJJCeWJKanZpakFoE08fEwSnVwGi8wfH+u1dMgicX3g+d
        3rbzzdkMaw7h7zVVLTw1U3b89d90eVpo/7nfZ47OtL7h+KNBfbM29/HCYiaRzzzHV+/kn+tl
        8rtoz4fTvQVWV8XPatUuq7GK2a15/x6r+W7Zkp1PcmS4j942/7juTU4pY6tD2NEdi1sqEq4+
        cHL+2hfTKNTGco53n7oSS3FGoqEWc1FxIgDmaxv+vgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphkeLIzCtJLcpLzFFi42LZdlhJTvcCL0Ocwf2tphb9j18zW5w/v4Hd
        4mzTG3aLTY+vsVpc3jWHzeJz7xFGixnn9zFZ3G5cwWYx9/cENgdOj52z7rJ7bFrVyeaxeUm9
        R9+WVYwenzfJBbBGcdmkpOZklqUW6dslcGX8fl5VsJy74kD/auYGxsmcXYycHBICJhKXr55l
        72Lk4hAS2M0ocb1hNgtEQlJi2sWjzF2MHEC2sMThw8UQNW8ZJdbv/8UGUiMsEC/R/H0GWD2b
        gJbE/hc32ECKRARamSQW3pjDCtHxiVHiwcZXTCBV/AKKEld/PGYEmcorYCex738+SJhFQFXi
        8qEP7CC2qECYxM4lj8HKeQUEJU7OfAK2gFPAXmLDywmsIDazgLrEn3mXmCFscYlbT+YzQdjy
        EtvfzmGewCg0C0n7LCQts5C0zELSsoCRZRWjZGpBcW56brFhgWFearlecWJucWleul5yfu4m
        RnAcaWnuYLy8JP4QowAHoxIPL8es/7FCrIllxZW5hxglOJiVRHh31/6NFeJNSaysSi3Kjy8q
        zUktPsQozcGiJM77NO9YpJBAemJJanZqakFqEUyWiYNTqoExhn2Lu8c1w0M28pa60lEp4V/Z
        1bL5k91MnbeHrDnid8yFZfuCd/53jU5O7J5wO/e15573c2ZEiTeceJJTbX7o8O9Lx1p6dx05
        +uhBxqf9q/dzLL0Zoc9T3fv/65MD3kJGOpnL2dRmJ99YstSdt5Fbt73X8+WCB/3tVW9Uebkc
        ItZN+D3D3vWAEktxRqKhFnNRcSIAvQk3R58CAAA=
X-CMS-MailID: 20191223004400epcas1p1da1c5a6c74351f319b1c9fe2e6a614e6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191222174142epcas1p4ad50cacad72ab368b07ee0ebc680c9b3
References: <20191222174132.3701-1-tiny.windzz@gmail.com>
        <CGME20191222174142epcas1p4ad50cacad72ab368b07ee0ebc680c9b3@epcas1p4.samsung.com>
        <20191222174132.3701-2-tiny.windzz@gmail.com>
        <ca7f5eb8-d549-a170-f952-90e5882b233d@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12/23/19 9:47 AM, Chanwoo Choi wrote:
> On 12/23/19 2:41 AM, Yangtao Li wrote:
>> The exynos_bus_profile_init process may fail, but the devfreq event device
>> remains enabled. Call devfreq_event_disable_edev on the error return path.
>>
>> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
>> ---
>> v2:
>> -change subject
>> -rename lable to err_edev
>> -add return value check
>> ---
>>  drivers/devfreq/exynos-bus.c | 9 ++++++++-
>>  1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
>> index 7f5917d59072..948e9340f91c 100644
>> --- a/drivers/devfreq/exynos-bus.c
>> +++ b/drivers/devfreq/exynos-bus.c
>> @@ -335,10 +335,17 @@ static int exynos_bus_profile_init(struct exynos_bus *bus,
>>  	ret = exynos_bus_set_event(bus);
>>  	if (ret < 0) {
>>  		dev_err(dev, "failed to set event to devfreq-event devices\n");
>> -		return ret;
>> +		goto err_edev;
>>  	}
>>  
>>  	return 0;
>> +
>> +err_edev:
>> +	ret = exynos_bus_disable_edev(bus);
>> +	if (ret < 0)
>> +		dev_warn(dev, "failed to disable the devfreq-event devices\n");
>> +
>> +	return ret;
>>  }
>>  
>>  static int exynos_bus_profile_init_passive(struct exynos_bus *bus,
>>
> 
> Applied it.
> 

I'm sorry. I applied the v3[1] patch instead of this.
[1] https://patchwork.kernel.org/patch/11307721/


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
