Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40CE414033F
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2020 06:16:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbgAQFQs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 Jan 2020 00:16:48 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:31074 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbgAQFQs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jan 2020 00:16:48 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200117051644epoutp03692da50bbaf3439db9002fc9ea4a2f50~qlMemFoZe2916529165epoutp03N
        for <linux-pm@vger.kernel.org>; Fri, 17 Jan 2020 05:16:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200117051644epoutp03692da50bbaf3439db9002fc9ea4a2f50~qlMemFoZe2916529165epoutp03N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1579238204;
        bh=Ve31F81RB+5f/YLj18CBdno2GZbuJKN9KNxty6tK3wc=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=lhQdzzwywXnkRC705BVL0YsW8W1apcEO9/0X39uolXtPT7PnZ+wT6Pnsj78GncKoG
         YOjBOm3A+tmLY+Nyb2T82usjzwP8RcQ2rVgDd0U5i5NDyQ38D2z3IuhFeKJAHFAkfT
         0KmLspe7MV0o4DwHlMTVU/bjln9lbuKSxx2Z5QwU=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200117051644epcas1p2cd702f26b18450c9e51ff28076316a8a~qlMeUe97W2278422784epcas1p2B;
        Fri, 17 Jan 2020 05:16:44 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.158]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 47zTnQ00WwzMqYlm; Fri, 17 Jan
        2020 05:16:42 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        8D.15.48498.833412E5; Fri, 17 Jan 2020 14:16:40 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20200117051640epcas1p3c34eb80a85f094bc40328680ac2e414d~qlMahij2T0513605136epcas1p30;
        Fri, 17 Jan 2020 05:16:40 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200117051640epsmtrp29988ed15b6b2c469e9bf678aee37731b~qlMag2TTI1927919279epsmtrp2H;
        Fri, 17 Jan 2020 05:16:40 +0000 (GMT)
X-AuditID: b6c32a36-a3dff7000001bd72-9d-5e214338f446
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        48.38.10238.833412E5; Fri, 17 Jan 2020 14:16:40 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200117051639epsmtip2d881e0424acf8def4ad95e60ae18cf57~qlMaUeOz92252822528epsmtip2Z;
        Fri, 17 Jan 2020 05:16:39 +0000 (GMT)
Subject: Re: [PATCH v4 2/3] interconnect: Relax requirement in
 of_icc_get_from_provider()
To:     =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@samsung.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Cc:     georgi.djakov@linaro.org, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com, krzk@kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <a4068452-0de0-dc5d-a7a9-3312723a9163@samsung.com>
Date:   Fri, 17 Jan 2020 14:24:00 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20200116144202.12116-3-a.swigon@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0hTYRTn293uruLqa2adhGpeC1JQd7emN9EKkhSSsKKICtdluzhxL3Y3
        yaQHPW3YC5faTIsiSDPMJ2Yty6ywqGX2sEiMMhpBz/UQpGjbNfK/3/nO73fO+Z3vUITyPBlP
        FVudvMPKmWkyWtp1KykthV2RUKiuPrKIHW3Yj9jW2hYZW+NrI1m//7KcHeo5RbLBw/2IrfVf
        l7CX+kfky6m8tqZDZN6rZ9fIvCMdTSgv2DavQLqpJMvEc0beoeKtBpux2FqUTa9ap1+h16Wr
        mRRmCZtBq6ychc+mc/ILUlYWm0Nj0KpSzuwKPRVwgkCnLc1y2FxOXmWyCc5smrcbzfYl9lSB
        swgua1GqwWbJZNRqjS5E3FpiejtxjLDfiN72vesCsRsNUW5EUYAXQ2C03I2iKSXuRhDwNiMx
        +Ibgzni1TAx+IvCdeE+4UVREcfXsczKMldiHoCeQL5I+I2j21KFwIhZvhv2XPJJwYib2Ihge
        PBhRE9gAnfWD0jAmcTL0BoYjlabjBHg6/jYiVuClMPykPYKleCH88j+IcOLwBhjo2jfJmQED
        J8cidaJwJtyq+i0X68+Gl2OnJSKeD3s764jwEICDJIzXuyct5MCEp0Yu4lj4cLdjEsdD8JOP
        FHE5NA70k6K4AkFH7yOZmNBC7/kqSXh7BE6Clp408TkBrkzUI7HxNPj0o1ImLlgBFQeUIiUR
        hl6PSEQ8B84dPEQeQ7R3ih3vFAveKRa8/5udQdImNIu3C5YiXmDsmqm/3YYiJ5qc3o3OPszv
        Q5hCdIyidq2qUCnjSoUySx8CiqBnKgZq5xYqFUaubDvvsOkdLjMv9CFdaNvHifg4gy108Fan
        ntFptFotu5hJ1zEMPVtRkxOqg4s4J1/C83be8U8noaLidyO10vB9R8Y8tiT3c7k/5sVt3aby
        yqSyxtaMHqN+cE+xP3X0eGN0u29083J9/4mdb1wNRvmdK+tvLqve0t7tLOUFaWxiq6ni/tCY
        69m7m54Rz+DGjK9Hg+7cuF11H7/c0ERVcR8rW9aszg0Y8MXmA9KGLHdMkyHzokMz/96Cx386
        tbRUMHFMMuEQuL+sSlePuAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAIsWRmVeSWpSXmKPExsWy7bCSvK6Fs2KcwZMeNov781oZLTbOWM9q
        MX3vJjaL8+c3sFtc3jWHzeJz7xFGixnn9zFZrD1yl92Bw2PTqk42jzvX9rB59G1ZxejxeZNc
        AEsUl01Kak5mWWqRvl0CV8bj3xOYCw5wVXzZtoK5gfEyRxcjJ4eEgInE7kXX2boYuTiEBHYz
        Stz+P50NIiEpMe3iUeYuRg4gW1ji8OFiiJq3jBI7J75jBqkRFoiWaF07hQkkISIwi1Hi4I8+
        sAZmgWSJO7NyIBr2MkqcetIBNpRNQEti/4sbYDa/gKLE1R+PGUFsXgE7iRtXNoPZLAKqEt/P
        nwWrERUIk9i55DETRI2gxMmZT1hAbE4BK4nDk/+yg9jMAuoSf+ZdYoawxSVuPZnPBGHLSzRv
        nc08gVF4FpL2WUhaZiFpmYWkZQEjyypGydSC4tz03GLDAsO81HK94sTc4tK8dL3k/NxNjOB4
        0tLcwXh5SfwhRgEORiUe3hlBCnFCrIllxZW5hxglOJiVRHhPzpCNE+JNSaysSi3Kjy8qzUkt
        PsQozcGiJM77NO9YpJBAemJJanZqakFqEUyWiYNTqoGx/fhDx6d5ffG9rn7SaZ2H0laeXhrl
        9PDdFb8Q1gz55TZHpj90edsgnBeyjPNQ6QPhW9f33/hkXcO4Q4Bx65qniTdez547VeSk5Mqk
        QzNWcLPU+5gWaJzjE3qr26qyOuqwmam3hu/xy0XmF/RuT7+alTor7KjXLWdnyfLLfQyyTwU1
        QkM5/+cpsRRnJBpqMRcVJwIAF5plkqMCAAA=
X-CMS-MailID: 20200117051640epcas1p3c34eb80a85f094bc40328680ac2e414d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200116144242eucas1p2bf8b4df91355974c8c96778f4ec117f7
References: <20200116144202.12116-1-a.swigon@samsung.com>
        <CGME20200116144242eucas1p2bf8b4df91355974c8c96778f4ec117f7@eucas1p2.samsung.com>
        <20200116144202.12116-3-a.swigon@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 1/16/20 11:42 PM, Artur Świgoń wrote:
> This patch relaxes the condition in of_icc_get_from_provider() so that
> it is no longer required to set '#interconnect-cells' to <1> in the DT,
> and therefore it is not required to supply dummy node IDs in the
> 'interconnects' property when node IDs are dynamically generated rather
> than hardcoded (statically allocated).
> 
> In case of the devfreq driver for exynos-bus, node IDs are dynamically
> allocated and '#interconnect-cells' is always zero.
> 
> Signed-off-by: Artur Świgoń <a.swigon@samsung.com>
> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/interconnect/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
> index 0be1764d3528..5ea270af5ff4 100644
> --- a/drivers/interconnect/core.c
> +++ b/drivers/interconnect/core.c
> @@ -335,7 +335,7 @@ struct icc_node *of_icc_get_from_provider(struct of_phandle_args *spec)
>  	struct icc_node *node = ERR_PTR(-EPROBE_DEFER);
>  	struct icc_provider *provider;
>  
> -	if (!spec || spec->args_count != 1)
> +	if (!spec)
>  		return ERR_PTR(-EINVAL);
>  
>  	mutex_lock(&icc_lock);
> 

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
