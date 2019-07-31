Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6E37B73A
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2019 02:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbfGaAe0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Jul 2019 20:34:26 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:35468 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbfGaAeZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Jul 2019 20:34:25 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190731003421epoutp02f98d81ec28c65c208bebeaf3772353a9~2VrZLdy_t1459414594epoutp02c
        for <linux-pm@vger.kernel.org>; Wed, 31 Jul 2019 00:34:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190731003421epoutp02f98d81ec28c65c208bebeaf3772353a9~2VrZLdy_t1459414594epoutp02c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1564533261;
        bh=F0On2VFtNL7VtPY1YN1nH3TXqp5VSvLootW9EB7fx6U=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=AH5IGp3KejScICxPB9xtBdNfR+XwoZ2fIzhrs3cAZ+Evoq3NnG5O0k01D0rPWFeVF
         RVzTPXTfDSamsS33m8+yt6rOkZyMqtq695uHDV6rakcM53ykcTzt3eR3sJNhtaTmtK
         L2zhsFCazXUastToUch91jTAFNHTqSOwBs4lehRU=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190731003420epcas1p3159b8e9560fe6ca0074c7e41ed938a39~2VrYfwBlf3134031340epcas1p35;
        Wed, 31 Jul 2019 00:34:20 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.152]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 45yvZ247QjzMqYkj; Wed, 31 Jul
        2019 00:34:18 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        16.07.04088.EF1E04D5; Wed, 31 Jul 2019 09:34:06 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20190731003406epcas1p47a71a46359f0aad93bdc6826ef5a2d2c~2VrKw-2Pk1059210592epcas1p4e;
        Wed, 31 Jul 2019 00:34:06 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190731003405epsmtrp2e15eef8316f423bff9db01687dcc4b14~2VrKufL6H0436704367epsmtrp2L;
        Wed, 31 Jul 2019 00:34:05 +0000 (GMT)
X-AuditID: b6c32a35-845ff70000000ff8-c7-5d40e1fe0d5c
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D6.90.03638.DF1E04D5; Wed, 31 Jul 2019 09:34:05 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190731003405epsmtip114c112b8c030d7aff9a2002065625621~2VrKlgFbd0149301493epsmtip1I;
        Wed, 31 Jul 2019 00:34:05 +0000 (GMT)
Subject: Re: [PATCH v5 18/20] PM / devfreq: tegra30: Define
 ACTMON_DEV_CTRL_STOP
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
Message-ID: <033a342c-ffd6-fa51-a9a2-daac36b195f9@samsung.com>
Date:   Wed, 31 Jul 2019 09:37:15 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190730162236.6063-19-digetx@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SWUwTURT10enQotXpCHJtUOuoiWAKHbA4KiBRYhoxkagfomlwApOCdEun
        GMBoQHCpESNxpa6guMaoCEpRxJQmikZEUaKSxg13xLCmYIK2HY38nXvPue+8896ViMjruEKS
        Y7JxVhNroPAQ7GZzpEo1+i5Zp777Yy5zufcDYkodVRjzeHt3MNPecBxn+svciLEPOHCms/gC
        zgw3nMSYfVee4clSbb3nLNI6HZ5gbVlJD67dV3sJaftrpqeJ1+cmZHNsFmdVcqZMc1aOSZ9I
        pa7JWJahiVfTKnohs4BSmlgjl0ilrExTLc8x+C5EKTezhjxfK43leSomKcFqzrNxymwzb0uk
        OEuWwbLQEs2zRj7PpI/ONBsX0Wp1rMYn3Jib3VF9S2TpHJ///dkjrAi9lu5BUgkQ88F75LZ4
        DwqRkEQ9gsYDpSKh6EOwc3gACcUQgicdx0X/RtoePv1LNCIoLXcFC8VPBHb7Mdyvmkyshl2d
        Q7ifCCVGfcRwSYAQEenQ7Lwc5Mc4EQVNX14G+pOImfDC+wH5sYxIAvfg8wDGiDnQXuMOWIcR
        66DvbbNY0MihpaIL82MpEQ+fBiox4fxweN11KkjAM6Ck7lggEBC/cWg+V4cJGVLgmvdekIAn
        w7f7tcECVkB/TyMu4C1wscWNC8O7EdQ2tYkFIg6aqg/4hiU+h0i42hAjtGeC89cJJBhPhJ7B
        vWK/BAgZ7N5JCpJZ0P7W89d2KpzZZcf3I8oxJo5jTATHmAiO/2anEXYJTeEsvFHP8bSFHvvf
        NSiwrlGaenSwdaULERJETZA90CXrSDG7mS8wuhBIRFSo7Ez4Eh0py2ILCjmrOcOaZ+B4F9L4
        XrtcpAjLNPuW32TLoDWxcXFxzHw6XkPTVLis0svoSELP2rhcjrNw1n9zQRKpogiRbSbPcLih
        5vD7ylLPq4sRr9avTV29aZX8UFlOxZvzhe31ZJczUj5iD4uVj86j04t3PEodt3/RbDOZHH94
        ynP116P5i1uHNpBJSy3K0I8RW/umVcll7ofVIfdDy6NXdSeuuHEn4XPMyMuw3m2db7xrWtrI
        9Aj9iJOYW6Goq8p3qVopjM9m6SiRlWf/AJ715ZrEAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsWy7bCSnO7fhw6xBnsnWFms/viY0aJl1iIW
        i7NNb9gtLu+aw2bxufcIo0Xnl1lsFrcbV7BZ/Nw1j8Wib+0lNgdOjx13lzB67Jx1l92jt/kd
        m0ffllWMHp83yQWwRnHZpKTmZJalFunbJXBlXFu6nbngNnfF60unWRoYb3F2MXJySAiYSFw4
        dZGxi5GLQ0hgN6NEz4Ql7BAJSYlpF48ydzFyANnCEocPF0PUvGWU2Ni1E6xGWCBIov32NzaQ
        hIhAE5PEpt4LYAlmgUiJnrlb2CA6tjBKXOucC5ZgE9CS2P/iBhuIzS+gKHH1x2NGEJtXwE7i
        yNcrYDaLgKrE5U1HmEFsUYEIicM7ZkHVCEqcnPmEBcTmFDCTePZlIQvEMnWJP/MuMUPY4hK3
        nsxngrDlJZq3zmaewCg8C0n7LCQts5C0zELSsoCRZRWjZGpBcW56brFhgVFearlecWJucWle
        ul5yfu4mRnCUaWntYDxxIv4QowAHoxIP74lYh1gh1sSy4srcQ4wSHMxKIryLxe1jhXhTEiur
        Uovy44tKc1KLDzFKc7AoifPK5x+LFBJITyxJzU5NLUgtgskycXBKNTDODs51Pb7YduPkpc4X
        G1W/sqiE7wryvH13+4tV/o+D5u24LZP7TZT3Ym3ODxWlBceuvWOZ3z0v0anliZXBhsYFLyZ9
        /S0x71FSlFbDn9/iHDukHn1rnVTu2JxjvrmT54c5z+Z1AaUn1XIunT/JxOr1p9Q3+YCo3kv7
        ljW3RViPsX8zvLZJ7txnJZbijERDLeai4kQA72AXK64CAAA=
X-CMS-MailID: 20190731003406epcas1p47a71a46359f0aad93bdc6826ef5a2d2c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190730163331epcas4p2fabd7ccf1b24c0cb95bf3994a289e13b
References: <20190730162236.6063-1-digetx@gmail.com>
        <CGME20190730163331epcas4p2fabd7ccf1b24c0cb95bf3994a289e13b@epcas4p2.samsung.com>
        <20190730162236.6063-19-digetx@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19. 7. 31. 오전 1:22, Dmitry Osipenko wrote:
> Add verbose definition for the client's device control register value that
> makes ACTMON to stop monitoring of the device.
> 
> Suggested-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/devfreq/tegra30-devfreq.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
> index 3543fba74b52..8adc0ff48b45 100644
> --- a/drivers/devfreq/tegra30-devfreq.c
> +++ b/drivers/devfreq/tegra30-devfreq.c
> @@ -35,6 +35,8 @@
>  #define ACTMON_DEV_CTRL_CONSECUTIVE_ABOVE_WMARK_EN		BIT(30)
>  #define ACTMON_DEV_CTRL_ENB					BIT(31)
>  
> +#define ACTMON_DEV_CTRL_STOP					0x00000000
> +
>  #define ACTMON_DEV_UPPER_WMARK					0x4
>  #define ACTMON_DEV_LOWER_WMARK					0x8
>  #define ACTMON_DEV_INIT_AVG					0xc
> @@ -714,7 +716,7 @@ static void tegra_actmon_configure_device(struct tegra_devfreq *tegra,
>  
>  static void tegra_actmon_stop_device(struct tegra_devfreq_device *dev)
>  {
> -	device_writel(dev, 0x00000000, ACTMON_DEV_CTRL);
> +	device_writel(dev, ACTMON_DEV_CTRL_STOP, ACTMON_DEV_CTRL);
>  	device_writel(dev, ACTMON_INTR_STATUS_CLEAR, ACTMON_DEV_INTR_STATUS);
>  }
>  
> 

I think that you can combine it to patch11.
When combining it to patch11, don't need to add the suggested-by tag.
Thanks.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
