Return-Path: <linux-pm+bounces-30815-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 317A4B04C06
	for <lists+linux-pm@lfdr.de>; Tue, 15 Jul 2025 01:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7768B4E1DF2
	for <lists+linux-pm@lfdr.de>; Mon, 14 Jul 2025 23:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2DA27A455;
	Mon, 14 Jul 2025 23:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Byi6Oq1m"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC014223DEF
	for <linux-pm@vger.kernel.org>; Mon, 14 Jul 2025 23:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752534671; cv=none; b=vFI64g9gh0qVsRhjMsTxtzKA8CoJUicdVlVK/jbjb2KS0gQTg8Cl7TgH+EahvTy8ZiAxTvdzmFqi40G6oFQoMKxsfBs6Q3ZXGpeNJgAfG0UJ7p8OfZWaNHjVOwPOh1bgfB6megYJjK9hNy/4JcWcgFJqziX8vGB0XbMxVmFuim0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752534671; c=relaxed/simple;
	bh=sP4SdeIpSUchjjIZMdqRkrYx1C+VnRkR1jo5U4lQz4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V0Z7LZ0U1/EcvFq1OURkABh0TaA0JaY51oeYsaRf1S8HtJ/fpzg1P0CeVuFEa31LO0Bs4x2vcmjIxnupwMLxJxbBUGw75NaLIGkyJwldKjdm9RI+JpIgsSfiIxeXzsYmWHMMIUDjlzTKt00Gv+nM5O4otUmmWUcAoGZ2l9WGkZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Byi6Oq1m; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56EIhLeK026577
	for <linux-pm@vger.kernel.org>; Mon, 14 Jul 2025 23:11:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=lnAbRsgM5Xpw854WTnr2PpxC
	p0fWTNuQo/r6LvQOASo=; b=Byi6Oq1mlQ2Du1UBtBznaIYzQY4p8hL5pynHWdSv
	aTDe7W6x/B7tNhEqPkO5Y+VCzcSxQOtr0SuJfn7PglX+uFZMeALZiw5WrQcMh9rf
	sJ/Mc7HQOsEFmM9uIhSp5TBa7YwgWQ1Y4TrG1gWWLFFEW0WjJs/h8KGUsIHfDcD2
	49jcgELppT87gxfGxfXrNE98HiZW3Wn2N2WeWsSdypESIKNDnuxrp27nFMZzD+bx
	yU9qvwOPSfNE3+VFAsukhHo6roMkV6ATzLPh7u6HFnfVKFPkYJtaWBlZlEnxipRV
	XPQa3LJW0KKZLLpv05ITsY9TLU5AbgQXd0WQ0ZKra56mOQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ufvbe3kr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 14 Jul 2025 23:11:07 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7e338e627f1so57172585a.0
        for <linux-pm@vger.kernel.org>; Mon, 14 Jul 2025 16:11:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752534667; x=1753139467;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lnAbRsgM5Xpw854WTnr2PpxCp0fWTNuQo/r6LvQOASo=;
        b=WwwYXH0HE/dH3TIIW0KV1Xac6zFyQTXl+xu8s0AogkFyRQqQxmc40cC9ZiUBdnJ6+v
         1cnkAkLb0zgsO2pErUleTTl5Sb8zYi/WoRWDMHBjD2f6r0dLdEF1LXKuAJSKZZPEU0XS
         Y8j6/mnDmFBAk7AKKeiSanho77TIkfeJv346rCheHH/OJsGPrKiGXR7iiE8EX46xZl1T
         pU9GO15zSW+LZdcoitAIMX77AWSwmVzk7ULgEIMDoCi9aXhBRtyN9NwKqAIG3QLx/bex
         sQLMZLNptcyIuDdzQtO6tj4ZMN07drXHFUn+L9UWpGVeaKTwE/YUh7xuHXpOGV6VWEAQ
         Lv4A==
X-Forwarded-Encrypted: i=1; AJvYcCXYpLTGpVVTdHtiQ+X9LgxBAq0UwmJtk3QCKNaNWB41fYjb3mRoGAvKpSg3DZE2R1eKcEy/BZjetw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyqteaDtrmKhiPndbKiKxumWMTzpGGO++XUuxfbbIlsPprixfbR
	L2QlTCA1UWAuBS8Hy5K24R+bIsQPYzrx3XMRQWebfHmyiCRhCFvXnn0oSLlYSTKk5EeYkTB/wDI
	RBiovMpgcm1BZpEunmY4KjXGj19DSCHKGXRM3hm2MF50zRi83qy4+ZOtzec21hA==
X-Gm-Gg: ASbGncuiB+NnsnvRjS7fHRmAkeHOG4qqWWokYpE69GnPWFoHBnmu6U5Rfh4eOoKY4uS
	Y8gt/XJpn5+212XlVRbjjPtCmxzgJbKcd++yh8E3FVfOdCoUCQUX7Gi0lrtrsE/qYOrqqkWkwbd
	vaLgvfNJivXlpTxpjqb7QkCx9huqVOw6fdfJUAnkx/Eb27J2xQQrlJGFH8jJy6+8vVUOkjnGmsl
	57Ac//lFQX5RK94KS8CwzTFa/0vsTGQxKx0E1pMmxZYZCmsXIaRziZl8jWgm57bCR1Bzi8hu6MT
	igZFKpTjoxt3pfumHb0xp1Xeag60+T8Xr8eYwhVdCClatXrMQkX13gXmU95RqQ5KLdX9VZoZ8gd
	Rt+7yg4bnuGCRVoNm5IqTxL1DGNiJT9BcD7fLEghfgFq7SIvUZqOQ
X-Received: by 2002:a05:620a:394d:b0:7e1:f16c:16d6 with SMTP id af79cd13be357-7e1f16c171bmr1319842385a.8.1752534666748;
        Mon, 14 Jul 2025 16:11:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgcpRDGfh0tTeMaTiRAOLif3PtbYVlsrcAaMwHK8S/xvzLSUZaIFYJ4fcz95Qmvjsb6mBB+Q==
X-Received: by 2002:a05:620a:394d:b0:7e1:f16c:16d6 with SMTP id af79cd13be357-7e1f16c171bmr1319837885a.8.1752534666331;
        Mon, 14 Jul 2025 16:11:06 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55943b73366sm2094948e87.211.2025.07.14.16.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 16:11:04 -0700 (PDT)
Date: Tue, 15 Jul 2025 02:11:02 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Andy Yan <andy.yan@rock-chips.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, Vinod Koul <vkoul@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Elliot Berman <elliotb317@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        Andre Draszik <andre.draszik@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-samsung-soc@vger.kernel.org, Wei Xu <xuwei5@hisilicon.com>,
        linux-rockchip@lists.infradead.org,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Sen Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>,
        Macpaul Lin <macpaul.lin@mediatek.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Srinivas Kandagatla <srini@kernel.org>
Subject: Re: [PATCH v10 01/10] power: reset: reboot-mode: Add device tree
 node-based registration
Message-ID: <5zlix4hfxkz447g6e6imjlatmnf26pvunnsmfkol7mhvropq6o@k7wr6h4hyqtg>
References: <20250710-arm-psci-system_reset2-vendor-reboots-v10-0-b2d3b882be85@oss.qualcomm.com>
 <20250710-arm-psci-system_reset2-vendor-reboots-v10-1-b2d3b882be85@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710-arm-psci-system_reset2-vendor-reboots-v10-1-b2d3b882be85@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDE2MyBTYWx0ZWRfXx7yx62bbsipP
 ft2TPJchupl1Rgne3o/MjWSb9rcDUNvSBPm+sffE5hYyGHcG6e/MmSMaNJewdlVEeDdXakoNkW6
 D25c/v4Er7RB+SYi1nP8f14SJa8PEiuBZJo9u8y2bz7ykLAJy0ccPUMWnG0fixcaHf69qaM0h5C
 P/plix+2Ua817NQT3ddR4rnKPmLPaW9A6AS9APx2GuAYLN+8okx1uGSS5DPeF2tP4I5OHSNYrS6
 MTzjG3Yvv/CG+W93iSweEs+d7bl6h2p/woR8nTDErcK+/yt05j29jAXzcs5LNewH4iDHH+gmu3x
 blskDNYdm29PYUaC4EEGUmN0ALNE50Shdt0YtZXJ5aBkUv7ach1kWRrJqSQOwtayofWO5uiIpzX
 fQ9M/3B2lnsuWKmX+IW9HrKQaevWRGR6amgz75RtYMUsBKUFyB/ZiL9bl8OV3XHAAHRIrLE7
X-Proofpoint-GUID: 2--cvCXXUztvKs_s39OjsnMipqUDwkO1
X-Authority-Analysis: v=2.4 cv=RPSzH5i+ c=1 sm=1 tr=0 ts=68758e8b cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=SZ81-B_MNtUeYvdDzSwA:9 a=CjuIK1q_8ugA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: 2--cvCXXUztvKs_s39OjsnMipqUDwkO1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_03,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999 spamscore=0
 clxscore=1015 suspectscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507140163

On Thu, Jul 10, 2025 at 02:45:43PM +0530, Shivendra Pratap wrote:
> The reboot-mode driver does not have a strict requirement for
> device-based registration. It primarily uses the device's of_node
> to read mode-<cmd> properties and the device pointer for logging.
> 
> Remove the dependency on struct device and introduce support for
> Device Tree (DT) node-based registration. This enables drivers
> that are not associated with a struct device to leverage the
> reboot-mode framework.
> 
> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
> ---
>  drivers/power/reset/reboot-mode.c | 23 +++++++++++++----------
>  include/linux/reboot-mode.h       |  2 +-
>  2 files changed, 14 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/power/reset/reboot-mode.c b/drivers/power/reset/reboot-mode.c
> index fba53f638da04655e756b5f8b7d2d666d1379535..61f647b23959789a313f3af0bd967abcad45fa43 100644
> --- a/drivers/power/reset/reboot-mode.c
> +++ b/drivers/power/reset/reboot-mode.c
> @@ -12,6 +12,7 @@
>  #include <linux/reboot-mode.h>
>  
>  #define PREFIX "mode-"
> +#define pr_fmt(fmt)	"reboot-mode: " fmt

This wasn't really tested. If I remember correctly, it should be defined
before the first include.

>  
>  struct mode_info {
>  	const char *mode;

-- 
With best wishes
Dmitry

