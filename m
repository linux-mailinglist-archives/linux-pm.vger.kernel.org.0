Return-Path: <linux-pm+bounces-20264-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFEB8A0A2A7
	for <lists+linux-pm@lfdr.de>; Sat, 11 Jan 2025 11:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF6CC188B8DB
	for <lists+linux-pm@lfdr.de>; Sat, 11 Jan 2025 10:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AADD218B492;
	Sat, 11 Jan 2025 10:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WvMHHIKc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE3E170A23
	for <linux-pm@vger.kernel.org>; Sat, 11 Jan 2025 10:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736590581; cv=none; b=EaJ/iARSZv12diJyXonTyN9w53Fc0SMp6dfaRZQ9KF4YHZB4vAbeK24py86p1ZV3V6LpDSl/l/9udFPNc5lTA3+xuMibgahfs3xEzD5FXZRN1l2i9c855Dj1StQrKcDqk0+eZvwyIQKMDJ1UMgJF64nyLuDJFNBCoyDy6RwI+r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736590581; c=relaxed/simple;
	bh=+0C8BlzusYxOPptL9BVR6fsXIYLEOTda+I65CwE8f6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WXjiAWLQhBjjeeqOR+DDUtdT9vIF6mn9ymG0QlqbnBVrNaasMjc1Q7GvDyl7PSt+9ycBgjlZfKWo8xTdprPqfUv6jtasjl3qnWgGrQlrg6PlqRbUhjS4diqlUy94wcMoVupx4sK0LeZ9RTsIwHSf54uvWpHhv6lqC4XrMYsq474=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WvMHHIKc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50B9X6GX020848
	for <linux-pm@vger.kernel.org>; Sat, 11 Jan 2025 10:16:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	w9+WyrSy4Bt0wnJHAm346WUu/Hgt2IxkMJO9OgJiDVk=; b=WvMHHIKcThoftU1l
	tyqz4wdCu8/6zpzR+OueS+H6hJRx8cr+QuiZpuvk0Z9qzfp5XLFlZw4D3hQqSnvf
	Fr1Jdcl+tXbti2eLo+9ekEo/OZjyFgQIRs1Mg80ul/HzafkhGQZE6yNMRfwLTrEd
	YSwA/It/Saj6DzHYF1yl2h9L8FRu1efb/AKYAsEZfkgBDv7fHH3buCbBcpMDgZh1
	KwjYPb7V1CvoQkSw+jcfLl+0OZxwG94lIr+WO+D5yJooJmR0DejX3ynZOGtnTVjz
	/PkgwOsLnn/NgKFrNlfi+lrYxvUBO0483+e167Acd/rCg9SapjbXA/PHFGJjyWdD
	me0E3w==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 443hkj8cxa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sat, 11 Jan 2025 10:16:18 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-467a437e5feso7421601cf.0
        for <linux-pm@vger.kernel.org>; Sat, 11 Jan 2025 02:16:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736590569; x=1737195369;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w9+WyrSy4Bt0wnJHAm346WUu/Hgt2IxkMJO9OgJiDVk=;
        b=UnFfKJJbsKxrZfglUin9qS5czRK1EiHS6IMd9ivWzd31cBLA5Ed39kwDKBO99UnPBM
         Q0CpdA/l0Wi8GSVI98uSupfvXtNyli2xzQmcxy/YyJPu6WA4UUBuUD6GM145R2LLXZqT
         yAhoE8gJOf8p9S8ev/ullhcsQrgDEOLGm+90ji4jTz0w9dLEgSKXuVxDfsCmsXzZcG2D
         ZBsFCbIJcy6Wl56GKYomCAQLu2ZJSTBENfl574UnljR/uXjdJQ6SJ2Y7CuEZmEbO6k6t
         J+B6J62BDKaqTCKMgoHsEguJOBOkxBgrD2jstK4l9x6OqKyQJBAYrMmSrM7wDyuPYncm
         bLpg==
X-Forwarded-Encrypted: i=1; AJvYcCUcsyjRvDtVqHgdUUSBs136MeqVBdgt+K0CmVfh8JQC4PfRyMEfxlejImu4Wp7ovr9xHkANlQVDlA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy4WfT/BpC5h/6CntA6oD5Tzrhw3hLrBRFDJQkJAsBXLoKUG3Y
	a4MsYq71MwZOimPIspf9gUl0xd3Zhn33unDKJZUe4lcELR+s+igVdc24/u5tCeJ7kgeLohMXhUq
	xTMDR4ZSRya0k62rQOcEQySXUDV8QOgcPIMEW3qPEsXtMx30ju72cNwL8kg==
X-Gm-Gg: ASbGncsCLXTh4B24AbN5iwW9pkNRwErFp+L6EO2gYBUJ9189P3tRn5TB9PyEfvWkBgY
	OGeZfLIConSeOWzfnC+jrb/LV3Qb4GozIdKmXczHfTEwddqT0jAjMVEUquBtLeBA+Syl1ks+lP5
	6FDNgzpQ6YIx2lN6cIwS7pZxPIVeRToq3U5XHsHiQ0iHmV+3ZPkVESm7X+VPjJgAbvq+4clGJmP
	1L2oeTw7aoEUIBQMmxAwQeoJBviASQCeETCXy9930eXu1fWIBYJ6KMDrZZPZYgLfsIgH7f6ZFnk
	SACXD80B88M2s8myhZvnODgbCNuXU/u4VhA=
X-Received: by 2002:a05:622a:450:b0:460:9026:6861 with SMTP id d75a77b69052e-46c7102be4cmr82952661cf.9.1736590569473;
        Sat, 11 Jan 2025 02:16:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHbKnV/v9Y7xtZ/lsEvPDhcI9HeXBzrrHAPAicTsOH8LPJnx7Wcrgu8KbVeasp8ehZ3y4BjQQ==
X-Received: by 2002:a05:622a:450:b0:460:9026:6861 with SMTP id d75a77b69052e-46c7102be4cmr82952551cf.9.1736590569059;
        Sat, 11 Jan 2025 02:16:09 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d99008c3cdsm2548085a12.1.2025.01.11.02.16.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Jan 2025 02:16:07 -0800 (PST)
Message-ID: <a087a20a-04f1-496a-adb0-1462bd79b5be@oss.qualcomm.com>
Date: Sat, 11 Jan 2025 11:16:04 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] arm64: dts: qcom: sm8650: add OSM L3 node
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
References: <20250110-topic-sm8650-ddr-bw-scaling-v1-0-041d836b084c@linaro.org>
 <20250110-topic-sm8650-ddr-bw-scaling-v1-2-041d836b084c@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250110-topic-sm8650-ddr-bw-scaling-v1-2-041d836b084c@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: rEbpECBxCa2Dvq-2wZDBiCGYwVd3C-Fi
X-Proofpoint-ORIG-GUID: rEbpECBxCa2Dvq-2wZDBiCGYwVd3C-Fi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 mlxlogscore=849 malwarescore=0 priorityscore=1501 bulkscore=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 suspectscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501110089

On 10.01.2025 4:21 PM, Neil Armstrong wrote:
> Add the OSC L3 Cache controller node.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

