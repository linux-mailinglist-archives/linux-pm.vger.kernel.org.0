Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB76D6CC63
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jul 2019 11:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbfGRJzt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Jul 2019 05:55:49 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:30436 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbfGRJzs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Jul 2019 05:55:48 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190718095545epoutp0187e450f6339d709ef004a5b3a9761d1f~yd815I0RR0374803748epoutp01h
        for <linux-pm@vger.kernel.org>; Thu, 18 Jul 2019 09:55:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190718095545epoutp0187e450f6339d709ef004a5b3a9761d1f~yd815I0RR0374803748epoutp01h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563443745;
        bh=1cYZWpty8TVGacXVxE+PxB2lbSa/vNMvyWISzXqDHPg=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=qk5FB1Y9HY6us/8pP8Wh7stYR3NXVkRuw8Yntij+ENAP88ATGnLX9oPcG5IKFGnEL
         ttOugkvH+qdw2lykouRIsI9Kjl0xIIk0BaxEeZ9gaNGxr6RPe0E6u9OYohpcISwxbw
         UU8isQj+auYUmM6Ifz0noNhgHPMTEJyi8js3B6gY=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190718095544epcas1p47240fdfe7dd495da81d22e1ef39ec478~yd81TlRIl1186211862epcas1p43;
        Thu, 18 Jul 2019 09:55:44 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.157]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 45q8dn4NRtzMqYkW; Thu, 18 Jul
        2019 09:55:41 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        1D.0A.04066.D12403D5; Thu, 18 Jul 2019 18:55:41 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190718095540epcas1p18bda7f795298f17535b8a0dcb84ffa06~yd8yFw3gd3203532035epcas1p1F;
        Thu, 18 Jul 2019 09:55:40 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190718095540epsmtrp15f171dcf38d6fa0e3c90b1eecbc85174~yd8yE-SvJ2027720277epsmtrp1R;
        Thu, 18 Jul 2019 09:55:40 +0000 (GMT)
X-AuditID: b6c32a37-e27ff70000000fe2-64-5d30421d46b2
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        52.AD.03706.C12403D5; Thu, 18 Jul 2019 18:55:40 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190718095540epsmtip28e3b00eaf901b54c93cb191b8e1e25de~yd8x5H1TW1226412264epsmtip2n;
        Thu, 18 Jul 2019 09:55:40 +0000 (GMT)
Subject: Re: [PATCH v4 22/24] PM / devfreq: tegra30: Include appropriate
 header
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <2f317faf-8de0-2717-cda7-b15374039493@samsung.com>
Date:   Thu, 18 Jul 2019 18:58:50 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190707223303.6755-23-digetx@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SeUwTQRTGMz22rbG6FtEnRq2LGCGBdi2FRQWNEtJEY/BK1ARxhU1Berlb
        iMc/KAYBRSXeK7bGI4h3FJBWDaaixjMqIUGgIoGoIIHgCSrGbbdG/vvNN9+b976ZUUo1V7AI
        Za7NybA22kJgY2R196N1sdMW6zP0PYOR1KXBLkTt5s/IqOe7+hRUk7cSo76UNyKq9CuPUW07
        L2DUsNclo/ZfeY0tUpnq/eeQycP7Fabyon7MtL/mIjJ9uTE9Xb4+b0EOQ2czrJaxZdmzc23m
        ZGLpqswlmcYEPRlLJlGJhNZGW5lkInVZemxarkUYiNAW0JZ8QUqnOY7QpSxg7flORptj55zJ
        BOPItjiSHHEcbeXybea4LLt1HqnXzzUKxo15OVc73iBHp2Lr4NFj8kLUgJUhlRLweBh8+CnI
        Grwegevz0jI0RuDPCCr21krExXcEnuFPin8VR0oKFeLGXQR7qw4gcTGA4KGvXTgLU4bhKyAj
        oE7E/yAoHS4KdpDi6+C+55IkwBgeAw0fW4L6eHwmNA91oQCr8RTw+tuDHhkeBT/flskDHI6v
        hSeNLpnomQCPT3QHWYUnQNdAJxLPnwyt3W6JyDOgqPakNDAE4D8waK3oC0VOheq6e6EwYdD7
        qCbEEdBzoDjEO6D6cSMmFpcgqGl4KRc3DNBw/pDQQSl0iIZrXp0ozwTPr1OhIcZB/7d98oAF
        cDWUFGtESyQ0vfNLRJ4CZ/eUYgcRwY+Kw4+KwI+KwP9vdhrJLqJJjIOzmhmOdBhGv/UNFPyq
        MYn16PqLZT6EKxExVt1C6DI0crqA22b1IVBKiYnqth5BUmfT27YzrD2TzbcwnA8ZhduukEaE
        Z9mFj29zZpLGuQaDgYonE4wkSUxWu35HZ2hwM+1k8hjGwbD/6iRKVUQhmhXn9g+psenFZ8An
        iSe3JLZVze+QZvWGP7m58h68ab3OpmjXXJ6jXZha9ar8sHO9a94UY9hqrPR4k46ffWfzpltl
        afS+bnbDs8sfCr4XFd7OPV03cHZkSfP748vtfKRK1j3ydGTaA7XPM2mjua5yndstdZsOOmuj
        vO1pU39WVHYSMi6HJmOkLEf/BTpiWwfAAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBIsWRmVeSWpSXmKPExsWy7bCSvK6Mk0GsQWe/qcXqj48ZLVpmLWKx
        ONv0ht3i8q45bBafe48wWnR+mcVmcbtxBZvFz13zWCz61l5ic+D02HF3CaPHzll32T16m9+x
        efRtWcXo8XmTXABrFJdNSmpOZllqkb5dAlfGuvs3GQsesld8nDadtYFxP1sXIyeHhICJxNSO
        BvYuRi4OIYHdjBINO9YzQiQkJaZdPMrcxcgBZAtLHD5cDFHzllFi+t5OoAY2DmGBQIlYkKiI
        QBOTxKbeC+wgncwCkRI9c7ewQZRvYZR42NfPCpJgE9CS2P/iBthefgFFias/HoOt4hWwk9h1
        9w4TiM0ioCrx614XWL2oQITEpGs7WSBqBCVOznwCZnMKmEk8fv+QEWKZusSfeZeYIWxxiVtP
        5jNB2PISzVtnM09gFJ6FpH0WkpZZSFpmIWlZwMiyilEytaA4Nz232LDAMC+1XK84Mbe4NC9d
        Lzk/dxMjOL60NHcwXl4Sf4hRgINRiYf3hpJ+rBBrYllxZe4hRgkOZiUR3tsvgUK8KYmVValF
        +fFFpTmpxYcYpTlYlMR5n+YdixQSSE8sSc1OTS1ILYLJMnFwSjUwZkw3ap7b4iXCIKaS6Xj9
        RVa6nkKZVPFmrdDkR9tL/uc2HVynpFzrtLU0/MftrqgAofI64bC3ZezX5s/pd2Lm8Nki35ZV
        9Vsxt7r6Lte5LLc0oT8sEp/aDy1ojlWLCBGvtW/6EfFhdoDqXw0ns13VoenFzbusH+WszVIt
        /h4Wfulz+z3hfCWW4oxEQy3mouJEAPmzSrSrAgAA
X-CMS-MailID: 20190718095540epcas1p18bda7f795298f17535b8a0dcb84ffa06
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190707223620epcas4p16538beeb317e2ed0cbecb64147f32b71
References: <20190707223303.6755-1-digetx@gmail.com>
        <CGME20190707223620epcas4p16538beeb317e2ed0cbecb64147f32b71@epcas4p1.samsung.com>
        <20190707223303.6755-23-digetx@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19. 7. 8. 오전 7:33, Dmitry Osipenko wrote:
> It's not very correct to include mod_devicetable.h for the OF device
> drivers and of_device.h should be included instead.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/devfreq/tegra30-devfreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
> index 8a674fad26be..19e872a64148 100644
> --- a/drivers/devfreq/tegra30-devfreq.c
> +++ b/drivers/devfreq/tegra30-devfreq.c
> @@ -13,7 +13,7 @@
>  #include <linux/io.h>
>  #include <linux/irq.h>
>  #include <linux/module.h>
> -#include <linux/mod_devicetable.h>
> +#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_opp.h>
>  #include <linux/reset.h>
> 

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

Is not there other unused header file anymore?

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
