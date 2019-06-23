Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3FD4FF2F
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2019 04:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbfFXCQl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 23 Jun 2019 22:16:41 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:22531 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbfFXCQl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 23 Jun 2019 22:16:41 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190623234831epoutp03f8d6e375f058c64f51ea10fc1d23646a~q_L0Y5VVL0095200952epoutp030
        for <linux-pm@vger.kernel.org>; Sun, 23 Jun 2019 23:48:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190623234831epoutp03f8d6e375f058c64f51ea10fc1d23646a~q_L0Y5VVL0095200952epoutp030
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1561333711;
        bh=y5JFwrOZq4d42qzJPkw+Zg+TcIER/Wk/VIKyGC4xXtM=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=ZROOufcthysiq9fS5Ltd8c6Dx5aWt+gIVm844JI6QoJpm/HScuN0loVoZU9aW1Put
         +uHq2Ab/UTYaNPfVOjKy+8rYxbN+J3ehT7mR+gyN9IpPjKGcBURZp3mEIMNXtwPd/p
         5BW7lWaXJOrD3/n0+45cQP8GNsUCSdFRFcxViUgg=
Received: from epsmges1p4.samsung.com (unknown [182.195.40.158]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190623234827epcas1p13e2ecfb1ca561a0b2c3a901536393930~q_Lv3tEc_0191701917epcas1p1O;
        Sun, 23 Jun 2019 23:48:27 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        4D.7E.04257.2CF001D5; Mon, 24 Jun 2019 08:48:18 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20190623234817epcas1p394d0ec7c278969f0b2e3d73c45df407a~q_LnCE6ds0503705037epcas1p3f;
        Sun, 23 Jun 2019 23:48:17 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190623234817epsmtrp10e6374e407264530a6ab2f883a9634cb~q_LnBOmNw2617626176epsmtrp1E;
        Sun, 23 Jun 2019 23:48:17 +0000 (GMT)
X-AuditID: b6c32a38-5e3ff700000010a1-1f-5d100fc2f8bf
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        2C.AF.03662.1CF001D5; Mon, 24 Jun 2019 08:48:17 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190623234817epsmtip1264e7902c17275a3cf2cc2e0c14370f0~q_Lm5JBod0344203442epsmtip1y;
        Sun, 23 Jun 2019 23:48:17 +0000 (GMT)
Subject: Re: [PATCH v4 00/16] NVIDIA Tegra devfreq improvements and
 Tegra20/30 support
To:     Dmitry Osipenko <digetx@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <31fc1430-5a3b-cccb-06bb-7b46081edb68@samsung.com>
Date:   Mon, 24 Jun 2019 08:50:53 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <389cc71d-8f0b-fa39-1325-433d27c75dc8@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIJsWRmVeSWpSXmKPExsWy7bCmvu4hfoFYg2f/NS1Wf3zMaNEyaxGL
        xdmmN+wWl3fNYbP43HuE0aLzyyw2i9uNK9gsfu6ax2LRt/YSmwOnx467Sxg9ds66y+7R2/yO
        zaNvyypGj8+b5AJYo7JtMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22V
        XHwCdN0yc4AOUlIoS8wpBQoFJBYXK+nb2RTll5akKmTkF5fYKqUWpOQUWBboFSfmFpfmpesl
        5+daGRoYGJkCFSZkZyx6sJqp4IFkRdOHWYwNjEdFuhg5OSQETCR23bvH3sXIxSEksINRYsm0
        xUwQzidGiQ1n30E53xglTp/+ygbT8nP/V2aIxF5Gic7OB1D97xkljn84D1YlLBAh8WrROmYQ
        W0QgUOLds31gHcwCbUwS7Rf/MoEk2AS0JPa/uAHWwC+gKHH1x2NGEJtXwE7ief8nVhCbRUBV
        ovntBLAaUaChl7fsgqoRlDg58wkLiM0pYCsx/8txsGXMAuISt57MZ4Kw5SWat84GWywh8J9N
        YmLnR6gfXCR2fO9mgbCFJV4d38IOYUtJvOxvg7KrJVaePMIG0dzBKLFl/wVWiISxxP6lk4E2
        cABt0JRYv0sfIqwosfP3XEaIxXwS7772sIKUSAjwSnS0CUGUKEtcfnCXCcKWlFjc3sk2gVFp
        FpJ3ZiF5YRaSF2YhLFvAyLKKUSy1oDg3PbXYsMAEOb43MYKTq5bFDsY953wOMQpwMCrx8Aps
        4I8VYk0sK67MPcQowcGsJMLLk8MTK8SbklhZlVqUH19UmpNafIjRFBjaE5mlRJPzgYk/ryTe
        0NTI2NjYwsTQzNTQUEmcN577ZoyQQHpiSWp2ampBahFMHxMHp1QDo+fzoN2zf6ZtuhYdz3jY
        JbWtoTgl+seu/gStxoQIcQF1rx3nzN6sDNz/4MoMtg2K5U+uWQud/fkwLY43aG/Y2jdZbomW
        x/u9n2noJ8w7+jI8fq9F2uOE2DPdh1XaUqaVneLuXR6Y8WHryen5Md7VTovj+b6z7FW8WaEd
        M8NkzhoFfUHBfO8uJZbijERDLeai4kQAQ/dOV8QDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFIsWRmVeSWpSXmKPExsWy7bCSnO5BfoFYg4uv5CxWf3zMaNEyaxGL
        xdmmN+wWl3fNYbP43HuE0aLzyyw2i9uNK9gsfu6ax2LRt/YSmwOnx467Sxg9ds66y+7R2/yO
        zaNvyypGj8+b5AJYo7hsUlJzMstSi/TtErgyFj1YzVTwQLKi6cMsxgbGoyJdjJwcEgImEj/3
        f2UGsYUEdjNKnF+UDBGXlJh28ShQnAPIFpY4fLi4i5ELqOQto8TSiRvYQGqEBSIk5l+4xARi
        iwgESpx+sJURpIhZoINJ4sn6n4wQHfuZJbZ3fWUBqWIT0JLY/+IGWDe/gKLE1R+PGUFsXgE7
        ief9n1hBbBYBVYnmtxPAakSBNvS1zWaDqBGUODnzCdgcTgFbiflfjoNdzSygLvFn3iUoW1zi
        1pP5TBC2vETz1tnMExiFZyFpn4WkZRaSlllIWhYwsqxilEwtKM5Nzy02LDDKSy3XK07MLS7N
        S9dLzs/dxAiOMS2tHYwnTsQfYhTgYFTi4RXYwB8rxJpYVlyZe4hRgoNZSYSXJ4cnVog3JbGy
        KrUoP76oNCe1+BCjNAeLkjivfP6xSCGB9MSS1OzU1ILUIpgsEwenVANj/+8vs1ifhtToZJkH
        CDx7PdFDblXhXgf7EuV6x6nfo1abMnqyFmv++TtntYssR5LKQdOw78cc5ir5tYkfXrNyYqar
        VefF5ztzA4zLOx9uWvt1WVu2n0b0p30zJ3q9WahrJDmH8ZqG0GcOR5Wltcqnrn15ZXb50iMW
        dp2Md28n3VhnerJKPnCGEktxRqKhFnNRcSIAPNA1Pa0CAAA=
X-CMS-MailID: 20190623234817epcas1p394d0ec7c278969f0b2e3d73c45df407a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190501234148epcas5p1cc9a8dafa9ee6d8d046d1292b8270727
References: <CGME20190501234148epcas5p1cc9a8dafa9ee6d8d046d1292b8270727@epcas5p1.samsung.com>
        <20190501233815.32643-1-digetx@gmail.com>
        <60ef6e47-e61b-3a92-e90d-90debedfcfc4@samsung.com>
        <fa061a65-f108-6c5e-1f87-950a9a8caafc@gmail.com>
        <0fb50eb1-a173-1756-6889-2526a10ac707@gmail.com>
        <683b343a-e64f-8345-ac44-10f5c00521bd@samsung.com>
        <5c2a7c32-a98c-3930-14ae-beb0241908d0@gmail.com>
        <389cc71d-8f0b-fa39-1325-433d27c75dc8@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Dmitry,

On 19. 6. 24. 오전 2:17, Dmitry Osipenko wrote:
> 05.06.2019 2:09, Dmitry Osipenko пишет:
>> 04.06.2019 3:49, Chanwoo Choi пишет:
>>> On 19. 6. 4. 오전 1:52, Dmitry Osipenko wrote:
>>>> 03.05.2019 3:52, Dmitry Osipenko пишет:
>>>>> 03.05.2019 3:31, Chanwoo Choi пишет:
>>>>>> Hi Dmitry,
>>>>>>
>>>>>> On 19. 5. 2. 오전 8:37, Dmitry Osipenko wrote:
>>>>>>> Changelog:
>>>>>>>
>>>>>>> v4: Addressed all review comments that were made by Chanwoo Choi to v3:
>>>>>>>
>>>>>>>     - changed the driver removal order to match the probe exactly
>>>>>>>     - added clarifying comment for 1/8 ratio to the Tegra20 driver
>>>>>>>
>>>>>>>     Chanwoo, please also note that the clk patch that should fix
>>>>>>>     compilation problem that was reported the kbuild-test-robot is already
>>>>>>>     applied and available in the recent linux-next.
>>>>>>
>>>>>> I knew that Stephen picked up your path about clock.
>>>>>
>>>>> Hi Chanwoo,
>>>>>
>>>>> Okay, good. Thank you very much for reviewing this series! I assume it's
>>>>> too late now for v5.2, but it should be good to go for v5.3.
>>>>>
>>>>
>>>> Hello Chanwoo,
>>>>
>>>> Will be nice to see the patches in the linux-next before they'll hit mainline. We have tested that
>>>> everything works fine on a selective devices, but won't hurt to get some extra testing beforehand.
>>>> AFAIK, at least NVIDIA people are regularly testing -next on theirs dev boards. Please note that
>>>> this not very important, so don't bother if there is some hurdle with pushing to the tracking branch
>>>> for now. Also please let me know if you're expecting to see some ACK's on the patches, I'm sure
>>>> we'll be able to work out that with Thierry and Jon if necessary.
>>>>
>>>>
>>>
>>> Hi Dmitry,
>>> I think that it is enough for applying to mainline branch.
>>> The devfreq.git is maintained by Myungjoo. He will be merged or
>>> reviewed if there are th remained review point.
>>
>> Thank you very much!
>>
>>>
>>> Hi Myungjoo,
>>> I reviewed the Dmitry's patches from v1 to v4 patches.
>>> And then I tested them on my testing branch[1] for catching
>>> the build warning and error. In result, it is clean.
>>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git/log/?h=devfreq-testing
>>>
>>> Please review or apply these patches for v5.3.
>>>
>>
>> Hello Myungjoo,
>>
>> I think this patchset should be completed now. Thierry has some extra
>> comments to the patches, but seems nothing critical so far and all the
>> concerns could be addressed in a follow-up series. Please let me know if
>> you're fine with this, I can re-spin v5 as well if necessary.
>>
> 
> Hello Chanwoo,
> 
> It looks like Myungjoo is inactive at the moment. Do you know if he'll
> be back to the time of the merge window opening or you'll be curating
> the pull request for 5.3 this time?

Myungoo works in the same place. I'll talk with him.

> 
> Secondly, I'll send a few more patches on top of this series, addressing
> Thierry's comments and making more improvements. Please let me know if
> this causes any problems and I should re-spin the whole series.

OK. I'll review them.


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
