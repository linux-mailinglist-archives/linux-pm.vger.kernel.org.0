Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB5C524E9
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2019 09:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbfFYHgO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Jun 2019 03:36:14 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:21524 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728539AbfFYHgM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Jun 2019 03:36:12 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190625073609epoutp01d9ebaa60df5bd94866032a809eb4dd49~rYNZCI1aF2971729717epoutp01p
        for <linux-pm@vger.kernel.org>; Tue, 25 Jun 2019 07:36:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190625073609epoutp01d9ebaa60df5bd94866032a809eb4dd49~rYNZCI1aF2971729717epoutp01p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1561448169;
        bh=Wtkcn2ai+OOxJ87tNg5e7fYQe47G0N9sQHFBq2RzMf8=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=DYoxcUrCwnyxIRh87Q/lmyUgBdVr9GudSLyggG4vuVu2ITNYbkV9/FHkfzomk4Fhi
         /CVnMlahvzNXAWBEevW7cHPkV5oSA4VGNFBn3g7s34SC5CTCeC2YPG3zb0ECL7ASSQ
         b4CufU9ptG7nrXC61VJuT8cDNit/B46aGWvKHpZk=
Received: from epsmges1p2.samsung.com (unknown [182.195.40.152]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190625073603epcas1p41a44e3712abda2dbbe7f08c4fcbb92c4~rYNT6WkiQ0694106941epcas1p4O;
        Tue, 25 Jun 2019 07:36:03 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        5F.99.04142.3EEC11D5; Tue, 25 Jun 2019 16:36:03 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190625073603epcas1p2fd373823934640c4660f49d4a7eb8b3f~rYNTTkVgc0896408964epcas1p2S;
        Tue, 25 Jun 2019 07:36:03 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190625073602epsmtrp1802c956e464be8fd88a07d2f0777382a~rYNTScBHg0778607786epsmtrp1h;
        Tue, 25 Jun 2019 07:36:02 +0000 (GMT)
X-AuditID: b6c32a36-ce1ff7000000102e-ce-5d11cee3e05c
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        64.F1.03692.2EEC11D5; Tue, 25 Jun 2019 16:36:02 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190625073602epsmtip187b244713ef0ab69d00e8bc142ddb972~rYNS5m-NX3060230602epsmtip1p;
        Tue, 25 Jun 2019 07:36:02 +0000 (GMT)
Subject: Re: [PATCH v10 09/13] drivers: devfreq: events: add Exynos PPMU new
 events
To:     Lukasz Luba <l.luba@partner.samsung.com>, cwchoi00@gmail.com
Cc:     devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        linux-clk@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>, keescook@chromium.org,
        Tony Lindgren <tony@atomide.com>, jroedel@suse.de,
        treding@nvidia.com, digetx@gmail.com,
        Greg KH <gregkh@linuxfoundation.org>,
        willy.mh.wolff.ml@gmail.com
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <d0bbc755-c370-98c8-3d52-492f2c709f76@samsung.com>
Date:   Tue, 25 Jun 2019 16:38:39 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <2e1be1d3-b6ae-e40d-48cd-6b6adb26860d@partner.samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphl+LIzCtJLcpLzFFi42LZdlhTT/fxOcFYg7tvFC02zljPavHsqLbF
        /CPnWC1Wf3zMaNG8eD2bxeRTc5ksznTnWvQ/fs1scf78BnaLs01v2C1uNchYfOy5x2pxedcc
        NovPvUcYLWac38dksfbIXXaLi6dcLW43rmCzOPymndXi37WNLBb7r3hZ3P7NZ/HtxCNGB3GP
        b18nsXi8v9HK7jG74SKLx85Zd9k9Nq3qZPPYP3cNu0dv8zs2j4Pv9jB59G1Zxeix+XS1x+dN
        cgHcUdk2GamJKalFCql5yfkpmXnptkrewfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6ZOUDf
        KimUJeaUAoUCEouLlfTtbIryS0tSFTLyi0tslVILUnIKLAv0ihNzi0vz0vWS83OtDA0MjEyB
        ChOyMyZ3fWcq+MFdcfdIE1sD43XOLkYODgkBE4lNq0q7GLk4hAR2MEo8Wn+YFcL5xCix4c4Z
        FgjnG6PEpMbXQBlOsI5FCxZDJfYySrzfN40NwnnPKHG98woLSJWwQKjEra2L2UBsEQEHiZ03
        XzKCFDELTGWT+NP8nhEkwSagJbH/xQ2wIn4BRYmrPx6DxXkF7CRWffgMNohFQFVi771bYHFR
        gQiJy1t2QdUISpyc+QSshlPAXeLCq41gNrOAuMStJ/OZIGx5ieats5lBFksI9HJI3Ds9iQXi
        axeJBVvSIN4Rlnh1fAs7hC0l8bK/Dcqullh58ggbRG8Ho8SW/Reg/jeW2L90MhPIHGYBTYn1
        u/QhwooSO3/PZYTYyyfx7msPK8QqXomONiGIEmWJyw/uMkHYkhKL2zvZJjAqzULyzSwkH8xC
        8sEshGULGFlWMYqlFhTnpqcWGxYYIcf2JkZwTtAy28G46JzPIUYBDkYlHt4fxwRihVgTy4or
        cw8xSnAwK4nwLk0ECvGmJFZWpRblxxeV5qQWH2I0BQb2RGYp0eR8YL7KK4k3NDUyNja2MDE0
        MzU0VBLnjee+GSMkkJ5YkpqdmlqQWgTTx8TBKdXAmOF3Rrju9uPNWkctGaIDbr5hfvlqzbmH
        kxXKAs5tmTPtm5/ZzZjgzx72nY+z0p4rTomt2vpV/MuE5L6gScsfl1urGk4PaRNbwPQy+aTn
        e6MbUqH62+bqlJ7Pm5kjtlX1ZGGCV8tKpxXy5ySvP/vmciuwMGr9jzmV9lMDn5+wZPe5n8/f
        yLDpjxJLcUaioRZzUXEiADUYUBofBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOIsWRmVeSWpSXmKPExsWy7bCSnO6jc4KxBlMbzSw2zljPavHsqLbF
        /CPnWC1Wf3zMaNG8eD2bxeRTc5ksznTnWvQ/fs1scf78BnaLs01v2C1uNchYfOy5x2pxedcc
        NovPvUcYLWac38dksfbIXXaLi6dcLW43rmCzOPymndXi37WNLBb7r3hZ3P7NZ/HtxCNGB3GP
        b18nsXi8v9HK7jG74SKLx85Zd9k9Nq3qZPPYP3cNu0dv8zs2j4Pv9jB59G1Zxeix+XS1x+dN
        cgHcUVw2Kak5mWWpRfp2CVwZk7u+MxX84K64e6SJrYHxOmcXIyeHhICJxKIFi1m6GLk4hAR2
        M0ocO/GECSIhKTHt4lHmLkYOIFtY4vDhYoiat4wS9y49ZgWpERYIlbi1dTEbiC0i4CCx8+ZL
        RpAiZoHZbBKzG/cwgiSEBM4xSZxfFwFiswloSex/cQOsgV9AUeLqj8dgNbwCdhKrPnxmAbFZ
        BFQl9t67BRYXFYiQ6GubzQZRIyhxcuYTsBpOAXeJC682gtnMAuoSf+ZdYoawxSVuPZnPBGHL
        SzRvnc08gVF4FpL2WUhaZiFpmYWkZQEjyypGydSC4tz03GLDAsO81HK94sTc4tK8dL3k/NxN
        jODkoKW5g/HykvhDjAIcjEo8vD+OCcQKsSaWFVfmHmKU4GBWEuFdmggU4k1JrKxKLcqPLyrN
        SS0+xCjNwaIkzvs071ikkEB6YklqdmpqQWoRTJaJg1OqgVGkgKt1Q9quLs+V5f07z5jYxRYv
        1/87+9zbQ5qzpty2OsOXNp/39RbVjnPz7t/mSD5mVXJxn+72LP/cLfKWP2NubnD8dvvYPdus
        /x+mmfcd5zf8X/VijnC8X/zUxUY3/qpW71ScyPS7/HKAuWvL0o/rNeRFSzZPnCrb2OqrfTDh
        yRbvq+VuXzqVWIozEg21mIuKEwFLttHcCgMAAA==
X-CMS-MailID: 20190625073603epcas1p2fd373823934640c4660f49d4a7eb8b3f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190614095328eucas1p24009b3a07322fd12e49eabb7a08baf50
References: <CGME20190614095328eucas1p24009b3a07322fd12e49eabb7a08baf50@eucas1p2.samsung.com>
        <20190614095309.24100-1-l.luba@partner.samsung.com>
        <20190614095309.24100-10-l.luba@partner.samsung.com>
        <CAGTfZH35X0zE2LhGWJJp2xZNNk1ew7zNMoMqL+eZ5rcBFcPvew@mail.gmail.com>
        <2e1be1d3-b6ae-e40d-48cd-6b6adb26860d@partner.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19. 6. 25. 오후 4:31, Lukasz Luba wrote:
> 
> 
> On 6/22/19 3:10 PM, Chanwoo Choi wrote:
>> Hi,
>>
>> 2019년 6월 14일 (금) 오후 6:54, Lukasz Luba <l.luba@partner.samsung.com>님이 작성:
>>>
>>> Define new performance events supported by Exynos5422 SoC counters.
>>> The counters are built-in in Dynamic Memory Controller and provide
>>> information regarding memory utilization.
>>>
>>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>>> ---
>>>   drivers/devfreq/event/exynos-ppmu.c | 6 ++++++
>>>   1 file changed, 6 insertions(+)
>>>
>>> diff --git a/drivers/devfreq/event/exynos-ppmu.c b/drivers/devfreq/event/exynos-ppmu.c
>>> index c2ea94957501..ce658c262c27 100644
>>> --- a/drivers/devfreq/event/exynos-ppmu.c
>>> +++ b/drivers/devfreq/event/exynos-ppmu.c
>>> @@ -89,6 +89,12 @@ static struct __exynos_ppmu_events {
>>>          PPMU_EVENT(d1-cpu),
>>>          PPMU_EVENT(d1-general),
>>>          PPMU_EVENT(d1-rt),
>>> +
>>> +       /* For Exynos5422 SoC */
>>> +       PPMU_EVENT(dmc0_0),
>>> +       PPMU_EVENT(dmc0_1),
>>> +       PPMU_EVENT(dmc1_0),
>>> +       PPMU_EVENT(dmc1_1),
>>>   };
>>>
>>>   static int exynos_ppmu_find_ppmu_id(struct devfreq_event_dev *edev)
>>> --
>>> 2.17.1
>>>
>>
>> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
>>
> Thank you Chanwoo.

It[1] was merged to devfreq.git.
[1] https://git.kernel.org/pub/scm/linux/kernel/git/mzx/devfreq.git/commit/?h=for-next

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
