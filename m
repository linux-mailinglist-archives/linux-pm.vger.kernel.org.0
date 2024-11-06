Return-Path: <linux-pm+bounces-17053-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B900D9BDF42
	for <lists+linux-pm@lfdr.de>; Wed,  6 Nov 2024 08:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB1C31C22E95
	for <lists+linux-pm@lfdr.de>; Wed,  6 Nov 2024 07:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8CDF1CB9E0;
	Wed,  6 Nov 2024 07:20:27 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C827192B61;
	Wed,  6 Nov 2024 07:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730877627; cv=none; b=fcYR7tmaEOLG74rOzMrh0eC7gTfxelxYhi6D9R7YfxEKJL5LvMzgiTxJ4nVsOLzRKy3XXJwVHYKcLZ6vQfo7RXAosiVEkTsDMg1LorsFHOFxbirWw7kTFx+q3YGo53lPtn0Kok1GsbORwx77QnGaEqeBTcw2Nq7B5YPL9zPO+QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730877627; c=relaxed/simple;
	bh=/mEdkmb4i1pd4wl+jSu8sjFkQAOoedX+OBM66cNaNUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uODCmfRMFG7vqTU2g7r1qOaMw/V2cIJVn/4YiPhYJizHTRSmpFZhAj+y8TtTGbKIXdGVmWfceybarEHvmbooW2woJxjxnigLsGJ/gTsteMb2Sc8BzxM+SSTr+GZo7YQ1E1eXQLwz5NhMeh0i6jnx55LX55TK/1FHL62E96BpyaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 70CE11063;
	Tue,  5 Nov 2024 23:20:54 -0800 (PST)
Received: from bogus (unknown [10.57.64.60])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B9C3A3F66E;
	Tue,  5 Nov 2024 23:20:16 -0800 (PST)
Date: Wed, 6 Nov 2024 07:20:01 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Johan Hovold <johan@kernel.org>
Cc: Sibi Sankar <quic_sibis@quicinc.com>, cristian.marussi@arm.com,
	ulf.hansson@linaro.org, jassisinghbrar@gmail.com,
	dmitry.baryshkov@linaro.org, linux-kernel@vger.kernel.org,
	arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org, konradybcio@kernel.org,
	linux-pm@vger.kernel.org, tstrudel@google.com, rafael@kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: Re: [PATCH V5 3/6] firmware: arm_scmi: Report duplicate opps as
 firmware bugs
Message-ID: <20241106072001.5jrbbctj7ud5uaxd@bogus>
References: <20241030125512.2884761-1-quic_sibis@quicinc.com>
 <20241030125512.2884761-4-quic_sibis@quicinc.com>
 <ZyThAFbOHKaBIgLg@hovoldconsulting.com>
 <e173058b-57e7-7fd0-dab7-7398bf9d66ec@quicinc.com>
 <ZyjViCVtPwe-tmMq@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyjViCVtPwe-tmMq@hovoldconsulting.com>

On Mon, Nov 04, 2024 at 03:09:12PM +0100, Johan Hovold wrote:
> On Mon, Nov 04, 2024 at 07:20:01PM +0530, Sibi Sankar wrote:
> > On 11/1/24 19:39, Johan Hovold wrote:
> > > On Wed, Oct 30, 2024 at 06:25:09PM +0530, Sibi Sankar wrote:
> 
> > >> @@ -387,7 +387,7 @@ process_response_opp(struct device *dev, struct perf_dom_info *dom,
> > >>   
> > >>   	ret = xa_insert(&dom->opps_by_lvl, opp->perf, opp, GFP_KERNEL);
> > >>   	if (ret) {
> > >> -		dev_warn(dev, "Failed to add opps_by_lvl at %d for %s - ret:%d\n",
> > >> +		dev_info(dev, FW_BUG "Failed to add opps_by_lvl at %d for %s - ret:%d\n",
> > >>   			 opp->perf, dom->info.name, ret);
> > > 
> > > I was hoping you could make the error message a bit more informative as
> > > well, for example, by saying that a duplicate opp level was ignored:
> > > 
> > > 	arm-scmi arm-scmi.0.auto: [Firmware Bug]: Ignoring duplicate OPP 3417600 for NCC
> > 
> > I did think about doing something similar but xa_insert can fail
> > with both -EXIST (duplicate) and -ENOMEM, so the we can't really
> > use term duplicate when insert fails. I can add the perf level
> > though to the message though.
> 
> We generally don't log errors for memory allocation failures (e.g. as
> that would already have been taken care of by the allocators, if that is
> the source of the -ENOMEM).
> 
> But either way you should be able to check the errno to determine if
> this is due to a duplicate entry or not.

Everyone has valid reasons for their argument here, so we need to find
a safe middle ground. Will stating it as [Possible Firmware Bug] be any
useful ? If there is -ENOMEM, other error messages will be seen before
this and user can ignore this error until that memory issue is fixed ?

-- 
Regards,
Sudeep

