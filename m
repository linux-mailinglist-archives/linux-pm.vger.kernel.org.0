Return-Path: <linux-pm+bounces-41478-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MOvgCKNud2m8gAEAu9opvQ
	(envelope-from <linux-pm+bounces-41478-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jan 2026 14:39:47 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B7288F91
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jan 2026 14:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7DA903075D94
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jan 2026 13:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2945833A6F1;
	Mon, 26 Jan 2026 13:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z3IXpmep";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Qdd9lFuH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943B433A038
	for <linux-pm@vger.kernel.org>; Mon, 26 Jan 2026 13:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769434472; cv=none; b=mLr3wBFNWiQ00zDYGB8xn5H5UCFgLEkzltI/sfn1Z6pJSUfbOiT7jTYCbUamo+tCJ3vaZPp015cVZjffNeiW+NJvNhUMilpDpacYAlWLfCK/2nWx/g3KTRzca/kLUOqHYy+ijQDYfkhjkIACHo7Q7XcvrlihXDhO2SwsC2VLifE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769434472; c=relaxed/simple;
	bh=yXLAq9KlI8wvcQ/x/qHbyHeswnLofO7p2mbItxHUGag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dw7+YlePRyOHNQ7+P8p8yDaNISUbd23GqeQ2ybMrR7vgHwKj9cYMauhIZtnlTcFN0GTXszAZyX4Zk0HLlNFK5uSDNn0vbME2cPbkpt0EQHHUnYIu8ERaxHh1xpU/eAVuLWD0tubNocN8Mtz+rfZaATo1TqUI5uXNQbLCVvlYHP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Z3IXpmep; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Qdd9lFuH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60Q9Z2RG701301
	for <linux-pm@vger.kernel.org>; Mon, 26 Jan 2026 13:34:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ogUx9c3kIlHsbm7jPIpllnLu
	xzdPQLpiDV66FuQYNXM=; b=Z3IXpmepD25Rwer3iV4ZiZnV6wFeCdnof3NojsHQ
	AGxkHG/ezDhKh9WKel7QyeuDSOyQx4USsxODgSpA+DnaY3JdZf0Hmp6Vv+xvpll+
	yZ5QgAZxITm7eHWlw+SXd+5w0usnzVmtJAI79QDuoY+0cD9WsPaCYp0jjWSXEsUY
	8mz+4lsFsX2tV2GMqJQU40fXOV0uFAEH53UabprRlL89/DWgtZuVgVq1LNhhpQtv
	35OktO/ituRRjP3VUqniON5dPwwSUWa+tGHM5Yt5W3XMq1Rfv7CwuLiG5FX9pFpL
	eAyHpvcf+i2OXlNdzNcdUJaDMrXT2arLqAj4q31R4E16vg==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bvq9tvkj8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 26 Jan 2026 13:34:29 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-948476b92e8so3001266241.3
        for <linux-pm@vger.kernel.org>; Mon, 26 Jan 2026 05:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769434469; x=1770039269; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ogUx9c3kIlHsbm7jPIpllnLuxzdPQLpiDV66FuQYNXM=;
        b=Qdd9lFuHSk2R86No3lE3iZi+u2ipD1pmpHAv2yS6bBuSfqUdIzAFPzIP2vsDoWQ5SS
         +d3/5ihwXbIXRk3ZNRLR8XWpdJIZzMWMlGJCWkAWIlbK561nLv/1aNU+jyFLvNqsDItd
         BM/gMigxY78Kcn2j77sP33ias9WLv9iFXm6WtrLfJM+WU32tJ8kEIxOgwZX8qpk9sD/6
         49SZ9go1h3++DBRi09Z5md03/bVhRLWF2H5uMMHFZeX51RDDXRBNXOM3Nk8yJoIksZW0
         ohCp1qZyMElQjcR4FInJGAmQ87Xl0YlcIrQw0eu+hkzxdvUP8MNPHbshbFwVyC/X5rDU
         HkAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769434469; x=1770039269;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ogUx9c3kIlHsbm7jPIpllnLuxzdPQLpiDV66FuQYNXM=;
        b=CW6UgYMU1EexUXn2pC8NahFZ1b/DGQS50ecit/EbLD1Oz0wJtmWKNlQxW1TUgOip8M
         mpGhUZdTQwA5gAMcVS9XdUpNyjln1CnRPOz+6ufr3N4SI0Z91957x8QdZXWpoPmyi5Vg
         /KgJcSI31vsSXrr+ZClyxftP78YBJgCXarxZIWa9IdUtFeXqgV+OXoGBWlkwalXRNqpW
         QOTw114+EmKx54qRLcqNR2Ru0btENMyMWaBU4I3DrTIT++94LablgX9xObXHhG58RiTY
         jOqIwaKKwXTnhE2/F59oBxGfqLTRkzjIwp7Ef9KFA7ivnRtdC1ggOcnaQgJwyYn96q2S
         hR8w==
X-Forwarded-Encrypted: i=1; AJvYcCUzStyvkfHgQS/z1tTmV5Zx1xFfhc4cur/F9yl62H+PI3m7RhCu00SHD3BI9ai2eDbZ9GVAe3DNxA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxVaucpp4a64HawxpyWwr2s6RZ1cm+QJaK6mujESvD4g01Bo5Ty
	hEC6/HDMwa+FjYSD4+fS4ykJ46i5x3sguzUCsHHFZ1vWEAc7fskh578v4irK7CNLytRtyRfFRhH
	8drzf0F2C/yp+xJuzREpDxWzx9Frgeik+9Xyqh/x0cvUCZu8dIWzz0ntIWXFHfg==
X-Gm-Gg: AZuq6aJXgfPktbjgZpa6p2a/DBeHD9SFNNKxuI46uDxLAiaqWzrJVdyR8lg172uSOxr
	pz8HnwcUNIVFxgvfUzSmGmBoFCvZ6wAE3lpuw8q25mfHNhL0hExmya9ovdJ2uS0AB7mmRXqGPAk
	4URmQ4Yb2v6TMspLfta425RnvVpZqasU+A5fS7u0IA4oP2LfiPZgOh6D8TA5DDQJUKrzkoLMWy9
	lXVQI65w6Kxufr28Zf3i3XVH4bnJ/+9rPBDGowgOTJq6ocOuiHO9qjH8YbdJW3ibnyv9B8Si8YF
	bvxax4KksCF9rAacHAzzNOUmRsIqKUuNKFIdV68+KMvV/iuaL7CBJX/EirjFTEG2USGT7GMkjPk
	AxuVfu2rYcF73isU7wPcehbur+7cwH/ucLOSo7zdJwwuCEZOPVpLWND8wm+dvzJ4qKIZGraTu0I
	ICLwpX81R38PcXqA2oC1RLBh0=
X-Received: by 2002:a67:ea46:0:b0:5f5:7737:cdf9 with SMTP id ada2fe7eead31-5f57737dd04mr761434137.1.1769434468822;
        Mon, 26 Jan 2026 05:34:28 -0800 (PST)
X-Received: by 2002:a67:ea46:0:b0:5f5:7737:cdf9 with SMTP id ada2fe7eead31-5f57737dd04mr761424137.1.1769434468407;
        Mon, 26 Jan 2026 05:34:28 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59de4918f94sm2731664e87.66.2026.01.26.05.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 05:34:27 -0800 (PST)
Date: Mon, 26 Jan 2026 15:34:26 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
Subject: Re: [PATCH 2/2] interconnect: qcom: glymur: Add Mahua SoC support
Message-ID: <k54tulgkio5at744qcuhqijgb6hb6kjcahloyiiu3ujeoqoir4@vu3cuu7p4wvw>
References: <20260123-mahua_icc-v1-0-bc82cb087f1e@oss.qualcomm.com>
 <20260123-mahua_icc-v1-2-bc82cb087f1e@oss.qualcomm.com>
 <vpaz7jhnuagfl24dow3ktyhjtzktmhiiwh2rnflub3jbc3pgu2@2ydlmugmqgbt>
 <d160aa9b-d22d-4c12-ab4f-42b5dff375b5@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d160aa9b-d22d-4c12-ab4f-42b5dff375b5@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI2MDExNCBTYWx0ZWRfX0jINfECY57So
 LK4BjTnNhwLHvJthH3S8eI2FwLaCq2Zr96H+yg/keAYFux5+GCIvrOSsqqOTA6blX6iXBAqFreK
 Z995jLeGRMIiT5ltQ2RvXCmsMwRt3CS+SLYWYO00tdjYuj03nHOJ8uE0bC0k8niIDaf7jgT2zrq
 QnJdTSDA/vCbkvf2GN03ipSgehepgvZDzL8flCqwgm8X6zoGveVDddRPa/4FzifRUx4HR+JWU16
 T+uE4Bnud0yd1H4EDvsFfdzbMXdEhxc7ge1zmn/EerUoXkhPvhZrYff9q4H0DNk5JlIBjjs2Wgt
 ttN40nxXnBKnuK1F9vYsz7fhjYI44hkxkCWraIIyrzlvBhpU4eNR+iwO26BuhnsXDZeWOqFDsm/
 3ys2r04imlmyeCB26J3rc5R9DiSWrkz97P844OczjSJw+8Rl0RGPe4M9qBus0693owz3GEt0gOf
 sdHjuBmL4Gz4NcpVCoA==
X-Authority-Analysis: v=2.4 cv=QN5lhwLL c=1 sm=1 tr=0 ts=69776d65 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=_hxizIyGxqbTRImzlzYA:9 a=CjuIK1q_8ugA:10 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-GUID: IRPsxMMoTduTPB1gL2b7haweYyiMlI4p
X-Proofpoint-ORIG-GUID: IRPsxMMoTduTPB1gL2b7haweYyiMlI4p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-26_03,2026-01-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 adultscore=0 malwarescore=0 suspectscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601260114
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41478-lists,linux-pm=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 73B7288F91
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 06:40:13PM +0530, Raviteja Laggyshetty wrote:
> On 1/23/2026 11:28 PM, Dmitry Baryshkov wrote:
> > On Fri, Jan 23, 2026 at 05:12:36PM +0000, Raviteja Laggyshetty wrote:
> >> +static int glymur_qnoc_probe(struct platform_device *pdev)
> >> +{
> >> +	if (device_is_compatible(&pdev->dev, "qcom,mahua-mc-virt")) {
> >> +		llcc_mc.channels = 8;
> >> +		ebi.channels = 8;
> >> +	} else if (device_is_compatible(&pdev->dev, "qcom,mahua-hscnoc")) {
> >> +		qns_llcc.channels = 8;
> >> +		chm_apps.channels = 4;
> >> +		qnm_pcie_west.buswidth = 32;
> >> +	} else if (device_is_compatible(&pdev->dev, "qcom,mahua-pcie-west-anoc")) {
> >> +		qns_pcie_west_mem_noc.buswidth = 32;
> >> +	}
> > 
> > Right here, set the node entries to NULL.
> 
> cnoc_cfg_nodes is declared as an array of const pointers, so the pointer
> values cannot be reassigned after initialization. To change the addresses,
> the const qualifier would need to be dropped. To preserve const, the 
> entire array has been duplicated instead by dropping the PCIE_3A related
> nodes.

Why? Just drop the const instead of creating unnecessary (almost)
duplication.

> > 
> >> +

-- 
With best wishes
Dmitry

