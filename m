Return-Path: <linux-pm+bounces-41332-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aFoXOsKEcmkrlwAAu9opvQ
	(envelope-from <linux-pm+bounces-41332-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jan 2026 21:12:50 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 466906D5B5
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jan 2026 21:12:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DBDC43015449
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jan 2026 20:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C393806D3;
	Thu, 22 Jan 2026 20:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="J//hv1IA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bxI3HqN8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787E5377579
	for <linux-pm@vger.kernel.org>; Thu, 22 Jan 2026 20:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769112767; cv=none; b=FvIpO+kJAlWjdwcSMefo/Ugga5Z/16y0z6lTfLQxouhYsF1vqidpuEh2i4nMdDTsH/0eYNaP5CNhOCn3NVLm7YL+rKVIBb3WXb+5CRUBCt0x3GDLYEkd3m7G3v0/kBp8uVKpcsJNwbSHpuBN2QR4RlJ8vUFwpV5xA85wKkjiAuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769112767; c=relaxed/simple;
	bh=jduR3DPjsBwkiMNp2Y0wEWzEq1WczGpYl6c0/yCHp68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=guBYoeO74xSNYj7p1NQvEiykDUGC+YpDzJwn0N2vPgYj0Rx+xq2WKbFnOe0TzkqB680xCL48PFbt3/jzh2r9jtZQky+/u/HmIjOG5hFihXZ6qJS36tjebyGYj2UVX9ftMNQ6aNoq3HntBDNvf76SevQEnSoZ6ps34d8W0SJw8tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=J//hv1IA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bxI3HqN8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60MK7a2U3126228
	for <linux-pm@vger.kernel.org>; Thu, 22 Jan 2026 20:12:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=zisYaB/Ivr0GK1BsQaosZB/e
	Sa9vM5iFQU68/JnHF3w=; b=J//hv1IA5yLnI4t2zeYLTro4lGjPc36jUS98uVZ9
	hQN3EmapEstrwJWn2PCBHQdGH9F9tjdHoNv5NCBiwiEObw2O/WU54rnbUHeP1G52
	ALK0U6a0Ll6aA018+QXtwhh6XCo3qbFgcdlCt9iiLMVXv/uohhYxfMET1aeQnYPF
	fIgFdKpOmVsJRCRvFz++AGoSAut84SGRJm/QxrU6xXEfz25+O7hCxvPcxJuuszut
	pk9ymnhIe1EmNswM5Z9o4H3qJvaA6FZzn9EE0Jo8M7x49mP9M9xS8E+MozTN5q8B
	TXwEQwWz6ydxAsMZPzmpK2RTqlXXeG1gN9L5gzbmhD0Rgg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4buthdr182-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 22 Jan 2026 20:12:37 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8c52d3be24cso175049285a.0
        for <linux-pm@vger.kernel.org>; Thu, 22 Jan 2026 12:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769112756; x=1769717556; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zisYaB/Ivr0GK1BsQaosZB/eSa9vM5iFQU68/JnHF3w=;
        b=bxI3HqN8IEgqTk7cRbMxySaWsJWPzJ4zB22F7E7OPpLvPV4yBZup+yNrbdvQoYu6B2
         VUtj8QiYHZlUEzp4Cyzh+SIwUolxZIwASOEGFgbMXf6jltBSePVOS5uFNg5bWJuQ8DPP
         di4oRyt5/pH61d/UkmqUvK+jf3H8sYuWgPoyDXxVPi3ajzX3t4ZtY5vFC+rOKhSbhIox
         CF9XNrzIM9yhF34EZjNMdgtKjYwF/AclmSEHWwIwyYWkSVT74ND9mhiQ+UTMw+jv9Gul
         mgWq8lwUGfN9JxKXWvMcl+Vior8Dyia/mN1MCSRoQojF+2w4GTLOJHpbSxrfPVWh3Lzd
         d0xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769112756; x=1769717556;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zisYaB/Ivr0GK1BsQaosZB/eSa9vM5iFQU68/JnHF3w=;
        b=NP0Q2olk3r68vb1ITNHLbk4ikerG8QaRIXIAYuTmtsb/EyUJkP3SdwQAwFe5AIbB5K
         o1pXyBVs1YqaUMQEI/fUVza03YVwBAN+QWB7/RcApkZBKacugxGI8ub+S7wKxUGHc4am
         8NX3gv8TefhHHWmEBjAN5aiUw5HZvHj3FzocIh+XkL/6wkiKyWUcqa1d93wNz9dl+hA9
         TxeUbQXE7gA5sz3oNFRrpa58EfBkbyT4gWS8y2O5YoajRF7HYfOyjn1QabFuxMjB+c5e
         4otvpTD+/cuFdDO/aoE1C8LIIPuZwY3U1UNskYPIcmDVqJJwXLjhE74oRgQSQqr5hosH
         thBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMeSnOlVeTHoCb1zPTN0d9lgh0E7fHUx2Kw/s1BvJ4MdLn95BEJlmeXw2R/A699LO5cm/aC7rKqg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxFvv50rm60Hy0PEB1TxiQg5uta0E/n7WyWbBIos9CAbbIl0kQW
	H7mZrY1QvkUR4gjXvIRaKubHABmlBmgv25eJ73N57aukTkE6V1wcKfO4jBOFqZ9YTym4DUqE1LV
	6uVFbLFv55x96/rYF7cKyzzL897WYr7vI1pfQ8J/5lEP33bigH9cOAMD313V5tA==
X-Gm-Gg: AZuq6aJVI+rs7wiP8EOvSTO33tgTTLYIrlziH4wvkebMyVZXgVIySgPIIW3NwXioGd6
	LOgyJi3ywdasJjWt0XsWipIxMYAQIaRAn0u9dbxipLDt0hmxAdpPybIZNa2/KleefmsQdLX85Cq
	5n8YjYg+BTbscLAfx4UNJmyVPPduS3DEpq7TVTCAB+czXW9lNJU9t+WhhNegQefKXvdoHyq5Ckx
	N3FKWmkqeuuWkaZw2KgVmPE/ZOY0/MT+q+nukovBFETAWNxiqevlnXfOezlbpP58MNCO3e/qWsJ
	PpqhI10k+SReS7k5DKEdMndxoKiQ76xrzyZh12sYviaKRq5sVdwx8BwX1bbLKhnvhXdIAtGnm1K
	mffvBnJybokFVZMaE/k/OQSqijpHh4MAaK8sjGbZt4lyhAEicehTJJ9seciZmUQ97ql0duAnXOW
	ZFMfkzGjKqqvTEfzIc2BhTaSA=
X-Received: by 2002:a05:620a:45a8:b0:8b2:edc8:13cc with SMTP id af79cd13be357-8c6e2dbc8f7mr96950485a.40.1769112756198;
        Thu, 22 Jan 2026 12:12:36 -0800 (PST)
X-Received: by 2002:a05:620a:45a8:b0:8b2:edc8:13cc with SMTP id af79cd13be357-8c6e2dbc8f7mr96947285a.40.1769112755704;
        Thu, 22 Jan 2026 12:12:35 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-385da1a526fsm954021fa.35.2026.01.22.12.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 12:12:34 -0800 (PST)
Date: Thu, 22 Jan 2026 22:12:33 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Gabor Juhos <j4g8y7@gmail.com>
Cc: Georgi Djakov <djakov@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] interconnect: qcom: smd-rpm: drop duplicated
 QCOM_RPM_SMD_KEY_RATE define
Message-ID: <kcsfvumlcze4aoydunxsmj3tayzaxo2e2r4gkvflsvzryfmy6a@5ckigdbbscrs>
References: <20260122-icc-qcom-dupe-defines-v1-0-eea876c2d98f@gmail.com>
 <20260122-icc-qcom-dupe-defines-v1-1-eea876c2d98f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122-icc-qcom-dupe-defines-v1-1-eea876c2d98f@gmail.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDE1NSBTYWx0ZWRfXzRzeOJ17Dph/
 +PUQhTGErR36LWGnWqjcDPaw3sg5nKl8o388eHVlx9Is9dZO3w0nOTMb91Gj7PZD1zI8tf6qrOc
 P+J6XOmvuP5WGvliGoZZkdqcXECKgMHorbN8h1vDD52UFufTkBQO9zbobfxnZM2AKAGfCf346L5
 f5ewwoau0WvmYN3KHtLk5IEIWzpclQ5/wNyYzt6i7zcqbQk08g29j7l/NplMoxrUCNJVRPd5u87
 ipCIXWJaMuHZs/jqDVIAXzyBfkLbv6iAOZKwPa1/LmkenJYdgXhoJtxq5f587+eDVzsZZzmp+OV
 29L8FuMGqR+EFpKBNO38pWqw2Go74E7i9FGGWr10pGglPxhG7bHDAlgURwL8GncvXp90JpIzJUf
 dHp/eKMs57UXEoUCRgCzMZGf4agGyN5sYMxzY2fiafMznN80h+F1Jjxo8k3upwLMRGUDHDecB3l
 mA0//TbTkIxlg6rf5SQ==
X-Proofpoint-ORIG-GUID: zY1DPHDgSZwg7_lwH-Z_CxuMJk37vbFb
X-Authority-Analysis: v=2.4 cv=XauEDY55 c=1 sm=1 tr=0 ts=697284b5 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=hXMO4SuWbqAAnYZNQPcA:9 a=CjuIK1q_8ugA:10
 a=zZCYzV9kfG8A:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: zY1DPHDgSZwg7_lwH-Z_CxuMJk37vbFb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_04,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 impostorscore=0
 clxscore=1015 phishscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601220155
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41332-lists,linux-pm=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 466906D5B5
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 08:34:22PM +0100, Gabor Juhos wrote:
> The 'linux/soc/qcom/smd-rpm.h' header defines QCOM_RPM_SMD_KEY_RATE
> with the exact same value.
> 
>   $ git grep -nHE 'define[[:blank:]]+QCOM_RPM_SMD_KEY_RATE[[:blank:]]'
>   drivers/interconnect/qcom/smd-rpm.c:17:#define QCOM_RPM_SMD_KEY_RATE    0x007a484b
>   include/linux/soc/qcom/smd-rpm.h:52:#define QCOM_RPM_SMD_KEY_RATE                               0x007a484b
> 
> Drop the local define to avoid the duplication.
> 
> No functional changes intended. Compile tested only.
> 
> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
> ---
>  drivers/interconnect/qcom/smd-rpm.c | 1 -
>  1 file changed, 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

