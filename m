Return-Path: <linux-pm+bounces-16871-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 318AB9B92D4
	for <lists+linux-pm@lfdr.de>; Fri,  1 Nov 2024 15:09:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E623528264C
	for <lists+linux-pm@lfdr.de>; Fri,  1 Nov 2024 14:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FAD81A0BCA;
	Fri,  1 Nov 2024 14:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oVhaYgZs"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DEC15855D;
	Fri,  1 Nov 2024 14:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730470146; cv=none; b=S5jiU8O7Drz1G0KHC4QwTNDfRTwyFoBQW6Y0RCE3wcbrLuX7M9EfaxPqvW86R80l3ukpN67ev6rVoyYDisL7a/sHpW2bGJypkLUW1V69Le6B/EMNMOqVuS+7Rb5HOVYwG12uoWQ1QzLxjD28fwr/8gi1tiqmHNNRVr5o0fWt+ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730470146; c=relaxed/simple;
	bh=V1lHT+M0hVf8y3QEJQ9Y5vnOyPZcmjeWG3D2SQpniHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S5U4DkXYtTmDuSid46YBhEn5qnRgTAL5RZWa8OPmFO2Nq6gjq/pfAH2bgKWkht1Jj/M+VATtFIrU3/TYCxByiCwn9R4TTnb0y1a/eTd4mZ+j5YWS/ldtjHDpUWKJNQjn91/QXpmAPoVjDveRjrqmpRjrCtZpqvC0kdSTqewMQpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oVhaYgZs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E050DC4CECD;
	Fri,  1 Nov 2024 14:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730470146;
	bh=V1lHT+M0hVf8y3QEJQ9Y5vnOyPZcmjeWG3D2SQpniHI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oVhaYgZse3lMJvuJEkmIOrlzosfBzD3lhMSHwGYeeZFK4qL9cuJ7bAxDJIV38WzpX
	 ml0u+DWHbWIML5Qs5h7G7clpJQN4xzOBOF//wa3XwUiM6G6d7pPzhKzL608g8+n9DW
	 vhrw84lpWizMsRMQkdw8w7iPjpe/2eFSxpU/N4empIL6yVXUhDh3H+KCgbabmQeigB
	 G7TmWJWrqT3hbGy4QoVAT02nf95JHTmGbsxRWomK8DuWVRvM1/2jkwMVCYwcF6J3G4
	 i8ad4X6AUL2iEiMG9cNfF+4qD2wD/boI0rJzM1eQvtsl22qYHbbkyv92ilMF5IaI16
	 pgEYnAflSDjDw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1t6sKm-000000005cY-06Fr;
	Fri, 01 Nov 2024 15:09:04 +0100
Date: Fri, 1 Nov 2024 15:09:04 +0100
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
Message-ID: <ZyThAFbOHKaBIgLg@hovoldconsulting.com>
References: <20241030125512.2884761-1-quic_sibis@quicinc.com>
 <20241030125512.2884761-4-quic_sibis@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030125512.2884761-4-quic_sibis@quicinc.com>

On Wed, Oct 30, 2024 at 06:25:09PM +0530, Sibi Sankar wrote:
> Duplicate opps reported by buggy SCP firmware currently show up
> as warnings even though the only functional impact is that the
> level/index remain inaccessible. Make it less scary for the end
> user by using dev_info instead, along with FW_BUG tag.
> 
> Suggested-by: Johan Hovold <johan+linaro@kernel.org>
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> ---
>  drivers/firmware/arm_scmi/perf.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
> index 32f9a9acd3e9..c7e5a34b254b 100644
> --- a/drivers/firmware/arm_scmi/perf.c
> +++ b/drivers/firmware/arm_scmi/perf.c
> @@ -387,7 +387,7 @@ process_response_opp(struct device *dev, struct perf_dom_info *dom,
>  
>  	ret = xa_insert(&dom->opps_by_lvl, opp->perf, opp, GFP_KERNEL);
>  	if (ret) {
> -		dev_warn(dev, "Failed to add opps_by_lvl at %d for %s - ret:%d\n",
> +		dev_info(dev, FW_BUG "Failed to add opps_by_lvl at %d for %s - ret:%d\n",
>  			 opp->perf, dom->info.name, ret);

I was hoping you could make the error message a bit more informative as
well, for example, by saying that a duplicate opp level was ignored:

	arm-scmi arm-scmi.0.auto: [Firmware Bug]: Ignoring duplicate OPP 3417600 for NCC

or similar (e.g. as the current message looks like an error, with errno
and all, that indeed warrants warning level).

Perhaps with such a message you could even keep the warning level to
make it stand out more (if that's desirable) without the risk of scaring
users.

Johan

