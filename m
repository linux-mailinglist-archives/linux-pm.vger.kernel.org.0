Return-Path: <linux-pm+bounces-42861-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iE08JQnYlmktpQIAu9opvQ
	(envelope-from <linux-pm+bounces-42861-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 19 Feb 2026 10:29:45 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B585515D5DC
	for <lists+linux-pm@lfdr.de>; Thu, 19 Feb 2026 10:29:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 39BD83004069
	for <lists+linux-pm@lfdr.de>; Thu, 19 Feb 2026 09:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3467F33890B;
	Thu, 19 Feb 2026 09:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HLID38pC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="K+fgUpJ3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15178324705
	for <linux-pm@vger.kernel.org>; Thu, 19 Feb 2026 09:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771493379; cv=none; b=YOF/T/m8YhdZ1zEZTWnblmY2/jDLtyBL9UvS+/pYlAqe02ief3nvmCTqsmzzLic3a6HxI3vHYBIosH/ERX4/ppthIrqFemw5Se6kmTY3m9vn09YxPvrGXcJZEzbumf5nlTfjxyQJ3IxhdMKekPAWgcfg81ugvCPFBV3Je5ALo/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771493379; c=relaxed/simple;
	bh=P0qIIDfzpUiJILQtOfKkgH3ZroDXXuMcD8301mLKV8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qyVTnP39l9AlfS4h1RFnaYvO3HFPGC0MfVxqSZlCl5ZQ+tqIslCKWCs9xYglbDH4cOCrmQUZzntQnFKtQe2FwHq9PL5o5VzivzXGTusN29M8B1Emf0jWzaylbeAot1Vt21fSh2SzbuexpZYP0Q53PrP0jNnRWf2NaXLieglY7RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HLID38pC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=K+fgUpJ3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61J56i7h3319574
	for <linux-pm@vger.kernel.org>; Thu, 19 Feb 2026 09:29:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MmuTNsdxIo1Ki6HQWuWsIBHgDhy9MLo0BmLXHdFSAeo=; b=HLID38pCUqKfFzwx
	b6hpzh8IRG9bMMCPET2CAxNJx7mxj8YtQphfrlWcRTaRT9IPMoc3+FJ3kE7TZFt3
	7aH8EByuzwUf8n9MJWaakbgayLYwxwgp3kAJeNGpo2EuoZLXKlExEUC8GgVtnDqa
	99po56qBb5a7TH3Oix4vJZO+vnjJNNmaFPHdUzWmjQWr7Zzi0vA/er8Q63uHQPtf
	dtGJtxQen5KSKalVxYh6rkuP3BB/oiKCc8xrR/lYuQDItnwGLKII+vIbjp+jT71/
	JaAiAIn7Xx90MO0eB/G6BitdyRG2zGlMv1gKSVn5Cfqyw9EORz+jGXY7h9mHcmN+
	5LDH7w==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cdv388jjf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 19 Feb 2026 09:29:37 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-89496f5086dso7178746d6.3
        for <linux-pm@vger.kernel.org>; Thu, 19 Feb 2026 01:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771493376; x=1772098176; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MmuTNsdxIo1Ki6HQWuWsIBHgDhy9MLo0BmLXHdFSAeo=;
        b=K+fgUpJ3yuBRzfYrry3sQRv3YdcCtTxeja8Qnq9gAiW250kklcInvWmSWMyAb4HovW
         ixwzRGD0+f8UxDjN3zqagYasPMjx+l80kQ1IcjfwjH52I4D0HLyGFKxYx3/UPdDXPNyv
         PKhjcadXXtrcm2noYJC7UskL2R76GHF+Hg50BwOdyLW0lrJOplChmEo4OCVpw0wNcvQz
         noJma1vPA6dPNBu8ssLjfDNw3mPAcxfvvFZdL4YQj41jhlPJEjxhGXhIJbXPZZmdXz1k
         NGio5ZFoyOt8JQjWWqr9A5MWOuMdbdtWgmrcou+lJu3Ql9ev6+4EV5/Ow2iaqZfNKegR
         uFQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771493376; x=1772098176;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MmuTNsdxIo1Ki6HQWuWsIBHgDhy9MLo0BmLXHdFSAeo=;
        b=dlZVK1TD7dK+YsCVbU9o8R4fOkK/A0RDsCqyxCfP7EBFvy3HwjbnT6NCeqirTsYE8/
         qY5p6FaFOBNxvZLrsOt9iSfc1wzZ/n2D1TkFN/dhcR9FOejlgHRETSHkLzl5vNNJYp0+
         vhMWSYQsFn0vnIgDUncBoo8Zq4nmqx+hvjyK9TvaIUJhovjcvY1dlNryRZFEg8/XBQjm
         55O1DLrL338V545598rDsKcfjQhRaI5xnRVt9wXzzHD8QsTbbyrfd4+TXGd7vQ1ajbJL
         fcjjOiCAbUnjq0GwYNIVef9v1jB3wLUvrJHjO1bGNLkjFkHJRlzVwBk6OJvRRB9/Yqpt
         HlJw==
X-Forwarded-Encrypted: i=1; AJvYcCVWtQHNpKZ/y9JaNab5QgpSHO12P+e4dLnTpDY/mstei/UPS9SM1qQ6bXsDG4YX9UT38i14MPI0xA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ57WoiXQRS1Sg9BsFPEF0fHQvyh0js3nFbs5EniwRvkH9Ep6/
	LxAb1jt2HkODu7P9VVFG2rIyKCXhfNm492B2V6Iy1egMahcHBq6Xc3GDKYStFIXvJReXvy/dCvd
	BRMz49QgShnfL6oqXin2I7etOuxnVOpDKz+GYQkb0YBrOkEoWERA8Xp5mEHI6ww==
X-Gm-Gg: AZuq6aJ4AQP9YtHpHKHNRbUMTn4s9sFqC+C18EhkHUXqSUdBMejye7QR09dm9eaeEfV
	0kIhW1DAMJYW8qYqLc0+pqH+TNABds87M7vi95+85nNU88wYyE//s1uWSE/bYx2Bs89ydAWv5DL
	+UZUloXaZa8mdno9xh9/O+fS5a4aFbc/qWnLVIJfE7WIYusJitxIHEk+a7kDfr13qDczay5aqEK
	Kfhl5TziJwyC/FYFnAdzTvsr6FyVlDRCwX31YHkFMHj6BI75R/GvTdHmFmO3eGizc0+bSlGBcpW
	MDclmJByyj6nJ19A781rZBUXksuE8co0rt9mKasT0M22FKDURbVzwIOOppSDLRbPoqnNlKxFuhR
	yBPZ8stdynaLbXj+6+EzBX4nCeGa/IoxaoOrzzUNanwKPHkfmREE5DaUiFCfxjFnqTou2R256Xb
	teULQ=
X-Received: by 2002:a05:6214:4c89:b0:897:41c:a766 with SMTP id 6a1803df08f44-897347c8326mr203654036d6.5.1771493376433;
        Thu, 19 Feb 2026 01:29:36 -0800 (PST)
X-Received: by 2002:a05:6214:4c89:b0:897:41c:a766 with SMTP id 6a1803df08f44-897347c8326mr203653856d6.5.1771493376058;
        Thu, 19 Feb 2026 01:29:36 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8fc735e587sm541749566b.2.2026.02.19.01.29.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Feb 2026 01:29:35 -0800 (PST)
Message-ID: <aa5f536a-41f2-47e7-b80c-8559c13a69b3@oss.qualcomm.com>
Date: Thu, 19 Feb 2026 10:29:33 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] arm64: dts: qcom: sm8550: add OSM L3 node and cpu
 interconnect nodes
To: webgeek1234@gmail.com, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Georgi Djakov <djakov@kernel.org>,
        Sibi Sankar <sibi.sankar@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20260218-sm8550-ddr-bw-scaling-v2-0-43a2b6d47e70@gmail.com>
 <20260218-sm8550-ddr-bw-scaling-v2-2-43a2b6d47e70@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260218-sm8550-ddr-bw-scaling-v2-2-43a2b6d47e70@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=ceffb3DM c=1 sm=1 tr=0 ts=6996d801 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=pGLkceISAAAA:8 a=hU_naWAkiL-jcIhTA_oA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-GUID: 6pTmnb7AbdO5cVdgJZsp100usfW0v37p
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE5MDA4NiBTYWx0ZWRfX/LjEwRRsEc5B
 csGidAHbxO0yM1o1HYz2EOq+2xxd/P94CzTrFDpfsRpdbmEpHxgbwkfL4alVxsbQEoEqTV6/pPV
 bqMxsMOx/etvl+nSaW539cXm8mCXbV/0vaLyZlmhMi1QCw+sOb3JGpjWDX+HxIx7kJ5mYLYgC86
 9b00qz+4Nr697fkIuv0diZUjkizQtMyUE7i3QCrdnfLeQ8myIo8mBLDcCiI86Jyv185Ad9uGfc0
 4rf2oa4vmifANQCqFuZ9xHoo8K8cBgsALPD7FKIOnuk1sp5AVL55PDdgWbscmv8WqkqoSDQm8Zo
 vCccWqlk17o4C7TgnXuKD0a6pYbspiWeyjkT/i9c59i3p/yuM7h/2OWpswNHwozFM+viGDQOa7P
 lvomFJUX2uK52WF/FcRE1pIsDfLynmb+8zoyjq8Vsky964GsL45Wyv7sMBt5h/uMgXf5mG+iqy2
 2CGkGbgiWFjD9RGR5pw==
X-Proofpoint-ORIG-GUID: 6pTmnb7AbdO5cVdgJZsp100usfW0v37p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-19_02,2026-02-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 impostorscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602190086
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42861-lists,linux-pm=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,oss.qualcomm.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B585515D5DC
X-Rspamd-Action: no action

On 2/18/26 7:16 PM, Aaron Kling via B4 Relay wrote:
> From: Aaron Kling <webgeek1234@gmail.com>
> 
> Add the OSC L3 Cache controller node.
> 
> Also add the interconnect entry for each cpu, with 3 different paths:
> - CPU to Last Level Cache Controller (LLCC)
> - Last Level Cache Controller (LLCC) to DDR
> - L3 Cache from CPU to DDR interface
> 
> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> ---

This should still be squashed with patch 3, as while you wire up the
CPUs as interconnect consumers, they cast no vote, leading to the
situation Krzysztof mentioned where the performance actually majorly
goes *down*, since the icc core sees no users present and assumes it can
send a zero-vote (which probably translates to F_MIN for the cache)

Konrad

