Return-Path: <linux-pm+bounces-934-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A6D80E67D
	for <lists+linux-pm@lfdr.de>; Tue, 12 Dec 2023 09:44:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F6BA1F2207C
	for <lists+linux-pm@lfdr.de>; Tue, 12 Dec 2023 08:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79DC0219E7;
	Tue, 12 Dec 2023 08:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CAfNCedX"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE711B271
	for <linux-pm@vger.kernel.org>; Tue, 12 Dec 2023 08:43:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5AB6C433C8;
	Tue, 12 Dec 2023 08:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702370639;
	bh=+udAdbv74ZH3Ec7v7gNkzkQW186AgEuuT/4lHWXQJa0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CAfNCedXuKTLRzZikctAa8tYeRcWK6eynmGaRAikE32izQQ+ukuhOZQZnA3Cy6fC/
	 krlmBjTF1Map9k4RMbGSTfch58p7I5M9bWZU1BmFkKeIjKRHBY9lm9PqNrkp4ovVW0
	 bl9ZwJtMYghgCMPInSfpZ+nj7bDbc3sKOnzR6a5U=
Date: Tue, 12 Dec 2023 09:43:43 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Georgi Djakov <djakov@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] interconnect fixes for 6.7-rc
Message-ID: <2023121235-amplifier-percolate-f23c@gregkh>
References: <20231209101548.1240700-1-djakov@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231209101548.1240700-1-djakov@kernel.org>

On Sat, Dec 09, 2023 at 12:15:48PM +0200, Georgi Djakov wrote:
> Hello Greg,
> 
> This pull request contains a few tiny fixes for the current cycle. The
> details are in the signed tag. All patches have been in linux-next
> during the last few days. Please pull into char-misc-linus when possible.
> 
> Thanks,
> Georgi
> 
> 
> The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:
> 
>   Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git tags/icc-6.7-rc5

Pulled and pushed out, thanks.

greg k-h

