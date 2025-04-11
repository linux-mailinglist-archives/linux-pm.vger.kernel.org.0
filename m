Return-Path: <linux-pm+bounces-25213-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB06A857C2
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 11:16:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A622C464007
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 09:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45652989B8;
	Fri, 11 Apr 2025 09:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BXHwukBe"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE8D298982
	for <linux-pm@vger.kernel.org>; Fri, 11 Apr 2025 09:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744362975; cv=none; b=NWXrrAKQZnRiBVquQ9vbv15vITagbpklS7lB2DKZ7C8w3C20TJ5hvtkflbi88S4dpfwHm/y3h52QHm+0QOuTgHvvGJLSrK4Uk4begAXD1h++dL3SQuoL7eqE1+VEryW9B5dz59IfkhGYr10EZx7D4uwLPflMQPxnvZ+n2rhA0oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744362975; c=relaxed/simple;
	bh=6op12FQgpbMbUy118314dBQL/V50ZpjJ7sSJIU2P3TE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tBpoKhFAP1GcRhQKcUrVuQYc2jxxr748orvgpQxt4MAICO3khzwKCZZ+tGF08gCiDYo+JHArAzMk1Hn0vfP4zVA/8BLFHnfsYqDNkkLcr9A/+1UoJOb3p5xt+ENMbhIhDR0FX8gpWgdktkMaq5+fMqZ+4BwgSP4vvVLNWIk0qto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BXHwukBe; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53B102Se001379
	for <linux-pm@vger.kernel.org>; Fri, 11 Apr 2025 09:16:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SdbE/DxPDX7mmNIDt0tfMeaCACq/2F5Z7OVDEZCEKFI=; b=BXHwukBeNNqi8du2
	PVAq5NvS3OJB6v0j6KUFrswmG8tzjAz7KGLPqliamMJzgcOQsOusYeYfwraPkwXM
	MzZkxReq2Jp0tI1ZE8GwclTnyVGu9rdbtf/aoUGbMFBEQumNPirxh/TELp2Edsba
	0xmGi/O8EA6O17AviSO1mrZv7a/vWN7koPTxvChVg52MAhh1YogFDueJCPpWy0nc
	L/Zrwe2qPMRegUg7eviewRj7A1MZ2Q3m/52qCzNzp0820vVT06VSJmadEnvgekP0
	jhLJsglOmUyb1GQOF85/iHbyGQY07St6pqWggtoVaQzqSNTWioo2n6IUTDb/oGFV
	TszYRw==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twftsne7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 11 Apr 2025 09:16:12 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6e906c7cd2bso2440386d6.3
        for <linux-pm@vger.kernel.org>; Fri, 11 Apr 2025 02:16:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744362971; x=1744967771;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SdbE/DxPDX7mmNIDt0tfMeaCACq/2F5Z7OVDEZCEKFI=;
        b=pw3OU1eHYFHqHmalfAZrOi/xl/WlBsA3tZQw3CYi0h2gZv2hzfBxyhnRfG8DoKrnnn
         B1+d135m39oV7qu5h5RMBEBI9Ju6k8Hq2gw/6bkDUvhgU4kTGmxfbY3Qg7LRDkGQp7YS
         LpkcjhNUgpA/lAw2M36GdgHoMUT7pTCOHzlha/PnOTrvb9s1ahjRO+SxRx0VMZUc7uo3
         UQLAC6J/En48wPOhSw8kUbpjrQPFkRmcJoQeYma8TiepD+F/CisCs25ogVoJ/qTv88U7
         rz36gtsPU0FXIkZRYEhFCErvXMz15/f3BJzJMvJgjTA4Hx+/Dh5uY/DpC/PmMs3mYafN
         oEjw==
X-Forwarded-Encrypted: i=1; AJvYcCWlRMfhH+wTnsZMgjFWZrRbEYmuwy+kQ4BjO0yFj/7EPlIiIG+B0/sC0A2F2xJChw3r2d9pPYCHvg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzlieNXqcrNQ635sTu0iJGQ3L+KUWvi8nInb0E/bgXZdhHY1KvE
	PGWhrBMsJ+qPz7Gf0CuJguVPtXLZRWQNy/K5jYpwIQYTPiD/aEtQC47eHtmgAKXmsYbfDNNYPsi
	U3keVi5+o3QHsrFmsniQ1yGncH0qzA92kV2ZYRULp1JeF4T2nBfNa6SPpvQ==
X-Gm-Gg: ASbGncu4ldnQFUzUvYcJ9fqQMcnnsxlWqxUgZQoOj3x08fVKmQtZXElnWmtbk5h8woD
	JKwfRl0e7RqyZe2CXJDB0sV7ulslM2ZU+mYjqlpjxBLMOpsRkj00QopXky2Kb0a3oxftykVrue+
	M9eiyIUwWH9iXkb7Dl4OSf2lobmDC6xydbSqjgMtZn6mUzvrtDqeMN/psj/rudwSyB583ZnPa/H
	735ICcqlHoQlivE2imz7nVVfeNxlgoq/FWYxfj2bOvb6RhTsL7LvszuWCgpXBBN+9XCHUt8YAz0
	VamT7fOf+WanCVCiMaiRfsnUQj35vsQEokgEQSDINZK/mCua6mWKL4UNRM14+kASmw==
X-Received: by 2002:a05:6214:212f:b0:6d8:99b2:63c7 with SMTP id 6a1803df08f44-6f23f1679e4mr10564126d6.9.1744362971633;
        Fri, 11 Apr 2025 02:16:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEA6e1P/nhdQHi+asbk4W6Q507S4YUL3gYt86eK9/3HOGGRdCgqddHT581PqAJyvJB7RwUyaQ==
X-Received: by 2002:a05:6214:212f:b0:6d8:99b2:63c7 with SMTP id 6a1803df08f44-6f23f1679e4mr10563536d6.9.1744362971205;
        Fri, 11 Apr 2025 02:16:11 -0700 (PDT)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1ccd2c4sm406829166b.129.2025.04.11.02.16.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Apr 2025 02:16:10 -0700 (PDT)
Message-ID: <d49926ce-e651-4da1-8e15-d24290047388@oss.qualcomm.com>
Date: Fri, 11 Apr 2025 11:16:07 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/17] arm64: dts: qcom: msm8992-lg-h815: Fix CPU node
 "enable-method" property dependencies
To: "Rob Herring (Arm)" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>, Conor Dooley <conor@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Daniel Machon <daniel.machon@microchip.com>,
        UNGLinuxDriver@microchip.com, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Heiko Stuebner <heiko@sntech.de>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, zhouyanjie@wanyeetech.com,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, imx@lists.linux.dev,
        linux-rockchip@lists.infradead.org, linux-amlogic@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20250410-dt-cpu-schema-v2-0-63d7dc9ddd0a@kernel.org>
 <20250410-dt-cpu-schema-v2-6-63d7dc9ddd0a@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250410-dt-cpu-schema-v2-6-63d7dc9ddd0a@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=B5+50PtM c=1 sm=1 tr=0 ts=67f8dddd cx=c_pps a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Rt0Z8iD2R8SC1h9hphoA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-GUID: qfoNtayDKaEjVuZyYy8onsIdX06HhWDQ
X-Proofpoint-ORIG-GUID: qfoNtayDKaEjVuZyYy8onsIdX06HhWDQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_03,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=775
 suspectscore=0 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 lowpriorityscore=0
 mlxscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504110057

On 4/10/25 5:47 PM, Rob Herring (Arm) wrote:
> The "spin-table" enable-method requires "cpu-release-addr" property,
> so add a dummy entry. It is assumed the bootloader will fill in the
> correct values.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---

Acked-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

