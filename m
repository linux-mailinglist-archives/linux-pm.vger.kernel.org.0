Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8F96D853
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jul 2019 03:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726015AbfGSBVP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Jul 2019 21:21:15 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:41182 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbfGSBVP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Jul 2019 21:21:15 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190719012111epoutp03290a96567f4165e1d77dfff99cf886b2~yqk3EHETr1386313863epoutp03u
        for <linux-pm@vger.kernel.org>; Fri, 19 Jul 2019 01:21:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190719012111epoutp03290a96567f4165e1d77dfff99cf886b2~yqk3EHETr1386313863epoutp03u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563499271;
        bh=8i7fTUFcI/SDJ3Ggs014esCNo3juctoyUC0Pve9OCu8=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=nKh4nI3FLaRQOpwKEbXa5zU8vypEit/XHWA2G4EohkG0bJmNaKyWV6ADY7vgecJKO
         BppVytiKUNJ/kVmZ96uPabGoMLuOVN+PQhm8+STNFiCaDhM84LyGnFo1PuKAkraISl
         fEewgDslIZYIY98NuhnEEKcDykKaKRZ4nZbh2JzU=
Received: from epsnrtp5.localdomain (unknown [182.195.42.166]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190719012111epcas1p2e6b90841af6c3627582eea48e69cbee0~yqk2nuS9a1279712797epcas1p2G;
        Fri, 19 Jul 2019 01:21:11 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.154]) by
        epsnrtp5.localdomain (Postfix) with ESMTP id 45qY9c4fNfzMqYkp; Fri, 19 Jul
        2019 01:21:08 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        B3.31.04085.40B113D5; Fri, 19 Jul 2019 10:21:08 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190719012108epcas1p2288f8a788bcb6c8f584590d4566450bb~yqkz4fJmL2962429624epcas1p2V;
        Fri, 19 Jul 2019 01:21:08 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190719012108epsmtrp102e95978fff87ca0336d5921a885d3fe~yqkz3sGVh1724117241epsmtrp1d;
        Fri, 19 Jul 2019 01:21:08 +0000 (GMT)
X-AuditID: b6c32a39-d03ff70000000ff5-0d-5d311b049eb8
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        82.F1.03706.40B113D5; Fri, 19 Jul 2019 10:21:08 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190719012108epsmtip1f032be36f67c71a51a2c3c8be7f28741~yqkzsCF0g2009120091epsmtip1S;
        Fri, 19 Jul 2019 01:21:07 +0000 (GMT)
Subject: Re: [PATCH v4 12/24] PM / devfreq: tegra30: Inline all one-line
 functions
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
Message-ID: <92f82420-5c50-468f-a403-7b4c36958076@samsung.com>
Date:   Fri, 19 Jul 2019 10:24:18 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190719042251.37cc9cda@dimatab>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa2xLYRj29ZyedqN8uuFVCXVkki3Z1rOtnGEuMTQxM5mIkGWO9eiW9aan
        G0PiUsY2HSaIjrnfzYZZqsySrSwIYY3EJZOKSVwns06wRrQ9xP49z/s+7/e8z/d9ckLZSKnk
        RWY7bzNzRpqKJpvb4xMTyXFMnsb5Oo691PsWsdtdJ0n20bbPMtbnOUKxfU4vYisCLop9tfU8
        xf701JFsdX0nNTtK5+46jXQ3XV0yndPRQ+mqmy4iXd+18TnSFcUzCnlOz9vUvLnAoi8yGzLo
        hbn5c/O1UzRMIpPOTqXVZs7EZ9CZWTmJ84uMoYVodSlnLAmVcjhBoJNnzrBZSuy8utAi2DNo
        3qo3WtOtSQJnEkrMhqQCi2kao9GkaEPCVcWF5Zd/Say+Yevdnq/SLagquhJFyQGnge9OJ1WJ
        ouVK7EZwL1BFiOQbggOOE3/JdwS/3bXkv5Hm5hqZ2GhBUH3mKCmSrwg8DU+JsCoGLwX/+V/S
        MI7Fk+Hc3aA0LCLwVQl0NF6WhBsUToDW98+pMB6BJ8KzH29RGCvwTPC390aGSRwHQcfeSH0U
        Xg7f/O1SUTMS7h/ujqwUhZPg845DEWMCj4GX3cckIp4Ajhu1kQyAHTJ4sL0yROQhkglf3qnF
        ODHwsaNJJmIVfNhT/hdvhAv3vZQ4uwtBU+sTqdhIhdYz+yXhcwgcDw2eZLE8EW4OHEWi73Do
        6d8tFa0UsKtcKUomgc/fJRHxWDi1s4Lai2jXoDSuQQlcgxK4/psdR+RFNJq3CiYDLzBW7eDn
        voYivzUh3Y3uPc5qQ1iO6GGKHJMmTynlSoUyUxsCOUHHKl59SM5TKvRc2QbeZsm3lRh5oQ1p
        Q5e9j1CNKrCE/r7Zns9oU1JTU9k0ZoqWYegxirpgfJ4SGzg7X8zzVt72b04ij1JtQWmbnLn9
        9beHzFISFTesTq/SoOvWTCp+UbAGD2wcGBrdF3wQiJnQtvRKd2c2P7Ih9+HvOS36dV7V6MXq
        dm/jAvbFhowl1z2rM71vig7+4D6eHVhQteyZac3telvL5nmBqdP3VR5e53+ZsnbRyZoeQzDd
        geL041XESl/2kcCVhV23PtGkUMgxCYRN4P4A7eJK0sMDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFIsWRmVeSWpSXmKPExsWy7bCSnC6LtGGswb0J7BarPz5mtGiZtYjF
        4mzTG3aLy7vmsFl87j3CaNH5ZRabxe3GFWwWP3fNY7HoW3uJzYHTY8fdJYweO2fdZffobX7H
        5tG3ZRWjx+dNcgGsUVw2Kak5mWWpRfp2CVwZbWt+MRVc5qnYses9awNjN1cXIyeHhICJxLZt
        k9i7GLk4hAR2M0p8XvqTCSIhKTHt4lHmLkYOIFtY4vDhYoiat4wS3x5OYwOpERYIkXiw4hcr
        iC0ioCax/OgfVpAiZoHNTBJnT60GKxIS+MokseNWCIjNJqAlsf/FDbA4v4CixNUfjxlBbF4B
        O4kHhz+CDWIRUJX40zwBLC4qECFxeMcsqBpBiZMzn7CA2JwCehJvWqczg9jMAuoSf+ZdgrLF
        JW49mc8EYctLNG+dzTyBUXgWkvZZSFpmIWmZhaRlASPLKkbJ1ILi3PTcYsMCw7zUcr3ixNzi
        0rx0veT83E2M4BjT0tzBeHlJ/CFGAQ5GJR7egFyDWCHWxLLiytxDjBIczEoivLdf6scK8aYk
        VlalFuXHF5XmpBYfYpTmYFES532adyxSSCA9sSQ1OzW1ILUIJsvEwSnVwGgjuLFD8f3dpWvc
        Hy03mny7W85wtoNHzmnBMku1nJf7+ZTXaMWz3l/1/cFq0002LosvPWBNDnLVjt2TtG6S0y7L
        lL8MDX9dGUKu1d+f+cra4vJzi79WIV+Xc3ULev/e+l/x2fNvbgVdiyPXnyjYwTlnyyadbQKh
        Os0v2x0Mvpr2nuNd4bHAOUyJpTgj0VCLuag4EQBYo5r8rQIAAA==
X-CMS-MailID: 20190719012108epcas1p2288f8a788bcb6c8f584590d4566450bb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190707223633epcas4p3873704f3199126be0e8d5cb7454c7a51
References: <20190707223303.6755-1-digetx@gmail.com>
        <CGME20190707223633epcas4p3873704f3199126be0e8d5cb7454c7a51@epcas4p3.samsung.com>
        <20190707223303.6755-13-digetx@gmail.com>
        <b5634fbe-8bc1-0f04-e13b-6345dfbb5615@samsung.com>
        <b7da3fa2-00d1-5bd6-408c-202c85be917d@gmail.com>
        <45621f73-2f86-cde7-a92e-2a34810b9c05@samsung.com>
        <20190719042251.37cc9cda@dimatab>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19. 7. 19. 오전 10:22, Dmitry Osipenko wrote:
> В Thu, 18 Jul 2019 18:09:05 +0900
> Chanwoo Choi <cw00.choi@samsung.com> пишет:
> 
>> On 19. 7. 16. 오후 10:35, Dmitry Osipenko wrote:
>>> 16.07.2019 15:26, Chanwoo Choi пишет:  
>>>> Hi Dmitry,
>>>>
>>>> I'm not sure that it is necessary.
>>>> As I knew, usally, the 'inline' is used on header file
>>>> to define the empty functions.
>>>>
>>>> Do we have to change it with 'inline' keyword?  
>>>
>>> The 'inline' attribute tells compiler that instead of jumping into
>>> the function, it should take the function's code and replace the
>>> function's invocation with that code. This is done in order to help
>>> compiler optimize code properly, please see [1]. There is
>>> absolutely no need to create a function call into a function that
>>> consists of a single instruction.
>>>
>>> [1] https://gcc.gnu.org/onlinedocs/gcc-9.1.0/gcc/Inline.html
>>>   
>>
>> If you want to add 'inline' keyword, I recommend that 
>> you better to remove the modified function in this patch
>> and then just call the 'write_relaxed or read_relaxed' function
>> directly. It is same result when using inline keyword.
> 
> That could be done, but it makes code less readable.
> 
> See the difference:
> 
> device_writel(dev, ACTMON_INTR_STATUS_CLEAR, ACTMON_DEV_INTR_STATUS);
> 
> writel_relaxed(ACTMON_INTR_STATUS_CLEAR,
> 	       dev->regs + ACTMON_DEV_INTR_STATUS);

No problem if you add the detailed comment and you want to use
the 'inline' keyword.

> 
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
