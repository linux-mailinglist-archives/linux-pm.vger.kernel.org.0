Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 272426D85B
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jul 2019 03:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbfGSBYO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Jul 2019 21:24:14 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:20003 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbfGSBYM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Jul 2019 21:24:12 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190719012409epoutp01cde05ff688a804ea739de6f37e7396d4~yqnckNuB22881228812epoutp01V
        for <linux-pm@vger.kernel.org>; Fri, 19 Jul 2019 01:24:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190719012409epoutp01cde05ff688a804ea739de6f37e7396d4~yqnckNuB22881228812epoutp01V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563499449;
        bh=Js74kvB2R5be8iTKu9yKko1EhBOAtQlBs/+0JNVC99A=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=VbJFRh7o5zbz57YdjDzM0dD4b3cD5OPrSpl9rIXe+0idFRTRxMlDlhCTHdiJxfxPR
         FsGNn3pT9yF52/dsVEtHCx3gdUMze/J57rtjU2iwxn05FdI3Tnq5vuun7fYLjcTHSp
         Fzxh6hFfLSs+zIAsoIOqe5EjnGwKUWy8ga6hABWc=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190719012408epcas1p3e88dd7e5c5ea87fa9078cbbe997f2c72~yqncCf53K3110631106epcas1p3b;
        Fri, 19 Jul 2019 01:24:08 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.157]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 45qYF22nCXzMqYkj; Fri, 19 Jul
        2019 01:24:06 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        A6.E3.04066.6BB113D5; Fri, 19 Jul 2019 10:24:06 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20190719012405epcas1p4d42b4186c72da723ec153a75399e0a3b~yqnZIUqXS1012210122epcas1p4G;
        Fri, 19 Jul 2019 01:24:05 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190719012405epsmtrp2510256250755bdffcc1d491f32d8eb0d~yqnZHReGH0589805898epsmtrp2e;
        Fri, 19 Jul 2019 01:24:05 +0000 (GMT)
X-AuditID: b6c32a37-e3fff70000000fe2-e9-5d311bb6641a
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        FE.02.03706.5BB113D5; Fri, 19 Jul 2019 10:24:05 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190719012405epsmtip1e057a1387edfa2bd631764aee8d0637b~yqnY57_Mq2297522975epsmtip1x;
        Fri, 19 Jul 2019 01:24:05 +0000 (GMT)
Subject: Re: [PATCH v4 12/24] PM / devfreq: tegra30: Inline all one-line
 functions
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Organization: Samsung Electronics
Message-ID: <97f2a317-989a-bcad-dd45-ccf00ba18cca@samsung.com>
Date:   Fri, 19 Jul 2019 10:27:16 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <92f82420-5c50-468f-a403-7b4c36958076@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTcRTH+W131ykuf67XcVHpDSsl3a5rda206MWikEEFEYjd3K9N3avd
        KVlBLzENl73+qFkWpplWaGKmhkk+MsEsisgKQ9MoKxZlSVlR226R/33OOd/D95zf78ilyhpa
        Jc+wuYjTxlsYOoRqaI9RxzXMYFM1Q4VK7sqnIcTlecoo7v7BD0Hc4+azNDfq7kBc4RcPzb04
        cJnmvjeXUtzRa4/oFcH6xv5ypG/y9Afp3Ye8tP5ofTXSj9bNMsi2Zi0zE95InJHElm43ZthM
        Scz6jWmr0nSLNGwcm8gtZiJtvJUkMas3GOLWZlh8AzGRObwl25cy8ILAqJOXOe3ZLhJptguu
        JIY4jBZHoiNe4K1Cts0Un263LmE1mgSdT7gty1xecoJ2FIbtqn6zYD9yhx5BwXLAC6HK+5Q6
        gkLkStyIoPdSvlQMPiOoLmugxWAMQV9xHvrXMth6XSYWWhA8vzGMxOAjAnffGZlfNRlvgoHL
        4wGmcSy0vu2j/TwFz4XKzp+Bbim+LoGu2qsSfyEMR8GTb0MBCwVOhqZnF4L8TOFoKL7bEtBM
        xVvg80C7TNSEQ/eZYcrPwXg55BcNBfJSPB2eD5+XiDwbDt0okYpj/6bhXuU8kVfDwcqqv/nJ
        8K6rPkhkFYx6W2iR90BVd0dgf8AFCOpbH8rEghZaK076DOQ+gxioaVaL6Sho+nEOib6TwPu1
        SOaXAFZAQb5SlMyBxwP9EpEj4OLhQvoYYjwTtvFM2MAzYQPPf7MLiKpG04hDsJqIwDq0E3+7
        DgWONXZxI6rt3dCGsBwxoQqDVZOqlPE5Qq61DYFcykxRvBhRpyoVRj53N3Ha05zZFiK0IZ3v
        sY9LVVPT7b7Tt7nSWF2CVqvlFrKLdCzLTFeU/oxJVWIT7yJZhDiI81+fRB6s2o+WrpvZmNeM
        qV3jYxGJa96fXvmgN2SH98Phgs6bmS9LK93mjSTnycNM85pVYXSOXlmxc5Sc79leHDZz7YKE
        8F/7zMytGdGGoju7ezInhdQJ9+dH3879+EWS0mPsGs4sGeTf/cgNT1GrX0ckb1aN7E2BsS7q
        VPvs8qjBiFdGU9u0deMMJZh5NlbqFPg/67DCncIDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFIsWRmVeSWpSXmKPExsWy7bCSnO5WacNYgxl/5C1Wf3zMaNEyaxGL
        xdmmN+wWl3fNYbP43HuE0aLzyyw2i9uNK9gsfu6ax2LRt/YSmwOnx467Sxg9ds66y+7R2/yO
        zaNvyypGj8+b5AJYo7hsUlJzMstSi/TtErgylsyexFbQyV+x6rlOA2MvTxcjJ4eEgInEw/0b
        WbsYuTiEBHYzSsye94cRIiEpMe3iUeYuRg4gW1ji8OFiiJq3jBLXrh5jB6kRFgiReLDiFyuI
        zSagJbH/xQ02EFtEQE1i+dE/YEOZBTYzSZw9tZoNonsVs8TDxWfBOvgFFCWu/ngMto1XwE5i
        580FYFNZBFQl+o/tZQKxRQUiJA7vmAVVIyhxcuYTFhCbU8Beoq3nMdgcZgF1iT/zLjFD2OIS
        t57MZ4Kw5SWat85mnsAoPAtJ+ywkLbOQtMxC0rKAkWUVo2RqQXFuem6xYYFhXmq5XnFibnFp
        Xrpecn7uJkZwjGlp7mC8vCT+EKMAB6MSD29ArkGsEGtiWXFl7iFGCQ5mJRHe2y/1Y4V4UxIr
        q1KL8uOLSnNSiw8xSnOwKInzPs07FikkkJ5YkpqdmlqQWgSTZeLglGpg5I7NlRb6JKHvN0/Q
        67XhDbv7290MZF5VOLfv5zzZxx5Q+c/C7r9S7zRfoZrj6aUiIaaMJ408Xv/arvi084/v9I8s
        jI+3T7pidzogLzXPNShGYcV+vfOrj/wJWf3S/K6K8G/lJp70FwYWDYzHr7IkO99M+2y/+WL/
        yXc+J9c533bR36Ql8DBViaU4I9FQi7moOBEA9inVsK0CAAA=
X-CMS-MailID: 20190719012405epcas1p4d42b4186c72da723ec153a75399e0a3b
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
        <92f82420-5c50-468f-a403-7b4c36958076@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19. 7. 19. 오전 10:24, Chanwoo Choi wrote:
> On 19. 7. 19. 오전 10:22, Dmitry Osipenko wrote:
>> В Thu, 18 Jul 2019 18:09:05 +0900
>> Chanwoo Choi <cw00.choi@samsung.com> пишет:
>>
>>> On 19. 7. 16. 오후 10:35, Dmitry Osipenko wrote:
>>>> 16.07.2019 15:26, Chanwoo Choi пишет:  
>>>>> Hi Dmitry,
>>>>>
>>>>> I'm not sure that it is necessary.
>>>>> As I knew, usally, the 'inline' is used on header file
>>>>> to define the empty functions.
>>>>>
>>>>> Do we have to change it with 'inline' keyword?  
>>>>
>>>> The 'inline' attribute tells compiler that instead of jumping into
>>>> the function, it should take the function's code and replace the
>>>> function's invocation with that code. This is done in order to help
>>>> compiler optimize code properly, please see [1]. There is
>>>> absolutely no need to create a function call into a function that
>>>> consists of a single instruction.
>>>>
>>>> [1] https://gcc.gnu.org/onlinedocs/gcc-9.1.0/gcc/Inline.html
>>>>   
>>>
>>> If you want to add 'inline' keyword, I recommend that 
>>> you better to remove the modified function in this patch
>>> and then just call the 'write_relaxed or read_relaxed' function
>>> directly. It is same result when using inline keyword.
>>
>> That could be done, but it makes code less readable.
>>
>> See the difference:
>>
>> device_writel(dev, ACTMON_INTR_STATUS_CLEAR, ACTMON_DEV_INTR_STATUS);
>>
>> writel_relaxed(ACTMON_INTR_STATUS_CLEAR,
>> 	       dev->regs + ACTMON_DEV_INTR_STATUS);
> 
> No problem if you add the detailed comment and you want to use
> the 'inline' keyword.

Basically, I think that 'inline' keyword is not necessary.
But if you want to use 'inline' keyword, I recommend
that call the 'write_relaxed or read_relaxed' function directly
with detailed description. 

> 
>>
>>
>>
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
