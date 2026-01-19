Return-Path: <linux-pm+bounces-41067-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C56DD39EBC
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jan 2026 07:40:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0F183301D634
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jan 2026 06:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30372727E0;
	Mon, 19 Jan 2026 06:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gFATkz3v";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Q/LQ+OPc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82833271450
	for <linux-pm@vger.kernel.org>; Mon, 19 Jan 2026 06:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768804763; cv=none; b=WdgghRpH5DLOIm0kaJuKjlcmR0KmWud1BOWXau+xwqJ40NRdYU0hlZWIgIyXtcVJIiW6AryqZCxA/DrUGk1yy/dAeC0sVS9zulRksbB+iH7u9jfvIskN2TjjfWmYRUqg15nbdW3jdnSc7Ec4SnstfbIryCSSXbV96pI1MpW9Jb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768804763; c=relaxed/simple;
	bh=cdoIc5vD89kFd3CSCwCjRq+7uAe4L+ntCB8WZ7mF/r4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ChtutkIxO5xBZbt0JYSELME4wrMIt/899RbOSNwGgPg36NRDMnIPrHB0+HmBw6MxuP4C9/7LsACnBdCPrGPXln6C0577I8526MkaV5fVZAuLQWbKohC9COHLJ6XQgGUXvWAqYOK8OkNP7G8bZFCt3JbegkHJraDy+hmhcsqG3ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gFATkz3v; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Q/LQ+OPc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60ILGKZB3749060
	for <linux-pm@vger.kernel.org>; Mon, 19 Jan 2026 06:39:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=IA/eo2iVwvXN/TKZSuoLgwo8
	wSFQC43ZkLYtHdqBfws=; b=gFATkz3vD73RP3r2k/+R/W09xigfPTs6w8baLvM7
	HIoxueF9JanZrBYDu5Syh3Gg+h38kxwbehZ53HXhhTclUAG7vJOBHyHQ6Vs3xtrl
	DD4Nhj4SB7vBJmirTjpf78sOXGm/hGMlHQZOHlF3TjhCsGhYGRTTsq4hTpX2Cze0
	A4um35Zd7MYM0cM7Iyc1p1Nj8C/+8fKxpbaqWQOC7R6WCHQfx6ot5CuOJ0qwSc3b
	Yj0sC2beMM1OJUOhAYPBGErbqN5yX72KE9v5JRhUt9Mjo7qK2hMD0XANLu0P1oSm
	lzLNDo8kCS3xB6bm/XFR6h1clwhW/ct0mUVmzCMdck2fgA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bs79egyad-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 19 Jan 2026 06:39:19 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8c52dcf85b2so151485485a.0
        for <linux-pm@vger.kernel.org>; Sun, 18 Jan 2026 22:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768804741; x=1769409541; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IA/eo2iVwvXN/TKZSuoLgwo8wSFQC43ZkLYtHdqBfws=;
        b=Q/LQ+OPc2oNFR/oIoBMohF5HMcr2dSuL+uexYQxi5P3z+WwKcpBmJCo5oSkXQOFniG
         18CvsGknHuUrCQHfudFHajbg+ygcgpqFrAx34tDOp9adVT713hxLV8eySGvVQs52B5kU
         06lKkW2Xeu83CcgNjZBG3EugkVcWb2yIZL2sPvpbsfyNwB/zaQDociygPOW10R7X78jD
         ozJu6MV2wk7ThMhXchDF1HFE9kVDLgcUX8uyYW+B9NUeYCHP7n800xPdy23SO+ki6Ec+
         uk33QItCUFAic/jvITrjbewqqOq3mo5pQ5bW22/W3uABoruwhblcRBKPqv1Ah1FwjnGl
         ecyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768804741; x=1769409541;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IA/eo2iVwvXN/TKZSuoLgwo8wSFQC43ZkLYtHdqBfws=;
        b=Coc9RMoJpWfHfltdN0hp3lwBimO5BRFW9iTIk5qI0+3rP7+nx9kqrT/xTV/eLfHXwM
         84dqBBTKiQxI+hhu5eESZFtam8XtuOPcsYtkToLqc+VwmP60+tSq8dLlXWbTfsZBDJbq
         ZJxqxpXPe1taf4P1V8I4UN5VELIhP/+18pU+bfP7jB5A91fuqSkYg+JJpBwT8BuY5RYl
         jgeMWjuWTJ9V28WMJnOZkk7ciZrI2qlo/KPP/gd+XB1S9CpFsC2xP+IDiXevKZKv3ZvC
         T74if28B+7h9IvJBpZe9bjetxof/gUtuJEfEap/BQhtSh2bh8rUQIjY55U1wWKcqtiad
         fZMg==
X-Forwarded-Encrypted: i=1; AJvYcCV6i6oW5v5kSFMFVk/L7bIqDn7hxY1cdY/JfuklcTFSzwxX7cGKhteaerqQqvfNBK8kgGLzdCmWYg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzDB+7UYX9Lft15CsHSvPWLtUGw/EhWRNvtVXIqEbv+riXJlQMs
	jEf0i5whB/JpwQWJygK9MFmoYHEYNQm0GUpI09rGtGb1xxbvi8PtWSR1kE3P0nSczJsLTLQt7Te
	u71jUL1hdrbkhg+sMD2I731OhurorSgfV9mNzqU+rTHLPKOOuMGaPkn4wPols8w==
X-Gm-Gg: AY/fxX6sv2YXOHKLky5E6guT1k6ZVH4u564rmeesxfJoTLC8e6sCVdca0QiCwXro8+H
	kFurFDO4VwUKnS4zamrxVuP+QmHSKSbZA1IrdD28FJqmqQyy3K3ACfTJUjxgt/VbeIIxqv7uihr
	dnrcLb13Zf1UR5YqUDPJdSA63r6i33F0ia0z6PTkXAHn4bcSLnxEkM2INsFVqG0Pe1FfSaSwiJl
	lFI8luue435Z6ctDBzM6d4uUgnjQnp/1lAAVMsCGK19UIYqclALec/vEkes/AfC8H1AoZwhXkQQ
	jbH44Rl7niA2QatJxscj6/5pU8J0SIrf1vCaCWIvLEFrU2zJI/tIx4BJqVvXVjnz60BCZxuESA5
	lZcl+/g77stL1tHuPK+85O10fOvhJ1QP3Rnb6VwhUea2OXBvdiGJjmEGKnlIgZTSI59yAiWPp6a
	N+n32S18w2XMIjfIYkZ8OaADc=
X-Received: by 2002:a05:620a:4490:b0:8c5:c9a0:ac28 with SMTP id af79cd13be357-8c6a68ea37dmr1359568285a.21.1768804741496;
        Sun, 18 Jan 2026 22:39:01 -0800 (PST)
X-Received: by 2002:a05:620a:4490:b0:8c5:c9a0:ac28 with SMTP id af79cd13be357-8c6a68ea37dmr1359566985a.21.1768804740997;
        Sun, 18 Jan 2026 22:39:00 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59baf3a6dd9sm3083719e87.101.2026.01.18.22.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 22:39:00 -0800 (PST)
Date: Mon, 19 Jan 2026 08:38:58 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Val Packett <val@packett.cool>
Cc: Sebastian Reichel <sre@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: qcom_battmgr: Recognize "LiP" as
 lithium-polymer
Message-ID: <bih6lxs4u7q2kfe4kmid35cpmnqmvjltvzv4wrowah6x7v3tth@kptyk7bnmnhv>
References: <20260117210941.6219-1-val@packett.cool>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260117210941.6219-1-val@packett.cool>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDA1MiBTYWx0ZWRfX5qt4w7icQu8k
 XFMXLzw8ybdSrwgfWPsGN8I0+mvPtcqtmX0GeFFty/8p/karNHCIiRRFLxC5qUY1l3SJc28OEw7
 ae86sDTHCOTyieE0vx0qLDy2P94Zv99+OdCPNc46Ven1nv2jvhObWPGMI43o5neQZKKGE9rbKmm
 zfzLBPb6VydIt8mFURD8K3AjDlWUZiAcPaOSceFFHnZ+08va4a2ONzmF7/uRuNSGOjsGFgBOsEK
 DPgMpc9EOXJJP8zlb2mrTE/+m84eiIqH6hSclR8hZJzMTuucf0sILobI3ABcYkLl9k8atMSrBRV
 37Ak3lZ3bR9b20+HvqesAMJGARZBKQF2MKAJhVwiVgrT5E7GAB1n2qa93oLcFgRI6Vg9D7GWR98
 p4BN/s4JTRpa5Jj+k2vQsHBL4dGAEFl6FtPE8P4+/KkqyNDY4ABUhDmetqRO/TDLPYo8wF3G6LH
 msUWfM4ptNmxRDl0A6A==
X-Authority-Analysis: v=2.4 cv=NY3rFmD4 c=1 sm=1 tr=0 ts=696dd197 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=1UYfKuQU2Z-oU-oOffMA:9 a=CjuIK1q_8ugA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: NQqPTg9imNx2QCn5_mLjmTTx3PLckcqH
X-Proofpoint-GUID: NQqPTg9imNx2QCn5_mLjmTTx3PLckcqH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-19_01,2026-01-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 bulkscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601190052

On Sat, Jan 17, 2026 at 06:09:24PM -0300, Val Packett wrote:
> On the Dell Latitude 7455, the firmware uses "LiP" with a lowercase 'i'
> for the battery chemistry type, but only all-uppercase "LIP" was being
> recognized. Add the CamelCase variant to the check to fix the "Unknown
> battery technology" warning.
> 
> Fixes: 202ac22b8e2e ("power: supply: qcom_battmgr: Add lithium-polymer entry")
> Signed-off-by: Val Packett <val@packett.cool>
> ---
>  drivers/power/supply/qcom_battmgr.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/qcom_battmgr.c
> index c8028606bba0..80e701c66434 100644
> --- a/drivers/power/supply/qcom_battmgr.c
> +++ b/drivers/power/supply/qcom_battmgr.c
> @@ -1240,7 +1240,8 @@ static unsigned int qcom_battmgr_sc8280xp_parse_technology(const char *chemistry
>  	if ((!strncmp(chemistry, "LIO", BATTMGR_CHEMISTRY_LEN)) ||
>  	    (!strncmp(chemistry, "OOI", BATTMGR_CHEMISTRY_LEN)))
>  		return POWER_SUPPLY_TECHNOLOGY_LION;
> -	if (!strncmp(chemistry, "LIP", BATTMGR_CHEMISTRY_LEN))
> +	if (!strncmp(chemistry, "LIP", BATTMGR_CHEMISTRY_LEN) ||
> +	    (!strncmp(chemistry, "LiP", BATTMGR_CHEMISTRY_LEN)))

Why do you have extra brackets around the second strncmp?

>  		return POWER_SUPPLY_TECHNOLOGY_LIPO;
>  
>  	pr_err("Unknown battery technology '%s'\n", chemistry);
> -- 
> 2.51.2
> 

-- 
With best wishes
Dmitry

