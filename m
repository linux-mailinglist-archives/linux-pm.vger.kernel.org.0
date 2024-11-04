Return-Path: <linux-pm+bounces-16961-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF809BB730
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 15:08:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CF621C2330C
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 14:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3235C13AD06;
	Mon,  4 Nov 2024 14:08:15 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476F3139D13;
	Mon,  4 Nov 2024 14:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730729295; cv=none; b=Cp0r2Tt9cos/NImhWzUKbb9pLUEVA4ArBRTJwqy7IKatIf8SYAn/E904A0nk96lo06YAYLhkn1ocaK51Xc7Gqro3CYi7hb4pZr7amCgry3vAx4gQx8La/lXE880xZaafnI+sdzMvhg6W0aEqA951glparj/5JdR8btkstAduqUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730729295; c=relaxed/simple;
	bh=a9s0pcem8w3lxwWtyVVytPGNG3+oR268c7vvouYKUKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pMd4NOv9M/AtUilDVzSwV9DzGcthx82vAOLlwiHKARj4fZL69Gn+jj7T+7jdbOUe2wLbWwBVZuBjbnWer2nde6RQYx7/u0sKm9XMS4bPxGJcQ0LL3RxNw32sLn8L5fSNp+GKCbo8laAxqnnwQo1wCGOUaYbobC76jNbHpYanR4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 46138FEC;
	Mon,  4 Nov 2024 06:08:40 -0800 (PST)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E3DB03F6A8;
	Mon,  4 Nov 2024 06:08:07 -0800 (PST)
Date: Mon, 4 Nov 2024 14:07:56 +0000
From: Cristian Marussi <cristian.marussi@arm.com>
To: Sibi Sankar <quic_sibis@quicinc.com>
Cc: Johan Hovold <johan@kernel.org>, sudeep.holla@arm.com,
	cristian.marussi@arm.com, ulf.hansson@linaro.org,
	jassisinghbrar@gmail.com, dmitry.baryshkov@linaro.org,
	linux-kernel@vger.kernel.org, arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	konradybcio@kernel.org, linux-pm@vger.kernel.org,
	tstrudel@google.com, rafael@kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: Re: [PATCH V5 3/6] firmware: arm_scmi: Report duplicate opps as
 firmware bugs
Message-ID: <ZyjVMBtm0eLoDlYK@pluto>
References: <20241030125512.2884761-1-quic_sibis@quicinc.com>
 <20241030125512.2884761-4-quic_sibis@quicinc.com>
 <ZyThAFbOHKaBIgLg@hovoldconsulting.com>
 <e173058b-57e7-7fd0-dab7-7398bf9d66ec@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e173058b-57e7-7fd0-dab7-7398bf9d66ec@quicinc.com>

On Mon, Nov 04, 2024 at 07:20:01PM +0530, Sibi Sankar wrote:
> 
> 
> On 11/1/24 19:39, Johan Hovold wrote:
> > On Wed, Oct 30, 2024 at 06:25:09PM +0530, Sibi Sankar wrote:
> > > Duplicate opps reported by buggy SCP firmware currently show up
> > > as warnings even though the only functional impact is that the
> > > level/index remain inaccessible. Make it less scary for the end
> > > user by using dev_info instead, along with FW_BUG tag.
> > > 
> > > Suggested-by: Johan Hovold <johan+linaro@kernel.org>
> > > Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> > > ---
> > >   drivers/firmware/arm_scmi/perf.c | 4 ++--
> > >   1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
> > > index 32f9a9acd3e9..c7e5a34b254b 100644
> > > --- a/drivers/firmware/arm_scmi/perf.c
> > > +++ b/drivers/firmware/arm_scmi/perf.c
> > > @@ -387,7 +387,7 @@ process_response_opp(struct device *dev, struct perf_dom_info *dom,
> > >   	ret = xa_insert(&dom->opps_by_lvl, opp->perf, opp, GFP_KERNEL);
> > >   	if (ret) {
> > > -		dev_warn(dev, "Failed to add opps_by_lvl at %d for %s - ret:%d\n",
> > > +		dev_info(dev, FW_BUG "Failed to add opps_by_lvl at %d for %s - ret:%d\n",
> > >   			 opp->perf, dom->info.name, ret);
> > 
> > I was hoping you could make the error message a bit more informative as
> > well, for example, by saying that a duplicate opp level was ignored:
> > 
> > 	arm-scmi arm-scmi.0.auto: [Firmware Bug]: Ignoring duplicate OPP 3417600 for NCC
> 
> I did think about doing something similar but xa_insert can fail
> with both -EXIST (duplicate) and -ENOMEM, so the we can't really
> use term duplicate when insert fails. I can add the perf level
> though to the message though.
> 

It is the caller iter_perf_levels_process_response() of the above
helpers that is in charge to check the retval and decide what to do:
if it is a -EBUSY it just bails out returning 0 (SKIP) otherwise returns
the error... (and anyway the warn/info had already been given)

Originally the message was generic exactly for this reason...making some
noise to have fw/guys fix it and carry on...or fail completely the otehr
way...

I suppose you should move the error message in the caller if you want
to attain this level of information for the user...if not you are also
making noise potentially for nothing by saying FW_BUG on an -ENOMEM...

....anyway, on the otehr side, on the -ENOMEM path there is probably
really no need to say anything in any case...things are going terribly
wrong and you will notice soon in the form of a total failure of the stack,
most probably.

Thanks,
Cristian

