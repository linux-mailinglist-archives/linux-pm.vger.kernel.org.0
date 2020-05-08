Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31B001CA1B9
	for <lists+linux-pm@lfdr.de>; Fri,  8 May 2020 05:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbgEHDyr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 May 2020 23:54:47 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:60685 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbgEHDyr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 May 2020 23:54:47 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200508035443epoutp03debcdf297d69c79f35b20acc9c82c18c~M8U1v6DzQ3224432244epoutp03B
        for <linux-pm@vger.kernel.org>; Fri,  8 May 2020 03:54:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200508035443epoutp03debcdf297d69c79f35b20acc9c82c18c~M8U1v6DzQ3224432244epoutp03B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1588910083;
        bh=F962LpSrFOl3x1UqKVgw8NIpqI4eBnKTQnStyDbMIiU=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=hivsNr5lFveg12lfH2F0F9EFy02h0KDxHJv6DZDRNKEOFAuuFyqWzywjbENSLBSAN
         Rwvh0CdqL7DVz9osk54bYdgLUs1lifUaSeaLU69MoRRhALCrC3z4h9nAB2PDOqokiY
         rF0k0ijA2qOgn1Iqk33qNkw/acG2866i0RLxM95o=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20200508035442epcas1p3077679ccbe91f54e6c87f08fd38f7ba1~M8U1D0jw42074720747epcas1p3j;
        Fri,  8 May 2020 03:54:42 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.152]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 49JGg43gk2zMqYkj; Fri,  8 May
        2020 03:54:40 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        F5.F9.04402.008D4BE5; Fri,  8 May 2020 12:54:40 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200508035438epcas1p12d02b9a9ac102e68b74bdd62ce9d390a~M8UxmMiTp0145501455epcas1p14;
        Fri,  8 May 2020 03:54:38 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200508035438epsmtrp22236cf07c6ebe21b7c0b72292534dfee~M8UxlWPia2412024120epsmtrp2X;
        Fri,  8 May 2020 03:54:38 +0000 (GMT)
X-AuditID: b6c32a35-753ff70000001132-73-5eb4d8008b39
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        96.DC.18461.EF7D4BE5; Fri,  8 May 2020 12:54:38 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200508035438epsmtip2b574f3494727385bbd41c8aa15358639~M8UxVCku41898718987epsmtip2A;
        Fri,  8 May 2020 03:54:38 +0000 (GMT)
Subject: Re: [PATCH v2] PM / devfreq: tegra: Add Dmitry as a maintainer
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <921abb5e-8c12-db8b-b345-fbe49080dc1c@samsung.com>
Date:   Fri, 8 May 2020 13:04:35 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20200402221723.6064-1-digetx@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SaUwTURDHfT22W6D6rKJjjYirH4SEwlqLq1KioWqjRjHGixhwhRWQHptu
        qdcH8YhVIioRNTYVFWOi4hWpAjWEWIxK8ArEEzEaUDzxQI1EQbtsjXz7zbz5z/WGlGvPEToy
        3+7inHbWShERiisNcfqEQY/9mUmerTFM5Zd2xGz3ViiYO1s/qJiWgI9gukuuI2bXNy/BtG45
        RTC3m5qVTE+gXDFDban1tqksJdu6CIv/gUdh2eM/gyzdl2LSlRkFKXkcm8M5Yzl7tiMn355r
        ouYtzkrLMiYn0Qn0VGYKFWtnbZyJMs9PT5idbw01RMW6WWthyJXOCgKVmJridBS6uNg8h+Ay
        URyfY+Wn8nqBtQmF9lx9tsM2jU5KmmQMBa4qyGu7cUPJt0auD5T3qIpQg7oYqUnAk6G4r1cl
        shbXILhXpCtGESH+iuDlvkPhhx8IDvaZ/wkaf5YppaA6BG/OtoaNTwjKOz0hgySH4Tmw96hJ
        9A/HvxHcb21Wimo5XgENtZUykQkcD/VvHhMiD8Hj4MHPdiSyBqdCxeWgTMyjwBPAtzdVdEfj
        pdB4ZXs4ZCg0Hu5QiKzGRvB7PofTj4SnHUdlEo+F6o8+udgD4NMk9H3wyaQJzHD7WrVS4mHw
        7qZfJbEOurvqCIk3wenG64Qk3onAX38/LDBA/cn9/c3JcRxcCCRK7nFQ++sIkgoPhq7vu/v3
        AFgDO3dopZDx0PKiLdzCKDjh2UXsQ5R3wDjeASN4B4zg/V/sGFKcQSM4XrDlcgLN0wP/+hLq
        P9V4Yw0quzs/iDCJqCgN86UqU6tk3cIGWxABKaeGa0rX+zO1mhx2w0bO6chyFlo5IYiMoWWX
        ynXR2Y7Q4dtdWbRxksFgYCbTyUaapkZqDjyyZmpxLuviCjiO55z/dDJSrStCTWMj/zyJPsIv
        OEfXOF73zWxR97g3H5qlNXdGZSS625akLSq9zByvfFFSXF0Vk2A+75uoW8G9ndPhL3P39iYu
        fzcr3ZTyNrn0T0SHvn3h3JX44WpDlT4Y3CisjRr98Rk/ffW6TfXvIzW3np+4umN3VXNdxpjg
        sozAK/lFTdOadWklcZRCyGPpeLlTYP8Cpg/OkcADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphkeLIzCtJLcpLzFFi42LZdlhJXvff9S1xBp9mm1qs/viY0aJl1iIW
        i7NNb9gtLu+aw2bxufcIo0Xnl1lsFrcbV7BZnDl9idXi5655LA6cHjtn3WX36G1+x+ax5Wo7
        i0ffllWMHp83yQWwRnHZpKTmZJalFunbJXBl3D12jLXgNnfFrnk/2RsYD3N2MXJySAiYSJz8
        MYW1i5GLQ0hgN6PEkt2X2CESkhLTLh5l7mLkALKFJQ4fLoaoecsoMaP7MBtIXFjAXaJ/vi1I
        XESggUmiddEyJpBeZoFIiZ65W9ggGjoYJa7N2wyWYBPQktj/4gYbiM0voChx9cdjRhCbV8BO
        YtHWQ0wgQ1kEVCTm9NuBhEUFwiR2LnnMBFEiKHFy5hMWEJtTwFRiS/sHVohd6hJ/5l1ihrDF
        JW49mQ91g7zE9rdzmCcwCs9C0j4LScssJC2zkLQsYGRZxSiZWlCcm55bbFhgmJdarlecmFtc
        mpeul5yfu4kRHGFamjsYt6/6oHeIkYmD8RCjBAezkgjvxIotcUK8KYmVValF+fFFpTmpxYcY
        pTlYlMR5bxQujBMSSE8sSc1OTS1ILYLJMnFwSjUwnT4Sdicg7kIMwySVOdoyFw77avyb+niB
        9pV0Vr8fBRMtDm3wT/v7f8OS//FT5/faZe6VNJKzqa7p31D+96bjehYtlULDZdGP59e5btQU
        vPHolFjnSZfVvx83S3jeY6tx2NPVpmLR8/Tx/uDdCps9Zu4vfHJyI0drbs/UmK/Zif2Tuu4w
        zNmRabvKvsV7xqeYGJlT5ZGrouekzsowexlpxr2L9dbX/twE7cNzdl/lPtR2Zql8jMuKr6+f
        y0++/MlLsdhoupdc82njLU9WTdKdciTq0SWOW05GKhvr4/04o62rGT+/XFNy3XPGVcajCjc2
        hthL1zw4OadxwqV5eeoveOwmNDqZ/ZTq71V4WpWwTImlOCPRUIu5qDgRAKmLcc4fAwAA
X-CMS-MailID: 20200508035438epcas1p12d02b9a9ac102e68b74bdd62ce9d390a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200402222006epcas1p4027cd509b32ba2d2bdf90e9e84cf4bec
References: <CGME20200402222006epcas1p4027cd509b32ba2d2bdf90e9e84cf4bec@epcas1p4.samsung.com>
        <20200402221723.6064-1-digetx@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

Could you please apply it to linux-pm directly?

I think that it is better to be applied directly
for preventing the possible merge conflict of MAINTAINERS file.

Best Regards,
Chanwoo Choi

On 4/3/20 7:17 AM, Dmitry Osipenko wrote:
> I was contributing to the NVIDIA Tegra20+ devfreq drivers recently and
> want to help keep them working and evolving in the future.
> 
> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
> 
> Changelog:
> 
> v2: - Addressed review comments made by Chanwoo Choi to v1 by correcting
>       git's address, making this patch standalone and adding Rafael Wysocki
>       to the list of email recipients.
> 
>  MAINTAINERS | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 245a96316636..0a694e20ea19 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10922,6 +10922,15 @@ F:	include/linux/memblock.h
>  F:	mm/memblock.c
>  F:	Documentation/core-api/boot-time-mm.rst
>  
> +MEMORY FREQUENCY SCALING DRIVERS FOR NVIDIA TEGRA
> +M:	Dmitry Osipenko <digetx@gmail.com>
> +L:	linux-pm@vger.kernel.org
> +L:	linux-tegra@vger.kernel.org
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git
> +S:	Maintained
> +F:	drivers/devfreq/tegra20-devfreq.c
> +F:	drivers/devfreq/tegra30-devfreq.c
> +
>  MEMORY MANAGEMENT
>  M:	Andrew Morton <akpm@linux-foundation.org>
>  L:	linux-mm@kvack.org
> 
