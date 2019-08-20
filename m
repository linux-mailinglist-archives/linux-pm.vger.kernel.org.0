Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6F895218
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2019 02:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728795AbfHTACQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Aug 2019 20:02:16 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:52369 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728721AbfHTACQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Aug 2019 20:02:16 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190820000213epoutp043955b7da26278b1be16ffb581f030a84~8eJC5tdVz2736827368epoutp04L
        for <linux-pm@vger.kernel.org>; Tue, 20 Aug 2019 00:02:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190820000213epoutp043955b7da26278b1be16ffb581f030a84~8eJC5tdVz2736827368epoutp04L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1566259333;
        bh=1IZDAsELDme1WOYVxDryTaAg4O77J7UQde+jdSXIPI0=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=lEULkMivshUYXAcQ9YKc2gnw2RhmL0azUbaxEBWs6Vp70fx21ARSCx1uRYPWyGARP
         tuDOM0X+xUdAk8V6GOg53DR9nh3aKyk7MaPRilVar/jSHCdagku7EnIk9sYpwvp92d
         6n/ex6IPmT40Xb8Qq56JFGn1gCjLJ2MVrtlGMiU8=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190820000212epcas1p2af04979a0188984b33d68b06d3d873d5~8eJCXyOqJ1984219842epcas1p2r;
        Tue, 20 Aug 2019 00:02:12 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.152]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 46C9vh0gHPzMqYlm; Tue, 20 Aug
        2019 00:02:08 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        F1.66.04088.F783B5D5; Tue, 20 Aug 2019 09:02:07 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190820000207epcas1p16180da78ca4b50c001ddd930984d18ef~8eI9PMm2R0990409904epcas1p1q;
        Tue, 20 Aug 2019 00:02:07 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190820000207epsmtrp1e115e27bd6b29f136519a538fd53ec57~8eI9OHGeU2556025560epsmtrp1p;
        Tue, 20 Aug 2019 00:02:07 +0000 (GMT)
X-AuditID: b6c32a35-85dff70000000ff8-75-5d5b387f9c9d
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        01.53.03706.F783B5D5; Tue, 20 Aug 2019 09:02:07 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190820000207epsmtip22ff4beb6e8d48b6fc4a3b6c41eda76ff~8eI9BlO3A1455614556epsmtip2A;
        Tue, 20 Aug 2019 00:02:07 +0000 (GMT)
Subject: Re: [PATCH v6 03/19] PM / devfreq: tegra30: Handle possible
 round-rate error
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
Message-ID: <b57acb3f-ef28-b945-0b8f-38892dc131bb@samsung.com>
Date:   Tue, 20 Aug 2019 09:06:01 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190811212315.12689-4-digetx@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRjm2+VsRrPPpfW6qPSEQSMvR50dw9m9BgkZBnZB7KAHFbedubOZ
        1o+85iUv2U1aptMySo1uGiqG5YSwKCIzShsIRphFUVpolrXtGPnveZ/nvT3f98rFyluESp5h
        tLBmI6MniUWSe451IcHH6UNJYTZnMN36dQzRRbYmCf204JOMHuyuI+jJyn5El03ZCHok/xpB
        z3TXS+iqGy+IzV66TucVpOuyOWW6ysLPhK6qvQXpJu+sipcezIxJZ5lU1hzAGlO41Axjmpbc
        nZC8LVkTFUYFU9H0BjLAyBhYLbk9Lj54Z4betRAZkM3orS4qnuF5MjQ2xsxZLWxAOsdbtCRr
        StWbok0hPGPgrca0kBTOsJEKCwvXuBIPZ6afb5iRmkZwTmVDqygP3VKUIy854Ei4fbcElaNF
        ciXuRFBRPCUTgm8I6n4NS4TgB4LaJ38k/0p+No6JBOE+guayHqkQfEHwumAOubOW4kR4W9Ej
        dgu+eA5B2Uwh4RbE+AA4ulpFbkxgNfSOv/bwS3AgDE2PeYoVOBacD954eAkOgtHyAg/vh/fD
        t1GHVMjxgYEL7zwreeEouFE5LRL6L4fhdw3zeDUUdlz0LAF4loD+07dd7uSuYDucG14p2FkK
        E4/aZQJWwYfqE/P4GFwf6CeE2lIE7b3PpYIQAb3NZ0TuPmK8Dm52hwp0IHTNXkLCXG/4/L1C
        KoxSQOkJpZCyBgZHnSIB+8PlkjLiFCJtC9zYFjiwLXBg+z/MjiQtaBlr4g1pLE+ZqIXffQd5
        rlWt6URnn8X1ISxH5GKF7vzBJKWUyeZzDX0I5GLSV5FT56IUqUzuUdbMJZutepbvQxrXY9eI
        VX4pnOv2jZZkShMeERFBR1JRGooilysap+kkJU5jLGwmy5pY8786kdxLlYc0M9fa9mSWGEbs
        00Un87G2MTtEzflwJw9MqNq8s3qbijfZjaK+j9bBoKD4Ze8jY7LiLvjUBJKJjp7xcZ/HWd2a
        mBp/eylnf/4qN3Js6vfW+iND+5K2FDXE7kqIu7tC2z7xcKdjZSGj+NhVU73j8dxVWWhHhnrz
        3k3r17bU1r58+4GU8OkMpRabeeYv3eiRusMDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsWy7bCSvG69RXSswdxGfovVHx8zWrTMWsRi
        cbbpDbvF5V1z2Cw+9x5htOj8MovN4nbjCjaLn7vmsVj0rb3E5sDpsePuEkaPnbPusnv0Nr9j
        8+jbsorR4/MmuQDWKC6blNSczLLUIn27BK6MafN/shbcFqjonb+aqYFxA28XIyeHhICJxK+F
        j5m6GLk4hAR2M0rcXHKdFSIhKTHt4lHmLkYOIFtY4vDhYoiat4wSC95vYwepERYIl7jTs4cZ
        JCEi0MQksan3AliCWSBSomfuFjaIjq2MEj+/QyTYBLQk9r+4wQZi8wsoSlz98ZgRxOYVsJO4
        e+AmWJxFQFXiQVcTWFxUIELi8I5ZUDWCEidnPmEBsTkFzCTW9v5gglimLvFn3iVmCFtc4taT
        +VBxeYnmrbOZJzAKz0LSPgtJyywkLbOQtCxgZFnFKJlaUJybnltsWGCYl1quV5yYW1yal66X
        nJ+7iREcZVqaOxgvL4k/xCjAwajEw+sxLSpWiDWxrLgy9xCjBAezkghvxRygEG9KYmVValF+
        fFFpTmrxIUZpDhYlcd6neccihQTSE0tSs1NTC1KLYLJMHJxSDYyWy+vf7axvmB57qMpVpvX6
        s0P6fbf3NbGKrH7pfbZg+sp2k83Nx6cce6X9iDlc5Jt/o0HP0+arFnYzA5Xt12c/MStvqGsq
        Wr9lbvX7e+cuqmZmZ7fdyFbxmVlf8ZepxXVr/hJBm4s27Veyj0/6/vLE7gv21mtid1Z6PK7d
        zWL5LO/35a0TP3xUYinOSDTUYi4qTgQAe/ypOK4CAAA=
X-CMS-MailID: 20190820000207epcas1p16180da78ca4b50c001ddd930984d18ef
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190811212443epcas3p3294b8ac39ea075000fbffee6078cf068
References: <20190811212315.12689-1-digetx@gmail.com>
        <CGME20190811212443epcas3p3294b8ac39ea075000fbffee6078cf068@epcas3p3.samsung.com>
        <20190811212315.12689-4-digetx@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 19. 8. 12. 오전 6:22, Dmitry Osipenko wrote:
> The EMC clock rate rounding technically could fail, hence let's handle
> the error cases properly.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/devfreq/tegra30-devfreq.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
> index 8be6a33beb9c..bfee9d43de1e 100644
> --- a/drivers/devfreq/tegra30-devfreq.c
> +++ b/drivers/devfreq/tegra30-devfreq.c
> @@ -592,8 +592,8 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>  	struct tegra_devfreq_device *dev;
>  	struct tegra_devfreq *tegra;
>  	struct devfreq *devfreq;
> -	unsigned long rate;
>  	unsigned int i;
> +	long rate;
>  	int err;
>  
>  	tegra = devm_kzalloc(&pdev->dev, sizeof(*tegra), GFP_KERNEL);
> @@ -650,8 +650,14 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>  
>  	reset_control_deassert(tegra->reset);
>  
> -	tegra->max_freq = clk_round_rate(tegra->emc_clock, ULONG_MAX) / KHZ;
> +	rate = clk_round_rate(tegra->emc_clock, ULONG_MAX);
> +	if (rate < 0) {
> +		dev_err(&pdev->dev, "Failed to round clock rate: %ld\n", rate);
> +		return rate;
> +	}
> +
>  	tegra->cur_freq = clk_get_rate(tegra->emc_clock) / KHZ;
> +	tegra->max_freq = rate / KHZ;
>  
>  	for (i = 0; i < ARRAY_SIZE(actmon_device_configs); i++) {
>  		dev = tegra->devices + i;
> @@ -662,6 +668,13 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>  	for (rate = 0; rate <= tegra->max_freq * KHZ; rate++) {
>  		rate = clk_round_rate(tegra->emc_clock, rate);
>  
> +		if (rate < 0) {
> +			dev_err(&pdev->dev,
> +				"Failed to round clock rate: %ld\n", rate);
> +			err = rate;
> +			goto remove_opps;
> +		}
> +
>  		err = dev_pm_opp_add(&pdev->dev, rate, 0);
>  		if (err) {
>  			dev_err(&pdev->dev, "Failed to add OPP: %d\n", err);
> 

It supports the exception handling. Looks good to me.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
