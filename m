Return-Path: <linux-pm+bounces-38908-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 30767C935C4
	for <lists+linux-pm@lfdr.de>; Sat, 29 Nov 2025 02:20:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 78803349C8E
	for <lists+linux-pm@lfdr.de>; Sat, 29 Nov 2025 01:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C6D81D798E;
	Sat, 29 Nov 2025 01:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Q0JZLOgg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="I8MrR/I1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950D31C6FF5
	for <linux-pm@vger.kernel.org>; Sat, 29 Nov 2025 01:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764379209; cv=none; b=dZWgqhW/qt7FRCALdCXTLWyUfqc9MrrlX5ZS0TXaaDJ1h3FZ1iYTfzmWVkBgwYz6esQDvsFrX4QIblOmQALizcQ7KsY6q719LY8o5dquuTJeQkiZKQRkP2G5a9Y4g4K3Zv+DcMXYtPjesm1O7Ef1AMy/PzVkqEVOlDvQ6CakyRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764379209; c=relaxed/simple;
	bh=Ax0bKmxJe1NEQv57Z4816PJlfnyEwndNe80T60/cHzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qFl84qIm2pFlYtmxfy9P0viAtoxM4eVy0MmYcyOiS0fp684taWi99tZR80czxic9GPxpG0ff+AUtc2e+b54bGofkaXf4f//BssnKvZ5YR/JEYGrqdqk1Uk56+sh1XcZ1JcCmPA+N5LUmI5QNcikQ0IFPK7K86AQvnqiWvQ48ImA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Q0JZLOgg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=I8MrR/I1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ASHWLNJ100283
	for <linux-pm@vger.kernel.org>; Sat, 29 Nov 2025 01:20:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=S6FM8DGduVe9gcXmmL1kbMvQ
	Mdy5V/uRwxeMZhnSy7Q=; b=Q0JZLOggTpAsdRDyZHwkFvnEYHuQ6xG1q0cocGDK
	V65ol9sK9GAmBusKBM9VJxJbFSYR9Hsau2DkHKbyVAPDHfHf+yuGd2xyoEpQZAd1
	BhTk0OiVhgIGyr3LRJM0PJutZ9eWbVXwv0f79JWPQrK2OqbD1v74Knun4OszZ8qz
	0Remr+XTSY7XzByJmcBcgXnN4EWAaX/czM/45XGQFP4gp94CJC/LRgvb+GuqAUQ9
	XqXXemuQ/T/v3lDL6d1cIarU7/RkS2a/2TXBnd4afTlzlnWQjHFOnpadXycTXOPu
	/NmKFjRmS2kamq1ranvDPXAzw0EFl6/wacnplTlstIlTQA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4aqg6d0nhq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sat, 29 Nov 2025 01:20:06 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-88233d526baso61306716d6.1
        for <linux-pm@vger.kernel.org>; Fri, 28 Nov 2025 17:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764379205; x=1764984005; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S6FM8DGduVe9gcXmmL1kbMvQMdy5V/uRwxeMZhnSy7Q=;
        b=I8MrR/I1KzzKv31RXr0IXOCB8QcEZ3tSU5AxdYwNq0VnmeFzWvJwGmS8bpK0dDQyxE
         GhmB2q09obgDzCqgMDLxh8utIILW0tlixb8qgTwNGi2d9tYdO0W5QRz+FkRLM6rAGxwG
         cyejpMdRTxrQu/tYv2XBXGo3QOTp2yTnmUdld1MC8VxyZ5vupKVyXlCAilRm5aGGBrJ5
         CWBSjxDzDqfY35l4MJUrqaIjBBMiZuIWWPB6jTgjunExB1dqMUP5UaSU4IMQkUoGDvip
         lS0eLbLfD3JiFWl9KRz70PGxdALayglHLuTW5nSCZyZ9rU3wxXn7lUFmp1XMHJUPHwnL
         KBkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764379205; x=1764984005;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S6FM8DGduVe9gcXmmL1kbMvQMdy5V/uRwxeMZhnSy7Q=;
        b=n26GcH2WmRNgZb4KnPizryEB1IGvHF9s7bnkfLgzkzzopXKRXrpV2DsnMqxAGDPdjL
         Z8XGsBCqpr0qWeMcOXvhs04QusJszhknzwyEgn1QxdwVCR7UgDQinobz1yUHQBByk9KO
         VjDUVcdQzEJlEmVIHucFu7GRr9NqstkWXZt/I4a6zZd4sbNdT5kune0M67VRDxhTrnr/
         xxygswnF+EBnVXfvZaMXc54PCuX31OVoARQEqeKGAhAZYpG85Uxd8bjWXyNVUH3RyesL
         dtg6AzDqH57E/QF/YfBc4n39C/DT6YT+0Eb9ri91vY/ubw361Jv0NasbsXbeHCunvboe
         8z6A==
X-Forwarded-Encrypted: i=1; AJvYcCUOmZYwu/0AjTaIBZ3odKFPbffieeqYORVWQLUdWoBcsDJvaMS7WxP2ynzhV3iYoQEiKouK1InWZA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywfm+/X+kum5KH3YV8/e0myWkp7ANOlODXviG9gkUGFio1cN1du
	/JbWIm1YATOeOJkUyp7mA+9XmamAtBmvNRyY+38GEYDMGBqoSgVuAu325+G6nxHMbYg79S40UiA
	/C3qH6o7ThN/GFXVI1v8fkLVp28kRUEe42e/y8WVsF9At+WP3TWs0DU3IHMU4dg==
X-Gm-Gg: ASbGnct8zrEKyb/9QGGaEVWtuPfH7MpPQXrPO1kTPjsbLN47oIwGz/1k1aYzoBaPt6V
	3HcaqvINj6OBUHpqEAQxseeX84N8mpQV3pUaJPC3t3M9Ubzjv18xLdsrMutwnbb6Hqe9wulzQV6
	EmKcvPlZ9lwOxBrAKLLE4CsEmdmAJa+6+S97WMKsRzxJjKex4vwppKA9i7UNW8u0R0b6RV9VcMj
	6zDPLIprmqVoUJ2z5sFXHK/I5Msw0cV+2Rv//iAVd3tcrMMXItdhO+6HWGOvps83ZNseTJ013SF
	i27y99MOdkgDrh99UzbVr7u3tMOXgOSm3z1oamFrcx87WYzhNHdFE6oZhQebNd5fgKmFx8wpcdn
	7sE0CcbTvRrAR8X3stQfMdbS2WxwSdPCqJVY80urhdHY2/b3i6DJwxbD1u5MreyIJLBriol18NK
	ph3Yn/GDGUG8dXV7eWXQrDl3k=
X-Received: by 2002:a05:6214:4a8e:b0:882:42e6:171a with SMTP id 6a1803df08f44-8847c4c7df7mr460885766d6.29.1764379205453;
        Fri, 28 Nov 2025 17:20:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHQCfRV4KKNT89Nq6AoyFt5iIZbL4G98X03t39ylDzO1tbriXbvqs4dfgDLreAtOeCmvLQLig==
X-Received: by 2002:a05:6214:4a8e:b0:882:42e6:171a with SMTP id 6a1803df08f44-8847c4c7df7mr460885286d6.29.1764379204928;
        Fri, 28 Nov 2025 17:20:04 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-596bfa43f33sm1543244e87.49.2025.11.28.17.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 17:20:03 -0800 (PST)
Date: Sat, 29 Nov 2025 03:20:00 +0200
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
Subject: Re: [PATCH 2/3] interconnect: qcom: qcs8300: enable QoS configuration
Message-ID: <leg62pf274mgzit246bx7vpzdovuni37lwl6mbb54dk3iqowmk@olbpn2fnis2b>
References: <20251128150106.13849-1-odelu.kukatla@oss.qualcomm.com>
 <20251128150106.13849-3-odelu.kukatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251128150106.13849-3-odelu.kukatla@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=L/AQguT8 c=1 sm=1 tr=0 ts=692a4a46 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=i2ZByRJmBIJE-cFrtQgA:9 a=CjuIK1q_8ugA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-GUID: qF3Gy0vVrY6HynvX1EwOWRP4y2a6RWGa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI5MDAwOCBTYWx0ZWRfX0yIbvS+OgAFG
 iV38O7Hoi4YYw1T5QIQB0QXDFsc5cRCz+mDcEBXVxd0lrLXqAUH0t5O9xtI/TwqMZj2Kf/NuG/r
 f+1LiuDhBF67tFCljCkicW0iNSaJpEj1zk6St/ptZFEkYSb7Ryt5SEZ19PCX78j7eafFR0atvV6
 cDmv6g9MgT66SKiMZpBtD+y/EzbBNtcHpsmLLiyDXVgL9JA6CyXM/bXMvbUQVnnOYcnFgXFRGdB
 X8t2SmNEd8jwE8honSMv7pOJO15bRS1Ew+uVjfJfMMoGT3BJXemHsHi9nTNXGxZXyHqckxnDYTx
 QcmDbIz86Ja3VycafgHUxBBBpE6j/d/vnfUFvI5QL5NN3MSH1nHsuw8vKngU/Vfq9PXoeshaMo7
 taoCL31ynbBuX6azviu4ZDL9zx4GUg==
X-Proofpoint-ORIG-GUID: qF3Gy0vVrY6HynvX1EwOWRP4y2a6RWGa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-28_08,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 phishscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511290008

On Fri, Nov 28, 2025 at 08:31:05PM +0530, Odelu Kukatla wrote:
> Enable QoS configuration for master ports with predefined priority
> and urgency forwarding.
> 
> Signed-off-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
> ---
>  drivers/interconnect/qcom/qcs8300.c | 375 ++++++++++++++++++++++++++++
>  1 file changed, 375 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

