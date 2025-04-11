Return-Path: <linux-pm+bounces-25214-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D1AA857CC
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 11:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A60F61BA55E7
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 09:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AEDA298982;
	Fri, 11 Apr 2025 09:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MfRWrUpW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79078293462
	for <linux-pm@vger.kernel.org>; Fri, 11 Apr 2025 09:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744363002; cv=none; b=a73Wksc3p2u7g0KyWMP9mwSk0g+IQO1+rrT8HgeIsBhFcFvfcuONn7CwdCTBSn5+SSjJ3WulIWxxqmpuypviiBCT8bKDBPYH3Lia1b6sMaTRgut10re/60iWlaGi+/uQ5P1grWx6Ik/eAuCkHIU/qLITTtPfRXr1ZmDThnhH8l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744363002; c=relaxed/simple;
	bh=C+RN3MzxMKy12kB1vgpMBhSAt+yGWRPeVpqXvFuJ8Po=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hTfDTv5JdxR+dv6jpO7djAJ1W0Cn4tiqr0F5PfpdobIpfKBo+73u0sPcFYj77wGPbIwkbvCNFPWNktnhoQUnjqXNfO85YUWuvTnto5AeZc33NGmcgA4nJKq4KF1rJHuybGpUhezpC0+5Ga0GbAAbVjiKdUnfBjJGnyOt5ebXaOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MfRWrUpW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53B4ubWj019687
	for <linux-pm@vger.kernel.org>; Fri, 11 Apr 2025 09:16:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ufhmds+kkSlO2rSMDq46DFe1lGxthqem6KM44BdOhnI=; b=MfRWrUpWHKOXgxYd
	tlO/p2GZIa8GpGmxViFMmae42WC/Sm1LQQSfsr1NCsUoMXDIaJcLbGKAHmC/vmO9
	mGCfteziXR1g/s5n4OXVCfBnlE+djitVvKKVaO0PNb1yjIvOk4sXsZyteZl/MXRU
	0u74+JzCVDzaGwOwQK7IzLVuZqj2WT82Y6ZZdVDBWMoTUSpTGWgMQ5JlvvhiEuf2
	Dn04zgeuEvj9ASmeFiha/ItVQzLRwcsdtbbXHHOkdsh+X6zRW5qmMas5wY2VLWDj
	jMR8zbMd2spdPqvT3hrO77tyq2fJSup339513IQbyZBJVJJou3eIdlBUHZjZCLEV
	8A6aGg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twcrt1t2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 11 Apr 2025 09:16:38 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7c5ad42d6bcso43537885a.2
        for <linux-pm@vger.kernel.org>; Fri, 11 Apr 2025 02:16:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744362997; x=1744967797;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ufhmds+kkSlO2rSMDq46DFe1lGxthqem6KM44BdOhnI=;
        b=SKURNcSZBWHgWoMj0qx2mU6jdxtgHJZ1jc1bbjGL9TrhK9+ipbgG/XG+u2s3p6txzM
         2z09bRv5EG28ygNYMOAZsvEhCIy3yt7v/JsA3ypuXtuO9oYtNE0lDI7BhYEtMx3xRglo
         T0SsnwNmVr7Vjzi9G3z8wre7lCgiKGpQCcw9ly8W3LrJFKu8ibxGaKG00LFI8OCbMxjO
         9yWN4j0+WfK2NFPFlnwTxu4+tQblzWixfxUjMsr40Do8RGc/sdS3myR0e9FOfzdHiZ47
         LHhP6t2SnRIiuSzTB80QXu27kErL3bcVAR+CzqeLUhXNaROae4ihEouXcQUgLnn2FgL/
         kfHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQDEB700cbHMYvGzcfeIazW1ZQfdL/dkInivRtMCQReiGlGmK08s+lWXmHfSu4CG7YQbTO3ybSrg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx97tzC6CyQv2nzvxbBVUT98hq9jcih5G+6G/18DP+gmOYcli5w
	j5pgSjSA5q8NQ4TdQTeArMuNCBZRPCcXp3zjCitamA8g76ml35AROS6mvXLpR3IoSDJsK8vyF+G
	uE9XS9NRHhqoueRhGHiL7XBw6/vh4HMT/T7C0z6MccWJux+lLnoSACKXDEQ==
X-Gm-Gg: ASbGncui5uRKl9x3v9FEHmV8OulixsHxw8uAdVsxUhIBtCj7KUmFigryaruFae73/AA
	HMp6XaJaQ0j4VBC8IeBqg/xL0bUmXQLwghL+E8s4peUZ8+3BeiWxefi/GyyE1mrYAQT9axi04i6
	mA3tHiy11Iv4Io8l7Tm2XojhCvI3+p3omOtyKQMJ0AAJt6UliQEs/8xDPSpUzwJyLUK1eAXTGju
	2HlUQMm6n3JHMkOQHkOu0yMs4RMo/n5vh5+MgNDW0HBJqbePv/AkHUIrST2WfGlB8ONCOvRXtY3
	mJIj0jdlHTVNz0w7PqQ6xR9IyuvKQ1QLMrhxUo4sKUaXhhJRTmjcgESJ2tnraOtQ9w==
X-Received: by 2002:a05:620a:24d3:b0:7c3:c340:70bf with SMTP id af79cd13be357-7c7b1af7826mr48640685a.14.1744362997420;
        Fri, 11 Apr 2025 02:16:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFk9dXYbzUf6tHquMMviOk/dVPcbI1gX6P3/o7uHdR9WHzJEGAa5g8BLBffgulwxemVb9V1bw==
X-Received: by 2002:a05:620a:24d3:b0:7c3:c340:70bf with SMTP id af79cd13be357-7c7b1af7826mr48635885a.14.1744362997070;
        Fri, 11 Apr 2025 02:16:37 -0700 (PDT)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1be9632sm424190666b.66.2025.04.11.02.16.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Apr 2025 02:16:36 -0700 (PDT)
Message-ID: <d4f29833-a9c3-4942-a333-8ca4e7a8bd97@oss.qualcomm.com>
Date: Fri, 11 Apr 2025 11:16:31 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/17] arm: dts: qcom: sdx55/sdx65: Fix CPU
 power-domain-names
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
 <20250410-dt-cpu-schema-v2-7-63d7dc9ddd0a@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250410-dt-cpu-schema-v2-7-63d7dc9ddd0a@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Apzf3WqAt0Zys8ZlNUPOHIAEWEmHWjuG
X-Authority-Analysis: v=2.4 cv=QuVe3Uyd c=1 sm=1 tr=0 ts=67f8ddf6 cx=c_pps a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=yZJRhKYQK8xzFtgzSFMA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: Apzf3WqAt0Zys8ZlNUPOHIAEWEmHWjuG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_03,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 spamscore=0 malwarescore=0 mlxlogscore=964 bulkscore=0 priorityscore=1501
 clxscore=1015 phishscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504110057

On 4/10/25 5:47 PM, Rob Herring (Arm) wrote:
> "rpmhpd" is not documented nor used anywhere. The power-domain is used
> for performance scaling (cpufreq), so "perf" is the correct name to use.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

