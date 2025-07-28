Return-Path: <linux-pm+bounces-31493-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C712BB13EE4
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 17:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 101E57ACB37
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 15:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1875E273D6A;
	Mon, 28 Jul 2025 15:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Pb4XQpKe"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2C826D4E2
	for <linux-pm@vger.kernel.org>; Mon, 28 Jul 2025 15:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753717042; cv=none; b=dMH+45ursyqKUL2bQqXMMd1u/Ec+P5F8RxzqrtnIQeGRqYwq+ixzmLh9PmoW2zAcmS8/kZLUsTFyF80h2fNksW9CnlKe0TVA+cDvGaHY56KGaHng3yeae+ELTYTy1K4fDzvy7FHMfrFpje5mg5mNTPmoPl+2To2htzjSSND7h6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753717042; c=relaxed/simple;
	bh=jre8QM0W1aod+snE4SIPjcwGuvGXMCnAU3WPP0zFovo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sUL7coTQdcMCy9qdDwGD6RGZwTcMIuIMygnZxdLbTPBj3t+uUn75qdM47aBUuGYk3MW6x6GLaPe0zHq+pG1cLhAPbSjC8awztlx/WCWN9U12P9L9DbyTJJ1eGp46knmhU5l5wUT8dLf1oKwIlgUlp3yEZjJItT/OvDXiwRCyfxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Pb4XQpKe; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56SAlL21017593
	for <linux-pm@vger.kernel.org>; Mon, 28 Jul 2025 15:37:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=SAVDu2CUO0GFbPnrkds994cc
	7fuJHUyL9s9URha4+gw=; b=Pb4XQpKeNIn4JwZo9QYgwyN8jt5WS7p27L9R+3Lv
	sBtDiOW2Yj3IWvwog0YlaLitsHCvtEERjgFKUEmhcM2VYrShSsoXJxVs9Lyp/qNn
	IQxNwn/xAdqBPLO8GpxMqliRmo/jkULpDDIACh9KEQSiD7oazMMV6NifxQTvnojz
	/PKWqbcLiZlWdNJKuyZQQv48DZQ/PpVLP4c9cE3NGZcSSU/F1JL59EoW0p26G0ap
	YCblv3wCsjP5zLhMFG1F0wPZfL/xiGBIXNxICmXZ0zayCQwUFW25an/BgEpyae56
	CTXQILbgTgVRaiCSFpyVsGFpnU+2t26xuAejBlnG8B20CA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484p1ad311-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 28 Jul 2025 15:37:18 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6fb3bb94b5cso60477026d6.2
        for <linux-pm@vger.kernel.org>; Mon, 28 Jul 2025 08:37:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753717038; x=1754321838;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SAVDu2CUO0GFbPnrkds994cc7fuJHUyL9s9URha4+gw=;
        b=u+dZB5n6jmsOPt5Ya8QerMhuIBYTpAO3OAU7Y6g8YNDuX7PzsLopugMmV49nmcdDPa
         InIUQS9kOY3wuJ8/xjq7UyEupKVqjpGPSlDWkqLQXFWFyiWC+isk1zrS+VWQbNGpT729
         4N+SWWrBr3CM30eJFPCZDcLsgO4tJuER2kJv/0jPnAEioHnlKjX/P2uYpuhLvAndyf3A
         Qg+jqaFgdQ9xSElk8prgJmkxN2tyy7PYKD+q6SV1kV5LpAPtyq+17bN86lnd/EVYnogQ
         Z++rGlWiGSrYmsd9Q2AqM71v9FEd3btvpSeTLN8nvWkfdrW4Zb3Lml7y4BXsPlprPorx
         TiyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWndQYZZr/zAKfA/vuEMKsHrI0zU+3H0qN7d3mNeQ+AcxOCmydhjBrR1teggTi/Zy1hP2ycD3KkrQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwBWykgI9ZYH+Xyw3I/74tUqdeo4NDB2Yp+wq81YUlcObi6RmV7
	e+sgZ72w8dm5sUmAlFDQ5fcctk2Tv0TVb9vjh3CiTl2EF0nmkIwkQI/TyH0363z9hqwGPkOZcy/
	GwdzYXuSMDBXI4RgFLeylgg33MBwL4ywRtgDPxalTkM3NmT9DEp5UL9QNbf249w==
X-Gm-Gg: ASbGncvtRfEU1nK8fkE8Cs4Sddzvw2Sf8phgDgFsHEOwCwfbhPwTBvxsB4oogXrZxt+
	1oyBxDshEAwAjG0Dw4cwd6rVI7FoEDUCPRoTs0U8zU6Lpr9HkHLS1Wtkudb/0fDDX1JHIWRwwOy
	Ie/ydhcau47nP6qFQmmmfftQa28GKXCakIeDE5qQJSsmuW02BvcSOZnOSK41ncX587x5le0myzW
	09uklw/g48LQAT9NbVv3oYhczYTP6d4XE0Cw12oVAg8vNgscp9r3EJDzXqXjwM8UXaq+q1GCEHi
	F87POZusGCbrFbm4lZf+dOlFMtUIhNGICXww+iPwRqekiiNZmWhmlffZ3FwhhvMRE/kAhaGJzb7
	HrwTSlvDBjnCdQF8lAmpm9vFurOCDzig8DVujzFgsidCd7mD27SDj
X-Received: by 2002:a05:6214:768:b0:707:4aa0:30b with SMTP id 6a1803df08f44-7074aa00690mr43615936d6.42.1753717038053;
        Mon, 28 Jul 2025 08:37:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+BWhOHv+VJeM/lHL4P6XKb8rnJZC+uPnNDX7+Ov1b4lYzmfrK08Z/Q+Kn87HxQgfASQl2vQ==
X-Received: by 2002:a05:6214:768:b0:707:4aa0:30b with SMTP id 6a1803df08f44-7074aa00690mr43615016d6.42.1753717037278;
        Mon, 28 Jul 2025 08:37:17 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b73f140fasm21169e87.113.2025.07.28.08.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 08:37:15 -0700 (PDT)
Date: Mon, 28 Jul 2025 18:37:13 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
        Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Andy Yan <andy.yan@rock-chips.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, Vinod Koul <vkoul@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Andre Draszik <andre.draszik@linaro.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        Elliot Berman <quic_eberman@quicinc.com>,
        Srinivas Kandagatla <srini@kernel.org>
Subject: Re: [PATCH v13 07/10] firmware: psci: Implement vendor-specific
 resets as reboot-mode
Message-ID: <mfxfi3blmebuua4rwdppbaiyiyqh7apkh4xxlwqm6t2ishjqfa@i26nvsduy5wm>
References: <20250727-arm-psci-system_reset2-vendor-reboots-v13-0-6b8d23315898@oss.qualcomm.com>
 <20250727-arm-psci-system_reset2-vendor-reboots-v13-7-6b8d23315898@oss.qualcomm.com>
 <b81aa592-a66b-457b-9f42-df4505b28508@kernel.org>
 <3gtlf5txxtioa5bvo6o467jupyoam4hjhm2mdiw5izv5vbl3tz@drndgp3tcrgo>
 <bcef34c3-98b4-454c-8138-c73729e17081@kernel.org>
 <5e2caeb7-360a-4590-a36f-ff1ec4c20d31@oss.qualcomm.com>
 <2a39c0ab-edd4-402c-95a0-a6286f03102a@kernel.org>
 <20250728-exotic-armadillo-of-upgrade-fbebc1@sudeepholla>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728-exotic-armadillo-of-upgrade-fbebc1@sudeepholla>
X-Proofpoint-ORIG-GUID: MOtMl6SQjaWTgTNT0lq0_CQ_-fU8Fr_S
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDExNCBTYWx0ZWRfX2GfMf327Uqqw
 /c4WgninR9YWzLrcP6CqYe1zgcX7P0pBHsCRGCbI6CWNgQQ/5j5Nfgs8i3OBs0KAOyJtezCLX7r
 AwZoeKJfjxHhkE/uyjsB6AL+/MnYf44o1V7xbhgRLIFA8zl+DZy8PJM96dwrpnBDXKIEMDDG4EY
 RCOETwqgcz1lKrCcrlh4lSTrMx5mWo3x9oQpMHQdEFxgSbw6R7Ze7iFW4MYe2H2QFxCSPLrq8M/
 62ZCyYBwp5RHjsm+2ff4p5otT0sViE5/Ut0vsai2NbxMs+3kS3kGRIAVGBIjwZFWL2pYaIoRNf4
 uYWVRk7CjXV2CJYjnqrgpnv6beDCI0h0+3fiy+RT2uFu9Wpt7dCtNYg1kjgE9VYj/9SFagbgljZ
 NLJ/o+7k+8ll6UrO6Dz+xZZlTe9Zt5rZFsHCVEfXJwneS02zmyB1yiOx5J60aWjrwRGo4oST
X-Proofpoint-GUID: MOtMl6SQjaWTgTNT0lq0_CQ_-fU8Fr_S
X-Authority-Analysis: v=2.4 cv=KtNN2XWN c=1 sm=1 tr=0 ts=6887992f cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=-6XmDZydnhzWYMP6MwkA:9 a=CjuIK1q_8ugA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_03,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 adultscore=0 mlxlogscore=727 bulkscore=0 spamscore=0 impostorscore=0
 mlxscore=0 malwarescore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507280114

On Mon, Jul 28, 2025 at 02:23:17PM +0100, Sudeep Holla wrote:
> On Mon, Jul 28, 2025 at 02:23:14PM +0200, Krzysztof Kozlowski wrote:
> > On 28/07/2025 14:03, Dmitry Baryshkov wrote:
> > >>
> > >>> and the reboot-mode is defined in the
> > >>> previous patch. So, I'd assume, the path is defined.
> > >>
> > >> As I said, path is not. only psci/reboot-mode is.
> > > 
> > > Do we have an _actual_ use case where PSCI node is not at at root node? 
> > 
> > Yes, many cases, because it belongs as well to firmware node.
> > 
> 
> +1, I was about to make similar comment. /psci predates the formal push
> to put all firmware related nodes under /firmware, so /firmware/psci is
> equally possible path and should be recommended one so that all such
> firmware related nodes are contained under /firmware.

Ack, thanks for the explanation.

-- 
With best wishes
Dmitry

