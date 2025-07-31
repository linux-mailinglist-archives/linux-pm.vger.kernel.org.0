Return-Path: <linux-pm+bounces-31677-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F28FB16EA9
	for <lists+linux-pm@lfdr.de>; Thu, 31 Jul 2025 11:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B096218928A7
	for <lists+linux-pm@lfdr.de>; Thu, 31 Jul 2025 09:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471672BE043;
	Thu, 31 Jul 2025 09:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TDQcV5lV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D875E2BD5BF
	for <linux-pm@vger.kernel.org>; Thu, 31 Jul 2025 09:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753954155; cv=none; b=QKJ4RqEYB3E4mlJnc6Q6+ier9AoI/0PZOvofQm5czkBlEJdycyp+SpanJg5AiUOaAnahbyjbRPbW9TUfG8Hd58k2V9AcNlVnMm9/sPkByNa6ftP1Jf7DeuIhsA6HTIL7i/wMgZsMpf0mY1Dq8C7hZx52/TouLLwj11hYwA/qyyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753954155; c=relaxed/simple;
	bh=IHZPKmlLSjGv/zKudIVvIceDqYAgwKFyLeVTCMSAGSc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VrfvrVs5ahgiVYA9SCfOMwrBROreva8ZoxfSvykBcTBpAaU9/Wz1KIcSZnusjhjPJY4JQicli2Z+7RGpxgpo9qe2M3YzkyuV30Wd3LAx4a0Pxxq/IPf/NInYERFwKnBOXlCzjhX3zQh/4Y9HGYFQVVr2JNddluJSaRUztQLC9XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TDQcV5lV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56V1fV8r021927
	for <linux-pm@vger.kernel.org>; Thu, 31 Jul 2025 09:29:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AR8kXmM+AcqdH9Nrt5k/6nLes+0FjxEWYyYuuWpZ7p0=; b=TDQcV5lVxg2CDFDR
	qklycQm2MIS+Tlyl3kfmjDSWsLc+Hfm3d2vfC6mPMIUY9szgBk3Rkf0YgcvG/MDQ
	bkRo5ppsTgZEZmp3kIJb6YAvORTc6FR4YuxXPhfmWjV4WLvXs2cEUwGicvHqNabE
	tF+gz8swVbzoC2X6A3DlMlB8QpqTxZb5vOw3oo46QB10csw+1RFx3BjvAKC/YTB3
	rV+86qZ+vw6Kw5THagFyQ/HD8OTm7T7g7B5I29AzZzdlfqiqkA6iGpBtZ+ZnQ00g
	7eyIa6IztPjxQdjvzfbA32YhJipcc3QpXy3hYmIjPqNs68wo2yRPgxSS1bcIlQlN
	WuA6AQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484mcrfbp1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 31 Jul 2025 09:29:11 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7e2ced79f97so20996785a.3
        for <linux-pm@vger.kernel.org>; Thu, 31 Jul 2025 02:29:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753954151; x=1754558951;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AR8kXmM+AcqdH9Nrt5k/6nLes+0FjxEWYyYuuWpZ7p0=;
        b=XUHLdqxaiG1zdGblEgmw+fDh0ZXAzhVazmoJzrQrLnKqzRRz+D4DwUO38Zg4rlyN8Q
         czVnppOWXGF4YaccsCR+1/QP9AlDkr0SeBY32w6PMXJ/6pz6Ljsu/WMQGQxpI4HeTN0N
         w/NzVkGNtk6BhQjE1aHkdEfqXwUD6YVRRBLIL0rSZKXudzbKdyMHF8YPY/v5p+HR6Py0
         L6B5aSwIxIsWiajURG3xQq0cWnK/ISNRsg6m+WK5rJbk2rjAw8lcmfd/8CzXw6CP844P
         eC6ey1mCQ/urOEpB/XtNFneWCd6nVVYuUzzEDzxrgr6Rot9CeiAkMsI00NAvhtZgMeUX
         wPfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUc6LXyiA7OaP6ReJv8j+xZ3/uOHPZt+lwvK4CUHeCwrm0TyfYqq7aR+n+X1ggrNqKVhbS54E+zZw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyZHgQySScxVfm+Rq/Wrft1VLW++5VAPalh/nEZLTnpsC/cg5+h
	1MTXm+JOdAKCmXYF1HYxkNhYMITfTheqe2bJstPkkJx0cey5DsTA7MDxjWtT77nLqXlW1DGG6jg
	s3k26BHnNjpFm1HOx2p3WCIzRXHCD2ka/QazuADLFZKjEJ/Rx/uILzW0qJDuOuQ==
X-Gm-Gg: ASbGncsZ+x1RIRQWOJdUgEATQVzkmuvAmjBO0sXMXaKH0lU4fZiOqCGrVNFMD29rpQp
	iCz+Jb5H2XTXeWkE+s06unyEgFYBQJqcKxb4qblCfKzkThnwHA5ke9J9WkhqUTcuh0N4fQYOKUu
	3f73EAUyExNfo0sLt+HXwoWNEn+Bap4ooaziix5A7Xv3R45iXNlvLjSpn7SJG3tYF6hm0+cZ7gx
	VGjKiSxJHLwq4fSUAp8M9vF3pfDTJQNehWiYPts8hyIdC5JH8ckmlKViAWcghPsxDsA/whpeZQt
	OfxaTQcba7RdKNsyJ683QIgMaZGLduZE8wRrMLO4s52c/mbdQoadRb5E/R6Sj5bs1HVD/p26Ybm
	p8iUWoph7HobLvNaIKw==
X-Received: by 2002:a05:620a:7017:b0:7df:d668:22ff with SMTP id af79cd13be357-7e66ef8c17bmr402827885a.4.1753954150705;
        Thu, 31 Jul 2025 02:29:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5EIEHBxAx/av6/EVl2n7Bd7mjdXoZdNNVoslRFzMEMPHOc15syfWHOkCpZhXmfqN651UxUA==
X-Received: by 2002:a05:620a:7017:b0:7df:d668:22ff with SMTP id af79cd13be357-7e66ef8c17bmr402826085a.4.1753954150222;
        Thu, 31 Jul 2025 02:29:10 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0771c7sm79029166b.26.2025.07.31.02.29.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Jul 2025 02:29:09 -0700 (PDT)
Message-ID: <17f19573-d304-4f45-8611-b62a032f33cf@oss.qualcomm.com>
Date: Thu, 31 Jul 2025 11:29:07 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] arm64: dts: qcom: qcs615: Add clock nodes for
 multimedia clock
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Taniya Das <quic_tdas@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc: Ajit Pandey <quic_ajipan@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20250702-qcs615-mm-cpu-dt-v4-v5-0-df24896cbb26@quicinc.com>
 <20250702-qcs615-mm-cpu-dt-v4-v5-2-df24896cbb26@quicinc.com>
 <ff6eee04-d191-4dfb-82e5-7e3a6c896025@oss.qualcomm.com>
 <d11496a2-5a43-4b6b-9a8a-d8e05a89587a@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <d11496a2-5a43-4b6b-9a8a-d8e05a89587a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMxMDA2NSBTYWx0ZWRfXxrjTCHAlRYf4
 jsKjk4lq4kmB9MZg1hZhSz0ARoc3BVzOIlakuMwkoWSnQPHQaPUVLm6bAO5t/V507b7Co+ecgHe
 Ddven3XV2dquJ1GlDDFaPb5UgHppf92Kh5JjZdlOdRoA2aXpW2WeJ/L9eEK1lTRRKau5PTnY9Lr
 GiSje0GQXO/2vGyGY9rzZW7/thp2sKXRU/uIXS6jP2wQIUXEhzet4CKdk6E8MZu38pa5srGKE1Y
 +v6kqQqgpsj7KoKqEfegxt8SyASp57Pqr7vXVPFbTVBjV5YWfKUo1fqXE0yfscN6XfkEqVIybID
 nqpMFN8oSHei20zyUIJ6jAwPxx2CaxHWFR7e01IsoT5tEAXnwvBfUnCxOogqnG+ksehZLOwQDo5
 kijDjxrbUUUgsu0gmiB4+zlbTBkxkzeYLsgMoojAVgAJ50oXJtNQboBTyZVjKb0wHgSpCyKl
X-Authority-Analysis: v=2.4 cv=Hth2G1TS c=1 sm=1 tr=0 ts=688b3767 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=1f7UYZhOQBCSuS8GvGYA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: _l30It0p1V8B1yQ5KEFqPOLIRUGGRS8z
X-Proofpoint-ORIG-GUID: _l30It0p1V8B1yQ5KEFqPOLIRUGGRS8z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-31_01,2025-07-31_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 mlxscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 mlxlogscore=999 clxscore=1015
 spamscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507310065

On 7/30/25 6:10 PM, Akhil P Oommen wrote:
> On 7/30/2025 7:07 PM, Konrad Dybcio wrote:
>> On 7/2/25 11:13 AM, Taniya Das wrote:
>>> Add support for video, camera, display and gpu clock controller nodes
>>> for QCS615 platform.
>>>
>>> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>>> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
>>> ---
>>
>> Bjorn mentioned offline that these controllers should
>> probably have power-domains attached to them (perhaps bar
>> GPU_CC, that's under discussion..)
> 
> QCS615 has an rgmu which doesn't manage gpucc. So this is a different
> case from the other discussion. Are we talking about scaling mx and cx
> rail while setting clk rate? Downstream clk driver does that on behalf
> of the clients. I suppose you are not talking about that here.

This is also relevant, as pmdomain states are propagated up the
tree, e.g. if we have:

usb@foobar {
	...
	power-domains = <&gcc USB30_GDSC>;
};

when someone calls dev_pm_opp_set_level() (or something equivalent like
dev_pm_opp_set_rate() with required-opps defined in the table), it
will set the performance state of the GDSC (which is a NOP for the GDSC
itself), but if we have this hunk:

gcc@feedbeef {
	...
	power-domains = <&rpmhpd RPMHPD_CX>;
};

RPMHPD_CX will be declared as a parent of all GCC GDSCs and its state
will be altered too. See:

drivers/pmdomain/core.c : _genpd_set_performance_state()


TLDR: clients are responsible for ensuring vdd_levels are set

Konrad

