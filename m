Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98CF012441E
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2019 11:17:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbfLRKRl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Dec 2019 05:17:41 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:36379 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbfLRKRk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Dec 2019 05:17:40 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20191218101738euoutp022b1a952e6b4ed756749e9ca7cff8fde2~hb8o2mhnk0591005910euoutp022
        for <linux-pm@vger.kernel.org>; Wed, 18 Dec 2019 10:17:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20191218101738euoutp022b1a952e6b4ed756749e9ca7cff8fde2~hb8o2mhnk0591005910euoutp022
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1576664258;
        bh=bwThtk0xrgCsolgLeuyMVr0819OsND3qMnr6RqwdLMI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=p5MfTccR7x2zDiVthDlRg0OA59ALTtVDv/9uyDrQ9mgRbJAuR6jkp2Kk5VOqn5D5F
         FBXKEcXBbOrlb4mcfs9w7M0g7WC3GeTk6U8WXP3KsX/UOuby1YnorMw63Qn3T5jGuS
         dFZglzpM+DMU13wmLJCksvvfTBk7cKOf7h22fj6s=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191218101738eucas1p2100dfedc2594bf3efb8d9e38a2824564~hb8oejBVD2968829688eucas1p28;
        Wed, 18 Dec 2019 10:17:38 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 01.33.61286.2CCF9FD5; Wed, 18
        Dec 2019 10:17:38 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191218101738eucas1p1b3abcd2bb6c825e6fb27b77df48d0100~hb8oIAUqA2842828428eucas1p1-;
        Wed, 18 Dec 2019 10:17:38 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191218101738eusmtrp139b535987309e190528b9eb39679ce25~hb8oHBlKA2290422904eusmtrp1p;
        Wed, 18 Dec 2019 10:17:38 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-2a-5df9fcc2122a
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 3C.DC.07950.1CCF9FD5; Wed, 18
        Dec 2019 10:17:37 +0000 (GMT)
Received: from AMDC3555 (unknown [106.120.51.67]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20191218101737eusmtip17fd69f11846ed085ae840ddc8c972528~hb8nc9z0T0982809828eusmtip1q;
        Wed, 18 Dec 2019 10:17:37 +0000 (GMT)
Message-ID: <2008dca684ccb1dd740e6e6b88e56727d0d1c435.camel@samsung.com>
Subject: Re: [RFC PATCH v2 08/11] arm: dts: exynos: Add parents and
 #interconnect-cells to Exynos4412
From:   Artur =?UTF-8?Q?=C5=9Awigo=C5=84?= <a.swigon@samsung.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     myungjoo.ham@samsung.com, inki.dae@samsung.com,
        sw0312.kim@samsung.com, georgi.djakov@linaro.org,
        leonard.crestez@nxp.com, m.szyprowski@samsung.com,
        b.zolnierkie@samsung.com, krzk@kernel.org
Date:   Wed, 18 Dec 2019 11:17:36 +0100
In-Reply-To: <eecc5d38-f6ab-b1ea-1a08-0afb2dcddbef@samsung.com>
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SaUhUYRSG++Yucx0a/RzDOWgYTavSotSPT6zMCLmBRRBBBKZjXibJUZnr
        UhK4JKKWYmppJhQtJlaok5pjKzYmmSaZ2NRoVqaSoeZWjWXm7Rr17znvOe9Z4HCUpo3x4KJi
        4gVTjD5ax6ro+ieO5+ubfjpCfX/kupOakiqGvJoaYshF63OGdE2PsaT4vpklBX35NOnoqFaS
        it5xhpj7uxnysrGMJZO5VkRKOh4oyC1rr5LY0ypYUlL4id3uwpsrs1m+p/sey/edalHwt6+m
        8DWjDQo+r7YS8ZNmr73Kg6otkUJ0VKJg2rgtXHXk2t1bbNw732P2dAubil6vzEFOHODNcMU2
        QOcgFafBFQg6782wcjCFIG3q80JmEsGs4xT6a2l9+JaSWIOvI2ht95WLBhFUT0zTUkKNeWie
        nPljcMMGeJU9oZCYxYHQbv+qkAxL8CiCjw+/UFJA4ScI7vc4/rhpvAoq31jm3RznNO9oHPaX
        J6+DkdY8WpLV2BVmG9wkmcLL4GTdBUouGVeCpYjIvBP6bd2MzG4w3FKrlHkpPCs8TcsswoCl
        j5FWAJyKwFxuXWgUAI9bXjDSLAp7Q1XjRlkOgsybxUpJBuwMthFXeQVnKKgvpmRZDVmZGhl1
        0HjeWTYCpN/oXujNw3R2myIfLS/9d0rpf6eU/pt6CVGVSCskiEaDIPrFCEkbRL1RTIgxbDgc
        azSj+R979qtlogFNd0Y0Icwh3WK17yJHqIbRJ4rHjU0IOEq3RG3PmpfUkfrjyYIpNsyUEC2I
        TciTo3Va9abLn0I12KCPF44KQpxg+ptVcE4eqWh1lEW7ddzf4b42Ir/9TlpXPeudnNwTGGz3
        /uDZY7i55vJ+5eCJtqFvqt1J+/Jc8aGA2NQk0h6eUp5eu+J9c1hNRHhpK6LOuZwJnRujI4ML
        8dlHc8bv2qKqwAfFwSHjL4+eu8T5dBKvrh0CVaa1HXganBG0p8gYbdtVN+ESkmHV0eIRvZ8P
        ZRL1vwHzZKQfXwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGIsWRmVeSWpSXmKPExsVy+t/xu7oH//yMNbi/y8pi44z1rBbXvzxn
        tZh/5ByrxZWv79kspu/dxGYx6f4EFovz5zewW6y4+5HVYtPja6wWl3fNYbP43HuE0WLG+X1M
        FmuP3GW3uN24gs1ixuSXbA78HptWdbJ53Lm2h83jfvdxJo/NS+o9Nr7bweTRt2UVo8fnTXIB
        7FF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZllqUX6dgl6GUt3
        r2UreGBQcbtpJ1sD402VLkZODgkBE4lT++8xdzFycQgJLGWUWDbhGDtEQkLi4/obrBC2sMSf
        a11sEEVPGCU+nroIluAV8JA4+vkXI4gtLJAucb3zExOIzSZgL3H29jcmkAYRgfeMEh+2v2MH
        cZgFTjBK7Lz2nA2kikVAVWLVrZ1A3RwcnEAdu15ZQmxYySSx4kQfM0gNs4CmROv231An6Ui8
        PdXHAlLPKyAo8XeHMESJvETz1tnMExgFZyHpmIVQNQtJ1QJG5lWMIqmlxbnpucVGesWJucWl
        eel6yfm5mxiBcbrt2M8tOxi73gUfYhTgYFTi4b3x90esEGtiWXFl7iFGCQ5mJRHe2x0/Y4V4
        UxIrq1KL8uOLSnNSiw8xmgK9M5FZSjQ5H5hC8kriDU0NzS0sDc2NzY3NLJTEeTsEDsYICaQn
        lqRmp6YWpBbB9DFxcEo1MKbWbxbuPFLAMentsYdGCiocjuIzXpkWSbplsJxhnWSk3bX9oZVM
        yssVR7XeJ/zoKnyQnnDG1aZPQ9nyTe+OOJXDRYmX+qecObBJrMT6+TupL2dWVXKaGzdx7ll7
        dkUl4/fjHxgncWzfIbNwzx0XzzNT/m/QWdt3pDx5f+i7LGWb+83qcxJSwpRYijMSDbWYi4oT
        AUu4vzbpAgAA
X-CMS-MailID: 20191218101738eucas1p1b3abcd2bb6c825e6fb27b77df48d0100
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190919142329eucas1p299762f99dd55a5d625633ceec84219f9
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190919142329eucas1p299762f99dd55a5d625633ceec84219f9
References: <20190919142236.4071-1-a.swigon@samsung.com>
        <CGME20190919142329eucas1p299762f99dd55a5d625633ceec84219f9@eucas1p2.samsung.com>
        <20190919142236.4071-9-a.swigon@samsung.com>
        <693e250d-9656-df67-9685-188020b43542@samsung.com>
        <eecc5d38-f6ab-b1ea-1a08-0afb2dcddbef@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On Mon, 2019-12-16 at 11:59 +0900, Chanwoo Choi wrote:
> Hi,
> 
> On 12/16/19 9:51 AM, Chanwoo Choi wrote:
> > On 9/19/19 11:22 PM, Artur Świgoń wrote:
> > > From: Artur Świgoń <a.swigon@partner.samsung.com>
> > > 
> > > This patch adds two fields to the Exynos4412 DTS:
> > >   - parent: to declare connections between nodes that are not in a
> > >     parent-child relation in devfreq;
> > >   - #interconnect-cells: required by the interconnect framework.
> > > 
> > > Please note that #interconnect-cells is always zero and node IDs are not
> > > hardcoded anywhere. The above-mentioned parent-child relation in devfreq
> > > means that there is a shared power line ('devfreq' property). The 'parent'
> > > property only signifies an interconnect connection.
> > > 
> > > Signed-off-by: Artur Świgoń <a.swigon@partner.samsung.com>
> > > ---
> > >  arch/arm/boot/dts/exynos4412-odroid-common.dtsi | 1 +
> > >  arch/arm/boot/dts/exynos4412.dtsi               | 9 +++++++++
> > >  2 files changed, 10 insertions(+)
> > > 
> > > diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> > > index ea55f377d17c..bdd61ae86103 100644
> > > --- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> > > +++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> > > @@ -106,6 +106,7 @@
> > >  &bus_leftbus {
> > >  	devfreq-events = <&ppmu_leftbus_3>, <&ppmu_rightbus_3>;
> > >  	vdd-supply = <&buck3_reg>;
> > > +	parent = <&bus_dmc>;
> > 
> > As I mentioned on other reply,
> > I'm not sure to use the specific 'parent' property to make
> > the connection between buses. If possible, you better to
> > use the standard way like OF graph. Except for making
> > the connection between buses by 'parent' property,
> > looks good to me.
> 
> I tried to think it continuously. I withdraw the my opinion
> using OF graph. If you make the property name like the following
> example, it is possible for exynos.
> - exynos,interconnect-parent-node = <&bus_dmc>; or other proper name.
> 
> Regardless of existing 'devfreq' property, I think you better to
> make the connection between buses for only interconnect as following
> example: This make it possible user can draw the correct tree by tracking
> the 'exynos,interconnect-parent-node' value.

OK, for v3 I will add 'exynos,interconnect-parent-node' to bus_dmc,
bus_leftbus and bus_display as you suggested below and change the code
so that the 'devfreq' (or the upcoming 'exynos,parent-bus') property is
not taken into account.

> diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> index ea55f377d17c..53f87f46e161 100644
> --- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> +++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> @@ -90,6 +90,7 @@
>  &bus_dmc {
>         devfreq-events = <&ppmu_dmc0_3>, <&ppmu_dmc1_3>;
>         vdd-supply = <&buck1_reg>;
> +       #interconnect-cells = <0>;
>         status = "okay";
>  };
>  
> @@ -106,6 +107,8 @@
>  &bus_leftbus {
>         devfreq-events = <&ppmu_leftbus_3>, <&ppmu_rightbus_3>;
>         vdd-supply = <&buck3_reg>;
> +       exynos,interconnect-parent-node = <&bus_dmc>;
> +       #interconnect-cells = <0>;
>         status = "okay";
>  };
>  
> @@ -116,6 +119,8 @@
>  
>  &bus_display {
>         devfreq = <&bus_leftbus>;
> +       exynos,interconnect-parent-node = <&bus_leftbus>;
> +       #interconnect-cells = <0>;
>         status = "okay";
>  };
> 
> 
> > 
> > 
> > >  	status = "okay";
> > >  };
> > >  
> > > diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos4412.dtsi
> > > index d20db2dfe8e2..a70a671acacd 100644
> > > --- a/arch/arm/boot/dts/exynos4412.dtsi
> > > +++ b/arch/arm/boot/dts/exynos4412.dtsi
> > > @@ -390,6 +390,7 @@
> > >  			clocks = <&clock CLK_DIV_DMC>;
> > >  			clock-names = "bus";
> > >  			operating-points-v2 = <&bus_dmc_opp_table>;
> > > +			#interconnect-cells = <0>;
> > >  			status = "disabled";
> > >  		};
> > >  
> > > @@ -398,6 +399,7 @@
> > >  			clocks = <&clock CLK_DIV_ACP>;
> > >  			clock-names = "bus";
> > >  			operating-points-v2 = <&bus_acp_opp_table>;
> > > +			#interconnect-cells = <0>;
> > >  			status = "disabled";
> > >  		};
> > >  
> > > @@ -406,6 +408,7 @@
> > >  			clocks = <&clock CLK_DIV_C2C>;
> > >  			clock-names = "bus";
> > >  			operating-points-v2 = <&bus_dmc_opp_table>;
> > > +			#interconnect-cells = <0>;
> > >  			status = "disabled";
> > >  		};
> > >  
> > > @@ -459,6 +462,7 @@
> > >  			clocks = <&clock CLK_DIV_GDL>;
> > >  			clock-names = "bus";
> > >  			operating-points-v2 = <&bus_leftbus_opp_table>;
> > > +			#interconnect-cells = <0>;
> > >  			status = "disabled";
> > >  		};
> > >  
> > > @@ -467,6 +471,7 @@
> > >  			clocks = <&clock CLK_DIV_GDR>;
> > >  			clock-names = "bus";
> > >  			operating-points-v2 = <&bus_leftbus_opp_table>;
> > > +			#interconnect-cells = <0>;
> > >  			status = "disabled";
> > >  		};
> > >  
> > > @@ -475,6 +480,7 @@
> > >  			clocks = <&clock CLK_ACLK160>;
> > >  			clock-names = "bus";
> > >  			operating-points-v2 = <&bus_display_opp_table>;
> > > +			#interconnect-cells = <0>;
> > >  			status = "disabled";
> > >  		};
> > >  
> > > @@ -483,6 +489,7 @@
> > >  			clocks = <&clock CLK_ACLK133>;
> > >  			clock-names = "bus";
> > >  			operating-points-v2 = <&bus_fsys_opp_table>;
> > > +			#interconnect-cells = <0>;
> > >  			status = "disabled";
> > >  		};
> > >  
> > > @@ -491,6 +498,7 @@
> > >  			clocks = <&clock CLK_ACLK100>;
> > >  			clock-names = "bus";
> > >  			operating-points-v2 = <&bus_peri_opp_table>;
> > > +			#interconnect-cells = <0>;
> > >  			status = "disabled";
> > >  		};
> > >  
> > > @@ -499,6 +507,7 @@
> > >  			clocks = <&clock CLK_SCLK_MFC>;
> > >  			clock-names = "bus";
> > >  			operating-points-v2 = <&bus_leftbus_opp_table>;
> > > +			#interconnect-cells = <0>;
> > >  			status = "disabled";
> > >  		};
> > >  
> > > 
> > 
> > 
> 

Best regards,
-- 
Artur Świgoń
Samsung R&D Institute Poland
Samsung Electronics


