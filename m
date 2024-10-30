Return-Path: <linux-pm+bounces-16712-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE73E9B5EE0
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 10:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 725D9283E81
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 09:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26201E22E8;
	Wed, 30 Oct 2024 09:32:27 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05037197531;
	Wed, 30 Oct 2024 09:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730280747; cv=none; b=HvTqJn3rIN+HzZNSLS4PYRjIjo++umB1+Ww/SGlFw+Nt6wR+mhCEtIkaf9dufuETBo3YI4k4w0QMADXYeW2AdrZBqE2+sPhTWZPIK0jT3RXYMnvN941we266xnrTEjpfDpjPiz83fx+udbR9R5GsXeLfs+gilWBo91/y0SxVeVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730280747; c=relaxed/simple;
	bh=Lg1MJ1BXTRK5oybRjcNrrJIYgJ4KAsr6ie6G2P661bo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mmLcQRwBcuz31il0UeyxLYCv+8K1oTmyVs1Mi2v2ZBesV1lObZ2/LPJAKEVm/qLs2ZPO4I6dSCn653YIlMk9l+M3Cm6m4PSSCuCYcDEYdatqmnhvUeE2MgktvlDa0SaWrVA5etLy7peeoUJfP78qL6f5FiE+oYmvxRz1JlPXpB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1A818113E;
	Wed, 30 Oct 2024 02:32:54 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DFBDE3F66E;
	Wed, 30 Oct 2024 02:32:21 -0700 (PDT)
Date: Wed, 30 Oct 2024 09:32:14 +0000
From: Cristian Marussi <cristian.marussi@arm.com>
To: Sibi Sankar <quic_sibis@quicinc.com>
Cc: sudeep.holla@arm.com, cristian.marussi@arm.com, rafael@kernel.org,
	viresh.kumar@linaro.org, morten.rasmussen@arm.com,
	dietmar.eggemann@arm.com, lukasz.luba@arm.com,
	pierre.gondois@arm.com, vincent.guittot@linaro.org,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, quic_mdtipton@quicinc.com,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH V5 1/1] cpufreq: scmi: Register for limit change
 notifications
Message-ID: <ZyH9HvKmYjlJC8_x@pluto>
References: <20240603192654.2167620-1-quic_sibis@quicinc.com>
 <20240603192654.2167620-2-quic_sibis@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603192654.2167620-2-quic_sibis@quicinc.com>

On Tue, Jun 04, 2024 at 12:56:54AM +0530, Sibi Sankar wrote:
> Register for limit change notifications if supported and use the throttled
> frequency from the notification to apply HW pressure.
> 

This sort of got lost in mbox...apologies.

As discussed offlist, the issue with cpufreq and multiple SCMI instances
remains BUT it will be solved later on with a different approach, so
as of now this LGTM.

Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>

Thanks,
Cristian

P.S.: have you got any chance to try the hack/experimental patch I CCed
you to address the multi/instance cpufreq issues ? (just to understand
if it is a viable option...)

