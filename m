Return-Path: <linux-pm+bounces-40998-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 12785D315D5
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jan 2026 13:54:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8CCEF300CB41
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jan 2026 12:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950E6228CA9;
	Fri, 16 Jan 2026 12:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ia3ItKgZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623AC2253AB;
	Fri, 16 Jan 2026 12:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768568065; cv=none; b=ut07adHXQas4nBjvgd//Rdy6ISeKvTOAJushOAvbgARriy6g8z66gYZYPBbWnzqZ1+w74HYyoie61f4CChifw/v0RPElFCa+IDgUzt9SBlELV57sgNmcdHXerdGk8NHyvJuddcDLU4kytnx/lhjC9FtzEaoApsDxiwHq+3nz2cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768568065; c=relaxed/simple;
	bh=HTWkzyAzvDK4WmkizPMnl6ATERP6l2OZwj6UOKICvUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AK/SeL6byIs1kfKC0VHru3smw4/MFElQY+Ob5MNFKjXJzuG0+NS9R8CBy52sLozFfkpYeYGAIBozRa9dZSBmctultzQODfjZf19WEnyru1cLKvsRIQ35yrRSupb7KjXduOgW0aGMgYSaUWuTUKJ58YQiEF68t+xkzyogtLGR8+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ia3ItKgZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A13EAC116C6;
	Fri, 16 Jan 2026 12:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768568065;
	bh=HTWkzyAzvDK4WmkizPMnl6ATERP6l2OZwj6UOKICvUM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ia3ItKgZ824K/kDGTi586EzY0LTIhXnYru+Xij3TsTHjJOtdotx9J9t+t3r8uN/FE
	 UvzbXx7RiJqaqh2SF7XOJ/vVh1Kjt6zZ/tSu8RDL7I4RKz6dMJqFBM/XpfsnDwe27n
	 dxIhxhFM5lLVMjeYkoV8iBS9o0vmcTeswWxhchkA=
Date: Fri, 16 Jan 2026 13:54:15 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Georgi Djakov <djakov@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] interconnect fixes for 6.19-rc
Message-ID: <2026011608-traitor-slashed-fec1@gregkh>
References: <20260115140728.494253-1-djakov@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260115140728.494253-1-djakov@kernel.org>

On Thu, Jan 15, 2026 at 04:07:28PM +0200, Georgi Djakov wrote:
> Hello Greg,
> 
> This pull request contains a couple of small fixes for v6.19. They are
> listed in the signed tag. All have been in linux-next for a few days.
> Please pull them into char-misc-linus when you get a chance.
> 
> Thanks,
> Georgi
> 
> The following changes since commit 8f0b4cce4481fb22653697cced8d0d04027cb1e8:
> 
>   Linux 6.19-rc1 (2025-12-14 16:05:07 +1200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git tags/icc-6.19-rc6

Pulled and pushed out, thanks.

greg k-h

