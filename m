Return-Path: <linux-pm+bounces-33639-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F56CB4001B
	for <lists+linux-pm@lfdr.de>; Tue,  2 Sep 2025 14:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B092916558B
	for <lists+linux-pm@lfdr.de>; Tue,  2 Sep 2025 12:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74DE2FE585;
	Tue,  2 Sep 2025 12:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Wzt2ivyg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC8E2FDC4E
	for <linux-pm@vger.kernel.org>; Tue,  2 Sep 2025 12:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756815077; cv=none; b=JddGDA7Xjjh9DBEfK0gHJyC4h/ORMkEuagbIegySnB1E58tPkJ4y7SGOXDrgj4O7SszmyzBV1BKfuP5MjagfTwKRskXe61OxoTMTajAKGw8203hDExaTxzYImEOXGL9T2s713QkiTr4QEWXZcE093xjw0Xos8BPI7c4a0/iOYBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756815077; c=relaxed/simple;
	bh=Q9xhz7InacewkR2sL7hxMKTtf5/Apj8ua9YctrXUMkQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LsToSf5c8htWfewOCObrddwddJOFBsWHkVXkhvY+Z0M0+a8lLZLPYOC3Bwxif9ILdxTnDQEE/LMjFSKFdBkW+70uUg5pzo3eBGctdx8/ROZVxiVGHq/QqS4Nm5FOuARXgjebSYZXF6h/HxEYqCUEKWcLLdvGKLFq9ZKO+RW7Y/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Wzt2ivyg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 582AU8kT030065
	for <linux-pm@vger.kernel.org>; Tue, 2 Sep 2025 12:11:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4vrt0A6ANjc79IaqhSJY8cPh7b4X0YAYPY/tdBRrzog=; b=Wzt2ivygiUPCUSwo
	BJAREK+B3YS73ADn7xyrkA3+Yid4oH+u/ktvtdOE2h2Aqx7mOQvkPPDlD6icrrBG
	8S9OW/8/QvXUjbtHgz39CKUw0RxZSjXRqA5DAMW9zUkdmOR4kMSEu4CQVKMcDxQL
	YNw2ENT48z1OpYcLawqx/abCCZksctaQ/99bSs7lkAqi+RDh7ajNPQ4E/st5RjgD
	RcKslF1kElgGzipF2lbQaJ5EUcMdEehlpngPrqnctql7iLR2r0oVhQF+QbHBQowl
	cD12I5MpBTvQbz0xvmgi8fcKmPSvYaqak+HBgFOtdKQwOhENbIiWtavOo1N/T5UT
	ett0MA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48w8wy3hrv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 02 Sep 2025 12:11:14 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b2967fd196so16299881cf.3
        for <linux-pm@vger.kernel.org>; Tue, 02 Sep 2025 05:11:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756815074; x=1757419874;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4vrt0A6ANjc79IaqhSJY8cPh7b4X0YAYPY/tdBRrzog=;
        b=i3V0OyVyQnYDvOMiH4CwVq/1eBN48+ejUIq0dJoyKNDk+2m3H8XMYSFnUKZavA4aAf
         LntSPwDqu/8+H1OuKEblm8AFujmwtzBWVCQhNCxFhnmsyMWKCMNVu4cwX2OKt4qL18iB
         ZOL9DbMsZKn/kz+VQAzSY+pj2+Npe9VU5cKnNnKanaE04d21JXqEtDDBRqn9zLf0tDcF
         TUrlM8lET/9RDgAiYFu1c2fiINCyAZRPGSIFjum3hWHlC3OHKML7QpTdlo65eDt+++/+
         b9Zyp40kz9ki1dBjlNWGU0l8ZyTY4rReijEgna+JP1YfHPlQXWAhNI5gb6+wB+NmjGNg
         P2hA==
X-Forwarded-Encrypted: i=1; AJvYcCVrxg3C0zcJVmQb4ewW68f/meg+J0lI5rPoj7D5XhKQSZ0/gVD0GQHnfZkCckJgbFh1dwrmw4V56A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzT0MKjgNDJjeChSiMQxLKciI+/L2mwvbZ+FqYWPTZ2VacS7SqT
	eGLXpBJMJ6HrlBJ+ySlxb8gm7ns+H+Yc4NAN0S6oNthpY9BnC4dx4sA9h74wJu5VW3CoTcLLYtR
	xYtZ+oGmqYek8Q1y5h6VlgpAIjdmbwt2FWmfgCTb1TOnvtFPqqpucIfzxp8Mauw==
X-Gm-Gg: ASbGncsDtYrsH5FFi1P5Sy9ZTWTZllV5La7j2XOoYPJq+vp+ZUIbfYvYvCz0gnd48LZ
	6/f9Co2VzKOXgHNwHQRVsM7g7OwsDunb6nZEEMW9JShkCUCeRwD6YuLFaSjbnJ+ngUov17h1vko
	iB6VMw5AxbbQajp9AF2iOJpsXwgVc4lMFGIzGULcQ59fONy28M1FvvtQURXnvr1j0qCHzsr90Bp
	MuCoiIiB1+Hy365zlOEP3k9+vFuJv4tkT7z3YxlXM/NMwGy48kNuo1aR5bQjaV1M4cKMIZo4moq
	kRm2ujP8B5P9W/8rGEMKse9G/Z+FBGtSgQzjMulEoiRgdbkrm7FnFaGN8g9yGCKorXHlN784eWJ
	5MQrQioLUk/7p7WxPZWhuuw==
X-Received: by 2002:a05:622a:241:b0:4b2:fb6b:38c2 with SMTP id d75a77b69052e-4b313e63155mr114514541cf.5.1756815073751;
        Tue, 02 Sep 2025 05:11:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3KfpCYj++Nh+x6sT1ov8IcNZd1mz0M6lJHlQz2dAizYJPZViCf3FEA46K+1XVLTY1Q97W+A==
X-Received: by 2002:a05:622a:241:b0:4b2:fb6b:38c2 with SMTP id d75a77b69052e-4b313e63155mr114513821cf.5.1756815073082;
        Tue, 02 Sep 2025 05:11:13 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b040f1cf4b9sm698003666b.29.2025.09.02.05.11.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 05:11:12 -0700 (PDT)
Message-ID: <b2838f7b-8da9-434b-83aa-fa117bdb715a@oss.qualcomm.com>
Date: Tue, 2 Sep 2025 14:11:08 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/10] clk: qcom: gcc-ipq5424: Enable NSS NoC clocks to
 use icc-clk
To: Luo Jie <quic_luoj@quicinc.com>, Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>,
        Varadarajan Narayanan <quic_varada@quicinc.com>,
        Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Anusha Rao <quic_anusha@quicinc.com>,
        Manikanta Mylavarapu <quic_mmanikan@quicinc.com>,
        Devi Priya <quic_devipriy@quicinc.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Richard Cochran <richardcochran@gmail.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        quic_kkumarcs@quicinc.com, quic_linchen@quicinc.com,
        quic_leiwei@quicinc.com, quic_pavir@quicinc.com,
        quic_suruchia@quicinc.com
References: <20250828-qcom_ipq5424_nsscc-v4-0-cb913b205bcb@quicinc.com>
 <20250828-qcom_ipq5424_nsscc-v4-3-cb913b205bcb@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250828-qcom_ipq5424_nsscc-v4-3-cb913b205bcb@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Ycq95xRf c=1 sm=1 tr=0 ts=68b6dee2 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=DdE-_dUAR9VioeaCo_UA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: ehTL_g6hCudcGIIxzELOqDdDf6KaHhCq
X-Proofpoint-ORIG-GUID: ehTL_g6hCudcGIIxzELOqDdDf6KaHhCq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAxMDEwMSBTYWx0ZWRfX7Qe3XdvdT0x/
 9Y/7hwjpDvpOPyI47tEGqPtCqlo64AbgIkHhiMuLErJjs4T7AQhukfnFvljPjmnmvBZPu/x0UNw
 cjS/vL0AjgF0D24lcvha57S++gilqoKz2LXqZEemq8k6+y4X4cltr1aJ0qmf10zR/duZeNI/ZE0
 TxX6szurC+EZwXb4rbYHXovW8zE+ASfRH1kX1Dmxuhs6vr8TkICrTgC2CcBQZ2wnnaZFoxlTLij
 wODm5pvxrhe4QwSu8ugFeGXvzqDOD/Sck0gJGE+ghFUtaGj+pt3Xc75lfkw6jyp2a2hHVkSIyw2
 mnpx1PV8FNMStI0594qY6Es30ruOjrfChVF3YqJf5asPO/My+3jqByHGDU9zX2Iji5h5Jg3DHo4
 vVWEeWN5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509010101

On 8/28/25 12:32 PM, Luo Jie wrote:
> Add NSS NoC clocks using the icc-clk framework to create interconnect
> paths. The network subsystem (NSS) can be connected to these NoCs.
> 
> Additionally, add the LPASS CNOC and SNOC nodes to establish the complete
> interconnect path.
> 
> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

