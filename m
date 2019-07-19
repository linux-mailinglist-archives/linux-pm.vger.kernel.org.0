Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2925C6D84E
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jul 2019 03:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbfGSBTj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Jul 2019 21:19:39 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:40229 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfGSBTi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Jul 2019 21:19:38 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190719011935epoutp03bb595200f27c43bd2645acc705c4baf7~yqjdZwkNc1258112581epoutp03X
        for <linux-pm@vger.kernel.org>; Fri, 19 Jul 2019 01:19:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190719011935epoutp03bb595200f27c43bd2645acc705c4baf7~yqjdZwkNc1258112581epoutp03X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563499175;
        bh=Nc13DWUl6dSRnsOicCx7FQYy9R73zATL5Zwi93HiA9Q=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=BT902Wo7/AWyzgxZMSexOfebBNAuzI5f3rykp13T1rWNE+/z7+fa8Q7XQY67E5vDX
         7tW+yDgqCd3l1wYrbkMWHU92hWqYX6KhiSllF3arcmHcpbOkZgv5WHMijjWH587ukn
         ZfndDmoAJBwOaq5f4ue6zOC0r7CpNRUHFKy43dA8=
Received: from epsnrtp6.localdomain (unknown [182.195.42.167]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190719011934epcas1p482a91fabeab52abb43c591f48fec51e6~yqjc_qXRx2609726097epcas1p4L;
        Fri, 19 Jul 2019 01:19:34 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.153]) by
        epsnrtp6.localdomain (Postfix) with ESMTP id 45qY7m4tFNzMqYkl; Fri, 19 Jul
        2019 01:19:32 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        98.3D.04075.F9A113D5; Fri, 19 Jul 2019 10:19:27 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190719011927epcas1p1a5bd6d20763dd44bffe8472e037a2b47~yqjVyuXUw1387913879epcas1p1G;
        Fri, 19 Jul 2019 01:19:27 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190719011927epsmtrp2e9ba7d349ff758a250197895ea3facb3~yqjVx6o0C0384903849epsmtrp21;
        Fri, 19 Jul 2019 01:19:27 +0000 (GMT)
X-AuditID: b6c32a36-b49ff70000000feb-da-5d311a9f1b1e
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        0C.D1.03706.F9A113D5; Fri, 19 Jul 2019 10:19:27 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190719011927epsmtip1ed4d28c3a43f7239061cef5a85c01e9e~yqjVnssbt2014720147epsmtip1t;
        Fri, 19 Jul 2019 01:19:26 +0000 (GMT)
Subject: Re: [PATCH v4 11/24] PM / devfreq: tegra30: Add debug messages
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <a5e0c217-280f-a420-4604-3872a17f5c96@samsung.com>
Date:   Fri, 19 Jul 2019 10:22:37 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190719041357.0a80a2dc@dimatab>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se2xLcRTH/Xpvb1uUnzI7Gma7Dckq23pXnUts8YpVmEwkgqi5Wa9u1t42
        vZ2MSbwfW2yIP8RlNjbmMTYzsi1kNmQm8SYRy2i8HzOqHlsQ2l5i/33O8/s753fUhO4MpVfn
        Cj7eK3BOmhpIXrgSn5RQrmdspr6nBvZU4Dlit0hHSPbmpm4Ve7/5IMUGS64ituiLRLGdG49T
        bF/zIZItPX2PmqaxNnZVIWuT1KWylmzuoaylDSeRNVgfk6lcmjc1h+fsvDeWF7Ld9lzBkUrP
        XZg1M8uSYmISmMnsJDpW4Fx8Kj1rXmbC7Fxn6EF07GrOmR9yZXKiSCelTfW68318bI5b9KXS
        vMfu9Ez2JIqcS8wXHInZbtcUxmRKtoQSV+Tl/Apgzy1DQeBCjXIDqhldjDRqwBNBelKmKEYD
        1TrciCAYeP/X+Iygt+WMUja+IdjUWkkWI3Wk5FPTBNl/CcGr1xWkbHxEUF3aSob7DsfpULf7
        uCLMI/B4qL72M9KJwGcV0F5XEwlQ2Agtbx5RYR6K4+Bh73MUZi1Og0fPNqrCTOJx4P90Wxnm
        KLwYPvuvKOWcYdCx/0VETIMTof51ZcRP4Gh4/KJcIfNY2Hz+ABEWBvybgmO1pwh5hFnQfcIm
        L2A4vGtvUMmsh2DPJUrmQjjRcZWSa3cgaGi5o5QDZmg5ulcR7kPgeKhtTpLdcdD0owzJukOg
        5+tOpSylhR3bdHKKAe77uxQyj4LK7UXUbkRL/aaR+k0g9ZtA+i9WgciTaCTvEV0OXmQ8yf0/
        ux5FbtWY0oiO3JrXhrAa0YO1vatMNp2SWy2ucbUhUBP0CG3n2ySbTmvn1qzlve4sb76TF9uQ
        JbTsPYQ+KtsdunzBl8VYks1mMzuRSbEwDB2tPfQz3qbDDs7H5/G8h/f+q1OoNfoNaPld86Dp
        +4pe5kbFF0QXlmekZWcstaxfX3e5SrBu7SwjYto/SMmGi27XvqIlF1uXGbe0N/lrzOf4G4a3
        txfZm990rMyLOzzKpekrGV3hWBc0rjivRdcCwq5a/6Tu712mOSljHg9VFcaUVJcvum6YNr+g
        rlHlZAak7/pyVPPg44IZNpoUczjGSHhF7g+QS6K0wQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJIsWRmVeSWpSXmKPExsWy7bCSnO58KcNYg6Wr2S1Wf3zMaNEyaxGL
        xdmmN+wWl3fNYbP43HuE0aLzyyw2i9uNK9gsfu6ax2LRt/YSmwOnx467Sxg9ds66y+7R2/yO
        zaNvyypGj8+b5AJYo7hsUlJzMstSi/TtErgy/n4UKDinXPFx2xrWBsY1Ml2MHBwSAiYSH3Zq
        dzFycQgJ7GaU2LRuFmMXIydQXFJi2sWjzBA1whKHDxdD1LxllJh97A87SI2wgLvEhgkrmEBs
        EQE1ieVH/7CCFDELbGaSOHtqNRtEx11miSUHe8Cq2AS0JPa/uMEGYvMLKEpc/fEYbBuvgJ3E
        jUeNYFNZBFQlHnw4zwpiiwpESBzeMQuqRlDi5MwnLCA2p4CexKbni8FqmAXUJf7Mu8QMYYtL
        3HoynwnClpdo3jqbeQKj8Cwk7bOQtMxC0jILScsCRpZVjJKpBcW56bnFhgWGeanlesWJucWl
        eel6yfm5mxjBEaaluYPx8pL4Q4wCHIxKPLwBuQaxQqyJZcWVuYcYJTiYlUR4b7/UjxXiTUms
        rEotyo8vKs1JLT7EKM3BoiTO+zTvWKSQQHpiSWp2ampBahFMlomDU6qBUbwxVeq7LntL74Vl
        QsvXq5r+8e1zzt636HtV4wGOo5VzynKcNhsv0nvy7OpEtw9PVUMc9d60WX1Q8eg6Xe6b+SR+
        exh7dD//XJO7citZZt2sXnGEtdF8TpnbcaYDzX2i56Rzw1oluIKC/4t5srBEKWjPvrLT8/E5
        UzPbnEi545MZ8yd4pP9UYinOSDTUYi4qTgQAoUyDVawCAAA=
X-CMS-MailID: 20190719011927epcas1p1a5bd6d20763dd44bffe8472e037a2b47
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
        <f630dacc-2065-a12d-bd03-1fc6c4363e1f@samsung.com>
        <20190719041357.0a80a2dc@dimatab>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19. 7. 19. 오전 10:13, Dmitry Osipenko wrote:
> В Thu, 18 Jul 2019 18:07:05 +0900
> Chanwoo Choi <cw00.choi@samsung.com> пишет:
> 
>> On 19. 7. 18. 오전 12:46, Dmitry Osipenko wrote:
>>> 17.07.2019 9:45, Chanwoo Choi пишет:  
>>>> On 19. 7. 16. 오후 10:26, Dmitry Osipenko wrote:  
>>>>> 16.07.2019 15:23, Chanwoo Choi пишет:  
>>>>>> Hi Dmitry,
>>>>>>
>>>>>> Usually, the kernel log print for all users
>>>>>> such as changing the frequency, fail or success.
>>>>>>
>>>>>> But, if the log just show the register dump,
>>>>>> it is not useful for all users. It is just used
>>>>>> for only specific developer.
>>>>>>
>>>>>> I recommend that you better to add more exception handling
>>>>>> code on many points instead of just showing the register dump.  
>>>>>
>>>>> The debug messages are not users, but for developers. Yes, I
>>>>> primarily made the debugging to be useful for myself and will be
>>>>> happy to change the way debugging is done if there will be any
>>>>> other active developer for this driver. The registers dump is
>>>>> more than enough in order to understand what's going on, I don't
>>>>> see any real need to change anything here for now.  
>>>>
>>>> Basically, we have to develop code and add the log for anyone.
>>>> As you commented, even if there are no other developer, we never
>>>> guarantee this assumption forever. And also, if added debug message
>>>> for only you, you can add them when testing it temporarily.
>>>>
>>>> If you want to add the just register dump log for you,
>>>> I can't agree. Once again, I hope that anyone understand
>>>> the meaning of debug message as much possible as.
>>>>  
>>>
>>> The registers dump should be good for everyone because it's a
>>> self-explanatory information for anyone who is familiar with the
>>> hardware. I don't think there is a need for anything else than what
>>> is proposed in this patch, at least for now. I also simply don't
>>> see any other better way to debug the state of this particular
>>> hardware, again this logging is for the driver developers and not
>>> for users.
>>>
>>> Initially, I was temporarily adding the debug messages. Now they are
>>> pretty much mandatory for verifying that driver is working
>>> properly. And of course the debugging messages got into the shape
>>> of this patch after several iterations of refinements. So again, I
>>> suppose that this should be good enough for everyone who is
>>> familiar with the hardware. And of course I'm open to the
>>> constructive suggestions, the debugging aid is not an ABI and could
>>> be changed/improved at any time.
>>>
>>> You're suggesting to break down the debugging into several smaller
>>> pieces, but I'm finding that as not a constructive suggestion
>>> because the information about the full hardware state is actually
>>> necessary for the productive debugging.
>>>
>>>   
>>
>> Sorry for that as I saie, I cannot agree this patch. In my case,
>> I don't understand what is meaning of register dump of this patch.
>> I knew that just register dump are useful for real developer.
> 
> It's not only a registers dump, as you may see there is also a dump of
> other properties like boosting value, OPPs selection and etc.
> 
> It looks to me that you're also missing important detail that debug
> messages are compiled out unless DEBUG is defined for the drivers
> build. So in order to get the debug message a user shall explicitly add
> #define DEBUG macro to the code or enable debug messages globally in
> the kernel's config. There is also an option for dynamic debug messages
> in the kernel, but it doesn't matter now because all these messages are
> turned into tracepoints later in the patch #17.


Right. But, this patch could not the split up between register dump and others.
As I said repeatly, I hope to add the log that anyone can understand. 


> 
>> If you want to show the register dump, you better to add some feature
>> with debugfs for devfreq framework in order to read the register dump.
>> As I knew, sound framework (alsa) has the similar feature for checking
>> the register dump.
>>
> 
> The intent was to have an option for dynamic debugging of the driver and
> initially debug messages were good enough, but then it became not enough
> and hence the debug messages were turned into tracepoints in the patch
> #17. Would it be acceptable to squash this patch and #17?
> 
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
