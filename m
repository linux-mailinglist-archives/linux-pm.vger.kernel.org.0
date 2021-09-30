Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC9D41D1E5
	for <lists+linux-pm@lfdr.de>; Thu, 30 Sep 2021 05:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347978AbhI3Din (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Sep 2021 23:38:43 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:39322 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347976AbhI3Din (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Sep 2021 23:38:43 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210930033659epoutp02cd49a37e829199579db647b51d31aafe~pfE8uCMvI2767527675epoutp02d
        for <linux-pm@vger.kernel.org>; Thu, 30 Sep 2021 03:36:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210930033659epoutp02cd49a37e829199579db647b51d31aafe~pfE8uCMvI2767527675epoutp02d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1632973019;
        bh=3L70PVEx/+F97xNBRCjA70lj65JFm14a0TJ1us+LDPQ=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=OTK3ZE2TA7FAxjA/WTLRzU/S5ZxnUSfYu6XUyssa3rc8KXht4+ebrccuFbhxMGIyF
         HXU2OpkTkYE7Ebw8bpLPJ/LMCiogHRW9+IY5oqUqrG7lBGbohMBhFLOyNiHiTdEZBX
         DOxeeM/0jU+ltkqvcCF6yA0mI7Vkay1o/HoV4qPw=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210930033658epcas1p14739e98633ceb209164c236f998e6f71~pfE75zfaW0668406684epcas1p1U;
        Thu, 30 Sep 2021 03:36:58 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.38.232]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4HKf796K4pz4x9Pv; Thu, 30 Sep
        2021 03:36:53 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        20.F7.13888.5D035516; Thu, 30 Sep 2021 12:36:53 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20210930033653epcas1p34537f75ad56be624c9b9aa3b66186c4c~pfE2yQs-j3149231492epcas1p37;
        Thu, 30 Sep 2021 03:36:53 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210930033653epsmtrp229051498b39aa6bc9af23c209f8bcc99~pfE2xIGJT1081410814epsmtrp2W;
        Thu, 30 Sep 2021 03:36:53 +0000 (GMT)
X-AuditID: b6c32a39-227ff70000003640-59-615530d5aacb
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        55.20.08750.4D035516; Thu, 30 Sep 2021 12:36:52 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210930033652epsmtip1969926569f975b4587601f5e5c5b745a~pfE2bjQr-2345623456epsmtip1b;
        Thu, 30 Sep 2021 03:36:52 +0000 (GMT)
Subject: Re: [PATCH 01/10] PM / devfreq: strengthen check for freq_table
To:     Samuel Holland <samuel@sholland.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <4c306d89-836f-a8d3-90ec-ed22641d0e48@samsung.com>
Date:   Thu, 30 Sep 2021 12:58:08 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20210929044254.38301-2-samuel@sholland.org>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLJsWRmVeSWpSXmKPExsWy7bCmvu5Vg9BEg/79ehbzj5xjtXg+fx2j
        xdmmN+wWmx5fY7W4vGsOm8Xn3iOMFlP27WKzaOtcxmpx8ZSrxe3GFWwWrXuPsFs8f9TJZvHv
        2kYWi5+HzjM58Hm8v9HK7rHh0WpWj52z7rJ7bFrVyeaxeUm9x4vNMxk9+rasYvR49XUuo8fn
        TXIBnFHZNhmpiSmpRQqpecn5KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJuam2Si4+AbpumTlA
        tysplCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJVSC1JyCkwL9IoTc4tL89L18lJLrAwNDIxM
        gQoTsjPunV3JXPCbs+JDy3yWBsapHF2MnBwSAiYShw5+YwGxhQR2MEos+K7cxcgFZH9ilDg9
        5TsjhPOZUeLf4S42mI6FnX+ZIRK7GCWOHOtlh3DeM0qcPHkFqIWDQ1jAQ6LlaTFIXERgIpPE
        7PsHWEAcZoG3jBILd+1gBhnFJqAlsf/FDbCx/AKKEld/PGYEsXkF7CReTpjGBGKzCKhKLPj4
        GqxeVCBM4uS2FqgaQYmTM5+AHc4pYCnx52wXWA2zgLjErSfzmSBseYntb+cwQ5z9gkNi7wVX
        CNtF4vH0lUwQtrDEq+Nb2CFsKYnP7/ZCvVktsfLkETaQoyUEOhgltuy/wAqRMJbYv3QyE8iX
        zAKaEut36UOEFSV2/p7LCLGXT+Ld1x5WkBIJAV6JjjYhiBJlicsP7kKtlZRY3N7JNoFRaRaS
        b2Yh+WAWkg9mISxbwMiyilEstaA4Nz212LDAFB7byfm5mxjB6VrLcgfj9Lcf9A4xMnEwHmKU
        4GBWEuH9IR6cKMSbklhZlVqUH19UmpNafIjRFBi+E5mlRJPzgRkjryTe0MTSwMTMyNjEwtDM
        UEmc99hry0QhgfTEktTs1NSC1CKYPiYOTqkGJunCS8c8fD3yKjnOBM7yflZlvrT+Adf/Nx6C
        YmaV39RO3Z/kcPlh0M/4k4d444r32T+/1e5/vTfVWJixr9/gxnbO1Ep7b6+CTyJJ5jtcUr4n
        OAS858zaPtPUV27650eCn5gnGER/dNSyn53G/yIwg3eRQe3dgIML7c7IzBAsFzLmnXhyQmG+
        ooCY4kP/7qo7nzMcfm1OOdJ6x/RlcrkOX0Op+vdJk18ufPzl8f/bRw5L/rjltz9hXlCIsf2T
        Qu9t2mGeKp/rXSYJFEZu5/z01yduTnfOMSmHNx+ZN76oMJ/j59aXV2+/UCPvdsys5sP3q3xu
        /50h78aafmRptdOGeyfyYmfy2gb+P/ZoQ6azEktxRqKhFnNRcSIAi2fHh2AEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJIsWRmVeSWpSXmKPExsWy7bCSnO4Vg9BEgz9fTSzmHznHavF8/jpG
        i7NNb9gtNj2+xmpxedccNovPvUcYLabs28Vm0da5jNXi4ilXi9uNK9gsWvceYbd4/qiTzeLf
        tY0sFj8PnWdy4PN4f6OV3WPDo9WsHjtn3WX32LSqk81j85J6jxebZzJ69G1Zxejx6utcRo/P
        m+QCOKO4bFJSczLLUov07RK4Mu6dXclc8Juz4kPLfJYGxqkcXYycHBICJhILO/8ydzFycQgJ
        7GCUWHW9mwUiISkx7eJRoAQHkC0scfhwMUTNW0aJ+bf3sYLEhQU8JFqegsVFBCYzSZzcepwJ
        xGEGKXp14TojRMduRon700AmcXKwCWhJ7H9xgw3E5hdQlLj64zEjiM0rYCfxcsI0JhCbRUBV
        YsHH12D1ogJhEjuXPGaCqBGUODnzCdh1nAKWEn/OdoHVMAuoS/yZdwnKFpe49WQ+E4QtL7H9
        7RzmCYzCs5C0z0LSMgtJyywkLQsYWVYxSqYWFOem5xYbFhjlpZbrFSfmFpfmpesl5+duYgTH
        rpbWDsY9qz7oHWJk4mA8xCjBwawkwvtDPDhRiDclsbIqtSg/vqg0J7X4EKM0B4uSOO+FrpPx
        QgLpiSWp2ampBalFMFkmDk6pBiaxNJ/VLRsj7rrUbdobysUs++zHnB07ozNLVYLO5LXsyuYU
        4ZCsYl7X79RieatJe9WTvzI9590X5FkrnZ/9SvPmN2P307lst6WL7xQLr1hwYvlU84iYCpcG
        cx+18I+vp5S5O9S/Nz+cfMHXjVHuwOqJ89VvmaesLcisO1WzQbEtoV76wuSLi79Mmq6p2v9i
        xtZ/uowJ287+9HZcvFF1ud3ZtuOzAy+8Ssm3/7ph6+u3J3d0RByo2jjnb1XZLnWvnS9PJDho
        f9928Q7rgS8N4pfdP3G8sDj/k23vblnWdRcyov4obGmYOYXtw4zTbZuvTn3SLXEjPur4/UsV
        B/NzJ0puZ/OuydgptsJap8hqhY+LEktxRqKhFnNRcSIAIKpPhUwDAAA=
X-CMS-MailID: 20210930033653epcas1p34537f75ad56be624c9b9aa3b66186c4c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210929044259epcas1p45d15a4d7913caa0bf12c18bd55d48a54
References: <20210929044254.38301-1-samuel@sholland.org>
        <CGME20210929044259epcas1p45d15a4d7913caa0bf12c18bd55d48a54@epcas1p4.samsung.com>
        <20210929044254.38301-2-samuel@sholland.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 9/29/21 1:42 PM, Samuel Holland wrote:
> Since commit ea572f816032 ("PM / devfreq: Change return type of
> devfreq_set_freq_table()"), all devfreq devices are expected to have a
> valid freq_table. The devfreq core unconditionally dereferences
> freq_table in the sysfs code and in get_freq_range().
> 
> Therefore, we need to ensure that freq_table is both non-null and
> non-empty (length is > 0). If either check fails, replace the table
> using set_freq_table() or return the error.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>  drivers/devfreq/devfreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 28f3e0ba6cdd..7a8b022ba456 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -827,7 +827,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  		goto err_dev;
>  	}
>  
> -	if (!devfreq->profile->max_state && !devfreq->profile->freq_table) {
> +	if (!devfreq->profile->max_state || !devfreq->profile->freq_table) {
>  		mutex_unlock(&devfreq->lock);
>  		err = set_freq_table(devfreq);
>  		if (err < 0)
> 


Applied it. Thanks.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
