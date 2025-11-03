Return-Path: <linux-pm+bounces-37289-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A66C2AD54
	for <lists+linux-pm@lfdr.de>; Mon, 03 Nov 2025 10:47:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30DD818937C1
	for <lists+linux-pm@lfdr.de>; Mon,  3 Nov 2025 09:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D32D2F8BE6;
	Mon,  3 Nov 2025 09:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XELXC3Xn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WGZhDLV6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EFB2F83AE
	for <linux-pm@vger.kernel.org>; Mon,  3 Nov 2025 09:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762163242; cv=none; b=T+o4XaJN7c0GmcPKLKICOHeb7SEY0uzfX+mSrsrpS/KnvfJZzeLq/eEN+IOReO7C5w18BGrypISvFVQicftcRISg6dgYArgtfT/wtA4L8cG9czA1kndYHGQ+PMtqGozr4YYoEA78mFgaDqSAESmlQcIIm4RzzCEOoGLWWzgq5pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762163242; c=relaxed/simple;
	bh=6ZUpgtOH5YH/KbSmlniCxlddkflCkVLwHtZiLFhzwmM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VyMR6r67QXgbk90IlbXjHhKF/0749JiMrBv+k2j/x0KSDr2ACyRJKNTIzBIVP0pvmH/eZ7FivcAXtc5HX2mYQ+gkuWZT9b8WqleUwlOsZYA0COSohxavGi48X4c/Z3dtg99fnBKlkKsH6hpbtJy8Sv7qc9oMC/vTfvOsGbfALz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XELXC3Xn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WGZhDLV6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A33DgIk1941400
	for <linux-pm@vger.kernel.org>; Mon, 3 Nov 2025 09:47:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	C6WkG3y8CxEMz4mNCVgHig9ILT00YvV3F7wuV3vWlIQ=; b=XELXC3Xno15ggkCz
	zUf7rxqQhD228HH7OkQrLcw0/zp8kXnaqY0nEDjAosqp6QZXzh6rgIgMimoJDHks
	E0+rERb8lpalH6A8KcwTBnBw5SQvJt2mNinrhNLuD0/T4JZy1qGbtZecetrvlIOA
	4Fw6FWSzgmkDzAzP54wVPX2NMtRIk0W+lUlWV0GXv8jNHdQQ13+KJhPKV2HnkjZS
	7YuBpLGUVjUZq63NPULolIrcQ/GDKu8km1BRVTCEwCOiqTDjzG/HjynPmqP6zOco
	IyTqNCpsLtE7T4YgqSQFBDPE6y2YEq7Jy3Xsxg2yFzdogwdRidpOB5mgV44eNUfO
	y9tWAg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a6m9w917p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 03 Nov 2025 09:47:18 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-89ea549dca5so212450785a.3
        for <linux-pm@vger.kernel.org>; Mon, 03 Nov 2025 01:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762163238; x=1762768038; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C6WkG3y8CxEMz4mNCVgHig9ILT00YvV3F7wuV3vWlIQ=;
        b=WGZhDLV6dWht8Y+yGyyn8fWFI/4bBRJDpueREtf4Y+m5je9x6nEGg+fKEMpImKq+UZ
         yLnY/lmir7W1kvPmIRosiBW04uOnSDCpqxBVHD7945BQ2j77gJerHS9m966MoVeDr9uo
         ZiTWjDP/Imn8CpiNQsXg/ZBoIc1uvPgxERrem8fbPIuBzUzmz75PluVwta9DsXWkdnuI
         8sBVCfE41cHjfiYZ6RDqxCRfg3K42uWUKRb6FCra6oW1T6MmmQ7z41BtBl1kBK53NgiT
         D+eE0lgu5c0UJs6C24DZfhm1E9IGVlQaA/S+fJQh4Y6iQgFTLgVTINnqULdG68u9O711
         c4dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762163238; x=1762768038;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C6WkG3y8CxEMz4mNCVgHig9ILT00YvV3F7wuV3vWlIQ=;
        b=JNm247DpD5X13xrVtUh3NQSKkPlHhHJaJZVWsmUWC+3tU60XFF4o3FLE2Na0Uwxp9o
         b5Ue3nHjTO/779jg/yOu3UpzmWv6O60tC3MC2cXP/pqM3vttwdWIzJcyKtwNH6kkMAo8
         hLJDij2ebPzZqxX4gY3IDobq2Bvci+dFNsioissNoyakJzG0PUk8r8vRvu8hIECEa/lc
         EAWC8kPyqV7Vj/Mq70qUwfMt4Tsmz2Rna/Zr68WF0u7omXAQnVxrjnSJqJSH1XM2JLhN
         fDthQU93vHCeT6z/fikX5OPRRuIHWQcNI8k/U3n2kAruovU+YzqAAYGox8/6P00ddIZT
         TnvA==
X-Forwarded-Encrypted: i=1; AJvYcCXWTsNoDNQKPk9t1BQf4/JaRg9JR12X0ZzMdO/b2FJk69SVOWv3IO/P2ZNZci6oyDMOTsQl0YlfEQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyKN5KKv1nGByjq1MZQ+/iHpjRJbIGPJtSSKNRHEmlrLnYbnToj
	SCCxGfcJWjZqIeE5hfB+hyNDjpMptzKF5yodqd5DwYS8TZUy0KxL1/D+n1CvMZ7GVL64xsCLrBL
	srPCinmn/kbRxTpOlsnJkWkX42TLYBo3dBJDy9LoO+Qpshd/0KOpIYNMib2ZKGQ==
X-Gm-Gg: ASbGncsaCz7RJhPr7HSkbwygwhu44hHYbKusOSVRUAIRkIs2JaRPVwYMx8IuimzBHaS
	qzJXd4uT+vsTTfam6XAYcvGf8CC3rBh4xShlmIs65ZcXQ6s7EFunSE6lo+asfV6BvXE9vHfqKys
	7sZuaZPT1RN6vLvKjWAf2HtBgOu/iUpdT1vsHhIGCFWhacMVsBra8cR9yFFfHqA9JHKZZABN0uV
	Zh6HM/wgaG0I8h74ZbUsJrZ9qYBoinYnkLPeA6NSG/u32myhm3d1we+BJVwqaZ5UE4Pxsr+zIbC
	RRFs3qyFScv6uRGiq2Dx93hKGXHC5MWiQQU1DL9J4zRQEB34UxvGllUb8AvuJLL2oM4SJUVHVjF
	cYw/YIenvGRXSFvEqjYzvl9VoiOJ8Ym76xZcUUGuUl7byGZKmzz31qp0M
X-Received: by 2002:a05:6214:1bcc:b0:830:4f29:a648 with SMTP id 6a1803df08f44-8802f42fe68mr99288286d6.6.1762163237715;
        Mon, 03 Nov 2025 01:47:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH8Me7GCcBS/O6WoNVVBQDLilh4+4Stvq8TsTyYlEkYaH4vMagiwC6s37Agz079dnrf0GO1cQ==
X-Received: by 2002:a05:6214:1bcc:b0:830:4f29:a648 with SMTP id 6a1803df08f44-8802f42fe68mr99288166d6.6.1762163237019;
        Mon, 03 Nov 2025 01:47:17 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6407b392d5dsm9361015a12.15.2025.11.03.01.47.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 01:47:16 -0800 (PST)
Message-ID: <02cc6e0c-5145-49d2-abea-fe4a951ff518@oss.qualcomm.com>
Date: Mon, 3 Nov 2025 10:47:14 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/25] interconnect: qcom: icc-rpmh: convert link_nodes
 to dynamic array
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Georgi Djakov <djakov@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251031-rework-icc-v3-0-0575304c9624@oss.qualcomm.com>
 <20251031-rework-icc-v3-1-0575304c9624@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251031-rework-icc-v3-1-0575304c9624@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=P7Q3RyAu c=1 sm=1 tr=0 ts=69087a26 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=pb1RGRiFvkXHE0IyWJsA:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: 5TPoqqGZ1LWTzJQMiXWgl2TJdGCt1dYf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDA4OCBTYWx0ZWRfX2W748cBlW2U8
 ElzLwGMT0cgSJAQpZCZCbl8zO4iICzxTTndZigzZ8RTg/BvNjU+WeHVPoYqPApYrv2wbYevaTt7
 w3bnJw2/5b6eIDyZMwR+Htg7puOyHhWdY/dQTJ65dFFAljRH81MR+uTV1U+FCAdeS5J3u8f8dDL
 IXX0vbGi6IVLCEw+vVNfl3OsnojX/+lnoNKvFAZxPChcpEh/0QhPup4QXTyDTwIgJqC2S0i8DI8
 VYF+TCZ5qtw7DagDYbkxv2VO3GslJb+FQzBLrMpk+Viu9qndneD7wOS/WFGOrCP+Ssz/bajyfPm
 MNOnqERIuQjYdvwDxlmH8zect7BcVg+0wNAHh8OAwjv7G4DywC8sMEdk1J73GWQ6s94YIE6OJLe
 OBWRtv52g58rQ5/e2ZhZaKgijQkn5g==
X-Proofpoint-ORIG-GUID: 5TPoqqGZ1LWTzJQMiXWgl2TJdGCt1dYf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_01,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 phishscore=0
 clxscore=1015 suspectscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511030088

On 10/31/25 3:45 PM, Dmitry Baryshkov wrote:
> Declaring link_nodes as a double-pointer results in a syntax sugar in
> the interconnect driver to typecast the array. Change the type of
> link_nodes field to the array to remove the need for the extra typecast.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

[...]

>  static struct qcom_icc_bcm bcm_acv = {
> diff --git a/drivers/interconnect/qcom/icc-rpmh.h b/drivers/interconnect/qcom/icc-rpmh.h
> index 307f48412563690049e944907bd80500f263f738..b72939cceba38e92154f6af5a93149337fa13479 100644
> --- a/drivers/interconnect/qcom/icc-rpmh.h
> +++ b/drivers/interconnect/qcom/icc-rpmh.h
> @@ -98,7 +98,6 @@ struct qcom_icc_node {
>  	const char *name;
>  	u16 links[MAX_LINKS];
>  	u16 id;
> -	struct qcom_icc_node **link_nodes;
>  	struct icc_node *node;
>  	u16 num_links;
>  	u16 channels;
> @@ -108,6 +107,7 @@ struct qcom_icc_node {
>  	struct qcom_icc_bcm *bcms[MAX_BCM_PER_NODE];
>  	size_t num_bcms;
>  	const struct qcom_icc_qosbox *qosbox;
> +	struct qcom_icc_node *link_nodes[];

__counted_by(num_links);

Konrad

