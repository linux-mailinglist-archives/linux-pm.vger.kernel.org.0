Return-Path: <linux-pm+bounces-20541-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 286C8A13A5D
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 14:03:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A35B03A03C3
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 13:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40CA1DE8B3;
	Thu, 16 Jan 2025 13:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vTvJR+I6"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720061DE899;
	Thu, 16 Jan 2025 13:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737032624; cv=none; b=r19Im1zL4nMxTggftGV6avFlI0vutvVOpCLpHKEwYsBl2yNdsiv1RAWihRhbxQW3z3TDvXwKAaCGsmxGRQfJ748YOT75MStxssU0A5T61E8CX7zQ3JE6mu0q9Or3/OzGNhVAIXoQK98CzuljkPbGbYiH+Oco/URXmHCFtL2rTuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737032624; c=relaxed/simple;
	bh=wtFFTOxOJqP6lQck9n+YU6XB1H06KpsXHkvD+kNuyTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K3ne/pTHy1JBSh7hbSR7JmAT2uAza0vY2sEMlFSvbnThNXvr73Zr4uUxDpsZbMIYiu7B1aUjKCgqOewzZ5jroAHX7LcQQehzybdLXZjASkf3DmwLMpyRMTGcxbmK122hS8vG3+T3IZ0aE49rsKA0RcTbjbKAG+APpR7ESAPvMhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vTvJR+I6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FB2AC4CEDD;
	Thu, 16 Jan 2025 13:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1737032624;
	bh=wtFFTOxOJqP6lQck9n+YU6XB1H06KpsXHkvD+kNuyTw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vTvJR+I6/wNsrqBU2c/PCfQ69pDj4Bukk/ume7bOtsvVvkN2YkZ+Jfw+IKTjtCwPO
	 TxQfNP6tQaSLjMIQPoGThZatMNBuuMz2/mMaD+sp52CgAyByPL7paER1cGKdGXSjEy
	 o5S+Jv+Al+p28cIXyZte8TgiY64hc0pESOBfcyzE=
Date: Thu, 16 Jan 2025 14:03:41 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Georgi Djakov <djakov@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] interconnect changes for 6.14
Message-ID: <2025011630-wildfowl-caress-ebe7@gregkh>
References: <20250116124230.635223-1-djakov@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250116124230.635223-1-djakov@kernel.org>

On Thu, Jan 16, 2025 at 02:42:30PM +0200, Georgi Djakov wrote:
> Hello Greg,
> 
> This is the pull request with interconnect changes for the v6.14-rc1 merge
> window. It contains a new driver and tiny DT binding updates. As always,
> the summary is in the signed tag.
> 
> All patches have been in linux-next for a while. There are no reported
> issues. Please pull into char-misc-next when possible.
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
>   git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git tags/icc-6.14-rc1
> 

Pulled and pushed out, thanks.

greg k-h

