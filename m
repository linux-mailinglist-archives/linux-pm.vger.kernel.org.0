Return-Path: <linux-pm+bounces-13810-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB99196F9D3
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2024 19:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7E741C21FC8
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2024 17:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC0C1D31B8;
	Fri,  6 Sep 2024 17:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RrQfNdxa"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B659654648;
	Fri,  6 Sep 2024 17:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725643111; cv=none; b=Pi3ekTB8T2nq2rtGnYCtaJS3o/OGM6pTYlBqkmsEk5ykRFXCGXbTxDuZNX1mqJReCJRwrE2qXTxz1U+N5Khhf0HZUATimYyX7Yvyg2ixNvoWqTTxvY+EFK/BOvivfe0szimLC2EX2J04+aUvqk8PjwQkIwN2lKmwajOr953Z+Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725643111; c=relaxed/simple;
	bh=OZNnoRdaf7h1Dxq114U3uVF35D0eWKo4fFrez304l+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uWksCkDwPZ7JuOivwLZCGk9IC84/Or7JUiInrKSxVathRYGXzv/bhRmqJOwvK02y8HenqdODCDwmzweXXIxTebwh0CvMi2kA2BVaMr83/c8suryOGV27J/1d14mxXpXGarhsi02RVsWAAKWIL61dbDUti9x8jeiOoqo9SjBk7CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RrQfNdxa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5A4AC4CEC7;
	Fri,  6 Sep 2024 17:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725643111;
	bh=OZNnoRdaf7h1Dxq114U3uVF35D0eWKo4fFrez304l+k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RrQfNdxaU0N0oWplH8tbdvI703SUMYM8wo8/3b0jlNDLgtH/uvrxcbjxbtQKBUZSx
	 +WRIa6JF/85swk1raLKCAtNVNUwPSNnF9SM3Umz3nzGxP14UZ0eV2GxEEXqUItJHOc
	 IhoU4eJldNHcxYXvOnz4HltyY+WcsgATd45jvXOk=
Date: Fri, 6 Sep 2024 19:17:48 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Georgi Djakov <djakov@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] interconnect changes for 6.12
Message-ID: <2024090637-henna-labored-c0f0@gregkh>
References: <20240906155227.310250-1-djakov@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240906155227.310250-1-djakov@kernel.org>

On Fri, Sep 06, 2024 at 06:52:27PM +0300, Georgi Djakov wrote:
> Hello Greg,
> 
> This is the pull request with interconnect changes for the v6.12-rc1 merge
> window. It contains some new drivers, fixes and clean-ups. As always, the
> summary is in the signed tag.
> 
> All patches have been in linux-next for almost two weeks. There are no
> reported issues. Please pull into char-misc-next when you get a chance.
> 
> Thanks,
> Georgi
> 
> The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f017b:
> 
>   Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git tags/icc-6.12-rc1

Pulled and pushed out, thanks.

greg k-h

