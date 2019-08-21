Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8CB96EBA
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2019 03:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbfHUBQt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Aug 2019 21:16:49 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:26266 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbfHUBQt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Aug 2019 21:16:49 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190821011644epoutp024cdb18ca39485345177d84484b9ebcfe~8yzZqPJFB1590515905epoutp02f
        for <linux-pm@vger.kernel.org>; Wed, 21 Aug 2019 01:16:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190821011644epoutp024cdb18ca39485345177d84484b9ebcfe~8yzZqPJFB1590515905epoutp02f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1566350205;
        bh=xEmIi5M02lWs875dbMM0AR/Z1LS0JR/AMotxqDZUibc=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=LRm4KKYmb41IrPbjd/lClNHds7md+xvA/9GSuWTM0edJV99Ry/xAqbYg+5nsaTB+X
         SrZJqkNOZ5aZxU5eWIqytPnUddEL1LA0T9IsfGNMrQc/3ud5xHvHK7A8uIVc5jU9h4
         Ext9EaEvmEYk7xweTNI/uRF3i2bvDRGE1et83wO0=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190821011644epcas1p4eb984018c30bdd27a4947059cb8eed2b~8yzY47sW81390013900epcas1p4P;
        Wed, 21 Aug 2019 01:16:44 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.157]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 46CqWF6y7yzMqYlr; Wed, 21 Aug
        2019 01:16:41 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        F7.A5.04085.77B9C5D5; Wed, 21 Aug 2019 10:16:39 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190821011638epcas1p1a834510ab4159ed52ff73559015042e9~8yzT3SIVy2418224182epcas1p1h;
        Wed, 21 Aug 2019 01:16:38 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190821011638epsmtrp1629bd8a367f0d5cbb83afdaff436e137~8yzT2aJlH2588825888epsmtrp1V;
        Wed, 21 Aug 2019 01:16:38 +0000 (GMT)
X-AuditID: b6c32a39-d03ff70000000ff5-d2-5d5c9b77b3fa
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        06.F7.03706.67B9C5D5; Wed, 21 Aug 2019 10:16:38 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190821011638epsmtip1c418e22db844a39cddcbad9b0ad1d8dc~8yzThBUpp0707007070epsmtip1v;
        Wed, 21 Aug 2019 01:16:38 +0000 (GMT)
Subject: Re: [PATCHv2] PM / devfreq: Add dev_pm_qos support
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Saravana Kannan <saravanak@google.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Lukasz Luba <l.luba@partner.samsung.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "cpgs (cpgs@samsung.com)" <cpgs@samsung.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <f753051c-628f-2d31-8ee1-4a64b5057e4e@samsung.com>
Date:   Wed, 21 Aug 2019 10:20:34 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <VI1PR04MB7023C709356F9EBE0CA4E3C8EEAB0@VI1PR04MB7023.eurprd04.prod.outlook.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHJsWRmVeSWpSXmKPExsWy7bCmvm757JhYg+Nz+CwOHdvKbvH19ClG
        i5eHNC2m793EZnH+/AZ2i7NNb9gtbjXIWKy4+5HVYtPja6wWn3uPMFrcblzBZnHm9CVWi65D
        f9ksNn71cODzeH+jld1jwaZSj02rOtk87lzbw+axeUm9x8Z3O5g8Dr7bw+Sx5Wo7i0ffllWM
        Hp83yQVwRWXbZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl
        5gBdr6RQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkpsCzQK07MLS7NS9dLzs+1MjQw
        MDIFKkzIzjix8jFjwTylip41d5gbGF9LdzFyckgImEgse3+AuYuRi0NIYAejxK2PDawQzidG
        iUW/OtggnG9AzrXNbDAtqz8sZodI7GWUmPvwHVTVe0aJxT03GEGqhAWsJZZ9nMUMYosI6Eq8
        fjsJbAmzwC8WibVNDSwgCTYBLYn9L26AjeUXUJS4+uMxWDOvgJ3E2XVTwJpZBFQlJk7qAKsX
        FYiQ+PTgMCtEjaDEyZlPwOKcArESm3+cBoszC4hL3HoynwnClpdo3jobbLGEwDF2iZ1/JrFC
        /OAisfP+FRYIW1ji1fEt7BC2lMTL/jYou1pi5ckjbBDNHYwSW/ZfgGo2lti/dDLQBg6gDZoS
        63fpQ4QVJXb+nssIYfNKNGz8zQ5xBJ/Eu689rCDlIPGONiGIEmWJyw/uMk1gVJ6F5J1ZSF6Y
        heSFWQjLFjCyrGIUSy0ozk1PLTYsMEWO702M4LStZbmD8dg5n0OMAhyMSjy8CdejY4VYE8uK
        K3MPMUpwMCuJ8FbMiYoV4k1JrKxKLcqPLyrNSS0+xGgKDO2JzFKiyfnAnJJXEm9oamRsbGxh
        YmhmamioJM678IdFrJBAemJJanZqakFqEUwfEwenVAMjT/RvlscFW0J+p4Uf3zVTYsqMxl/Z
        nl9tAzZ5rihZJnaWUXHnPvt0j/um0xiXLIy5q16lnyonYbCqdK244ju/jZZMm4Miwh4r9+7S
        ucJkqH36FkvEzCK9TI90DrWqHcnHZ17xN76/9Ou7WAWHXbN/Kp6ZWPLpf5ew2MnydO0XMz3P
        hRbrrk1RYinOSDTUYi4qTgQA+gF1tfEDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBIsWRmVeSWpSXmKPExsWy7bCSnG7Z7JhYg/dL1C0OHdvKbvH19ClG
        i5eHNC2m793EZnH+/AZ2i7NNb9gtbjXIWKy4+5HVYtPja6wWn3uPMFrcblzBZnHm9CVWi65D
        f9ksNn71cODzeH+jld1jwaZSj02rOtk87lzbw+axeUm9x8Z3O5g8Dr7bw+Sx5Wo7i0ffllWM
        Hp83yQVwRXHZpKTmZJalFunbJXBlnFj5mLFgnlJFz5o7zA2Mr6W7GDk5JARMJFZ/WMzexcjF
        ISSwm1Fi9penLBAJSYlpF48ydzFyANnCEocPF0PUvGWUuDX5KhNIjbCAtcSyj7OYQWwRAV2J
        128nMYMUMQs0sUocmfOHDaLjG7PExDkPWUGq2AS0JPa/uMEGYvMLKEpc/fGYEcTmFbCTOLtu
        CtgkFgFViYmTOsCuEBWIkDi8YxZUjaDEyZlPwOKcArESm3+cBpvJLKAu8WfeJWYIW1zi1pP5
        TBC2vETz1tnMExiFZyFpn4WkZRaSlllIWhYwsqxilEwtKM5Nzy02LDDMSy3XK07MLS7NS9dL
        zs/dxAiOXy3NHYyXl8QfYhTgYFTi4d1xMzpWiDWxrLgy9xCjBAezkghvxZyoWCHelMTKqtSi
        /Pii0pzU4kOM0hwsSuK8T/OORQoJpCeWpGanphakFsFkmTg4pRoYm7ODQnfc2BRe/sOo91ny
        EtXYBs/PBzZ/WSt6heGI3OWn3vtqystfm3889OzQ0ha1FcHGK9Z95g8o3qfFGRlwttF40Wa2
        2i2tK+qfKVmndvFfv67J1qNxU/70npX91Zqbn7ziWbApQqml3mjC3+2VDhy/vcLvb1x8Tsr6
        gpbHz14hnozmPxs6lViKMxINtZiLihMBo5hgi9sCAAA=
X-CMS-MailID: 20190821011638epcas1p1a834510ab4159ed52ff73559015042e9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
X-CPGSPASS: Y
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190808143919epcas4p33c93a5a3d4df1032fa84ddad9110a160
References: <CGME20190808143919epcas4p33c93a5a3d4df1032fa84ddad9110a160@epcas4p3.samsung.com>
        <e45c28528ff941abb1f72fdb1eedf65fb3345c5a.1565274802.git.leonard.crestez@nxp.com>
        <b3941b19-f0aa-87a6-d50a-299d07a26532@samsung.com>
        <VI1PR04MB7023EB13BB2DE94814B38477EED20@VI1PR04MB7023.eurprd04.prod.outlook.com>
        <a9328230-96f3-6bab-826a-bb199de4ad48@samsung.com>
        <195bef25-5235-4c24-cc7a-48d368da3bbd@samsung.com>
        <VI1PR04MB7023C709356F9EBE0CA4E3C8EEAB0@VI1PR04MB7023.eurprd04.prod.outlook.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19. 8. 21. 오전 12:26, Leonard Crestez wrote:
> On 8/14/2019 4:14 AM, Chanwoo Choi wrote:
>> On 19. 8. 14. 오전 10:06, Chanwoo Choi wrote:
>>> On 19. 8. 13. 오후 8:27, Leonard Crestez wrote:
>>>> On 13.08.2019 09:10, Chanwoo Choi wrote:
>>>>> In case of cpufreq, cpufreq.c replace the body of store_min_freq()
>>>>> and store_max_freq() by using struct dev_pm_qos_request instancce
>>>>> with dev_pm_qos_update_request().
>>>>>
>>>>> If you use the new way with dev_pm_qos_update_request() for
>>>>> min_freq_store() and max_freq_store(), it doesn't need to
>>>>> get the final frequency from three candidate frequencies.
>>>>
>>>> Yes, I saw that but didn't implement the equivalent for devfreq because
>>>> it's not clear what there is to gain.
>>>
>>> I think that it is clear. Just use the dev_pm_qos_request interface
>>> for both user input through sysfs and device input with qos request.
>>> Already PM_QOS has the feature to get the final freuency among
>>> the multiple request. When use the dev_pm_qos request, the devfreq
>>> doesn't need to compare between user input and device input with qos.
>>> It make devfreq core more clear and simple
> 
>>>> Since dev_pm_qos is measured in khz it means that min_freq/max_req on
>>>> sysfq would lose 3 significant digits, however those digits are probably
>>>> useless anyway.
>>>
>>> I think that it doesn't matter. This patch already considers the this issue
>>> by using '* 1000'. We can get either KHz or MHz with additional operation.
>>> I think that it is not problem.
> 
> It introduces the following issue:
> 
> # echo 333333333 > /sys/class/devfreq/devfreq0/min_freq
> # cat /sys/class/devfreq/devfreq0/min_freq
> 333333000
> 
> Changing rounding rules could confuse userspace tools. This is not 
> entirely a new issue because freq values which are not an integer number 
> of khz are likely not an integer number of hz either.

As I knew that, user don't need to enter the perfect supported clock
of devfreq0 because the final frequency is decided by device driver
with some limitations like the range of h/w clock.

The user can input the wanted frequency like 333333333,
but, the device driver try to find the similar frequency with policy
and the can decide the final supported frequency because the h/w clock
for devfreq0 might not support the perfect same clock frequency of user input.

Also, if it is the problem to lose the 3 significant digits, 
it should be fixed on dev_pm_qos.

> 
>>> Actually, I think that I want to use the only dev_pm_qos_request
>>> for all external request like devfreq cooling of thermal,
>>> user input through sysfs and device request with dev_pm_qos_request.
>>>
>>> Already, dev_pm_qos_request is designed to consider the multiple requirements.
>>> We don't need to use the various method (OPP interface, sysfs input, dev_pm_qos)
>>> because make it more simple and easy.
>>>
>>> I think that after finished the review of this patch, I will do refactor the devfreq_cooling.c
>>> by using the dev_pm_qos_request. Or, if there are some volunteeer,
>>
>> Sorry, I would withdraw the this opinion about replacing
>> the OPP enable/disable interface with the dev_pm_qos_request
>> because even if devfreq-cooling.c needs the 'dev' instance
>> to use the dev_pm_qos_request method, it is not clear until now.
>> It needs how to get the device instance of devfreq on device-tree.
> 
> I looked a bit at the devfreq-cooling implementation and it seems like 
> there aren't any users in upstream?

Right. there are no upstream patch. But, ARM developer contributed
the devfreq-cooling.c in order to control ARM Mali frequency
according to temperature. If you want, you can check
the reference code from ARM Mali kernel driver.

> 
> As far as I can tell a devfreq implementation needs to call 
> of_devfreq_cooling_register and then the devfreq cooling code could 
> register a dev_pm_qos request on devfreq->dev.parent. I'm not sure I 
> understand what problem you see.

Ah. you're right. It is my misunderstand. I though that there are no
any way to get the 'devfreq' instance from device tree. But, I checked
the devfreq-cooling.c again, as you commented, the devfreq-cooling.c
provides the of_devfreq_cooling_reigster().



-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
