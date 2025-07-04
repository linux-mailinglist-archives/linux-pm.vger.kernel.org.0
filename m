Return-Path: <linux-pm+bounces-30141-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B0F2AF9592
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jul 2025 16:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1ABCB1CA5AA9
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jul 2025 14:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5FE1BCA07;
	Fri,  4 Jul 2025 14:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="z1PASmnD"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA3B1917E3;
	Fri,  4 Jul 2025 14:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751639546; cv=none; b=LnYhpm0d2h+m9M0tSnINPQSQORhJGuo6exNxjP3iK7SNSPb4wOjWpu8r58dUAoG53s0MJky16uSCfrnqpWIFFAuEikMuXNqg/dKFmYzebusTO5yW4F71YYSOs/6b8vPO2LAAw2EiLpAXkyQmiK8mKS10YtJjFB0xRT2G+OydMPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751639546; c=relaxed/simple;
	bh=JrGza/8sp35LuR2NfsJdTwu2nEHvxBokGAho0qB8l5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BqUyZawU06F3I0Y/X0nDNiiv1M1w7pSP7e5klKIimfawLrm6XOQKT2D2r5Q4cviaSg7eFzo0BFNxBWdAvzeUH3K/rR1mD2382Gc8lfsoYORL1rzzW0owsvypSsZ/YKaPRMmiQl/7NNiberIFnL7+uvecrT2hRzIn2lRQshOAE/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=z1PASmnD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87AD0C4CEE3;
	Fri,  4 Jul 2025 14:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751639546;
	bh=JrGza/8sp35LuR2NfsJdTwu2nEHvxBokGAho0qB8l5Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=z1PASmnDwzA9uVYbcbg04PrASTRhuzOOPG83fBmQPkgFXvFXl6RIfyWEK9IcFvSNI
	 OeGLiSkygW6L7HBssekaS2Q5/k/TYlaykyl25IJuGIC2uewnbUQ3CRBsGIcY4X8IyJ
	 vzYSnUmwedEXBhjFn9FGyCAmdhMSoUY6mOZklFLM=
Date: Fri, 4 Jul 2025 16:32:07 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Georgi Djakov <djakov@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] interconnect fixes for 6.16-rc
Message-ID: <2025070459-primp-snitch-f338@gregkh>
References: <20250703155514.3841629-1-djakov@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703155514.3841629-1-djakov@kernel.org>

On Thu, Jul 03, 2025 at 06:55:14PM +0300, Georgi Djakov wrote:
> Hello Greg,
> 
> This pull request contains fixes for the current cycle. The details are
> in the signed tag as usual. The patches have been in linux-next for a few
> days. Please pull into char-misc-linus when possible.
> 
> Thanks,
> Georgi
> 
> 
> The following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd1354494:
> 
>   Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git tags/icc-6.16-rc5

Pulled an dpushed out, thanks.

greg k-h

