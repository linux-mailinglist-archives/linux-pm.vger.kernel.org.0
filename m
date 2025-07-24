Return-Path: <linux-pm+bounces-31357-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB86B1005C
	for <lists+linux-pm@lfdr.de>; Thu, 24 Jul 2025 08:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 921507AC1FC
	for <lists+linux-pm@lfdr.de>; Thu, 24 Jul 2025 06:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21161EF391;
	Thu, 24 Jul 2025 06:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="B90eUmDQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2ACB2E3710;
	Thu, 24 Jul 2025 06:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753337085; cv=none; b=ddJH2LdqsFXzSz1+bA60RpDn7Zh8WPRoyNQMpA18R/4K4OMOvkAwlNos2XIo10RYaaiWqJFMcD/YVjNQdNn89IolON47HqCzUMgycd+aOUMqNKvfIufT7+xKkkt9SNzCY2E+ywc1eXSmiQ42FoSjANzjB9cJRjo0ZIIA0Lv0qUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753337085; c=relaxed/simple;
	bh=AlDqG1p/UWZSZ1ypenU/Xho9TDi2YZ9jWVg7faxhh3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FZ7GmqxYkJ0sAXzH1zqhp23d0v5om2LTZogKxeUfWqpMngFaz1yx3nOhFC38HEW592zIqB/cIwMcy1tDGsQfvw89OOuFCZW+l/2g/4TMJ8r0pNtxoyB0y6vMcc+UYK3Ib5DGflofznJs738kEX3JgCtl/np7z4M/Vp1xHxUYALE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=B90eUmDQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB057C4CEF1;
	Thu, 24 Jul 2025 06:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753337085;
	bh=AlDqG1p/UWZSZ1ypenU/Xho9TDi2YZ9jWVg7faxhh3g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B90eUmDQozXWEPhLhBgnLVZN/7mL1EqpMK4pjYgMYA4KuvRutxFqAWnuCCnekkvlF
	 nclX1MsYk/VY3fXqjho4gLjo8BQ0HX59V4vWf0f6BsoroY0cHhUkaUmyrhJCCk32zq
	 vDL7sCnNNlxGVqxldlyLLSEr9fnJaINMh8hf+Nfc=
Date: Thu, 24 Jul 2025 08:04:25 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Georgi Djakov <djakov@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] interconnect changes for 6.17
Message-ID: <2025072410-outward-shortage-8eae@gregkh>
References: <20250724055716.1636178-1-djakov@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724055716.1636178-1-djakov@kernel.org>

On Thu, Jul 24, 2025 at 08:57:16AM +0300, Georgi Djakov wrote:
> Hello Greg,
> 
> This is the pull request with interconnect changes for the v6.17-rc1 merge
> window. This time it contains only driver changes. As always, the summary
> is in the signed tag.
> 
> All patches have been in linux-next during the last few days. There are
> currently no reported issues. Please pull into char-misc-next when possible.
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
>   git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git tags/icc-6.17-rc1

Pulled and pushed out, thanks.

greg k-h

