Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2990C332277
	for <lists+linux-pm@lfdr.de>; Tue,  9 Mar 2021 11:00:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbhCIKAS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Mar 2021 05:00:18 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:17340 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbhCIKAC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Mar 2021 05:00:02 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210309100001epoutp032eccaf14cbd81530d9805b417d2c5878~qpD2vXZrK2654126541epoutp03Z
        for <linux-pm@vger.kernel.org>; Tue,  9 Mar 2021 10:00:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210309100001epoutp032eccaf14cbd81530d9805b417d2c5878~qpD2vXZrK2654126541epoutp03Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1615284001;
        bh=5aw8QMiBzKMZmtYqG/uhz5F/EAh/dpIq1Fu/9wiXRuI=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=VYrANWpPHsZFuxw4wqzX8dOzWnhpmWjBGk5ae43u4xVlePggbC3nynlWDzVIaVh1Q
         YOJj4GTf2J50KKr0MnC7zNQEH+uR9GrKS2yjlubmSw1sD0VErw1iZeoJ6LOIsupeHg
         D9KAdi8iL17RUfChXzNqDNGo1W5ZgLxmTLCoiR6w=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20210309100000epcas1p34b5766eda84923f8b86ca90372b3951b~qpD2QrPXW2132321323epcas1p3B;
        Tue,  9 Mar 2021 10:00:00 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.157]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4DvrKm28Vlz4x9Q2; Tue,  9 Mar
        2021 09:59:56 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        8F.BE.02418.91747406; Tue,  9 Mar 2021 18:59:53 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20210309095952epcas1p496609cfb1f84c423a1cdd2ad5e13b3bd~qpDuWsNsz1735217352epcas1p4T;
        Tue,  9 Mar 2021 09:59:52 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210309095952epsmtrp2b1530ea1946a9d47cb796ab1899b9dd4~qpDuV0dDK3037430374epsmtrp2Y;
        Tue,  9 Mar 2021 09:59:52 +0000 (GMT)
X-AuditID: b6c32a35-c0dff70000010972-b1-604747198749
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        1F.FB.08745.81747406; Tue,  9 Mar 2021 18:59:52 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210309095951epsmtip287568ae55a2343b7334dfda02283475a~qpDt-0qqw2608326083epsmtip2h;
        Tue,  9 Mar 2021 09:59:51 +0000 (GMT)
Subject: Re: [RESEND PATCH v5 4/4] dt-bindings: devfreq: rk3399_dmc: Remove
 references of unexistant defines
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, heiko@sntech.de
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        =?UTF-8?Q?Ga=c3=abl_PORTAY?= <gael.portay@collabora.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:DEVICE FREQUENCY (DEVFREQ)" <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <4c2c9145-d404-0c3b-e0c8-b4404dc1ea20@samsung.com>
Date:   Tue, 9 Mar 2021 19:16:34 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20210308233858.24741-4-daniel.lezcano@linaro.org>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGJsWRmVeSWpSXmKPExsWy7bCmrq6ku3uCwd2XbBbzPstazD9yjtVi
        ya43bBb/H71mtTjb9IbdYtPja6wWl3fNYbP43HuE0eLTg//MFrcbV7BZtO49wu7A7bHj7hJG
        j02rOtk87lzbw+axeUm9R9+WVYwe26/NY/b4vEkugD0q2yYjNTEltUghNS85PyUzL91WyTs4
        3jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMH6EQlhbLEnFKgUEBicbGSvp1NUX5pSapCRn5x
        ia1SakFKToFlgV5xYm5xaV66XnJ+rpWhgYGRKVBhQnbGuqfb2Aoa7Squz9vN0sC4X7+LkZND
        QsBE4tOGl0xdjFwcQgI7GCV6rr5nhHA+MUrcfbWFDcL5zCixcvUmNpiWhyePMkMkdjFK/Hvy
        Gcp5zyjxePoxRpAqYYE8ieX7HrCA2CIC9hJnGyeygBQxC1xgltj7oAGsiE1AS2L/ixtgY/kF
        FCWu/ngMFucVsJPYv+QemM0ioCJxqXMhE4gtKhAmcXJbC1SNoMTJmU/AFnACLXjR+YEZxGYW
        EJe49WQ+E4QtL9G8dTbYdRICBzgkOg/uZoT4wUXiW9sPJghbWOLV8S3sELaUxOd3e6H+rJZY
        efIIG0RzB6PElv0XWCESxhL7l04GauYA2qApsX4XNCgVJXb+nssIsZhP4t3XHlaQEgkBXomO
        NiGIEmWJyw/uQq2VlFjc3sk2gVFpFpJ3ZiF5YRaSF2YhLFvAyLKKUSy1oDg3PbXYsMAQOb43
        MYITsJbpDsaJbz/oHWJk4mA8xCjBwawkwut33C1BiDclsbIqtSg/vqg0J7X4EKMpMIAnMkuJ
        JucDc0BeSbyhqZGxsbGFiaGZqaGhkjhvksGDeCGB9MSS1OzU1ILUIpg+Jg5OqQYmOe2vjaoa
        Ivut466fTuXdvCpEoCBr5zpZVSHFqbMydrV1Xwnri/pgI1TNt419LqPhm9bPCovZXduiTjJt
        M3u6sWbKGmn+0J+FAvtkVct6DATrd1y9dF3j88epBu/56mYLLl+neOnTsrirssxaehv/O7aE
        KJTkFAaWbOcrmzjnv6uq74TFjGsXp3BPPryKm9Fmyp6dVttuXmFTkHremC6dv31RpSQXO7eN
        hsOm/EXH5dw6Mw++CLypKclr02Qw63vKduVQD7ktSVOOSU45z3tgs/Fm2+gdfy7H7E9oOeFV
        yTAxSWfLq1jD2EzhR7Pk2PUL3N5eZIhS/ndA8kiExJFaDqdzS2Ybpi3VtvfS2aXEUpyRaKjF
        XFScCABJRAlqSQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAIsWRmVeSWpSXmKPExsWy7bCSvK6Eu3uCwZMGNot5n2Ut5h85x2qx
        ZNcbNov/j16zWpxtesNusenxNVaLy7vmsFl87j3CaPHpwX9mi9uNK9gsWvceYXfg9thxdwmj
        x6ZVnWwed67tYfPYvKTeo2/LKkaP7dfmMXt83iQXwB7FZZOSmpNZllqkb5fAlbHu6Ta2gka7
        iuvzdrM0MO7X72Lk5JAQMJF4ePIocxcjF4eQwA5GibmTZjNBJCQlpl0ESXAA2cIShw8XQ9S8
        ZZTYM2kKM0iNsECexPJ9D1hAbBEBe4mzjRNZQIqYBS4wSxxaOhdq6nFGiYe7f4BNZRPQktj/
        4gYbiM0voChx9cdjRhCbV8BOYv+Se2A2i4CKxKXOhWD1ogJhEjuXPGaCqBGUODnzCdg2TqBt
        Lzo/gF3BLKAu8WfeJShbXOLWk/lMELa8RPPW2cwTGIVnIWmfhaRlFpKWWUhaFjCyrGKUTC0o
        zk3PLTYsMMpLLdcrTswtLs1L10vOz93ECI5ELa0djHtWfdA7xMjEwXiIUYKDWUmE1++4W4IQ
        b0piZVVqUX58UWlOavEhRmkOFiVx3gtdJ+OFBNITS1KzU1MLUotgskwcnFINTLLP1nZO+769
        WyHAzaH7xWrOT4vu2sg7FD0SFX7Sp+PPJp93aeLvyvMX4yZxTOnhePVlalr9tLh+j+XzuxZJ
        muupXTh/zOS65fbr5jqRLjGrXx2ckWoZYT7394QV+yaX3GkunuG9IuoG4+oJN70aZtp1elpf
        e2LlKPZ/3SxmF1W7x697un01kyY86fm9T+TmRp0K5d11KuLPzAUMYi/vPr5hlekkq8vf+6+I
        ngoUOWY5e2qKRN7t0IyDDoHn7xYEJDV9VTe24XrKfiH7oFRSfOeDeqbEv7l2H+qlbLoZmv+I
        t08vTtSyv7F0/sflAn8XhZb0Ranz/l/2d6PdOott1yWme8+aXWa4xo1LZt2u3UosxRmJhlrM
        RcWJALiBE9QzAwAA
X-CMS-MailID: 20210309095952epcas1p496609cfb1f84c423a1cdd2ad5e13b3bd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210308234059epcas1p1f68056155634a407d62d2ed52e2729da
References: <20210308233858.24741-1-daniel.lezcano@linaro.org>
        <CGME20210308234059epcas1p1f68056155634a407d62d2ed52e2729da@epcas1p1.samsung.com>
        <20210308233858.24741-4-daniel.lezcano@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 3/9/21 8:38 AM, Daniel Lezcano wrote:
> From: Gaël PORTAY <gael.portay@collabora.com>
> 
> Those DDR related defines do not exist. Replace their references with
> their numerical constant.
> 
> Signed-off-by: Gaël PORTAY <gael.portay@collabora.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  .../bindings/devfreq/rk3399_dmc.txt           | 73 +++++++++----------
>  1 file changed, 34 insertions(+), 39 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt b/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt
> index a41bcfef95c8..ddde2c4f97df 100644
> --- a/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt
> +++ b/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt
> @@ -79,24 +79,23 @@ Following properties relate to DDR timing:
>  
>  - rockchip,ddr3_drv :		  When the DRAM type is DDR3, this parameter defines
>  				  the DRAM side driver strength in ohms. Default
> -				  value is DDR3_DS_40ohm.
> +				  value is 40.
>  
>  - rockchip,ddr3_odt :		  When the DRAM type is DDR3, this parameter defines
>  				  the DRAM side ODT strength in ohms. Default value
> -				  is DDR3_ODT_120ohm.
> +				  is 120.
>  
>  - rockchip,phy_ddr3_ca_drv :	  When the DRAM type is DDR3, this parameter defines
>  				  the phy side CA line (incluing command line,
>  				  address line and clock line) driver strength.
> -				  Default value is PHY_DRV_ODT_40.
> +				  Default value is 40.
>  
>  - rockchip,phy_ddr3_dq_drv :	  When the DRAM type is DDR3, this parameter defines
>  				  the PHY side DQ line (including DQS/DQ/DM line)
> -				  driver strength. Default value is PHY_DRV_ODT_40.
> +				  driver strength. Default value is 40.
>  
>  - rockchip,phy_ddr3_odt : 	  When the DRAM type is DDR3, this parameter defines
> -				  the PHY side ODT strength. Default value is
> -				  PHY_DRV_ODT_240.
> +				  the PHY side ODT strength. Default value is 240.
>  
>  - rockchip,lpddr3_odt_dis_freq : When the DRAM type is LPDDR3, this parameter defines
>  				  then ODT disable frequency in MHz (Mega Hz).
> @@ -106,25 +105,23 @@ Following properties relate to DDR timing:
>  
>  - rockchip,lpddr3_drv :		  When the DRAM type is LPDDR3, this parameter defines
>  				  the DRAM side driver strength in ohms. Default
> -				  value is LP3_DS_34ohm.
> +				  value is 34.
>  
>  - rockchip,lpddr3_odt :		  When the DRAM type is LPDDR3, this parameter defines
>  				  the DRAM side ODT strength in ohms. Default value
> -				  is LP3_ODT_240ohm.
> +				  is 240.
>  
>  - rockchip,phy_lpddr3_ca_drv :	  When the DRAM type is LPDDR3, this parameter defines
>  				  the PHY side CA line (including command line,
>  				  address line and clock line) driver strength.
> -				  Default value is PHY_DRV_ODT_40.
> +				  Default value is 40.
>  
>  - rockchip,phy_lpddr3_dq_drv :	  When the DRAM type is LPDDR3, this parameter defines
>  				  the PHY side DQ line (including DQS/DQ/DM line)
> -				  driver strength. Default value is
> -				  PHY_DRV_ODT_40.
> +				  driver strength. Default value is 40.
>  
>  - rockchip,phy_lpddr3_odt : 	  When dram type is LPDDR3, this parameter define
> -				  the phy side odt strength, default value is
> -				  PHY_DRV_ODT_240.
> +				  the phy side odt strength, default value is 240.
>  
>  - rockchip,lpddr4_odt_dis_freq : When the DRAM type is LPDDR4, this parameter
>  				  defines the ODT disable frequency in
> @@ -134,32 +131,30 @@ Following properties relate to DDR timing:
>  
>  - rockchip,lpddr4_drv :		  When the DRAM type is LPDDR4, this parameter defines
>  				  the DRAM side driver strength in ohms. Default
> -				  value is LP4_PDDS_60ohm.
> +				  value is 60.
>  
>  - rockchip,lpddr4_dq_odt : 	  When the DRAM type is LPDDR4, this parameter defines
>  				  the DRAM side ODT on DQS/DQ line strength in ohms.
> -				  Default value is LP4_DQ_ODT_40ohm.
> +				  Default value is 40.
>  
>  - rockchip,lpddr4_ca_odt :	  When the DRAM type is LPDDR4, this parameter defines
>  				  the DRAM side ODT on CA line strength in ohms.
> -				  Default value is LP4_CA_ODT_40ohm.
> +				  Default value is 40.
>  
>  - rockchip,phy_lpddr4_ca_drv :	  When the DRAM type is LPDDR4, this parameter defines
>  				  the PHY side CA line (including command address
> -				  line) driver strength. Default value is
> -				  PHY_DRV_ODT_40.
> +				  line) driver strength. Default value is 40.
>  
>  - rockchip,phy_lpddr4_ck_cs_drv : When the DRAM type is LPDDR4, this parameter defines
>  				  the PHY side clock line and CS line driver
> -				  strength. Default value is PHY_DRV_ODT_80.
> +				  strength. Default value is 80.
>  
>  - rockchip,phy_lpddr4_dq_drv :	  When the DRAM type is LPDDR4, this parameter defines
>  				  the PHY side DQ line (including DQS/DQ/DM line)
> -				  driver strength. Default value is PHY_DRV_ODT_80.
> +				  driver strength. Default value is 80.
>  
>  - rockchip,phy_lpddr4_odt :	  When the DRAM type is LPDDR4, this parameter defines
> -				  the PHY side ODT strength. Default value is
> -				  PHY_DRV_ODT_60.
> +				  the PHY side ODT strength. Default value is 60.  
>  
>  Example:
>  	dmc_opp_table: dmc_opp_table {
> @@ -195,23 +190,23 @@ Example:
>  		rockchip,phy_dll_dis_freq = <125>;
>  		rockchip,auto_pd_dis_freq = <666>;
>  		rockchip,ddr3_odt_dis_freq = <333>;
> -		rockchip,ddr3_drv = <DDR3_DS_40ohm>;
> -		rockchip,ddr3_odt = <DDR3_ODT_120ohm>;
> -		rockchip,phy_ddr3_ca_drv = <PHY_DRV_ODT_40>;
> -		rockchip,phy_ddr3_dq_drv = <PHY_DRV_ODT_40>;
> -		rockchip,phy_ddr3_odt = <PHY_DRV_ODT_240>;
> +		rockchip,ddr3_drv = <40>;
> +		rockchip,ddr3_odt = <120>;
> +		rockchip,phy_ddr3_ca_drv = <40>;
> +		rockchip,phy_ddr3_dq_drv = <40>;
> +		rockchip,phy_ddr3_odt = <240>;
>  		rockchip,lpddr3_odt_dis_freq = <333>;
> -		rockchip,lpddr3_drv = <LP3_DS_34ohm>;
> -		rockchip,lpddr3_odt = <LP3_ODT_240ohm>;
> -		rockchip,phy_lpddr3_ca_drv = <PHY_DRV_ODT_40>;
> -		rockchip,phy_lpddr3_dq_drv = <PHY_DRV_ODT_40>;
> -		rockchip,phy_lpddr3_odt = <PHY_DRV_ODT_240>;
> +		rockchip,lpddr3_drv = <34>;
> +		rockchip,lpddr3_odt = <240>;
> +		rockchip,phy_lpddr3_ca_drv = <40>;
> +		rockchip,phy_lpddr3_dq_drv = <40>;
> +		rockchip,phy_lpddr3_odt = <240>;
>  		rockchip,lpddr4_odt_dis_freq = <333>;
> -		rockchip,lpddr4_drv = <LP4_PDDS_60ohm>;
> -		rockchip,lpddr4_dq_odt = <LP4_DQ_ODT_40ohm>;
> -		rockchip,lpddr4_ca_odt = <LP4_CA_ODT_40ohm>;
> -		rockchip,phy_lpddr4_ca_drv = <PHY_DRV_ODT_40>;
> -		rockchip,phy_lpddr4_ck_cs_drv = <PHY_DRV_ODT_80>;
> -		rockchip,phy_lpddr4_dq_drv = <PHY_DRV_ODT_80>;
> -		rockchip,phy_lpddr4_odt = <PHY_DRV_ODT_60>;
> +		rockchip,lpddr4_drv = <60>;
> +		rockchip,lpddr4_dq_odt = <40>;
> +		rockchip,lpddr4_ca_odt = <40>;
> +		rockchip,phy_lpddr4_ca_drv = <40>;
> +		rockchip,phy_lpddr4_ck_cs_drv = <80>;
> +		rockchip,phy_lpddr4_dq_drv = <80>;
> +		rockchip,phy_lpddr4_odt = <60>;
>  	};
> 

Applied it with following minor fixup (unneeded spaces). Thanks


diff --git a/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt b/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt
index ddde2c4f97df..ac189dd82b08 100644
--- a/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt
+++ b/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt
@@ -154,7 +154,7 @@ Following properties relate to DDR timing:
                                  driver strength. Default value is 80.
 
 - rockchip,phy_lpddr4_odt :      When the DRAM type is LPDDR4, this parameter defines
-                                 the PHY side ODT strength. Default value is 60.  
+                                 the PHY side ODT strength. Default value is 60.
 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
