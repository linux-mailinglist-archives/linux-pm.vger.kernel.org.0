Return-Path: <linux-pm+bounces-30361-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 808EFAFC9A8
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jul 2025 13:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7E7E5649BC
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jul 2025 11:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56B62D97A0;
	Tue,  8 Jul 2025 11:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gwwrNEEy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429042D97B5
	for <linux-pm@vger.kernel.org>; Tue,  8 Jul 2025 11:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751974305; cv=none; b=qYYENXHMpAGg4wAln+0hYaksuRLOJAWPqbNz6oUeihbqBvI3RGt+95C0T0/Rn4LfNerHGbfPro/9VUdPvgeBCNzI1wR9IljOQTwTtCnewPf0SgthSQVaMFu0dd6RN7c6GK1i4kfCQ+B0kmZZgae+HCkvUufdcCMK1ykUpoWHZgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751974305; c=relaxed/simple;
	bh=P+pxE6WaqJCtlIPhTde25jg4Wk2SpGFNRRq9qAcfinM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xyj1KUSeGiK4mqjK14pOtrLFe4PIbUcYZrrqI5E/RbM4OeDfW5S6W9lyFEJ7dBG/cHbj+YjmQrcNQywBpNhQ5jo0Yi7dbiOIY7NbbIH3hvMg5bliYqsISfvT/w3Ti5iziDyP3Nr6m9i/rNTnY0L5nsF6/FjfX5EfZ8IOG6FmP6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gwwrNEEy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 568AAOMe012091
	for <linux-pm@vger.kernel.org>; Tue, 8 Jul 2025 11:31:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tUm412BRbW/zHRuNnheSl3siSXwcdOp9rqnr499LK+U=; b=gwwrNEEydC/VFkSE
	C9qBwaEMdqlXYh4rJWV0wz/+oWpfv9sNEJXK9zzL0X4Hczchu7ChsdPyUZIUdR/W
	jcs4TMcTD/El9/mQrM6qtxA1/WeBEy+TWFBdf0/ghZ+SEzBkfojs/sB6MT1KKwy0
	JatNFxdvM5HNWmhD188G0QK1d0/KkpPRWA5+rvZAPrQWLvZ4KxuOviRze5OsYhdO
	aySsDEJYrWiEnxkc3jp4Qp4b85kkLURUgwdXyeG1qx/uFPJYRsicHT2/8vlx/bRu
	FXKNoDjMpYYYPCaoZh54WoO48OV4YBZSxt4QjZmvaY+YjeBCYfxiHZ3rJ/HMa3dv
	knAAxQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47pv97mgns-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 08 Jul 2025 11:31:43 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6fac0b29789so14280806d6.2
        for <linux-pm@vger.kernel.org>; Tue, 08 Jul 2025 04:31:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751974302; x=1752579102;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tUm412BRbW/zHRuNnheSl3siSXwcdOp9rqnr499LK+U=;
        b=c/Eo7qGURIPKm+QhcG5Wh9QBF/lS7SCSYyN4s/xwWtbzdQqDibRFhtewPURktEYwSb
         JPiD+OTa7WDb9pvVP9ix4NrY33kReaSz3R2/IffiDL68ruMtO4YUYmKW4Zfa0LrHcJy6
         nUYp8jkdCSCuTSn8dB/8d/rEFq5AyxQhhRFDrvHIAjyyhrJ2owvFMNMwiTLLPcKmoVY0
         qor8sWFOK1ae8ZZnUVMmQsz9wIHG1G+ZPhscvE9e8GADxIBHI6MHMhxwxxM5XMWFdn5/
         EuFLECuLu+m3k1aiQ+x+PCWfe79PWY8hXliofqGGpJ+OctfZhsLhmbVUgVyQAUj7tuuH
         J88Q==
X-Forwarded-Encrypted: i=1; AJvYcCXQ3gimyRDK0gp9nrfmSg6ZYDfNoSY6gjCMekY0oFsWXyOaUAoJjnBYd3f/9HRtwcLFVys7qmG9bA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxP5a8RrkDD+48829lOVame1ttA3qsDfvXIVZ6BkPmonzRaoozQ
	z5tHSlomVgaJZmA6ATR85nTXA3qvDMqFz+1bGvQXr4VcXMFUS1MmyfNjnr+5h8do1sqNmEWoPF1
	R+jtVfrsOAcvOJCsbMb2wUSsPzmYInwyUPzjFDuuRGMKx/LfkVO1RYdggC/ZvHQ==
X-Gm-Gg: ASbGncu03Z0TcNBNC89dDKHBCTOAIkFWxzg95mwQOxjaarNVKqR2jHEucm/K+uIZLXa
	ulZN5PPZCICru7lq+COQuuYt/SpzGB6wk+UR54QTo8SAO4K+EXTt9HYF9AuYGHCeW2jqbL4cKEG
	0GIfU3hCIwv9bYncCMg2UuIJzmz9pdqDG6LBHF4WI8SXuVCUzL6eVWOvSazp5Uxfo1/WTk5Sp4a
	tlnQAB1KPx6hV1CM+MX85+SoGnwvuOW56FMQllGSgNfuUiDcJqS+jsygoY/UOjzf62CPBSpjgnQ
	JkISkyJYbL5eb+a7SZNAnS9y3QIEI/fzSPLsHPQotZEdwEcVey1vMaRyEQ9gqmBYhfyr2QOQVHs
	pZpo=
X-Received: by 2002:a05:622a:34b:b0:4a9:8e6a:92c3 with SMTP id d75a77b69052e-4a9bd3c3284mr46378541cf.11.1751974301883;
        Tue, 08 Jul 2025 04:31:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXS7HsMKzGHLe7mgZx4hB+HHWETmL2VAFfFIACPNdmtmlGbyoflOmhdiXYt3hmPsI2vMpoEg==
X-Received: by 2002:a05:622a:34b:b0:4a9:8e6a:92c3 with SMTP id d75a77b69052e-4a9bd3c3284mr46378351cf.11.1751974301243;
        Tue, 08 Jul 2025 04:31:41 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f6b600ddsm877212066b.158.2025.07.08.04.31.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 04:31:40 -0700 (PDT)
Message-ID: <97074fed-7b63-47fe-90be-4161a4c7a297@oss.qualcomm.com>
Date: Tue, 8 Jul 2025 13:31:38 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] interconnect: qcom: Add SM7635 interconnect provider
 driver
To: Luca Weiss <luca.weiss@fairphone.com>, Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250625-sm7635-icc-v1-0-8b49200416b0@fairphone.com>
 <20250625-sm7635-icc-v1-2-8b49200416b0@fairphone.com>
 <3f8bcecb-4c5e-48b1-98be-96f3c0c8329e@oss.qualcomm.com>
 <DB6LPBOU5TDL.13B4A6U4NQQZQ@fairphone.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <DB6LPBOU5TDL.13B4A6U4NQQZQ@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=FrUF/3rq c=1 sm=1 tr=0 ts=686d019f cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=6H0WHjuAAAAA:8 a=qFGWVYr3AIIjfRM7rNMA:9
 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDA5NSBTYWx0ZWRfX5nmbYdjbnDxv
 zRmcVa288mj9FzfHEshdI+lIw+zWbu53CPY6clz8CIoIMlV3XYBIK15qd9y6P4bwqTrcQbKgb0Z
 g/BQgYkP++QTD1voMxUZY138FodnY852GvHBRMDghPLPkOEkp/dTBSj+i9qd4GQSmSU8VlAOBsp
 xmhS3mfWqifFCZ3M64oOgGmNpf0z4Xdnejte8/9m4rFWe3bESil/x0dqsc3oiDAVxpX2G4EpHn0
 A80J+e67iodRD7laVi2QMEsknlmgQZUkpAYq5CzQxIvO/sZu0P06qHCUhA7S4a/P2lfIUjKJube
 iRfoyNg5/db5r4HZcVjXQ64yPBV7lqJH5rZq29WRwVRGczG3C0f3WimHdhinoNR+vYeCeTp587a
 Lk190Frr6nAK/z4naeXS32BZWwhdx6cYC9OA9nlL07+kG0an072e2zJIwYIbOUIKQjcwR/Q3
X-Proofpoint-GUID: MwdLb83kgpfxeVqCD7nUkZsqeXVMTUSC
X-Proofpoint-ORIG-GUID: MwdLb83kgpfxeVqCD7nUkZsqeXVMTUSC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_03,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 mlxscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 adultscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507080095

On 7/8/25 12:28 PM, Luca Weiss wrote:
> Hi Konrad,
> 
> On Fri Jun 27, 2025 at 2:48 PM CEST, Konrad Dybcio wrote:
>> On 6/25/25 11:13 AM, Luca Weiss wrote:
>>> Add driver for the Qualcomm interconnect buses found in SM7635 based
>>> platforms. The topology consists of several NoCs that are controlled by
>>> a remote processor that collects the aggregated bandwidth for each
>>> master-slave pairs.
>>>
>>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>>> ---
>>
>> [...]
>>
>>> +static const struct of_device_id qnoc_of_match[] = {
>>> +	{ .compatible = "qcom,sm7635-aggre1-noc",
>>> +	  .data = &sm7635_aggre1_noc},
>>> +	{ .compatible = "qcom,sm7635-aggre2-noc",
>>> +	  .data = &sm7635_aggre2_noc},
>>> +	{ .compatible = "qcom,sm7635-clk-virt",
>>> +	  .data = &sm7635_clk_virt},
>>> +	{ .compatible = "qcom,sm7635-cnoc-cfg",
>>> +	  .data = &sm7635_cnoc_cfg},
>>> +	{ .compatible = "qcom,sm7635-cnoc-main",
>>> +	  .data = &sm7635_cnoc_main},
>>> +	{ .compatible = "qcom,sm7635-gem-noc",
>>> +	  .data = &sm7635_gem_noc},
>>> +	{ .compatible = "qcom,sm7635-lpass-ag-noc",
>>> +	  .data = &sm7635_lpass_ag_noc},
>>> +	{ .compatible = "qcom,sm7635-mc-virt",
>>> +	  .data = &sm7635_mc_virt},
>>> +	{ .compatible = "qcom,sm7635-mmss-noc",
>>> +	  .data = &sm7635_mmss_noc},
>>> +	{ .compatible = "qcom,sm7635-nsp-noc",
>>> +	  .data = &sm7635_nsp_noc},
>>> +	{ .compatible = "qcom,sm7635-pcie-anoc",
>>> +	  .data = &sm7635_pcie_anoc},
>>> +	{ .compatible = "qcom,sm7635-system-noc",
>>> +	  .data = &sm7635_system_noc},
>>
>> One line per entry, please
>>
>> In addition to what Dmitry asked for, please also look into porting
>> QoS settings - those will require additional clock references in the ICC
>> nodes and as such, the bindings will be altered (which we'd prefer to get
>> right from the getgo).
> 
> I've forgotten to do this for v2, which I've just sent.
> 
> But we already have the clock references in the bindings, so the
> bindings should be final, also when QoS is added, so just a driver patch
> then.
> 
> I will put this on my todo list for a future patch to enable this, if
> that's fine with you.

Well I'd rather see that be done from the get-go, just in case there's any
surprises (e.g. downstream may not describe all the necessary clocks, as
some were enabled by luck or so).. that bit me in the past on some other
platform

Konrad

