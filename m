Return-Path: <linux-pm+bounces-614-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ECD9800B3F
	for <lists+linux-pm@lfdr.de>; Fri,  1 Dec 2023 13:44:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 815221C209C8
	for <lists+linux-pm@lfdr.de>; Fri,  1 Dec 2023 12:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9E01C685;
	Fri,  1 Dec 2023 12:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CnrmfvMk"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576675954E;
	Fri,  1 Dec 2023 12:44:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B36CC433C7;
	Fri,  1 Dec 2023 12:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701434647;
	bh=ah7J3Jqo85Y9L6UmtUaNFJgYT5iUf/nZE7iW/HuhMYc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CnrmfvMkp6yoWoq8NJ1XEtT4O7m4/JQFa1GxIQtgU5F5aVDX1HP/VVulkZDwyD9T4
	 BGMGmR+Ksv/nWBy6gUv3Kf7zzXD15PwDGmDpOZ3O6677P90vL/UIHKVpfsF9QLy/r8
	 85SsqfXldhr9nl3+62tAyAV3Mi9xas7AUdSF1E1o=
Date: Fri, 1 Dec 2023 12:44:04 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	daniel.lezcano@linaro.org, rafael@kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] powercap: DTPM: Fix the missing cpufreq_cpu_put() calls
Message-ID: <2023120139-staging-sprang-7e77@gregkh>
References: <20231201123205.1996790-1-lukasz.luba@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201123205.1996790-1-lukasz.luba@arm.com>

On Fri, Dec 01, 2023 at 12:32:05PM +0000, Lukasz Luba wrote:
> The policy returned by cpufreq_cpu_get() has to be released with
> the help of cpufreq_cpu_put() to balance its kobject reference counter
> properly.
> 
> Add the missing calls to cpufreq_cpu_put() in the code.
> 
> Fixes: 0aea2e4ec2a2 ("powercap/dtpm_cpu: Reset per_cpu variable in the release function")
> Fixes: 0e8f68d7f048 ("powercap/drivers/dtpm: Add CPU energy model based support")
> Cc: <stable@vger.kernel.org> # v5.10+

But the Fixes: tags are for commits that are only in 5.12 and newer, how
can this be relevant for 5.10?

thanks,

greg k-h

