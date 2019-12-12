Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEF0011C39E
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2019 03:51:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbfLLCvm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Dec 2019 21:51:42 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:48670 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727599AbfLLCvl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Dec 2019 21:51:41 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20191212025139epoutp02da48281e3224a685b06458a90b1d2963~ff-hTz5h-1223312233epoutp02W
        for <linux-pm@vger.kernel.org>; Thu, 12 Dec 2019 02:51:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20191212025139epoutp02da48281e3224a685b06458a90b1d2963~ff-hTz5h-1223312233epoutp02W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1576119099;
        bh=GnrJ15q/HFwDIHL3gFZLsi8o81NU126LeWMf5E0LJ5c=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=JFJiKm5hOnM7amp9ocV7Wp2WD8TY6eWsHbMvfQlfarNLztP7GRIXzZjr1O1auz1I9
         ZaEBt81uPPs3LOE1g4CsPRC+cw550RnSoCS6SpY5JhqGVANjecU7jV5sVhWVwy01hI
         DShwLN5GmUbhGMsoYr4CgObnROAQbQCiCvbZUMLI=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191212025138epcas1p1858adcc8b9206ae31b3012d76f86ffd7~ff-g131vi0821908219epcas1p1h;
        Thu, 12 Dec 2019 02:51:38 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.156]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 47YJGc3trDzMqYkc; Thu, 12 Dec
        2019 02:51:36 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        80.37.48498.83BA1FD5; Thu, 12 Dec 2019 11:51:36 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191212025135epcas1p274ba7bab1a68bb734e41db188027270a~ff-eOv5JT0287002870epcas1p2I;
        Thu, 12 Dec 2019 02:51:35 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191212025135epsmtrp1af88fc2491b136ce6d1856e8ce60fed6~ff-eOFwhy1625416254epsmtrp1D;
        Thu, 12 Dec 2019 02:51:35 +0000 (GMT)
X-AuditID: b6c32a36-a55ff7000001bd72-00-5df1ab380e70
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        19.AB.10238.73BA1FD5; Thu, 12 Dec 2019 11:51:35 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191212025135epsmtip239f283f5bdacfa75b85dab823f22caa1~ff-eCmZop1206312063epsmtip2n;
        Thu, 12 Dec 2019 02:51:35 +0000 (GMT)
Subject: Re: [PATCH] PM / devfreq: tegra: add COMMON_CLK dependency
To:     Arnd Bergmann <arnd@arndb.de>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Dmitry Osipenko <digetx@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <e046bf10-f683-c230-471f-cd7768db3b11@samsung.com>
Date:   Thu, 12 Dec 2019 11:58:05 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20191211125411.1857250-1-arnd@arndb.de>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKJsWRmVeSWpSXmKPExsWy7bCmrq7F6o+xBoeuSVn8nXSMHch5zGhx
        tukNu8XlXXPYLD73HmG0uN24gs1i86apzA7sHr9/TWL02DnrLrvHu3Pn2D36tqxi9Pi8SS6A
        NSrbJiM1MSW1SCE1Lzk/JTMv3VbJOzjeOd7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwfoDCWF
        ssScUqBQQGJxsZK+nU1RfmlJqkJGfnGJrVJqQUpOgWWBXnFibnFpXrpecn6ulaGBgZEpUGFC
        dsaNvlvMBV/YK7pO/mVqYNzF1sXIySEhYCKxsr+LvYuRi0NIYAejxNZPO9kgnE+MEuvW3IDK
        fGOU2HntC1zLqjXLGSESexklXv7dD9XynlFi3u5nzF2MHBzCAs4S/74ngsRFBOYySix/8Bus
        m1kgSeJW22oWEJtNQEti/4sbYHF+AUWJqz8eM4L08grYSdx74AgSZhFQlfh1pYcJxBYVCJM4
        ua2FEcTmFRCUODnzCdgYTgFTibfT/zNBjBeXuPVkPpQtL7H97RxmkBskBN6zSay/NIMZ4gMX
        iZuTvkLZwhKvjm9hh7ClJF72t0HZ1RIrTx5hg2juYJTYsv8CK0TCWGL/0slMIIcyC2hKrN+l
        DxFWlNj5ey4jxGI+iXdfe1hBSiQEeCU62oQgSpQlLj+4ywRhS0osbu9km8CoNAvJO7OQvDAL
        yQuzEJYtYGRZxSiWWlCcm55abFhghBzbmxjBSVTLbAfjonM+hxgFOBiVeHgfSH+MFWJNLCuu
        zD3EKMHBrCTCe7ztXawQb0piZVVqUX58UWlOavEhRlNgaE9klhJNzgcm+LySeENTI2NjYwsT
        QzNTQ0MlcV6OHxdjhQTSE0tSs1NTC1KLYPqYODilGhhnH5l56trUSo8ChfQNHfK1Rxe/rfMp
        /GDVquQ3x2et86EHjY5nMq7k5SStq7Ra1NKpLjZjQau1RobydE+Z7g16/66ovDiXIRG74tvj
        0H6WT29kdbvO1y55Pi3t6Z9f3fZ+rQuMN0WIfGL951ey/riJgZ9N7KNsjR0OBfNN1m24uH3h
        NbMLnYFKLMUZiYZazEXFiQDpjLeCuAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjkeLIzCtJLcpLzFFi42LZdlhJXtd89cdYg1XduhZ/Jx1jt1j98TGj
        xdmmN+wWl3fNYbP43HuE0eJ24wo2i82bpjI7sHv8/jWJ0WPnrLvsHu/OnWP36NuyitHj8ya5
        ANYoLpuU1JzMstQifbsErowbfbeYC76wV3Sd/MvUwLiLrYuRk0NCwERi1ZrljF2MXBxCArsZ
        JT5OPcEKkZCUmHbxKHMXIweQLSxx+HAxRM1bRon1f6eBxYUFnCX+fU8EiYsIzGaUOHX2KNhQ
        ZoEkiUnzrrOD2EICHYwSXS/B4mwCWhL7X9wAs/kFFCWu/njMCDKHV8BO4t4DR5Awi4CqxK8r
        PUwgtqhAmMTOJY/BbF4BQYmTM5+wgNicAqYSb6f/Z4JYpS7xZ94lZghbXOLWk/lQcXmJ7W/n
        ME9gFJ6FpH0WkpZZSFpmIWlZwMiyilEytaA4Nz232LDAMC+1XK84Mbe4NC9dLzk/dxMjOJa0
        NHcwXl4Sf4hRgINRiYd3hvrHWCHWxLLiytxDjBIczEoivMfb3sUK8aYkVlalFuXHF5XmpBYf
        YpTmYFES532adyxSSCA9sSQ1OzW1ILUIJsvEwSnVwJgpuI/78pPozwp8doIrLwuZqAffzbFh
        +ikSy5fpfdU3+OyLmN6fuWHXuFqOCcb086xaG1g965fUhFAfqVLTh7wzK/S8n2+057u2WPmC
        6DkmZ1bdVLZ/oQcYWn1msb64F3kgwah/aptP+fqXjlXz5C4oznl8ZE5OLLfetvNLkt++4Qqq
        ejrvvBJLcUaioRZzUXEiAH5oOJShAgAA
X-CMS-MailID: 20191212025135epcas1p274ba7bab1a68bb734e41db188027270a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191211125428epcas1p3200de29d1a7566ebd443cd0477ca594e
References: <CGME20191211125428epcas1p3200de29d1a7566ebd443cd0477ca594e@epcas1p3.samsung.com>
        <20191211125411.1857250-1-arnd@arndb.de>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12/11/19 9:54 PM, Arnd Bergmann wrote:
> Compile-testing this driver fails if CONFIG_COMMON_CLK is not set:
> 
> drivers/devfreq/tegra30-devfreq.o: In function `tegra_devfreq_target':
> tegra30-devfreq.c:(.text+0x164): undefined reference to `clk_set_min_rate'
> 
> Fixes: 35f8dbc72721 ("PM / devfreq: tegra: Enable COMPILE_TEST for the driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/devfreq/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
> index defe1d438710..f712c3de0876 100644
> --- a/drivers/devfreq/Kconfig
> +++ b/drivers/devfreq/Kconfig
> @@ -98,6 +98,7 @@ config ARM_TEGRA_DEVFREQ
>  		ARCH_TEGRA_132_SOC || ARCH_TEGRA_124_SOC || \
>  		ARCH_TEGRA_210_SOC || \
>  		COMPILE_TEST
> +	depends on COMMON_CLK
>  	select PM_OPP
>  	help
>  	  This adds the DEVFREQ driver for the Tegra family of SoCs.
> 

Applied it. Thanks.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
