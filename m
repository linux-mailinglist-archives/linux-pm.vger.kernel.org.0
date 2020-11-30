Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A21E2C8037
	for <lists+linux-pm@lfdr.de>; Mon, 30 Nov 2020 09:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbgK3IpJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Nov 2020 03:45:09 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:54273 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727026AbgK3IpJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Nov 2020 03:45:09 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20201130084426epoutp02d58c52fff95180fcfa8d88344e7ea5e4~MPKmUeIDx1116911169epoutp023
        for <linux-pm@vger.kernel.org>; Mon, 30 Nov 2020 08:44:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20201130084426epoutp02d58c52fff95180fcfa8d88344e7ea5e4~MPKmUeIDx1116911169epoutp023
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1606725866;
        bh=bDmfLQ82vcquQ/0l4S78MMctRA1hFpJZ5MR48SmgKvU=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=FsGGGLdm3FvvSiLnNdybdZgi8qOESGHirqW65XhUzYJO6LCJQXMI8RCj2yCvUHjaP
         P1kzWoJp96bmptQp9/oos4E33QwfJCGB5OFYcpaNt5nA6bllfXeSUTzOxKigz73zkl
         Bm2JMqky0sCbJffxmUWHTU+NbpebNr3VxlhIc6wg=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20201130084425epcas1p24e6c7eb5f00b4c3ce4ca847868c1d463~MPKlpW60K0906509065epcas1p2a;
        Mon, 30 Nov 2020 08:44:25 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.152]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4CkzLG6TDzzMqYkj; Mon, 30 Nov
        2020 08:44:22 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        11.8F.09582.6E0B4CF5; Mon, 30 Nov 2020 17:44:22 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20201130084422epcas1p1483ad5cd7f62e6bd1b1a552fdad63c37~MPKigGiCB0262202622epcas1p1W;
        Mon, 30 Nov 2020 08:44:22 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201130084421epsmtrp1d9cde4869274466412c34f4fa4428634~MPKifG-n80737807378epsmtrp1W;
        Mon, 30 Nov 2020 08:44:21 +0000 (GMT)
X-AuditID: b6c32a37-899ff7000000256e-c9-5fc4b0e6a3b4
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        24.A5.13470.5E0B4CF5; Mon, 30 Nov 2020 17:44:21 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20201130084421epsmtip107ec41bb79363c00a72e0c14ec4f0ced~MPKiHbOtd0519605196epsmtip12;
        Mon, 30 Nov 2020 08:44:21 +0000 (GMT)
Subject: Re: [PATCH v10 00/19] Introduce memory interconnect for NVIDIA
 Tegra SoCs
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Viresh Kumar <vireshk@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <56cf1513-e7c6-6079-82c4-768c116f4717@samsung.com>
Date:   Mon, 30 Nov 2020 17:59:00 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20201130083646.GA6711@kozik-lap>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKJsWRmVeSWpSXmKPExsWy7bCmnu6zDUfiDVZ06Fq8+/SU1WL1x8eM
        Fle+vmezmL53E5tFy6xFLBbnz29gt9j6dA2TxdmmN+wWl3fNYbP43HuE0aLzyyw2i4unXC1u
        N65gs5i0diqjxdln3hate4+wW/y7tpHF4ueueSwWmx8cY3MQ9nh/o5XdY+esu+wel879YfbY
        tKqTzePOtT1sHve7jzN59Da/Y/Po27KK0ePzJrkAzqhsm4zUxJTUIoXUvOT8lMy8dFsl7+B4
        53hTMwNDXUNLC3MlhbzE3FRbJRefAF23zBygp5QUyhJzSoFCAYnFxUr6djZF+aUlqQoZ+cUl
        tkqpBSk5BZYFesWJucWleel6yfm5VoYGBkamQIUJ2RkbDgsUPGGvWPv5AlsD4zy2LkZODgkB
        E4lHF+YzdTFycQgJ7GCUmLlyEiuE84lR4vSPNnYI5xujxL77+5m7GDnAWo5OrIGI72WUmLqo
        kRnCec8o8edvBzPIXGGBEIm7f16zgtgiApoS1/9+BxvLLLCKVeLk7ANgCTYBLYn9L26AHcIv
        oChx9cdjRhCbV8BO4n33QyYQm0VAVWLBiatgcVGBMImT21qgagQlTs58wgJicwroSUz7OR1s
        DrOAuMStJ/OZIGx5ie1v54BdJyHQzSmxvv8NK8QLLhJdZ00gASAs8er4FnYIW0riZX8blF0t
        sfLkETaI3g5GiS37L7BCJIwl9i+dzAQyhxnos/W79CHCihI7f89lhNjLJ/Huaw/UKl6JjjYh
        iBJlicsP7jJB2JISi9s72SYwKs1C8s0sJB/MQvLBLIRlCxhZVjGKpRYU56anFhsWGCNH9iZG
        cHrXMt/BOO3tB71DjEwcjIcYJTiYlUR4MzgOxgvxpiRWVqUW5ccXleakFh9iNAWG70RmKdHk
        fGCGySuJNzQ1MjY2tjAxNDM1NFQS5/2j3REvJJCeWJKanZpakFoE08fEwSnVwKTFYV8ZP+mI
        0+r45xmqE8QObKz1med+hV2/Jdg68Fcja+UsvYDSO/+lT078whwc9z/uaMi0iXrxvcH3FBQL
        ffM+td1dc9CYz/S3hyH/8VPOMmFL+wU6E7l5PFndco3vBShwH/RvcZtucKvcZIeXkto9FZ7e
        byuf2UsofF7BfmJRD7/VTNb3K3mSrlbx3reWTjfzNloUNifwhoSFouSrdw2TvuRmL/R4Kl5W
        8uVai/N2j4ychduv7ubrF5LgmixeMyGI686N3UHTdSf9upjNOL2UY5qqzY1eudz1K2LfWs0R
        vtcoFCsu3ilhv+Cq7MGJsX8Wq59Wcb/B2RMZsbqrUsugKOQt69sQkb5vCy8rsRRnJBpqMRcV
        JwIAdGj3j3gEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02Ra0hTYRiA+c45OzszrdNU/NRatMxylCVFfISYUdJBIbrhD39oo046c2vt
        aKVlqMtgS82ilKY5K42czmyztKt5WypZamlmifeIUOclK8m0thH47+F9n+f981K4sI3womSK
        eFalkMaJSSfiUb1YtHGkoiFq80LRNjQ+NcJDpZNDAL2fsZIo97mJRBd0twn09m0FHz0cKcNQ
        a9ooH717kk+i6cwGgDTfdSRqbwlBn1Lvkeiq8TpArV/CUPrzBj6a73pAoNknBQQy91vIYFfG
        2p3OZx7revlMx5s5nDEZNCTzuesZyfRdeoUxmepxksmqNABm2iTaJ4hwCjzKxslOsapNQYed
        YirqaeUw/4xxuo1MAQWkFlAUpLfCxivntMCJEtJPATTXDuNaIPg394Q57Y24w3GF9fWcwxkD
        sHjWYndc6UMwp3vKzm60H/zw5yfPJuF0OQ8ac0t5jmIQwPnX5XybRdISWPO1m7TxMno17Pw1
        BGzsQgdB66UBzMYEvRYWNnXa5+50OHxcNIQ5nOWw+cYwYWMB7Q9zZnPtd3B6HZwr6MAd7AF7
        hvWYg1fBqrF8PBu46hblukWJblGiW5QUAsIAPFklJ4+WcwHKAAV72p+TyrkERbT/kRNyE7A/
        XeJXDaoME/51AKNAHYAULnZziaFqo4QuR6WJSazqRJQqIY7l6oA3RYg9XLpP3ooU0tHSePY4
        yypZ1f8tRgm8UrCaHg+fjIW8H5YBj9MHFO8GliYU80Z7CkryjLH6lspBTZuyMbg8v7BCJi/8
        +CVus8Hnem1rm481vj9GJhF1rNqy4s5sM2pKNC95IQjkW/dod+6+tjKDbFqT9nk3nR19bEE/
        2uSGVhAz0Pv+y1S/lv7fVTevoDm1Z8l2zrwnMETb3rnDPVKU+s1yPrSrUy2aPPvp1hKNpNdd
        Pr8vt4/RyvTOvrHpyeF9B3ctJO1fn515N1Fo0Rict+ZN5CRhvjSvqONiZFhvqVhcZo2oXrah
        N/ByY8/9F25pE1gdAiXGG1Xq5ErfkKfNd6zk3sH4UEsRaJipvq3OOixLWecVrHwmJrgYaYAE
        V3HSv6G1FnFjAwAA
X-CMS-MailID: 20201130084422epcas1p1483ad5cd7f62e6bd1b1a552fdad63c37
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20201123003254epcas1p1763e1ce693d7cb8e2f20d521e701ad5f
References: <CGME20201123003254epcas1p1763e1ce693d7cb8e2f20d521e701ad5f@epcas1p1.samsung.com>
        <20201123002723.28463-1-digetx@gmail.com>
        <d12880ba-6780-cfee-7667-3723fcad9f3a@samsung.com>
        <20201130083646.GA6711@kozik-lap>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11/30/20 5:36 PM, Krzysztof Kozlowski wrote:
> On Mon, Nov 30, 2020 at 05:44:39PM +0900, Chanwoo Choi wrote:
>> Hi Dmitry,
>>
>> The v5.10-rc6 was released from linus git tree.
>> Generally, I will send the pull-quest about devfreq to linux-pm.git maintainer
>> after releasing the v5.1-rc7 for the integration test on linux-pm.git.
>>
>> The icc patches in this patch have not yet merged. If these patches
>> are not merged before v5.10-rc7, Maybe, I'll apply the devfreq patches
>> for v5.12-rc1.
> 
> None of the patches here are going to be merged to Linus' in the current
> cycle. They will only go to the next so if there is dependency,
> everything will be broken and non-bisectable.
> 
> However no such dependencies or merging requirements were mention in the
> cover letter.

Thanks for reply. The devfreq patch depends on the icc changes.
I'll apply the devfreq patches on next time (v5.12-rc1). Thanks.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
