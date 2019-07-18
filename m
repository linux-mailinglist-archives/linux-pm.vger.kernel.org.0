Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47F436CB72
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jul 2019 11:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbfGRJEF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Jul 2019 05:04:05 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:24960 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389802AbfGRJEE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Jul 2019 05:04:04 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190718090400epoutp03f91a80c77319bf7f0478fa722c082d4a~ydPqaZOxY0629406294epoutp03T
        for <linux-pm@vger.kernel.org>; Thu, 18 Jul 2019 09:04:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190718090400epoutp03f91a80c77319bf7f0478fa722c082d4a~ydPqaZOxY0629406294epoutp03T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563440640;
        bh=eCzRoBS64n7hVgrP135ikuTSoqkmLqw2kLKgG7YgpEU=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=bA5VVtKeasRVhApGYBSUuNXAnG7zgbPmUJw39UjjxGrJSCuoTYSFG+paejuetIfXT
         Cv7HS23Hi68cNVpZFcONodt+esOk3WLEtJgpddDQ91P428wqVNbhp8vhaqw7FeUFf3
         5hep0gdG48nHeKRJPfncLBeO2CCSn+y/JbntMNMk=
Received: from epsnrtp6.localdomain (unknown [182.195.42.167]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190718090359epcas1p14d9d1a2eb89b015d6726d6c86bc8c37f~ydPpto1t13105231052epcas1p1Y;
        Thu, 18 Jul 2019 09:03:59 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.158]) by
        epsnrtp6.localdomain (Postfix) with ESMTP id 45q7V530nXzMqYkX; Thu, 18 Jul
        2019 09:03:57 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        0D.51.04066.DF5303D5; Thu, 18 Jul 2019 18:03:57 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20190718090356epcas1p363ba27cd8b2bfbbe4461b2cd790207bb~ydPnPQrDT1995319953epcas1p3o;
        Thu, 18 Jul 2019 09:03:56 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190718090356epsmtrp13293ce08d24cbaf4ca218978d52e2869~ydPnN-imK2474324743epsmtrp1Y;
        Thu, 18 Jul 2019 09:03:56 +0000 (GMT)
X-AuditID: b6c32a37-e27ff70000000fe2-72-5d3035fda9c6
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D0.1B.03706.CF5303D5; Thu, 18 Jul 2019 18:03:56 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190718090356epsmtip2bc4a93adf982290e3fddd4b433b25c85~ydPm_6KI50953309533epsmtip2Z;
        Thu, 18 Jul 2019 09:03:56 +0000 (GMT)
Subject: Re: [PATCH v4 11/24] PM / devfreq: tegra30: Add debug messages
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <f630dacc-2065-a12d-bd03-1fc6c4363e1f@samsung.com>
Date:   Thu, 18 Jul 2019 18:07:05 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <f819c226-4328-c85d-5da3-932391fa6747@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHJsWRmVeSWpSXmKPExsWy7bCmge5fU4NYg91rxSxWf3zMaNEyaxGL
        xdmmN+wWl3fNYbP43HuE0aLzyyw2i9uNK9gsfu6ax2LRt/YSmwOnx467Sxg9ds66y+7R2/yO
        zaNvyypGj8+b5AJYo7JtMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22V
        XHwCdN0yc4AOUlIoS8wpBQoFJBYXK+nb2RTll5akKmTkF5fYKqUWpOQUWBboFSfmFpfmpesl
        5+daGRoYGJkCFSZkZ3w7MZ2x4KJExf9bcQ2MV4W7GDk5JARMJO5cWMIKYgsJ7GCU2DPVvouR
        C8j+xCgx7XgnO4TzjVHi1uRmoCoOsI5DF7Qg4nsZJfa2zmWDcN4zShyaPIEJZJSwgLvEhgkr
        mEASIgL/GCU6fzazgSSYBSIlDu9cDVbEJqAlsf/FDbA4v4CixNUfjxlBbF4BO4nN63eD1bAI
        qEp8m7iQBcQWFYiQOHVkHgtEjaDEyZlPwGxOAVuJqW9WQ80Xl7j1ZD4ThC0v0bx1NjPIERIC
        v9kk3t3eyQjxtIvE7Lcf2CFsYYlXx7dA2VISL/vboOxqiZUnj7BBNHcwSmzZf4EVImEssX/p
        ZCZQWDALaEqs36UPEVaU2Pl7LiPEYj6Jd197oMHFK9HRJgRRoixx+cFdJghbUmJxeyfbBEal
        WUjemYXkhVlIXpiFsGwBI8sqRrHUguLc9NRiwwJj5MjexAhOq1rmOxg3nPM5xCjAwajEw3tD
        ST9WiDWxrLgy9xCjBAezkgjv7ZdAId6UxMqq1KL8+KLSnNTiQ4ymwNCeyCwlmpwPTPl5JfGG
        pkbGxsYWJoZmpoaGSuK88/5oxgoJpCeWpGanphakFsH0MXFwSjUw+jN+aZUSeJ5yuD4uadWx
        jvy6ozM+7z6zi7fXb0vJcobc2jtWWZda34nv0uk8+qDj9foHlxqWx5xZd1vTK8F8rWTkMz7P
        7wIljQZHU7+xKmz+VJ3qpLX+I+uPj3lzF5xSzzPovXdy1lKHLeu2ntgZVWqsaREyKfH3+mjp
        X7/FHj0z/bb9/O0d6kosxRmJhlrMRcWJAFAoP+zBAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJIsWRmVeSWpSXmKPExsWy7bCSvO4fU4NYg8bFxharPz5mtGiZtYjF
        4mzTG3aLy7vmsFl87j3CaNH5ZRabxe3GFWwWP3fNY7HoW3uJzYHTY8fdJYweO2fdZffobX7H
        5tG3ZRWjx+dNcgGsUVw2Kak5mWWpRfp2CVwZ305MZyy4KFHx/1ZcA+NV4S5GDg4JAROJQxe0
        uhi5OIQEdjNKrLj8m6WLkRMoLikx7eJRZogaYYnDh4shat4ySsz6dJwJpEZYwF1iw4QVTCAJ
        EYEmJolNvRfYQRLMApESPXO3sEF0tDBLnHzyD2wqm4CWxP4XN9hAbH4BRYmrPx4zgti8AnYS
        m9fvBpvKIqAq8W3iQrB6UYEIiUnXdrJA1AhKnJz5BMzmFLCVmPpmNRvEMnWJP/MuMUPY4hK3
        nsxngrDlJZq3zmaewCg8C0n7LCQts5C0zELSsoCRZRWjZGpBcW56brFhgWFearlecWJucWle
        ul5yfu4mRnCEaWnuYLy8JP4QowAHoxIP7w0l/Vgh1sSy4srcQ4wSHMxKIry3XwKFeFMSK6tS
        i/Lji0pzUosPMUpzsCiJ8z7NOxYpJJCeWJKanZpakFoEk2Xi4JRqYAxZwB3Dniym9DfEduk3
        /ZWcvM7imz/0R+Xt0QiSc3414eZzbwZtaaWHCpYCJe+mbfncpWS1ZcuW++HMxgrXF10pW375
        5qPMfRH9GiWvL5ReNVHTXTRTy9BpW/KBNt77sq4Ts89oOEZH2bfWRelJR+68p513xFGvuKLI
        MfSV+ofX6R8N1JKXKbEUZyQaajEXFScCADDxGfGsAgAA
X-CMS-MailID: 20190718090356epcas1p363ba27cd8b2bfbbe4461b2cd790207bb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190707223640epcas4p15337f40466342832b731ad6a53be946e
References: <20190707223303.6755-1-digetx@gmail.com>
        <CGME20190707223640epcas4p15337f40466342832b731ad6a53be946e@epcas4p1.samsung.com>
        <20190707223303.6755-12-digetx@gmail.com>
        <c883bdbe-427f-35a1-9e63-5e4953a84286@samsung.com>
        <53cd0ba5-f814-cd9b-19c5-1d42717ca58c@gmail.com>
        <922c9178-71de-46ad-eafd-805af461bedb@samsung.com>
        <f819c226-4328-c85d-5da3-932391fa6747@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19. 7. 18. 오전 12:46, Dmitry Osipenko wrote:
> 17.07.2019 9:45, Chanwoo Choi пишет:
>> On 19. 7. 16. 오후 10:26, Dmitry Osipenko wrote:
>>> 16.07.2019 15:23, Chanwoo Choi пишет:
>>>> Hi Dmitry,
>>>>
>>>> Usually, the kernel log print for all users
>>>> such as changing the frequency, fail or success.
>>>>
>>>> But, if the log just show the register dump,
>>>> it is not useful for all users. It is just used
>>>> for only specific developer.
>>>>
>>>> I recommend that you better to add more exception handling
>>>> code on many points instead of just showing the register dump.
>>>
>>> The debug messages are not users, but for developers. Yes, I primarily
>>> made the debugging to be useful for myself and will be happy to change
>>> the way debugging is done if there will be any other active developer
>>> for this driver. The registers dump is more than enough in order to
>>> understand what's going on, I don't see any real need to change anything
>>> here for now.
>>
>> Basically, we have to develop code and add the log for anyone.
>> As you commented, even if there are no other developer, we never
>> guarantee this assumption forever. And also, if added debug message
>> for only you, you can add them when testing it temporarily.
>>
>> If you want to add the just register dump log for you,
>> I can't agree. Once again, I hope that anyone understand
>> the meaning of debug message as much possible as.
>>
> 
> The registers dump should be good for everyone because it's a
> self-explanatory information for anyone who is familiar with the
> hardware. I don't think there is a need for anything else than what is
> proposed in this patch, at least for now. I also simply don't see any
> other better way to debug the state of this particular hardware, again
> this logging is for the driver developers and not for users.
> 
> Initially, I was temporarily adding the debug messages. Now they are
> pretty much mandatory for verifying that driver is working properly. And
> of course the debugging messages got into the shape of this patch after
> several iterations of refinements. So again, I suppose that this should
> be good enough for everyone who is familiar with the hardware. And of
> course I'm open to the constructive suggestions, the debugging aid is
> not an ABI and could be changed/improved at any time.
> 
> You're suggesting to break down the debugging into several smaller
> pieces, but I'm finding that as not a constructive suggestion because
> the information about the full hardware state is actually necessary for
> the productive debugging.
> 
> 

Sorry for that as I saie, I cannot agree this patch. In my case,
I don't understand what is meaning of register dump of this patch.
I knew that just register dump are useful for real developer.

If you want to show the register dump, you better to add some feature
with debugfs for devfreq framework in order to read the register dump.
As I knew, sound framework (alsa) has the similar feature for checking
the register dump.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
