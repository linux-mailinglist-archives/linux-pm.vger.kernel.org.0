Return-Path: <linux-pm+bounces-27949-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE956ACA961
	for <lists+linux-pm@lfdr.de>; Mon,  2 Jun 2025 08:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADBC317C0AF
	for <lists+linux-pm@lfdr.de>; Mon,  2 Jun 2025 06:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1F817BB21;
	Mon,  2 Jun 2025 06:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HTIcvhB3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976DE2D7BF
	for <linux-pm@vger.kernel.org>; Mon,  2 Jun 2025 06:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748845033; cv=none; b=A8MquLEXfqZZYw/8njeCETVpOB13A1/LQqsMjGl6rvM78F/XSMufzu0BL18RpC5LWU+DcDrBtFF7ejdb2uQwvCR8cbjG04rRhBBjsSUIur7p7LduTbylc9qBuIADgKtLzGwGP5GN/Fcm/2Cz+VcRsA+8t71gWUi0ljVkPN7SyXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748845033; c=relaxed/simple;
	bh=xdoLc9XoaXK8M0XbS9PhopfYff7oTgRwR4OLTqlt5Oo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cc7PFE9Us5G3Nwf7YAJlpX/JfTjqoQrQcOmQHW0TXzoqjelvW4ZhhABMvNxC2La7SX5y/NSWnauOALPCw/KnNYkc6ZJ2tYHd7jC8qzFhsVpuHdUlNU7oWIXh7Z2sWUrwBqBQYfwORbkMdYbpnfTKbMHXq9ui5+qLxKsDNqHg+3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HTIcvhB3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 551N9tkv027342
	for <linux-pm@vger.kernel.org>; Mon, 2 Jun 2025 06:17:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=2KsyhDG7BdkTTvHo4/rBMgEo
	RCi0WrKaizdzWoGZ+sc=; b=HTIcvhB3RPxriA+15Gfp6+IwwllYm5luw6HAwP61
	rTz4vIOi+lsgOoEP23Bx9SjOi+VbU809Dw/ynYYs2D7D58dtp+gTsaHq2rlWMOJR
	AysKL2+lxR2ZrlYe6q34I5cy3o4luLk71qF9ryrMXpq+A1xZnMVEd5/ryhWtpSKI
	o7IjS0CpcmPqADUCGK663uzdLv2yCiBcYObUCQYUm1yvx0KNfBUDrGAtQYx2ZH4+
	BQh1tv5Ch7pZa73RmW0PykqWSuN5n8YPrp/Q4V5nQM8OW4UKI1b5TWUNePqQvnDf
	hXfC4GU/FRRGlrca0QNR8uB4/jf9X0Q9PcWvyxs3/XsTAQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46ytpeuhem-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 02 Jun 2025 06:17:10 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7cd06c31ad6so783978585a.0
        for <linux-pm@vger.kernel.org>; Sun, 01 Jun 2025 23:17:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748845029; x=1749449829;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2KsyhDG7BdkTTvHo4/rBMgEoRCi0WrKaizdzWoGZ+sc=;
        b=m2LY3yF1IQMa3lR8CKr7bVgcS+kcfGcfzNFGu/CWFuhfvDhzx6QdbK2P4E26ZL21HD
         EUnskhoVGkCIZaVRkDtbJ/MJFkoNVjW9EpYmIxn0/oO8QEUeiCMrA3/hn0rf0KqLSEXl
         vjFGuCMyS9xcwKDtpggdP4zJ1kt325wZqYty0yel1lGwCrlGqxoNnkNqm6DbP4ZVYjyG
         a/ERk66YTOUfNHdHskez0IfrESwF7NpVVxYlHLMh5SHVpW0OHA0+WwsXu66z8rVw+rPY
         KmBj/raMJjzY2gS8srtH2qSZ5nSlZBSJyyvHUm4JbA49dWjGm47NimkOQzgkzK7RWB0M
         b52g==
X-Forwarded-Encrypted: i=1; AJvYcCXxSKc8AjNeZqMMWZ3RQPAbp30woHEIBp9nKw/3oxk6NoX+pAYjFYvnodsjFdYYI/R1YdiTKbh0Xg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzhvG0E7EqNvxpIAx8oPjwREV6eJnWWYUiQ4ZtcWuLGh+bZJIlo
	+wVlETHrSbCOA4F+qex272vcozt/TAjCKQJFVbj0//Lk/tNaH+/gBknLwxahzEiR8/imm+d1OpY
	+Ml8lVRQgsueWGyxYrekYF9K7RE8Mj9pad/4VB/OHXBHOz3DgqYA2+QlT58/AtA==
X-Gm-Gg: ASbGncswXfQ//6IsD3WrMqeazTIMAWzkkYUykeEve9JQvnG48q8YjiNzoHHoQMOpayj
	XblWF2yKAQt9TXfKoAYOvM15ZR2qDnIty7Jq8Y1DdgROSzZUPzFtwFdEzBQ1o7QXts+hFuXO6Ei
	hvvxqHhCbxcIL1jUUfngyZIGbO6inJwU4gjwLNX5udLZljJfxLO2knsdP0uvPffzqRjmt1FAb2z
	UuLU6QKzSaiwAna5gzMcSPduq047N80Zyv59uBJ5eBOqfN3BzdyrNFXvq0CszRyzwzD96SWCQOD
	1tcSkh6ZKOoTb6OfkCM/suDvPV0jCJVER5XmWkvOmyUMCQekf1RxbxUgbi9vzVt+csZwCKvT2Jo
	=
X-Received: by 2002:a05:620a:24c7:b0:7cb:de0d:ba59 with SMTP id af79cd13be357-7d09879d98dmr2538880185a.17.1748845029557;
        Sun, 01 Jun 2025 23:17:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSdGsGDCqj3qNFWw0eKZ+nQWqakHUuPqz0KDPEOWNeJVqgCsioBRM8H9Z1LzwjXuRTHL7kyw==
X-Received: by 2002:a05:620a:24c7:b0:7cb:de0d:ba59 with SMTP id af79cd13be357-7d09879d98dmr2538878885a.17.1748845029212;
        Sun, 01 Jun 2025 23:17:09 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55337937786sm1489417e87.227.2025.06.01.23.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Jun 2025 23:17:08 -0700 (PDT)
Date: Mon, 2 Jun 2025 09:17:05 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: fenglin.wu@oss.qualcomm.com
Cc: Sebastian Reichel <sre@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>,
        David Collins <david.collins@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, kernel@oss.qualcomm.com,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 2/8] power: supply: core: Add state_of_health power
 supply property
Message-ID: <6oixvnhihgjucqaovkayzm6cpi35jfmtwmm67wa6h4nlmhr6w5@ggb7auvjzos2>
References: <20250530-qcom_battmgr_update-v2-0-9e377193a656@oss.qualcomm.com>
 <20250530-qcom_battmgr_update-v2-2-9e377193a656@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250530-qcom_battmgr_update-v2-2-9e377193a656@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=H+fbw/Yi c=1 sm=1 tr=0 ts=683d41e6 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=EyRF99YuA1x6hCxG0qEA:9
 a=CjuIK1q_8ugA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: dGr7NyR_YEKveIt_vyF5sw2l0Z45qx3c
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAyMDA1MiBTYWx0ZWRfXx+ur+8tP25A2
 TrvZyX8tdqJK2+Q4NCehdYQQO4e8CalcsqAB3ayE4aPYem6A5efXWS/bAcmO7Lbiy/e2HZdnflv
 EANWka1nrutOXCIq5DaHcUvnjjbqn8YNyZMqPqxsgmbDKq/e+q8KCJERk4+1CMMurepNnRR3V7a
 5bt94Ztk3CHE+gW70k7Il0Vuj2sjqS9IPHTXhnbpLkh6VWy62AeX6iC8CaPEljWud3zzJGaJJmr
 LIBH7X5mhY9ZQVSTztZyU8GMWo97KsTsC62n3pP1zh2tO2TLKGilkhSBCZjLWWYTh49EsfV0M5C
 rCRdRUMRxMKhAnxQ0Beghj2odGTZOfkl8kplGYHLHvwDGqXQxbFvhd/MSi/JWWUwqLSOd89yjIY
 pXdRUB2hmssaJ0oy1KvqqVIStNf97b90OZdaFzaDGslDdxx0L3TtsnRO4RAvnObfkDczDFeH
X-Proofpoint-ORIG-GUID: dGr7NyR_YEKveIt_vyF5sw2l0Z45qx3c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-02_02,2025-05-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 lowpriorityscore=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 clxscore=1015 phishscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505160000 definitions=main-2506020052

On Fri, May 30, 2025 at 03:35:07PM +0800, Fenglin Wu via B4 Relay wrote:
> From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
> 
> Add state_of_health power supply property to represent battery
> health percentage.
> 
> Signed-off-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
> ---
>  Documentation/ABI/testing/sysfs-class-power | 10 ++++++++++
>  drivers/power/supply/power_supply_sysfs.c   |  1 +
>  include/linux/power_supply.h                |  1 +
>  3 files changed, 12 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
> index 22a565a6a1c509461b8c483e12975295765121d6..74e0d4d67467500c3cd62da3ae0b2e4a67e77680 100644
> --- a/Documentation/ABI/testing/sysfs-class-power
> +++ b/Documentation/ABI/testing/sysfs-class-power
> @@ -562,6 +562,16 @@ Description:
>  
>  		Valid values: Represented in microohms
>  
> +What:		/sys/class/power_supply/<supply_name>/state_of_health
> +Date:		May 2025
> +Contact:	linux-arm-msm@vger.kernel.org
> +Description:
> +		Reports battery power supply state of health in percentage.
> +
> +		Access: Read
> +
> +		Valid values: 0 - 100 (percent)

What does it mean that battery has 77% of health?

> +
>  **USB Properties**
>  
>  What:		/sys/class/power_supply/<supply_name>/input_current_limit
> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
> index dd829148eb6fda5dcd7eab53fc70f99081763714..12af0d0398822ff23d8970f6bdc8e3ef68081a1d 100644
> --- a/drivers/power/supply/power_supply_sysfs.c
> +++ b/drivers/power/supply/power_supply_sysfs.c
> @@ -221,6 +221,7 @@ static struct power_supply_attr power_supply_attrs[] __ro_after_init = {
>  	POWER_SUPPLY_ATTR(MANUFACTURE_MONTH),
>  	POWER_SUPPLY_ATTR(MANUFACTURE_DAY),
>  	POWER_SUPPLY_ATTR(RESISTANCE),
> +	POWER_SUPPLY_ATTR(STATE_OF_HEALTH),
>  	/* Properties of type `const char *' */
>  	POWER_SUPPLY_ATTR(MODEL_NAME),
>  	POWER_SUPPLY_ATTR(MANUFACTURER),
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index de3e88810e322546470b21258913abc7707c86a7..dd0108940231352ac6c6f0fa962d1ea904d81c7a 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -175,6 +175,7 @@ enum power_supply_property {
>  	POWER_SUPPLY_PROP_MANUFACTURE_MONTH,
>  	POWER_SUPPLY_PROP_MANUFACTURE_DAY,
>  	POWER_SUPPLY_PROP_RESISTANCE,
> +	POWER_SUPPLY_PROP_STATE_OF_HEALTH,
>  	/* Properties of type `const char *' */
>  	POWER_SUPPLY_PROP_MODEL_NAME,
>  	POWER_SUPPLY_PROP_MANUFACTURER,
> 
> -- 
> 2.34.1
> 
> 

-- 
With best wishes
Dmitry

