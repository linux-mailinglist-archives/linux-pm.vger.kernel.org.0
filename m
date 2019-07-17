Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E828B6B6D8
	for <lists+linux-pm@lfdr.de>; Wed, 17 Jul 2019 08:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbfGQGm7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Jul 2019 02:42:59 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:30407 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727097AbfGQGm7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Jul 2019 02:42:59 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190717064257epoutp0113474047d01ff3c9fca6c47c08c12913~yHrOb--9t0860708607epoutp01O
        for <linux-pm@vger.kernel.org>; Wed, 17 Jul 2019 06:42:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190717064257epoutp0113474047d01ff3c9fca6c47c08c12913~yHrOb--9t0860708607epoutp01O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563345777;
        bh=deOsYQPUlsMNAwlQxJO3S1U8Nw9DJ9s0uABjc8BsERQ=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=BHnaHm5AKTBrgWUvevQsY9cDCyiDNCHCOIOGtxeR2NVrlbXHzqN+GciT5cshBPk+c
         5nlNyrzkRpF7VkRMP5VVoRfF26vwCgKQ9WZ/yEG/dSsM8gJLfOe+sfjgTQ/+BVH030
         QuulTzdGIxstD50Zde0FEw/Qg72CeCrw4+cc1IHw=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190717064256epcas1p3200702665b3836af45d8688895799f70~yHrN8A_lO2561825618epcas1p3e;
        Wed, 17 Jul 2019 06:42:56 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.155]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 45pSPl3stlzMqYlt; Wed, 17 Jul
        2019 06:42:51 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        2B.C3.04160.B63CE2D5; Wed, 17 Jul 2019 15:42:51 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190717064250epcas1p1ef8c98ccebcb1dd2400136e35c9c5898~yHrIEMgfv3112331123epcas1p1E;
        Wed, 17 Jul 2019 06:42:50 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190717064250epsmtrp2a1ec681dc33a76fbc0f4d9f542d996d2~yHrICtvjV1492614926epsmtrp2R;
        Wed, 17 Jul 2019 06:42:50 +0000 (GMT)
X-AuditID: b6c32a38-b33ff70000001040-e1-5d2ec36b267c
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        6E.20.03706.A63CE2D5; Wed, 17 Jul 2019 15:42:50 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190717064250epsmtip2ca606eb525683e73ac8e6f2da9065cc6~yHrH20Hq63133131331epsmtip29;
        Wed, 17 Jul 2019 06:42:50 +0000 (GMT)
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
Message-ID: <922c9178-71de-46ad-eafd-805af461bedb@samsung.com>
Date:   Wed, 17 Jul 2019 15:45:58 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <53cd0ba5-f814-cd9b-19c5-1d42717ca58c@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0hTcRTut7td78TVdWqdBpXeitLycadbt2g9yGqgkVDQi2EXd9nEvdjd
        RItiZZmP7EFEtMqyNHrQg7LUkRlOCRUzNMkUKWn0QgwzLbPXtmvkf9/5zvnOOd/5/QhMfhtX
        ENkWB2e3sCYKDxU/9MYmxud4E3RJv+qlzM3ht4g55L4sZtoPDoYwXZ7zODNS1oSY4q9unOk7
        cA1nxj3lYubYrU58jVRb21+JtHXu/hBtWcEQrj1WfQNpR+7NzZDszFlp5Fg9Z4/mLFlWfbbF
        oKHStmSuy1Spk+h4ejmzjIq2sGZOQ6WmZ8RvyDb5F6Kic1mT009lsDxPJa5aabc6HVy00co7
        NBRn05tsy20JPGvmnRZDQpbVvIJOSlKq/IW7c4yHfEpbd2hezdUikQvVECVISgCZAj5XO16C
        Qgk5WYvgm+uxRAi+IPjxqnAyM4bgfWGFPyCCEtcpSuDrEQwfKA0Rgs8ITj95hAX6RpAb4e6J
        a6JAIpL8jaB4vAAPJDByB3jrbooCGCfjoOFDT5CfQcZA9/e3KIBl5CqY8HqD08TkQhisCPaM
        IrdDa1O5WCgJh5azviCWkhrwnBlGQvtZ0Ou7KBLwPCh4cA4L7ADkHxzu3zouEUynQmnVR0zA
        EfDpaXWIgBUwMlSPC3gvXG9pwgVxEYLqhueT4mRoqDolCiyHkbFwx5Mo0DFQN3FhconpMDR6
        VCJcSwZFhXKhZD50vekXCXg2XDlSjJ9AlHuKHfcUC+4pFtz/h11C4htoJmfjzQaOp20pUx/7
        Hgr+1TimFj16lt6ISAJRYTKtN14nl7C5fL65EQGBUZEyzegSnVymZ/P3cHZrpt1p4vhGpPIf
        +ySmiMqy+n++xZFJq5TJyclMCq1W0TQ1S1b+M1YnJw2sg8vhOBtn/6cTEVKFCzEb+xanf20t
        3Lc2YmkHlqZQxp1cdFnbVFKxXpkxZ7i5b66ut/Rd7WCqcmfvh7Lmqj7F6Tq95+LqwbaP1sqw
        gtdei34/MW3Njs1Zijz1Lk8PHO5kxmqu7uoZGEAv27ZtIHarnZtLNj1E6q3GzlTFNHZduPOF
        IbzD92XBeNv1mIlESswbWToOs/PsX5WNQIvBAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBIsWRmVeSWpSXmKPExsWy7bCSvG7WYb1Yg293ZS1Wf3zMaNEyaxGL
        xdmmN+wWl3fNYbP43HuE0aLzyyw2i9uNK9gsfu6ax2LRt/YSmwOnx467Sxg9ds66y+7R2/yO
        zaNvyypGj8+b5AJYo7hsUlJzMstSi/TtErgyWp4YFVzlqti+rIOpgXE7RxcjB4eEgIlEw2Sl
        LkYuDiGB3YwS7xuPsnQxcgLFJSWmXTzKDFEjLHH4cDFEzVtGiVXdc9lBaoQF3CU2TFjBBJIQ
        EWhiktjUewEswSwQKdEzdwsbRMccJok7d5tYQRJsAloS+1/cYAOx+QUUJa7+eMwIYvMK2En8
        PnyYDWQbi4CqxJuFzCBhUYEIiUnXdrJAlAhKnJz5BMzmFLCV2DX9IyPELnWJP/MuMUPY4hK3
        nsxngrDlJZq3zmaewCg8C0n7LCQts5C0zELSsoCRZRWjZGpBcW56brFhgWFearlecWJucWle
        ul5yfu4mRnB8aWnuYLy8JP4QowAHoxIP74cDurFCrIllxZW5hxglOJiVRHhtv2rHCvGmJFZW
        pRblxxeV5qQWH2KU5mBREud9mncsUkggPbEkNTs1tSC1CCbLxMEp1cBoHlOY4Rj34s0Ru57z
        8m1Ndj1WKdxGQRE1MxUu+l7bITl55r0C331PZ965EKTVHT/RTvn6t+rWG+JnH/bpnPLxUg8O
        e1DXJvEx9pVKeFoH77fVt84xaVZOXX7ea43beXdT2S0vUq8xrSgKfT7bUcOJLaL0yJk3zqaF
        dRf0vtz6sohh66SFjb5KLMUZiYZazEXFiQCsvvz6qwIAAA==
X-CMS-MailID: 20190717064250epcas1p1ef8c98ccebcb1dd2400136e35c9c5898
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
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19. 7. 16. 오후 10:26, Dmitry Osipenko wrote:
> 16.07.2019 15:23, Chanwoo Choi пишет:
>> Hi Dmitry,
>>
>> Usually, the kernel log print for all users
>> such as changing the frequency, fail or success.
>>
>> But, if the log just show the register dump,
>> it is not useful for all users. It is just used
>> for only specific developer.
>>
>> I recommend that you better to add more exception handling
>> code on many points instead of just showing the register dump.
> 
> The debug messages are not users, but for developers. Yes, I primarily
> made the debugging to be useful for myself and will be happy to change
> the way debugging is done if there will be any other active developer
> for this driver. The registers dump is more than enough in order to
> understand what's going on, I don't see any real need to change anything
> here for now.

Basically, we have to develop code and add the log for anyone.
As you commented, even if there are no other developer, we never
guarantee this assumption forever. And also, if added debug message
for only you, you can add them when testing it temporarily.

If you want to add the just register dump log for you,
I can't agree. Once again, I hope that anyone understand
the meaning of debug message as much possible as.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
