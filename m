Return-Path: <linux-pm+bounces-39651-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B492DCC792C
	for <lists+linux-pm@lfdr.de>; Wed, 17 Dec 2025 13:22:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 99468311A625
	for <lists+linux-pm@lfdr.de>; Wed, 17 Dec 2025 12:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB38342148;
	Wed, 17 Dec 2025 12:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZFrSypy5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DzNcqd9w"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10F334250E
	for <linux-pm@vger.kernel.org>; Wed, 17 Dec 2025 12:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765973682; cv=none; b=BCmdElvp1B1UXkKh/3fStK4CNf15E52uQYn+CcH6lUnUnfFU5GCt8JqHf/f9wE3+FfjbTXSYzL8pY9to/HjcqSmsB3NVMm1aAnt3z6j15pjCHGctacrFJU9G+saZouKttPWUP3jPIiLAKPMhiXS3MWeHyqoBNsKiA14IinKZLYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765973682; c=relaxed/simple;
	bh=FOhOqH7toKWDzEVlR9pUeDZO7isCrYW9YHhCfh7mb4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aqcGmM6EhmkbpmsPeGdJqIGcNCHGOIStccrS5Eq36eH/Fjj3iIq8Bc6rZekpcV/2Cghhd27ahnSpdt5BZgYqbFTSX15mEPtz5i3XHx9MocnKtmElGS5PAsZ4XtFlrKtTwZmuMt7u5OpNrxSdRb8ISg9nlLob6hOF44m994T02aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZFrSypy5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DzNcqd9w; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BHCCipx2484141
	for <linux-pm@vger.kernel.org>; Wed, 17 Dec 2025 12:14:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TiIbU7CAhhv+5oiifZDjVX1Qm9RbZdgxoYbJ4QOuiwo=; b=ZFrSypy5utuA2YbI
	hI8cL76CIrAck3oThQeoP95f1+GFPSx7sQFPCz3grsZ/eH91tuvM0GyS+Wk+ANJs
	74NsKs1oenO2QQtHFUvYJuEW3/gyAt00nQnwYoSKip3Hw/dCkREL2hs+CBFHh4+l
	Uv5oyCqzcWOB6rLSfOxpF0aI514PvPGy5QnZl62UJmumw8zZbPOLhAmVdQG6Vxx6
	GNa2JUE6llKuxKckHwVDRBUnimC+CNsD5HquA56ZqKzcz0sMFV4DTxs0bc3NKmJ1
	1rjtN/CyTXi+yIBveOlLhaCbiZJGReais+zPbBPh8nN72tIcExM1htXrOb5C5/yo
	XkcCjw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b3rqa8sg6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 17 Dec 2025 12:14:38 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4f1aba09639so18344741cf.0
        for <linux-pm@vger.kernel.org>; Wed, 17 Dec 2025 04:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765973677; x=1766578477; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TiIbU7CAhhv+5oiifZDjVX1Qm9RbZdgxoYbJ4QOuiwo=;
        b=DzNcqd9wdgg91+8wciqJ6aareK7wxNv10+40Afrcnrjou/bR6VvbcHEX2V4QivL/nY
         Azf4Sl/DcLhMIAkBMk9CMaL+UgvuQezeQfND+fGgId4S4X6j4XXsKNLhz+JGxyDr9N2Y
         V3fmoWG/AE/6bKp/YJ075YMLPVRmi9cggXDtoIkmSACeBHPF7L8UZd5GI68MaK5dyHEs
         ryBDIOVPoeswan38pxfwpRHadyRcdHvpKFs0SI/4vz9nGMwOBxjpSB0TDZ1cJEjUR9jE
         qbi9I0VwTwwjnEPQ4tPRhstU+gWNBh8kx/aTR65n9g9wGJmCO5fgNizoI6BHexlZXoRI
         fKsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765973677; x=1766578477;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TiIbU7CAhhv+5oiifZDjVX1Qm9RbZdgxoYbJ4QOuiwo=;
        b=t82AExb50ZRb9fT4hqDfZiGe8vxgEUcIQXWvfo8K0WpRJGTXtBgDT4qwSZimU+MLR9
         SIkYWNIzliR5wqUKIhmxvK1E1Kvs/YmuBl1o9xambX2MqpJmEK3qU4R6429maAPvbzF/
         zJdpVk9kExnH7EkDPmT8lNQdOxZrjofMlcjEjaBREdPyRkOB29G2gviGZZ8BBTO/IRri
         5k2UEhNLNgbFfDFgNIacvn3Pi45kIEqn15fNxWkbEYt/UpDrKHcrF5CTyJHr9YfaNOZY
         JyCeaUcfRZ0/OWjEdSKpnF5crenNT6gBIPjSWYiomt7JPahHC2dQ4fcynFOl8u7zLwtD
         Kjkw==
X-Forwarded-Encrypted: i=1; AJvYcCVgnPXWVptE/VdJxyiaKGPNVMhfsgSV/oaBebIiKN2cpfci23Tqbw127gwiH5MChrtzvumb5XODIw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyIlBYdWDS71bNQCZknH4UXuMn8l9i5vQZa6b+JRSkGL7YYZbEb
	ic+riIij8OYZXVZnzAPzdRMYDAh8q7nTZwKzXs9vSQtmBSsQBU3onaCnBI+z+0QjCbjxVDcrDV2
	PhDIGoFNsACc9fi18dNOjYqbOFnVrf+30kMMc/9ovR7/J4U4ThtwdYq2eihif+Q==
X-Gm-Gg: AY/fxX4bxt9KhAnKjbvkXniosYskpk7dc+PwTGk15UmHR2YcSPxXLN2VHZ9W6yRG21P
	Wkdh9Cd5J5LIxEyF03/a2Mrpg2apbExHRRLkf+dOLWQzZALPkhzqfmwMhAFx1krOEJT6wus3d2B
	Tafo/lrZFrPx5cb7b2bcpz8JEnFLLYlvd6WZj0u5mO+6fXHmws4VTY9VWSv6n9CHsoz+bYRcYac
	b20hBn/a7yQnC6Rvy2hCRThG/w/mG5cCldM+gnSpccRFoQnIWYmouv1r72g3DpnbYl7JA4ER9WL
	V3O2djNmmj1RTh8Png6g71SZ8AFDB9FoMr3MPIG7U4miR5H+B/TXMkCuoZfmSAh9UipdCw3N3Ev
	Wep613rNt9t5nA1gjtLEqAxeoc4+/+6kC17XIXZMGHKH65dkdE2EO8EANDZR7QT0T0Q==
X-Received: by 2002:a05:622a:610:b0:4ec:f9c2:c200 with SMTP id d75a77b69052e-4f1d0655504mr188695331cf.11.1765973677019;
        Wed, 17 Dec 2025 04:14:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEXVGpRhIxu3Mf8+ixHHNkLitg1sBzNFn+khIqfYf9Z5J9ROjGkK+V2r9lo/OeYRDeOI3YbBw==
X-Received: by 2002:a05:622a:610:b0:4ec:f9c2:c200 with SMTP id d75a77b69052e-4f1d0655504mr188695061cf.11.1765973676600;
        Wed, 17 Dec 2025 04:14:36 -0800 (PST)
Received: from [192.168.119.72] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7cfa2ed80dsm1945925566b.16.2025.12.17.04.14.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Dec 2025 04:14:36 -0800 (PST)
Message-ID: <8466d783-faf4-4b33-8822-1477cbdec288@oss.qualcomm.com>
Date: Wed, 17 Dec 2025 13:14:33 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 9/9] arm64: dts: qcom: Add The Fairphone (Gen. 6)
To: Luca Weiss <luca.weiss@fairphone.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, Vinod Koul <vkoul@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Bjorn Andersson
 <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-crypto@vger.kernel.org
References: <20251210-sm7635-fp6-initial-v4-0-b05fddd8b45c@fairphone.com>
 <20251210-sm7635-fp6-initial-v4-9-b05fddd8b45c@fairphone.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251210-sm7635-fp6-initial-v4-9-b05fddd8b45c@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: bt5v_ICxx9KzrLu-JKpKI0lI6Y2eVcV8
X-Authority-Analysis: v=2.4 cv=ALq93nRn c=1 sm=1 tr=0 ts=69429eae cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=6H0WHjuAAAAA:8 a=EUspDBNiAAAA:8
 a=deFlHvtSqnmsrBg3ijIA:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
 a=kacYvNCVWA4VmyqE58fU:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE3MDA5NSBTYWx0ZWRfX9BxlgQorFBOP
 nltrhP3Ey2YqTx6cotKgyRAgkCMwH9JG9rKQx35rawgrtNQgKezbBcd72V1Fnzu97IYQDfHoFZb
 3hFKWx71hGawoAp/LTvHkvYMy9ruWiizBwsSqAOP/0fNdB/EomdoX4C9ivag73NAM5i4ZhEYuo7
 8V64iZaLEh20XiupJ3a5aJHz/rmc7voaalpaaA6oeRWWkzOI6J49dRvoL9z/zupEAyWZTyXt2lk
 eWAWQNJGT6IzeDd3Y4akkKIqomxdsMxq22ENkNtgRz1CauNWMIoPXB81+UIo+5MpGW9FlnQiN6K
 g4+sRnjLqeyeKlmaj2sQHjTCNaefaRzorjkI36xvv70ejzyFgAdrbRgTdlbcTC5A0kCljXXXTBC
 sUkzkUydiFyDgIs5K+bc5KoWYd8B0A==
X-Proofpoint-GUID: bt5v_ICxx9KzrLu-JKpKI0lI6Y2eVcV8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-17_01,2025-12-16_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 impostorscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512170095

On 12/10/25 2:43 AM, Luca Weiss wrote:
> Add a devicetree for The Fairphone (Gen. 6) smartphone, which is based
> on the Milos/SM7635 SoC.
> 
> Supported functionality as of this initial submission:
> * Debug UART
> * Regulators (PM7550, PM8550VS, PMR735B, PM8008)
> * Remoteprocs (ADSP, CDSP, MPSS, WPSS)
> * Power Button, Volume Keys, Switch
> * PMIC-GLINK (Charger, Fuel gauge, USB-C mode switching)
> * Camera flash/torch LED
> * SD card
> * USB
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

