Return-Path: <linux-pm+bounces-35334-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC06B9EFB2
	for <lists+linux-pm@lfdr.de>; Thu, 25 Sep 2025 13:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7FDD3AC3DA
	for <lists+linux-pm@lfdr.de>; Thu, 25 Sep 2025 11:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900C12FB993;
	Thu, 25 Sep 2025 11:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BwL9nOEp"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D4F2C17A0
	for <linux-pm@vger.kernel.org>; Thu, 25 Sep 2025 11:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758800791; cv=none; b=CaVDSVUw+MCtg0D/l89yjV4/1RsPDOdOvc7d6X7Cj5QrZ64OnjUUnWVLJ2wW07mJLDOFLVIu1A+GWbCvHN7HIkgeH/MRkZGBz+8NuS1F6/RHB3Rd28z5hkCyTbyl7TiRiC8fGalYLyfM9Eu1oM1ndIxXjghGvmr9MRx+u1dxCts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758800791; c=relaxed/simple;
	bh=7DUJfiYTs8+x3mc2MkZUdIPuwcqgS8adOyhUYXmp83s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dSJX0UM6D49i0xnj/75BKllDD6vSdkfhMC7HDFLRJJwkEDkS619ckvQcrJdECzSABHDyABXqpviA1k6sztWL7zJQb9Fg4dPzARcARxlcrFIpF/xOqW9V7Cj9VNWPv0kAFiakcW5h3Er0umejr0LUFWGqJ/TNwNhauegtphpb/7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BwL9nOEp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P9W2k2018033
	for <linux-pm@vger.kernel.org>; Thu, 25 Sep 2025 11:46:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SuXsHHwcpiqJfT9yqqeUFDXI9jlqCp7KFuFE7uhFDrQ=; b=BwL9nOEpWXZOCVxS
	MSwnEg3+NGGJz/QjUi2JEUTIE2M/TeLzYM/bHQl+tRcJpy1YANBJAy19WT41iACs
	a3KqOxg/1/Qr1qksLVLtSLsteL73hBt49YNZhf3/5rjdFIlRZUr3gziNSiloXwmS
	hyWqE7Je8p1gl7fML9fJ2HoBcCl+YU+OMcGMcglx50q9I0G8YzqcUm4n7qupjl+x
	i1qk9jj9UlXosc9RjhV65PtVzR1GSc1Ys1nwNA8q4IlSCDrhYpTx8V76klzSwr0L
	n9YmaQ8t5zJiAwMdaKebboJI8dIfKaBdTDslK1YGQ4r6qr5ZVcJXn3aRU1Q3RSgO
	UBmRlQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49b3kkbwa1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 25 Sep 2025 11:46:28 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4cb12718bf7so1926181cf.1
        for <linux-pm@vger.kernel.org>; Thu, 25 Sep 2025 04:46:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758800787; x=1759405587;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SuXsHHwcpiqJfT9yqqeUFDXI9jlqCp7KFuFE7uhFDrQ=;
        b=Zm+pubaZPL/vhSEZgBSxaL0RXX29D13hIMT/6A5cB2wrncJODhULmRlQcgGojDvta3
         WNaoUAHZXSj9Xd/42Xcby1JaNE3D5UTcJuMqhVUeV7RPMhGh0LNNC1oLJf+37EmvArDE
         mXXiKxA7SRaNS3KMdHx+Iq3KKkBDgydhoFl1X/Mjdt1drzFCB4a7tmR8Jg4IZEL3q19L
         vqznPt0TLwnkttUfjVrEixmKslgCSjxSBB164xWMTZ+1gzNWGaYd7vMracO61Hs38tS7
         aehH4oCQR0ZfikkZ86yKGm0piQnq2QDUeBib1fv6VkkSWo/JacBZFFvePSton0DsV/7Z
         AwZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWs0yQya3bZ0438MIoD4OdYNrY+vGWFEqoxPMcZRjSG/AEArYymvMzwJuvgosLF5BKBbrBSATxQeg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2EduOphqUcMCjy7Hd+KY3w1ZsJF0e7rzyP8dbWv92F96w6pCJ
	QrcgoF9aapWXnRJuw6TMIOnZ1BkuOw+/dWpC6WTbvxseBC+V67tA8Fa2g5ETQPbofqua/k4UKyH
	NtjxjWtmhcZp+A6oqp8dxwBDAGzG/WUiq6AbB/nml8HkSh0BxWXlpwCKYiIwAHQ==
X-Gm-Gg: ASbGncuMvI37I7txaD37ueWqonmCo7CDJ+Vm96gM7n3zW+7cwa+7BR3rY/O4qLJqsgi
	D8WA1nIj4jqxGuUjG8RvBslCN1hJhshGjQWhl1S9HZ3EY1hD2idOL+hlEJHCThnsNkEmJZGn/9w
	Xh/jIooRDhIup8q92Y0tT1l9ntgbP4XIl4e4xr+XJ1hxO2afjfId4iKgMnUaQ+zorCiRQUMyKOk
	+KxQB1EtqDjO/JmevmuFHLLEE0uARdCBMmpdMv3+DI7ioTnb9vDhU+9xCP/hfBfCNUiuPBPKHkA
	8SInElbfh8eMsNp5pSEx6NrPtDpEGFWzKjP6mK+ozHA9iAH/l/OFePr4S/6w1tYLzYdcOd2h8Vf
	Dhtl4z70nCT96kLgw8sX2ZQ==
X-Received: by 2002:a05:622a:1905:b0:4d1:7b86:3618 with SMTP id d75a77b69052e-4da47c0cf8emr30175801cf.3.1758800787396;
        Thu, 25 Sep 2025 04:46:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGO/ijx0jrPWvk4fdd8rSVeDWSkOXP0j+0q+c0/jbMYaJrmCFmJzEa0Qx+2CaDRqh27fdMYWQ==
X-Received: by 2002:a05:622a:1905:b0:4d1:7b86:3618 with SMTP id d75a77b69052e-4da47c0cf8emr30175551cf.3.1758800786949;
        Thu, 25 Sep 2025 04:46:26 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b370257a5c3sm4126666b.110.2025.09.25.04.46.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 04:46:26 -0700 (PDT)
Message-ID: <6f3e528b-0989-4d06-8b28-7d98d9de9548@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 13:46:23 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] pmdomain: qcom: rpmhpd: Add RPMh power domain support
 for Kaanapali
To: Jingyi Wang <jingyi.wang@oss.qualcomm.com>, Rob Herring
 <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc: aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
References: <20250924-knp-pd-v1-0-b78444125c91@oss.qualcomm.com>
 <20250924-knp-pd-v1-3-b78444125c91@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250924-knp-pd-v1-3-b78444125c91@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 1AN0AgqbT5kzK7n9u0IczRc0fBz1mpUs
X-Proofpoint-ORIG-GUID: 1AN0AgqbT5kzK7n9u0IczRc0fBz1mpUs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIyMDA4OSBTYWx0ZWRfX04tHmUYZpKGw
 XevfBIm1VVqDO7Dcma1CkiHa26melTPzXego3NWhu5LzMenrfaFSzaAmnsYXfGK5wG3Tc+YsUqj
 RimZYhE9pHvjyM/FGNC/hiD+sICJU85AI77/Bjvkeapo/R9uPVxWIDmotEyYl9YxnaO0+J4LsPc
 ajEFvGtWxJjxY+azaNvqOkeEjgSZjD7La67NQ6M9mCvR1VlXatgtERCk513h0ic4Jv6QsIUtvys
 Nfb2UGPFo+6udipCn82xEC8WxxqSzpFOBv/MLigaqAlZVZtqbTXJC9iRxq/9cmDPo2Hkan1XgKh
 INi1382rFLf97sgcr4wssP1oGiCKghWhplJ3/L+XkbEL6TsYWaSEiX4f+XPcltAohz2zyJ0XaFY
 Y9uPaZVF
X-Authority-Analysis: v=2.4 cv=BabY0qt2 c=1 sm=1 tr=0 ts=68d52b94 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=hka-zFMH_fk-WL56CYAA:9
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 malwarescore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509220089

On 9/25/25 1:17 AM, Jingyi Wang wrote:
> From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
> 
> Add the RPMh power domains present in Kaanapali SoCs. Also increase the
> maximum allowed number of levels for ARC resources from 16 to 32, as
> needed starting on the Kaanapali SoC where the ARC vote registers have been
> expanded from 4 to 5 bits.
> 
> Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

