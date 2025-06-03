Return-Path: <linux-pm+bounces-27988-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B37AACC061
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jun 2025 08:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25CDB16E3FE
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jun 2025 06:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244C9267F48;
	Tue,  3 Jun 2025 06:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="m4YWk38M"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D65D2036FA
	for <linux-pm@vger.kernel.org>; Tue,  3 Jun 2025 06:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748932965; cv=none; b=M1AEnpUhsvhTOk8oS2n9y0Xf+jsVZ+aB2HFVhmQji3bDNYiDBC/nfZgIiKCa5t81Wo1dWF1KgqVOlTFtl0b7FpAWadKPwGnc2nYmTovKPkQIb7e16ObL6Nmx6TEv+lOEEyI09vkmZg374xjNWs9prhsl22JaNj+n3iwZsYrJv2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748932965; c=relaxed/simple;
	bh=GN44FSpPUMryhxPjpfEqKO90JozkFgvGGpM5mOb+UyI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a1Q9ev0v/uX5IcK5z395hEwaVHta0Dz6qQcYvdrCN8uCugKOvYuEvGbHSCiFF26J2ah8GCkJUoGDf5YP/yVnZ9UJjHsD+syUD+sKeUgu5lDm2FYAZESbuGNVOswzqY8XZiwMF1utS7K8NbGAt0hNNZ+Az7dUR1AGrue2nXOVe88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=m4YWk38M; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 552HKEL5013942
	for <linux-pm@vger.kernel.org>; Tue, 3 Jun 2025 06:42:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FapTv+hgyXWAiQtFZ/6aCrTIGpX87fiidKCn0qHWkY4=; b=m4YWk38M+e+WaUU2
	2MNnPRd1e3Wq3UkuCDEej4pffPNTitPdua7/lMlqc2fHzYiLSSX2L9OWlyXfABKJ
	8V7kETY7JrwU3NqtcXI8b2sJseVYOpP2vPpNOJuKnfFx5PY3GKcI97mW7F/AI7iX
	jmWYgthlSteecvgmEb5Hs1H6FvwIa+9Qkk5Q/ms7l/6aS0T3U1Vnn6XGgNLSQB9o
	+VFHEt9QDfCo2QrU2uD3svK1YCFScCfVTjudGNkWv0gEUZvBCtz7FjwnLGIEDZU2
	aIf3ie8WOXDf732HT9jP+8P9RYDUjxeRlGUT63+Q4QOjgT395KOxJtUzsd0IFDjn
	/dXExA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 471g91hkk0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 03 Jun 2025 06:42:42 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-310e7c24158so5160437a91.3
        for <linux-pm@vger.kernel.org>; Mon, 02 Jun 2025 23:42:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748932961; x=1749537761;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FapTv+hgyXWAiQtFZ/6aCrTIGpX87fiidKCn0qHWkY4=;
        b=HFw5QTNCX7tpvb/IXz5hYNjI0UZKzP5429zpEQ/+WTADEelZlYMCcYcddNdGkvb99G
         PUJ8YrLYJi0rFJkUq0RQ+c2iZDmIgpTZ5l4xvUDd53+6aEhDzx9BhxXSDGLZCvPOE8xq
         G+o6IZkPDEzpCPjVhxJzD0hYVuvZ26y1rc4iHcaFflm3tNzpS+yCsW0LoaxYzIWbzU0J
         zqfvEtZ8BRrLHujTwzpLt4EMcDdX6zO0V97NpzjfXLb2nIUq0U9RcA2PJ/CTHniBOfeG
         CVYg29Ncax3iFO0grgan/ki8LQ3ynodUyA8HaayCruedoIfjwdzzniFjzr/OFpikcqol
         6kAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXII/K9buKwNESskB05COcF5T9NvzCYATBY4QaCcT00dGIP/iIQriTRJUPBG75esm0ZTCnPV840sA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzcrDPZapCg+KvUukqK6KbI5atitZykLnkaft+sA0PvJkTFABW4
	cAXRpgsIAkOCQi+LYfd2WonuuhMtPiNf8eNRo6/e0/NASVbCJf1p5Kl6RcvHQRikTRu2W/Hn1cb
	qFELLivSNo9Xn8VQIB9EsCpMfuuSF57bxL4KHsRiKF9YXGivPMptngKOQXFcN6g==
X-Gm-Gg: ASbGncv9DBYSM6l/cQGosiza47JvUU1UJmazZaHDcy0Ls9VuzD+PD2d/bN2F6DxFQMV
	5CGUUkYOhUvlGVX6RKbehpxLWGDnXl0u5iS4OGv80CuCQLmighXBZ+24N2uQSFpfaWyJ8JJivml
	P91EmmTr/LVJccQp3B468nw3Qg80o1PUEskwQa3xTFoSLK3rhg93WqYVclf0RdmsMtXIHOM1vnm
	i2bWjfzXhpeWbQh/2Coc8+/2igR0EJrELpPfZ7YXk7OffFU/dkseozW5vb32EpsKSAZp6XaJMpl
	TcCpuWS331lZK+qY7gRv0g8nL5efWd0Sa18y3AqS9xPTF0S8gl7y8wuIMTbeZuRaDUW/qO/5SR8
	sl26nYvBJ+XU=
X-Received: by 2002:a17:90b:3e89:b0:311:af76:35b2 with SMTP id 98e67ed59e1d1-3125047f1b0mr18780917a91.30.1748932960977;
        Mon, 02 Jun 2025 23:42:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGVU9kEh+fJEWFdjM3ozZfG8ZXX9JAQnIZMnanwAHvQ7aYTu3wh5QiNLtgU2x8tq/oYaLaBQ==
X-Received: by 2002:a17:90b:3e89:b0:311:af76:35b2 with SMTP id 98e67ed59e1d1-3125047f1b0mr18780895a91.30.1748932960527;
        Mon, 02 Jun 2025 23:42:40 -0700 (PDT)
Received: from [10.133.33.127] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3124e2b67f4sm6603856a91.3.2025.06.02.23.42.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jun 2025 23:42:40 -0700 (PDT)
Message-ID: <14cba9ae-e3bb-46e8-a800-be5d979b2e06@oss.qualcomm.com>
Date: Tue, 3 Jun 2025 14:42:35 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/8] dt-bindings: soc: qcom: pmic-glink: Move X1E80100
 out of fallbacks
To: Krzysztof Kozlowski <krzk@kernel.org>, Sebastian Reichel
 <sre@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>,
        David Collins <david.collins@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, kernel@oss.qualcomm.com,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org
References: <20250530-qcom_battmgr_update-v2-0-9e377193a656@oss.qualcomm.com>
 <20250530-qcom_battmgr_update-v2-6-9e377193a656@oss.qualcomm.com>
 <4e093835-af3b-4a84-b42f-fa7d3a6f60a1@kernel.org>
Content-Language: en-US
From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
In-Reply-To: <4e093835-af3b-4a84-b42f-fa7d3a6f60a1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAzMDA1NiBTYWx0ZWRfX1nJnHODnCaA+
 2T3WD2YwR9+jjoi1+hz0ceGTAWYF04XsyrXn5LpoYFp4jzpD5Xu6aVw4hzhyPM78FqHqv09kNf4
 L54p11NpZfSqfr/IqN+IfKz+iy9vaQnPQld9kc4b8JtNJOr69uoGe9rfD4K/q28rNStaGn2wX6C
 E1Arjz8k5mxB1kpDhOKMuitOXzuLcpmJxFq3rzq/pupwIhD3u5gwdtWFygIW+3x8ZkdbO5HGBBB
 yYljVkusm6bS7xBAh/AoBbeBzZ9g8Ek19czvtVHgdtQXQ4UUshnzgAJEUbC4REfibvjp2gqQUoL
 ttS0LJBnoksr9h3qFR32qaJeGP5bu3iicckelAa90/dbKq60DT3AwMYjqXu1oxWnE823TQOQ4UM
 iUKZKbCpJAC8eQVNbqHOQfdzjvwdhbZxKMoKUtQypSMwXka5kfs/KW5BmLYF32JaPOKT8EaI
X-Proofpoint-GUID: v7JyntrkrS3iZyrT9TTMpvwYnlh_Vslf
X-Authority-Analysis: v=2.4 cv=KYHSsRYD c=1 sm=1 tr=0 ts=683e9962 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=kUhqu5DrlFyasPmHbFAA:9
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: v7JyntrkrS3iZyrT9TTMpvwYnlh_Vslf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-03_01,2025-06-02_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 mlxlogscore=889 phishscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 bulkscore=0 mlxscore=0
 adultscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506030056


On 6/2/2025 3:40 PM, Krzysztof Kozlowski wrote:
> On 30/05/2025 09:35, Fenglin Wu via B4 Relay wrote:
>> From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
>>
>> Move X1E80100 out of the fallbacks of SM8550 in pmic-glink support.
> Why?
>
> Do not describe what you do here, it's obvious. We see it from the diff.
>
>
> Best regards,
> Krzysztof

Previously, in qcom_battmgr driver, x1e80100 was specified with a match 
data the same as sc8280xp, also sm8550 was treated a fallback of sm8350 
without the need of a match data.

In ucsi_glink driver, sm8550 had a match data and x1e80100 was treated 
as a fallback of sm8550. There was no issues to make x1e80100 as a 
fallback of sm8550 from both qcom_battmgr and ucsi_glink driver perspective.

In patch [5/8] in this series, in qcom_battmgr driver, it added charge 
control functionality for sm8550 and x1e80100 differently hence 
different match data was specified for them, and it makes x1e80100 ad 
sm8550 incompatible and they need to be treated differently.

I explained this a little bit in the commit text of patch [7/8] in this 
series, I can make similar description in patch [6/8].


