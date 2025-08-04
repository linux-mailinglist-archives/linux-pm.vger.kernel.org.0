Return-Path: <linux-pm+bounces-31856-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13209B19B96
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 08:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B41E1897455
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 06:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B4B123183B;
	Mon,  4 Aug 2025 06:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="m/x96F+L"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FDA2309B0
	for <linux-pm@vger.kernel.org>; Mon,  4 Aug 2025 06:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754288943; cv=none; b=c5RWGYL87SUiQlB9fQo8B0383wmLvQhu/rQBe5DInNS/M6nAKR96XvreippWL7dmjFiCCQEYg9KrHXE/wzU+jcD/37X2JZqbQhgB0jq9rVXvesKrisZbbfHmHAAE9SLN3+AqIDeY/lOYuz45geT1q+orZ6Qpl6/wJ/B6hTzg7XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754288943; c=relaxed/simple;
	bh=UVq2TYOD85H1Ja3HHtmHivG3lZLMpy0pM635ppWjNoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ou5NXcybDzjRHyOFq1yhjwS8X9Z8/gxltAMi5sxii8AAqOj4iEbeKsYDnVXBw1Nz5EHL2XFZgebuS9WGIXqsA1gJ/1AXee5BowKFosOlmT3WiSqDnhtG/DSi4f0ESa1Bye0aJof4KP/dd3C4lke9PQOmH6qo9STJfxGGJGhuO6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=m/x96F+L; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 573MX3K3029726
	for <linux-pm@vger.kernel.org>; Mon, 4 Aug 2025 06:29:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=pvj9BgUvYssblNJ8rcEOnc8B
	tkYAnDBzYEMRah/53Tc=; b=m/x96F+LN4Wq5b9UUP+UMMwbiZ7orvW/7Z/uanHD
	gOUCt0v9TeGEk3MYXR78S1J7LqLhf2kiWVUC8FYwMr4lL4l/luwIj7atHGQG1h0r
	3/nFJtCVALTW4w/6G4ysldoXP/n9CX8DmbKIMMj00CrDPoEgYNQx87I0tP8Kjz3t
	qM4bEQ84v5onmlogNMMVeya1fyqX/3j75lAdI85K++j6/7ZK+ePgQnbcySi6W//E
	yTznV0kKxcaTstxuaodpEmWrhWM4drz5dQBQiQN8Vkl/wTtxSXnmZr2bkpe63swP
	TbfAquKzYZf/hXKeq6+uZPC2r3j+nyw7WoswLrVeFhJs1g==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 489arwkpqj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 04 Aug 2025 06:29:00 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-7074cb63bccso75212366d6.1
        for <linux-pm@vger.kernel.org>; Sun, 03 Aug 2025 23:29:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754288939; x=1754893739;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pvj9BgUvYssblNJ8rcEOnc8BtkYAnDBzYEMRah/53Tc=;
        b=GQpbfBPVZVeERwcR3vFw4dskE2fqCQEjYV/XXbLSdV/hhO6KxsnQs18Ij4ttQyaE2s
         MaYBs0nHeAgDGewVlAGAsWnMhSscXI5u3526xxamzNXjtzjPxrxhWa7DjKNcB1Oj5o8Z
         avcIDinZ7ZDqbQMAoUYU8+FAGZHhSiX2rOdMjJ+7ttPCkIUEB9IQkt1I5m9QfuHTTKME
         P/tm3PrGMeBFX6SaSOKbGqVxLgTl5Qw5+6YyHQ2F1WySRGlr/VDaTOU7ELg2YOY55CC6
         FIN3E8Cs6o+G0a3WW13PJSmOcv/jG0prlVYWgJiwSqMAQyYHUhg3X571Bk/JOOkRYxWc
         0GYw==
X-Forwarded-Encrypted: i=1; AJvYcCXP6X94sz14ajLpMz0xzcxA5NJ4HnBE/GUFTiXu9zI37ELqw6MF/IM6os8gKpvfRYNBxHCVvbJ4Lg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxRQ5Wr3kSCJyjsMqorqirLCNE3LoqRAUJ7JEq34zEdhFyhWVKU
	FCcXqetH6vrJ5oTz54nmEMfHlZG1qmq/QtjWRYMSvsTTokMnGsc0Hl9GzDy9XhJepJp7G1o9zc7
	lABmuzyVYMOM8MzWvSTboGz+xPEtjlfTsTaZKRuKZp23rHTdUOnowJoXjOye4OQ==
X-Gm-Gg: ASbGncspbn1L4nBJ9gN/IAPeCdszp/bS5oNiOtmBD1GHiJcaI37ZfY0qwD6H7XPKzLV
	rdPyqeoT595fjjZel3OelZNJOKk/uxacLs3Wd9tEuFRRZlyc/IV4BPirbsaSHzsRspuF/uMd5BR
	vKMSGe1Rx2C4TOR/Rq9V0sq7X/w1p2ZxBgxG84fTitA3jVN4kAOi+sf9CS93d+VvHA9mkE8krOg
	IiDZXxu53F+sUTc92KTQVJNyerJpprHi0GFUT2yXgCKTUCMqiAEz6iG/louULLSRodMDTfl4wfR
	B26Wq8RjTKCQNZcHL/KJ1VhnJ0wXJNxd701/Ol50gUHbxr/0f01l4MguFbJrc3cEhhFZ/j4ycmv
	PsmFhsYWpSfXEddFYd0KYTyN3I92+/LA4Zp2qljxw/7IDZJcAdGe1
X-Received: by 2002:a05:6214:2aab:b0:704:f956:667b with SMTP id 6a1803df08f44-7093637adeamr137156966d6.50.1754288938678;
        Sun, 03 Aug 2025 23:28:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH63vqAiisY6ETkheNsOB3qX+bnOLoYkIMhtnNsFiAj6A8wRDCiRqE+gB1mdnw3opOn+XtSiw==
X-Received: by 2002:a05:6214:2aab:b0:704:f956:667b with SMTP id 6a1803df08f44-7093637adeamr137156646d6.50.1754288938205;
        Sun, 03 Aug 2025 23:28:58 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-33238272f28sm15151501fa.10.2025.08.03.23.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Aug 2025 23:28:57 -0700 (PDT)
Date: Mon, 4 Aug 2025 09:28:55 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Odelu Kukatla <quic_okukatla@quicinc.com>,
        Mike Tipton <mike.tipton@oss.qualcomm.com>,
        Imran Shaik <quic_imrashai@quicinc.com>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 2/2] arm64: dts: qcom: qcs615: Add OSM l3 interconnect
 provider node and CPU OPP tables to scale DDR/L3
Message-ID: <bsrhqkrzdapg72o6h6yx3pw6fjeseolt7zmq5fpvfhhdg7ktyv@zz3ueam6lcqh>
References: <20250804061536.110-1-raviteja.laggyshetty@oss.qualcomm.com>
 <20250804061536.110-3-raviteja.laggyshetty@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250804061536.110-3-raviteja.laggyshetty@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDAzMiBTYWx0ZWRfX+PW+hgYtGEfy
 HKtg5EULq1rQu4nhfnP48DUvTk6zVIpf5IhUtRTP29O7DnFbESYeePHf2ZqwkYCy/a+jqFZU+Pz
 NiwmtCYHPhbylpoenlZDBDXncWObqZTsR8gN65BFs1HzhBp2bvXjV0nh9kSHHmORpDkuhw+9tYJ
 YADPFxvIG/k/TZfEVlNMrtuaMC2z2J7i0PSO7YmDfmhVkL6/U4eYgnIWzsG1vhd8Xdsm0y+M2tU
 F+O4Xb0sH+X9Utr88fx0LH4F3I0tlbT0MIvsuIVB8RWFmd7fMk0cw54n0nGaB/1i/bkm8VjMvpD
 oizR7ka9Vxj9/Z5sQnF/1C0aTGGSfoJCsz4bOQdPRgAkkc3I3hLV9417WStTtvqNlbHdATxQLVC
 4YOkcGtAJ1IFlnWmJ8DiWBtfGxmyDKsT8gftawHsCQh6w7I+9teP895SxvWXS1qJZfL0cSJv
X-Authority-Analysis: v=2.4 cv=We8Ma1hX c=1 sm=1 tr=0 ts=6890532c cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=PxBRM3sLOaicz7rGac0A:9
 a=CjuIK1q_8ugA:10 a=1HOtulTD9v-eNWfpl4qZ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: vntfgM6pwnOQ0GoGpi7zansRTTKnJ_k8
X-Proofpoint-ORIG-GUID: vntfgM6pwnOQ0GoGpi7zansRTTKnJ_k8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_02,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 clxscore=1015 bulkscore=0 phishscore=0 mlxscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508040032

On Mon, Aug 04, 2025 at 06:15:36AM +0000, Raviteja Laggyshetty wrote:
> Add Operation State Manager (OSM) L3 interconnect provide node and OPP
> tables required to scale DDR and L3 per freq-domain on QCS615 SoC.
> As QCS615 and SM8150 SoCs have same OSM hardware, added SM8150
> compatible as fallback for QCS615 OSM device node.
> 
> Depends-on: <20250702-qcs615-mm-cpu-dt-v4-v5-3-df24896cbb26@quicinc.com>

Yuck. It's not a way to define dependencies.

> Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
> Signed-off-by: Imran Shaik <quic_imrashai@quicinc.com>

And the comment regarding SoB chain wasn't addressed.

> ---
>  arch/arm64/boot/dts/qcom/sm6150.dtsi | 148 +++++++++++++++++++++++++++
>  1 file changed, 148 insertions(+)
> 
>  			};
>  		};
>  
> +		osm_l3: interconnect@18321000 {
> +			compatible = "qcom,qcs615-osm-l3", "qcom,sm8150-osm-l3", "qcom,osm-l3";
> +			reg = <0 0x18321000 0 0x1400>;

reg = <0x0 0x18321000 0x0 0x1400>;

> +
> +			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
> +			clock-names = "xo", "alternate";
> +
> +			#interconnect-cells = <1>;
> +		};
> +
>  		usb_1_hsphy: phy@88e2000 {
>  			compatible = "qcom,qcs615-qusb2-phy";
>  			reg = <0x0 0x88e2000 0x0 0x180>;
> -- 
> 2.43.0
> 

-- 
With best wishes
Dmitry

