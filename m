Return-Path: <linux-pm+bounces-18297-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A3A9DF1BE
	for <lists+linux-pm@lfdr.de>; Sat, 30 Nov 2024 16:32:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55F70B20819
	for <lists+linux-pm@lfdr.de>; Sat, 30 Nov 2024 15:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181C219CC3F;
	Sat, 30 Nov 2024 15:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r/r2UrKB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8B4433BC
	for <linux-pm@vger.kernel.org>; Sat, 30 Nov 2024 15:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732980772; cv=none; b=c5wr1976tYoTAuw+ewDU5RGd0yQ/64m8JY9798vfBFtYe8rtuMlHsm29Ldq+Ggqo+KsxOxKl0J6y9gWa0GpSX7iGw4NP2ovvnbOCWOCdZXlHdAbGAkM8VKnVLiZ+GvCaxVV2RFuRDPZll8X82NfCn5v8Txym1dPY/noa7sKP39w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732980772; c=relaxed/simple;
	bh=Mmwr0wcR/cpd81hA4yBerElVsz/ymKKscLvdl1mokxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bzH93PwmYZlRzTCbUjRGLDhj/wt6Eqa46yRSr7I+1sIx1Rt1qTuxDhoG0zb5Z8ryzQNWUxq7gfmT3BqNRjr67Tj3gOOe+NLZsuYwrzLNNER01mcpXg/gdcFaXz9IbJv62Gr/H/LHW9AzxBcfqSc1bW5nqywZfIHXoZgeeqyDGVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=r/r2UrKB; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-53de92be287so4182883e87.1
        for <linux-pm@vger.kernel.org>; Sat, 30 Nov 2024 07:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732980768; x=1733585568; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3c6nP2biyY51IWSJhlHDMjwRqcJrCsvuje0PxvJuHtc=;
        b=r/r2UrKBuZI3XH0sUn8lqKlVrtZj40ezWTcN1oBz33qb99ok6lsDbIglb4GA9vYGB8
         bH14e6ol+DkOe0W2lT4O8MW29GG4X+3VaFgdU+7QHImoCo50qylGcNcNbe0sf/lSOs9n
         5QUSK5XdIxmwO/o/hLvfUHcZCKf8GjlaudQpT0/WcZsqfiq7B6kygTB6oirlI8D2t05B
         PODgDTLg1ZChVcu961FYO4zKMxCpF/irHprfvfg8UZrMeZkg7OSnt/hmAVZ5BfUUWVsV
         PadNA8aNuA9IUaZCvPbZsRG5HH22QFCGyrVQ0uOqRBFlAUE1ty4OcePpYgr+QsqphqB3
         wFBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732980768; x=1733585568;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3c6nP2biyY51IWSJhlHDMjwRqcJrCsvuje0PxvJuHtc=;
        b=mKecBfe06Fr0KpNeVmj2G1CbtmRlJEmkqQWJaxoMrCm7hQrGlaUZkUL5eyXwIgTojk
         GU5IKRUK6bEzUlS5TJ4gGwufkPHxV/cqHPG2Rj0hhVbWravdkj5vDpdWY1dW2ttPGZhe
         9A+CVigI3GpYYdjkyLmTTHJz+JFrQmFzsYS29HWLGrKS5U8W9XAABr00wGCbSmG6W3Cg
         o4um3RQJEjbYGeFY0iJ83EH7bdixWcBJCZEofKLoo7cU3q8T+RHfSdq8yS4ho40Tv4on
         bMaEj/2IKuphVvOZ9GPh+REEszsPrkKNvPxyKx9i+dSJmDegtEjZMi0aLScMHydLIcu1
         y/pg==
X-Forwarded-Encrypted: i=1; AJvYcCU3YSNiaJlxlANnyZEpMo2EQXPdFwFelAieoZIwQWi0I4b+DSD+Bz9wXNVNo9Lme7Ub6NJyr8CrrQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwExGIlfunxQRLXig5VrCSF95q2anOEbZnJvviRKATvtYA+ze4I
	7vw8fUxWlvaLu4xFpF9kOzi08ilS9oJinrjsztDbvu3ZeTPTdwRgLus0ZUFRXKgItTnp47rD02j
	s
X-Gm-Gg: ASbGncv78gDCk8DfVVA3mlFLrs0cFYxvDZ2Lm7m64I/OI120o/mfb1UHo8o0RdcEp0y
	znShINXQvJWqI7oWIbnd39o8A4zEoir9HoyIWyKkXxC/CDO4TnLavMh0Qok4vQctM3LNBpNGdw7
	SczUtyfPuEzwSMhaxOgKVkA2yOMHddH6SlhfIoEOY569LsH+64qM2JxHViGgD0ZC30U4Mmfo372
	VxQxlI8akBYbh5ug8LbzJj56u6fZSghBoAm63ZGmAGOa1ko6gOynAkKfQvE8BcN48829t7L4S0M
	V5OVFLxTERBBqMVyGstl29ZGrXxGUg==
X-Google-Smtp-Source: AGHT+IFErDW63p2PD42irUmoZJLwKPqVCbwqQAzMQ1RF+lVEg19qh0U51+2WE4NE6ZIxiJISUYRF/Q==
X-Received: by 2002:a05:6512:3d86:b0:53d:a3a7:fe84 with SMTP id 2adb3069b0e04-53df00a96e8mr14216821e87.8.1732980768078;
        Sat, 30 Nov 2024 07:32:48 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df64432adsm794384e87.83.2024.11.30.07.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Nov 2024 07:32:46 -0800 (PST)
Date: Sat, 30 Nov 2024 17:32:44 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>, 
	Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Odelu Kukatla <quic_okukatla@quicinc.com>, Mike Tipton <quic_mdtipton@quicinc.com>, 
	Sibi Sankar <quic_sibis@quicinc.com>, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V6 1/4] interconnect: qcom: Add multidev EPSS L3 support
Message-ID: <b2zicviv7nyl3izj2fzwzm2cp5phlxufaaoyi7e3g3iyxcyw56@iufgz33tsk33>
References: <20241125174511.45-1-quic_rlaggysh@quicinc.com>
 <20241125174511.45-2-quic_rlaggysh@quicinc.com>
 <2b95cc25-a842-4edd-a5f3-2351038d264e@oss.qualcomm.com>
 <5egskepgsr52ulnbw7jhvazfjayg5ge5vhg6pi7mllyxx2vwqw@a2ojvabzd36o>
 <0881289f-db05-4e33-91a7-ffd415c2f37e@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0881289f-db05-4e33-91a7-ffd415c2f37e@oss.qualcomm.com>

On Sat, Nov 30, 2024 at 04:12:49PM +0100, Konrad Dybcio wrote:
> On 30.11.2024 4:09 PM, Dmitry Baryshkov wrote:
> > On Sat, Nov 30, 2024 at 01:49:56PM +0100, Konrad Dybcio wrote:
> >> On 25.11.2024 6:45 PM, Raviteja Laggyshetty wrote:
> >>> EPSS on SA8775P has two instances which requires creation of two device
> >>> nodes with different compatible and device data because of unique
> >>> icc node id and name limitation in interconnect framework.
> >>> Add multidevice support to osm-l3 code to get unique node id from IDA
> >>> and node name is made unique by appending node address.
> >>>
> >>> Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
> >>> ---
> >>
> >> [...]
> >>
> >>> +	ret = of_property_read_reg(pdev->dev.of_node, 0, &addr, NULL);
> >>> +	if (ret)
> >>> +		return ret;
> >>> +
> >>>  	qp->base = devm_platform_ioremap_resource(pdev, 0);
> >>>  	if (IS_ERR(qp->base))
> >>>  		return PTR_ERR(qp->base);
> >>> @@ -242,8 +262,13 @@ static int qcom_osm_l3_probe(struct platform_device *pdev)
> >>>  
> >>>  	icc_provider_init(provider);
> >>>  
> >>> +	/* Allocate unique id for qnodes */
> >>> +	for (i = 0; i < num_nodes; i++)
> >>> +		qnodes[i]->id = ida_alloc_min(&osm_l3_id, OSM_L3_NODE_ID_START, GFP_KERNEL);
> >>
> >> As I've said in my previous emails, this is a framework-level problem.
> >>
> >> Up until now we've simply silently ignored the possibility of an
> >> interconnect provider having more than one instance, as conveniently
> >> most previous SoCs had a bunch of distinct bus masters.
> >>
> >> Currently, debugfs-client.c relies on the node names being unique.
> >> Keeping them as such is also useful for having a sane sysfs/debugfs
> >> interface. But it's not always feasible, and a hierarchical approach
> >> (like in pmdomain) may be a better fit.
> >>
> >> Then, node->id is used for creating links, and we unfortunately cannot
> >> assume that both src and dst are within the same provider.
> >> I'm not a fan of these IDs being hardcoded, but there are some drivers
> >> that rely on that, which itself is also a bit unfortunate..
> >>
> >>
> >> If Mike (who introduced debugfs-client and is probably the main user)
> >> doesn't object to a small ABI break (which is "fine" with a debugfs
> >> driver that requires editing the source code to be compiled), we could
> >> add a property within icc_provider like `bool dynamic_ids` and have an
> >> ICC-global IDA that would take care of any conflicts.
> > 
> > Frankly speaking, I think this just delays the inevitable. We have been
> > there with GPIOs and with some other suppliers. In my opinion the ICC
> > subsystem needs to be refactored in order to support linking based on
> > the supplier (fwnode?) + offset_id, but that's a huuuge rework.
> 
> I thought about this too, but ended up not including it in the email..
> 
> I think this will be more difficult with ICC, as tons of circular
> dependencies are inevitable by design and we'd essentially have to
> either provide placeholder nodes (like it's the case today) or probe
> only parts of a device, recursively, to make sure all links can be
> created

Or just allow probing, but then fail path creation. It will be a
redesign, but I think it is inevitable in the end.

> 
> Konrad
> 
> >> Provider drivers whose consumers don't already rely on programmatical
> >> use of hardcoded IDs *and* don't have cross-provider links could then
> >> enable that flag and have the node IDs and names set like you did in
> >> this patch. This also sounds very useful for icc-clk.
> > 

-- 
With best wishes
Dmitry

