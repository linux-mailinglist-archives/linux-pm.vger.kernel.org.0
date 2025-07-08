Return-Path: <linux-pm+bounces-30353-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E15AFC7A8
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jul 2025 12:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5F79189C71B
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jul 2025 10:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D8B268C40;
	Tue,  8 Jul 2025 10:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bdVbT8xq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAE81C84D6
	for <linux-pm@vger.kernel.org>; Tue,  8 Jul 2025 10:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751968871; cv=none; b=VHyHWbWDN23fCviEEVeWn4MlTpjHx2E5UGa0VJUipfcIJyQP3aZvxWeTcRyTs78CsyIYud3wZL6Ye8BKOspEhTc8O1+3pGl+aqChpVS7jkUAYlzpUCyRg1rF8Z7JT9QRmsPaqYTdt9MMC0CRA2l8dwytgkeWOdJRoI/T4Tu0PTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751968871; c=relaxed/simple;
	bh=gJEle21HfeHRg/MyaaNCJjVlwd7x02N2SP3mJGzdmA8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XbiykDudUnqIWoEWr3QiEfZXlEQjCb6rF+QFYO35st7OFtrRclCbWt6p34ixvVMWKd2HytmcjU4PMM5XMvx10q3Z2g333tEUvb9hErjc+CMhnyHIQQn6YrCIqMH6Q9+wLs83p9rXgHg+IdjQuzgIF6z5LU1uGT26gZ0EuEeQZ5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bdVbT8xq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5688DbTx018593
	for <linux-pm@vger.kernel.org>; Tue, 8 Jul 2025 10:01:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	483dfQ545JlIrRhF6KMFjkkyxIpCkMi//ibR/zkJguU=; b=bdVbT8xqpQH3m75O
	kynfN+zTI0/3Ha2t48Mhs3Ncra/8lFCR53hNi7IdS1EAhjKhsW/T/p218vJHufPZ
	jMMhmnbDq7Dqxt4JgHqNs9WdIodT75IACmOPPWn3xz1r9V+kDN6/5QsoL1JmpOPT
	y88lyIb0OZwB8In+apHaSGgokWOT8FmlMBqbQTxSImnyVI4B9iQTwlgyvb1FZcYm
	n2VKgz7M1No/U/ITNpdEBbYjgCmQYtVFlOKYgfFbt3VU59GlEak3ztVSDBXqeoQC
	2ThtpaF7sQw023226bPrj+vLkCyNk8uk3+eQHcEYgH62uayBDcD3yqLucXDBFAsM
	T+JBmw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47psrkm3df-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 08 Jul 2025 10:01:09 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4a43924a1bcso7393761cf.2
        for <linux-pm@vger.kernel.org>; Tue, 08 Jul 2025 03:01:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751968868; x=1752573668;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=483dfQ545JlIrRhF6KMFjkkyxIpCkMi//ibR/zkJguU=;
        b=EFGyO3XkXV4BjmDi1UTB9QOpZ8vDKcCDAxQjfjERvv0gOEtLvFzyVMQ3OEzcSmTnm/
         GilCxNGvJPfP5qUsTEqbE94V3DAGk1ctuFKcEVIkME0EGe3GpTGLlo1+M/GAOOef6i70
         AoqHEjIzIrAaN6SzwSTsStEokRWs147EO/J7fEJsVXBiY8SZFMrDxc28wtUOGr68X+Ma
         3dSuHVtUBMqSx368tXcGu6LJ8NGA6eCCX7ZQct6K8nunRrU55i038vbvTDNbKk7qI8vt
         RmwXf/sZ4j9aBSNzWT/pL5KdZ5gzFGzP6McL/8Y1cJlrc4AUhddeVoKCW9ON3RtK6BJK
         7UwA==
X-Forwarded-Encrypted: i=1; AJvYcCUhqZbukarvCUP32JwiSsfd4NseM+UiBPFcbHmhfS6Pfq2HtgYU6i9uLLHbPwRVpxER0sh0NabsTg==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa/wdzcLUDwlZadMUsLiRgoYS9ezv3E0MkMctKKN+e6Uyg5KhU
	P1kW2NgdCjKrSePKkDopVQv2we3PFUSDBidOxg/NLkdAbIIXftbwr1+Xa8L7REK+H4Pooo2UW7R
	smsDj3LKwNFY5HIaQuawAvSdTvJ3AwjVj+HEOyZ/ad/mTy4GTA0cDmsagMMu3hA==
X-Gm-Gg: ASbGncsZuzUzz/Qupo/Nhdhk3ps3zZt+cQbPbjdqRWP+pCMJ0XkLk6TSqeLDUtJFQZn
	tjrZC/7N0glQqa1ikEKWlvqp8fHvtooiL0KeOdiSXUx0ifEX5NvLiw0MvPDGG4z2VkavuMy8Dza
	xInWBYsasD2QB9f6+KnoSg5/yBq0VdD1OfUWWBhDhXwbCnG7XDA7mQ9ugQqsS/xfHibIu+xOWJ7
	tV71vVZwhPd6IBSiL5AMEvjekb/k73kOR4UM5fDxscXWD4l02z0BzY1xbFZXWsJNd+jYQnXVJOV
	LOFfux/AZHCSMDxdkbT3gwgXuCgUxB8zn89RNfiBcHDud3OIALbZhEpJKXmQ7BSN/4a0uSc/4L5
	z/DM=
X-Received: by 2002:a05:622a:5792:b0:4a4:40e8:6e23 with SMTP id d75a77b69052e-4a9af1cdd94mr55938131cf.2.1751968867500;
        Tue, 08 Jul 2025 03:01:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZnC5Cdjb3gvmhNxFzfuEuiFwvA9CntFLERXntN3Kd6tNI1FJYzPO8V5RedGFE35zBoCMnEw==
X-Received: by 2002:a05:622a:5792:b0:4a4:40e8:6e23 with SMTP id d75a77b69052e-4a9af1cdd94mr55937961cf.2.1751968866897;
        Tue, 08 Jul 2025 03:01:06 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae411a5429esm634556866b.16.2025.07.08.03.00.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 03:01:00 -0700 (PDT)
Message-ID: <044bdfc9-85df-4f03-a4f8-8ef1717138dd@oss.qualcomm.com>
Date: Tue, 8 Jul 2025 12:00:55 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] arm64: dts: qcom: qcs615: Drop IPA interconnects
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Georgi Djakov <djakov@kernel.org>,
        Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-clk@vger.kernel.org
References: <20250627-topic-qcs615_icc_ipa-v1-0-dc47596cde69@oss.qualcomm.com>
 <20250627-topic-qcs615_icc_ipa-v1-1-dc47596cde69@oss.qualcomm.com>
 <20250708-amiable-owl-of-enthusiasm-e75662@krzk-bin>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250708-amiable-owl-of-enthusiasm-e75662@krzk-bin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: D2K1cfwDFfmPNqkuR6WD-ogJfNR5ZTOw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDA4MiBTYWx0ZWRfX/f0wlGzL5rjZ
 QKw+mHocFXiwLdXZom6R06fVNmKgo+EhPBYaKXMYe5YBTpMLPfgyuu/GLwTPl40qAFH3u004O/1
 y8SMiVvh8PAw7eQdO3tWDywy1H704Fb8GF9GLh7155Ttl8UImhSsxkh9ofz4ICGAc5Zl9BQgwR2
 yW0NVQfdG9MJiIVp+1pyjYr/+jvNaDEN3/3DEPgcu2/SVTivM6Ad+aCbRVBrGpOUb4qHlqZ/Nhi
 8EfVHPLN+/iGDntE1RMRuTgxmrOVspQdbxYvtcvOKXlCPiGpnlnyUTOSgc4jRvCHAe1QiDR7XDW
 6UwAiFyVwE3/eTvTBdoNff/i+5sRGnYc+oReFopD0XgkdGnnzQxu3Df6fELrzdNAr86mMyFwPJK
 8pypnrAs4e11WVAEeNeKEH343ZHRTpTCgHfJg8oDlmR7BbiEWUTPFO1RuLyKmvM9SzXvPuJw
X-Proofpoint-GUID: D2K1cfwDFfmPNqkuR6WD-ogJfNR5ZTOw
X-Authority-Analysis: v=2.4 cv=GtBC+l1C c=1 sm=1 tr=0 ts=686cec65 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=mnq6psiAt-L2oik7x9cA:9
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_03,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1015 spamscore=0 adultscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 suspectscore=0
 impostorscore=0 mlxlogscore=954 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507080082

On 7/8/25 10:51 AM, Krzysztof Kozlowski wrote:
> On Fri, Jun 27, 2025 at 09:37:55PM +0200, Konrad Dybcio wrote:
>> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>>
>> In the same spirit as e.g. Commit 6314184be391 ("arm64: dts: qcom:
>> sc8180x: Drop ipa-virt interconnect") drop the resources that should
>> be taken care of through the clk-rpmh driver.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>> ---
>>  arch/arm64/boot/dts/qcom/qcs615.dtsi | 6 ------
> 
> This is non-bisectable and breaks the users.

Of which there are clearly none, as can be seen by the node not
being referenced by any other one. I can add that to the commit
message.

This is actually as bisectable as it gets, since it goes out of
the way to satisfy both compilation and dt-bindings checks

> Should be the last patch,> not the first, with explicit notice that it must wait after the next
> merge window.

Patches to all three subsystems can go in independently to their
respective trees (except maybe icc bindings going in before dts
could spawn a dt-checker warning)

> Plus this affects all outside users, which also should be somehow
> explained. "Spirit" of some other commit does not apply here. These are
> different products, different users. It needs its own rationale and
> justification.

Yes and no, you're focusing on me referencing a different commit
while I included the same rationale it presents later in the
sentence.

Konrad

