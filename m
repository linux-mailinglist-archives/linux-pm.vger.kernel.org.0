Return-Path: <linux-pm+bounces-7275-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A39208B5630
	for <lists+linux-pm@lfdr.de>; Mon, 29 Apr 2024 13:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5073C1F21EB1
	for <lists+linux-pm@lfdr.de>; Mon, 29 Apr 2024 11:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7E53D56D;
	Mon, 29 Apr 2024 11:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0Mt11OT6"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432EE5382;
	Mon, 29 Apr 2024 11:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714389153; cv=none; b=faGwrIXWXQTr84G7BlP+Y0xzr2PaxRLktqBKfV0OPllW0eMQyY0R6cY65Xguf3EH5bAgdoNarBGoCkga8DDoii4c7LSHI3+uP21ZD43GV/QZmlDqf/2XvTGF4+VyGbBCQPI3AJ++IoEN4emkMkYd18ZuPg+Ff0b+wLzOX4jBmTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714389153; c=relaxed/simple;
	bh=lzTWWW43K3gPneW5OXkC13YOFffiN5E4u6PkjR57FOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e411DwSFgNmRVFfCjqzlLXonKmKH5d5PSJNgYztD45EByQ12phN3F/WKeESxUzGo2jCZ6RX+frK5dnj1LTwFKUZRYoUz0nuUohZUMQSiZPHtA5Z7C2YjOEGJAcwo6LWCHwuVcZzag5dSp3OxZH5620RF5znhQ/TtISafNAWPpSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0Mt11OT6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81E79C113CD;
	Mon, 29 Apr 2024 11:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714389152;
	bh=lzTWWW43K3gPneW5OXkC13YOFffiN5E4u6PkjR57FOM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0Mt11OT6aIJnqNpv2EG5+esj2ff10d/2TtW83Mtchg295Swr52Sx0+R22zVnwrFBS
	 Wk/9BqAeAStsuGvTAeXGFkTRVQJrIrqYeYuRAFqPAEf0Fu0FJTrlEi4UqM2h0wM494
	 T/uFCUrjLaEG7o5oV97MWDkSkZdkA/fPrXcns25s=
Date: Mon, 29 Apr 2024 13:12:30 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Sasha Levin <sashal@kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Johnny Liu <johnliu@nvidia.com>, Jon Hunter <jonathanh@nvidia.com>,
	Linux PM list <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 5.10.y] PM / devfreq: Fix buffer overflow in
 trans_stat_show
Message-ID: <2024042922-fleshed-bonding-648d@gregkh>
References: <8a59f3b2-48b0-4a62-ab54-61f8d6068cbc@siemens.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a59f3b2-48b0-4a62-ab54-61f8d6068cbc@siemens.com>

On Sun, Apr 28, 2024 at 10:28:42AM +0200, Jan Kiszka wrote:
> From: Christian Marangi <ansuelsmth@gmail.com>
> 
> [ Upstream commit 08e23d05fa6dc4fc13da0ccf09defdd4bbc92ff4 ]
> 
> Fix buffer overflow in trans_stat_show().
> 
> Convert simple snprintf to the more secure scnprintf with size of
> PAGE_SIZE.
> 
> Add condition checking if we are exceeding PAGE_SIZE and exit early from
> loop. Also add at the end a warning that we exceeded PAGE_SIZE and that
> stats is disabled.
> 
> Return -EFBIG in the case where we don't have enough space to write the
> full transition table.
> 
> Also document in the ABI that this function can return -EFBIG error.
> 
> Link: https://lore.kernel.org/all/20231024183016.14648-2-ansuelsmth@gmail.com/
> Cc: stable@vger.kernel.org
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218041
> Fixes: e552bbaf5b98 ("PM / devfreq: Add sysfs node for representing frequency transition information.")
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
> 
> Original found by someone at Nvidia. But this backport is based on the 
> 5.15 commit (796d3fad8c35ee9df9027899fb90ceaeb41b958f) where only a 
> conflict in sysfs-class-devfreq needed manual resolution.

Now queued up, thanks.

greg k-h

