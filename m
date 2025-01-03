Return-Path: <linux-pm+bounces-19952-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A282A00D29
	for <lists+linux-pm@lfdr.de>; Fri,  3 Jan 2025 18:48:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FDC21884A2B
	for <lists+linux-pm@lfdr.de>; Fri,  3 Jan 2025 17:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582031FBE8C;
	Fri,  3 Jan 2025 17:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vsBHETgw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE951FC7C2
	for <linux-pm@vger.kernel.org>; Fri,  3 Jan 2025 17:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735926404; cv=none; b=pkj3QzpTQ3bSyN3k8kv0qjyIXnXVFcGXHq4WFetoYCMSXEFdhV+rLUFXusOAarT7zZWMPdt0g62Y85u7927qvnqMK/AT5+xaRhmcVhl3FfBN2lmJQ/Xp5YMO8RQfiYRB31sWP71L7WoBM4zvYx4WqxvmM0rLXLpZ0qD0Z6FmvAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735926404; c=relaxed/simple;
	bh=51Zv5mmH5JrIL5lLXRuc0qNZXFh7l+H3tKdEOAhnrpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cILakDaxEw6qwoU0eBr3OAVsMsFhOAfJoO2Ud8DKtg0m43A5coqwQTPLyw1sih7UHmICzinnEI1JA/dozzi5ZFnglP0SkG2T19f8uIcB53EHRaYxTBtMOcL6i/C9s+D8yohIkTLwk3s/CdxSprLW8zuYSLjbf839Yhs8Cm//yVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vsBHETgw; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-540201cfedbso12999379e87.3
        for <linux-pm@vger.kernel.org>; Fri, 03 Jan 2025 09:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1735926397; x=1736531197; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5EdUd3mNvijFEqZMGUPeLjq5aUx2IgvJI6azgpr74Uk=;
        b=vsBHETgwc11w3d4C76KYi+YjQ6pFmKo+wzsSAL3/6k1o9puTUxDI3qqGLaCQoHLam9
         q6WBbzJ4DjrKvK1N7urtnxo5PVuqBL5SqbQWy4HG0b0Ih4ciqd9IYDUnfwVJBMLLWSK4
         /hqhgJSHTItBBFuK0UjMMt2C4riNwqWqpXxkrczDYqzftmciZEN4iwZoUSaa1uGReNny
         in2H2dR00Z8v2dOISJBaxsEadf8WF3e0DmciC8eYb6GF6VlOauViOKs+18sbtffEbPm1
         Mui5YNL6V2C3kEmaZar4ZMLzUUrZC0l2xAs/nYm2vardgU8cKlj/P10rZKRC24qzE2z8
         Unbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735926397; x=1736531197;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5EdUd3mNvijFEqZMGUPeLjq5aUx2IgvJI6azgpr74Uk=;
        b=QyeoOK579vd50blT1IuTy4AJa7NHJiEdLTm8g18ce7EFlDub7mLxESV2OWl+wmm/iL
         8PR/6b5St/mG6clWeDWqnW929AI7gMZqiE5hABPNo186PijREKxPTMDGQGIYDfz+wLt2
         L5sQ1Ffoy32JfvwYPQhCruXxSWoBTgLQafkG8EWqpZMz9jUJfz07NWjc5SczWv8KDdgB
         4b2ms31O+p0jk9NEC1HgG5599e7CH8l5RQE8AIAemN1wRzAp7IFH+f0P5gggejSbGpwA
         l5vffH6oOsj8HUrQT2l9kTCPeMq1hGXOx4y9MQVXbOIp73wXaln4BIO6maFM9BizxDxC
         q5Pg==
X-Forwarded-Encrypted: i=1; AJvYcCX4a+vvRWUIZvAkrGOYhe0jxRWezZMc7FloiIMUPmbL2EvjrG9jxRG+ZALcg+4PUUEuvfnwScum4Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywqw11Oep66S7JxA62Mds68FK475ZXa2j6AhdQRsUjAUfOyXKOx
	G7tRAiJwTQYgpJucWco04y4fUByO+u0ux2Dn4UsChIsN5LUgRW0Nh8HM2ZYK7OjXoGdnp4ldRKB
	ns5Q=
X-Gm-Gg: ASbGncuqB5TWxy3YitrrXLQHdd+D79wCni4zcyAWe7LhJNVwc1z/JS5ZuV+5UGpHe4c
	J3WvbIhHzxHhHgvBaP3ZT4kPsYC+pEUmEFnvMWNbVWGC7euA3UOFKojUd8fQlU283F0aAG9tUlV
	w3zpQzj2S0zAowrql6dnVqePG0bmX3+4Y9DkATvcquGs4Azo0hbI4HhcJqPGGGswQQ9xh7CLtBV
	TKyQ9CWzaJ6YqTQ3WpaVY50BUzTiqNkwFDERvaVIt/aGZzJBQDM/8SPnxeZi+H5neIr9GoCLALb
	pXAGt1Vxvj8sJPkIobWVC8/AwPUBZiYoPwh9
X-Google-Smtp-Source: AGHT+IF6TFaZ9c6XSMsZt3MPz45Ca0hTF8mKibX7lYoCaDaa8uqHl8uERbeoaZKb4SrP12ZjJUUWSA==
X-Received: by 2002:a05:6512:2387:b0:542:2e04:edb4 with SMTP id 2adb3069b0e04-5422e04f19fmr11703142e87.13.1735926397096;
        Fri, 03 Jan 2025 09:46:37 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-542238217f9sm4157568e87.211.2025.01.03.09.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2025 09:46:35 -0800 (PST)
Date: Fri, 3 Jan 2025 19:46:33 +0200
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
Message-ID: <t26ijxxizqv2zdvg4qkx2t6vggdbpwtgaash6bq5zwq4yhnx6c@pskmgobfqbdw>
References: <20241125174511.45-1-quic_rlaggysh@quicinc.com>
 <20241125174511.45-2-quic_rlaggysh@quicinc.com>
 <2b95cc25-a842-4edd-a5f3-2351038d264e@oss.qualcomm.com>
 <5egskepgsr52ulnbw7jhvazfjayg5ge5vhg6pi7mllyxx2vwqw@a2ojvabzd36o>
 <0881289f-db05-4e33-91a7-ffd415c2f37e@oss.qualcomm.com>
 <b2zicviv7nyl3izj2fzwzm2cp5phlxufaaoyi7e3g3iyxcyw56@iufgz33tsk33>
 <dafa6ce0-47f6-4e6a-882b-278c3b51e768@quicinc.com>
 <bbn3cbrxcagifpcjrzh5k7o5xvf6ajnf5y6zqnghex6sqwdt4t@mb3v6yfgehtv>
 <193702a3-cdad-42d9-8434-b29c2cca0896@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <193702a3-cdad-42d9-8434-b29c2cca0896@quicinc.com>

On Fri, Jan 03, 2025 at 07:37:07PM +0530, Raviteja Laggyshetty wrote:
> 
> 
> On 12/29/2024 6:53 AM, Dmitry Baryshkov wrote:
> > On Thu, Dec 26, 2024 at 09:43:20PM +0530, Raviteja Laggyshetty wrote:
> >>
> >>
> >> On 11/30/2024 9:02 PM, Dmitry Baryshkov wrote:
> >>> On Sat, Nov 30, 2024 at 04:12:49PM +0100, Konrad Dybcio wrote:
> >>>> On 30.11.2024 4:09 PM, Dmitry Baryshkov wrote:
> >>>>> On Sat, Nov 30, 2024 at 01:49:56PM +0100, Konrad Dybcio wrote:
> >>>>>> On 25.11.2024 6:45 PM, Raviteja Laggyshetty wrote:
> >>>>>>> EPSS on SA8775P has two instances which requires creation of two device
> >>>>>>> nodes with different compatible and device data because of unique
> >>>>>>> icc node id and name limitation in interconnect framework.
> >>>>>>> Add multidevice support to osm-l3 code to get unique node id from IDA
> >>>>>>> and node name is made unique by appending node address.
> >>>>>>>
> >>>>>>> Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
> >>>>>>> ---
> >>>>>>
> >>>>>> [...]
> >>>>>>
> >>>>>>> +	ret = of_property_read_reg(pdev->dev.of_node, 0, &addr, NULL);
> >>>>>>> +	if (ret)
> >>>>>>> +		return ret;
> >>>>>>> +
> >>>>>>>  	qp->base = devm_platform_ioremap_resource(pdev, 0);
> >>>>>>>  	if (IS_ERR(qp->base))
> >>>>>>>  		return PTR_ERR(qp->base);
> >>>>>>> @@ -242,8 +262,13 @@ static int qcom_osm_l3_probe(struct platform_device *pdev)
> >>>>>>>  
> >>>>>>>  	icc_provider_init(provider);
> >>>>>>>  
> >>>>>>> +	/* Allocate unique id for qnodes */
> >>>>>>> +	for (i = 0; i < num_nodes; i++)
> >>>>>>> +		qnodes[i]->id = ida_alloc_min(&osm_l3_id, OSM_L3_NODE_ID_START, GFP_KERNEL);
> >>>>>>
> >>>>>> As I've said in my previous emails, this is a framework-level problem.
> >>>>>>
> >>>>>> Up until now we've simply silently ignored the possibility of an
> >>>>>> interconnect provider having more than one instance, as conveniently
> >>>>>> most previous SoCs had a bunch of distinct bus masters.
> >>>>>>
> >>>>>> Currently, debugfs-client.c relies on the node names being unique.
> >>>>>> Keeping them as such is also useful for having a sane sysfs/debugfs
> >>>>>> interface. But it's not always feasible, and a hierarchical approach
> >>>>>> (like in pmdomain) may be a better fit.
> >>>>>>
> >>>>>> Then, node->id is used for creating links, and we unfortunately cannot
> >>>>>> assume that both src and dst are within the same provider.
> >>>>>> I'm not a fan of these IDs being hardcoded, but there are some drivers
> >>>>>> that rely on that, which itself is also a bit unfortunate..
> >>>>>>
> >>>>>>
> >>>>>> If Mike (who introduced debugfs-client and is probably the main user)
> >>>>>> doesn't object to a small ABI break (which is "fine" with a debugfs
> >>>>>> driver that requires editing the source code to be compiled), we could
> >>>>>> add a property within icc_provider like `bool dynamic_ids` and have an
> >>>>>> ICC-global IDA that would take care of any conflicts.
> >>>>>
> >>>>> Frankly speaking, I think this just delays the inevitable. We have been
> >>>>> there with GPIOs and with some other suppliers. In my opinion the ICC
> >>>>> subsystem needs to be refactored in order to support linking based on
> >>>>> the supplier (fwnode?) + offset_id, but that's a huuuge rework.
> >>>>
> >>>> I thought about this too, but ended up not including it in the email..
> >>>>
> >>>> I think this will be more difficult with ICC, as tons of circular
> >>>> dependencies are inevitable by design and we'd essentially have to
> >>>> either provide placeholder nodes (like it's the case today) or probe
> >>>> only parts of a device, recursively, to make sure all links can be
> >>>> created
> >>>
> >>> Or just allow probing, but then fail path creation. It will be a
> >>> redesign, but I think it is inevitable in the end.
> >>>
> >>
> >> There are no two instances of l3 or NoC on any SoC except qcs9100 and
> >> qcs8300. I dont expect any new SoC as well.
> >> As second instance is needed only on qcs9100 and qcs8300, I am keeping
> >> the patch (patchset v6) as is and limit the dynamic id addition to l3
> >> provider only.
> > 
> > As you could have noticed, it was suggested to change ICC subsystem API
> > to allow the dynamic IDs. This isssue is not limited to just EPSS L3
> > driver. So we were discussing if you or your colleagues could sign up
> > for updating the interconnect subsystem to use node+arguments approach
> > instead of using a global static ID list.
> > 
> This problem is limited to EPSS L3 only, NoCs are not having
> multi instances and don't expect this problem to arise in new
> chipsets. we have multi instances of L3 only on qcs9100 and
> qcs8300. we can limit the dynamic ID creation for L3 provider.
> If we update the interconnect framework also, we will have to
> limit it to provider only.

This problem is not limited to the EPSS L3 only. You just see one side
of a problem. The icc_clk framework has a similar issue. Each time we
register ICC node, we have to provide globally unique ID. This works in
simple cases, but if the platform is slightly more strange, things start
to be complicated.

> 
> Thanks,
> Raviteja
> >>
> >>>>
> >>>> Konrad
> >>>>
> >>>>>> Provider drivers whose consumers don't already rely on programmatical
> >>>>>> use of hardcoded IDs *and* don't have cross-provider links could then
> >>>>>> enable that flag and have the node IDs and names set like you did in
> >>>>>> this patch. This also sounds very useful for icc-clk.
> >>>>>
> >>>
> >>
> > 
> 

-- 
With best wishes
Dmitry

