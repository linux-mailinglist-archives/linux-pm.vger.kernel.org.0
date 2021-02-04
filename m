Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 704AE30EE90
	for <lists+linux-pm@lfdr.de>; Thu,  4 Feb 2021 09:38:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234935AbhBDIgS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Feb 2021 03:36:18 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:63101 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234755AbhBDIgR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 4 Feb 2021 03:36:17 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210204083534epoutp03679b418df38548627242248d953d1a4e~gfntKbZBn1467314673epoutp03e
        for <linux-pm@vger.kernel.org>; Thu,  4 Feb 2021 08:35:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210204083534epoutp03679b418df38548627242248d953d1a4e~gfntKbZBn1467314673epoutp03e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1612427734;
        bh=gwn/3D2wr8w6Pv5ev3ds0QbI94AFvWuW7FIuYPrZABw=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Zpg9QOuA1KSj5QnR4MalYe0+g1hHl9Fy22IpSqSL0+8vGrgnsRm+6ZFc+bBnVAYOt
         1Fjl6nq93yRhDx/Qf1fv7YJXNCYsRGC3SBghYB0p8sgs9en8siou0t6k126ryxxQnA
         Uj43UvNgnVxjOHDrqUElfO8IH0T0/ZJO6ZcEpcgU=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20210204083533epcas1p3c20996977523f79e69c81773c7889e73~gfnskX5Bg0336003360epcas1p3L;
        Thu,  4 Feb 2021 08:35:33 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.156]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4DWX1b4MHXz4x9Pw; Thu,  4 Feb
        2021 08:35:31 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        16.C8.63458.3D1BB106; Thu,  4 Feb 2021 17:35:31 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210204083531epcas1p129d5f696f547bcfd03b91829d08670a8~gfnp_wj_M0371303713epcas1p1h;
        Thu,  4 Feb 2021 08:35:31 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210204083531epsmtrp1628e4696b17e22ab902fd0386691fdc7~gfnp94lrz0769707697epsmtrp1p;
        Thu,  4 Feb 2021 08:35:31 +0000 (GMT)
X-AuditID: b6c32a36-6dfff7000000f7e2-db-601bb1d3d555
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        18.63.08745.2D1BB106; Thu,  4 Feb 2021 17:35:30 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210204083530epsmtip2992315a9d786eadac0335d2d6f042b21~gfnpqasIE2649226492epsmtip2r;
        Thu,  4 Feb 2021 08:35:30 +0000 (GMT)
Subject: Re: [PATCH v6 3/3] PM / devfreq: Add required OPPs support to
 passive governor
To:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Viresh Kumar <vireshk@kernel.org>, linux-pm@vger.kernel.org
Cc:     Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Saravana Kannan <saravanak@google.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <7562fde3-cf48-fd1b-07c5-eaf02ddc15ad@samsung.com>
Date:   Thu, 4 Feb 2021 17:51:39 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20210204081424.2219311-4-hsinyi@chromium.org>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEJsWRmVeSWpSXmKPExsWy7bCmvu7ljdIJBm+uyVtMaN3ObHG26Q27
        xeVdc9gsPvceYbS43biCzeLNj7NMFmdOX2K16Dr0l83i37WNLBabHxxjc+DymN1wkcVjwaZS
        j02rOtk8tlxtZ/Ho27KK0eP4je1MHp83yQWwR2XbZKQmpqQWKaTmJeenZOal2yp5B8c7x5ua
        GRjqGlpamCsp5CXmptoqufgE6Lpl5gCdp6RQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUot
        SMkpsCzQK07MLS7NS9dLzs+1MjQwMDIFKkzIzmi+d5+94LpYxbvn29gbGKcIdTFyckgImEg8
        /f6ZpYuRi0NIYAejxI5JU5ggnE+MEuvezWWEcD4zSvy/8ZodpmXryhtsEIldjBKXV/+Ect4z
        Spy52M0CUiUsECnx4OR9NhBbRCBVYu/v1WBFzAKdTBLzt/0FK2IT0JLY/+IGWBG/gKLE1R+P
        GUFsXgE7iTM7n4HVsAioSHTPfwlmiwqESZzc1gJVIyhxcuYTsDingLXEgVufwOYwC4hL3Hoy
        nwnClpfY/nYOM8hiCYEDHBKtT6ZA/eAiMfFiOyuELSzx6vgWqLiUxMv+Nii7WmLlySNsEM0d
        jBJb9l+AajCW2L90MtAGDqANmhLrd+lDhBUldv6eywixmE/i3dceVpASCQFeiY42aGgrS1x+
        cJcJwpaUWNzeyTaBUWkWkndmIXlhFpIXZiEsW8DIsopRLLWgODc9tdiwwAg5vjcxghOvltkO
        xklvP+gdYmTiYDzEKMHBrCTCm9gmlSDEm5JYWZValB9fVJqTWnyI0RQYwBOZpUST84GpP68k
        3tDUyNjY2MLE0MzU0FBJnDfR4EG8kEB6YklqdmpqQWoRTB8TB6dUA1NIxVq5g4e6td6JV3um
        tp/589U2ecfZg3tdD3emSZ/zsglgKdHc2lBnIHf5pHFC6wwlrcj5rinHor4zPprqragdxa3K
        obDUa5FmZGniFqP9N+P9JzI/vLr1kHzvf5HdMwP2Gx1fwmP9sj8id0tw352amIO14SZT7mZy
        nKzZp9duc7bQ+JBEdq2ryeLXKnNrlknvOcWXlfRs4fO7Zo9lc+J+cAZenXlhrcGlG3vPlR9e
        ziVvpLXgTNIW3ZL2BXueJG45XfP93/81TaI9baaHl6tFLCjwEtWxNu1013Z8/MV5seIpma1Z
        he+uKZZKXnz08sVLto/P91+qEy83Ov5CzaEx0X1+1m27A4a/Lh6Pf6nEUpyRaKjFXFScCABK
        lVLHRQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsWy7bCSvO7ljdIJBtvtLSa0bme2ONv0ht3i
        8q45bBafe48wWtxuXMFm8ebHWSaLM6cvsVp0HfrLZvHv2kYWi80PjrE5cHnMbrjI4rFgU6nH
        plWdbB5brrazePRtWcXocfzGdiaPz5vkAtijuGxSUnMyy1KL9O0SuDKa791nL7guVvHu+Tb2
        BsYpQl2MnBwSAiYSW1feYOti5OIQEtjBKPH57ncWiISkxLSLR5m7GDmAbGGJw4eLIWreMkrc
        fv2QEaRGWCBSYkfjB2YQW0QgVWJiczfYIGaBbiaJR5+mMkN07GeUuPLiJStIFZuAlsT+FyDr
        ODn4BRQlrv54DDaJV8BO4szOZ2CbWQRUJLrnvwSzRQXCJHYuecwEUSMocXLmE7A4p4C1xIFb
        n8DmMAuoS/yZd4kZwhaXuPVkPhOELS+x/e0c5gmMwrOQtM9C0jILScssJC0LGFlWMUqmFhTn
        pucWGxYY5aWW6xUn5haX5qXrJefnbmIEx5+W1g7GPas+6B1iZOJgPMQowcGsJMKb2CaVIMSb
        klhZlVqUH19UmpNafIhRmoNFSZz3QtfJeCGB9MSS1OzU1ILUIpgsEwenVAOTDZPLNG0JzVn9
        ae/cFjLJnX3dencn48yGd/k91/ZM37Blc4X5jfS43cfsRX69eOx9oMW47/WLVMH1hTqTL6wR
        beZI079R+0f9ZslnbZks9cS/Nn1hse4HbuZOftF69nC04NK6qngT/ZMsUr9+1H0+d0xS5rJE
        Vu/GObvW/62+tmbZk96bBf9tV3oq309ZeXHGdl9thggL3cILsV/PprpOzQ9v1ElyfSa0UOdL
        a3CI6o9j/bz5HZZLpY15y61Kso4cv7ok8qZAYZvM1ZbpxcdCe2/flOUNlPoosEm6KC3oatoe
        ZuXybceWzjr14Or70IzZsw7EM6+M2rYp5dQt1slxb+NfTE+5PMtQLTtng6ywEktxRqKhFnNR
        cSIA9qxY3S4DAAA=
X-CMS-MailID: 20210204083531epcas1p129d5f696f547bcfd03b91829d08670a8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210204081438epcas1p3f72cee2a2d14da1742f1301053794aae
References: <20210204081424.2219311-1-hsinyi@chromium.org>
        <CGME20210204081438epcas1p3f72cee2a2d14da1742f1301053794aae@epcas1p3.samsung.com>
        <20210204081424.2219311-4-hsinyi@chromium.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Hsin-Yi,

I have reviewed this patch already.
This version looks good to me.
I add my acked-by again.

Acked-by: Chanwoo Choi <cw00.choi@samsugn.com>

Thanks,
Chanwoo Choi

On 2/4/21 5:14 PM, Hsin-Yi Wang wrote:
> From: Saravana Kannan <saravanak@google.com>
> 
> Look at the required OPPs of the "parent" device to determine the OPP that
> is required from the slave device managed by the passive governor. This
> allows having mappings between a parent device and a slave device even when
> they don't have the same number of OPPs.
> 
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
>  drivers/devfreq/governor_passive.c | 25 ++++++++++++++++++-------
>  1 file changed, 18 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
> index 63332e4a65ae8..8fd51cc9b991a 100644
> --- a/drivers/devfreq/governor_passive.c
> +++ b/drivers/devfreq/governor_passive.c
> @@ -19,7 +19,7 @@ static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
>  			= (struct devfreq_passive_data *)devfreq->data;
>  	struct devfreq *parent_devfreq = (struct devfreq *)p_data->parent;
>  	unsigned long child_freq = ULONG_MAX;
> -	struct dev_pm_opp *opp;
> +	struct dev_pm_opp *opp, *p_opp = ERR_PTR(-ENODEV);
>  	int i, count, ret = 0;
>  
>  	/*
> @@ -29,7 +29,7 @@ static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
>  	 */
>  	if (p_data->get_target_freq) {
>  		ret = p_data->get_target_freq(devfreq, freq);
> -		goto out;
> +		return ret;
>  	}
>  
>  	/*
> @@ -56,13 +56,22 @@ static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
>  	 * list of parent device. Because in this case, *freq is temporary
>  	 * value which is decided by ondemand governor.
>  	 */
> -	opp = devfreq_recommended_opp(parent_devfreq->dev.parent, freq, 0);
> -	if (IS_ERR(opp)) {
> -		ret = PTR_ERR(opp);
> -		goto out;
> +	p_opp = devfreq_recommended_opp(parent_devfreq->dev.parent, freq, 0);
> +	if (IS_ERR(p_opp)) {
> +		ret = PTR_ERR(p_opp);
> +		return ret;
>  	}
>  
> -	dev_pm_opp_put(opp);
> +	if (devfreq->opp_table && parent_devfreq->opp_table) {
> +		opp = dev_pm_opp_xlate_required_opp(parent_devfreq->opp_table,
> +						    devfreq->opp_table, p_opp);
> +		if (!IS_ERR(opp)) {
> +			*freq = dev_pm_opp_get_freq(opp);
> +			dev_pm_opp_put(opp);
> +		} else
> +			ret = PTR_ERR(opp);
> +		goto out;
> +	}
>  
>  	/*
>  	 * Get the OPP table's index of decided freqeuncy by governor
> @@ -89,6 +98,8 @@ static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
>  	*freq = child_freq;
>  
>  out:
> +	dev_pm_opp_put(p_opp);
> +
>  	return ret;
>  }
>  
> 
