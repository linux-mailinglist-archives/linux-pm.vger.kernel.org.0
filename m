Return-Path: <linux-pm+bounces-21840-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6DCA30E7D
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 15:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 309821889FB0
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 14:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015852505C8;
	Tue, 11 Feb 2025 14:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HBMzsjW1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EACF2500C0
	for <linux-pm@vger.kernel.org>; Tue, 11 Feb 2025 14:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739284592; cv=none; b=YVPq51mT9fMSXNjr+0CCuiHLMGzXnjke1EbgYQc8hHqmYNWYdx4Bt3vdG+rS9hAf28RmSTBoyS+yBpyBSFqzV66i/iuuU7FGPkEYq7T4e2c+sTWOHCTeumq1NVMGi6mUn71Sm4Q2M9yS6Jvo34M3uBiJs28BYwdCThbksH8ovDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739284592; c=relaxed/simple;
	bh=7Ii4oZkOZGYKE3BZdy/K87x7eC+Q8/Yg8xmakzI1XRA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fGON32bflNihMFeXPIwovqzaLj5x5WmLzfPWCo7t9+34elPCIVApWEINhavGvUKGe6o+seCdU4accZj4VwfRJFUZwPhoZLCpnM1AfM6ZlDVMTU1p/yZ8hjmZ3MOVOrzIGp9I40/QR1/lpSErA4OpK1x1RNbsyJhacjgXDeCW4ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HBMzsjW1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51B9sZt0023203
	for <linux-pm@vger.kernel.org>; Tue, 11 Feb 2025 14:36:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	D1WudjrHqQFLXTx6wDZ/8frFhEy4z+ON8ytd3oA/31g=; b=HBMzsjW13/L3niYb
	J/VObtlRmyL4aGLwfXV0eupMOupUvNloVngCbuuuB/c6Irsv4cHefNX/PURZgfWR
	8FnfAiAP1no2lFdB3EcEHOkeyJt4s9TVztSeY43PkuWanNGguzrqIsDE+lNPvpzp
	m6lKjM2JUetNKwCdLZ5ma7okY22rdbWd8zjQ4i1pKxun5hqobdJG6eHYtDHfIVGM
	oNINsP3V9lxnrrrkSsXmIzdWXOui6Wkh6s8DNr/4qRHp65L/vCrFEljxYp/zLQEY
	CbjFwuraDCG6sENmaMTZxyY/TCK910MOqwqoEpm9p4keuRq/Bs8CzyP+lDGx1dF2
	lhvE/w==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44r4b5rurm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 11 Feb 2025 14:36:30 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-47181a14d8bso9672661cf.3
        for <linux-pm@vger.kernel.org>; Tue, 11 Feb 2025 06:36:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739284589; x=1739889389;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D1WudjrHqQFLXTx6wDZ/8frFhEy4z+ON8ytd3oA/31g=;
        b=ic8qI73aSSsBqZux9lXRTol+P6RfhExxNvZuEOAUOC4egWfnHKt9Fj8DuiYjuG/0SB
         /YvbdWEGehk2XpNOLjOrH5ntBKxtqJcqI5/TxHx2vLq7cS7GBqiz5Bz4XdWQxmAeoi+R
         9Dsw/DjWtpeG6rWihSmbOvjphlNC5W/KeH94quVPxwWvJo+nMH/P49G21dcD83XXlzSJ
         1h9m1Yz5sHWhrw6QhVWtkcF5yb/Ys2ePctE8CENmmkI7GcbX6d1adnz+rITDU27ym5AB
         3+N6zSFr5cmVdwBzdvV3g1hi5c9nnIfWidpp/6mxKwRiy5INQKhvpnChH8RalZVRaY0A
         GjxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbOldVCFAQbQHsQdsdfrkruI0rLU5rA2W4xe5WnZT2ouqcWnMlaJvnd/j2lmLLqi6i1DxnKRZOhA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzuVo0DA3w8NpGEgxCJaGtcUcMBRok2i1fRLi0mbZKu12JThDRk
	AAWId5Rz7nQD9SsVjLkQSVBBwLj1/oYaa19hUml8yF8aUrD0zVfzd3fVQ3OTPLQ1BOM/Zk8CyZn
	aJRMfdEP3QYir0s3ELP9jvgZsiTKK/ZCI9y7gI4kn4Itw0LWFnzifzkgkJg==
X-Gm-Gg: ASbGnctWdMP+E/BijOAnq3cOsucOtVu5YtaMBh1x0StLUDQmxJrl76wTn14JKewEVLD
	yS58lHFYW9VQfpUbXPS4HHWQNwBZmaBn/s4kRLCaPaCIvEkwKEp91kN7h+O5w108Znm4/aNGvgP
	w6vaiKya7wm5MMbN97U0YBeXs+wuQpRU6/5fvt4lme1n/uS72vB2/vW2SfhtrvY5yBSeAofhDtQ
	IsbySteF2N849kgnfkqgcW6+yMT1oiOhsH81chQWwbXJDAb3gQf254jsr538EdM5Hm5rEa8mCgJ
	7BUkjbYC7jAeB18fWgZZS+sRtNC+5P/sD3zRQpMPojX6shgZ+MLVuzYRQmM=
X-Received: by 2002:ac8:58c6:0:b0:462:b46b:8bf8 with SMTP id d75a77b69052e-471a3e28ffbmr13331821cf.14.1739284589379;
        Tue, 11 Feb 2025 06:36:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHBtd/o9zaPUcZSBSJqeNb6V6jDhonTEpK4kvS0kO6RILTzAgiYeOe5mvtHYLZNwbNqBaucQQ==
X-Received: by 2002:ac8:58c6:0:b0:462:b46b:8bf8 with SMTP id d75a77b69052e-471a3e28ffbmr13331531cf.14.1739284588932;
        Tue, 11 Feb 2025 06:36:28 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7b4e96185sm521953466b.86.2025.02.11.06.36.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 06:36:28 -0800 (PST)
Message-ID: <13f7d30e-9237-4a3e-b9a7-0c667b3e77a8@oss.qualcomm.com>
Date: Tue, 11 Feb 2025 15:36:26 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V8 6/7] arm64: dts: qcom: sa8775p: add EPSS l3
 interconnect provider
To: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>,
        Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Odelu Kukatla <quic_okukatla@quicinc.com>,
        Mike Tipton <quic_mdtipton@quicinc.com>,
        Jeff Johnson <quic_jjohnson@quicinc.com>,
        Andrew Halaney <ahalaney@redhat.com>,
        Sibi Sankar <quic_sibis@quicinc.com>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250205182743.915-1-quic_rlaggysh@quicinc.com>
 <20250205182743.915-7-quic_rlaggysh@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250205182743.915-7-quic_rlaggysh@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: imvADMgL-8ujY6tlsZ1Wr76247nJEW-Q
X-Proofpoint-GUID: imvADMgL-8ujY6tlsZ1Wr76247nJEW-Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-11_06,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=999 lowpriorityscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 mlxscore=0 bulkscore=0
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502110097

On 5.02.2025 7:27 PM, Raviteja Laggyshetty wrote:
> Add Epoch Subsystem (EPSS) L3 interconnect provider node on SA8775P
> SoCs. L3 instances on this SoC are same as SM8250 and SC7280 SoCs.
> These SoCs use EPSS_L3_PERF register instead of REG_L3_VOTE register for
> programming the perf level. This is taken care in the data associated
> with the target specific compatible. Since, the HW is same in the all
> SoCs with EPSS support, using the same generic compatible for all.
> 
> Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

