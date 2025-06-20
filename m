Return-Path: <linux-pm+bounces-29175-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87CDBAE244A
	for <lists+linux-pm@lfdr.de>; Fri, 20 Jun 2025 23:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 268801C21258
	for <lists+linux-pm@lfdr.de>; Fri, 20 Jun 2025 21:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E893238C19;
	Fri, 20 Jun 2025 21:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Oj/OnBdd"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD90B238D53
	for <linux-pm@vger.kernel.org>; Fri, 20 Jun 2025 21:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750455882; cv=none; b=pBeBLtgg2K4IQIkJDyJ5wrDzF/g9t93Yftk96Qda2BFJBnI6kuFQtfhJ836JPAJAdrskKq4QjGfcwhKRYPiUa0eXClws/Ms2VOahse/SX+5GVeGZ7jY3PBAl3MEXti4+Hco4bWNCZULMfS8JZx9t7E6ifd9rHyDt0gT81f1W2XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750455882; c=relaxed/simple;
	bh=YzcmdcxDrTekUG/seNJPMliDEDlcxMooWnagOOkCocw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AKyDk/V9WfqgoqWSx4azsYCiNbF7TQK8dSpPO5bkvP/tiCp94kPcUiu5ztyzhXyI54JbQYNhx7vSjJQTdW7ONumld0wUf8Zu2mQFjAFRj6E1yvWmjcsehunVb3/pSFM/cSaOrVj3RPxPZa9ZS1KhWh2sLGDxoDT+iMUKj9+kDpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Oj/OnBdd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55KLMd5a018040
	for <linux-pm@vger.kernel.org>; Fri, 20 Jun 2025 21:44:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Ctwi2DOqfjI225KB6TOH6mB5
	C8TUDi02E4qF9W2x+qs=; b=Oj/OnBddlpiCI0Z5jn8m/1LaNtcIfXnwUDKZVarA
	8fhvrVFSdvAFaiBYnsfpznrEZZNwD69Gy9fEP5ssJSYSRNzgwNcZKD2Gzae37R/e
	WyKbY1QrBWF/QT+jOwEaUvnOOsWAM9OEMCFXNbGXLOyKCecPrT73RONWFtQrB5Li
	HF1YbVyEc1zwwKhzsbUGqGj0n6fl8QyjGOlSXIxslW3swm17MoV/sn2PjKS1RCVX
	PyFWWqDhpcmu7taBPB9NZLg5QUMH52GvcTasH7sHgFOIpch4Wvi+ecwU52MlqPhS
	AF3hBkoA6Ol08L+ySrLGnBMH6cK66CpAt2K1aNPvl4eCSA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47dfgpr14m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 20 Jun 2025 21:44:39 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7d400a4d4f2so121509485a.3
        for <linux-pm@vger.kernel.org>; Fri, 20 Jun 2025 14:44:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750455878; x=1751060678;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ctwi2DOqfjI225KB6TOH6mB5C8TUDi02E4qF9W2x+qs=;
        b=C3JDi6ZBsykz4HLRxGgFpMLpo37cHLyiibSUspmU4IiU4G3tPYvBU/CLPTO90ofFb/
         5LdtlzJV5oBbbeo34r25uAukXzzH0Ia4dDCaPkbWFKXozWrYIFCg7Hk52eJiyurbKgI+
         STPXuANQF5c1z05plbzi7W/sQin4OCIEnl6cn9u7t7JbzxnbapDetrHgDSiChnWsZbFl
         ie+Dd8neqvHxBdoK6w7+TW9POnx2LEfSWWAkJeiFpCpdDtDyGXCy/WuohYLsnkcgcF4A
         /leBng0OINQOV9xf2tDmPVLruvVzlLKS6f45KM4giY+FJJ30ayrp7PiHk4ZTmfw3Mg7p
         By7A==
X-Forwarded-Encrypted: i=1; AJvYcCXty9O3JBxQlIFHJU3yDyXtu0qutOAbea78XFxnCykiMtdQhNbSLwW3jf7Ti4gww9pkM1fbvg1Mng==@vger.kernel.org
X-Gm-Message-State: AOJu0YwGglvU1VoxNXuxj+B7EK4HqtcS8sEVzCZyGdJQ4R/Bo55JbcFP
	zwsmtKv4GdzD72tlVyg9/3mirzGENoK51c3gaXdAc+ivAZPnxSLYkvtFtmVimXf6LH4Q6P58UUp
	ubRQ5ch3Rv3bzeIYxO23i4MZJWN+iJW1FMcYMjK8u0O38lI4V3Ad058nECt50ww==
X-Gm-Gg: ASbGnct1G3eV4UvzHZvmLzhNhDQJ0n1F2ENjbW+dPl4DrJENpxti7Z3kqHwktFltmwS
	Rshok1euGzQ7LLBmq49oUlP4b9rCaPGkt2RUanMOzVsrWsJd21QbWnePXhfMnLRPrJ4VZdIs9MC
	gZltdEH2cqCO4Q1VmNpQFZ3t6EMIWgI2Zd/5BvYfeUSHUREyEsbaa0DyFWcNEZIEsJZD/m61dvS
	rl7Bp3H/FJYcfZtp+nCpMk4OY27bC3HG/n/Z0McevkfO+9mZ26tm8gnCsRd2Rl8qOldwIU+s+Mt
	0k9eXwRGzTwq7bWW/ZWl4ZSwsCHxbd6Rh/UyNnsuKh3PC/2gZmwWaFnHcuViGAWOnTutWpBrqYj
	lMFqulDc2Z3zErDRk8JgzBilxq+hqnoNHkg0=
X-Received: by 2002:a05:620a:25d4:b0:7d2:11a:5d07 with SMTP id af79cd13be357-7d3f994c66fmr697119085a.51.1750455878658;
        Fri, 20 Jun 2025 14:44:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZvdnmqP63O5PRRl19Y/9Q76MA6K05Mv4i76MtyquHA2RkydgG8Ih53vLnCssRj5N3PUcNOQ==
X-Received: by 2002:a05:620a:25d4:b0:7d2:11a:5d07 with SMTP id af79cd13be357-7d3f994c66fmr697116285a.51.1750455878264;
        Fri, 20 Jun 2025 14:44:38 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32b980a3631sm4223561fa.67.2025.06.20.14.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 14:44:37 -0700 (PDT)
Date: Sat, 21 Jun 2025 00:44:35 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Casey Connolly <casey.connolly@linaro.org>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 03/11] power: supply: qcom_pmi8998_charger: fix wakeirq
Message-ID: <e523itylvfmikypnic7exgrnrtr6ocjmlvtozmgbhqos4lpcdm@rfsqiezqb5p3>
References: <20250619-smb2-smb5-support-v1-0-ac5dec51b6e1@linaro.org>
 <20250619-smb2-smb5-support-v1-3-ac5dec51b6e1@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250619-smb2-smb5-support-v1-3-ac5dec51b6e1@linaro.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIwMDE1MCBTYWx0ZWRfX5dT701iUPyxo
 hTqJn03wXFokamHO5Y39a9rmILYltv1cH564HEf9J+aD22KmHYxk0B1zpzjRbizgGvmSvp3qR8U
 XlspDBA3Mm2tFNNMQDYBOVJzUaAVhoiQHOAk/GBVAf1rrDTOVBT95ZDvttBJrP9Xfe/wT/mc6y9
 h3MdG9KdJLuueS4A1oqKwtkYhKTOu+0gwC5uTUIybIToamOypSLiP2su7+WwdhZKL9A11kYBG5Y
 hACWzJKP9JvUs+FxIMT+bX4xuvaMHTzQO1AYS/8pZfocRz3+7mR0GJ0r3zCTKePRNVELEUN5677
 F6M01k75k3ydlQ1mOPbcygPODgMGJmLRcFhkF5mdMRAiN7YWtMJBpkTsrR3KI6PgJOvo3ZX1+9L
 mszNFY9cPCUu6+TrMqZup+Hp6teHAtaQrSV+NRl+AgryXkfvPq4JR4xW0vPVKMFzx8ZRHFL5
X-Authority-Analysis: v=2.4 cv=eo7fzppX c=1 sm=1 tr=0 ts=6855d647 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6IFa9wvqVegA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=QHKHbuR_x138-IVXrqQA:9
 a=CjuIK1q_8ugA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 4m_cOnu3dgALaJcqGavomRWcLXQoCrap
X-Proofpoint-ORIG-GUID: 4m_cOnu3dgALaJcqGavomRWcLXQoCrap
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-20_08,2025-06-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 mlxlogscore=906 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506200150

On Thu, Jun 19, 2025 at 04:55:11PM +0200, Casey Connolly wrote:
> Unloading and reloading the driver (e.g. when built as a module)
> currently leads to errors trying to enable wake IRQ since it's already
> enabled.
> 
> Use devm to manage this for us so it correctly gets disabled when
> removing the driver.
> 
> Additionally, call device_init_wakeup() so that charger attach/remove
> will trigger a wakeup by default.
> 
> Fixes: 8648aeb5d7b7 ("power: supply: add Qualcomm PMI8998 SMB2 Charger driver")
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> ---
>  drivers/power/supply/qcom_pmi8998_charger.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

