Return-Path: <linux-pm+bounces-37369-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A59C317BB
	for <lists+linux-pm@lfdr.de>; Tue, 04 Nov 2025 15:22:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 874514276FB
	for <lists+linux-pm@lfdr.de>; Tue,  4 Nov 2025 14:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B6ED32E139;
	Tue,  4 Nov 2025 14:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="d2hS0VxF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LgIrfhDX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB9023B604
	for <linux-pm@vger.kernel.org>; Tue,  4 Nov 2025 14:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762265717; cv=none; b=D/88X/IFoV7a9mYkexfjqcnw5+CKRC8pG3AgBxV7p+8onDNeA9Ddq/dYcsFSeEWY4zJ/BHaMcoNXR737Ms9tFlUsHmX3HxidN//DUkPGw+Vh9re4LUi+853pNYe3QmFZZN2shUTOjLgNwgA/MUssOno3MQbjYnPruFDNWAhFTmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762265717; c=relaxed/simple;
	bh=4kBQhnMmMZ/Vy1JwfBL2bis3lRa4wBFnh9JULuE5Ri4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dDUidqYXVoblCl3/qmQQ/K1HaprFXAcM4/RXKGP4rUnqk7tTDqoKZBgio6PJG8l0nQ/HIyjUjRBkB1yUx+5Y0sdRYOt5I7sjtehKmGE94uAJkHrEe0qfDpuBDYrYacBZrEj/4Fyfc5Lt88u2LTJ+SY5Z7K7YJu3ItZuG2xCf5O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=d2hS0VxF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LgIrfhDX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A4Cg66c2007674
	for <linux-pm@vger.kernel.org>; Tue, 4 Nov 2025 14:15:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZawzPU1DPbFarr1ZZzIREyZz+hjl5nYRiQ8rgw6UyOo=; b=d2hS0VxFizwnb3BW
	uVAga6h34ZWMfLPqjAOnk0ObVLn3KSsrJ0mdCrJfhufeY+UYDhCeV+LKqKkbw1Nb
	NaEk+FQ6r4mYne0iHeC0EbSu/O+WC4bhomJKaKUzlk74jwNhehhhDoi8ZZwKkafV
	FlQBhkr9Qai2wi8/Su6BdGO2JoTIQpKe1Rjgsem07lt6XpKDoUgJ32dBP/ujef5n
	3F1UdVJ2V15gulYGj7H43bnD5DgYKFOA/yiZKUzqTPOkLyBOhPWJukExyn8j+xS0
	lt3vdvv+BBK8twD8vemZzu5ilHLRnW24+CLw9FLLMnOOUvsEntrUC8S0UbKoaeik
	IuuL7g==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a7c7jh8tr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 04 Nov 2025 14:15:14 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4e8b86d977fso23698201cf.1
        for <linux-pm@vger.kernel.org>; Tue, 04 Nov 2025 06:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762265714; x=1762870514; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZawzPU1DPbFarr1ZZzIREyZz+hjl5nYRiQ8rgw6UyOo=;
        b=LgIrfhDXUOpygd+EDO5ndj9qqPEPQ63bEDMepnoM3bIsz8PixgnIpLClhVfPMTnvlk
         HybEiSsl3bcNDLzly14Qbso3dyn2ItUmYZahYFL2+jPYoXVrr/h0NGg9yQ7odFJIRojx
         t2cnIrsV0MfqQc8K0KtLROeRrU/mi4uF6yCijIhNatoK3glVRezSoYwi4KgObf0Hei3q
         vzsNRxq0jsb3et7SB0uGP7mBP5RrXHkSLB6/h+hr8Vibv3IXJpTMksXDUa4G0iLaqkBu
         NqUbxymya7tt1Z9KO0sx0FDcAcpZtKcyevp/hebuxtfvXkHAZDPann9kZiQ8pdUdzeNf
         RoEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762265714; x=1762870514;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZawzPU1DPbFarr1ZZzIREyZz+hjl5nYRiQ8rgw6UyOo=;
        b=eZ0vOXHvWIo9KJP5l794srQJ6MspW9e7MwUCWITNTWBcQlcaY5rq6MRkoicKVX/Ydv
         Xp3vIStzQPumbq11NvBWVAR7AGlyQ5Sk0EMULLVICySyXZBdt0vQeqRwxUtskxUpXuLP
         44BlNMpbaXp1QU47+NmvX/nb5FHOv7Jz+FPUgWezTE45gp0v1/9iKuRGq//5z/GwlXYV
         t983buHNKvf35OaDmcnfAcuBSw4JC0+c5/kBZ6lq85CXRVui9mx5zecrx4b4vDADpkSA
         M7pbc4DszZbLSUEJ4gqDcTGeZnGt/SEONsbL1m6qpdByLtkQAzeqXJn+abE91QelmdTV
         OTTg==
X-Forwarded-Encrypted: i=1; AJvYcCWA+Av5LIAUezSzMGeaOTJ1zYPAtUhXKcY2j2gB4Hn7a28xtxtfIBuWJW2Iom8XGjmk9qRnN3gnxg==@vger.kernel.org
X-Gm-Message-State: AOJu0YznzuRmhmR0Txx6kDCkP+q3YwZnzjJWwTbs7av5JHv1qX0aeR0V
	Qv3g91cifPY6WiPMXJMOncsYFgY1vnomWL4/AuZl94XxgVpKpYvvDP1cXc1wTMBUFyIrGqUIenu
	ic1YSEMdzZcvD9hbzejkjOGHw41W3dths2bPp0CNUtLuMFQiPXHBv+xC1VNr1eQ==
X-Gm-Gg: ASbGnctIpzQ2095jw5ap6w43JeC0iXC+WEJhuNwGLI/45SPzFE/hxVCvkqZLTK66uFA
	PHfUqKUOB6Tcbg6Nvy6/CgEb6UUttVcqQX/QBEg9Ez62f1BkzouRlSTQs39fd9oXYRRVobJyfJ5
	FTHZwVLNZ18H5gb2u4L3Fq8F5yNCAKkYgsnGr2ADfY0MBL1MqnIrcyUhLtuPX9Zn+ZvoEYsk5Mg
	ZEULnEAqk45ER/fgZDOYkuc38eXG+oxuvwsvrhn2UMHBLUT6Tga1lh6LvVgupIyhLTUoKnqcvLA
	vUZfAV2+Kl9gXjX5e/TfwiJQaweaFOFXnw83ELci3CYInucRBrjsQyFHuJ5VeTto0n1aJvLWSiv
	6Vy6JAnUhtYlqZm/l8QX/Ad81ISeuozW8OWJYFuQX85SZb1Lp2oq0bV2b
X-Received: by 2002:a05:622a:114:b0:4e8:90f4:c3aa with SMTP id d75a77b69052e-4ed30fa1f91mr141074351cf.8.1762265713693;
        Tue, 04 Nov 2025 06:15:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHCnoT8noK1WKbItMnFv98+PdZWeIxVjd/vScz7EL4P+FoEmsmNlCNB/0M/VxORbweqoFtfOA==
X-Received: by 2002:a05:622a:114:b0:4e8:90f4:c3aa with SMTP id d75a77b69052e-4ed30fa1f91mr141068421cf.8.1762265706797;
        Tue, 04 Nov 2025 06:15:06 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7240751077sm217902466b.75.2025.11.04.06.15.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 06:15:06 -0800 (PST)
Message-ID: <e50ec922-64b7-4d18-b527-0563260fb5fc@oss.qualcomm.com>
Date: Tue, 4 Nov 2025 15:15:04 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] cpufreq: qcom-nvmem: add compatible fallback for
 ipq806x for no SMEM
To: Christian Marangi <ansuelsmth@gmail.com>, Ilia Lin <ilia.lin@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20251104140635.25965-1-ansuelsmth@gmail.com>
 <20251104140635.25965-2-ansuelsmth@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251104140635.25965-2-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDExOCBTYWx0ZWRfX3noV7y5ClvJ5
 LKtWXRI5HJkCKVL3b0Jws1LUA2oqZbAlkhHHWHIJ1U9djhBEHKX0m/2Uog3uYTzL7kbzMlbXMgn
 lzMm6ILjIdI8U4mPS2c7YJE7FN8aEGH0zFGxuzgPxsMbOFrQf7pOc76oAzKWVWK3YuX7C2a4yYH
 j6A8Qm8ch1lQaRD3DND3ME9xe6qAXTyHRXedCDK8WpmRSBY2q3McAX0AA3JSS2P0H8v5qLOJIgn
 V2FDKc8OSVxrE/hwEDclSfCe25jy82T/KypoLujBisdmViox47JOsGumzCtID/ivOKGSYcwo3jH
 pDaen0vMNCc8vLBrXQ13KRCF9DGt1lg9u5F9qbK36h9sXpSTwK7ZFxGLEtVCUnNC03xuM8d+q66
 ZO3Lq5dhbH550lUjVA7fb3tHY5jtlg==
X-Proofpoint-ORIG-GUID: cufliYf1uglhdn3FwUy_gzj_JiFMbjwE
X-Proofpoint-GUID: cufliYf1uglhdn3FwUy_gzj_JiFMbjwE
X-Authority-Analysis: v=2.4 cv=DvNbOW/+ c=1 sm=1 tr=0 ts=690a0a72 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8
 a=oITguE-HI76OPg9VQbsA:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-04_01,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511040118

On 11/4/25 3:06 PM, Christian Marangi wrote:
> On some IPQ806x SoC SMEM might be not initialized by SBL. This is the
> case for some Google devices (the OnHub family) that can't make use of
> SMEM to detect the SoC ID.
> 
> To handle these specific case, check if the SMEM is not initialized (by
> checking if the qcom_smem_get_soc_id returns -ENODEV) and fallback to
> OF machine compatible checking to identify the SoC variant.
> 
> Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

