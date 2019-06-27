Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36C0B578DE
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2019 03:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbfF0BJO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Jun 2019 21:09:14 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:44477 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726732AbfF0BJO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Jun 2019 21:09:14 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190627010912epoutp01e2304b42991878834e1c6e7f80d50972~r6OHQ-Zy53061830618epoutp01T
        for <linux-pm@vger.kernel.org>; Thu, 27 Jun 2019 01:09:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190627010912epoutp01e2304b42991878834e1c6e7f80d50972~r6OHQ-Zy53061830618epoutp01T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1561597752;
        bh=uInEp3j3G0XFuViWSlYVOQQ4J2ycTL1mKxSrVR72yYo=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=sGd9i/DIFTSxzLIPJYiwEu7+jnmK4Ak/yBcdhjpaLMgKmsh2aLEALtaGiS9jvViln
         BDHK5FPBcWNPAw7rKSwTnpxqIGDFRHNw8l6k61ZvEWIuMpPIwPELR29+06d3QjYUmz
         1kqUVMHbKmuDKDNVUReovkqJh2TyadAm8nPvLu5U=
Received: from epsmges1p4.samsung.com (unknown [182.195.40.156]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190627010906epcas1p399a0674f908891b6c329ccfa1fb128b3~r6OBe0GQz3172831728epcas1p3V;
        Thu, 27 Jun 2019 01:09:06 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        95.63.04257.237141D5; Thu, 27 Jun 2019 10:09:06 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20190627010905epcas1p347586b98c94ed5b6fe4f5672ad568ed1~r6OBEaW1t0997809978epcas1p3o;
        Thu, 27 Jun 2019 01:09:05 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190627010905epsmtrp2743d21a17fa82667ae77e8a2f752423b~r6OBDaI7i0313603136epsmtrp27;
        Thu, 27 Jun 2019 01:09:05 +0000 (GMT)
X-AuditID: b6c32a38-5cbff700000010a1-b0-5d1417320857
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        83.A4.03662.137141D5; Thu, 27 Jun 2019 10:09:05 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190627010905epsmtip2915645a7fefe2d9608ead492f8c1e187~r6OAn7gp81982919829epsmtip2N;
        Thu, 27 Jun 2019 01:09:05 +0000 (GMT)
Subject: Re: [PATCH v4 4/5] Documentation: devicetree: add PPMU events
 description
To:     Lukasz Luba <l.luba@partner.samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     cwchoi00@gmail.com, devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        =?UTF-8?Q?Bart=c5=82omiej_=c5=bbo=c5=82nierkiewicz?= 
        <b.zolnierkie@samsung.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, kyungmin.park@samsung.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com, kgene@kernel.org,
        willy.mh.wolff.ml@gmail.com
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <99a47066-3713-77fa-4afb-6f2f17a2721a@samsung.com>
Date:   Thu, 27 Jun 2019 10:11:43 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <776f58c2-a05c-8fa8-c7f5-458dc17926f6@partner.samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrAJsWRmVeSWpSXmKPExsWy7bCmvq6RuEiswYpNbBYbZ6xntXh2VNti
        /pFzrBb9j18zW5w/v4Hd4mzTG3aLWw0yFpseX2O1uLxrDpvF594jjBYzzu9jslh75C67xdLr
        F5ksbjeuYLNo3XuE3eLwm3ZWi28nHjE6CHqsmbeG0WPnrLvsHptWdbJ5bF5S73Hw3R4mj74t
        qxg9Pm+SC2CPyrbJSE1MSS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQwV1LIS8xNtVVy8QnQ
        dcvMAbpfSaEsMacUKBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQklNgWaBXnJhbXJqXrpecn2tl
        aGBgZApUmJCdse3oFvaCK/wVrWdfsjUw7uLpYuTkkBAwkeiaMYe1i5GLQ0hgB6PEgZ/vGCGc
        T4wSd3esZoNwvjFKXP93kxmmZe/Gl1BVexklHp0/zAThvGeU+P3zBitIlbBAiMS/TYeYQGwR
        gVCJlXtOM4MUMQusZJGYf2U/C0iCTUBLYv+LG2wgNr+AosTVH48ZQWxeATuJxlvn2EFsFgFV
        iYvdL8FsUYEIictbdkHVCEqcnPkEbA6ngLvEh2unwWqYBcQlbj2ZzwRhy0s0b50NtlhC4Bi7
        xPXZzVA/uEi0zzvKDmELS7w6vgXKlpL4/G4vG4RdLbHy5BE2iOYORokt+y+wQiSMJfYvnQy0
        gQNog6bE+l36EGFFiZ2/5zJCLOaTePe1hxWkREKAV6KjTQiiRFni8oO7TBC2pMTi9k62CYxK
        s5C8MwvJC7OQvDALYdkCRpZVjGKpBcW56anFhgUmyPG9iRGcurUsdjDuOedziFGAg1GJh3fF
        TuFYIdbEsuLK3EOMEhzMSiK8SxMFYoV4UxIrq1KL8uOLSnNSiw8xmgJDeyKzlGhyPjCv5JXE
        G5oaGRsbW5gYmpkaGiqJ88Zz34wREkhPLEnNTk0tSC2C6WPi4JRqYOyZmyLM4ix8Zq/U55j5
        EdavmC7n/PlXdTPu2fewjV1bD3qmXQjMX+YWXezU82aNnEV5Gm+Ey2eW6QuPcbp6nfj7vn/W
        7vV5/54/Sl3cb3Hugp6Z25neprPJ3P8VZ3D03J2z7uWzVymBTXuPa64z7s75Ghr3RvzggzWH
        WH9ydWqz3FuYph7+96sSS3FGoqEWc1FxIgB86ve38wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFIsWRmVeSWpSXmKPExsWy7bCSvK6huEiswYbDyhYbZ6xntXh2VNti
        /pFzrBb9j18zW5w/v4Hd4mzTG3aLWw0yFpseX2O1uLxrDpvF594jjBYzzu9jslh75C67xdLr
        F5ksbjeuYLNo3XuE3eLwm3ZWi28nHjE6CHqsmbeG0WPnrLvsHptWdbJ5bF5S73Hw3R4mj74t
        qxg9Pm+SC2CP4rJJSc3JLEst0rdL4MrYdnQLe8EV/orWsy/ZGhh38XQxcnJICJhI7N34krGL
        kYtDSGA3o8StxWeZIBKSEtMuHmXuYuQAsoUlDh8uhqh5yyhxau98dpAaYYEQiX+bDoHViwiE
        SvzvvQo2iFlgJYvEvt6frBAdF5klPr3/xwJSxSagJbH/xQ02EJtfQFHi6o/HjCA2r4CdROOt
        c2BTWQRUJS52vwSzRQUiJPraZrNB1AhKnJz5BGwOp4C7xIdrp8FqmAXUJf7Mu8QMYYtL3Hoy
        nwnClpdo3jqbeQKj8Cwk7bOQtMxC0jILScsCRpZVjJKpBcW56bnFhgVGeanlesWJucWleel6
        yfm5mxjBMayltYPxxIn4Q4wCHIxKPLwrdgrHCrEmlhVX5h5ilOBgVhLhXZooECvEm5JYWZVa
        lB9fVJqTWnyIUZqDRUmcVz7/WKSQQHpiSWp2ampBahFMlomDU6qBkSllTopZcomqHR/roTCT
        qbM2v3qvJ/rzblBd2cGmHU6nhP9ytnrG1r//fVvyeZcqP796w74tD4M+KcfEyKxZpyd1xED0
        xKk3r+NfnBM6uvCi5QuRbFY71qb6aQ+WqcRyrCsqygn55+N07gYzm1TMyWdulcXnquXiLt67
        UNhVu+MLt6JytripEktxRqKhFnNRcSIAlGiJPN0CAAA=
X-CMS-MailID: 20190627010905epcas1p347586b98c94ed5b6fe4f5672ad568ed1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190605091304eucas1p21e0717cafa17a14de569f1773cc7abe5
References: <CGME20190605091304eucas1p21e0717cafa17a14de569f1773cc7abe5@eucas1p2.samsung.com>
        <20190605091236.24263-1-l.luba@partner.samsung.com>
        <20190605091236.24263-5-l.luba@partner.samsung.com>
        <CAGTfZH2kTNWtx=Jp1UJaLN50Qxbq+Q9ThV4vhQ240QbOy1TRMQ@mail.gmail.com>
        <7498059d-95f7-e154-cf49-bcbc8ee6fdb9@partner.samsung.com>
        <CAJKOXPc6304D=HNQnrvhBH6qKxhkf=VQ2Gg6Q2FMP2hYOTYSDQ@mail.gmail.com>
        <776f58c2-a05c-8fa8-c7f5-458dc17926f6@partner.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Lukasz,

On 19. 6. 26. 오후 11:17, Lukasz Luba wrote:
> Hi Krzysztof,
> 
> On 6/26/19 4:03 PM, Krzysztof Kozlowski wrote:
>> On Wed, 26 Jun 2019 at 15:58, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>>>
>>> Hi Chanwoo,
>>>
>>> On 6/26/19 10:23 AM, Chanwoo Choi wrote:
>>>> Hi Lukasz,
>>>>
>>>> 2019년 6월 5일 (수) 18:14, Lukasz Luba <l.luba@partner.samsung.com
>>>> <mailto:l.luba@partner.samsung.com>>님이 작성:
>>>>
>>>>      Extend the documenation by events description with new 'event-data-type'
>>>>      field. Add example how the event might be defined in DT.
>>>>
>>>>      Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com
>>>>      <mailto:l.luba@partner.samsung.com>>
>>>>      Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com
>>>>      <mailto:cw00.choi@samsung.com>>
>>>>      ---
>>>>        .../bindings/devfreq/event/exynos-ppmu.txt    | 26 +++++++++++++++++--
>>>>        1 file changed, 24 insertions(+), 2 deletions(-)
>>>>
>>>>
>>>>
>>>> Acked-by: Chanwoo Choi <cw00.choi@samsung.com
>>>
>>> Thank you for the ACKs for this a 2/5 patch.
>>> Do you think the v4 could be merged now?
>>
>> I think you have all necessary acks. I can take the DTS patch (5/5)
>> although probably for next merge window as I just sent one.
> There was one patch 3/5
> https://protect2.fireeye.com/url?k=82dd0d0cbe2abd04.82dc8643-d13ecd7e5f989b8d&u=https://lkml.org/lkml/2019/6/5/215
> which was waiting ACK or I missed the email somehow.

When I was in vacation, your patches are removed on my email account
because of the email expiration. So, I replied with my Ack through
gmail account on mobile phone. But, there are some problem. My reply
didn't arrive the mailing list.

I have no any way to reply about this at company. After leaving one's
office, I'll reply with Ack again at home.

> 
> Regards,
> Lukasz
> 
>>
>> Best regards,
>> Krzysztof
>>
>>
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
