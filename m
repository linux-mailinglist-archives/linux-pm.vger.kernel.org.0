Return-Path: <linux-pm+bounces-27614-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97497AC2A86
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 21:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4531A544FB0
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 19:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7D4299958;
	Fri, 23 May 2025 19:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="G1O7VeWc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E9E1B4241
	for <linux-pm@vger.kernel.org>; Fri, 23 May 2025 19:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748029338; cv=none; b=QIuoh4oCJGXU5KWdavI7DMBkgb8qrgltaBGs+QDQ5agydICFWeiLIIey2nxlRFMzPNUR307UT8pDyLnQrfll0VUlXGENRZJIeLpJ3Peyh79jHMz8ZCeA5+IXDbvnvDT5wS8nmyQkjEwcN3bdUDbM2rV9E95jZSsIx8J22c4XA4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748029338; c=relaxed/simple;
	bh=vggqRB8K93h/m3cLIrF81JSPM1zQ3Hx9nwM19BYafhY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XL8AhrwQI3LMJ+cPdUq7rwir24aPosxibR9fYUDCtvyoW0p2VPh4oXS3G6HE7CaD5SupMQDE3VsnS9U4daSPXb+f5yVeLOH/JuP1OuUtAcmZi8ach5nGk1x/ruo5odhKsB73lVQ3W80XbAXzmjxJiz0HWFm4CRqUi2SM08d63o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=G1O7VeWc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54NI2FUg003269
	for <linux-pm@vger.kernel.org>; Fri, 23 May 2025 19:42:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rDD8GO02V6xisZvlrexGxwobQQAXnk3SkEUC/8wzeJ4=; b=G1O7VeWcf0aMeNX9
	pvSRtOwpkX4xqzzI2UsHomt54kNwd9dYjxzXQ20gQjs6Vb+gFmuxxyP27kLoWcch
	GPJ7Hu5xTh3cpdy8JScSkc2J5gg+BAcKiJsYYPoCRDD66WIz31ajrgwRDhzRJwZ9
	5pedIktCpyqS96szL/MVzxmM1y8MeoVb22z7oMdRrGDnctvloLyRI2/Vf/4mc507
	jwkFZEq+FBobA1aDf14M9sEjJKVPuDjS6hPS+HC2ifuJx5/xRugMD9QMrVAHHd5Z
	Ef5kOjf9BWnlDM4oA+gO2KcWDG2OSqqM7FTMHf5FUxcLnnmjYYGKL9dVwjECg3Fz
	Khn1pw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46rwf0b7fn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 23 May 2025 19:42:15 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6f8d32c0b57so385416d6.2
        for <linux-pm@vger.kernel.org>; Fri, 23 May 2025 12:42:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748029334; x=1748634134;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rDD8GO02V6xisZvlrexGxwobQQAXnk3SkEUC/8wzeJ4=;
        b=lZz8HljXGj8/EwsFZjqK4rnh9hj4EIUThlKg3EWU7F4MvkIPt8FfHzw7CRIpjxzhEW
         8gnaY89rzKtmkfJrh+PPNLQZyLq0bXpR0bip2PAH9lxUDsqJEXSQi/0QEeYfvV6z/oil
         ec1i/Ko4ur6YhB6Ra/7KOFGIE/tptYKAmaxzxjD+IvECC9kieQiBlKzGKKZxBWIl5v7U
         Xznovh5e/slWf9sWp9KzgzW3l3eBgswMyg4Kiwq1Ya8auvoc6CO76qdAKAIoIrUzACSW
         +gQnfKlYkmuqv7bhCFuaNzCH58hDIiNBcbrJ5PRTBX46T8J8X48y/5NIz/XaVNoJICwo
         JObQ==
X-Forwarded-Encrypted: i=1; AJvYcCXw0zOKxsKQAnAWIW480Qt+yD92x1Hg5gZIWcNPN7gV7D8IKzIKiKIkyoariIFJR/KDez+7hkmF7g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxtXwiWNjG+8hj8NDXVJM/jxClEDY6YK/cS/QnlRYhhIS887ew6
	XLbMxaczkHcca6z8YtboTdcsRze21Cms9CjGSuP6JcnSFpZZQ5uThtiJoBM86CCEazQC8MdZ7YG
	8alcyemmDft+okuLdUG5JPcglMh2sweghkrP7yqrcwMquA9OI7Xfxcr+YmiEEtw==
X-Gm-Gg: ASbGncsW9aJp23Ueg+i8IsDrHemenU9KsHuFlTPre5ElfsY444GrtYrYu6LedOKTPg0
	fmsfsLPAKvEBuCV8CpmRbJuQCH9OIvcxL/DAGXPcwKlKErLWB7OmZhv100qB1/C+r6mPSpfAkUs
	uTPybhbzfAEWhJJNQe2VMmC3bwR2C+C0vPb00vCsSk6JtdWR10bVvMcV7smidW4chJq8gFKl7WP
	Dji6jbAfW28WScPqlAY5HcLLIdIqqG9D7V+Y+fMlBH995FkdnPCpDF6R69aeR9YJy2UPXZ7j2Bj
	J4LnVDqP35gfhRv7UOu6qJQrUbspv3yUnne6wWRNLL6pk0zOSFBtFVj/n5v6QtgLyQ==
X-Received: by 2002:a05:6214:529d:b0:6f8:471a:9fd8 with SMTP id 6a1803df08f44-6fa9d28fd01mr3864466d6.8.1748029334673;
        Fri, 23 May 2025 12:42:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEakNeqD7PjHCb2lw3PkVQBGbw2mv8vCsbXcVbucJNPHi/LLt7DhFiJHbVdrvpunQbrFKGGPg==
X-Received: by 2002:a05:6214:529d:b0:6f8:471a:9fd8 with SMTP id 6a1803df08f44-6fa9d28fd01mr3864236d6.8.1748029334246;
        Fri, 23 May 2025 12:42:14 -0700 (PDT)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d4b6d18sm1268078866b.153.2025.05.23.12.42.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 May 2025 12:42:13 -0700 (PDT)
Message-ID: <4a0ec467-b81e-4282-8e09-b7adc67eba97@oss.qualcomm.com>
Date: Fri, 23 May 2025 21:42:11 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/21] pmdomain: qcom: rpmhpd: Use
 of_genpd_sync_state()
To: Ulf Hansson <ulf.hansson@linaro.org>,
        Saravana Kannan <saravanak@google.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Abel Vesa <abel.vesa@linaro.org>, Peng Fan <peng.fan@oss.nxp.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Johan Hovold <johan@kernel.org>,
        Maulik Shah <maulik.shah@oss.qualcomm.com>,
        Michal Simek <michal.simek@amd.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250523134025.75130-1-ulf.hansson@linaro.org>
 <20250523134025.75130-10-ulf.hansson@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250523134025.75130-10-ulf.hansson@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 0OoMx5LhuQO34JMqTGuq5HkbT1jiJSq9
X-Proofpoint-ORIG-GUID: 0OoMx5LhuQO34JMqTGuq5HkbT1jiJSq9
X-Authority-Analysis: v=2.4 cv=ZP3XmW7b c=1 sm=1 tr=0 ts=6830cf97 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=_nM6lhH5BCRQepSfEGgA:9 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIzMDE4MCBTYWx0ZWRfX0zIj+XzNbq2V
 5W7/5F9T0Ls0377FaQXfwHndmg5Lt9pru0MphT2UNFgHEqeznhM/uQiAuMs6jhz7ms2P8JqKAVs
 3N6ADu2C/pLNMW7j+MLzhgwjbGD7X3IARUkw2t958pXop5djt42tdotHSces7EiYUH+W2msCUWt
 J58WtX4UG6PVZMkRuYHO7NoAyx6su7I0zoJHIGJCNJe3Uv/3xc9cxai2pIHS2vyEJjEZObmLKmb
 9uuIBWw/RgDCawhpTsqlGHX41SSJRfwRJj4qzEafoqHPj2SgFMVKML2zHelRqsZmQuL/cqgz3/H
 GU6JuVSIf7Nirq8lSRCub5ap2WfF4LaY2pOg9uZxpzf6PacQQ/JV9P5E85omASqX3jwYCo0YX89
 dmQX44ROmriDNKUbITfyjcGSj3TgO5PPPIsYAA1aEJRIxegDD+rfw6VusaS0FRcmbXOnuuQI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-23_06,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 impostorscore=0 phishscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505230180

On 5/23/25 3:40 PM, Ulf Hansson wrote:
> To make sure genpd tries to power off unused PM domains, let's call
> of_genpd_sync_state() from our own ->sync_state() callback.
> 
> Cc: Bjorn Andersson <andersson@kernel.org>
> Cc: Konrad Dybcio <konradybcio@kernel.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---

note: the subject is wrong - this driver is rpmpd, the other
one is rpm*h*pd (patch 10 has the correct subject)

Konrad

