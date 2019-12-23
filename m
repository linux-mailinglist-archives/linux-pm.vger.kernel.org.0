Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5725B12907E
	for <lists+linux-pm@lfdr.de>; Mon, 23 Dec 2019 01:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbfLWAlU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 22 Dec 2019 19:41:20 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:48275 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbfLWAlU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 22 Dec 2019 19:41:20 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20191223004116epoutp03e3b1c11381e6b0bb1b970e2608bb13a5~i2T0s5AKD2760127601epoutp03R
        for <linux-pm@vger.kernel.org>; Mon, 23 Dec 2019 00:41:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20191223004116epoutp03e3b1c11381e6b0bb1b970e2608bb13a5~i2T0s5AKD2760127601epoutp03R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1577061676;
        bh=hfxb9FOBtElm++yJSXU9+y6s3nokJd85p/wnbCA7/UA=;
        h=Subject:To:From:Date:In-Reply-To:References:From;
        b=BeqgRthAn7xyDHJ+pPZLn35WtaFt/iMDgIesKzs+8MI/e8/udTJ/tUQp33nwzI9//
         KaHGXHh04vhttZ+8Y2jlMJf1sdVt0jhkz+VWR+1QloKtVCKxTmlo/UQiW1y6/rWZHs
         TDLAdkbjQHl8KTOgpyW1VIAiAFBVBGmruqKDd5tQ=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20191223004115epcas1p3d0e18be02c3650b125600ae0d77531ab~i2T0LFzS61722617226epcas1p3x;
        Mon, 23 Dec 2019 00:41:15 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.158]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 47h0rw1WQ6zMqYkb; Mon, 23 Dec
        2019 00:41:04 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        C2.4A.48498.A1D000E5; Mon, 23 Dec 2019 09:40:58 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191223004058epcas1p21cbd51d53345b21a8737fc6e08feac24~i2Tjqqr_c2954529545epcas1p2L;
        Mon, 23 Dec 2019 00:40:58 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191223004057epsmtrp15671f4ce27c4b03c7e6491f7c725de16~i2Tjp36AA3041230412epsmtrp1p;
        Mon, 23 Dec 2019 00:40:57 +0000 (GMT)
X-AuditID: b6c32a36-a3dff7000001bd72-de-5e000d1aad2f
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        09.5E.06569.91D000E5; Mon, 23 Dec 2019 09:40:57 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191223004057epsmtip1bc50f03921a346acf8352a324b94b2f3~i2Tjek2bG2788127881epsmtip1m;
        Mon, 23 Dec 2019 00:40:57 +0000 (GMT)
Subject: Re: [PATCH v2 2/2] PM / devfreq: exynos-bus: Disable devfreq-event
 device when fails
To:     Yangtao Li <tiny.windzz@gmail.com>, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, kgene@kernel.org, krzk@kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <ca7f5eb8-d549-a170-f952-90e5882b233d@samsung.com>
Date:   Mon, 23 Dec 2019 09:47:43 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20191222174132.3701-2-tiny.windzz@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHJsWRmVeSWpSXmKPExsWy7bCmrq4UL0OcwfznvBb9j18zW5w/v4Hd
        4mzTG3aLTY+vsVpc3jWHzeJz7xFGixnn9zFZ3G5cwWYx9/cENgdOj52z7rJ7bFrVyeaxeUm9
        R9+WVYwenzfJBbBGZdtkpCampBYppOYl56dk5qXbKnkHxzvHm5oZGOoaWlqYKynkJeam2iq5
        +AToumXmAN2jpFCWmFMKFApILC5W0rezKcovLUlVyMgvLrFVSi1IySmwLNArTswtLs1L10vO
        z7UyNDAwMgUqTMjOWH/yFWPBE86Kj439TA2Mb9m7GDk5JARMJDb/38/cxcjFISSwg1Hi4+RT
        UM4nRom3U/awQDjfgJyGB6wwLd8v9bJDJPYySrz79Q6q5T2jxP1GkBZODmGBeInm7zPA2kUE
        Wpkk1m+ZAJZgE9CS2P/iBhuIzS+gKHH1x2PGLkYODl4BO4mmdcYgYRYBVYn5K6cyg9iiAmES
        J7e1MILYvAKCEidnPgEbwylgJdHUdRjsImYBcYlbT+YzQdjyEtvfzgE7SELgM5vEsicTmEDm
        Swi4SLxaHQbxgbDEq+NboAEgJfGyvw3KrpZYefIIG0RvB6PElv0XoF42lti/dDLYHGYBTYn1
        u/QhwooSO3/PZYTYyyfx7msPK8QqXomONiGIEmWJyw/uMkHYkhKL2zvZIGwPiU+f29kmMCrO
        QvLZLCTfzELyzSyExQsYWVYxiqUWFOempxYbFhghx/YmRnBa1TLbwbjonM8hRgEORiUeXo5Z
        /2OFWBPLiitzDzFKcDArifDurv0bK8SbklhZlVqUH19UmpNafIjRFBjwE5mlRJPzgSk/ryTe
        0NTI2NjYwsTQzNTQUEmcl+PHxVghgfTEktTs1NSC1CKYPiYOTqkGxp0/3t1b+vPqI64fUn/e
        Xf+e3ZYvyM62P2Amk1hu6f8zOlPYZ2r8uR2lcPXpyt3Lfc8vb338kknsRg238CO2Z3JBfDJt
        ThdYfz0K3JATbRqwKmrC1zrjpXPly+fsvdTv037pzF2Wb+c/Hbdv1u3Kzdykderg11drzvNu
        SX5zXpB9ecWDdfFdWwqVWIozEg21mIuKEwG+DUovwQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplkeLIzCtJLcpLzFFi42LZdlhJTleSlyHOYOZSC4v+x6+ZLc6f38Bu
        cbbpDbvFpsfXWC0u75rDZvG59wijxYzz+5gsbjeuYLOY+3sCmwOnx85Zd9k9Nq3qZPPYvKTe
        o2/LKkaPz5vkAlijuGxSUnMyy1KL9O0SuDLWn3zFWPCEs+JjYz9TA+Nb9i5GTg4JAROJ75d6
        gWwuDiGB3YwSLxp3MEMkJCWmXTwKZHMA2cIShw8XQ9S8ZZT4NGsJWI2wQLxE8/cZLCAJEYFW
        JomFN+awQlTtZZR49LefFaSKTUBLYv+LG2wgNr+AosTVH48ZQabyCthJNK0zBgmzCKhKzF85
        FWyoqECYxM4lj5lAbF4BQYmTM5+wgNicAlYSTV2HwUYyC6hL/Jl3iRnCFpe49WQ+E4QtL7H9
        7RzmCYxCs5C0z0LSMgtJyywkLQsYWVYxSqYWFOem5xYbFhjlpZbrFSfmFpfmpesl5+duYgRH
        kpbWDsYTJ+IPMQpwMCrx8HLM+h8rxJpYVlyZe4hRgoNZSYR3d+3fWCHelMTKqtSi/Pii0pzU
        4kOM0hwsSuK88vnHIoUE0hNLUrNTUwtSi2CyTBycUg2M7hXb5pVENRj8P66avz61WPnas9i9
        ra5nZ0sk6Qa9DXtzzWLDao5TXKdlnbnZbG6E8ohumMo5vehhh+Mr/kjLIrlZslW5Ta80RJNa
        uBw+Per71681e6YB4y73K1LvA2QPFMx+Me/zF7kmt9DHt4PeHWA1vuh1Z9MNL7/na2Iau3yn
        2j7SOPBfiaU4I9FQi7moOBEA+RjZH6ACAAA=
X-CMS-MailID: 20191223004058epcas1p21cbd51d53345b21a8737fc6e08feac24
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191222174142epcas1p4ad50cacad72ab368b07ee0ebc680c9b3
References: <20191222174132.3701-1-tiny.windzz@gmail.com>
        <CGME20191222174142epcas1p4ad50cacad72ab368b07ee0ebc680c9b3@epcas1p4.samsung.com>
        <20191222174132.3701-2-tiny.windzz@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12/23/19 2:41 AM, Yangtao Li wrote:
> The exynos_bus_profile_init process may fail, but the devfreq event device
> remains enabled. Call devfreq_event_disable_edev on the error return path.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
> v2:
> -change subject
> -rename lable to err_edev
> -add return value check
> ---
>  drivers/devfreq/exynos-bus.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
> index 7f5917d59072..948e9340f91c 100644
> --- a/drivers/devfreq/exynos-bus.c
> +++ b/drivers/devfreq/exynos-bus.c
> @@ -335,10 +335,17 @@ static int exynos_bus_profile_init(struct exynos_bus *bus,
>  	ret = exynos_bus_set_event(bus);
>  	if (ret < 0) {
>  		dev_err(dev, "failed to set event to devfreq-event devices\n");
> -		return ret;
> +		goto err_edev;
>  	}
>  
>  	return 0;
> +
> +err_edev:
> +	ret = exynos_bus_disable_edev(bus);
> +	if (ret < 0)
> +		dev_warn(dev, "failed to disable the devfreq-event devices\n");
> +
> +	return ret;
>  }
>  
>  static int exynos_bus_profile_init_passive(struct exynos_bus *bus,
> 

Applied it.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
