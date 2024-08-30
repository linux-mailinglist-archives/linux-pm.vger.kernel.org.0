Return-Path: <linux-pm+bounces-13223-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1126B965F58
	for <lists+linux-pm@lfdr.de>; Fri, 30 Aug 2024 12:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43D3E1C22330
	for <lists+linux-pm@lfdr.de>; Fri, 30 Aug 2024 10:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC20175D4E;
	Fri, 30 Aug 2024 10:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xw93+ttS"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C249015C147;
	Fri, 30 Aug 2024 10:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725014162; cv=none; b=rdEZ3lVFnYzGUooUJeygVzs8WuJbctFx+QNkB2fDm1vnMCb9ql625G1KYvXN4aZxRuQTKisOHvO0Eh2z5lgHqdft6p7gO8keAI00kZblKEb7WEUGRmdF2Mm6E5ALmqdGDgmX1LoFIXQ23vWacGRGfjdXWsz1MDo8Juw+wUYbqkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725014162; c=relaxed/simple;
	bh=/1qHgvh8lwhrV0MkTfCTb/ns8Yv2zQi2oDX8Nmhr2Dc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jpQqiavkBX/+SK2CnrFwmaoVp2aInx7lBHOGeRB6rfAKatfjnagXx2bJ5jS732jgQWorXHqqYva793bdcDPDUCYT8+byTjow+ruybr6JUI23UXzT1gUyyISZoew9H2gI+ACo/A+hbXj/zpb/wyb9ra6ve+K5QcAErEPl8DTHzmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xw93+ttS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0E8BC4CEC2;
	Fri, 30 Aug 2024 10:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725014162;
	bh=/1qHgvh8lwhrV0MkTfCTb/ns8Yv2zQi2oDX8Nmhr2Dc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xw93+ttSnVCZa+2A0v5skhHZ71hew76eQmVhMwggOyg6eUdkfJIURtbHKb95huT/Z
	 WuZrg5Vo3DJo8JisM1C74+yqBgFc2YPjcngI28o/8zm+pKS1YeQmTGEc+0dd83O4Vq
	 5oe1Zs4EQ5ZLI5ubVI+CFU0DjA1vkmQEYBDDfFuk=
Date: Fri, 30 Aug 2024 12:35:59 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Yibin Ding <Yibin.Ding@unisoc.com>
Cc: djakov@kernel.org, rafael@kernel.org, yibin.ding01@gmail.com,
	niuzhiguo84@gmail.com, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Hao_hao.Wang@unisoc.com,
	Ke.Wang@unisoc.com
Subject: Re: [PATCH 2/2] debugfs: Fix crash problem caused by accessing
 uninitialized nodes
Message-ID: <2024083023-unblended-poise-ab28@gregkh>
References: <20240830102314.409307-1-Yibin.Ding@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830102314.409307-1-Yibin.Ding@unisoc.com>

On Fri, Aug 30, 2024 at 06:23:14PM +0800, Yibin Ding wrote:
> From: Yibin Ding <Yibin.ding@unisoc.com>
> 
> For uninitialized nodes such as
> /sys/kernel/debug/interconnect/test_client/dst_node, if the cat operation
> is performed directly without writing content to the node, it will cause
> a crash due to accessing a null pointer. So it is necessary to add a null
> pointer check in the debugfs_read_file_str() function.
> 
> Signed-off-by: Yibin Ding <Yibin.ding@unisoc.com>
> ---
>  fs/debugfs/file.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
> index c6f4a9a98b85..8bbe7df6dfd1 100644
> --- a/fs/debugfs/file.c
> +++ b/fs/debugfs/file.c
> @@ -970,6 +970,10 @@ ssize_t debugfs_read_file_str(struct file *file, char __user *user_buf,
>  		return ret;
>  
>  	str = *(char **)file->private_data;
> +	if (!str) {
> +		debugfs_file_put(dentry);
> +		return -EINVAL;
> +	}

How can private_data be NULL now with patch 1 in this series?  I guess
the allocation could fail, but really, how can it?

thanks,

greg k-h

