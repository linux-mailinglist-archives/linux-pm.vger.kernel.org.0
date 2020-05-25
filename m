Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 471C51E0518
	for <lists+linux-pm@lfdr.de>; Mon, 25 May 2020 05:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388419AbgEYDYy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 24 May 2020 23:24:54 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:59723 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388587AbgEYDYy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 24 May 2020 23:24:54 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200525032450epoutp03bdfa406ad9d008859e125e7715cdd43d~SJ4mGL9by0784907849epoutp03L
        for <linux-pm@vger.kernel.org>; Mon, 25 May 2020 03:24:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200525032450epoutp03bdfa406ad9d008859e125e7715cdd43d~SJ4mGL9by0784907849epoutp03L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1590377090;
        bh=whwtiYVJePSOpI6IDsuK2aO2TqcSPkMQQXmpbyPPijE=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=NMlI6k/rhRiJFYKWx4gnYDDXT13iah75xPKvQd1BHbFCUinUZFRk9o4z9LxSPkUBQ
         N+mV26eeDOXMGNMKnIgiXe+mCuZjEURJem75O9XRbfZ+drkaspLyquwZWH3fyQSii/
         ZMtKLZnhHHPxjrq4LeQKMMmEeB+3qNqA0AFp9lL4=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20200525032449epcas1p46da777b14093b0d0bccb0f3faa2d10c1~SJ4ljr0oH0133401334epcas1p4q;
        Mon, 25 May 2020 03:24:49 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.153]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 49VjBk15DWzMqYkV; Mon, 25 May
        2020 03:24:46 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        DA.8C.04392.E7A3BCE5; Mon, 25 May 2020 12:24:46 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20200525032444epcas1p3cb8df5bc4db0acbf7ba0f2b015295d3f~SJ4hYp7ML0361403614epcas1p3L;
        Mon, 25 May 2020 03:24:44 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200525032444epsmtrp125c88d00e8d76f74d7ec5f9a541ecc55~SJ4hX775M1742717427epsmtrp1e;
        Mon, 25 May 2020 03:24:44 +0000 (GMT)
X-AuditID: b6c32a37-cabff70000001128-c1-5ecb3a7e9abf
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        2C.0D.08303.C7A3BCE5; Mon, 25 May 2020 12:24:44 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200525032444epsmtip1889fb26a38d4bdb0f8e0eb4860e0caf9~SJ4hNyvK01369713697epsmtip1r;
        Mon, 25 May 2020 03:24:44 +0000 (GMT)
Subject: Re: [PATCH v3 2/3] extcon: max14577: Add proper dt-compatible
 strings
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Sebastian Reichel <sre@kernel.org>,
        Mark Brown <broonie@kernel.org>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <8441253a-c8c9-17be-e2a7-7d96f1369dd5@samsung.com>
Date:   Mon, 25 May 2020 12:35:08 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20200522102448.30209-2-m.szyprowski@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SWUwTURSGc5l2OqDVsYAe+qBljFGILGMtjAaIBoJEfKiY+KAGHOlYKt3S
        aYlLomhcQAVFU5YKiqBRMaaIbNaHGiTBYoIiwTVEicQdBbER9cVpp0TevnPO/+e/595LYIpG
        XEkYzHbOZmaNFB4h6XwQl5hwcO2j/OTDxwjmdq1byjhHx3Dm8eNWGTPkqceZqYpexNzqHZEx
        rw9fx5lH9+zriJy2lnI8p7K9BeVMtS3WYtuK04o4VsfZVJy50KIzmPXpVO6WgswCTUoynUCv
        YVIplZk1celU1iZtQrbBKByAUpWwRofQ0rI8TyVlpNksDjunKrLw9nSKs+qM1jXWRJ418Q6z
        PrHQYlpLJyev0gjCncVF0x7G2jh378CpbmkpKo84icIJIFdD9ad+dBJFEAqyG4Gz7j4uFj8Q
        XPzZKROLKQTeiXP4jKWiwi0VBx4EHUf6Q5bvCD66moOqSFILfwangxxFGqB34HPQgZGDCN5X
        VAUHOBkP3o8vgjyfjIXh6XcowHIyA2qu+IMsIZfBRPnzIEeTW8HXeTSkWQC+ujFJgMMF/bPJ
        +rAAY+QieDV2KcRLoGu8HgsEA1lFQM2d4TBxhyy4cOl0iCPhc1+7TGQlfDpzPMQH4IavFxfN
        ZQjavU+k4kAN3qvnBTMhJMSB25MktmPh7t8GJAbPg2/+09KABEg5lB1XiJKlMPR2JBQbA80n
        yvGziHLNWsc1awXXrBVc/8MakaQFLeSsvEnP8bRVPfu521Dwd8andqPWgU09iCQQNVeudfbn
        K6RsCb/P1IOAwKgo+YZsoSXXsfv2czZLgc1h5PgepBFuuwpTRhdahL9uthfQmlVqtZpZTado
        aJpaJHc+N+YrSD1r54o5zsrZZnxhRLiyFMX4dhyVOBprq336lXlqt5JomvTfbNr8BVSqmvHM
        Oqvn8nJnQ5zR7Tp0+eX86i7daM36sqzKybcjUVj/rsHf17/GLnlT+mHOxYjdGyOnri02vKdJ
        oz8vMUOyYXufd0/ujS4i/qn/WeFDmWZFRt7oH3kMNfBLlVlbn9Ih6YqebPBTEr6IpeMxG8/+
        AxRUs3uzAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDLMWRmVeSWpSXmKPExsWy7bCSnG6N1ek4g1MbzC02zljPajH14RM2
        i/PnN7BbXN41h83ic+8RRou1R+6yW9xuXMFmcXp3iQOHx6ZVnWwefVtWMXp83iQXwBzFZZOS
        mpNZllqkb5fAlfFjl0XBAp6Kc907WBsYO7m6GDk5JARMJHp717N2MXJxCAnsYJR4dfc+K0RC
        UmLaxaPMXYwcQLawxOHDxSBhIYG3jBITTzmD2MICfhK7WyYwg9giApkSO/ZfZAKZwyxwmVFi
        680eRoihRxklDnxvAqtiE9CS2P/iBhuIzS+gKHH1x2NGEJtXwE5i+pKvYDaLgKrEh87rYLao
        QJjEziWPmSBqBCVOznzCAmJzAtVf+zgHLM4soC7xZ94lZghbXOLWk/lQcXmJ7W/nME9gFJ6F
        pH0WkpZZSFpmIWlZwMiyilEytaA4Nz232LDAKC+1XK84Mbe4NC9dLzk/dxMjOIK0tHYw7ln1
        Qe8QIxMH4yFGCQ5mJRFed7dTcUK8KYmVValF+fFFpTmpxYcYpTlYlMR5v85aGCckkJ5Ykpqd
        mlqQWgSTZeLglGpgunx0/6TmKz8uPjgxUeNy3p3FWlvaXO3NEnlZA3j2bt0RK/8yk3tWwjyd
        Xx+cbRyErwVP8zO/v6pG5N2RZ4f6bj9S2FJsEqH3W1smqsTsLPc8SfvHnUdvvZFQ1/LSvmld
        YBzK9pQ39M5TDScdvoZt/kt2mK3lY54b13yK/eZf3R8sue8/NNVXhq28F8At1ZgV46ASvy1A
        etmCN/Y717LtfpFluFBz0uLXPz9IOfxJF03MjHonKfjVpk/T5x2LwBt13tvmb1YdyWJQLevK
        WH9JY3ugetmFZG+XIm6RgwauCpqiX3/7bbXTPv13S0HyvaOHXj+NS/VsvnknIuPxl6/xXpMt
        GdzjWPWFbc6FixYrsRRnJBpqMRcVJwIAlAEnig8DAAA=
X-CMS-MailID: 20200525032444epcas1p3cb8df5bc4db0acbf7ba0f2b015295d3f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200522102455eucas1p24b695b7f6c533681f544be166ea69200
References: <20200522102448.30209-1-m.szyprowski@samsung.com>
        <CGME20200522102455eucas1p24b695b7f6c533681f544be166ea69200@eucas1p2.samsung.com>
        <20200522102448.30209-2-m.szyprowski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Marek,

On 5/22/20 7:24 PM, Marek Szyprowski wrote:
> Add device tree compatible strings and create proper modalias structures
> to let this driver load automatically if compiled as module, because
> max14577 MFD driver creates MFD cells with such compatible strings.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
> v3:
> - sorted of_max14577_muic_dt_match
> v2:
> - added .of_match_table pointer
> ---
>  drivers/extcon/extcon-max14577.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/extcon/extcon-max14577.c b/drivers/extcon/extcon-max14577.c
> index 32f663436e6e..03af678ddeba 100644
> --- a/drivers/extcon/extcon-max14577.c
> +++ b/drivers/extcon/extcon-max14577.c
> @@ -782,9 +782,19 @@ static const struct platform_device_id max14577_muic_id[] = {
>  };
>  MODULE_DEVICE_TABLE(platform, max14577_muic_id);
>  
> +static const struct of_device_id of_max14577_muic_dt_match[] = {
> +	{ .compatible = "maxim,max14577-muic",
> +	  .data = (void *)MAXIM_DEVICE_TYPE_MAX14577, },
> +	{ .compatible = "maxim,max77836-muic",
> +	  .data = (void *)MAXIM_DEVICE_TYPE_MAX77836, },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, of_max14577_muic_dt_match);
> +
>  static struct platform_driver max14577_muic_driver = {
>  	.driver		= {
>  		.name	= "max14577-muic",
> +		.of_match_table = of_max14577_muic_dt_match,
>  	},
>  	.probe		= max14577_muic_probe,
>  	.remove		= max14577_muic_remove,
> 

Applied it. Thanks.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
