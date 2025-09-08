Return-Path: <linux-pm+bounces-34165-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C7A3B493CF
	for <lists+linux-pm@lfdr.de>; Mon,  8 Sep 2025 17:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 730EE188AC15
	for <lists+linux-pm@lfdr.de>; Mon,  8 Sep 2025 15:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC4130F939;
	Mon,  8 Sep 2025 15:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fIovl2uI"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1481430F818
	for <linux-pm@vger.kernel.org>; Mon,  8 Sep 2025 15:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757346052; cv=none; b=edfymsBpSklTWRVQRPB7GE+8FRHazWYaWwMcoSHuqTBQPcxaKP4JBxfFB958O6k078H2SIadNztgHd8EX4kQ1Fh7z9tMmwlg33mKtJvmUSw7mPHfOJyEn9rD6joVrB1Grd9TZXrgk36NRr+uuT1/j8cMGorlNOjzbjQlb37VLjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757346052; c=relaxed/simple;
	bh=XQXO+Tzhlv6Nwt4EWVGJNi5s6zZrQnUFejRGMlJMDwI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n+gKDNvcFNW9mnMWjy3RtN92jtdWU4WMj+MqDXnmjgOBiniedPiPZp9wxnet4EdIUqprhSRWmoeMQgmi+75PX9ZI+tp7eWeWWm0zW7agIcJm8gdjvGldTe7pkP/IvMJ9QPgkZnRNBMd186rIEFmW2uC0OBhTyszqKRRB+FYK/Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fIovl2uI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5888xgOn014574
	for <linux-pm@vger.kernel.org>; Mon, 8 Sep 2025 15:40:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qEL/f0fiN9vSyXycSIa4kThderOPszVm82CtrwmVcn0=; b=fIovl2uI5mDRcrPg
	lVdvcU+/5wOC93/HcguaLdwltpugxYyabIvW2WHRMcm0fpDO7TIRSkJI3eC7gEHV
	9HXHOjq5KTuutnRITjdDRSfqBhcHsQLU9ujIiQ3/HCfKbe/LJ7YHpoqvOOzkmByt
	FJXPovaCzpZgSKZ+ZGuwV0TJu135QuX8gnyMhlmw36oiT/+UZZ5apm6QxNhBSREA
	aHX8fgArVYXXVwRGtsdouDhhuvLdZe5a29vSnccOhWfYr/gkG67lj/gzfbDCIP98
	MXKMm/IPYMvimjpPsWvCcVcKzGVodtBlnrb1c6WHb2s2hX7l0hw8JPWIwufFVZSU
	ReEtmg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490c9j5671-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 08 Sep 2025 15:40:49 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b600d0a59bso10824191cf.0
        for <linux-pm@vger.kernel.org>; Mon, 08 Sep 2025 08:40:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757346049; x=1757950849;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qEL/f0fiN9vSyXycSIa4kThderOPszVm82CtrwmVcn0=;
        b=QVn0RVzwZKAborm3/X7q4Uo8jKvEN8/BfXHmxB/1NIjY85mUiLfSz9Aj7MVrvlT8Wx
         p17o1Wwttp5aACiHfNz6e1eSKgpbWV+TEcdIuWgbxtC7cJc8l3eBIl7UmgqsRk0I3meh
         aCmD7iYuWfUdtW7RKhZe0i7vYZr44EKZTAwnXhF1LaU7eFLTiu64kqxSwBoAWUoQT4is
         j+UFAa5EfXqaE88Vc/GHZRYhen9+RY0O1Wlt2PBF5mTwMEuc9tlesijZzlYuQBts4oIz
         k16JpofGle7R/9CsG18sZ94Lmccl52K0MaA/0UZDAqco2T2LLFFnQ7hmNrDw7m9xXDkj
         r/kw==
X-Forwarded-Encrypted: i=1; AJvYcCV6zOjMTzzbo3AeSl5UMvdsNDIhsR/M4dcoN9N8aSDXtDnjuk6euH2G4wHJZK+O9W5APOLm1tYsWQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywsye6w/IcDlJ6pFDgtGu4dkmV2jXHizG9RbNOqjXVHqOpaEQv/
	5ugOVGwNbrOFkJBKUH/hZxVyPaBEguIfrJP+HgAJhJIEdtzv05fCmZE6th3LK7BYGWeiFDGGGMk
	vDlRzIjxmlff91yi9OcGb9CdH017O3+fX7kCg7wVQFcCrWWSI90TfXG5xEtvUbl5l/4m3vA==
X-Gm-Gg: ASbGncsE/LFpro6mUwdzn79fe+ZwqYcr6/Pj9+W8QerPW2si9rNZbsMF1MoajiDQz+g
	OTxyIyIIGMatoFYllvySh6iBZJ0abPeTQ8ASOr8qLMvN4CBE8g4tSGQ8i3k14itFUXI6czOPytY
	kvqnybt4//MBD5p7t0Hjsem/SmieHlFFDdO4v+xy5KXwkn1uwBcMjauXW4pFkA/0rXfVxq4aem0
	loeTu3xoqZ0dTrMkTKGbULg88crKZPRYdo/kidIZyhC4R8xRbMY5kXRIIrXSRsud26GU20DaNAA
	2PgNKeL2SmNEsoqeHUg/m333pg84BfX6Q7Z+OnJ3PrsPqUb4rlZ50NC6fMJYtPlWN/GCyDPfzLD
	8lPsZGy6I0lzU/ZV4P+rzhQ==
X-Received: by 2002:a05:622a:58b:b0:4b4:9d38:b93e with SMTP id d75a77b69052e-4b5f83860e2mr57363661cf.4.1757346048714;
        Mon, 08 Sep 2025 08:40:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSQXBBnYcaEbWaiBHeiamyobKP1WAkRxcpeUav1deyl3r76u7Rjk/xxH6krW0KNLxWuUfTog==
X-Received: by 2002:a05:622a:58b:b0:4b4:9d38:b93e with SMTP id d75a77b69052e-4b5f83860e2mr57363431cf.4.1757346048119;
        Mon, 08 Sep 2025 08:40:48 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b0438102debsm1819568266b.66.2025.09.08.08.40.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 08:40:47 -0700 (PDT)
Message-ID: <6a00646c-2b25-4193-8db2-157669817d61@oss.qualcomm.com>
Date: Mon, 8 Sep 2025 17:40:45 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] cpuidle: qcom-spm: fix device and OF node leaks at
 probe
To: Johan Hovold <johan@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250908152213.30621-1-johan@kernel.org>
 <20250908152213.30621-2-johan@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250908152213.30621-2-johan@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyMiBTYWx0ZWRfX3JfKCkXyf6+n
 OscCz+HY5EfKc3bKOkORW6AvVl/R4AZoQb4hTlumWX0m1QQLXeJ7w3tDTWQXPx1WCPcvnaqUCV9
 +oT+lch0KwGQU+1oMW6wrlo26S5NXM+73T85B057li0a6uZEgLsRaGs/nvGBFtyztgbKhwKsdxx
 /5RSIRyRgmuQ78N653w8HO8iae3xTsKMfaiyKUQmRCXpEB5Ujc03OoGTF7R3dBVcqQlnN3Ciybk
 qA/v3hPkLtu8g3Yn0Tf1XGmEsbYmSCXyy2qoAxBYCsZco80Pmvy7zFJEDi7WQfnxkfxkTMpwpwe
 FMxyQpQ93fwMJOqi02pq65JKzAUenDo7WpMbuhI9Tt8tHu/v+RJqL4WMLXe0u8c+Yr0R/UrPnRn
 eoiiB3r1
X-Proofpoint-ORIG-GUID: 6KHYBHvWdzPgAgBhih7ThVEe54Vd65CC
X-Authority-Analysis: v=2.4 cv=PpOTbxM3 c=1 sm=1 tr=0 ts=68bef901 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=tVI0ZWmoAAAA:8 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=LotNk_tcR8CuMVeKJCUA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=kacYvNCVWA4VmyqE58fU:22 a=-BPWgnxRz2uhmvdm1NTO:22
X-Proofpoint-GUID: 6KHYBHvWdzPgAgBhih7ThVEe54Vd65CC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_05,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 adultscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060022

On 9/8/25 5:22 PM, Johan Hovold wrote:
> Make sure to drop the reference to the saw device taken by
> of_find_device_by_node() after retrieving its driver data during
> probe().
> 
> Also drop the reference to the CPU node sooner to avoid leaking it in
> case there is no saw node or device.
> 
> Fixes: 60f3692b5f0b ("cpuidle: qcom_spm: Detach state machine from main SPM handling")
> Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

