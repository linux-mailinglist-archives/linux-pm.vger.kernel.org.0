Return-Path: <linux-pm+bounces-35952-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D1CBD258B
	for <lists+linux-pm@lfdr.de>; Mon, 13 Oct 2025 11:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4E8354EF687
	for <lists+linux-pm@lfdr.de>; Mon, 13 Oct 2025 09:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE052FE066;
	Mon, 13 Oct 2025 09:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L4O6KkFS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4A12FE04B
	for <linux-pm@vger.kernel.org>; Mon, 13 Oct 2025 09:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760348590; cv=none; b=mWQVN/rrOoFyppZ2iB2gg9ZJ0spY6e+eOhRn27c8aTb1kZpgNKPsD1REOpFuI88UyEQT+MClng+B4FbJy37wBAOC5rX2+YeKIrN+BziX7yW0aetjVYHkkj3QFO79q1WmaT3JvaxYYwpL9N33MHPtJV5SzkHdti5l23KreAycYBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760348590; c=relaxed/simple;
	bh=JAorbLSuZiT53x85S0dpzWaGHVqHdTXASc19XDvMYJA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZgAx+DR90QgOF2NSvfewKLWftE49oGoGOzGHhfmAmCQO8z4gZNszbvZbmmNwi9AmUSdhrpCVVLvILoY7wlYBXVxcbMLZ25/L8StShOeMfVgGm9cjcwBK6bqchSFGYHDmw+Dcbs/4RoGeXtxDxWaRh6BnXrF5LS3PZfKcGdlanLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L4O6KkFS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59D4qKWn022864
	for <linux-pm@vger.kernel.org>; Mon, 13 Oct 2025 09:43:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PRoNub5jA9Gf7w1dXnkXsq7KXaxAcgcIuaL6MaCMdgk=; b=L4O6KkFSUN0UGwxg
	uwbjbdjSLlijcjeNnIYgyP5E5Rk//2L6Ag9bpTUMU5OQyUK8l3YyZjmiUqMIIuf6
	dx676QqUc45cBMCm4fXWd9CqSaiIl+59nvO0b+rFjWWSr1KrA7nSMmv3EkY6Fnh7
	mq64cK035a1tXA3RC1+CpxUPlak+0UJkqeOsAMnB+DN6HEDhKR/r+IhzKqG7UvEp
	XWdlGG/Jz5+DTEKjmN3LhKeQxzNkyNYR9y5yV2qEtNHeP5v0iv1+inSSFwGfbUOg
	4cfMZWbm+oYfG+mLGmhpjS/m+7qdUKp/cblKSoA1boZAWY7/UAfPSN1AeKwfFCIf
	Tb4dEQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49rtrt0ure-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 13 Oct 2025 09:43:07 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-85bb4e88394so180123385a.1
        for <linux-pm@vger.kernel.org>; Mon, 13 Oct 2025 02:43:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760348586; x=1760953386;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PRoNub5jA9Gf7w1dXnkXsq7KXaxAcgcIuaL6MaCMdgk=;
        b=RAn9l6ym4wbGpZaW6p5JxYS/1i1VALo3IrNFgFzfGbeUvAeRG9fgyoKpFlzzVQRH07
         HoVxTwYoAfYk1GZT9VxrKFQK4RQdV0bqg7Zn2EGtNugYxjBxihwJOeZigilkjW1A+b6e
         KtqhPH/ToEL8k43bU52ow1YPCRcKHHsokjLLpB1oMpieV7r/po1SiOTOs7vR04nwxauv
         AZlaHPqZPp3SwC5KRMNH/5dAqV5zP+1CuoTkXZWGV+gqO02RUCpL2jIYFZuOKHSJT+oN
         hQmwezcGeiiD1hX5bW1APPgi9QpkGhYr0ElKhuZdE2KNU4xW1e0159w3DGShTMA0fl0f
         S92Q==
X-Forwarded-Encrypted: i=1; AJvYcCUvg0+sWjWg0gxVTFjJoDjGoo3w1tvsY2zkm50Hyi+WWINEzMeBXlx+9Cec4ne0MvWX3XLu2r984g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwbqmaSShZF2tGYTR2ddvNLIAaMdfUU0by+kf/6ya35AyHTB+oN
	Hr34ZsZ1vMg5hjevxBlLoY0jDCSgLtPwLWF0AmiOZLSD+rUz0cVvze8aukpTRrFw759f1xOfqWV
	lR+l8BxTksJUmp17cEnhhMF06ESk/rPqhXvXo+r0OvCn3PBQ8+oS5m+VjpX31u2vsBAutkw==
X-Gm-Gg: ASbGnctYFN4eYkLNgzvfgKXxlwonBk401R7dLzr5iDDhgg6rNBBdhpLuBL8sYDInzrg
	MvYhu1GMxhU4Yfz7UVxHECjocrUPAHS+3f1lj7NI2uS/zxK+SswglUpABK4JenHHVPSd9571OI3
	OEWcgi+n4JgwEiGyKpgfUi8cT2LHl3ORlibu7ab1xI/HWiELoSoYJzlhJ1pnSW2VPpLo3koKjJe
	oskpNC7YoWqW2E+7HflC46BCCrRGzpnn81NDBp7ij/4vHHpm4ltIlQpTl2eeEsjaYpw/H/588Mw
	mHdJXrVDw2wo3pvHnFdYJyPnuUMCJIJycvLX93U7zaN1NLh/givZmgiPDHMW2tBNPdA1P47cEiG
	L9LNewiDfBxd+GSxGvOoqTw==
X-Received: by 2002:a05:620a:40ce:b0:883:3c5c:9077 with SMTP id af79cd13be357-883543faa58mr1929904085a.13.1760348586416;
        Mon, 13 Oct 2025 02:43:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZ37YIa8D275kZUNP9IUttcMgdGMHC6q8jTuYigjOj9p2rv1EtOiRJJX6OXhmRdZGU4PYwjQ==
X-Received: by 2002:a05:620a:40ce:b0:883:3c5c:9077 with SMTP id af79cd13be357-883543faa58mr1929902185a.13.1760348585981;
        Mon, 13 Oct 2025 02:43:05 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d66cc4b8sm894618366b.30.2025.10.13.02.43.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 02:43:05 -0700 (PDT)
Message-ID: <4b4ca560-d8e8-4d89-a02c-02d4245ccc37@oss.qualcomm.com>
Date: Mon, 13 Oct 2025 11:43:04 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] power: supply: qcom_battmgr: clamp charge control
 thresholds
To: Val Packett <val@packett.cool>, Sebastian Reichel <sre@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Fenglin Wu <fenglin.wu@oss.qualcomm.com>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251012233333.19144-2-val@packett.cool>
 <20251012233333.19144-3-val@packett.cool>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251012233333.19144-3-val@packett.cool>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: v_2NO6vbGh0fm6q_FxkfiUqGeOMi8JxT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEzMDAyMiBTYWx0ZWRfX+QZmU4KNEg48
 S40UJe9qcjm2WxGV04H1/mnf0pjzAmv6svIErc8jP7uAZrNGWTLC6DJTvPpMTA8EYY9UFYBPMrn
 ZrC/emgolgAqCbTAZfNiKMFzxpaAtJDtPVSwmv32s0N1Se/xcyp+wzL7HCt5CFlH1Sz34pAWseR
 aXd5JRuyMmOqLMCijs9iPedNi7FWb1lCBiXPAK6Ek+qH7MU9digaoi+mLbWhxGw99a+F0CPATxf
 UQhIm100m4teTzb56a5rOVMBMIIIt5g931cSbQmmIjHN08ig5stkIVVy+sxI+FV36DJ7hhK8MYH
 6UFaSSZU2wgW7RfHEHVqPxBBD5FggdATDjqTfilh1lGq42nxGpw1ejuvaGz5yarDIRtWZXf5FHe
 hCK/r0QUem1l2d/PTsj1N2JRRa7csA==
X-Authority-Analysis: v=2.4 cv=SfD6t/Ru c=1 sm=1 tr=0 ts=68ecc9ab cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=Wbw6XCnMcsYJmrvhT80A:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: v_2NO6vbGh0fm6q_FxkfiUqGeOMi8JxT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 adultscore=0 phishscore=0 lowpriorityscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510130022

On 10/13/25 1:32 AM, Val Packett wrote:
> The sysfs API documentation says that drivers "round written values to
> the nearest supported value" for charge_control_end_threshold.
> 
> Let's do this for both thresholds, as userspace (e.g. upower) generally
> does not expect these writes to fail at all.

The documentation says so only for the upper bound. You should
probably submit a patch to amend the lower one as well

Konrad

