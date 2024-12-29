Return-Path: <linux-pm+bounces-19813-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE0F39FDD08
	for <lists+linux-pm@lfdr.de>; Sun, 29 Dec 2024 02:23:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24A0A3A15F1
	for <lists+linux-pm@lfdr.de>; Sun, 29 Dec 2024 01:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5EB32594B6;
	Sun, 29 Dec 2024 01:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K4li8RVP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A258D259C
	for <linux-pm@vger.kernel.org>; Sun, 29 Dec 2024 01:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735435418; cv=none; b=NMEo7fN8MI9rpDcTtUYShtu2b50T7+yUeFjjGfEd1gfiqcxKFdRQKPLKXFWhzSdgvm48RCNQrEYJRgrq4u5uKLftdLfzLtIdJ1JnZD7/ulD4maEqIkALBFKIdxYZ970jUoBbByf8eBIstLVOrRF0W3O5dpNefs6vVyCqxTIeYVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735435418; c=relaxed/simple;
	bh=MH2kKGrSKK2CgBl4KM0ZOEJRCnzuI/Kcseozcr4PHN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XjsNsvJgbS+AQk6M7qimK681rr+JVgYw3GYyqtZ/qmWb1GSEbBRGuU9aLCTyzKBih7h2KGimdqIE0U/Q18Gf8Bn7wkiwQZ6A5iv+E8FFPUAFdnMUpDPrz6+341OzYlHlREfKS+1Yepfi+rTBkfpIscW/4SBtksLV4TaVWBy+/Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K4li8RVP; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-53e3a227b82so7885053e87.0
        for <linux-pm@vger.kernel.org>; Sat, 28 Dec 2024 17:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1735435415; x=1736040215; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SFsbQPjlzXbFI6XJVd0xng35m0N0gmlheNYTk38UQVw=;
        b=K4li8RVPn1eW/VssVk/MJwXAIZO3AuStJJasNxw2y5bTGWnFVjMF2MA7XncsBgHiJz
         y0qMxdlmiWRuTfSmc2qUW1KKUPMNtMI5vdkoDOERihIcowczMibaEoRnVau+XioD2TMB
         FCe3UtgAuLXxeKGl/dbzcgr8hWx6Tn4/B8683DBmMkb5X4C+H1X6Oai91fFYuJYKaBZY
         e7sXOWxGqhgm6T0pFLac2CCJR0RyAmQ+QDeUMYngC/jPT0xjBrtSWFbaunp7xYZulLSb
         kt+nTy+WFvU0oyMMVrBCEQuPkPVYuDbU0ONNoQMGxaBDR+ziCMhaj7Ut0qxZrXoBanlu
         0FqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735435415; x=1736040215;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SFsbQPjlzXbFI6XJVd0xng35m0N0gmlheNYTk38UQVw=;
        b=NlFHV0gu0N01yBkGKi+5BnJ69QPXdy6hGmz+Ny7bJ7Q82cS0KlX/RBUrJ1SZDKLwgJ
         1P9m/nHp9GMvbjtyJ8pnv2ZzZ/IF2yacHhdLu9EPOCTR7uINW9rbIO2lGjjQCJCcQ1g5
         NQyY5xuJgrihQiK+4fwkOSiLX8POrArQA+FjZeXJy91qUHK4tX+aHM1wGlouDt8bkWXK
         UYQwrMcZVd/efyVbAi1Vb0Ngb4j98weBCKfR10v4wdxi1dGM9qWB1bT++MaHY5SMUNDF
         X6d+iWCjIdwVs1G38sBkt4+jK6aciOSNHV3elrb8hpG6jZpFvUndOpxcHdDo4HqaSSKJ
         eYzw==
X-Forwarded-Encrypted: i=1; AJvYcCVXcnk1KH/p5Txy0xKWuxlN/3psePEPutVWBBWFuaw/OzaNIKkw1W7DsbaqqrqSar/CkpcT7N2rQw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyjMM8GufO1ArV7PK6UPWAGWP8QIlCU00c7VoDQEhAhvTBhWTHZ
	g6BlPy0yCWJk8Hhk7L+LOce+RZOD+vvrfLZQ9fIXEK2ayZpAnpKf2y1h1HV7kkG+AmiX26oJNpU
	d
X-Gm-Gg: ASbGnctDnhrt67DzHte9TisSK0/HhQ7bKdWERG2+yny8kSeESTMD3jLMEia+cfH/i2N
	xd4W00JrZIKJbnDsyQEptnSlBuO0elxcdH6l8xrrQR5jb2yY2f5+yIObfw2PE4nKsE3LLJ00ALC
	nMv+/aQ3RQTMz+moh7A+xI/VF1+s0czxfe74L8DRSbdEO+DAI8/MNT9/mtu/lAFyrb/2xmRQBY8
	GPfs+83VVtgXcdody05uKjFpZeodqWs4T7huFqu5PaGePzwXkBjQYaLI0SY12rA8NmPLuYFX1tH
	1O15bN7V2FdK6HunSuPts6cu69aoU4Xwzu5i
X-Google-Smtp-Source: AGHT+IE6ygaFpJhqi1sQtOzzMfQwC5MPGSQWsNozAVNIAiDUNkupqX2bYVPn8WGzoUFvYpPfErgXzA==
X-Received: by 2002:a05:6512:12c2:b0:542:1b6a:b476 with SMTP id 2adb3069b0e04-5422952291bmr9340193e87.7.1735435414599;
        Sat, 28 Dec 2024 17:23:34 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5422382154csm2741299e87.181.2024.12.28.17.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Dec 2024 17:23:33 -0800 (PST)
Date: Sun, 29 Dec 2024 03:23:30 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
	Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Odelu Kukatla <quic_okukatla@quicinc.com>, Mike Tipton <quic_mdtipton@quicinc.com>, 
	Sibi Sankar <quic_sibis@quicinc.com>, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V6 1/4] interconnect: qcom: Add multidev EPSS L3 support
Message-ID: <bbn3cbrxcagifpcjrzh5k7o5xvf6ajnf5y6zqnghex6sqwdt4t@mb3v6yfgehtv>
References: <20241125174511.45-1-quic_rlaggysh@quicinc.com>
 <20241125174511.45-2-quic_rlaggysh@quicinc.com>
 <2b95cc25-a842-4edd-a5f3-2351038d264e@oss.qualcomm.com>
 <5egskepgsr52ulnbw7jhvazfjayg5ge5vhg6pi7mllyxx2vwqw@a2ojvabzd36o>
 <0881289f-db05-4e33-91a7-ffd415c2f37e@oss.qualcomm.com>
 <b2zicviv7nyl3izj2fzwzm2cp5phlxufaaoyi7e3g3iyxcyw56@iufgz33tsk33>
 <dafa6ce0-47f6-4e6a-882b-278c3b51e768@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dafa6ce0-47f6-4e6a-882b-278c3b51e768@quicinc.com>

On Thu, Dec 26, 2024 at 09:43:20PM +0530, Raviteja Laggyshetty wrote:
> 
> 
> On 11/30/2024 9:02 PM, Dmitry Baryshkov wrote:
> > On Sat, Nov 30, 2024 at 04:12:49PM +0100, Konrad Dybcio wrote:
> >> On 30.11.2024 4:09 PM, Dmitry Baryshkov wrote:
> >>> On Sat, Nov 30, 2024 at 01:49:56PM +0100, Konrad Dybcio wrote:
> >>>> On 25.11.2024 6:45 PM, Raviteja Laggyshetty wrote:
> >>>>> EPSS on SA8775P has two instances which requires creation of two device
> >>>>> nodes with different compatible and device data because of unique
> >>>>> icc node id and name limitation in interconnect framework.
> >>>>> Add multidevice support to osm-l3 code to get unique node id from IDA
> >>>>> and node name is made unique by appending node address.
> >>>>>
> >>>>> Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
> >>>>> ---
> >>>>
> >>>> [...]
> >>>>
> >>>>> +	ret = of_property_read_reg(pdev->dev.of_node, 0, &addr, NULL);
> >>>>> +	if (ret)
> >>>>> +		return ret;
> >>>>> +
> >>>>>  	qp->base = devm_platform_ioremap_resource(pdev, 0);
> >>>>>  	if (IS_ERR(qp->base))
> >>>>>  		return PTR_ERR(qp->base);
> >>>>> @@ -242,8 +262,13 @@ static int qcom_osm_l3_probe(struct platform_device *pdev)
> >>>>>  
> >>>>>  	icc_provider_init(provider);
> >>>>>  
> >>>>> +	/* Allocate unique id for qnodes */
> >>>>> +	for (i = 0; i < num_nodes; i++)
> >>>>> +		qnodes[i]->id = ida_alloc_min(&osm_l3_id, OSM_L3_NODE_ID_START, GFP_KERNEL);
> >>>>
> >>>> As I've said in my previous emails, this is a framework-level problem.
> >>>>
> >>>> Up until now we've simply silently ignored the possibility of an
> >>>> interconnect provider having more than one instance, as conveniently
> >>>> most previous SoCs had a bunch of distinct bus masters.
> >>>>
> >>>> Currently, debugfs-client.c relies on the node names being unique.
> >>>> Keeping them as such is also useful for having a sane sysfs/debugfs
> >>>> interface. But it's not always feasible, and a hierarchical approach
> >>>> (like in pmdomain) may be a better fit.
> >>>>
> >>>> Then, node->id is used for creating links, and we unfortunately cannot
> >>>> assume that both src and dst are within the same provider.
> >>>> I'm not a fan of these IDs being hardcoded, but there are some drivers
> >>>> that rely on that, which itself is also a bit unfortunate..
> >>>>
> >>>>
> >>>> If Mike (who introduced debugfs-client and is probably the main user)
> >>>> doesn't object to a small ABI break (which is "fine" with a debugfs
> >>>> driver that requires editing the source code to be compiled), we could
> >>>> add a property within icc_provider like `bool dynamic_ids` and have an
> >>>> ICC-global IDA that would take care of any conflicts.
> >>>
> >>> Frankly speaking, I think this just delays the inevitable. We have been
> >>> there with GPIOs and with some other suppliers. In my opinion the ICC
> >>> subsystem needs to be refactored in order to support linking based on
> >>> the supplier (fwnode?) + offset_id, but that's a huuuge rework.
> >>
> >> I thought about this too, but ended up not including it in the email..
> >>
> >> I think this will be more difficult with ICC, as tons of circular
> >> dependencies are inevitable by design and we'd essentially have to
> >> either provide placeholder nodes (like it's the case today) or probe
> >> only parts of a device, recursively, to make sure all links can be
> >> created
> > 
> > Or just allow probing, but then fail path creation. It will be a
> > redesign, but I think it is inevitable in the end.
> > 
> 
> There are no two instances of l3 or NoC on any SoC except qcs9100 and
> qcs8300. I dont expect any new SoC as well.
> As second instance is needed only on qcs9100 and qcs8300, I am keeping
> the patch (patchset v6) as is and limit the dynamic id addition to l3
> provider only.

As you could have noticed, it was suggested to change ICC subsystem API
to allow the dynamic IDs. This isssue is not limited to just EPSS L3
driver. So we were discussing if you or your colleagues could sign up
for updating the interconnect subsystem to use node+arguments approach
instead of using a global static ID list.

> 
> >>
> >> Konrad
> >>
> >>>> Provider drivers whose consumers don't already rely on programmatical
> >>>> use of hardcoded IDs *and* don't have cross-provider links could then
> >>>> enable that flag and have the node IDs and names set like you did in
> >>>> this patch. This also sounds very useful for icc-clk.
> >>>
> > 
> 

-- 
With best wishes
Dmitry

