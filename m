Return-Path: <linux-pm+bounces-10698-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FAE7928932
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jul 2024 15:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AEC328350D
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jul 2024 13:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F141F14A4FF;
	Fri,  5 Jul 2024 13:04:59 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F00143C79;
	Fri,  5 Jul 2024 13:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720184699; cv=none; b=JSvfqTsY/c7PygYUEb3IcYmd+g/X0iiHEwPPzRlLoZCMstSEgqOKv0T+OM9sjEWErtkd289udfvoLPqSI/xXm5x/nMK6GxorIrKrjhapBbU6sf1j8LggQZVYXB8h/5o2IMa/Rx7z3xJlzcOYpvRZSm+cS3goJNY+ZZ1l4flYHyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720184699; c=relaxed/simple;
	bh=EWI4zmWAXKTS95NpgBFwzsLFCqxfVD6ICNOLsknuZDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dWx4uh9fe752pdxhlWQ//c6/ihA7/mI0Oii85GdM8125wqKDrd/rJnHuFQQl0KrlTk3AMBf2ElzPAsRUSX3qxjApQex3Uu/t2Cp9rDQWmDzrMP1XWEsOq+yyPgpP8e3yoZIKOX/k5+dJtr7kYP59MSExSzsafnl6joeYDK7GdBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 67A83367;
	Fri,  5 Jul 2024 06:05:21 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3168C3F762;
	Fri,  5 Jul 2024 06:04:54 -0700 (PDT)
Date: Fri, 5 Jul 2024 14:04:51 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Sibi Sankar <quic_sibis@quicinc.com>
Cc: <ulf.hansson@linaro.org>, <cristian.marussi@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>, <linux-kernel@vger.kernel.org>,
	<arm-scmi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<quic_rgottimu@quicinc.com>, <quic_kshivnan@quicinc.com>,
	<johan@kernel.org>
Subject: Re: [PATCH] pmdomain: arm: Fix debugfs node creation failure
Message-ID: <Zofvc31pPU23mjnp@bogus>
References: <20240703110741.2668800-1-quic_sibis@quicinc.com>
 <ZoZ6Pk7NSUNDB74i@bogus>
 <064274c4-3783-c59e-e293-dd53a8595d8e@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <064274c4-3783-c59e-e293-dd53a8595d8e@quicinc.com>

On Fri, Jul 05, 2024 at 09:16:29AM +0530, Sibi Sankar wrote:
>
> On 7/4/24 16:02, Sudeep Holla wrote:
> >
> > If there are 2 perf domains for a device or group of devices, there must
> > be something unique about each of these domains. Why can't the firmware
> > specify the uniqueness or the difference via the name?
> >
> > The example above seems firmware is being just lazy to update it. Also
> > for the user/developer/debugger, the unique name might be more useful
> > than just this number.
> >
> > So please use the name(we must now have extended name if 16bytes are less)
> > to provide unique names. Please stop working around such silly firmware
> > bugs like this, it just makes using debugfs for anything useful harder.
>
> This is just meant to address firmware that are already out in the wild.
> That being said I don't necessarily agree with the patch either since
> it's penalizing firmware that actually uses a proper name by appending
> something inherently less useful to it. Since, the using of an unique
> domain name isn't required by the spec, the need for it goes under the radar
> for vendors. Mandating it might be the right thing to do since
> the kernel seems inherently expect that.
>

Well I would love if spec authors can agree and mandate this. But this is
one of those things I can't argue as I don't necessarily agree with the
argument. There are 2 distinct/unique domains but firmware authors ran out
of unique names for them or just can't be bothered to care about it.

They can't run out of characters as well in above examples, firmware can
add some useless domain ID in the name if they can't be bothered or creative.

So I must admit I can't be bothered as well with that honestly.
--
Regards,
Sudeep

