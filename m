Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08242921F6
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2019 13:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbfHSLQZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Aug 2019 07:16:25 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:55067 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727377AbfHSLQZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Aug 2019 07:16:25 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190819111623euoutp01a7d344f8cde283cc16fa0fc2f2541735~8TsYp9IUe1795217952euoutp011
        for <linux-pm@vger.kernel.org>; Mon, 19 Aug 2019 11:16:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190819111623euoutp01a7d344f8cde283cc16fa0fc2f2541735~8TsYp9IUe1795217952euoutp011
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1566213383;
        bh=mHohkKnMT8xmCVz946S2fj/VooESKL2x2tfzA/bLGQM=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=U1c/AyGSOon12WTp1/ca/JxxkZdGezvL7jktcoYNefWjGNSwwFhOlMQnj6HaRUTDz
         2TvPzcFepYBcXRgG8/xKlAwWxhOR87MlnvwiTXONDx3AL8ySAGBMNs3kD12KAN1pHE
         0eevu23Kh9DyjgDZ0TlkSw+aOINIYxbQs8FQzEl0=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190819111622eucas1p2eb5126314a1c1630ca616a5b40279764~8TsX2Yyqt3179931799eucas1p2l;
        Mon, 19 Aug 2019 11:16:22 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 7D.DD.04469.6058A5D5; Mon, 19
        Aug 2019 12:16:22 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190819111621eucas1p228cea8b1ed16b8a065983af9ea28c3db~8TsW-QSK_3187131871eucas1p2r;
        Mon, 19 Aug 2019 11:16:21 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190819111621eusmtrp29c9e075d164c5e486878d581bd782150~8TsW_nkFW1063410634eusmtrp2u;
        Mon, 19 Aug 2019 11:16:21 +0000 (GMT)
X-AuditID: cbfec7f2-569ff70000001175-74-5d5a8506bee6
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 98.9D.04117.5058A5D5; Mon, 19
        Aug 2019 12:16:21 +0100 (BST)
Received: from [106.120.51.75] (unknown [106.120.51.75]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190819111621eusmtip1f1c967c1212ba46b9976063d06632464~8TsWZtvTM1525215252eusmtip1N;
        Mon, 19 Aug 2019 11:16:20 +0000 (GMT)
Subject: Re: [PATCH v2 0/9] Exynos Adaptive Supply Voltage support
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>, krzk@kernel.org,
        robh+dt@kernel.org, vireshk@kernel.org, devicetree@vger.kernel.org,
        kgene@kernel.org, pankaj.dubey@samsung.com,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, b.zolnierkie@samsung.com
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-ID: <b831d7c5-c830-fd65-20cf-02e209889c28@samsung.com>
Date:   Mon, 19 Aug 2019 13:16:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190819090928.pke6cov52n4exlbp@vireshk-i7>
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0iTYRjt3XfVmrxOzSeLkpFBA28Q8YUhmSULCbIbYljN/FqSNzYvaZSW
        GKV5KUhtKooXUjHMVWZLy3TOwswyCyXvrkxtEblRJmjOT8l/55znPM97DrwsIWmnXNiI6Dhe
        Fa2IlNK2ZINh9q07nR4S6tVcbcfVF9RRXIn+LcXljE8TXHf3A4bTjn+iuA+6IpqbydIjrqD7
        uYi7rx9kuLLHZoZLb9YzXL1Fzj0cMdB7xHJtzQ1aPvCpiZY/rEiRZz+qQfIZ7eZDVIjt7nA+
        MiKBV3n6nrY99+JnHx3bQl8YyptGqUhDZSAbFvAO+Dbwg8xAtqwEVyGYK69cJmYEPzrHCIHM
        IHhjqKBXVsy6+yJhcA9B8YMuRiAmBF+Mf5YOO+C90DRnWdxgWUcsg8l+3ioT+KMIdJYlTGNv
        yGrPRlaLGPvC74ltVkhiN7jTrbQ6nHAw/BppWzooxvbw+q6RtGIbvAua5gcI4aIzXDVXUwLe
        Ak9MRUuZAQ8x8LXKsJx5H7y89Xe5sgNMdTxiBLwJFp6WiISFNAQ3n31mBJKLYLijFAkuH2jr
        eE9Z0xF4O9TpPAXZD7J79SKrDNgO+kz2Qgg7uN2QTwiyGK5fkwjurTBXky8SsAtkGhfIXCTV
        rKqmWVVHs6qO5v+7pYisQc58vDpKyau9o/lED7UiSh0frfQ4ExOlRYufq3O+41cjsvSEtSLM
        Iuk68Su3kFAJpUhQJ0W1ImAJqaM42ys4VCIOVyQl86qYU6r4SF7dijaypNRZfHHNyAkJViri
        +PM8H8urVqYi1sYlFSX/Tsks75k8WygLDEhsfpWl9fTRX9ZsbZzaMezWWxrj5KUzetQp1x48
        2lKYMH7Z1ZAS3C/FoyangLDUA+4bXEVBvU2zfe+OZ/juLGsJlNV/DIo3FI8x5Wy/9J5/FZlu
        Drx0eH1O7feEK/vTeg8fq81rnPDzz7TP7Rk9crKyb3CqS0qqzym8ZYRKrfgHenLCP1gDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOIsWRmVeSWpSXmKPExsVy+t/xu7qsrVGxBhsWK1lsnLGe1WL+kXOs
        Fv2PXzNbnD+/gd1i0+NrrBaXd81hs/jce4TRYsb5fUwWa4/cZbdYtPULu0Xr3iPsFhu/elhs
        fnCMzYHXY9OqTjaPO9f2sHlsXlLv0bdlFaPH501yAaxRejZF+aUlqQoZ+cUltkrRhhZGeoaW
        FnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehn7P9xgKzjAVnFv2mvGBsZZrF2MnBwSAiYS
        X3atZepi5OIQEljKKPH49EOgBAdQQkpifosSRI2wxJ9rXWwQNa8ZJRq3fGIESQgLOEns+f2V
        DaReREBL4uXNVJAaZoGrTBKL91xigWhoY5Y48boDrIFNwFCi92gfI0gDr4CdxPfnaiAmi4Cq
        xNTz6SAVogIREod3zAKr5hUQlDg58wkLiM0pYCmx598dZhCbWUBd4s+8S1C2uETTl5WsELa8
        xPa3c5gnMArNQtI+C0nLLCQts5C0LGBkWcUoklpanJueW2ykV5yYW1yal66XnJ+7iREYqduO
        /dyyg7HrXfAhRgEORiUe3hOqUbFCrIllxZW5hxglOJiVRHj7DCJihXhTEiurUovy44tKc1KL
        DzGaAv02kVlKNDkfmETySuINTQ3NLSwNzY3Njc0slMR5OwQOxggJpCeWpGanphakFsH0MXFw
        SjUwXj6qMvmZ8e8Dmzwd76Ul8/W90n3Kmb5W9pWaUPZ5UzsxcXHLH8snqj0pVee+aHfyeIn4
        /9+Hez+xesz3rPT0sl/08Qrny2PbrzDcltfUW7hH46mpn+9NK7PMN0I+Xj9lDNq+X5Vo5qsS
        n2jJZtAhy/iL/833XJVtiafP3P7S3XXlGmvZW3s2JZbijERDLeai4kQAgtWqOeoCAAA=
X-CMS-MailID: 20190819111621eucas1p228cea8b1ed16b8a065983af9ea28c3db
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190718143117eucas1p1e534b9075d10fbbbe427c66192205eb1
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190718143117eucas1p1e534b9075d10fbbbe427c66192205eb1
References: <CGME20190718143117eucas1p1e534b9075d10fbbbe427c66192205eb1@eucas1p1.samsung.com>
        <20190718143044.25066-1-s.nawrocki@samsung.com>
        <20190723020450.z2pqwetkn2tfhacq@vireshk-i7>
        <5ef302a4-5bbf-483d-dfdf-cf76f6f69cee@samsung.com>
        <20190725022343.p7lqalrh5svxvtu2@vireshk-i7>
        <562dd2e7-2b24-8492-d1c1-2dc4973f07be@samsung.com>
        <20190819090928.pke6cov52n4exlbp@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 8/19/19 11:09, Viresh Kumar wrote:
> Will something like this help ?
> 
> https://lore.kernel.org/lkml/1442623929-4507-3-git-send-email-sboyd@codeaurora.org/
> 
> This never got merged but the idea was AVS only.

It's quite interesting work, it seems to be for a more advanced use case 
where OPP voltage is being adjusted at runtime.

We could use it instead of removing an OPP and then adding with updated 
voltage. On Exynos there is there is just a need to update OPPs once at boot 
time, so it is more "static". However the requirements could presumably 
change in future.

If that's your preference I could switch to that notifier approach.
AFAICS the API would still need to be extended to support multiple voltages,
when in future we add support for the Body Bias regulator. 

-- 
Thanks,
Sylwester
