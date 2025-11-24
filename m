Return-Path: <linux-pm+bounces-38481-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D12CCC819C9
	for <lists+linux-pm@lfdr.de>; Mon, 24 Nov 2025 17:37:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7F5F7341E09
	for <lists+linux-pm@lfdr.de>; Mon, 24 Nov 2025 16:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8909429A9FE;
	Mon, 24 Nov 2025 16:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dM7i6Bjz"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594AF1EDA02;
	Mon, 24 Nov 2025 16:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764002253; cv=none; b=FIq7uw9UMPapkcq8H3KnOm6y0kn4qhX4pJUi+rMeADLIUU8UbSIo+ZeIzoj8x9lTJ3Yz8lMOl9OnQ9E4efFUB+s30wKfM1T58G/kdH0xWasYLks0CpUdEY2yNFvLQUGnZ6VfGeuHlgzRGDsqkV7cS/UI1C42q6WFUiyH+ouuHz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764002253; c=relaxed/simple;
	bh=lRZVBEv7xRLD87NdGqjlx9sHa1KleXZAvso/8dwbhFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JPcmrRnb5+hjuCKAWtDWsTCKcwDsTvRFk4g9jzYb+NJP7+sgd9YsgLdTSN1jLzGOwAaI6O/vCCKZ4EmNx49qQcEMvf4P1jqCupb+4o2k9YS8fF2gBRiSwc8swwPP2nh+atr8z6iJIQG3bFAG9ZZV1vIrVQzhCyFu2xoQ2SlJGMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dM7i6Bjz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C04DC4CEF1;
	Mon, 24 Nov 2025 16:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764002251;
	bh=lRZVBEv7xRLD87NdGqjlx9sHa1KleXZAvso/8dwbhFM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dM7i6BjzbcfUspW1wCIJ7VwE6K8/SWbncBn5UQ5Yn9CEOJ3u0+Lvx8OlxWNPsybfV
	 KvNbftuXgJsongLJvPWn85SrkJtSZn1F8iHt8CaEEtyM2XorlGzU2iruNncNvSYE0M
	 2n+UNTRuXOa9NYyu0qpYO/q3AxZjkr3q3q2BwZ4o=
Date: Mon, 24 Nov 2025 17:36:05 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Georgi Djakov <djakov@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] interconnect changes for 6.19
Message-ID: <2025112457-occultist-glorify-10c7@gregkh>
References: <20251124153332.2754651-1-djakov@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251124153332.2754651-1-djakov@kernel.org>

On Mon, Nov 24, 2025 at 05:33:32PM +0200, Georgi Djakov wrote:
> Hello Greg,
> 
> This is the pull request with interconnect changes for the v6.19-rc1 merge
> window. As always, the summary is in the signed tag.
> 
> All patches have been in linux-next for a while. There are currently
> no reported issues. Please pull into char-misc-next when possible.
> 
> Thanks,
> Georgi
> 
> 
> The following changes since commit 3a8660878839faadb4f1a6dd72c3179c1df56787:
> 
>   Linux 6.18-rc1 (2025-10-12 13:42:36 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git tags/icc-6.19-rc1

Pulled and pushed out, thanks.

greg k-h

