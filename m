Return-Path: <linux-pm+bounces-17662-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DBEB9CFD03
	for <lists+linux-pm@lfdr.de>; Sat, 16 Nov 2024 08:43:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72874287DC5
	for <lists+linux-pm@lfdr.de>; Sat, 16 Nov 2024 07:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E12191473;
	Sat, 16 Nov 2024 07:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2W/t/W7Y"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29695181CE1;
	Sat, 16 Nov 2024 07:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731743013; cv=none; b=oGDxOGflVqVXiKhy2i8D3rkfo6SxUUbBC68pGdKbltYh1+s2DfdoIOEcaogPSe0NzER15fY7+YbcvNpMGU/QnMoutEOk3AH3rW7XxJri1noyR6yo6bqSl5wq5nmhPhaR+IoSdcSh95RhfmEEIJxcyYXp+vu4VgsUvzp3i4hMmx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731743013; c=relaxed/simple;
	bh=7iY2SnGNn9JGQJ3Q4hJYLUfDCLFuWIm9yVt1xqdObDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RL+g87UPuMe8WQuubAPbEyVCDHZre9wCezjzw5XDiJ6xDOX3m/v5JVde+BO99E9TcrHqR9wDDp7BL8kwGl/6vJXMnqKCcy+qSMXd2Abk1MO1yengD9R2i8Mqrgbuepnn4zy3K+3EBGp4dvMmXuw2EFZQh5hBUKqDIIAqnuOyPoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2W/t/W7Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B139C4CEC3;
	Sat, 16 Nov 2024 07:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731743012;
	bh=7iY2SnGNn9JGQJ3Q4hJYLUfDCLFuWIm9yVt1xqdObDM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2W/t/W7YNfEcJjMCIn1v831TZlxo+p2RFbe/VPyqnImZiAftx/qwNXqxiPSNDF6S3
	 D25pOx4mp3Fbr+JxR8MMl4nVCKOuEjVWU45bKDIYWerPE8/HNLHLBeN/Rf9H4PTuf9
	 Cz5jek3MVDMhOwk7gobsDN8YGH91RltSi9ceHTqU=
Date: Sat, 16 Nov 2024 08:43:09 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Saravana Kannan <saravanak@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>,
	Len Brown <len.brown@intel.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Marek Vasut <marex@denx.de>, Bird@google.com,
	Tim <Tim.Bird@sony.com>, kernel-team@android.com,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/5] PM: sleep: Fix runtime PM issue in dpm_resume()
Message-ID: <2024111648-drilling-jubilant-1285@gregkh>
References: <20241114220921.2529905-1-saravanak@google.com>
 <20241114220921.2529905-2-saravanak@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114220921.2529905-2-saravanak@google.com>

On Thu, Nov 14, 2024 at 02:09:15PM -0800, Saravana Kannan wrote:
> Some devices might have their is_suspended flag set to false. In these
> cases, dpm_resume() should skip doing anything for those devices.
> However, runtime PM enable and a few others steps are done before
> checking for this flag. Fix it so that we do things in the right order.
> 
> Signed-off-by: Saravana Kannan <saravanak@google.com>

This looks like a nice generic fix as well, should it go to older
kernels?

thanks,

greg k-h

