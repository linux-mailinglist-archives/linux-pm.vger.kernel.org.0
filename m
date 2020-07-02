Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB03421191B
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jul 2020 03:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729365AbgGBBb2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Jul 2020 21:31:28 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:36069 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729161AbgGBB02 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Jul 2020 21:26:28 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200702012624epoutp04107d30f062769ca4a3dc82d45c9e63eb~dyyDJsmxS0685806858epoutp04M
        for <linux-pm@vger.kernel.org>; Thu,  2 Jul 2020 01:26:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200702012624epoutp04107d30f062769ca4a3dc82d45c9e63eb~dyyDJsmxS0685806858epoutp04M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1593653184;
        bh=r1UFsiX2gwfp92mr5h2mcmJhno2JQaKBbzAcYSiCUl8=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=RZMHakJ0LqLcS9+mkPgg5tQuI53jBUhPlWcUeq/6iVfR4lWghSpL7WNRjHwFC16NV
         it91x05T45LcfFeOxtfq26b21sE0ldqtaBm28Zjy92AusPvR3u6/Cc52amb82htvGP
         BCgDPT9j5x+g4LGL3QwYNdZb6YcUUIUr7Hl17JlE=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20200702012624epcas1p410dab840a52e6bcfe5710e2e3593618a~dyyCeaIou1419414194epcas1p44;
        Thu,  2 Jul 2020 01:26:24 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.158]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 49y0mZ0jyWzMqYkw; Thu,  2 Jul
        2020 01:26:22 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        21.E8.19033.BB73DFE5; Thu,  2 Jul 2020 10:26:19 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200702012618epcas1p22d53f5f254949f59ff091b8035ec360d~dyx9lI0RM0909209092epcas1p2k;
        Thu,  2 Jul 2020 01:26:18 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200702012618epsmtrp12406b726074bc36123645b856551a985~dyx9idkVH1619716197epsmtrp1T;
        Thu,  2 Jul 2020 01:26:18 +0000 (GMT)
X-AuditID: b6c32a36-6ed22a8000004a59-3d-5efd37bb1fc2
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        6C.69.08303.AB73DFE5; Thu,  2 Jul 2020 10:26:18 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200702012618epsmtip2dc5d3d6ff220c54a553be1ac4db67d1a~dyx9IzkTV2710427104epsmtip2G;
        Thu,  2 Jul 2020 01:26:18 +0000 (GMT)
Subject: Re: [PATCH v4 16/37] PM / devfreq: tegra20: Adjust clocks
 conversion ratio and polling interval
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>
Cc:     =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@samsung.com>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <fef085ec-62e6-58e1-d34c-bfbc7a6a2e71@samsung.com>
Date:   Thu, 2 Jul 2020 10:37:34 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20200609131404.17523-17-digetx@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPJsWRmVeSWpSXmKPExsWy7bCmru5u879xBn82s1vcn9fKaPHu01NW
        i/lHzrFarP74mNHiytf3bBbT925is2iZtYjF4mzTG3aLy7vmsFl87j3CaNH5ZRabxcVTrha3
        G1ewWUxaO5XRonXvEXaLf9c2slj83DWPxUHQ4/2NVnaPnbPusntcOveH2WPTqk42jzvX9rB5
        3O8+zuTR2/yOzaNvyypGj8+b5AI4o7JtMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1DS0t
        zJUU8hJzU22VXHwCdN0yc4B+UVIoS8wpBQoFJBYXK+nb2RTll5akKmTkF5fYKqUWpOQUWBbo
        FSfmFpfmpesl5+daGRoYGJkCFSZkZ7xasYi1YJNwxb6jV9gaGF/ydzFyckgImEh823ecvYuR
        i0NIYAejxObml1DOJ0aJ5mnXWEGqhAQ+M0rcXlkJ13FpGzNE0S5Gibn3r0J1vGeUODd9GztI
        lbBAlsT9e/PYQBIiAkeYJVZ3HmcEcZgFLjNKnG37wgZSxSagJbH/xQ0wm19AUeLqj8eMIDav
        gJ3E72cHwHazCKhItO9ewgxiiwqESZzc1gJVIyhxcuYTFhCbU8Bc4vfb6WBzmAXEJW49mc8E
        YctLbH87B+xWCYF2TonbBy+yQTzhIrH34y5GCFtY4tXxLewQtpTEy/42KLtaYuXJI2wQzR2M
        Elv2X2CFSBhL7F86GWgDB9AGTYn1u/QhwooSO3/PZYRYzCfx7msPK0iJhACvREebEESJssTl
        B3eZIGxJicXtnWwTGJVmIXlnFpIXZiF5YRbCsgWMLKsYxVILinPTU4sNC4yQ43sTIzila5nt
        YJz09oPeIUYmDsZDjBIczEoivKcNfsUJ8aYkVlalFuXHF5XmpBYfYjQFBvBEZinR5HxgVskr
        iTc0NTI2NrYwMTQzNTRUEudVk7kQJySQnliSmp2aWpBaBNPHxMEp1cBkxmHzeoXVOa57lW+t
        7YSMPH9wcfH+cmGrLedOe32N94jh/eyLD5wmp9j7OjyTeNBldTijwdNfM00yu7FSsqXEdnlu
        Rf3ssJcbdMPWbj+wNPl0z+GzM4SUma7nPo491bAm49Bk9frI51s/FdslWh/4WxO5psU+5Qnv
        sRWbuspvsYjPqv+7Lblu+rmWG0wPTX3n2DKyxatIlr5k3pk3qWnyYaZlkbNjm30NbiQb7n4n
        cZlNgrd2YURtyf01wo/Crzz6tbOKXWrO+oPd308Zmejr+XI/7evtXPo189E7oeRpegs7XS+0
        NCYHZfvtD3u2QO7NLFkJi83aq0/L8d/WXVt56nhNF2O0pPT3BSael5VYijMSDbWYi4oTAT0q
        dw5yBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Re0hTYRjG/c45np1Jw+NW7bMkc1niQtMS/IiQIKVjRESZQYa52sH7lB0v
        aRFlmc0wpfK2RE1KbZbVSptLK5xLdChObURODGZSllnquqld5gj87/fyPL/nn5fChb3EGipR
        kcEqFbIUCelGtBok3gH60MXYoNHuADRWnQ/Q55l3rqimq98VNX21ATRsnyZReYeWRBfUdQTq
        y/vEQ0P6KhLNFnUBpJpTk8jcG4FGzjWS6Oq9UoDyO7p46LflIYF+6quJnR7M9Ot8HtOmHuUx
        g/0LOKPVqEjGamknmbHL3RhTdP4zyVx5rAHMrHbdfv4Rtx1yNiUxi1VuCYtzS5hsrHNN14pO
        PjMOk2fBB/dCwKcgHQK/DbbihcCNEtI6AG0VE5gz8IRlZuO/gPrHImgwcM7OFID117SEoyOi
        k6DmTR/pCFbSL3GoNZkwx4HTQwDqVHbSqbQCWGoeXlJIWgqfv39NOtid9oGvftiAgwV0GJyf
        eOHqYIL2hQVPb+EOXkVHw7ZbNszZ8YA9leNLO3w6FM5PlS/t4LQfXKgexJ0shm/GazAne8Mn
        U1V4CRCpl+nqZYp6maJeptQCQgM82XQuNT6VC07fqmCzAzlZKpepiA88kZaqBUvvlkp1oF3z
        JbATYBToBJDCJSsFpqBfsUKBXJaTyyrTjikzU1iuE6ylCIlYYFffjBXS8bIMNpll01nl/xSj
        +GvOYjEbinX78nKbb3SMiMey9FFppXd8I5+YCgij5Xf0vrnvD6hsmfssJ6n0uPR8oD2ndMXI
        YgnZ5OeyaNlYNGctmLTP1+6p/CiShgsWvZIMtxvkXR+/nTZOb25Ozjpn+8E/wD1I/rThS8wC
        FyPu673zUO7TdgGGHb/fvJY2BVvydhfXRKjqDyUkHNSHZ2t1LcZj8WfsWNPdUOup8fWqDK8X
        u8z9faNxVfmKvRWMy4eNm2K7J07F1eYePXH4VZQ5YPvENjTQYi17e70ncJt/jkElj/TsnSsn
        H+nC50cvzvjjLe94oUCzOUboFa06cprzoqxRxX/g6hDz9k2ZMy4NyeKLEoJLkAVLcSUn+wuK
        LJ35XQMAAA==
X-CMS-MailID: 20200702012618epcas1p22d53f5f254949f59ff091b8035ec360d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200609131504epcas1p1069393852a0d53f5ea31ded7aff34a93
References: <20200609131404.17523-1-digetx@gmail.com>
        <CGME20200609131504epcas1p1069393852a0d53f5ea31ded7aff34a93@epcas1p1.samsung.com>
        <20200609131404.17523-17-digetx@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 6/9/20 10:13 PM, Dmitry Osipenko wrote:
> The current conversion ratio results in a higher frequency than needed,
> that is not very actual now since the Display Controller driver got
> support for memory bandwidth management and hence memory frequency can
> go lower now without bad consequences. Since memory freq now goes to a
> lower rates, the responsiveness of interactive applications become worse
> due to a quite high polling interval value that is currently set to 500ms.
> Changing polling interval to 30ms results in a good responsiveness of the
> system.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/devfreq/tegra20-devfreq.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/devfreq/tegra20-devfreq.c b/drivers/devfreq/tegra20-devfreq.c
> index 249d0dc44f6c..7cdea4ba38f7 100644
> --- a/drivers/devfreq/tegra20-devfreq.c
> +++ b/drivers/devfreq/tegra20-devfreq.c
> @@ -79,16 +79,12 @@ static int tegra_devfreq_get_dev_status(struct device *dev,
>  
>  	/*
>  	 * EMC_COUNT returns number of memory events, that number is lower
> -	 * than the number of clocks. Conversion ratio of 1/8 results in a
> -	 * bit higher bandwidth than actually needed, it is good enough for
> -	 * the time being because drivers don't support requesting minimum
> -	 * needed memory bandwidth yet.
> -	 *
> -	 * TODO: adjust the ratio value once relevant drivers will support
> -	 * memory bandwidth management.
> +	 * than the number of total EMC clocks over the sampling period.
> +	 * The clocks number is converted to maximum possible number of
> +	 * memory events using the ratio of 1/4.
>  	 */
>  	stat->busy_time = readl_relaxed(tegra->regs + MC_STAT_EMC_COUNT);
> -	stat->total_time = readl_relaxed(tegra->regs + MC_STAT_EMC_CLOCKS) / 8;
> +	stat->total_time = readl_relaxed(tegra->regs + MC_STAT_EMC_CLOCKS) / 4;
>  	stat->current_frequency = clk_get_rate(tegra->emc_clock);
>  
>  	writel_relaxed(EMC_GATHER_CLEAR, tegra->regs + MC_STAT_CONTROL);
> @@ -98,7 +94,7 @@ static int tegra_devfreq_get_dev_status(struct device *dev,
>  }
>  
>  static struct devfreq_dev_profile tegra_devfreq_profile = {
> -	.polling_ms	= 500,
> +	.polling_ms	= 30,
>  	.target		= tegra_devfreq_target,
>  	.get_dev_status	= tegra_devfreq_get_dev_status,
>  };
> 

Ackded-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
