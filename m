Return-Path: <linux-pm+bounces-14284-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E92979135
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2024 15:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FDEA1C21590
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2024 13:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A561CF7BF;
	Sat, 14 Sep 2024 13:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rw3qgZeu"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904891CF7B0;
	Sat, 14 Sep 2024 13:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726322239; cv=none; b=B72Sc4WvMvew/911bila4SjDCXanEfSM2xJrLpqrwekQHmuZwnIVr4KqE6quq2PA9E2VjluTSBgkyiFxiYwCvr40QDfZcpFsqtdIE1PAvxfIOPkDfk/dB0b7BIQ1YbdI8Hj8Eqzgt8hF/9fFejYYau0D+sIgzWrwAg9I/6jCrX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726322239; c=relaxed/simple;
	bh=/SA+Q8ligYDHVrlwyqxED78/YrIfXmZdo5guel73H6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VaJPVeot6pUndg/cER8GzuWDLz3EoAnTGc25Gq2if3TLn03EtxNa5+7bxaGlcvMl2MJQekVo5Z7avKRY3vC0Sh6w4kg50PSOA6BsVVpKLVnGdO4blEyfVVN9MNI/RwoBV24HGnwNAKbFGx9HC2s+MpiQ0D8KCBjoQTRFkvLiD80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rw3qgZeu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB92DC4CEC0;
	Sat, 14 Sep 2024 13:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726322239;
	bh=/SA+Q8ligYDHVrlwyqxED78/YrIfXmZdo5guel73H6s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rw3qgZeuQqy5IHcPwC/uW3Tmziev0WIezswuZ2sM2yQCMLN9WtoVSBcIwEiG8HqgK
	 Zz6jbtM7Qo6xS4rvi35QPOt541DfTvYSRBLY/p1CouF9EgxtvTJ5oU+3KesppxuQvV
	 jmxc1MgbI+tj3ubz5N5/DtkXOoZRRtCuX3waHpvU=
Date: Sat, 14 Sep 2024 15:57:16 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Yibin Ding <Yibin.Ding@unisoc.com>
Cc: djakov@kernel.org, rafael@kernel.org, yibin.ding01@gmail.com,
	niuzhiguo84@gmail.com, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Hao_hao.Wang@unisoc.com,
	Ke.Wang@unisoc.com
Subject: Re: [PATCH V2 0/2] Added debugfs node initialization and null
 pointer detection.
Message-ID: <2024091404-battered-boxlike-c7c1@gregkh>
References: <20240914102418.3879203-1-Yibin.Ding@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240914102418.3879203-1-Yibin.Ding@unisoc.com>

On Sat, Sep 14, 2024 at 06:24:18PM +0800, Yibin Ding wrote:
> From: Yibin Ding <Yibin.ding@unisoc.com>
> 
> The two debugfs nodes (/sys/kernel/debug/interconnect/test_client/dst_node,
> src_node) do not initialize the character pointers before creation. For
> such uninitialized nodes, direct access will cause a crash due to accessing
> a null pointer.
> For example, directly execute the following command after booting:
>     cat /sys/kernel/debug/interconnect/test_client/dst_node.
> 
> Therefore, for the problem nodes, it is necessary to add initialization
> operations and null pointer detection when accessing.
> 
> Yibin Ding (2):
>   interconnect: Add character pointer initialization
>   debugfs: Fix crash problem caused by accessing uninitialized nodes
> 
>  drivers/interconnect/debugfs-client.c | 9 +++++++--
>  fs/debugfs/file.c                     | 4 ++++
>  2 files changed, 11 insertions(+), 2 deletions(-)
> 
> -- 
> 2.25.1
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

