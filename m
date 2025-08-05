Return-Path: <linux-pm+bounces-31931-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 170F4B1AD8B
	for <lists+linux-pm@lfdr.de>; Tue,  5 Aug 2025 07:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4D373BE98F
	for <lists+linux-pm@lfdr.de>; Tue,  5 Aug 2025 05:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631731C6FE9;
	Tue,  5 Aug 2025 05:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RkP2HQh+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13521078F
	for <linux-pm@vger.kernel.org>; Tue,  5 Aug 2025 05:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754370995; cv=none; b=PNyom+EAclXlkQtNw7Mm3pzH953RGYKo9QfFxNGs6Wh1TrKkHufE/JBMMrI5w/JoVkBMRDnyr56Adgrm+fcKOnO0FuLO6iJomuVB0zs+bLfbPXqOOeBv3IusUzYlls/3aaVJUGZG7Np/gpXk+a8wYodJ61/roN7y4nJDOm2dXUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754370995; c=relaxed/simple;
	bh=Oig3Q3hZsmlQdhFORQ72t5fDzPXNsgbDxXPWaMvU3y4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SSb3bwVFlGunclMXzEt0I+TPWedYAr/n44JGQIf2y1qL7bkmoKhjp63jnrRAwF+h9Pj92350gTD3YKSEiHv6ltBlT0CA3fvjIAJelZSC0MDW0huMaVaHGfX3UIWFvEFmxnuaxzaLnFwnYmuBGWXti3ezizQ7M3hHeYmUeMpeg8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RkP2HQh+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5751sBfg010254
	for <linux-pm@vger.kernel.org>; Tue, 5 Aug 2025 05:16:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=q2Sp0JJ7hRolgAlgKHs4gknL
	uxQ4lo/VLiV4SU+Ip7k=; b=RkP2HQh+z4BMOxqOD7P7sW4/NkW9TPK7IOkBy5uS
	RcP7s2YTJWtiM0sc7FlIHUW4W3gmJCWt5pNDc+iF24pMBtrl2N5y/WJmGXuD8EQj
	xI0olVxVaHY0ry8XpT2IExY16wbzQc1Ch2CE68vXGVyyEnNQjhxu1esCX62zD9Q8
	qLALOXjyxEtlbR2TLkVVB2UBvglNG6LpVnAiO/k0UbQOXyRZuNnzNIZxGhxQvYtP
	EwkQAwNwseSAgy6Rg/JRcUkuemotHK5pYHm19oyWgszK7Y8V1c1R7yf3j0QoHl2w
	UdV6gsN+2Is4+N5qYfho2hRmUeJCH7HD57tYezf6deAUFA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48avvua944-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 05 Aug 2025 05:16:32 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b0791a8e8dso31296561cf.2
        for <linux-pm@vger.kernel.org>; Mon, 04 Aug 2025 22:16:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754370991; x=1754975791;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q2Sp0JJ7hRolgAlgKHs4gknLuxQ4lo/VLiV4SU+Ip7k=;
        b=RVfn33UdEo1eccPUysGMo822Zx3+pemJjnD0qSPkekflowOR8IbnPJe6uB89bpZPtw
         64n6f21JZGQX9lnxDKri0t1J03CQCKQcj/hn8nB1Y2aBk+cFyAV6QxQs6fdJ3BjLtxR+
         GTk/o+2SiN6LOTqiMIB1DqaFbRkDfOYXcRbtMcbHxTgOTbhpa4RyyrzZULVT7aSI3EkI
         UnKH7sw9QQ8F1BPNb5EzIgb/tQ4853v1hIQtbCGlo/2+nSEZ1xHMpkJ5tiRGr43nxd91
         oqfyr1D1AJII+pqPuSwgjOo+FZFZ6wFptTE7O2aOKW8voHodBMnEF8PbeK5jgYsha9U4
         RhHA==
X-Forwarded-Encrypted: i=1; AJvYcCWbBrHc2gdCaoWN1rIA7BCxsepQWD6Xy6ufm3pA+P3NMpqAlcV2SijAYqbDs+HfmU2XpLsByDdiVg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxCM97BntIXiGhGYQG19TLZUIcuJrzZ1C6+F5atIhr/N3rJ7gzd
	gsSIvI7iFzW9NwCjk0juu908oFGSFHnd0mJTwRkX8BodCN1oYnQb+0ILpXRfl6Cnehu4r0nA7AM
	yw9Y+j9QgMcmHGlM+/Oy2UIZOke+ST2OXqhf280vTsycyidPGrruar3fgi0Tpqg==
X-Gm-Gg: ASbGnctfFQL6vLffQ8Q9e5I5Qml3MKFwPHLnp4bKmsmq/zlhDUVzPwqG/mmV4p9QALE
	sJWQ7Lnj3Tetbtlrp1VApTJO+DSjEbn7vkG03qml+mmsFL1YmOeNCG9igVUVN//XQdJZezit0Ta
	HQG7uVGjNOOiy1CoOenvxr+pSxNdIq50cncsc5VeRedG1ui0P5i6sCkvQFMAXs/sIiOijnHhx5c
	knY5SyeHRfzdt9Vocrh1906b3UVeYIKELZ+1jUtGMBHICTfqftQxGfSEbq+3JFhW8JagPhVpVUS
	4IIcdVcR7+3HxPQ0yZ71WIm+HVfH22XzGIu21XrFSkOJG7VVOQb6VUnvlJVSMWiCzQ6nByzt5vB
	v1fEMglOu4Sliz3Vsp//Yl6qBWKUwfpEYncFy/G+2rw+y24ol/e7z
X-Received: by 2002:a05:622a:4cce:b0:4ae:f1c6:ddaf with SMTP id d75a77b69052e-4af109acbbbmr196148851cf.21.1754370991467;
        Mon, 04 Aug 2025 22:16:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGoJwGH8DESoTEOJWJaexUrrK5XOe0roUw245sEJWDUswWWIFDABMaD+GvDrofNEWtsRroi/w==
X-Received: by 2002:a05:622a:4cce:b0:4ae:f1c6:ddaf with SMTP id d75a77b69052e-4af109acbbbmr196148501cf.21.1754370991032;
        Mon, 04 Aug 2025 22:16:31 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b88ca334asm1829494e87.131.2025.08.04.22.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 22:16:30 -0700 (PDT)
Date: Tue, 5 Aug 2025 08:16:27 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: andersson@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        konradybcio@kernel.org, rafael@kernel.org, viresh.kumar@linaro.org,
        ilia.lin@kernel.org, djakov@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        Md Sadre Alam <quic_mdalam@quicinc.com>
Subject: Re: [PATCH v5 1/4] dt-bindings: clock: ipq5424-apss-clk: Add ipq5424
 apss clock controller
Message-ID: <4jvbnswz2445k67hy7xo4t62zevelk4bond2bzgjnsuzf57ah2@mmif5he65o6k>
References: <20250804112041.845135-1-quic_varada@quicinc.com>
 <20250804112041.845135-2-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250804112041.845135-2-quic_varada@quicinc.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDAzNSBTYWx0ZWRfX9us3wknjclFu
 Pmo78wFK2Nah8byvd3DdVyUSQTvDwOEnqvEX+lb7H6xI4YCj26IhO6HeBgnZPR98cU/XRdF2hFS
 S12d38a4+lzmZtd+9+I8cU54b0Awk3qb/WWOTTdYnUFh4jpUOFInj2y3ohl5dmJdigxsNXdrg3A
 nE9VnAfM6HkbvvoRVbVmyhXIi+FotWzfAHCPzj02JibKilKPjpqqZ7ttvTn8l2GZUpriO66KAed
 w59SSP6Z1jIXTsZbarzT8P/+Z9UEIKIrXGanoygrLzgTrFWtHICZRkFqw5agOdq3gRg2LhkY4ly
 ljuAWutKaoNBRlRjmwihM7e9lqnxBEOOEMx9LtCu3bCG/szkyVbod8dNxa31loZQ42jukQA1Gls
 GI5mPdGq59HUkDI90LNZUD6T/IiTJrjGieCddFQpdY2/RlRUHq1bpUSXeY4GyAW0+ch4J7Aj
X-Proofpoint-GUID: nOWJ1dToW-_yx5mdCgCl681sFQh_C3ph
X-Authority-Analysis: v=2.4 cv=OYKYDgTY c=1 sm=1 tr=0 ts=689193b0 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=gEfo2CItAAAA:8 a=COk6AnOGAAAA:8 a=i0r7BDbisMXdHKPMmEgA:9
 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22 a=sptkURWiP4Gy88Gu7hUp:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: nOWJ1dToW-_yx5mdCgCl681sFQh_C3ph
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_01,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 priorityscore=1501 mlxlogscore=999 malwarescore=0 adultscore=0 suspectscore=0
 clxscore=1015 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508050035

On Mon, Aug 04, 2025 at 04:50:38PM +0530, Varadarajan Narayanan wrote:
> From: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> 
> The CPU core in ipq5424 is clocked by a huayra PLL with RCG support.
> The RCG and PLL have a separate register space from the GCC.
> Also the L3 cache has a separate pll and needs to be scaled along
> with the CPU.
> 
> Co-developed-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> [ Added interconnect related changes ]
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
> v5: Remove previous maintainers
>     Change clock@fa80000 to clock-controller@fa80000 in example
>     Have one item per line for clocks and clock-names in example
> 
> v4: Add self to 'maintainers'
>     s/gpll0/clk_ref/ in clock-names
>     s/apss-clock/clock/ in example's node name
> 
> v2: Add #interconnect-cells to help enable L3 pll as ICC clock
>     Add master/slave ids
> ---
>  .../bindings/clock/qcom,ipq5424-apss-clk.yaml | 63 +++++++++++++++++++
>  include/dt-bindings/clock/qcom,apss-ipq.h     |  6 ++
>  .../dt-bindings/interconnect/qcom,ipq5424.h   |  3 +
>  3 files changed, 72 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,ipq5424-apss-clk.yaml
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,ipq5424-apss-clk.yaml b/Documentation/devicetree/bindings/clock/qcom,ipq5424-apss-clk.yaml
> new file mode 100644
> index 000000000000..0154016075de
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/qcom,ipq5424-apss-clk.yaml
> @@ -0,0 +1,63 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/qcom,ipq5424-apss-clk.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm APSS IPQ5424 Clock Controller
> +
> +maintainers:
> +  - Varadarajan Narayanan <quic_varada@quicinc.com>
> +
> +description:
> +  The CPU core in ipq5424 is clocked by a huayra PLL with RCG support.
> +  The RCG and PLL have a separate register space from the GCC.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,ipq5424-apss-clk
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: Reference to the XO clock.
> +      - description: Reference to the GPLL0 clock.
> +
> +  clock-names:
> +    items:
> +      - const: xo
> +      - const: clk_ref

You should not need clock-names now, please use indices.

> +
> +  '#clock-cells':
> +    const: 1
> +
> +  '#interconnect-cells':
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - '#clock-cells'
> +  - '#interconnect-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/qcom,ipq5424-gcc.h>
> +
> +    apss_clk: clock-controller@fa80000 {
> +      compatible = "qcom,ipq5424-apss-clk";
> +      reg = <0x0fa80000 0x20000>;
> +      clocks = <&xo_board>,
> +               <&gcc GPLL0>;
> +      clock-names = "xo",
> +                    "clk_ref";
> +      #clock-cells = <1>;
> +      #interconnect-cells = <1>;
> +    };
> diff --git a/include/dt-bindings/clock/qcom,apss-ipq.h b/include/dt-bindings/clock/qcom,apss-ipq.h
> index 77b6e05492e2..0bb41e5efdef 100644
> --- a/include/dt-bindings/clock/qcom,apss-ipq.h
> +++ b/include/dt-bindings/clock/qcom,apss-ipq.h
> @@ -8,5 +8,11 @@
>  
>  #define APCS_ALIAS0_CLK_SRC			0
>  #define APCS_ALIAS0_CORE_CLK			1
> +#define APSS_PLL_EARLY				2
> +#define APSS_SILVER_CLK_SRC			3
> +#define APSS_SILVER_CORE_CLK			4
> +#define L3_PLL					5
> +#define L3_CLK_SRC				6
> +#define L3_CORE_CLK				7
>  
>  #endif
> diff --git a/include/dt-bindings/interconnect/qcom,ipq5424.h b/include/dt-bindings/interconnect/qcom,ipq5424.h
> index a770356112ee..afd7e0683a24 100644
> --- a/include/dt-bindings/interconnect/qcom,ipq5424.h
> +++ b/include/dt-bindings/interconnect/qcom,ipq5424.h
> @@ -21,4 +21,7 @@
>  #define MASTER_CNOC_USB			16
>  #define SLAVE_CNOC_USB			17
>  
> +#define MASTER_CPU			0
> +#define SLAVE_L3			1
> +
>  #endif /* INTERCONNECT_QCOM_IPQ5424_H */
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

