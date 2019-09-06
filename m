Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFC9EAB430
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2019 10:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730415AbfIFImN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Sep 2019 04:42:13 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:46709 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390565AbfIFImN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Sep 2019 04:42:13 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190906084211euoutp016932353ed9072a75321a978c6b9afc84~BzM5K_MEq0446404464euoutp01a
        for <linux-pm@vger.kernel.org>; Fri,  6 Sep 2019 08:42:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190906084211euoutp016932353ed9072a75321a978c6b9afc84~BzM5K_MEq0446404464euoutp01a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1567759331;
        bh=roV6i1ybt0okWVVsbn4NlTxFVAV2oeF0PA+qqtPZaTs=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=OTroPG6RLPnqV5MGmKiLOu6F71AhS2IMZbl6D9CUwTp6GrUTJ+/Qy4ueY3SZlMHnF
         I4IIHD+89uOeJuK8Yju0fWdDVn8PzIcwjcWJvI07KBTsnRutAk+1lpmJbzIFpjlz6k
         oqJc24/F2nVzgQeghj5HP/3wJWY133R6LF949Auo=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190906084210eucas1p2184a7e2312a2293f90e22d9a08f258ed~BzM39V-l70741707417eucas1p2_;
        Fri,  6 Sep 2019 08:42:10 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 33.0C.04469.2EB127D5; Fri,  6
        Sep 2019 09:42:10 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190906084209eucas1p2b4e7e0fd43cc7ca1772516cdb1b836ab~BzM3KvHrE0741707417eucas1p28;
        Fri,  6 Sep 2019 08:42:09 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190906084209eusmtrp2514225b66bc560f1d13138c365663825~BzM3J4oSu1216912169eusmtrp2L;
        Fri,  6 Sep 2019 08:42:09 +0000 (GMT)
X-AuditID: cbfec7f2-54fff70000001175-97-5d721be2cf33
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 48.C2.04166.1EB127D5; Fri,  6
        Sep 2019 09:42:09 +0100 (BST)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190906084208eusmtip2a5854a2938a653700e14aefae7c37bcd~BzM2AdFhx0515305153eusmtip2a;
        Fri,  6 Sep 2019 08:42:08 +0000 (GMT)
Subject: Re: [PATCH v13 3/8] drivers: memory: extend of_memory by LPDDR3
 support
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, b.zolnierkie@samsung.com, kgene@kernel.org,
        mark.rutland@arm.com, robh+dt@kernel.org, cw00.choi@samsung.com,
        kyungmin.park@samsung.com, m.szyprowski@samsung.com,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com,
        keescook@chromium.org, tony@atomide.com, jroedel@suse.de,
        treding@nvidia.com, digetx@gmail.com, gregkh@linuxfoundation.org,
        willy.mh.wolff.ml@gmail.com
From:   Lukasz Luba <l.luba@partner.samsung.com>
Message-ID: <cc6ad0de-a748-2f5b-10db-ed1a56789a06@partner.samsung.com>
Date:   Fri, 6 Sep 2019 10:42:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190904183114.GB12918@kozik-lap>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUzMcRzH+97v8Y7Lz4k+qmE3f2BcbMZ3WNOG/cY8P8yYh6PfCndX7qeU
        a3YkKoXVPHQkD0s5tXNJ0vLUHVHI4VykUJaNynRhaUnXr6b/Xp/35/35fj7v7csSqpN0ELvD
        sEcwGrQ6Na0gSx911U5rCjZumm7PZrD9jI3Cns4vFM51PqfwtR/NCCddttE4qzpHhp8e1ePj
        zd8IXFt7ncHPDrYy+Ed6I4VflZ+jsTfDifCZ2rsyXORsYHCexyXDruqFuP5AAY2T7zgZ7Gg9
        QuG/b+wkvvd6Ma7v9se/Hjeh+cAXni9E/K+fmST/vS6Z4c+aXSR/29LA8MXWVJq/l1PI8BlJ
        7TR/rMSK+Bs1Jt5bPG7FsA2KeRGCbkecYAwN26qIep7xFMU8ouK/X+1izKiITENyFriZkFXc
        Q6UhBaviChA43HZaKjoR2KtvMlLhRdCe3iYbHClzJRNSIx+B1/NBJhVtCLLedSGfaxS3Ct43
        9fRPBHCTwdPzm/IxwVWQYM4cm4ZYluY0UGbd7ZOV3CK46G7sv4nkJsJhby/t49Hceuj46KAk
        z0h4kv2Z9I3KuVCwtq6RXgyEd59zZRKPh1tt5wjpzjoWug+ES7wAqt0PKIlHwdeqEkbiEOi9
        nTuQSwRzxkUkcSI0H88Z8MwFR5WL8q0l+pLYykMlORye5Lb3y8D5Q13bSOkCf8gsPU1IshJS
        Dqsk9yQoSX8xsGgM5BeeYk4gtWVILMuQLJYhWSz/915ApBUFCrGiPlIQZxiEvRpRqxdjDZGa
        7dH6YtT3WWv+VnWUoZ8vt1UijkXq4UquM2aTitLGiQn6SgQsoQ5Q2ux9kjJCm7BPMEZvMcbq
        BLESBbOkOlBp8vu4UcVFavcIuwQhRjAOdmWsPMiMymXx+6a4St1vElef7v202W+qbUTNnC55
        2C1D+LI1V3ZXFB2FeOE+m2dyBIegrFVJD1tSEsZ91X1aqWl8n3BnuUltv9SdGB3mzqt3axpC
        ApZExSTKZ3ne7jzUknq+YKPfOoXTOfuCrmNdxNqlJflL8wIqT4b0/NnvrrC2THhoao2zqUkx
        SjtjCmEUtf8A/IrW6agDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02SaVCMcRzH/fc5kzV/a6v/rKNmxxvXk+3850hvNA/jhUFDaGrpmbap3c0+
        W+MYM2EiER0vZOlCQ1t0mWwhoxKSaiuiSwdjqJByDcVuy0zvvvP9fT+/Y+bHErIiSsFG64yC
        QaeOVdKzyadTj/pWDiwwhK26dhHisqwSCndOvKNwbn0zhYvGhgA+fqWExpmN2RLcdFqLzw0N
        E7ilpZTBz46NMHjsTB+F26sv0Xg8tR7grJYaCb5R38vggk6rBFsbN+Duo9dpnHSvnsF1Iycp
        PPWijMT3Ozbh7l9z8bfHgyAI8cU5xYD/9jWD5D+9TGL4i4lWkq8y9TJ8ufkUzd/PLmb41OMf
        af7sLTPgK54e5sfLF29x3sWtNejjjYKHRi8a1yl3q7AXpwrAnJdPAKfy9g9b7eWr9AxcGynE
        RicIBs/ACE7TnNoE4hqoA58KfzKJ4AaZApxYBH2QxZpEpIDZrAwWAPRlootxFFxRRs3tf3o+
        +v0ihXaEhgG6WnOFthfmw62oZ3BSYtdyuBR1Tn6n7CEC3iXRh4IOiYP4CFBS2kPbDJalIYcs
        5v12QAqDUf7zvuk1SLgEnRj/M93UBe5EdRYTcGTmoScX3pB21Al6IvPIdrtNQD+UUzFAOLQb
        6nqTK3Fod3R79BKRBmSmGbRpBmKagZhmIHmANAO5EC9qo7SiihPVWjFeF8Xt02vLge1RKht+
        VlhAW9m2WgBZoJwjhRNxYTJKnSAe1NYCxBJKubSkzGZJI9UHDwkGfbghPlYQa4Gv7bZ0QuGy
        T297O50xXOWr8scBKn9vf28/rHSTJsMHe2QwSm0UYgQhTjD85ySskyIRKLJCL69c3/tZGlzZ
        v8a1O1zRo0Nh5GjjorkjG69BS36PJiTwx6y+qkW1q7KWRfh8rqzmQ5uC7rgXDnoPy332emQe
        SS49diH6UGtBxevzubDpVczwirchYx6N77kTA8tXnN6R1+pZLTU6dxiFzTUNvNNCa7vzRPpU
        203X/mj5aKFGSYoatWoZYRDVfwFJHsWtPgMAAA==
X-CMS-MailID: 20190906084209eucas1p2b4e7e0fd43cc7ca1772516cdb1b836ab
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190821104320eucas1p10c911c2ce59007bcf6c039f52b869656
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190821104320eucas1p10c911c2ce59007bcf6c039f52b869656
References: <20190821104303.32079-1-l.luba@partner.samsung.com>
        <CGME20190821104320eucas1p10c911c2ce59007bcf6c039f52b869656@eucas1p1.samsung.com>
        <20190821104303.32079-4-l.luba@partner.samsung.com>
        <20190904183114.GB12918@kozik-lap>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 9/4/19 8:31 PM, Krzysztof Kozlowski wrote:
> On Wed, Aug 21, 2019 at 12:42:58PM +0200, Lukasz Luba wrote:
>> The patch adds AC timings information needed to support LPDDR3 and memory
>> controllers. The structure is used in of_memory and currently in Exynos
>> 5422 DMC. Add parsing data needed for LPDDR3 support.
> 
> Thanks, applied, with commit msg fixes.
> 
> Please do not write "This patch" (submitting patches mentions preferred
> format). Also at this point, this is not "used currently in Exynos 5422
> DMC" because there is no such driver. Just say that it is necessary for
> upcoming DMC driver.

OK and thank you.

Regards,
Lukasz
> 
> Best regards,
> Krzysztof
> 
> 
> 
