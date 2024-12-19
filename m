Return-Path: <linux-pm+bounces-19546-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F1169F863F
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2024 21:49:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA3AC165BE8
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2024 20:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B86F17799F;
	Thu, 19 Dec 2024 20:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VrH6ZAp7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10E714E2CF
	for <linux-pm@vger.kernel.org>; Thu, 19 Dec 2024 20:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734641361; cv=none; b=tc7pIq4WPkUFWIkSs2OP4g2rRkh7RgKFyU33AThucrAi6QrmxVzbeihxdnum9GCOWL8vMFJVIMA+Gdg0qxKEnM+lpesPY1Xlri4jpJhq6X2ZaK640PBbSQWe8r+DsK9DowltZYY2utcqw9g8F6zWZGye6G2jex7rHNBnHxbZRIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734641361; c=relaxed/simple;
	bh=EQfBiz4KQS0eSw+KHo1QGZraJTfCArIJ3CDRC9zlk/E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EXIRi8BNWpR+xDq6bSGce2w1XWFjh6X2fVpRfIDIk128+gvpL0eJTGf1hrSYkNnNwEdIhx+CIjj1BXvb6MwIk62eKsZBSsYU76g1v29rkcxRmi5QyDHJrWQMJFOCHWIOJV1dPha/LhM9LgibQRr2qNZNpBsTjgQsEKiWJT6AG+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VrH6ZAp7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BJK9fOI000546
	for <linux-pm@vger.kernel.org>; Thu, 19 Dec 2024 20:49:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FRRDae/hYvUEanCzXC8N3Hce9xcTItE0EhrjOzeNFUM=; b=VrH6ZAp7TKDuM3RI
	cxD7VtXWFgAxv7aqJuFg2f+AlzT7zGv1ceOw+ol2E+pkAfg+UmPmPMCGc8ns6HlN
	e/mBxmfJgLGaosL9HR+q6XFnvRKjcZ6icVKA/CDkvar2w0garyLAgL5bGE4utuXT
	MUG6EEv7sZ2Ocj9qZLxqwpdYj1U4u0ZzB3hGmevtG/nAGQOUg6tRvHnt5XOX6Pq3
	7OV+8LbRQIoYsTFT13slcw4hKENbC/knbcF3gAtjefOBHtzSOCZwMf97PAmMq3HP
	DxF9rEuN9qJpqlYajTNdzrolkLZ1BLOlm0cf4bkgQ829KleQ2inPLjc0H5IKWO7L
	VN647g==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43mt9g029r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 19 Dec 2024 20:49:19 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-469059f07e2so2803861cf.3
        for <linux-pm@vger.kernel.org>; Thu, 19 Dec 2024 12:49:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734641358; x=1735246158;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FRRDae/hYvUEanCzXC8N3Hce9xcTItE0EhrjOzeNFUM=;
        b=mffw49qESL9TkfWkrpjK5KHleqDECR7/5nAUoEu3GF3NF5dQKT8QsTXLACuGja18Iy
         Q5XAdOG+E6ItC9YjPFUJao4YmIXR3C0CZlFRKrVWVcl3OCgGkdsE1ZbcYALIEgG1/b5z
         UZxhVhCyea5nhXK9kZXD9rBGxV2DKdRCsRFKKNuNXjiR/EovHxVjsPgBSD3J/fx8lpaR
         2Hem6ytQSkbWt/TI4zfzcGasDILYIYIlZRdjLe0mZECtZf6yBJUUFuxwNRZ4j9OzIsHH
         t9YFbm2zJNF1m0VUX1Mj7z6rhoxwAN1zMEroQOKR6QBYTIS2A2JeirkLHJ1Cssreiyca
         33cg==
X-Forwarded-Encrypted: i=1; AJvYcCWb64ncKtSxTcPADf2990fo1v0TIHHgPhG5XrRt6QyZfFGImCLKB4ImhZgqMcTockVrf7bqlr5ucg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyns28beN1HzZbIBJ4pfyY0NGphp1lozKfHVMm7iw2qq9M73bDz
	3W6IuoWk16odfjmAjGoWyT2/YLfq0QPqbli0ro57PXpRmyuqsc2tz2aA+NJok+qJJDoNjVFcISw
	j6bJi6qHSVKFXJTN3r8TIQbDlEDL7fmGXLBbDok6+RjQMyWklATJ14oI6EEVqv6zFPQ==
X-Gm-Gg: ASbGncva8kWFSJlobt8p5yZvIX2h0iJbIhMfBFncq7XfI3xudAf8M6RWss4np0olyUw
	xr/fz+7UPuDwAzCiCvKJZQlb05DwKaz5SnMhZy5SpyGPThNQvq/P4DjGUabezaEmYik8jGFfB4J
	jHDCgoKEaioR5IAZy64Rz7NiA4Gn+pH5ogqMVe/1yao8CaKUGffNzzP8D+yWcifodSluI4nnf8a
	p8NCePrGyARzj56EihrkP9eP8C+6SkcK8AQwXXNpCfbeGjXMvXGScEkX9ZTHa3X5yTRUr3BYKzb
	LrZcbQjWOU19BkqTmAzDpi919HY52PMRJ5w=
X-Received: by 2002:a05:620a:2a02:b0:7b6:cf60:396e with SMTP id af79cd13be357-7b9ba7c9cf7mr15499085a.12.1734641358409;
        Thu, 19 Dec 2024 12:49:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF7ISODQMAOSONZGIrjNmW5ouACP+wuadO5IPYxmzS4CEZjDWnNhh1jYC9AQFHeMk83wtScjg==
X-Received: by 2002:a05:620a:2a02:b0:7b6:cf60:396e with SMTP id af79cd13be357-7b9ba7c9cf7mr15497485a.12.1734641358113;
        Thu, 19 Dec 2024 12:49:18 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d80675a27bsm981610a12.9.2024.12.19.12.49.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Dec 2024 12:49:16 -0800 (PST)
Message-ID: <424acb26-9836-4463-a427-7ff27d6ff895@oss.qualcomm.com>
Date: Thu, 19 Dec 2024 21:49:13 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: qcom: qcs615: Add CPU and LLCC BWMON
 support
To: Lijuan Gao <quic_lijuang@quicinc.com>, Rob Herring <robh@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Georgi Djakov <djakov@kernel.org>
Cc: kernel@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20241218-add_bwmon_support_for_qcs615-v1-0-680d798a19e5@quicinc.com>
 <20241218-add_bwmon_support_for_qcs615-v1-2-680d798a19e5@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241218-add_bwmon_support_for_qcs615-v1-2-680d798a19e5@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: RfM2iHfVf8z8SJ9eUxv7jtPWjIzFgYrk
X-Proofpoint-ORIG-GUID: RfM2iHfVf8z8SJ9eUxv7jtPWjIzFgYrk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 phishscore=0 malwarescore=0
 impostorscore=0 suspectscore=0 mlxlogscore=981 clxscore=1015 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412190164

On 18.12.2024 11:39 AM, Lijuan Gao wrote:
> Add CPU and LLCC BWMON nodes and their corresponding opp tables to
> support bandwidth monitoring on QCS615 SoC. This is necessary to enable
> power management and optimize system performance from the perspective of
> dynamically changing LLCC and DDR frequencies.
> 
> Signed-off-by: Lijuan Gao <quic_lijuang@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

