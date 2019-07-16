Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5CAD6A463
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2019 10:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731042AbfGPI57 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Jul 2019 04:57:59 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:17882 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731015AbfGPI56 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Jul 2019 04:57:58 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190716085752epoutp02802b47446d1d17feafc205f38450b846~x13vrynSF3168831688epoutp02E
        for <linux-pm@vger.kernel.org>; Tue, 16 Jul 2019 08:57:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190716085752epoutp02802b47446d1d17feafc205f38450b846~x13vrynSF3168831688epoutp02E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563267472;
        bh=ap2pf5V1vr4DTOHde6WNETh7BisYzaT8r+hM4Fugw+o=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=J6QUxYXyw0t3X/8JwsIPi/kuXC2A6Ie6EF2B13WdBIv4V62nPcM6RsI0CBriaBz7+
         MR+/AOWE2UWW5qI/IyvKjy6Q2Ztip4fDzu1Zu3tdjlDw18gmFmPz3r3LpmwEFoRifw
         OX6kP8tyitbFLbYiet9LHwwlxTYRU8IkBSqih+6c=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190716085752epcas1p31661fc26c4cef44ea8904a40e2a9dbe1~x13u_4gyG2399723997epcas1p3J;
        Tue, 16 Jul 2019 08:57:52 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.156]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 45nvRx1HbfzMqYkV; Tue, 16 Jul
        2019 08:57:49 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        51.B0.04160.D819D2D5; Tue, 16 Jul 2019 17:57:49 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20190716085748epcas1p4ff623772e49a927d436a7affa386b2c0~x13rTksht2270122701epcas1p4b;
        Tue, 16 Jul 2019 08:57:48 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190716085748epsmtrp1f295ca55d07d98a0ecf7bf5ddba0d09b~x13rSpz5f1598415984epsmtrp1-;
        Tue, 16 Jul 2019 08:57:48 +0000 (GMT)
X-AuditID: b6c32a38-b33ff70000001040-4e-5d2d918d3e7a
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        90.F3.03706.C819D2D5; Tue, 16 Jul 2019 17:57:48 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190716085747epsmtip179823a39f035606534e5f3518f4534de~x13q2bpNW2273322733epsmtip1O;
        Tue, 16 Jul 2019 08:57:47 +0000 (GMT)
Subject: Re: [PATCH v2 3/4] ARM: dts: exynos: add initial data for coupled
 regulators for Exynos5422/5800
To:     Kamil Konieczny <k.konieczny@partner.samsung.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Mark Rutland <mark.rutland@arm.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <27db3883-2d84-3585-6122-e861576ffadb@samsung.com>
Date:   Tue, 16 Jul 2019 18:00:54 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190715120416.3561-4-k.konieczny@partner.samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrIJsWRmVeSWpSXmKPExsWy7bCmnm7vRN1YgztL2C02zljPajH/yDlW
        i759/xkt+h+/ZrY4f34Du8XZpjfsFpseX2O1uLxrDpvF594jjBYzzu9jslh75C67xdLrF5ks
        bjeuYLN48+Msk0Xr3iPsFv+ubWSx2PzgGJuDoMeaeWsYPTat6mTz2Lyk3uPguz1MHn1bVjF6
        HL+xncnj8ya5APaobJuM1MSU1CKF1Lzk/JTMvHRbJe/geOd4UzMDQ11DSwtzJYW8xNxUWyUX
        nwBdt8wcoA+UFMoSc0qBQgGJxcVK+nY2RfmlJakKGfnFJbZKqQUpOQWWBXrFibnFpXnpesn5
        uVaGBgZGpkCFCdkZ109uZys46FDRtfcxewPjSYMuRk4OCQETiV3bFrJ0MXJxCAnsYJT4fmIX
        O0hCSOATo8S/L7EQiW+MEgu/tbDDdNzt/sYIkdjLKNGx9BMbhPOeUWLt5T1gVcIC2RKrFp9l
        BrFFBEwlHq1uYAUpYha4zCIx7dEkVpAEm4CWxP4XN9hAbH4BRYmrPx4zgti8AnYSV65MBLNZ
        BFQlOm88B7NFBSIkTh2ZxwJRIyhxcuYTMJtTwEVi3a9OsBpmAXGJW0/mM0HY8hLNW2czgyyW
        EDjFLvFr9SdGiB9cJOY9W8wKYQtLvDq+Beo3KYmX/W1QdrXEypNH2CCaOxgltuy/ANVgLLF/
        6WSgDRxAGzQl1u/ShwgrSuz8PRfqCD6Jd197WEFKJAR4JTrahCBKlCUuP7jLBGFLSixu72Sb
        wKg0C8k7s5C8MAvJC7MQli1gZFnFKJZaUJybnlpsWGCCHN2bGMHJW8tiB+Oecz6HGAU4GJV4
        eE/s0YkVYk0sK67MPcQowcGsJMJr+1U7Vog3JbGyKrUoP76oNCe1+BCjKTC0JzJLiSbnAzNL
        Xkm8oamRsbGxhYmhmamhoZI477w/mrFCAumJJanZqakFqUUwfUwcnFINjBsdNCd4Ov2NS377
        qGBq5RSOFf3sG3u+7ret03iSMZV3N2PFZUnmeRYXj3ZsNvoifXH9/iMXCg9cu7yg0vTmSoMb
        lqpzV7yao7bzw8O0woN6H+rPR4fqCuTubT+j+FEs7lbE9OUSk17aMD6d/6VI48FfqRWhIWq/
        Sy5LrT64PM4/YmHVEemnGzuUWIozEg21mIuKEwHAb0Fz9AMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDIsWRmVeSWpSXmKPExsWy7bCSnG7PRN1Yg+a/rBYbZ6xntZh/5Byr
        Rd++/4wW/Y9fM1ucP7+B3eJs0xt2i02Pr7FaXN41h83ic+8RRosZ5/cxWaw9cpfdYun1i0wW
        txtXsFm8+XGWyaJ17xF2i3/XNrJYbH5wjM1B0GPNvDWMHptWdbJ5bF5S73Hw3R4mj74tqxg9
        jt/YzuTxeZNcAHsUl01Kak5mWWqRvl0CV8b1k9vZCg46VHTtfczewHjSoIuRk0NCwETibvc3
        xi5GLg4hgd2MEic/P2OCSEhKTLt4lLmLkQPIFpY4fLgYouYto8SDcwcZQWqEBbIlVi0+ywxi
        iwiYSjxa3cAKUsQscJVF4vzGOWwQHRcZJd4/3MUKUsUmoCWx/8UNNhCbX0BR4uqPx2CTeAXs
        JK5cmQhmswioSnTeeA5miwpESEy6tpMFokZQ4uTMJ2A2p4CLxLpfnWA1zALqEn/mXWKGsMUl
        bj2ZzwRhy0s0b53NPIFReBaS9llIWmYhaZmFpGUBI8sqRsnUguLc9NxiwwLDvNRyveLE3OLS
        vHS95PzcTYzgONbS3MF4eUn8IUYBDkYlHt4Te3RihVgTy4orcw8xSnAwK4nw2n7VjhXiTUms
        rEotyo8vKs1JLT7EKM3BoiTO+zTvWKSQQHpiSWp2ampBahFMlomDU6qB0Wt53855czdz5qi8
        vHZeUcYuWWlb0BlbbubaBo9z7x9cNHw9SWa+l+WEApMahpczOt3VUuZ179Vur3635o3DlRUp
        7NFe+Ypnim+YLwk9Hr8rU4V5V/ybsODWN/cY++byzSxZxBLCazi98tIK9XI3TisT9t/Lu3UW
        XND02PTufXuxjQrPOv5PSizFGYmGWsxFxYkACkU6Nt8CAAA=
X-CMS-MailID: 20190716085748epcas1p4ff623772e49a927d436a7affa386b2c0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190715120432eucas1p1b32d72d239420b861bf8596d4e8a053d
References: <20190715120416.3561-1-k.konieczny@partner.samsung.com>
        <CGME20190715120432eucas1p1b32d72d239420b861bf8596d4e8a053d@eucas1p1.samsung.com>
        <20190715120416.3561-4-k.konieczny@partner.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 19. 7. 15. 오후 9:04, Kamil Konieczny wrote:
> Declare Exynos5422/5800 voltage ranges for opp points for big cpu core and
> bus wcore and couple their voltage supllies as vdd_arm and vdd_int should
> be in 300mV range.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Kamil Konieczny <k.konieczny@partner.samsung.com>
> ---
>  arch/arm/boot/dts/exynos5420.dtsi             | 34 +++++++++----------
>  arch/arm/boot/dts/exynos5422-odroid-core.dtsi |  4 +++
>  arch/arm/boot/dts/exynos5800-peach-pi.dts     |  4 +++
>  arch/arm/boot/dts/exynos5800.dtsi             | 32 ++++++++---------
>  4 files changed, 41 insertions(+), 33 deletions(-)

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

> 
> diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
> index 5fb2326875dc..0cbf74750553 100644
> --- a/arch/arm/boot/dts/exynos5420.dtsi
> +++ b/arch/arm/boot/dts/exynos5420.dtsi
> @@ -48,62 +48,62 @@
>  			opp-shared;
>  			opp-1800000000 {
>  				opp-hz = /bits/ 64 <1800000000>;
> -				opp-microvolt = <1250000>;
> +				opp-microvolt = <1250000 1250000 1500000>;
>  				clock-latency-ns = <140000>;
>  			};
>  			opp-1700000000 {
>  				opp-hz = /bits/ 64 <1700000000>;
> -				opp-microvolt = <1212500>;
> +				opp-microvolt = <1212500 1212500 1500000>;
>  				clock-latency-ns = <140000>;
>  			};
>  			opp-1600000000 {
>  				opp-hz = /bits/ 64 <1600000000>;
> -				opp-microvolt = <1175000>;
> +				opp-microvolt = <1175000 1175000 1500000>;
>  				clock-latency-ns = <140000>;
>  			};
>  			opp-1500000000 {
>  				opp-hz = /bits/ 64 <1500000000>;
> -				opp-microvolt = <1137500>;
> +				opp-microvolt = <1137500 1137500 1500000>;
>  				clock-latency-ns = <140000>;
>  			};
>  			opp-1400000000 {
>  				opp-hz = /bits/ 64 <1400000000>;
> -				opp-microvolt = <1112500>;
> +				opp-microvolt = <1112500 1112500 1500000>;
>  				clock-latency-ns = <140000>;
>  			};
>  			opp-1300000000 {
>  				opp-hz = /bits/ 64 <1300000000>;
> -				opp-microvolt = <1062500>;
> +				opp-microvolt = <1062500 1062500 1500000>;
>  				clock-latency-ns = <140000>;
>  			};
>  			opp-1200000000 {
>  				opp-hz = /bits/ 64 <1200000000>;
> -				opp-microvolt = <1037500>;
> +				opp-microvolt = <1037500 1037500 1500000>;
>  				clock-latency-ns = <140000>;
>  			};
>  			opp-1100000000 {
>  				opp-hz = /bits/ 64 <1100000000>;
> -				opp-microvolt = <1012500>;
> +				opp-microvolt = <1012500 1012500 1500000>;
>  				clock-latency-ns = <140000>;
>  			};
>  			opp-1000000000 {
>  				opp-hz = /bits/ 64 <1000000000>;
> -				opp-microvolt = < 987500>;
> +				opp-microvolt = < 987500 987500 1500000>;
>  				clock-latency-ns = <140000>;
>  			};
>  			opp-900000000 {
>  				opp-hz = /bits/ 64 <900000000>;
> -				opp-microvolt = < 962500>;
> +				opp-microvolt = < 962500 962500 1500000>;
>  				clock-latency-ns = <140000>;
>  			};
>  			opp-800000000 {
>  				opp-hz = /bits/ 64 <800000000>;
> -				opp-microvolt = < 937500>;
> +				opp-microvolt = < 937500 937500 1500000>;
>  				clock-latency-ns = <140000>;
>  			};
>  			opp-700000000 {
>  				opp-hz = /bits/ 64 <700000000>;
> -				opp-microvolt = < 912500>;
> +				opp-microvolt = < 912500 912500 1500000>;
>  				clock-latency-ns = <140000>;
>  			};
>  		};
> @@ -1100,23 +1100,23 @@
>  
>  			opp00 {
>  				opp-hz = /bits/ 64 <84000000>;
> -				opp-microvolt = <925000>;
> +				opp-microvolt = <925000 925000 1400000>;
>  			};
>  			opp01 {
>  				opp-hz = /bits/ 64 <111000000>;
> -				opp-microvolt = <950000>;
> +				opp-microvolt = <950000 950000 1400000>;
>  			};
>  			opp02 {
>  				opp-hz = /bits/ 64 <222000000>;
> -				opp-microvolt = <950000>;
> +				opp-microvolt = <950000 950000 1400000>;
>  			};
>  			opp03 {
>  				opp-hz = /bits/ 64 <333000000>;
> -				opp-microvolt = <950000>;
> +				opp-microvolt = <950000 950000 1400000>;
>  			};
>  			opp04 {
>  				opp-hz = /bits/ 64 <400000000>;
> -				opp-microvolt = <987500>;
> +				opp-microvolt = <987500 987500 1400000>;
>  			};
>  		};
>  
> diff --git a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
> index 25d95de15c9b..65d094256b54 100644
> --- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
> +++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
> @@ -428,6 +428,8 @@
>  				regulator-max-microvolt = <1500000>;
>  				regulator-always-on;
>  				regulator-boot-on;
> +				regulator-coupled-with = <&buck3_reg>;
> +				regulator-coupled-max-spread = <300000>;
>  			};
>  
>  			buck3_reg: BUCK3 {
> @@ -436,6 +438,8 @@
>  				regulator-max-microvolt = <1400000>;
>  				regulator-always-on;
>  				regulator-boot-on;
> +				regulator-coupled-with = <&buck2_reg>;
> +				regulator-coupled-max-spread = <300000>;
>  			};
>  
>  			buck4_reg: BUCK4 {
> diff --git a/arch/arm/boot/dts/exynos5800-peach-pi.dts b/arch/arm/boot/dts/exynos5800-peach-pi.dts
> index e0f470fe54c8..5c1e965ed7e9 100644
> --- a/arch/arm/boot/dts/exynos5800-peach-pi.dts
> +++ b/arch/arm/boot/dts/exynos5800-peach-pi.dts
> @@ -257,6 +257,8 @@
>  				regulator-always-on;
>  				regulator-boot-on;
>  				regulator-ramp-delay = <12500>;
> +				regulator-coupled-with = <&buck3_reg>;
> +				regulator-coupled-max-spread = <300000>;
>  				regulator-state-mem {
>  					regulator-off-in-suspend;
>  				};
> @@ -269,6 +271,8 @@
>  				regulator-always-on;
>  				regulator-boot-on;
>  				regulator-ramp-delay = <12500>;
> +				regulator-coupled-with = <&buck2_reg>;
> +				regulator-coupled-max-spread = <300000>;
>  				regulator-state-mem {
>  					regulator-off-in-suspend;
>  				};
> diff --git a/arch/arm/boot/dts/exynos5800.dtsi b/arch/arm/boot/dts/exynos5800.dtsi
> index 57d3b319fd65..2a74735d161c 100644
> --- a/arch/arm/boot/dts/exynos5800.dtsi
> +++ b/arch/arm/boot/dts/exynos5800.dtsi
> @@ -22,61 +22,61 @@
>  
>  &cluster_a15_opp_table {
>  	opp-1700000000 {
> -		opp-microvolt = <1250000>;
> +		opp-microvolt = <1250000 1250000 1500000>;
>  	};
>  	opp-1600000000 {
> -		opp-microvolt = <1250000>;
> +		opp-microvolt = <1250000 1250000 1500000>;
>  	};
>  	opp-1500000000 {
> -		opp-microvolt = <1100000>;
> +		opp-microvolt = <1100000 1100000 1500000>;
>  	};
>  	opp-1400000000 {
> -		opp-microvolt = <1100000>;
> +		opp-microvolt = <1100000 1100000 1500000>;
>  	};
>  	opp-1300000000 {
> -		opp-microvolt = <1100000>;
> +		opp-microvolt = <1100000 1100000 1500000>;
>  	};
>  	opp-1200000000 {
> -		opp-microvolt = <1000000>;
> +		opp-microvolt = <1000000 1000000 1500000>;
>  	};
>  	opp-1100000000 {
> -		opp-microvolt = <1000000>;
> +		opp-microvolt = <1000000 1000000 1500000>;
>  	};
>  	opp-1000000000 {
> -		opp-microvolt = <1000000>;
> +		opp-microvolt = <1000000 1000000 1500000>;
>  	};
>  	opp-900000000 {
> -		opp-microvolt = <1000000>;
> +		opp-microvolt = <1000000 1000000 1500000>;
>  	};
>  	opp-800000000 {
> -		opp-microvolt = <900000>;
> +		opp-microvolt = <900000 900000 1500000>;
>  	};
>  	opp-700000000 {
> -		opp-microvolt = <900000>;
> +		opp-microvolt = <900000 900000 1500000>;
>  	};
>  	opp-600000000 {
>  		opp-hz = /bits/ 64 <600000000>;
> -		opp-microvolt = <900000>;
> +		opp-microvolt = <900000 900000 1500000>;
>  		clock-latency-ns = <140000>;
>  	};
>  	opp-500000000 {
>  		opp-hz = /bits/ 64 <500000000>;
> -		opp-microvolt = <900000>;
> +		opp-microvolt = <900000 900000 1500000>;
>  		clock-latency-ns = <140000>;
>  	};
>  	opp-400000000 {
>  		opp-hz = /bits/ 64 <400000000>;
> -		opp-microvolt = <900000>;
> +		opp-microvolt = <900000 900000 1500000>;
>  		clock-latency-ns = <140000>;
>  	};
>  	opp-300000000 {
>  		opp-hz = /bits/ 64 <300000000>;
> -		opp-microvolt = <900000>;
> +		opp-microvolt = <900000 900000 1500000>;
>  		clock-latency-ns = <140000>;
>  	};
>  	opp-200000000 {
>  		opp-hz = /bits/ 64 <200000000>;
> -		opp-microvolt = <900000>;
> +		opp-microvolt = <900000 900000 1500000>;
>  		clock-latency-ns = <140000>;
>  	};
>  };
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
