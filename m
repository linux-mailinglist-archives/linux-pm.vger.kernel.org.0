Return-Path: <linux-pm+bounces-16962-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 976EE9BB735
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 15:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B15C28510E
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 14:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D6D13B29B;
	Mon,  4 Nov 2024 14:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K6IxGyA5"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416DF7083E;
	Mon,  4 Nov 2024 14:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730729355; cv=none; b=V4xSF6QS3Rqhm2w83GGcQtaavYtLxZlcfRMNqfq8CMxPvgX1Rnd6nqCQ0pWEA8QeS5JjaQpTCpJx/FoYK4qoYbHuPdCQ5ZsfLsjuqI3YB2t/PfWj5m+k5eNwhE/6pHAirDjOAsgZGgxOYQlmdRJcXaD50+DoGD7fWCLWwwcTXqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730729355; c=relaxed/simple;
	bh=65OFDvUsjvE7rt/DlU7JuIUhbpB5mDQ8n6OdH0qeDdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iuKMaIym4FdyrNYenUux+5MKBYEzHIbx/jPD54Jr+gK05fUltxZ2BlqLfgxX4e5ebJ7lHvBRFbsv5YdLEH6F/f4c+riAJ1QbtQ44G9KtEBMbFq0+hiGuAykvGaIur1nOB3XsvQEjuLj2TzjnlxAUdul0OLnS3FGFiApWlp5l0gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K6IxGyA5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2BC2C4CED1;
	Mon,  4 Nov 2024 14:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730729354;
	bh=65OFDvUsjvE7rt/DlU7JuIUhbpB5mDQ8n6OdH0qeDdg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K6IxGyA5/Q/v4wvgVx/3Dw5iJbz7au6BOTy3Lu+rzx2ltxMP6fU65t2dyxmWM2z5l
	 GWd3spdQxqRpZ4D1FJgkdK4MqdY/Ev4CRNKhaegnblnbgZdrp2V8EdzDysSWNXbuwL
	 f/JIx0La64PUWPZgjHArkAm7GN3cBnOu81QIXNUJEF7BWzQs9a6Z4h4ZZTfzVQ6qk3
	 N/NhzyE6jPvs2rbK/cH618vIkEwWYDHnGJh66ZnnBK2yg9+mjEF8+Ymp7eDrXxz3O/
	 2D0R/QoX0e6PptFFVAIsj0sG4cENQlcg1O4irSGrfgr041SyD0v18GvTlEwznGeaFj
	 bpHX3ZeBYtUqg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1t7xlY-000000007gd-0i2h;
	Mon, 04 Nov 2024 15:09:12 +0100
Date: Mon, 4 Nov 2024 15:09:12 +0100
From: Johan Hovold <johan@kernel.org>
To: Sibi Sankar <quic_sibis@quicinc.com>
Cc: sudeep.holla@arm.com, cristian.marussi@arm.com, ulf.hansson@linaro.org,
	jassisinghbrar@gmail.com, dmitry.baryshkov@linaro.org,
	linux-kernel@vger.kernel.org, arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	konradybcio@kernel.org, linux-pm@vger.kernel.org,
	tstrudel@google.com, rafael@kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: Re: [PATCH V5 3/6] firmware: arm_scmi: Report duplicate opps as
 firmware bugs
Message-ID: <ZyjViCVtPwe-tmMq@hovoldconsulting.com>
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
> On 11/1/24 19:39, Johan Hovold wrote:
> > On Wed, Oct 30, 2024 at 06:25:09PM +0530, Sibi Sankar wrote:

> >> @@ -387,7 +387,7 @@ process_response_opp(struct device *dev, struct perf_dom_info *dom,
> >>   
> >>   	ret = xa_insert(&dom->opps_by_lvl, opp->perf, opp, GFP_KERNEL);
> >>   	if (ret) {
> >> -		dev_warn(dev, "Failed to add opps_by_lvl at %d for %s - ret:%d\n",
> >> +		dev_info(dev, FW_BUG "Failed to add opps_by_lvl at %d for %s - ret:%d\n",
> >>   			 opp->perf, dom->info.name, ret);
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

We generally don't log errors for memory allocation failures (e.g. as
that would already have been taken care of by the allocators, if that is
the source of the -ENOMEM).

But either way you should be able to check the errno to determine if
this is due to a duplicate entry or not.

Johan

