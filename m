Return-Path: <linux-pm+bounces-8047-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9658CC3AB
	for <lists+linux-pm@lfdr.de>; Wed, 22 May 2024 17:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87C23281C3A
	for <lists+linux-pm@lfdr.de>; Wed, 22 May 2024 15:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E8117556;
	Wed, 22 May 2024 15:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rZrZun4u"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9D4AD23;
	Wed, 22 May 2024 15:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716390056; cv=none; b=VwBNYyWKz3unyi3vkiGf+ZlN76FljIoxcN3NfZz0Fib6/Xbc0uTwUNda10pFE/4+tDcefbgHki3NQiiBpqLqP2OO/LTi7n9/yAaciteqkXN1W5s8VbfC/Gh9Kiosk7iXpKq/MsrobWHPUVSsUf/GyEmeoUA7Zn7FJlDWeO1nZvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716390056; c=relaxed/simple;
	bh=4pdAzhbUK2tL0oB6flZpstCuhJJbI2mdYJEwhKfdzs8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lcyzT+MxjdLkRwr5TZPJxFdJ6zEdfM//duQQ/yXkVyI/ntMUW1pdGgBRG1BnEhOTqb6oGnjyI8jnXRh/EJPPaO1nk/CDQSTz0/BiQsec1kKBWTgnR9CEnA0oX6JKoJP/d9qFsC0IdakzJFKVUa4rOtgu467P1Zbpu3xwzWwpOB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rZrZun4u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFE13C2BBFC;
	Wed, 22 May 2024 15:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716390056;
	bh=4pdAzhbUK2tL0oB6flZpstCuhJJbI2mdYJEwhKfdzs8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rZrZun4umNT26if2ijBipctJlvrW5ohvd+Rda/UdY8LIkzWmFxfUze/N4XLt/pesQ
	 d/v3VsvEVc3U936NdWseVbClZ9dUXpWy74mfbRvLrQmF4l10B/p/VpXFB7zXUXOUwK
	 wIf27Qo1LqiH6rZRwBZIDVO30vt1PpHYxcLcUl+cKhb1AvmsaENGqUjIwCIC8/Vfw4
	 qvKKVr34wOwSTY+1fynwAso4llPK+k8VtF/VmZBQFlynfhWbLkMqxM6DqM+2FGqFBE
	 DMwJUK8PWjnpqCg02EuMEmBVi7jSmoP1SGskMjhxH2W5TGeZCmdEe4Y1KwpYo/LU8o
	 XvoZsphGw4/5Q==
Date: Wed, 22 May 2024 10:00:54 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: David Dai <davidai@google.com>
Cc: Will Deacon <will@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Pavan Kondeti <quic_pkondeti@quicinc.com>,
	devicetree@vger.kernel.org,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@google.com>,
	Quentin Perret <qperret@google.com>,
	Gupta Pankaj <pankaj.gupta@amd.com>, Marc Zyngier <maz@kernel.org>,
	Mel Gorman <mgorman@suse.de>,
	"Rafael J. Wysocki" <rafael@kernel.org>, kernel-team@android.com
Subject: Re: [PATCH v6 1/2] dt-bindings: cpufreq: add virtual cpufreq device
Message-ID: <171639005247.3294172.9981807951705426790.robh@kernel.org>
References: <20240521043102.2786284-1-davidai@google.com>
 <20240521043102.2786284-2-davidai@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240521043102.2786284-2-davidai@google.com>


On Mon, 20 May 2024 21:30:51 -0700, David Dai wrote:
> Adding bindings to represent a virtual cpufreq device.
> 
> Virtual machines may expose MMIO regions for a virtual cpufreq device
> for guests to read performance information or to request performance
> selection. The virtual cpufreq device has an individual controller for
> each performance domain. Performance points for a given domain can be
> normalized across all domains for ease of allowing for virtual machines
> to migrate between hosts.
> 
> Co-developed-by: Saravana Kannan <saravanak@google.com>
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> Signed-off-by: David Dai <davidai@google.com>
> ---
>  .../cpufreq/qemu,virtual-cpufreq.yaml         | 48 +++++++++++++++++++
>  1 file changed, 48 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/cpufreq/qemu,virtual-cpufreq.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


