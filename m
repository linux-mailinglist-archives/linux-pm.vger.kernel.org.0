Return-Path: <linux-pm+bounces-22893-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E16DA440D2
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 14:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 584E07A674D
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 13:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C451C26989E;
	Tue, 25 Feb 2025 13:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WtvwuQgZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5102686A6
	for <linux-pm@vger.kernel.org>; Tue, 25 Feb 2025 13:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740490248; cv=none; b=qIFNMP7YPBjrzlYGLczJnt5gMd2b4vHIyyxgiOJROZ38F2M1tE6HqRJtJshy2IszKHHdfbSc/C80ob/eAkWG2vdMd6YDg2gtv1K8tysY0zAKvlFjQNo622M6sxbNWMdlSrvSK4B4C57GghUbcYbrKH6+zC+iUZ0Yifps6rTaK3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740490248; c=relaxed/simple;
	bh=wuAI4vGUijPnTtk+36Nugk8Q7ab8WJXds5NIWN/WtzI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F8NdFuM+Jh8aUOgn2Tdq6Q1Xsac1N8JrEU4TLO9kTvT4YR5iQvwX4UShcEV5YLiO2AIncNy/LZGmv8RUQ4CwyENFTd1lHOwFgbCCY7sgICX97OzQHBfrFxgqkpj9zWu4yrXl1TKH4uXoYbHnvpnQ0Mu4UA8DNPAFnts/55RyWkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WtvwuQgZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51P8Bf2g001967
	for <linux-pm@vger.kernel.org>; Tue, 25 Feb 2025 13:30:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Bc2n7N6LrsSsfLdU3/CSzOVYKaVednS4e8P74t418mI=; b=WtvwuQgZGtD64t41
	mgEe4Tqxw7EW+UyAISwxO0LXyEOLQG5xtf+9F6+xkYBeY6idvcooff0a3abOENmt
	deyGZ+hdIInNWPx8bljVYuJnRx+kk6nn504F2cYtB48X60cxeo4XMOtZLA+Ttm1I
	R6JaLz84dpH4ANeZzgOdr4JSpWNQZj7XSsuJuQaFoavAQWx1przf6Er+h4v8Q5wK
	Sre9sEx0JwQN4t2S0Hmi1WgsvOOu/w+os5RYn0ZIoFz05jCJ5s54odgy1gN6uXXD
	UH2PkyYp0BiVCXwrpRIdxm2oOWqUhh0nuZMpmR5Xj0v78O6oTEm+sLeTNJ3pXu0p
	S76wjQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44y7rk0tfu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 25 Feb 2025 13:30:46 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6e1b2251f36so7729336d6.3
        for <linux-pm@vger.kernel.org>; Tue, 25 Feb 2025 05:30:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740490245; x=1741095045;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bc2n7N6LrsSsfLdU3/CSzOVYKaVednS4e8P74t418mI=;
        b=b3/pmr04fb71VIc228+CiT/28NC2qlqSHR0imFeatjT5SMy7b6aRxcFP5QI1Rg6iLY
         TiKarwk8gCJH7Vk62UiGJrezR+/uC0bUgvD8mCFU/IDlQ8o+uIzYnk5ThmWPqEIil0s/
         GMwvqIik3HTvAVEFkpgXlJg/O0Y84a9f5IzOUL89D6lkLUtJgNsH3jQExeHQtAPpXcEn
         RCy3MotA33T+vRSaJqsTP/q49/FI8fuNjYJ9Hm3iX6nmUpDrukYfdaVJngHQ/iopvBxq
         FUIN5fJcsxxGXZaLuaEGFktZSD6fcbQhg9H9rdb22vHkfeTHXO4WZBeSUo8h/2EXg/iR
         fxwA==
X-Forwarded-Encrypted: i=1; AJvYcCX77MCTLGNUye+M3dh48ow6CnP5hyCkwb6y9+owyilZis3HaGy3OiXsNoHbpExCXxXHUcG7lFmN5Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj/sLDWPAc4XkMf3AUUmSKiaxHFWGnDH0J8f+kVUItOpAuNFMK
	jWw8MEPCv1skJ8eSPhWN1b12sFhp0YbVywEbCWvQDkjPqaZj48R+222l/tdff/mTPDzmYvbKYie
	fw+x8N2+72n9GueSqf4nh81MxfbTDgzm/hGO9I9ciMGnpfQjSlKp0ae+7sg5Cz/o5pw==
X-Gm-Gg: ASbGncuzyzz8YKLEuVnvN81Zk7JWtVFHkZ2GN9ZwgbknKp3Sdt1yrrWn6be2JsfDSbC
	d3WWd5/Diy1KVynEd4lAADkH7t1yUKXqA+E4f2ChWMKDYF+3nnxzxndpnoHQjjYoV58yoykSgYb
	5CXtfkiBUlK8T23sRjxDACPOw7jTQ2bts0g1dHgR6jvoze7kN8DMl3Wr4CqpeIxrlFWsb2zE/mI
	rAylqZEFn5wx0lxfzo6yk9KWTqgFmvrjxBzcOlpqYJvj9j0aNNKkv5cIB2plFRJ1EV6QwTxt6u8
	s+gpVTT+nvKXuBLwY8VmbmWrL7GXm0Wc3j1fvnJtd9VvQqmu3OUqYi8MdfOmfQyxmLvQEA==
X-Received: by 2002:a05:6214:c4b:b0:6e4:3caf:c9aa with SMTP id 6a1803df08f44-6e6ae80129amr87622536d6.3.1740490244853;
        Tue, 25 Feb 2025 05:30:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHlvs30Bcej2ehUoX5uYBPU/0u/U41vnUBagzU9ehas+iea8IpGY9brXOMrEMFxTREYhyjkBg==
X-Received: by 2002:a05:6214:c4b:b0:6e4:3caf:c9aa with SMTP id 6a1803df08f44-6e6ae80129amr87621916d6.3.1740490243814;
        Tue, 25 Feb 2025 05:30:43 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed2054d7esm141970366b.136.2025.02.25.05.30.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 05:30:43 -0800 (PST)
Message-ID: <b81fb350-f680-4e50-8cab-89c93f733bfc@oss.qualcomm.com>
Date: Tue, 25 Feb 2025 14:30:41 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] arm64: dts: qcom: sm8650: add OSM L3 node
To: Neil Armstrong <neil.armstrong@linaro.org>,
        Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250211-topic-sm8650-ddr-bw-scaling-v2-0-a0c950540e68@linaro.org>
 <20250211-topic-sm8650-ddr-bw-scaling-v2-1-a0c950540e68@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250211-topic-sm8650-ddr-bw-scaling-v2-1-a0c950540e68@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 4_XFDAnybeQ0VvPop_y18aASE9bmpY4W
X-Proofpoint-ORIG-GUID: 4_XFDAnybeQ0VvPop_y18aASE9bmpY4W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_04,2025-02-25_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 phishscore=0 impostorscore=0 malwarescore=0 adultscore=0 spamscore=0
 priorityscore=1501 mlxlogscore=851 lowpriorityscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502250092

On 11.02.2025 1:56 PM, Neil Armstrong wrote:
> Add the OSC L3 Cache controller node.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

