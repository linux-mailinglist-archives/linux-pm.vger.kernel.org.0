Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD45C56BB1
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2019 16:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbfFZOR1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Jun 2019 10:17:27 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:43888 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbfFZOR1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Jun 2019 10:17:27 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190626141725euoutp02e8deb1a381c5488906c780263ad65673~rxVCTzY872300423004euoutp02L
        for <linux-pm@vger.kernel.org>; Wed, 26 Jun 2019 14:17:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190626141725euoutp02e8deb1a381c5488906c780263ad65673~rxVCTzY872300423004euoutp02L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1561558645;
        bh=Lb5vMIMA4+2oGP1PTQxIWYQ2bA+QyEgleS8n+1L6J3M=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=WxVQz+BomuWZLShZRQdbbK7fjmkd6TOfzAa394ssdp3aSqd04s85A6AtMx8+d0HDX
         i0FJRpGreSI9ySXFELtQ/gKImlRGwyq7hoMoMjv/VwnXOk7JUnTIzRg4lZ5YfB8A7U
         WCHCwtOvx0a08zN14EfqD/nBQeTrjk9kDOM+ceLg=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190626141724eucas1p1ae2024c243dd959b702afd7cb1a15023~rxVBk9Omm1371213712eucas1p1w;
        Wed, 26 Jun 2019 14:17:24 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 1F.C8.04298.47E731D5; Wed, 26
        Jun 2019 15:17:24 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190626141723eucas1p2a3cd561e822e6caaeffcc6d004b37a69~rxVAupGD00710607106eucas1p2b;
        Wed, 26 Jun 2019 14:17:23 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190626141723eusmtrp16dbe68df7311179a8bfa2398b05bf084~rxVAgZ4NY1521615216eusmtrp1d;
        Wed, 26 Jun 2019 14:17:23 +0000 (GMT)
X-AuditID: cbfec7f2-3615e9c0000010ca-f4-5d137e748db2
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 56.B3.04140.37E731D5; Wed, 26
        Jun 2019 15:17:23 +0100 (BST)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190626141722eusmtip1cfd37b7173ad3b0c2168b9ff59529ebe~rxU-gYMh_2787727877eusmtip1I;
        Wed, 26 Jun 2019 14:17:22 +0000 (GMT)
Subject: Re: [PATCH v4 4/5] Documentation: devicetree: add PPMU events
 description
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     cwchoi00@gmail.com, devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        =?UTF-8?Q?Bart=c5=82omiej_=c5=bbo=c5=82nierkiewicz?= 
        <b.zolnierkie@samsung.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, Chanwoo Choi <cw00.choi@samsung.com>,
        kyungmin.park@samsung.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com, kgene@kernel.org,
        willy.mh.wolff.ml@gmail.com
From:   Lukasz Luba <l.luba@partner.samsung.com>
Message-ID: <776f58c2-a05c-8fa8-c7f5-458dc17926f6@partner.samsung.com>
Date:   Wed, 26 Jun 2019 16:17:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAJKOXPc6304D=HNQnrvhBH6qKxhkf=VQ2Gg6Q2FMP2hYOTYSDQ@mail.gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTYRjG+3YuOw5nx6O2FwuFQXQjyy70dSGSLizxjy5SUUgtO6ily3bU
        tCSnppl5w7BsdjMSLyy0NaUJmcypqdm0IkuxTE2lnJSuQui6HSP/+73v+7zf+zzwMQT3lvJl
        ojRxvFajjlbSMrKuZdq2PO6cV9jKyZyF+H5xNYV7HKMUHmlehm9Zn1E4f+gTgW22GinuTBuX
        YuPQKwq/qL9O46lcK8LFtgYJvmftl+Kynm4J7kutoHHGI6sUN41foPC3J4Noi6fKcNOAVGZ9
        v1RlrLpIqx7cTVHlmaqQasrot4s+KNt0jI+OSuC1KzYfkUXW9Jup2BFZ4kfLG1qHmphs5MYA
        uwbqDdMoG8kYjq1AcMHQIRELB4IWw/uZyRSCklfd9L+V5vNWShyUI3g8OUCIhR1B9Y965FR5
        saHwy2iRONmbXQI9P7+7NgjWRsKXWgeZjRiGZgPgYdUpp0bO7oAaXaNLT7ILofbziNTJPuwB
        cJiNSNR4Qtu1YdLJbuxuyBp74GKCVUDv8C2JyP6QXlviMgRsKgM/MzMI0fY2sJsaSZG94GOr
        SSryAui4nDPTF0CXW4pEToah/Bszmo3Q1NpNOT0Tf8NU169wIrBB0HZnroge8NruKTrwgMK6
        q4TYlkNWJie+sRhMOV0SkedBueGKtAAp9bNy6Wdl0c/Kov9/9jYiq5CCjxdiInghUMOfDhDU
        MUK8JiIg/GSMEf39dR2/Wicfoq/Pj1oQyyClu1znz4VxlDpBSIqxIGAIpbe8TM2GcfJj6qQz
        vPbkYW18NC9Y0HyGVCrkZ+cMHOLYCHUcf4LnY3ntv6mEcfPVIWXD2KbgecnBhS+7So+r9oyb
        x4JMvsWZqZubxvuKGg+tG+U0u+p+r1X4mRN7d9pWL98fv6/PRoeG7B22by/pbAtoX5V06ar7
        1slFA4MbwhQTlaUtqTfblO2JBWlF97ZVXLyenB7Chad8rUybfpT1xr7+6R5yw5pIhzZi4l3s
        qbwPPkVKUohUBy4ltIL6DzamK/lxAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMIsWRmVeSWpSXmKPExsVy+t/xu7rFdcKxBr8naVlsnLGe1eL6l+es
        Fs+OalvMP3KO1aL/8Wtmi/PnN7BbnG16w26x6fE1VovLu+awWXzuPcJoMeP8PiaLtUfuslss
        vX6RyeJ24wo2i9a9R9gtDr9pZ7X4duIRo4Ogx5p5axg9ds66y+6xaVUnm8fmJfUefVtWMXp8
        3iQXwBalZ1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZllqkb5eg
        l7Hh7k7WgmdcFa8O3WRrYDzM0cXIySEhYCJxtOUIaxcjF4eQwFJGiSsne9khEmISk/Zth7KF
        Jf5c62KDKHrNKNF/aT0zSEJYIETi36ZDTCC2iICmxPW/38EmMQucZ5FYdPY+O0THFGaJSxu3
        MHYxcnCwCehJ7FhVCNLAK+AmsaHhAFgzi4CqxNYPz8C2iQpESMze1cACUSMocXLmEzCbUyBQ
        ouPFZjCbWcBMYt7mh8wQtrjErSfzmSBseYnmrbOZJzAKzULSPgtJyywkLbOQtCxgZFnFKJJa
        WpybnltspFecmFtcmpeul5yfu4kRGOHbjv3csoOx613wIUYBDkYlHt4GeaFYIdbEsuLK3EOM
        EhzMSiK8SxMFYoV4UxIrq1KL8uOLSnNSiw8xmgI9N5FZSjQ5H5h88kriDU0NzS0sDc2NzY3N
        LJTEeTsEDsYICaQnlqRmp6YWpBbB9DFxcEo1MJbGffUSmT21j0Mozf0rW76msZP171/Lizxn
        7Lg22eCkhX/8xX37Tq8XOx5XVybyMbE8TfryrgqvjjM/CuYyCa3Plj0U7bvsgvsksa4wkffd
        hyfuzDuksq5ubZd6DwvDowtFL1m7G1i5jr7nbjJ7eHhz5667vMUlv26b7G/4vSX9jFLBp22V
        u5RYijMSDbWYi4oTAdJz0PoGAwAA
X-CMS-MailID: 20190626141723eucas1p2a3cd561e822e6caaeffcc6d004b37a69
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
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Krzysztof,

On 6/26/19 4:03 PM, Krzysztof Kozlowski wrote:
> On Wed, 26 Jun 2019 at 15:58, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>>
>> Hi Chanwoo,
>>
>> On 6/26/19 10:23 AM, Chanwoo Choi wrote:
>>> Hi Lukasz,
>>>
>>> 2019년 6월 5일 (수) 18:14, Lukasz Luba <l.luba@partner.samsung.com
>>> <mailto:l.luba@partner.samsung.com>>님이 작성:
>>>
>>>      Extend the documenation by events description with new 'event-data-type'
>>>      field. Add example how the event might be defined in DT.
>>>
>>>      Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com
>>>      <mailto:l.luba@partner.samsung.com>>
>>>      Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com
>>>      <mailto:cw00.choi@samsung.com>>
>>>      ---
>>>        .../bindings/devfreq/event/exynos-ppmu.txt    | 26 +++++++++++++++++--
>>>        1 file changed, 24 insertions(+), 2 deletions(-)
>>>
>>>
>>>
>>> Acked-by: Chanwoo Choi <cw00.choi@samsung.com
>>
>> Thank you for the ACKs for this a 2/5 patch.
>> Do you think the v4 could be merged now?
> 
> I think you have all necessary acks. I can take the DTS patch (5/5)
> although probably for next merge window as I just sent one.
There was one patch 3/5
https://lkml.org/lkml/2019/6/5/215
which was waiting ACK or I missed the email somehow.

Regards,
Lukasz

> 
> Best regards,
> Krzysztof
> 
> 
