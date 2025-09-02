Return-Path: <linux-pm+bounces-33635-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 131B1B3FEA5
	for <lists+linux-pm@lfdr.de>; Tue,  2 Sep 2025 13:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D2EC18805E2
	for <lists+linux-pm@lfdr.de>; Tue,  2 Sep 2025 11:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D312F5496;
	Tue,  2 Sep 2025 11:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="n3pPskEY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E51E28489D
	for <linux-pm@vger.kernel.org>; Tue,  2 Sep 2025 11:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756813649; cv=none; b=tZ1MUjHaPSa+ezNjQSmKWG8Gxq5fEetlhhyt/VXkEa61esj4T3DIH4rsRJknlIRc4ITnQspshSOsbQjIoFO+jq5qYZ581dlFOS5L1FoYHf2Io+7sexdK16Y9SUoZXphAd6aRYu65PdFywZjJceYo+m5Ge8cfiyoTpM5+K5PkkNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756813649; c=relaxed/simple;
	bh=Efg1Sal0KX5O8uYenvTI/MzkTGbrZNd4ohf0F8McEG8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ub5Ggkvl2FhgTIgPa8u0t3i6pYu3Tu0sasFuXXs1Izev/mJnzmkVwwcG6mi1o2KQ+8HjaNn1rNHGjqbCiso8A6ZAt54JVymN0VAd63TD7KXa+2XK+oDyNkNBcCgvJdaUyodGzeMFIGuOIPJ+6X8T7wXh2L2vZPFERyeFHhAdcE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=n3pPskEY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 582Ae3E9021586
	for <linux-pm@vger.kernel.org>; Tue, 2 Sep 2025 11:47:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2vTMTDMliYIWA3QTZWruvIxOrprzqsFuQP3qBWa983E=; b=n3pPskEY+Eh83K48
	/AyIcuimWmqNruTTtWvxMDhNVoW2VQtC9rKYwTLztaLXfKdbZklJBtG1Dk+Mt8bm
	YXEM83F6t/MKboEyU/t+omkD2O3hp1ckF8phDoztzkunBXbqb9ROnyIaBwmZTaRy
	Z6riUIPl3GnJwacNqqXWcfbh8a5SNV/c+DTPNwrhzKFD1M5VyttREfZqgvCBZeu/
	pKgT0GAdFUIoAuMuqapYv1HWrtyzFH+3MXUPPJt7i0BcFKQsieaLweLFM3MB8h5A
	ZVHqMbX0iXUan4RJ8jUvYNhyDCqe/3uGRYTcrtXTyHwdRn8hDnUeOjW8V9f3oAs2
	urVuRA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ur8ryqmt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 02 Sep 2025 11:47:27 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b3037bd983so28866411cf.1
        for <linux-pm@vger.kernel.org>; Tue, 02 Sep 2025 04:47:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756813645; x=1757418445;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2vTMTDMliYIWA3QTZWruvIxOrprzqsFuQP3qBWa983E=;
        b=gVfhVbH3aYO5zHDdDhBQK+jjf8c4iRsbKUhtbXWGkmK+xLNNHaWxuYJjD4dilqXdxW
         fqUcrYh40Somgp0DVYNl5tXPUZ8d/82XtpkL2epCx4RvSCSNsT/+QriD2w/UqSZQsfdn
         HNXSv5WQLLnd3prgNKBdkJFc9AdInggQhxF1MmrdV0xCrgTn9ObPdATpVxmzp96c0WNZ
         v4H8deaFO+tUx8f5nMU+sVHhxKRiFqVv65gbKr7viQyaooZLKrupBB2QZjiuNnDEIbmp
         qBCOYUNhVXhF8e7eGjMUUIKWOEco0a26mFyGb4j8pyiJYrlQcEaKxmXnI/Mv+Sz6kas2
         z6Kw==
X-Gm-Message-State: AOJu0YynmYUIdH1psGeREn5diTvKoCoKsJJyOceMjURYZgwlRPeZ9fsd
	Cs4EmWih/Fn6crMRJ6F8DDoeLc65X7hKV5Lqgq9Aa1WptyUuaSTWZ5Ny0vSXPeWDe3eR3qot9E9
	38HuUaypzQWJTpuIgouxfigBLxchoqEiu+4pDedzmdh03kW2Mc4sZzByRWh04tA==
X-Gm-Gg: ASbGncsSM7W0nZuk3MpAruygyC8jipTp4hUFDVvmPiHgW/6nyBa4mnvJfS7oV5nWVPT
	fpScitypKFJJ4/vy15TFqDIv09JVRw/t1EEubASC9Wl2Yaq+U7QFIc19+N4Gx9GCp7iEeCMmKt6
	tszyOEEZxe+Bqbc7kWEoGsktDLs+NY1zS7yjIasnZeGj87atMTJorNCut6gSYo9vPUe7GDW0lTb
	3HH/ODXCzsTU4DwwrCV/HFvuseHrPQ0xZYd+KjADG/Ueg8ns+3D/006XTpd2mOOI2JrW58hszYs
	lt/Gvk9Iie9vxuXyVzp7M/8V9rBIiod5qyOiXS3s/Zn72xctI5KIjrPShUQxB37PHO0NYBRoK9e
	yx4nk1Yv9UhiOGnBqtwkRuA==
X-Received: by 2002:ac8:5804:0:b0:4b2:b591:4602 with SMTP id d75a77b69052e-4b313f0e2ebmr130498461cf.9.1756813645506;
        Tue, 02 Sep 2025 04:47:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEa/TiGzm5CdFf5W/mtmjzpcHIClEM9pOfrKxv/RTV2a1ZzxsQKuK48Yvc6XvUx5Q34m34s4w==
X-Received: by 2002:ac8:5804:0:b0:4b2:b591:4602 with SMTP id d75a77b69052e-4b313f0e2ebmr130498241cf.9.1756813645033;
        Tue, 02 Sep 2025 04:47:25 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b041f00d4c2sm571868366b.97.2025.09.02.04.47.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 04:47:24 -0700 (PDT)
Message-ID: <6f9b7f9d-9ec7-4827-b6d5-51c42b5eb7b9@oss.qualcomm.com>
Date: Tue, 2 Sep 2025 13:47:21 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] arm64: dts: qcom: sm8450: Add opp-level to
 indicate PCIe data rates
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20250819-opp_pcie-v3-0-f8bd7e05ce41@oss.qualcomm.com>
 <20250819-opp_pcie-v3-2-f8bd7e05ce41@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250819-opp_pcie-v3-2-f8bd7e05ce41@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAxOSBTYWx0ZWRfXxS08pgYOPSrD
 yyCOI+ium/n7s7j82Gchlb/i8cEILMUBp3A0AHLarI3Q6EemyPDQpBrcvZgBqtCfPanAG4AMm/4
 Hm240nxbAhOM9WA5F+E+imEO6GtxLtOx71NHsEaY8A22U6nZhA8GjaRYBD4v6T8G0h+CR7w5YP/
 TiWsdJ9YfCv+a2LBDVzRccSZYPDL4F+zOEiqqgVu8G7hW+PIO4RrSCN+c+gFVe8K51IKm6w0ns2
 AMtZ4Nny10MaOJ9NUpxSoXvguEUMB/G/sAsHZR8Eenb/ecx8LLi4yA5UGiX79DiwJOKgP6zZAxz
 Bw021ZHxGroDy96Twju+Hz4CMnNaIrnXlfkygH/dfNcpFuJyNn2dPiJlmNhfYzKNr4UgpfCyiOW
 9xr/SZG/
X-Proofpoint-GUID: dAAoTUBxDgsvLwVV6KANtfTCGct_PKUf
X-Proofpoint-ORIG-GUID: dAAoTUBxDgsvLwVV6KANtfTCGct_PKUf
X-Authority-Analysis: v=2.4 cv=PNkP+eqC c=1 sm=1 tr=0 ts=68b6d94f cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=6pHcnep46kEejBPVP2gA:9
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300019

On 8/19/25 7:34 AM, Krishna Chaitanya Chundru wrote:
> Add opp-level to indicate PCIe data rates and also define OPP enteries
> for each link width and data rate. Append the opp level to name of the
> opp node to indicate both frequency and level.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Are there any other SoCs affected?

Konrad

