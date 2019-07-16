Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBFC76A7B3
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2019 13:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbfGPLwQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Jul 2019 07:52:16 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:36920 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728004AbfGPLwQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Jul 2019 07:52:16 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190716115211epoutp04eb56b3337fbe2e35e3eab1868baf16f7~x4P8asx3b0850508505epoutp04a
        for <linux-pm@vger.kernel.org>; Tue, 16 Jul 2019 11:52:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190716115211epoutp04eb56b3337fbe2e35e3eab1868baf16f7~x4P8asx3b0850508505epoutp04a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563277931;
        bh=Uso2Ga8Oa+tncy5oMeiY6dXz4wVS1oVTdUBnraoGptI=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Aepz4gJzNJQbhB68NqM4iljgNuRJXuEq/wEKz+Q30UFveomaQqOjrs75jttpEYVqe
         rKlDeNQatNY/XCX6rKYiNaYSdn4rEfayK3wuiVwAzHofT8FRTR2uNyyJ2ZIAYi3C7j
         6OX0Q5Zd+DWtwC6ZSfc8Y7tHGZbNv9FrtpyqVWMY=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190716115211epcas1p2d1ba7c8d62f799f37414f246c61866e8~x4P7uriq62392723927epcas1p2a;
        Tue, 16 Jul 2019 11:52:11 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.156]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 45nzK565L3zMqYkV; Tue, 16 Jul
        2019 11:52:09 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        39.1D.04085.96ABD2D5; Tue, 16 Jul 2019 20:52:09 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20190716115209epcas1p39ce175e07e9bebcaab4423343f24280d~x4P6Iisk63262332623epcas1p3N;
        Tue, 16 Jul 2019 11:52:09 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190716115209epsmtrp1ab84819cc8f5308a7338686047710f7b~x4P6HxGZ42099420994epsmtrp1i;
        Tue, 16 Jul 2019 11:52:09 +0000 (GMT)
X-AuditID: b6c32a39-cebff70000000ff5-27-5d2dba6952ba
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        7E.1D.03706.96ABD2D5; Tue, 16 Jul 2019 20:52:09 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190716115209epsmtip1ffe9b7031567957857071367bb616d4a~x4P59znDW2972629726epsmtip1Y;
        Tue, 16 Jul 2019 11:52:09 +0000 (GMT)
Subject: Re: [PATCH v4 06/24] PM / devfreq: tegra30: Tune up boosting
 thresholds
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
Message-ID: <fe402767-430b-7554-c1c5-c75d7dcd04aa@samsung.com>
Date:   Tue, 16 Jul 2019 20:55:15 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190707223303.6755-7-digetx@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SWUwTURTNa6fTqVgdi8oVtzIuCdUiQx0ZVHCNaYSPqglxCcEJTIDQLZ2W
        gMaIokCJiEqioSC4QRQkoEGFBiUCKi4obriSgBCDaNwhEgnadjDyd+495y7nvUtIVdV4IJFi
        tvM2M2ek8AnY1ZbgEG2KWxsXerw4jK361ovYA64zGNu+/5Ocfeouwdkf+a2Idf504eybfedx
        dthdirGHq5/gqxX6+q5zSN/g6pLr87M+4/rDdZVI/+PyHINse+rKZJ5L5G1q3pxgSUwxJ0VS
        0Vvi18Uzy0JpLR3BhlNqM2fiI6n1MQbthhSjZyFKncYZHZ6UgRMEaknUSpvFYefVyRbBHknx
        1kSjNcIaInAmwWFOCkmwmJbToaFhjEe4MzU5s+CdxNqmSO/46p+JeuR5iCCAXAr9p6fnoQmE
        iqxH8HWwCM9DCk/wHcGp9lUiMYSgt/O93Et4C1oev8ZF4jqCkvJRJAZfEAxUFvhU/uRmuFlc
        KPMSU8lRBM7hLF9fKbkNWhqqJF6Mkxpo6n/py08mg+D5r17kxUoyCvKfvcK8GCMXwJ2eYz79
        NHIr3GstxUTNFLhb1OfDCpKBj4WtSOwfAK/7yiQingtZV4ql3iWA/IPD22NDMtH0enBdmyja
        8YeBO3Vj1gLhQ0H2GN4NF+624mJtLoK6pg6ZSOigqbxQ4u0jJYOhxr1ETAdBw++TYztMgs+D
        h8ZGKSE3WyVK5sHT7i6JiGfA2RwnfgRRrnFuXOMcuMY5cP0fdgphlWg6bxVMSbxAW5nxf30Z
        +U5VE1GPbj+MaUYkgaiJyrbGxXEqGZcmZJiaERBSaqoycnBRnEqZyGXs4m2WeJvDyAvNiPE8
        9lFp4LQEi+fwzfZ4mgnT6XTsUnoZQ9NUgLJ0JDhORSZxdj6V56287V+dhFAEZiLGaTg4MqNM
        e+FRUdMGqbajwu+ec1H+7I4XAyWx63Iu1qavnSPvm9/Y3TJUdmTSrNvhJwpvtHV+NOxdmHsp
        WtDkVWr0PzNqdhQN70Gpzt+3ak0ORbWw8WLzlm2Ysv9+UJTxvXrNs00VJ7J3rKhqbP80K0KX
        TuDVfg+YM7HuzpmxaS8oTEjmaI3UJnB/AZLEEFbAAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFIsWRmVeSWpSXmKPExsWy7bCSnG7mLt1Yg+Y7kharPz5mtGiZtYjF
        4mzTG3aLy7vmsFl87j3CaNH5ZRabxe3GFWwWP3fNY7HoW3uJzYHTY8fdJYweO2fdZffobX7H
        5tG3ZRWjx+dNcgGsUVw2Kak5mWWpRfp2CVwZDf2PmApOcFZc+CDcwPiQvYuRk0NCwETi8MVb
        bF2MXBxCArsZJTb82M0EkZCUmHbxKHMXIweQLSxx+HAxRM1bRolp836xgdQICwRJHJw9mRUk
        ISLQxCSxqfcC2FRmgUiJnrlboKZuZpRY9fQNM0iCTUBLYv+LG2Dd/AKKEld/PGYEsXkF7CR6
        r9xkAbFZBFQljj+cBHaFqECExKRrO1kgagQlTs58AmZzCphKvJ58hBFimbrEn3mXmCFscYlb
        T+YzQdjyEs1bZzNPYBSehaR9FpKWWUhaZiFpWcDIsopRMrWgODc9t9iwwDAvtVyvODG3uDQv
        XS85P3cTIzjGtDR3MF5eEn+IUYCDUYmH98QenVgh1sSy4srcQ4wSHMxKIry2X7VjhXhTEiur
        Uovy44tKc1KLDzFKc7AoifM+zTsWKSSQnliSmp2aWpBaBJNl4uCUamDMf/6v7JVFtkbb7mUN
        sl2hqTtvV61P+tl9aMd+/Zw7EwKe+8ROzEvM2y6470+B5HROp9IFP3inRm0NDDsWtmiVYsi2
        SQ97J/s+3735/49S9rOBrV7TYm5///6Z4fH7lbFd1ZcZLqsvDNf93Nfhpzh93b8FV8LCwlec
        +Zk1uzXSOPdpVYLj5eA/SizFGYmGWsxFxYkAXLDEMq0CAAA=
X-CMS-MailID: 20190716115209epcas1p39ce175e07e9bebcaab4423343f24280d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190707223648epcas5p29ffd69f96e6ab840877647be14df6b0b
References: <20190707223303.6755-1-digetx@gmail.com>
        <CGME20190707223648epcas5p29ffd69f96e6ab840877647be14df6b0b@epcas5p2.samsung.com>
        <20190707223303.6755-7-digetx@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19. 7. 8. 오전 7:32, Dmitry Osipenko wrote:
> Now that average-sustain coefficient / multiplier is gone, it won't hurt
> to re-tune the boosting thresholds to get a bit harder boosting for MCALL
> clients, resulting in a more reactive governing in a case of multimedia
> applications usage like 3d / video.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/devfreq/tegra30-devfreq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
> index 16f7e6cf3b99..2bf65409ddd8 100644
> --- a/drivers/devfreq/tegra30-devfreq.c
> +++ b/drivers/devfreq/tegra30-devfreq.c
> @@ -111,8 +111,8 @@ static struct tegra_devfreq_device_config actmon_device_configs[] = {
>  		.irq_mask = 1 << 26,
>  		.boost_up_coeff = 200,
>  		.boost_down_coeff = 50,
> -		.boost_up_threshold = 60,
> -		.boost_down_threshold = 40,
> +		.boost_up_threshold = 50,
> +		.boost_down_threshold = 25,
>  	},
>  	{
>  		/* MCCPU: memory accesses from the CPUs */
> 

It just adjusts the tunable point.
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
