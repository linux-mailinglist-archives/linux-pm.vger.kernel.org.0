Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2873EBBDC
	for <lists+linux-pm@lfdr.de>; Fri,  1 Nov 2019 03:07:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbfKACHo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 31 Oct 2019 22:07:44 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:20105 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbfKACHo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 31 Oct 2019 22:07:44 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20191101020741epoutp037baa50c976a499dbc45906290e1c408a~S58bfPdYC1438314383epoutp03P
        for <linux-pm@vger.kernel.org>; Fri,  1 Nov 2019 02:07:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20191101020741epoutp037baa50c976a499dbc45906290e1c408a~S58bfPdYC1438314383epoutp03P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1572574061;
        bh=Mjkj938/enFh7TXgaZ4m6p1lCXUWvuW9Fi6TAR5IgyY=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=UQI/U/mQ0UOLZsR749FoTtbV97Y3bFFCvqC4JmhF8yi1GM3YSE/sxtoQ706aP5VXj
         ANXgMgfhuqj8TvDCLhr8KlYN4kwTe7q7TO2pJJVNCZeRN165vu1iBojXwKvPkPHKCN
         fL4BxPHGRO+811nTZQ2Cn8HbetiGwunDVpn6gDkc=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191101020740epcas1p2aa32d253a377589e7581435ad5e84c8c~S58amUT1O0469504695epcas1p2W;
        Fri,  1 Nov 2019 02:07:40 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.155]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4745Dk4NC4zMqYlr; Fri,  1 Nov
        2019 02:07:34 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        EC.6A.04068.6639BBD5; Fri,  1 Nov 2019 11:07:34 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191101020733epcas1p26a7edb3b5ccfc94dba4457a1f6fda43e~S58ULdvBy0471704717epcas1p2H;
        Fri,  1 Nov 2019 02:07:33 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191101020733epsmtrp219afc68ffdf8456c7c4b7d35e274d609~S58UKYD2D0860008600epsmtrp2U;
        Fri,  1 Nov 2019 02:07:33 +0000 (GMT)
X-AuditID: b6c32a39-f47ff70000000fe4-88-5dbb936682dd
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        5D.05.25663.5639BBD5; Fri,  1 Nov 2019 11:07:33 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191101020733epsmtip1151317cac9cd94cb06cd606ab23fc878~S58T2ig891794917949epsmtip1X;
        Fri,  1 Nov 2019 02:07:33 +0000 (GMT)
Subject: Re: [PATCH v10 06/11] PM / QoS: Reorder pm_qos/freq_qos/dev_pm_qos
 structs
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Abel Vesa <abel.vesa@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <072ef916-1753-ddc9-0fe8-7704b85def7a@samsung.com>
Date:   Fri, 1 Nov 2019 11:13:04 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <254e9ed653c7d9d866a860673629d02351c1afd8.1572556786.git.leonard.crestez@nxp.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPJsWRmVeSWpSXmKPExsWy7bCmvm7a5N2xBm2zlS0OHdvKbvH19ClG
        i2WXjjJaTN+7ic3i/PkN7BZnm96wW6y4+5HVYtPja6wWXb9WMlt87j3CaPF5w2NGi9uNK9gs
        Vp87yGZx5vQloOyhv2wWG796OAh4vL/Ryu4xu+Eii8eCTaUem1Z1snncubaHzWPzknqPje92
        MHkcfLeHyWPL1XYWj74tqxg9Pm+SC+COyrbJSE1MSS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1
        tLQwV1LIS8xNtVVy8QnQdcvMAXpHSaEsMacUKBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQklNg
        WaBXnJhbXJqXrpecn2tlaGBgZApUmJCdcfvyD5aCZbIVTxpbmRsYd4p3MXJySAiYSCy7NJGt
        i5GLQ0hgB6PEnttfGSGcT4wSvbM7oDLfGCWebNjCDtOy/PkFqMReRokbzZeYIJz3jBKTPh1l
        A6kSFgiVOHmijRkkISKwjlHiz+EusCpmgQfMEpOm/mYEqWIT0JLY/+IGWAe/gKLE1R+PweK8
        AnYSz9vegNksAioSK740AdVwcIgKREic/poIUSIocXLmExYQm1MgTqJl8lcmEJtZQFzi1pP5
        ULa8RPPW2WBHSAjcYpd4PeMXI8QPLhJPf/eyQNjCEq+Ow/wmJfH53V42CLtaYuXJI2wQzR2M
        Elv2X2CFSBhL7F86mQnkIGYBTYn1u/QhwooSO3/PZYRYzCfx7msPK0iJhACvREebEESJssTl
        B3eZIGxJicXtnWwTGJVmIXlnFpIXZiF5YRbCsgWMLKsYxVILinPTU4sNC0yR43sTIzixa1nu
        YDx2zucQowAHoxIP74yu3bFCrIllxZW5hxglOJiVRHi/2eyMFeJNSaysSi3Kjy8qzUktPsRo
        CgzsicxSosn5wKyTVxJvaGpkbGxsYWJoZmpoqCTO67h8aayQQHpiSWp2ampBahFMHxMHp1QD
        o/FZE+Nt1VtyXry4uPxUh/E5hsQYful2H6a175ZW3/x9aPsv90DGZxLtm1e32hmeSPZOZzj/
        zmr5xf6w/c5f5M15LWrn6zN69k5UkCmcH8lR61Ire8i8ozt3l8KEaFWFRFZBxy9/Vi+51Nv9
        wnDXm+8Tk3eyqrFf5Uvnn22zREhf1MmyRv6dEktxRqKhFnNRcSIAhmHqiwIEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFIsWRmVeSWpSXmKPExsWy7bCSnG7q5N2xBnvOCVkcOraV3eLr6VOM
        FssuHWW0mL53E5vF+fMb2C3ONr1ht1hx9yOrxabH11gtun6tZLb43HuE0eLzhseMFrcbV7BZ
        rD53kM3izOlLQNlDf9ksNn71cBDweH+jld1jdsNFFo8Fm0o9Nq3qZPO4c20Pm8fmJfUeG9/t
        YPI4+G4Pk8eWq+0sHn1bVjF6fN4kF8AdxWWTkpqTWZZapG+XwJVx+/IPloJlshVPGluZGxh3
        incxcnJICJhILH9+ga2LkYtDSGA3o8TjtjlsEAlJiWkXjzJ3MXIA2cIShw8XQ9S8ZZSY/PQD
        WI2wQKjEyRNtzCAJEYENjBIrt/5lAnGYBR4xS2w79BVq7CNGiePTmphBWtgEtCT2v7gB1s4v
        oChx9cdjRhCbV8BO4nnbGzCbRUBFYsWXJrAaUYEIiefbb0DVCEqcnPmEBcTmFIiTaJn8lQnE
        ZhZQl/gz7xIzhC0ucevJfKi4vETz1tnMExiFZyFpn4WkZRaSlllIWhYwsqxilEwtKM5Nzy02
        LDDKSy3XK07MLS7NS9dLzs/dxAiOcS2tHYwnTsQfYhTgYFTi4Z3RtTtWiDWxrLgy9xCjBAez
        kgjvN5udsUK8KYmVValF+fFFpTmpxYcYpTlYlMR55fOPRQoJpCeWpGanphakFsFkmTg4pRoY
        C/f7ufq1XufsZDybd+xq5bRcFbN8mWObLF1DQ2KXbNXaU84Zzbj0Ks/hqXkqzPLXphR1LpPp
        Xmq+ieFEB5Oy357XMxhY9z7iU5Xse2/m5N10Smx9WdnlSd8tqmNeK2vvXzF5dp/8tES1owaV
        W/1l4v/z2r8rPbCpmfPd5OBtPyVUxQ9N/e2gxFKckWioxVxUnAgAmOw9Ze0CAAA=
X-CMS-MailID: 20191101020733epcas1p26a7edb3b5ccfc94dba4457a1f6fda43e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191031213442epcas1p41dc9214e98c05c634647ef06cdd0a7f3
References: <cover.1572556786.git.leonard.crestez@nxp.com>
        <CGME20191031213442epcas1p41dc9214e98c05c634647ef06cdd0a7f3@epcas1p4.samsung.com>
        <254e9ed653c7d9d866a860673629d02351c1afd8.1572556786.git.leonard.crestez@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Leonard,

Why do you add the new patches on v10 (patch6/7/8)
in this series? If you think that need to update
the pm_qos core, you have to send the new patchset
on separate mail thread. It make the difficult
to merge the PM_QoS support of devfreq.

Please split out the patch6/7/8 from this series.

On 19. 11. 1. 오전 6:34, Leonard Crestez wrote:
> This allows dev_pm_qos to embed freq_qos structs, which is done in the
> next patch. Separate commit to make it easier to review.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> ---
>  include/linux/pm_qos.h | 74 ++++++++++++++++++++++--------------------
>  1 file changed, 38 insertions(+), 36 deletions(-)
> 
> diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
> index c35ff21e8a40..a8e1486e3200 100644
> --- a/include/linux/pm_qos.h
> +++ b/include/linux/pm_qos.h
> @@ -47,25 +47,10 @@ struct pm_qos_request {
>  struct pm_qos_flags_request {
>  	struct list_head node;
>  	s32 flags;	/* Do not change to 64 bit */
>  };
>  
> -enum dev_pm_qos_req_type {
> -	DEV_PM_QOS_RESUME_LATENCY = 1,
> -	DEV_PM_QOS_LATENCY_TOLERANCE,
> -	DEV_PM_QOS_FLAGS,
> -};
> -
> -struct dev_pm_qos_request {
> -	enum dev_pm_qos_req_type type;
> -	union {
> -		struct plist_node pnode;
> -		struct pm_qos_flags_request flr;
> -	} data;
> -	struct device *dev;
> -};
> -
>  enum pm_qos_type {
>  	PM_QOS_UNITIALIZED,
>  	PM_QOS_MAX,		/* return the largest value */
>  	PM_QOS_MIN,		/* return the smallest value */
>  	PM_QOS_SUM		/* return the sum */
> @@ -88,10 +73,48 @@ struct pm_qos_constraints {
>  struct pm_qos_flags {
>  	struct list_head list;
>  	s32 effective_flags;	/* Do not change to 64 bit */
>  };
>  
> +
> +#define FREQ_QOS_MIN_DEFAULT_VALUE	0
> +#define FREQ_QOS_MAX_DEFAULT_VALUE	(-1)
> +
> +enum freq_qos_req_type {
> +	FREQ_QOS_MIN = 1,
> +	FREQ_QOS_MAX,
> +};
> +
> +struct freq_constraints {
> +	struct pm_qos_constraints min_freq;
> +	struct blocking_notifier_head min_freq_notifiers;
> +	struct pm_qos_constraints max_freq;
> +	struct blocking_notifier_head max_freq_notifiers;
> +};
> +
> +struct freq_qos_request {
> +	enum freq_qos_req_type type;
> +	struct plist_node pnode;
> +	struct freq_constraints *qos;
> +};
> +
> +
> +enum dev_pm_qos_req_type {
> +	DEV_PM_QOS_RESUME_LATENCY = 1,
> +	DEV_PM_QOS_LATENCY_TOLERANCE,
> +	DEV_PM_QOS_FLAGS,
> +};
> +
> +struct dev_pm_qos_request {
> +	enum dev_pm_qos_req_type type;
> +	union {
> +		struct plist_node pnode;
> +		struct pm_qos_flags_request flr;
> +	} data;
> +	struct device *dev;
> +};
> +
>  struct dev_pm_qos {
>  	struct pm_qos_constraints resume_latency;
>  	struct pm_qos_constraints latency_tolerance;
>  	struct pm_qos_flags flags;
>  	struct dev_pm_qos_request *resume_latency_req;
> @@ -253,31 +276,10 @@ static inline s32 dev_pm_qos_raw_resume_latency(struct device *dev)
>  {
>  	return PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
>  }
>  #endif
>  
> -#define FREQ_QOS_MIN_DEFAULT_VALUE	0
> -#define FREQ_QOS_MAX_DEFAULT_VALUE	(-1)
> -
> -enum freq_qos_req_type {
> -	FREQ_QOS_MIN = 1,
> -	FREQ_QOS_MAX,
> -};
> -
> -struct freq_constraints {
> -	struct pm_qos_constraints min_freq;
> -	struct blocking_notifier_head min_freq_notifiers;
> -	struct pm_qos_constraints max_freq;
> -	struct blocking_notifier_head max_freq_notifiers;
> -};
> -
> -struct freq_qos_request {
> -	enum freq_qos_req_type type;
> -	struct plist_node pnode;
> -	struct freq_constraints *qos;
> -};
> -
>  static inline int freq_qos_request_active(struct freq_qos_request *req)
>  {
>  	return !IS_ERR_OR_NULL(req->qos);
>  }
>  
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
