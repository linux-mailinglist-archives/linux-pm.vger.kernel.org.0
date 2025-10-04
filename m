Return-Path: <linux-pm+bounces-35714-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F925BB8A11
	for <lists+linux-pm@lfdr.de>; Sat, 04 Oct 2025 08:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A33F1189196B
	for <lists+linux-pm@lfdr.de>; Sat,  4 Oct 2025 06:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B1F1DE2A5;
	Sat,  4 Oct 2025 06:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nEJ/mhuL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003B4188734
	for <linux-pm@vger.kernel.org>; Sat,  4 Oct 2025 06:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759560364; cv=none; b=XuM+pL51kUsAFKUSXoEzJQF3Qro0xlZRay6bRDophOJWfZIKhkD9gYmv1IJYogVjVxsRI6IW/r3xjPvJyOk17PLEwue+vLMD4PEhZvvsM2D0RlXyLKPntMKGdf+WmFQeHb29f5a2rDOrx8XkcecS6QFpb3U3HsnI1EE8pahwA7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759560364; c=relaxed/simple;
	bh=Tr6GBYqy+IzLd8uqM33CAtRY3paCCFvnoi/vQfjzRKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lYrVEn4JlZoUfs76xltv4pDUCC3dPutdI1h2RN4k5pTOFyA83FlAGe1LIVguqk6NY6AfDGIK83bfwc3WAJYQP1eL908T3sEQtjB17V2L5BqczVV2RGKlqAuv7nn31Gif8AsowiDMun7HHy1luGw32H8mQFEn0kvRASwPsSgQgNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nEJ/mhuL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5943PYV3024784
	for <linux-pm@vger.kernel.org>; Sat, 4 Oct 2025 06:46:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=T/5jf8viW1Ms0TYa2j+4TJfG
	uZOdpLLk19JW7AHS0TE=; b=nEJ/mhuLLXgISTtPjE5OngC5ziHVqscmEFKPBtJ6
	EeQKlhY88+L+pxPR/XFVAQRSQRG4ZVPTfpuRrzEtbZ2FMXaTlycOjthLDUUISWC8
	S1dmkdKp6cvzX+Oamu8eChprnIG+Wr3lJQry7WTXL1N/gJKba/IzGY3z/Y0/VQbb
	fr8SyagsLV4so9uMM17qtA2GY54fP6Zyppv3YBTGoBbQ6orwUAvc8Ak6dpRlBBfA
	dV1X8yhRqpgVlRpe1ZedCSZXhbGQLvtGkYUx54BPQlsRfjQoY4S37YUuxhS53vFL
	H3DZEy93TbhBJ7hcFrXgcVgJxJplhHSfFiOx+6gI5cU1mw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49junu09j0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sat, 04 Oct 2025 06:46:01 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-863cd58a92dso655736185a.1
        for <linux-pm@vger.kernel.org>; Fri, 03 Oct 2025 23:46:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759560361; x=1760165161;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T/5jf8viW1Ms0TYa2j+4TJfGuZOdpLLk19JW7AHS0TE=;
        b=IlL0SAOP8k8w05lzoZfa3RtKBZrBT/xne+ero3FCvpBzTJEBk2jVQw51xgrrgXMcBB
         ++6LlHJM01yGfSgO8/iGBhksK6axntub+NLfwwtUJIjEvUM6Ejxn1rwMi7UusvUgqnhY
         W9gP5B5aN/RmOHEITuUT6qokBPoTKWVq1UZJoP0ZTqB43JCCpwpmv9Xh8tCvjJwV7MwF
         2Cdi1O8GNFdQt0p621c5/TiF9Odu2iSHRX8ukhpZ99X/r1SgGq1pe/MP7EYsrkId+cQC
         Z2nT1+BoSo6LI04zxZRUR0eYftpyd65Z+vRehda3vZe3HarhAILy1WD79qAZdKPN5F/5
         bCZA==
X-Forwarded-Encrypted: i=1; AJvYcCUDQ+vPjT+FSWlrs8xSi5XhOPVFuCgagOOuylDVuzizwoY//tHw7mRKdyabXgbhREpOCrbrX6n/1A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyFPdwuHEFrT0A8ITiLOE/mEzET4PehwsfBfIq73w7sHJbGDLiD
	S78smsucD6NTIUWW2/9ho9oFakMJQDqBlLRRGSRNlxUbTXGTyuyfdyoApNu3ciLKEQSEc/OhKWM
	IsJBAlYiSWwQ0hfEswYQLLK03KVSVTk5PoOEXXa2t5ypw52Rg/PLyXaXF9pL8BA==
X-Gm-Gg: ASbGncufjeWXvdK1aOGD81gcOlCbzVpXt7om5Zzhc7iwI24ZufwjoPvrlpkmvGOFeiZ
	Fh6rfxmnx7kA90abv9RtlP9v4GOWV/nkCte2GDSWn3g1laFU7PE3J4qE5pPJWg7ypQXCQT+GbKH
	+v9YQzhB+IxFyDUrzreKMudwHHwes8+uiJNMCi/DAhMfA0MdQbGI4oiLUWEP1uoadkOTCqNYYWG
	eEYTh7wL4fLibuF6A/sNjU95ymNlO0xY+TPkSBzGUkGsYheFptYKOo1eILT/3ChxhkiyZxzDdky
	xut3XbH+NEVVEe12TbNjG/k7S613nfYt6QR8mMXQeRxIlUZYm/qKyVmrUPrwo6yBtVphzhax6br
	IuwjQq9JzHC9P1MavLrWG8g0SaF0rTb4hmz2o6gYlXEb7jY0B+qIBMmd1qQ==
X-Received: by 2002:a05:620a:2a0d:b0:83b:5f20:41a6 with SMTP id af79cd13be357-87a33f1f29dmr848488885a.2.1759560361034;
        Fri, 03 Oct 2025 23:46:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUMkJm/6OV7cxicvapSEjp5hlA70/rYB9hv2U/Vt5pJr1Bht3HvfH+Ym3gM8TNKn9utq0DZQ==
X-Received: by 2002:a05:620a:2a0d:b0:83b:5f20:41a6 with SMTP id af79cd13be357-87a33f1f29dmr848487685a.2.1759560360579;
        Fri, 03 Oct 2025 23:46:00 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-374fc0787a2sm3101491fa.61.2025.10.03.23.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 23:45:58 -0700 (PDT)
Date: Sat, 4 Oct 2025 09:45:55 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Tipton <mike.tipton@oss.qualcomm.com>
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: sa8775p: Add reg and clocks for
 QoS configuration
Message-ID: <ezlm452ti4lrrkjkriz4yasbbsma4vw5grsxhg4ggetvku7r42@aqhdjeyc7elb>
References: <20251001073344.6599-1-odelu.kukatla@oss.qualcomm.com>
 <20251001073344.6599-4-odelu.kukatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001073344.6599-4-odelu.kukatla@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: GessN9JksSScH6IEWcnx7e79iYxl7weR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAyMyBTYWx0ZWRfX8g0Xo4mjA7YR
 qzC4C4GPI9yHrL0NBhB7JQrp+oVZYcDsGU6VO3B6RXvP87hYTr60lb+uxau8aztfBKbi+TEciMc
 8khSH6IYsMQSXaYUP98Tmg0azVIWfxTDnd+gtoPivaft5ide+Pwi/8r2i074jCTnn2X/Fp8j02N
 0GyjIn+5F0wUXznyvm5W0hkMxX+GLi+9QNBbt2CXul1BpvKXOJ/CBog4TKbXwaqLl2ANLCJiW0D
 M/syWrkkh0RwU60Zl4TkF4htVb8qzvOS9+NXZ5H4BxCtkpYn82+YwjlF+NEhA0Sapzo9HuTKpwC
 X+x1eYwvcQP23DA6nPhwWoIYuHE6UUBDX36XZFQokNCEEpq1hVBIlVOgFX6yWglF/6pzrqBs3zi
 ACEITTNnwwXdOJBD/hq5eyaEA8cMsA==
X-Authority-Analysis: v=2.4 cv=CbIFJbrl c=1 sm=1 tr=0 ts=68e0c2a9 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=M9tGKf1UEhd6l-wMVe4A:9 a=CjuIK1q_8ugA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: GessN9JksSScH6IEWcnx7e79iYxl7weR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-03_07,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 phishscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040023

On Wed, Oct 01, 2025 at 01:03:44PM +0530, Odelu Kukatla wrote:
> Add register addresses and clocks which need to be enabled for
> configuring QoS on sa8775p SoC.
> 
> Signed-off-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/lemans.dtsi | 163 +++++++++++++++------------
>  1 file changed, 91 insertions(+), 72 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

