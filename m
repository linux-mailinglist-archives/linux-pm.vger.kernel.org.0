Return-Path: <linux-pm+bounces-10596-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 785CA92741C
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jul 2024 12:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34A67285689
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jul 2024 10:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5555D1AB52A;
	Thu,  4 Jul 2024 10:32:38 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62FB1D696;
	Thu,  4 Jul 2024 10:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720089158; cv=none; b=bLPdJZOUDavtpVaK/VuuTfKc2dMavJohZ7ApQbjWvbf5q0Y1mA3omQioKmk28rJBYMq9bvyuUdbUyga/xAY0eHz9k7OkXNara5xne75e+rnRZF8KVjzuxZ1r3F6bOR04sb96jNj7B7mrJREV+wHaClrcVH1dvzRh619j/k13l/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720089158; c=relaxed/simple;
	bh=0PZh3q+a7ToijpDQIW9OsIT8qGi+U0E5R5MjBL/wbWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IbDLrqYSLSwbDRIv/C5/uj+Z8JPZcECk5gIVdn2Jvym65orrFupqZwFB23FIhaF+0eKNxHI8xjRicpjB41ajsvaHEc9AphqHYPdOS/5UEyuuiQQ8M3WblRe8UgERzCHfXtuyOYqXVMNdVCbvVSjb/AEyGdhIlDP++ktUntiUsJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4E801367;
	Thu,  4 Jul 2024 03:33:00 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6A1A53F762;
	Thu,  4 Jul 2024 03:32:33 -0700 (PDT)
Date: Thu, 4 Jul 2024 11:32:30 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Sibi Sankar <quic_sibis@quicinc.com>
Cc: <ulf.hansson@linaro.org>, <cristian.marussi@arm.com>,
	<linux-kernel@vger.kernel.org>, <arm-scmi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<quic_rgottimu@quicinc.com>, <quic_kshivnan@quicinc.com>,
	Sudeep Holla <sudeep.holla@arm.com>, <johan@kernel.org>
Subject: Re: [PATCH] pmdomain: arm: Fix debugfs node creation failure
Message-ID: <ZoZ6Pk7NSUNDB74i@bogus>
References: <20240703110741.2668800-1-quic_sibis@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703110741.2668800-1-quic_sibis@quicinc.com>

On Wed, Jul 03, 2024 at 04:37:41PM +0530, Sibi Sankar wrote:
> The domain attributes returned by the perf protocol can end up
> reporting identical names across domains, resulting in debugfs
> node creation failure. Fix this duplication by appending the
> domain-id to the domain name.
> 
> Logs:
> debugfs: Directory 'NCC' with parent 'pm_genpd' already present!
> debugfs: Directory 'NCC' with parent 'pm_genpd' already present!
>

If there are 2 perf domains for a device or group of devices, there must
be something unique about each of these domains. Why can't the firmware
specify the uniqueness or the difference via the name?

The example above seems firmware is being just lazy to update it. Also
for the user/developer/debugger, the unique name might be more useful
than just this number.

So please use the name(we must now have extended name if 16bytes are less)
to provide unique names. Please stop working around such silly firmware
bugs like this, it just makes using debugfs for anything useful harder.

--
Regards,
Sudeep

