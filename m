Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03BA56A8CA
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2019 14:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732906AbfGPM3O (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Jul 2019 08:29:14 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:38805 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728470AbfGPM3N (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Jul 2019 08:29:13 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190716122910epoutp02ab91f2ec5219e77f054d770a6cb95032~x4wO9K6xO2286622866epoutp02X
        for <linux-pm@vger.kernel.org>; Tue, 16 Jul 2019 12:29:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190716122910epoutp02ab91f2ec5219e77f054d770a6cb95032~x4wO9K6xO2286622866epoutp02X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563280150;
        bh=hh2LdVR0ZS2p7Tx29kN5GzbdlcD2XPhwMYMSi/iWb3s=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=PM0OLLoTszPubcK50A28r1u9EVgYCt1J1vMzKkkec2LZOT48ITxa3jRuawBvCBbbT
         NR16vUjMHn5csRKkY+/4CEDpDh8+IuE5XENs2e2cFo5Hjvyh5K4I45YdI2fBAnbl43
         5C6BiG+nGUv4tPMFZwf2BMr119hK4GH4YqYTACUY=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190716122909epcas1p40fb95c79bb247eaa71050e4f8939b649~x4wN98taA1486514865epcas1p4k;
        Tue, 16 Jul 2019 12:29:09 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.154]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 45p07m4CLXzMqYkY; Tue, 16 Jul
        2019 12:29:08 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        EF.6D.04088.413CD2D5; Tue, 16 Jul 2019 21:29:08 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190716122907epcas1p2f858c2cb04093f8054139b8c5ddc617a~x4wL1bkMC0408604086epcas1p2h;
        Tue, 16 Jul 2019 12:29:07 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190716122907epsmtrp23640085f56318cabcbdf3df08d338bab~x4wLyJn283055930559epsmtrp2M;
        Tue, 16 Jul 2019 12:29:07 +0000 (GMT)
X-AuditID: b6c32a35-85dff70000000ff8-52-5d2dc3146303
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        60.6E.03706.313CD2D5; Tue, 16 Jul 2019 21:29:07 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190716122907epsmtip236b012402c142bd529f0b4c2ea84916d~x4wLjR4pd3107831078epsmtip2T;
        Tue, 16 Jul 2019 12:29:07 +0000 (GMT)
Subject: Re: [PATCH v4 15/24] PM / devfreq: tegra30: Fix integer overflow on
 CPU's freq max out
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
Message-ID: <bf0cf31f-4a03-f8f5-ac7b-280a384bb09d@samsung.com>
Date:   Tue, 16 Jul 2019 21:32:13 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190707223303.6755-16-digetx@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SfUyMcRzf716ensPxuKKv5uV60FaUe+TykItR3MYf0Vih1bPu2XW6N/dc
        VpiVI4ryvumRWPKWGSOpLNfbSozFyQylqY0Z14gmhLt7rum/z+/7+3y+n+/n9/viYsVNLAQ3
        mO2szcwYSWycpKYlXBUZ1BKZqrrYNoO+9qUP0fv4Cgn9eO+nANpVX4bRg8WtiC78xmP06/wr
        GD1cXy6hS64/w1bItLXdlUhbx3cHaIsdbkxbUl2FtIO3ZiZKN2cty2QZHWtTsuYMi85g1mvI
        tUlpq9LUMSoqklpCLyaVZsbEasj4dYmRqw1Gz0CkcgdjzPaUEhmOIxfELbNZsu2sMtPC2TUk
        a9UZrUusURxj4rLN+qgMi2kppVItVHuI6VmZeV1W6wE8p6yrXZyHmrAiJMOBWAT5PR3SIjQO
        VxC1CO5WuTHh8BVBQ2mBWDgMIfg5/ACNSo4Ut/klDQj6eo/6JQMIvg18lnhZgQQDHYecIu9F
        EPEHQeGww+coJlKgpe6ayIsxIgKcH1766pOIUOj60eezkBNxUMGPSL1YQswF5+V3vqZTiGR4
        2FouETiToaO034dlRAyMvHuDhP7B8Kr/nEjAs8Bx54wvAxB/MTh9/JVUyBAPp26/8ONA+Nhe
        HSDgEBh0N/ifZhdc7WjFBPFBBNXOTr8gGpwXT3gccI9DONyoXyCUQ6Hu11n/EBPB/f2w1EsB
        Qg4HCxQCZTa4ertFAp4GFw4UYkcRyY+Jw4+JwI+JwP83O48kVWgqa+VMepajrNTY776FfNsa
        oa5FJ5+sa0YEjsgJcqVzfqpCyuzgck3NCHAxGSTXfJ+XqpDrmNydrM2SZss2slwzUnte+5g4
        ZEqGxbP7ZnsapV4YHR1NL6Ji1BRFBsvLf4enKgg9Y2ezWNbK2kZ1IlwWkoe2DJ5V1CYtd8/p
        HEluKOIqqwxxG3R/MnJgW/l4QqUJTQpqTBi4/yiHHRqu2eqaeqFp6ISh5vapK+mO0L7druld
        3IrGojWHw5LDwnoq6i9V52/XZ+1JSFE+j+3VvK8McIEj52Hxpn71ftlKd0LsVX7y40udufKn
        50fc96YN/X67fiMp4TIZKkJs45h/yGtcV8MDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFIsWRmVeSWpSXmKPExsWy7bCSvK7wYd1Yg4udoharPz5mtGiZtYjF
        4mzTG3aLy7vmsFl87j3CaNH5ZRabxe3GFWwWP3fNY7HoW3uJzYHTY8fdJYweO2fdZffobX7H
        5tG3ZRWjx+dNcgGsUVw2Kak5mWWpRfp2CVwZDVcLCto5KuZcPc7cwHiQrYuRk0NCwESiv/cY
        axcjF4eQwG5Gic2vb0ElJCWmXTzK3MXIAWQLSxw+XAxR85ZRYsPuJ2A1wgKJEie79zOBJEQE
        mpgkNvVeYAdJMAtESvTM3cIG0bGFUaLveDcTSIJNQEti/4sbYN38AooSV388ZgSxeQXsJBbN
        +ssKYrMIqErsX/6IBcQWFYiQmHRtJwtEjaDEyZlPwGxOATOJv4/uMEIsU5f4M+8SM4QtLnHr
        yXwmCFteonnrbOYJjMKzkLTPQtIyC0nLLCQtCxhZVjFKphYU56bnFhsWGOallusVJ+YWl+al
        6yXn525iBMeYluYOxstL4g8xCnAwKvHwfjigGyvEmlhWXJl7iFGCg1lJhNf2q3asEG9KYmVV
        alF+fFFpTmrxIUZpDhYlcd6neccihQTSE0tSs1NTC1KLYLJMHJxSDYwCP3Nu+EjqdSi6nPK9
        y3naTKzomlTcaYc1HHy3J52dwjJzkWidme2GJWKneMsMtu3s/sj7JTf6zI/0GQabbZfuunJr
        p0JQ2cfXqiVvVwe/1Dp3Q7kg/pmZ9f79d55K3T5ltqFW9+Lbb4oXbl244JmwIllc1OP39/R+
        e7fVeTnT88vXfcnX5QpRYinOSDTUYi4qTgQAeLg3vq0CAAA=
X-CMS-MailID: 20190716122907epcas1p2f858c2cb04093f8054139b8c5ddc617a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190707223632epcas4p2c3254e4cc10a71bb1311fcfef582ed39
References: <20190707223303.6755-1-digetx@gmail.com>
        <CGME20190707223632epcas4p2c3254e4cc10a71bb1311fcfef582ed39@epcas4p2.samsung.com>
        <20190707223303.6755-16-digetx@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19. 7. 8. 오전 7:32, Dmitry Osipenko wrote:
> There is another kHz-conversion bug in the code, resulting in integer
> overflow. Although, this time the resulting value is 4294966296 and it's
> close to ULONG_MAX, which is okay in this case.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/devfreq/tegra30-devfreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
> index 0de1efdaabf4..60ebf9c9cd86 100644
> --- a/drivers/devfreq/tegra30-devfreq.c
> +++ b/drivers/devfreq/tegra30-devfreq.c
> @@ -172,7 +172,7 @@ struct tegra_actmon_emc_ratio {
>  };
>  
>  static const struct tegra_actmon_emc_ratio actmon_emc_ratios[] = {
> -	{ 1400000, ULONG_MAX },
> +	{ 1400000, ULONG_MAX / KHZ },
>  	{ 1200000,    750000 },
>  	{ 1100000,    600000 },
>  	{ 1000000,    500000 },
> 

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
