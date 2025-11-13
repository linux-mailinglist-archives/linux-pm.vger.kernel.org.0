Return-Path: <linux-pm+bounces-37958-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46187C57DDA
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 15:14:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4DE7422E8B
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 13:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F77227BA4;
	Thu, 13 Nov 2025 13:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AoXCpOsh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZVDKwEVA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6958F21C9F9
	for <linux-pm@vger.kernel.org>; Thu, 13 Nov 2025 13:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763040855; cv=none; b=mWDaiA23qFCGOW5ny54yqhaXZgDrWTb1Vo0ofoHHQZTFa1zsW0iUQLgW5OG+Z2mS4fx01NiazzueJMs985+LJ5NlUwcHdkfWc0cYoUPu0AG89AvhlCuNfk8yBCL9/16J191S2NCEcy0+KPwndFIxy+sboy3tZMKOPW5GIayZdoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763040855; c=relaxed/simple;
	bh=+IP1XudSJ38VP40JgyddsTiDM+XvNBXWL/m/zF2pMPI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ciQnWNDfYd+LA+N6kcIDmkA66x+iJczFk/TWI7CpXKKOTB+L3Rafi6AxmVs9EtUJSpZfVk53ch7mVnjKMDzb/IcDVqqMoq40pEpyo+5CWm88htj6jjvjFg8p+c50wLhbQ8nfD9kOjEl2wiXfnXVxfjUUhsAFR2r9pRwN/mDAozM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AoXCpOsh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZVDKwEVA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AD6r0YU3874028
	for <linux-pm@vger.kernel.org>; Thu, 13 Nov 2025 13:34:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KlFdoAYM8/VYA6GdFSWsSZk5wCZjObFXEKG3Wx/Bryk=; b=AoXCpOshHgJsGACk
	5F1dN7j2MoHce1jTJtQArpaZPZ4MTlZ6HHWccKnw4gKbc3XLPchPWL07hOce2H1/
	jDiy4M2lRMMZGXZ7sDUvpbBHZOWorVaEXgq/xwLud1IXwYQTOhExf9hOLg4yExyS
	h9Eh4BTTAWfq1PSfzWNp2Lmy78wRc2PyJmMT3UIm7W0kmXTdf33Xaq2A3hTUCwiw
	JV1o2HKgRqp8JMYtG7nXk7wOwO6JROBgBlLvBSZvCux0RvhTE7xWQBFnEW6dSYuY
	M21QQQO/9as1Wp9HjTv/11VgU0cDqqc6RicHCIN07Xnk96gYA2P5WSlMiHxFjfqL
	jTqTEg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4adaeus6dc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 13 Nov 2025 13:34:12 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4ede0bd2154so2019721cf.1
        for <linux-pm@vger.kernel.org>; Thu, 13 Nov 2025 05:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763040850; x=1763645650; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KlFdoAYM8/VYA6GdFSWsSZk5wCZjObFXEKG3Wx/Bryk=;
        b=ZVDKwEVAWQmhfCHe62RSLVq/JQZZ/YSGyIuH4pE35mjxXfbWSUpXgMWkh3YF6/56tS
         XjN0k2prdAwujWQtTmtktQrb6DX4YsuhOR54oOqtSWcVk7QKTvAkSBt9IMUdpmiCioyp
         NGNqo2Uh2dn0sJHJyDdgcAraLdAJZgAsZydrOUYop7nryyIr3G7C74cgg48XySwdysu/
         MWRyC7XUQMCPQlW4B6WI9YYWfxYWT/wk3YTVMwQayqKqKxTewvhzgQeZaGbtUctO12iw
         aRcvl3tICh/1JwcyWd5FGhE5jaIFB2ztzlAgRDNKXMqyqzA0CDYysqZYnjiXUsp/0N+h
         KFqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763040850; x=1763645650;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KlFdoAYM8/VYA6GdFSWsSZk5wCZjObFXEKG3Wx/Bryk=;
        b=fxhlevKTnQujQF5ybnJExEhsQqJW6VR27GyIBn+1DWlsaLe3VeCFZtIVu1MZd5bYdj
         rMRHBqK0qZZNwazAi+TM+DidoWultf/FaMWkWp7AuSY/Dj1hy1w5tZFDF0y0zfIhaR35
         hNInvqrl/t1Raigu0WFFuyI/V/VmiVCpAsBKCeqDep7UnUgbRrAy2oSgoz1oZOLuxslZ
         o4cdz/vyfI4VPfJ5/rgH/2n67lN6YeohwiXuoDeM66Ccir4WvVDN2ptMIENcso2E4PPV
         R+2eO9n8Jb2UwjWFmoKySeBSE46qIMpCSh7HJAUJGwRaTV0r7fJSWQmjg4dZz/Ek0Ryt
         ru5A==
X-Forwarded-Encrypted: i=1; AJvYcCUgf4jUYrjXSYxWz0sNDjtN0pXGS2l507FyagQhH3ZuMGF4EN22y521KKecvVJxpRJVrH6UrXyRdg==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd+d4hpM818zJ8no+/em+ONXy3cSjr893IA+xuHw8LazG+E9b6
	b8UDgVFKgmEmix+5p1smkM4vmplw9ps0XeJFmenGwUoGEgziHe4jHH/B0QPQaX3ltd3ygldhoen
	AoZ4E6JU65wzOLyrsqelGLaP4T++8L1KQegFwNJ+cnzFoCQdLnv8PjDmaemJ6cg==
X-Gm-Gg: ASbGnctEFgW/Dtx8yKSvVbwVTYystlr+c1KCRAGgWfXdbL8o4Hrcd6v9ZYTKU7ePF7X
	NDDuLhCmy0tatDiWkLAdGRungmuvJPA84BTl8On4AlgCDDseBGoadtS1JIVXLWjiOI/u35RkHtX
	rr21yLhwWWFIj0Ia7etnsxVMlVuwEyf0c0Vw6RU9f/oLiF3oYkRdMrxMQC/wm7QuHZJW+T4Mgua
	TlmePSreX2j6NkdNWAUaz5V3FSdHn4Xwsdia1RWumVn1TJ6e67f2S1g8jwP0xp9rNitDMvFree1
	TINB6uH+bPEt7z4D+GamqJD7clZTQ94PgqTaZ5kOdbznGhf8AovFZ0WepanmGUUjYcAIRsZKvhv
	DAVSVyZ30WZtlKJ16SvtJSYV/NjPGEGsvQuGyVLlFZBc0Hiv3/qBOv2D6
X-Received: by 2002:a05:622a:148d:b0:4ed:b2b1:18c1 with SMTP id d75a77b69052e-4eddbc9bff9mr56111011cf.6.1763040850203;
        Thu, 13 Nov 2025 05:34:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFPE0sRVrglN3s1Wc42f/OsKVhH+8tSWcqanaQmO/9xNP7f5H7iuIa/iIFmPGwOU/XlckjLYg==
X-Received: by 2002:a05:622a:148d:b0:4ed:b2b1:18c1 with SMTP id d75a77b69052e-4eddbc9bff9mr56109611cf.6.1763040846925;
        Thu, 13 Nov 2025 05:34:06 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6433a49806csm1453196a12.18.2025.11.13.05.34.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 05:34:06 -0800 (PST)
Message-ID: <f433a645-5af6-4813-ab76-687d1ce22b0c@oss.qualcomm.com>
Date: Thu, 13 Nov 2025 14:34:04 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: interconnect: qcom-bwmon: Document Kaanapali
 BWMONs
To: Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com,
        Amir Vajid <amir.vajid@oss.qualcomm.com>
References: <20250924-knp-bwmon-v1-1-56a9cdda7d72@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250924-knp-bwmon-v1-1-56a9cdda7d72@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: o2re9DcZ1bF6BY7zttJ1tlKYEs51tNUS
X-Proofpoint-GUID: o2re9DcZ1bF6BY7zttJ1tlKYEs51tNUS
X-Authority-Analysis: v=2.4 cv=JPI2csKb c=1 sm=1 tr=0 ts=6915de54 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=mygda9kbUFeXYpHWPk8A:9
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDEwMyBTYWx0ZWRfXxk56PvjQS4D8
 9VYx9jLbS07DALJQt/hGKQTJ39GKYk7rFCCCQomsVAF2BDT0tnqz2Gp3dn3gPJZLBtpnVfIeR8K
 TkSYYuwwlAt9oLuCare4jzARuiwvIK4+jJUWvCrgoL3rfzVs16hZ0jJQ7pjIz5xzZXlTxcBDJRT
 kOEAc/LffkznFiktwzKdDC98gmi7yK3Z8fAUaGeXbBMocDGk6i08XhzXpp3gOh93Fn6vkr96qy8
 aF/ZYMuSX9GfpvesgCActDbq4ux0zrIgwFthklf5Qya5szswILMS7UcOm8BGiqaRHDMJnYyGx3N
 868Ay6A02ueMIgGzyql/RhJNmc0zeD5wHf8Q1QGRKa/v4IXx7YebvHzlcqYE3vK5WyyYkYYvw0L
 bv8RzpfgdbU/qHieg0Wj9kV9hz4RAA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_02,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 spamscore=0 adultscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511130103

On 9/25/25 1:25 AM, Jingyi Wang wrote:
> From: Amir Vajid <amir.vajid@oss.qualcomm.com>
> 
> Document the Kaanapali BWMONs, which have one instance per
> cluster of BWMONv4.
> 
> Signed-off-by: Amir Vajid <amir.vajid@oss.qualcomm.com>
> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

