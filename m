Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E66C15806A
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2019 12:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbfF0KbP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Jun 2019 06:31:15 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:38245 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbfF0KbO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Jun 2019 06:31:14 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190627103113euoutp02a7004a65c061a895bfbacde516d730db~sB40NFjRa3142931429euoutp024
        for <linux-pm@vger.kernel.org>; Thu, 27 Jun 2019 10:31:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190627103113euoutp02a7004a65c061a895bfbacde516d730db~sB40NFjRa3142931429euoutp024
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1561631473;
        bh=9qMksaSn2o1RzY5tC5OZ+NxmFvebkX7TJu1+xGfBCiw=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=ccL1ZDEHKxyJ2Fn81kIcR92zG9FOs3MjLjrzdmi8mKJrr0zbqMsPS7DztwbH5+1j4
         AqAJok66BCDtV2v74jPvbCC/Ax5zDl2AO9m6QL6UFE0QKKyuwQ9iobhBTUnJ+DG+vs
         O2hGtr5ZbiRd7QpBkP8fnaA/qNaArNu+2nFGrUpQ=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190627103112eucas1p1ae22251d569889712181490145817bea~sB4zUOgNn3171631716eucas1p1V;
        Thu, 27 Jun 2019 10:31:12 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 91.F0.04298.FEA941D5; Thu, 27
        Jun 2019 11:31:11 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190627103111eucas1p204450a032db835ba18a70d12939384e9~sB4yiP0K41122111221eucas1p2Y;
        Thu, 27 Jun 2019 10:31:11 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190627103111eusmtrp25aa2911c568498975452e64c9e863a35~sB4yUDhim0413004130eusmtrp2H;
        Thu, 27 Jun 2019 10:31:11 +0000 (GMT)
X-AuditID: cbfec7f2-f13ff700000010ca-71-5d149aef4419
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 04.30.04140.FEA941D5; Thu, 27
        Jun 2019 11:31:11 +0100 (BST)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190627103110eusmtip2f3f2e980cd4c4b326eada11fb687fe3e~sB4xhqKXS1415414154eusmtip2e;
        Thu, 27 Jun 2019 10:31:10 +0000 (GMT)
Subject: Re: [PATCH v4 4/5] Documentation: devicetree: add PPMU events
 description
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>, cwchoi00@gmail.com
Cc:     devicetree <devicetree@vger.kernel.org>,
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
From:   Lukasz Luba <l.luba@partner.samsung.com>
Message-ID: <3fdba210-2ca1-9fe3-c886-25d1d13bb133@partner.samsung.com>
Date:   Thu, 27 Jun 2019 12:31:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <99a47066-3713-77fa-4afb-6f2f17a2721a@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0zNYRjHe3/3mpO306HHZdhpuTWFyd4wl2ntZGwNWZOWQ79VqhPnJ1Qu
        uSvdpFyOJJHSaumoVijdFItSTbXMZsplKaxTDBN+/TL9932e5/Ncvu9egVZ3s1OFEMNe0WjQ
        h2k5G6as4Xvzgs8mjf/C0kZ3UnypiCWdQ+9Z8u6RM7lW38yS5J6PNGlpucOTZ8f6eWLu6WBJ
        +70MjlgS6xG51FJFkcL6VzzJ6WylyMujeRw5WVnPk7r+0yz5+vgNWm2nK8gsQLoK0yteZ86P
        43R3bx7RJZXkI53FPMOb22qzIlAMC9knGl1XbrcJTmlOYnefwAeGf3rHor4J8chaALwE0s7W
        0PHIRlDjPATF2Sc5JRhC0FDdwMuUGlsQpOfOiEfCaEfVF43C5CLoGMyglGAAwdMPPxi5wR5v
        hhFzLSVrDRbhx/AvJEM0Tmfga00cJ0/isAuU5++RGRX2hG+WaiSnGewEZ/I85PQk7AtDFWak
        IHbw5HLv6HhrvAqy497SsqaxA3T3XqMUPROOl14ZdQP4Fw9l7amMYtMDylpfIEXbQ19jCa/o
        6fC7QmkGLEFs4vUx5iD0JF8dY5ZDXWMrK99G43lQdM9VeYc18CR7oiJtoWvATrnAFlLLLtJK
        WgVnTqmVGXOhJOH52J7JkFtwgU9BWtM4X6ZxXkzjvJj+r81CTD5yECOl8CBRWmQQ97tI+nAp
        0hDksjMi3Iz+/rimkcbBcjTctqMWYQFpJ6isHtj7q1n9PikqvBaBQGs1qogtGn+1KlAfFS0a
        IwKMkWGiVIumCYzWQRVj9dpPjYP0e8VQUdwtGv9VKcF6aixau76yz+H2yI1grzSnUEc358z7
        mRvfuW2bXpzsXHm46UBdT5vVtHVHfZ3Wfeo4Ty0+F+2YonKNNjSs9EuetTZpChMWumzX5g32
        I8W9Pjnpltm3LqZbLvRTQ68PPTvi+bkz4fQXn/KIwj0xXnPWdMUeX2r0oPyXBVgy0jic8DCV
        cXPP2qRlpGD9ovm0UdL/AQkFqAttAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPIsWRmVeSWpSXmKPExsVy+t/xe7rvZ4nEGmx5w2yxccZ6VovrX56z
        Wjw7qm0x/8g5Vov+x6+ZLc6f38BucbbpDbvFpsfXWC0u75rDZvG59wijxYzz+5gs1h65y26x
        9PpFJovbjSvYLFr3HmG3OPymndXi24lHjA6CHmvmrWH02DnrLrvHplWdbB6bl9R79G1Zxejx
        eZNcAFuUnk1RfmlJqkJGfnGJrVK0oYWRnqGlhZ6RiaWeobF5rJWRqZK+nU1Kak5mWWqRvl2C
        XsaEc32sBS0CFV9/BzQwvuLpYuTgkBAwkdj3QaSLkYtDSGApo8S/ntXMXYycQHExiUn7trND
        2MISf651sUEUvWaUuHDwK1hCWCBE4t+mQ0wgtohAqsSTZWvBmpkFprJILPlfCNHQxiLxYdtx
        ZpBtbAJ6EjtWFYLU8Aq4SXz/fIARJMwioCrRscIFJCwqECExe1cDC0SJoMTJmU/AbE4Be4lF
        nU+hxptJzNv8EMoWl7j1ZD4ThC0v0bx1NvMERqFZSNpnIWmZhaRlFpKWBYwsqxhFUkuLc9Nz
        i430ihNzi0vz0vWS83M3MQIje9uxn1t2MHa9Cz7EKMDBqMTDu2KncKwQa2JZcWXuIUYJDmYl
        Ed78MJFYId6UxMqq1KL8+KLSnNTiQ4ymQL9NZJYSTc4HJp28knhDU0NzC0tDc2NzYzMLJXHe
        DoGDMUIC6YklqdmpqQWpRTB9TBycUg2MW1M1iutcAo8XndyssdDzg0fPg6iYdR08q7Tj+TNO
        GejtiPuzpv1uwXrPeXvPrmPkiDTL+bV9EfO6XXddJ7P0Wz+rerdr29srV6dO27e4VDY7eceE
        hwsresrLkv9I3Tc21f5w5Aev1Kl2nbOZax5c6P+9aL4AW7itjRJjXGftdPNf6kuYGX1ylFiK
        MxINtZiLihMB4iU3qQIDAAA=
X-CMS-MailID: 20190627103111eucas1p204450a032db835ba18a70d12939384e9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190605091304eucas1p21e0717cafa17a14de569f1773cc7abe5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190605091304eucas1p21e0717cafa17a14de569f1773cc7abe5
References: <CGME20190605091304eucas1p21e0717cafa17a14de569f1773cc7abe5@eucas1p2.samsung.com>
        <20190605091236.24263-1-l.luba@partner.samsung.com>
        <20190605091236.24263-5-l.luba@partner.samsung.com>
        <CAGTfZH2kTNWtx=Jp1UJaLN50Qxbq+Q9ThV4vhQ240QbOy1TRMQ@mail.gmail.com>
        <7498059d-95f7-e154-cf49-bcbc8ee6fdb9@partner.samsung.com>
        <CAJKOXPc6304D=HNQnrvhBH6qKxhkf=VQ2Gg6Q2FMP2hYOTYSDQ@mail.gmail.com>
        <776f58c2-a05c-8fa8-c7f5-458dc17926f6@partner.samsung.com>
        <99a47066-3713-77fa-4afb-6f2f17a2721a@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Chanwoo,

On 6/27/19 3:11 AM, Chanwoo Choi wrote:
> Hi Lukasz,
> 
> On 19. 6. 26. 오후 11:17, Lukasz Luba wrote:
>> Hi Krzysztof,
>>
>> On 6/26/19 4:03 PM, Krzysztof Kozlowski wrote:
>>> On Wed, 26 Jun 2019 at 15:58, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>>>>
>>>> Hi Chanwoo,
>>>>
>>>> On 6/26/19 10:23 AM, Chanwoo Choi wrote:
>>>>> Hi Lukasz,
>>>>>
>>>>> 2019년 6월 5일 (수) 18:14, Lukasz Luba <l.luba@partner.samsung.com
>>>>> <mailto:l.luba@partner.samsung.com>>님이 작성:
>>>>>
>>>>>       Extend the documenation by events description with new 'event-data-type'
>>>>>       field. Add example how the event might be defined in DT.
>>>>>
>>>>>       Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com
>>>>>       <mailto:l.luba@partner.samsung.com>>
>>>>>       Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com
>>>>>       <mailto:cw00.choi@samsung.com>>
>>>>>       ---
>>>>>         .../bindings/devfreq/event/exynos-ppmu.txt    | 26 +++++++++++++++++--
>>>>>         1 file changed, 24 insertions(+), 2 deletions(-)
>>>>>
>>>>>
>>>>>
>>>>> Acked-by: Chanwoo Choi <cw00.choi@samsung.com
>>>>
>>>> Thank you for the ACKs for this a 2/5 patch.
>>>> Do you think the v4 could be merged now?
>>>
>>> I think you have all necessary acks. I can take the DTS patch (5/5)
>>> although probably for next merge window as I just sent one.
>> There was one patch 3/5
>> https://protect2.fireeye.com/url?k=82dd0d0cbe2abd04.82dc8643-d13ecd7e5f989b8d&u=https://lkml.org/lkml/2019/6/5/215
>> which was waiting ACK or I missed the email somehow.
> 
> When I was in vacation, your patches are removed on my email account
> because of the email expiration. So, I replied with my Ack through
> gmail account on mobile phone. But, there are some problem. My reply
> didn't arrive the mailing list.
> 
> I have no any way to reply about this at company. After leaving one's
> office, I'll reply with Ack again at home.
> 
OK, no worries, it is not an emergency issue.
Regards,
Lukasz
