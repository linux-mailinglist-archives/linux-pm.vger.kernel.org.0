Return-Path: <linux-pm+bounces-10192-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24CCD91BECE
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2024 14:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D58C0285756
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2024 12:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90DE9158A3A;
	Fri, 28 Jun 2024 12:42:14 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7FB515572B;
	Fri, 28 Jun 2024 12:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719578534; cv=none; b=bKwM2aBLENIYS/0gvw/KR/0vU1BEl/2ddVXu+Qd0MXjV2w3CQY+CoaPfcRALlzYAq8GROsV/RnzG+q0jIFpQu5e/vD/2QQPz3nHOGFD660h189SVVcBybxjxlC8mRhHdlzCxq6DCw+Xl/DIj2vryUxsGiVWuMaiSeKegtdNg6/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719578534; c=relaxed/simple;
	bh=XC0hcIAUM/jpVJyP+KwrsMF68vxYpQhsEFJXuiyM+5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MLqr7Q0PElYgi2++XCxWF5L+3iANopSefljdD96eYAuCUev2Th8sWE3Q+VnYVr5vezX+xXNVVKBjkG+xPqmnvzg1TiEIwu779kZ998G4P1S9d14Gnhcdg1CL/MafdVYfhdWX94/TFL8lqfsB94wMh+T8ejIM5aTIqiQucbmsLGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DB213106F;
	Fri, 28 Jun 2024 05:42:36 -0700 (PDT)
Received: from bogus (unknown [10.57.81.131])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 624DF3F6A8;
	Fri, 28 Jun 2024 05:42:07 -0700 (PDT)
Date: Fri, 28 Jun 2024 13:42:07 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: David Dai <davidai@google.com>, Viresh Kumar <viresh.kumar@linaro.org>,
	Sudeep Holla <sudeep.holla@arm.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Quentin Perret <qperret@google.com>,
	Masami Hiramatsu <mhiramat@google.com>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Pavan Kondeti <quic_pkondeti@quicinc.com>,
	Gupta Pankaj <pankaj.gupta@amd.com>, Mel Gorman <mgorman@suse.de>,
	kernel-team@android.com, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] cpufreq: add virtual-cpufreq driver
Message-ID: <20240628124207.qnu5jypprsibpx72@bogus>
References: <20240521043102.2786284-1-davidai@google.com>
 <20240521043102.2786284-3-davidai@google.com>
 <CABN1KCKirjdVxF7Mc38tToB9OKH3n2kdN6k1tJbC-cyUtsVAFA@mail.gmail.com>
 <CAJZ5v0jcZW92zm916VAD2a9_CMusuG-K968hWBS+tS1BL-Lspw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0jcZW92zm916VAD2a9_CMusuG-K968hWBS+tS1BL-Lspw@mail.gmail.com>

On Fri, Jun 28, 2024 at 02:01:16PM +0200, Rafael J. Wysocki wrote:
> Hi,
> 
> On Thu, Jun 27, 2024 at 11:22 PM David Dai <davidai@google.com> wrote:
> >
> > Hi folks,
> >
> > Gentle nudge on this patch to see if there's any remaining concerns?
> 
> Yes, there are.
> 
> The dependency of OF is pretty much a no-go from my perspective.
> 

I agree and I don't think it is needed as well, can be removed easily IMO.

--
Regards,
Sudeep

