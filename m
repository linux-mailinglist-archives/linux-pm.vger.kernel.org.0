Return-Path: <linux-pm+bounces-28890-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D9A4ADC912
	for <lists+linux-pm@lfdr.de>; Tue, 17 Jun 2025 13:07:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A87DB3AE9B4
	for <lists+linux-pm@lfdr.de>; Tue, 17 Jun 2025 11:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A70E2DBF49;
	Tue, 17 Jun 2025 11:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Wpq2gupq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A632C0323
	for <linux-pm@vger.kernel.org>; Tue, 17 Jun 2025 11:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750158430; cv=none; b=lxZ4kfwOUMTrRgcEzYpKuH27XP393c1e590qyM6yN15oIrfxJATAhEkDufSWumvB9BcLo7gEv1c3BycEvlKvHWjoEhuhlyayd8YPy/lfeeq6cJl64Ouyc4IXDHuD5CWvaBBWpovKQIfxdC9tOcqQoWNEfcDUrY3p8uozagBof7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750158430; c=relaxed/simple;
	bh=ocgJRSJa6BE3JFmsVpvS45RVD35leZze8Krtljlq6B0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KUzXtf861LsZqgHdWZOYF8ZWtTKU57/UQ3hNof7IXDAMYen+OexpUnkH5T0e281+1/46QJ+sr2FVUf9dkHGNeqBOLS9pSga+oC0NprcEyEYKuSS9o0DPyK9S+etjxnY/x+Q1hnpJRfmw8TrbgO74Vh0ruXiEpFDGTEcgE2pNeQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Wpq2gupq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55H6etcf023126
	for <linux-pm@vger.kernel.org>; Tue, 17 Jun 2025 11:07:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QQBuEvx5JTVQWB/H58QAUF5UuJhkg/HVPeKkcx6NHyM=; b=Wpq2gupqxyqZHJsi
	qic+LGF6gO6KlvVYYPy703qlvF7aiP27T40vWYZygr6r/J4e29wLhJECCN6Hnik3
	MU+GRNFZUHjYszkcK0Z0yP5uFBV/s+komAImVBtpOm/rthVinQH4rGPWWcUX2eTI
	JcstzbsrQ8MZubwZ5cjqI98GVe1oFWdLmnGyfx18N21Zdic1PLjfMQO1sC2ijqXc
	fJCDupEleZNpN4teFha8EKq2hy5YxqyouoQ7plF4H8fonAmLEsbH9HCPbDNB5kyN
	DBGZ5KYciWb4RVb8zM3rXHk1x55N5ZrLPiK7yQut9qxIAPGkzUggwgS1SLxLRNRC
	Cup1VA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4791hd03bw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 17 Jun 2025 11:07:06 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-235089528a0so51844665ad.1
        for <linux-pm@vger.kernel.org>; Tue, 17 Jun 2025 04:07:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750158425; x=1750763225;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QQBuEvx5JTVQWB/H58QAUF5UuJhkg/HVPeKkcx6NHyM=;
        b=bzFlFnKAu6GCaeaV0XXveollBMnC3UPFJ2J9wmJ8lvYcoRkHV7svYu5818kLHiodrK
         dEt/buEXkipnOcJl7ltyPbI+3SDFvcwdm5ybsTQkW4Z8+y9WbZF5fx4HwF3EbVTCXxUE
         OPCxKh0BaXRaKRV90fX30bM54HMKQ86OR7U4Wr5t3d3q45G31vE8pWEg872za2X9Xzdu
         s4e55LTjpxX7qZU5L68a3zL8OkOZyusjHabDYUVsTsAl0jXgbZY1Hj+NiDaxfyNrIsHY
         Zrqf9SEt19+5YD4T9QHNmRvoCpJLjPBKR7APj/v6vqdNJT4qLUuqTuhD8KcFNLh2ORuC
         UAdA==
X-Forwarded-Encrypted: i=1; AJvYcCUOoH2yGvZ6uh4kNEg4iKp8yhNRh7JfQmOhvUnrA9da+58mLiffJ4PV30mjsACUlDFN9Mq5SHKHRw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwO0PX/1hSE2oNt8paZmG275xJWOWHR3T4O3ZStzl9WVZCGPzsR
	dS2fXvZXhOuzmEJ0TjE56BkUZVhCgQMVTWAIQwILuR5YDG7UHXTRexzZjYfFHzzUxBQa6kSfq7G
	y5yhasEmXSjs+0UIgUDxjWtqCRKqluGN1/XLLdQRvqGiQ7P69Eza4LYHvaBtYCg==
X-Gm-Gg: ASbGncvy1pLOKp5QYoLHorXvyPHErZXsC9cDPvd/GX/FbY1WZ6TuoSem/QhhYPZej17
	hlLuuKf3Y1bIJKyw3hl6X7EKYSr3lpWMJ+irMoA8xWwDQDnIxeNxJZsBNL4WX971lCz4mD+syf7
	EZKJzPuxsObfFsDu944YE5V2tYww+2ZUd+NyV/qmuZ40V2gXg7j+iYIgR+GE2UzJwdBH6ir0Fvx
	/JfmRW3mS0Zfde5TgoqptOO22pL4mDesv81nqAl9FJpYIA1TanL9myiIQ7/kTabI8DDCnWxd6h5
	O5OdafE17duV7+Ct2Fs7sY1nvr9p1vclPhNxO2aC5TlZnlj6SS2fFFsCi+U=
X-Received: by 2002:a17:902:d552:b0:235:f091:11e5 with SMTP id d9443c01a7336-2366ae01073mr195545585ad.10.1750158425362;
        Tue, 17 Jun 2025 04:07:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMk/25sYGw7/noMCtsDarXs981kExTrASeeTn/1Izn7gqk+MKOiCOPdIyos0682zfgI0LP7Q==
X-Received: by 2002:a17:902:d552:b0:235:f091:11e5 with SMTP id d9443c01a7336-2366ae01073mr195545055ad.10.1750158424942;
        Tue, 17 Jun 2025 04:07:04 -0700 (PDT)
Received: from [10.218.15.248] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365dea7d98sm77290745ad.151.2025.06.17.04.07.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jun 2025 04:07:04 -0700 (PDT)
Message-ID: <11827cf0-8985-43e7-8c05-3c554bf1fdbf@oss.qualcomm.com>
Date: Tue, 17 Jun 2025 16:36:59 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] interconnect: qcom: Add EPSS L3 support on QCS8300
 SoC
To: Krzysztof Kozlowski <krzk@kernel.org>, Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Mike Tiption <mdtipton@quicinc.com>, Sibi Sankar
 <quic_sibis@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250617090651.55-1-raviteja.laggyshetty@oss.qualcomm.com>
 <20250617090651.55-3-raviteja.laggyshetty@oss.qualcomm.com>
 <43ebe623-8822-4437-92cc-9d24e97295d7@kernel.org>
Content-Language: en-US
From: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
In-Reply-To: <43ebe623-8822-4437-92cc-9d24e97295d7@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE3MDA4OSBTYWx0ZWRfX8b1/nDVRSk3j
 s10smAzI/TfQYKUihqGjza49OPV2VukxutnRD3kC54M+q5CTDdEahvAtZC280EROJUxYb+GIpEf
 nFumSJANSrzy+9qj06h/FBbmTiDYw/03vD2OF1togzhXLu98uowrqeoe+Pi2Vf3zMiG04+9JQxP
 uCAJu1ojgbfZ3k35ruKDXYh2R+wBcRVvAj46OHAmUtGTlpZkl4okFxpQm6ShR9Py7q0PrZi3lEM
 rCDvKRac7OhuUqxRhnfoSMw6GbDms/mUuPKi7k+p+GBNoigojh7Sq2K41YPJLLNwRpt2zcY+JGx
 hNy3lUVZjDA5N/xN7fVtprRSn6BcxhLL7yVxqKGcF6sLvJu9aOZMvKC5LQLQ+ywbO+sbz+qsmKX
 y5fpaEgboS2l3rBa4/l66ZeaG+MyPj7AApLleQCusXnFVUEVzE6RNp4nvDxrqg4FH7MYWzu+
X-Authority-Analysis: v=2.4 cv=PtaTbxM3 c=1 sm=1 tr=0 ts=68514c5a cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=5YNjd6bEO5n3GnEyyeIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: 3OUuGGwVRee2NYWfn2xLRExe1kqB4jvQ
X-Proofpoint-GUID: 3OUuGGwVRee2NYWfn2xLRExe1kqB4jvQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-17_04,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 mlxlogscore=999 suspectscore=0 malwarescore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 spamscore=0
 priorityscore=1501 phishscore=0 mlxscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506170089


On 6/17/2025 2:56 PM, Krzysztof Kozlowski wrote:
> On 17/06/2025 11:06, Raviteja Laggyshetty wrote:
>> Add Epoch Subsystem (EPSS) L3 interconnect provider support on
>> QCS8300 SoC.
>>
>> Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
>> ---
>>  drivers/interconnect/qcom/osm-l3.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/interconnect/qcom/osm-l3.c b/drivers/interconnect/qcom/osm-l3.c
>> index baecbf2533f7..d8f1e0a4617b 100644
>> --- a/drivers/interconnect/qcom/osm-l3.c
>> +++ b/drivers/interconnect/qcom/osm-l3.c
>> @@ -270,6 +270,7 @@ static const struct of_device_id osm_l3_of_match[] = {
>>  	{ .compatible = "qcom,sm8150-osm-l3", .data = &osm_l3 },
>>  	{ .compatible = "qcom,sc8180x-osm-l3", .data = &osm_l3 },
>>  	{ .compatible = "qcom,sm8250-epss-l3", .data = &epss_l3_perf_state },
>> +	{ .compatible = "qcom,qcs8300-epss-l3", .data = &epss_l3_perf_state },
> Heh, the same as some time ago. We discussed this.
>
> No, stop adding more redundant entries. For explanation look at previous
> discussions.

Will remove the compatible "qcom,qcs8300-epss-l3" from driver and retain
it in bindings and devicetree. 

This will allow the driver to probe using generic compatible, without
the need of additional target specific compatible.

>
> Best regards,
> Krzysztof

