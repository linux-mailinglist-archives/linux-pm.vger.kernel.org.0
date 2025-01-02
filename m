Return-Path: <linux-pm+bounces-19911-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E282E9FFB2F
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jan 2025 16:53:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A13F2162628
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jan 2025 15:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C121B0425;
	Thu,  2 Jan 2025 15:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZUojcRWn"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F0119D071;
	Thu,  2 Jan 2025 15:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735833235; cv=none; b=Q/nxQQKlGMorYoRiSfWcqcFqnssMjOoGqoSAZINBWVTwAmouozfc6TQ/BEb1C1+upPViY8P+koISg+M3grTzG7o78AKoq2XCK6l+jIho7WtoUPxSVl60WtjRPOGfdFrlNbT54LF/juEHj6gS1bk0DgvVFqrA1hzDAeUEziKb1fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735833235; c=relaxed/simple;
	bh=v1J47GRanwUoooSHR/5HYWsIvjii039mjEWLgd0obV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n3ao/xV/EFjsRuYHUx5QNx9TkZMlnFMRsR8xBP2AgdgRM01MahIx8iYi+iIF5GN7HMt5SGLOkOhdOdJp13nFtFXzExZnmYdacxIX8DwngP9HM+LGLBLE6fv+/tDB35KRvQQoMYZOKjKxbtWh/gdBNL8MD8YNogrE578MwNob/Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZUojcRWn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6005C4CED0;
	Thu,  2 Jan 2025 15:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1735833234;
	bh=v1J47GRanwUoooSHR/5HYWsIvjii039mjEWLgd0obV4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZUojcRWnWldRtKvD9P7IsjiYfWeM9RgLYFrkkx7ndYtBWg0OznERz7nKBZbMqGBWa
	 8FSUbu9PeIDm84vF/SQSGzQQ0PnsgJUXalMBYwpDKwQMvgfQHYcsldo0AGyz5OnL96
	 PG+mbKGtmvqt7JZLfYst/CZJrwniWYDqScW0Kjmg=
Date: Thu, 2 Jan 2025 16:53:50 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Georgi Djakov <djakov@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] interconnect fixes for 6.13-rc
Message-ID: <2025010237-thinly-multitude-3936@gregkh>
References: <20250102093404.947684-1-djakov@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250102093404.947684-1-djakov@kernel.org>

On Thu, Jan 02, 2025 at 11:34:04AM +0200, Georgi Djakov wrote:
> Hello Greg,
> 
> This pull request contains two fixes for the current cycle. The details
> are in the signed tag as usual. The patches have been in linux-next for
> a few days right before the holidays. Please pull into char-misc-linus
> when possible.
> 
> Thanks,
> Georgi
> 
> 
> The following changes since commit 40384c840ea1944d7c5a392e8975ed088ecf0b37:
> 
>   Linux 6.13-rc1 (2024-12-01 14:28:56 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git tags/icc-6.13-rc6

Pulled and pushed out, thanks

greg k-h

