Return-Path: <linux-pm+bounces-32165-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C144B2091C
	for <lists+linux-pm@lfdr.de>; Mon, 11 Aug 2025 14:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20FA01883C42
	for <lists+linux-pm@lfdr.de>; Mon, 11 Aug 2025 12:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D8133D8;
	Mon, 11 Aug 2025 12:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Iuih7vAG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384B242AA3
	for <linux-pm@vger.kernel.org>; Mon, 11 Aug 2025 12:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754916343; cv=none; b=VERK0wUoqVXUTRAg8BZmcMxNYUiVVM988lDG6VeAbNmJ7nYBDw3dVowh0dmXUmwwgeIr93enmy4YNusBI7MjJ6L8xHhiVTuNmL1gTgxyVJ+40uIIxLiFLJ8c+t5Wg5CRUAip/Lic+RoLVCG7EFAjwzEFgooHjACiwKGlDIxb8FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754916343; c=relaxed/simple;
	bh=jW5Qvse2VjAQgBMlkx0ghwxP6d3zSzl6DpklQz/HXq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ddgmU35B2GENrDJDRPlxuOtTw5uIC0oDTovpYVvYfPvAbVbtAi3M4voCCgLMFF1xKw+hEk3LuUU3M2KkIqAyDV/gkFl8tpeL23asDON7VamW+cF7xfSaxfgdUmti2gJMX06TYccxLDxDDocfKCGXhjPkdrcVkqkIim1NuDr2UAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Iuih7vAG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57B9dCUF007639
	for <linux-pm@vger.kernel.org>; Mon, 11 Aug 2025 12:45:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=pT9ohewNtPwm8XYt5Nk3ZAoe
	mGBHmM5ljwEdjo4ftDE=; b=Iuih7vAGr956+NyImXauom3d6ITOXc7qap30yyTV
	R7D6/c4BW+X1ZD5N2PjbcrbD580GzH3J456uyczrNYnapSnpkD4fAIE1ntNnl5C+
	GJoGyErafNsaL2E6NNJLMdJ8jsAiKIaGQFoD/HXfiuzF4kRh2GEDqwkod4yQOiXl
	CWyBeDcTWxJsSAnaIBAHkwK8ihB6jtjR9pbIn1R+8dIr6FIwLfOXiUayoWyWOe+F
	Jh6A2rBhyVGVComgkXwRGhQqYLljZtNkEDbe3ysJB67SYjcjE5dygDYDD3k+CAwa
	LkO/gksYsx0r5dpP5WD5O8SINn7ge7W/qBh5jOozmKievw==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dv1fmp6j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 11 Aug 2025 12:45:41 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-70743a15d33so97753006d6.0
        for <linux-pm@vger.kernel.org>; Mon, 11 Aug 2025 05:45:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754916340; x=1755521140;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pT9ohewNtPwm8XYt5Nk3ZAoemGBHmM5ljwEdjo4ftDE=;
        b=lzCDyEITKHPqO4HagLHQ7ek7xSbiAc0mnJ+h08zTbbRIZQpJPR8LIFLHEBy7qXm5Fm
         4739+lqKx1TkHgcJS34zkaM5lpqB56Xs+75e1CLTndY9n9jm5EC3x45NNmZO2wRHdWEM
         KF96CEJn6AfDIQrr5kTn4KZH+mrhpVLFamv55ECdE/J9kBYNuqpyNzFvvNrAjUiL2OIe
         rHNsqSriXrPn8OK8/bPQTGbagjgp2bubDlNnlmDJydl3tKRsfSqhXBSVl6CG5YRaKGw8
         F/D0oNV+Cz0lCzp9FnrKKKL5Z2+6TLtbbiVLCMa04/OcTa9y6e8OdzexXzJ83+obBgFk
         m7CQ==
X-Forwarded-Encrypted: i=1; AJvYcCUY+cuiNmXYtllqgj9mW2FDRSiyBhKDwzaJg3nj7azQJOylXQXuTgW1MNKv3QiU2W+iJ/d9NyZJ2A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwTy4N9ZrZXq6t1vQFb/8Zc37tq9bhZwjakWL0DtKzBbNN/Avqz
	iIuj385bPkUQlvwI6TzYkGKmfa6VHHsDaYdb+4K/CJIHWuVM2Ruw0AXuqvax5IgRs68+9fKUhcn
	BfGHVWVQAZuASxnXsdbl3nUH4Oi8dCaQoVJetYsqUWrBQuALdphTbNkrD2Sr+xg==
X-Gm-Gg: ASbGncumDhxWx0fCf4yMtJmPMDViz3j8l2vMkHO8y6xiVVtZPz5cMYylPau9VRSQT9r
	TRJJRCVwpGEMsZ24e1kFMa6T8Q0eQEK0CkfxwMvntHwpnKIcI2HzP+95NzQas/7MX9LE2qIdpR5
	4srsNV61j4H7194Cpe/kzAMvpSJwueEnmVAss0JBX+oopk1484Ck3wjbFdMCTb2SRezFtRRByCF
	Ck2Bm3YJuapAScvSTBu215dhvqs4VE9mgN4YU210mvxdjI3ji4eyzIiNoy/Rmh34uRHoD6x7jwm
	Y/JxPczy7tETG1lgz1204y7H2ZHNpcBsXD6tlN+sId7NnRn1d3rr+aVHhDhwiVMv1CbdXOhlApr
	xlASh8X2NjRUmernpvVY20ER/d3315f6NuTgoYgBxbkiZ1tQ+/V9b
X-Received: by 2002:a05:6214:2626:b0:707:1b24:f305 with SMTP id 6a1803df08f44-7099a1fcfb3mr151745146d6.18.1754916340038;
        Mon, 11 Aug 2025 05:45:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNeqcsczlEMfgPrp2sE30gPgQQo08+/icjLACF9Uyg6u4HdWc5u3IL4q586h1hVCxd/FxkBw==
X-Received: by 2002:a05:6214:2626:b0:707:1b24:f305 with SMTP id 6a1803df08f44-7099a1fcfb3mr151744486d6.18.1754916339187;
        Mon, 11 Aug 2025 05:45:39 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b8898c0e9sm4233296e87.13.2025.08.11.05.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 05:45:38 -0700 (PDT)
Date: Mon, 11 Aug 2025 15:45:34 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: chris.ruehl@gtsys.com.hk
Cc: sre@kernel.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, ruehlchr@gmail.com
Subject: Re: [PATCH] msm: arm: qcom battery manager add OOI chemistry
Message-ID: <tvdv6755c57x5b4yjtqopshxtdjl7eoor5mxqh62k47o6dtcdh@znug23oizqbw>
References: <20250811111026.24292-1-chris.ruehl@gtsys.com.hk>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811111026.24292-1-chris.ruehl@gtsys.com.hk>
X-Proofpoint-GUID: gJPpwaIEHCVKIfzXbwU_AB-CS4iG3s5_
X-Authority-Analysis: v=2.4 cv=cLTgskeN c=1 sm=1 tr=0 ts=6899e5f5 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=O7zmUmNSAAAA:8 a=EUspDBNiAAAA:8 a=XW9AV8nKKixspLQJyWAA:9
 a=CjuIK1q_8ugA:10 a=OIgjcC2v60KrkQgK7BGD:22 a=IJxu9zi5bFdC9NS7oKyv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAwMyBTYWx0ZWRfX15nl3b0EbWaJ
 nShFj78gb2BJRIb4eXGs72fIFevRPb03ET2/tXfjCgZPbkZ5sdECbmSdfZQ/gFXa171RagNKzIO
 8SRANuoRnca2t2KHeV7lGaDDlv0Z990B9/6lTFh2fAvAfO3HTM9x6jpK6NUGr+zdOUkP15J8jMt
 bQ2Gug8PhWwkvXIJvVyXl++m0tSHRerYOZATAE6qaiaK1fkNNkHceuFSfrk9SG/8nPKQ6+egSt3
 hGOnpJqQiTFAg6G6+yxob261PqA3byRZVhh3894Y5gwa3aVLY/h8x8lwJ9vuRZDkuf3f4fNJpWN
 LXbPMFA7h4dQDxKVERMO184tq3Y/No1RcRrNykNc0ZNyHSXlYV2PC8JwdUfW5BUcnfFIFJugtW3
 wCW1rrRN
X-Proofpoint-ORIG-GUID: gJPpwaIEHCVKIfzXbwU_AB-CS4iG3s5_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090003

On Mon, Aug 11, 2025 at 01:10:26PM +0200, chris.ruehl@gtsys.com.hk wrote:
> From: Christopher Ruehl <chris.ruehl@gtsys.com.hk>
> 
> The ASUS S15 xElite model report the Li-ion battery with an OOI, hence this
> update the detection and return the appropriate type.
> 
> Signed-off-by: Christopher Ruehl <chris.ruehl@gtsys.com.hk>
> ---
>  drivers/power/supply/qcom_battmgr.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

