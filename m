Return-Path: <linux-pm+bounces-30367-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42548AFCB32
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jul 2025 15:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C86EE7A7503
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jul 2025 12:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102142DCC02;
	Tue,  8 Jul 2025 13:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="g3Z7WCht"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A513444C63
	for <linux-pm@vger.kernel.org>; Tue,  8 Jul 2025 13:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751979617; cv=none; b=ZgkImKGBXkxxeCewGhPI5+ry5lojmGh++y/EPx7BfKODJMav/A82dMxLuzTUbhh7RwW/L3vhexZslm8eJ51dIZE5BUStBQGT6rD5BQYvTwasiZ9IRb39DE9sRweM6r6FYtxKAR+2JD63VJiZZQG9aF1BswDhiYocDKMBQ4xLNo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751979617; c=relaxed/simple;
	bh=zQXHKtgpAU/Cz2/90XNDOZ/2DON5pPdweIU7vev4U2g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ks36Irjw82KDMXzgPPCK5VTenpWXrbr29LVprwp/ZxfGbpbXUO1zZ7FVP5OXW0B/iozfFbNOYbuGnlxDVNRCeh8a7z387Ka1hXW67yfKrRaVcdOCxziMUPBTl9hT5qV4R8GjSL/slmZVtpE4wvahyPbDSN/HSBjEXLUUsu1DhQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=g3Z7WCht; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 568AAN8F030304
	for <linux-pm@vger.kernel.org>; Tue, 8 Jul 2025 13:00:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uZ7nQ9K9etHDUg75souiQvkrDKhzX8ysd2chrySYPb8=; b=g3Z7WChtPvkD6+Kf
	UtEsgALJRRLZyvLm8daLuuvak3X0J35m6mDyYitbXbM2RgUhtvN+dRkemoHwH36A
	bb0nRYIhpLoQR/cDI7dTgtOMazU7aAihsnkPX43752zPguzLI6dCQ+CRqQS+KCoi
	xlf31LRetsLZxT/iCwp2eH83goHZB0oypNJBaxtwppOkDjMN/BhA4eSJ8iLgplyW
	dEI4O5mv74ffY/JtRgLHaD17wQMM9tZ8/0vxbNgaS6IirQ/0lM2e59U6Al/gXFb7
	1FdmJWsLl4XH8+3sFvw3uzoEzhLSyzTU/VMlOrF5oC/Ffya+uCrilqllOkL6tf/i
	cu8S9A==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47r9b0u2g2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 08 Jul 2025 13:00:14 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7d2038aae69so20136185a.0
        for <linux-pm@vger.kernel.org>; Tue, 08 Jul 2025 06:00:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751979613; x=1752584413;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uZ7nQ9K9etHDUg75souiQvkrDKhzX8ysd2chrySYPb8=;
        b=WD8bnpDcSLcxjGjQ6Ypx7cITuCKwce00M9eLnhy9rJxAOBqSYPmm9n8HI+rVMt0JYT
         coxSG5ui34ywgip5AH1fjape9Uaslz0uBgeSTHD2hCW52nF2cBBA+c94m7zSikO1eO5y
         by84om0UbRnwIl5eSq5YxHwqw+byDXHLC5VIRFjg4YkN898xKoJjxn7gy6oFlKs/84Fn
         gNvmbdHavtVDlZdLdnJ7Npj27usZbBwMlGmWjR+3fEYLc1jzDAn2Vp2Jk8bki3w5pgOA
         YE+OgaBgA2Lzo7V0Emq3l3ZVrKsrgfflyOqSsmFJ3VX5arRdgVWadsYHQVPuMXigsn6n
         RQ8g==
X-Forwarded-Encrypted: i=1; AJvYcCWQpf33byF8rscbnpwaxvDTvXHEr0B4XH1ntHmpao6Jz8oP5MFQZzCE2CVX+wXR5QXj0b8ATWVabQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwtEHo1/EpsQdH/4xBYQkg9RXwKC5hwxTEuOrh6RaWW4lYzLHXU
	/ZymXrB5+qE3GBgh4jL9e8IApJN8IGDiGCELrFNAZqpz7MihLvQXE/cIoJkjDyTEZcuZ5Pn2lqz
	rl/4bJxrgV42sBVNdQkMyFTDziJ9kXwf9A+eAsOYMoHgCkGRkx1QDJmEwxV1YTw==
X-Gm-Gg: ASbGnctXbletVZz063ArLa2ceBNMQSJlGpItOyfS8tEikS3mIDZyO45dpvOLelVgjT0
	bseEA9pYfC3l9myXKmrbADsQy2TsOAKVCo4/wTJ/G2azJUc/+eex/bPbedW2c8Q6bzlvKwtgkpM
	0qMVVAj6k4lXKrP+82od8fjHYOrS+afgWTdPUFMtGVNS8zFkgb+2W3wYjBOiyWs0US4Y1Gg3lSf
	49mqTpZf2uLaxi0YBU9emwQx8xv3fvSq9wPNItA8yJnx4JmrvV71lrnOrxUd9O+TJxDB5SQdqzc
	isR3TVFABGkoOsGMC5tPLkrqxOt4HbYdieQbteEqfpEEG0zckdC3gg7s3lCfG5WYTxgnRpxZAoB
	joAs=
X-Received: by 2002:a05:620a:1b85:b0:7d5:c29a:b41d with SMTP id af79cd13be357-7d5ddb72e87mr894470985a.6.1751979611961;
        Tue, 08 Jul 2025 06:00:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOWeCg8LWYitPQYk8omBFmESpVhxHV/1NeuK7QjbwJP3U2bGrlO4pmbJ+4ikK1Q6UkvlaRXw==
X-Received: by 2002:a05:620a:1b85:b0:7d5:c29a:b41d with SMTP id af79cd13be357-7d5ddb72e87mr894468785a.6.1751979611416;
        Tue, 08 Jul 2025 06:00:11 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f6949fa6sm901129066b.68.2025.07.08.06.00.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 06:00:10 -0700 (PDT)
Message-ID: <b3074aa4-6898-446b-87d4-de8ba2346ded@oss.qualcomm.com>
Date: Tue, 8 Jul 2025 15:00:08 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/28] interconnect: qcom: sc8180x: specify num_nodes
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Georgi Djakov <djakov@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250704-rework-icc-v2-0-875fac996ef5@oss.qualcomm.com>
 <20250704-rework-icc-v2-2-875fac996ef5@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250704-rework-icc-v2-2-875fac996ef5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=dYuA3WXe c=1 sm=1 tr=0 ts=686d165e cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=alsCV9giXxwD5S6y2l8A:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDEwOCBTYWx0ZWRfXz9/QhcmtHT6+
 79H5ZL/xt1p/toYvbdxx2xLNSsrP/fzw72O2MpIKqTACIWhzOBtlU0/iMa+UH1AyOMFMZUYanv5
 fGU0XZiFdXx3ZFH6HIFUiSeGV/pUrrhzs41xrGADjEfThLhjg8seYXkzAisGSPMV4N71hqPa8Ka
 eS8zhYmm2qirDT63cjWH0BfHcesfhc6cspTZcU8TAl9gNAC49Ot6w4hx0zXRTH7TqOWYbHWavNN
 W0qP5dA2a1nUzzsa6sPPfGWiMQBRuTg/IqQO0uqsQymTHQWUM2/oW7uEEdRBZBqg6Rv0QzUsQDF
 GXWENnMLb+r6xBPhbaxPzIdBiCM6eRF0PVV2BptBRm3BAbP/ppXdHcBEiE3KSaj+6+Zj4wSui5Z
 5l8ZN+Q8z4spHdfICh11NvOLwNtOfGJ5HnaleD5I+EoqE65NNVwu74QoScL7zpoW8e01Xifg
X-Proofpoint-GUID: 6G4Ya-Zc6cD8Z8rbP8Y7SK2JaSqTq7DK
X-Proofpoint-ORIG-GUID: 6G4Ya-Zc6cD8Z8rbP8Y7SK2JaSqTq7DK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_03,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 adultscore=0 mlxlogscore=846 malwarescore=0
 mlxscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507080108

On 7/4/25 6:35 PM, Dmitry Baryshkov wrote:
> Specify .num_nodes for several BCMs which missed this declaration.
> 
> Fixes: 04548d4e2798 ("interconnect: qcom: sc8180x: Reformat node and bcm definitions")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

oh wow

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

