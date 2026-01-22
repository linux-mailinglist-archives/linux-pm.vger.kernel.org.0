Return-Path: <linux-pm+bounces-41333-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mKxYA9OEcmkrlwAAu9opvQ
	(envelope-from <linux-pm+bounces-41333-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jan 2026 21:13:07 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B97D6D5CD
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jan 2026 21:13:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 01A063018BDA
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jan 2026 20:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD98A39BA48;
	Thu, 22 Jan 2026 20:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HYJyEqbH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WoRs4avW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4597E2EF64F
	for <linux-pm@vger.kernel.org>; Thu, 22 Jan 2026 20:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769112781; cv=none; b=iUKoG38rgDVUB7Z316YvhtXY5i9VW+d+L7yhFpUL0RkcD6wfZEo40nyMTfPRSm3RFLHCQzuwHsHv3LMEle/D84EMV54JS9/BQI+73jNCG1y+rv16ITxv8wjlYosDYHHP6SZeOaDzg1HJ/3jET2LzpJ2QqDv2FwSbfo1y9hCpPus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769112781; c=relaxed/simple;
	bh=kETdlgq3mRj2CGYHfDUfs8Gq8EgqBAAq6aAIipvcOaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lic8X7CseYxKFmzv83vD2NBynHhLvLZ4E58ZT561RmJN/g2N+QKTDE58CADjWeikwmA5B84Qq6oPqZeCC8dKkRbyBGNWeJnyWoWmBari7hAfMzDQs4/Oaexop47kOwKSDSLGwOxHRquScQMpIl0xGnu0o+OVkWd0XalXg00GezM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HYJyEqbH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WoRs4avW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60MK7oNE3811192
	for <linux-pm@vger.kernel.org>; Thu, 22 Jan 2026 20:12:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=SA1JXQKeHjDTC4DubGlj145P
	/VFCD04yuCXGDLkeMt8=; b=HYJyEqbHZG/PKicNDO+0npA72awEEQ8KBQrpQRyK
	6lgFJ9FS2kVihGkXicFcbntOu7Ra9Hxs0icureWv8IVP2yKfYowYBZtJywpBJUdH
	2UNbYFCNnZ+ZHi1NUD1KfvVkKwWB25+Cpz5EWRpPWBUIZGKQYgL+a/YUDqji+VWY
	orWZYK3zNEWX17XCpVNmLHX7YrrFZmBSolxF1HS90BqTUJ/fKmyi06cG1z/tQ/0f
	ND4vPZI+NzEbavI9296Bo77sbURK0PTeZCyySTXJ2FCfSeVOa9KI8gV7f0SOqrKg
	f2vj4scj0FkOLDpI/jZhwKq/gT5HoX5ewcSa9Aa7r8myGA==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bujq19x5g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 22 Jan 2026 20:12:53 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-93f6a0da26dso2754632241.2
        for <linux-pm@vger.kernel.org>; Thu, 22 Jan 2026 12:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769112772; x=1769717572; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SA1JXQKeHjDTC4DubGlj145P/VFCD04yuCXGDLkeMt8=;
        b=WoRs4avWtaYkQ3HE1xa9puap6fMjSMVC5MyWW2QW4gMz2Yz4RU5FefJNjWhTlKrbx1
         q+FA0E/qHEeWwz4Bpbe/8UiMkitngdglAmvxOCK4YtJFnTwxXs7TKj8uBvhq3iii2nmO
         YwGRTrlr/St+d+9zm637OoxsiPe9eCuME8hD/kbkowlJcQtL5CCHC5IkXtGUrvFiaWMF
         sBB8LS+uTrHcPBZzhTVp40MYdkYUWw/r3133jWLmDw/dQ8uoZVKhEGpx2NJW9UvCA7V9
         jsbQZsUSq7vBvRCn6HtGT8c5qkk6fAMUIF6w6H4Bm2jXe2JjvwD9FRDmMFpk2hJXAZSL
         khOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769112772; x=1769717572;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SA1JXQKeHjDTC4DubGlj145P/VFCD04yuCXGDLkeMt8=;
        b=vVUy1xtq3xfsxu+GnF4FM7iC/0pESt0RtHn7O+LfarG+AiOR/Uy230nq3KUS0vh5ue
         pOl0itqVblAbwJhLR73CB5KxdjzZYLrObrX4x5DAu+jz2D9aXTY6WDYikJzJCEOoDaEy
         WFhriDm+eRWF1OMMWSzx2PIpB2dzGZOmPl/ItRaNnYMi55OquZhI8BdPfirf0YYG2D0o
         XlpDOgnn49olBpq/ZdevNCn8h3WSPuv/zLt30FZBqXym9Q/dN5WvLAJzSS8Bjgaj8Sn7
         FeqLITGQAZnei/u7Jgtpjk/DbnMBJTIM7H5webZcZRzmeAI9Agm6HjLbOVSG4eObsuLT
         pKhg==
X-Forwarded-Encrypted: i=1; AJvYcCWJVrSlIc07vF/2/lT6nXZoMaZvrJb2Xe/HgjhdHX8DDeOkY3te6m96FUnrlwRHuN0nQlobcPEClQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyC4N5+8xN0jz/5jaW3n3yH/whOUnq9NQ4sBdv+zb96BJcs35on
	+z8kmyl2eRKUnz7+JUHLAEPCTPYaTZFp5To2MKMxKJnOzlXS9Wz/3QqUuY8NITDZo+TMOjQbDq6
	UxZMII43rFbbQj7DGYqaULQyCAEJhG/ynP6c9OMTpVHWUSXx69pANWMWFWFkoLg==
X-Gm-Gg: AZuq6aI9RI/TkqXunQHJ6V691BESBpgeAPMZIOg1hRvKZ0FRPTc/ecIm3XBnX1iztWG
	3sm/1D0YNVLseFhpkh5KWnfLxeN7ne6v7WonabZV+1dIfEevZqgLMzZ+vbxh8GIuIVedDjX8vXD
	17WBOr6y/u5Ni02rEmMYh7hr7ByI2RipK8bBKJ2JHZ6ofT7W574QBRGbgJHVgpAF+Biqeg54qKh
	/24NdYSvB3vouAweVhd3e8WnCd8WCckqVKS2+Y/fHtt47Yd9fLEZWIlzrr9Fi0PwtHdSWXjsgp6
	SNsMUh3yitruCJLqIzoH4KPeemyW4Wj7Jd06XwBPW7wypX6bgYzVMFrmrUajfyXMH/ers6JYZt8
	T4fDCzbWQ3nU5LWHoRSp+1J3TEgEnndfPPRU+0xp4Ih+fwIGdmPsK8i9wVSTqxb6RW4LmJyEcU5
	nbNKHBrgS5LdSkEBNKbyH2Hlk=
X-Received: by 2002:a05:6102:32c5:b0:5f1:9641:4f4e with SMTP id ada2fe7eead31-5f54b9dac18mr306682137.8.1769112772392;
        Thu, 22 Jan 2026 12:12:52 -0800 (PST)
X-Received: by 2002:a05:6102:32c5:b0:5f1:9641:4f4e with SMTP id ada2fe7eead31-5f54b9dac18mr306677137.8.1769112772001;
        Thu, 22 Jan 2026 12:12:52 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59de4918679sm115343e87.63.2026.01.22.12.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 12:12:51 -0800 (PST)
Date: Thu, 22 Jan 2026 22:12:49 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Gabor Juhos <j4g8y7@gmail.com>
Cc: Georgi Djakov <djakov@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] interconnect: qcom: msm8974: drop duplicated
 RPM_BUS_{MASTER,SLAVE}_REQ defines
Message-ID: <63n5yafjvmq5mwqowokh5ecobi3zbzflx73xhheqnwhdke6fat@u7nn2i3qumqx>
References: <20260122-icc-qcom-dupe-defines-v1-0-eea876c2d98f@gmail.com>
 <20260122-icc-qcom-dupe-defines-v1-2-eea876c2d98f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122-icc-qcom-dupe-defines-v1-2-eea876c2d98f@gmail.com>
X-Proofpoint-ORIG-GUID: uUVwQ79LmW9ZF4TBENwcuEWbsyq-mCzW
X-Authority-Analysis: v=2.4 cv=O480fR9W c=1 sm=1 tr=0 ts=697284c5 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=ucfLbyYKLo5MbnlhLQ8A:9 a=CjuIK1q_8ugA:10
 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-GUID: uUVwQ79LmW9ZF4TBENwcuEWbsyq-mCzW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDE1NSBTYWx0ZWRfXzA7OMrxZTrPj
 IFzkKxoc0GlDB/Bns7cEidCf+tUtMHRaDo0wmC1MPPX048Spk5eU4fPTv/z8rclTGzMHABz3+yg
 psrFmt/Ws2PDAQ1N7UEvs8xTdLlXzdGfu/Zggy1Ag3TqEGfQlMTlltN51u0LTruuusju1Fq5ojf
 xQTj5P8x+gaWwWGiC02KsahJM5aZ2XtZbEbV3J7lwa6l25FsZSc0bgcrYN7Q0yxZIuIj5E3pWdP
 Nbjo7yzDU0RPErKP7MVy+ZPRxBbCAuZs4rZt4hrCUY4WG1BZJ4XLGFKRQyKC4EtTc7rHe+L8rNv
 dE9fwidlKUV98qiYWzgW/VxB6rEX2HjzfSzgqYIfultPQIqdOa99aYfXJQ3oLVgYzJdPdcwsles
 Aeo7YsfrAfUZaTrih665Gc9eNsPkNIB5NBfmxn8goYpFmOXgOyGFaHJBqFkkUJfUOVTbiT3gMUA
 qGdDwj9EfohQULaR4EQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_04,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 bulkscore=0 spamscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
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
	TAGGED_FROM(0.00)[bounces-41333-lists,linux-pm=lfdr.de];
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
X-Rspamd-Queue-Id: 4B97D6D5CD
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 08:34:23PM +0100, Gabor Juhos wrote:
> Both the RPM_BUS_MASTER_REQ and the RPM_BUS_SLAVE_REQ constants are
> also defined in the 'icc-rpm.h' header.
> 
>   $ git grep -nHE 'define[[:blank:]]+RPM_BUS_MASTER_REQ[[:blank:]]'
>   drivers/interconnect/qcom/icc-rpm.h:16:#define RPM_BUS_MASTER_REQ       0x73616d62
>   drivers/interconnect/qcom/msm8974.c:176:#define RPM_BUS_MASTER_REQ      0x73616d62
> 
>   $ git grep -nHE 'define[[:blank:]]+RPM_BUS_SLAVE_REQ[[:blank:]]'
>   drivers/interconnect/qcom/icc-rpm.h:17:#define RPM_BUS_SLAVE_REQ        0x766c7362
>   drivers/interconnect/qcom/msm8974.c:177:#define RPM_BUS_SLAVE_REQ       0x766c7362
> 
> Drop the local defines to avoid the duplications.
> 
> No functional changes intended. Compile tested only.
> 
> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
> ---
>  drivers/interconnect/qcom/msm8974.c | 3 ---
>  1 file changed, 3 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

