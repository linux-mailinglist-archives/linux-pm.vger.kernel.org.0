Return-Path: <linux-pm+bounces-13222-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 548A4965F56
	for <lists+linux-pm@lfdr.de>; Fri, 30 Aug 2024 12:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 265551C20E35
	for <lists+linux-pm@lfdr.de>; Fri, 30 Aug 2024 10:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C6616D9A7;
	Fri, 30 Aug 2024 10:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="p7NbsIxX"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0420615C147;
	Fri, 30 Aug 2024 10:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725014115; cv=none; b=q2o3Qg9JEn9BMFXHljxq9IVfceRjSZ0lvF24/6SVglEuYBFt1a8F0Vl1Sbh/TNjO6s7Da+jetNygnUnFqiqt5VEWIJo5XlCchhHuSgYNHHipW5Y7JHR4N6M319Vi1FYCoFF1Tv+w4gZ8a56GGe2eTN7LOFmiz+LDsMlUVGvRULE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725014115; c=relaxed/simple;
	bh=Oy+ISfTJkxCO6jDPyB1J50o/rsLnGwqNoDBhSvC32lA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hmaWCHepDZCQGH2gGZzeOZSDXoAblLPdIWCPT3ZupNOtX9UZkPHRE061DepbS+Nul/tlHv+rtzdA2ApuJid9UDHUulccT0fx1As72NHZZ2AyJuEtwNrN+Jnr1N7e+bTg6KZ3+i9Ux3h1Jt5/8rsgtHE+McDH4gahF5uh9KBsL88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=p7NbsIxX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A72EC4CEC2;
	Fri, 30 Aug 2024 10:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725014114;
	bh=Oy+ISfTJkxCO6jDPyB1J50o/rsLnGwqNoDBhSvC32lA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p7NbsIxXa5DFzhZrSFAOtsfYD853a0OPyKfbDwyaSRqCenTwJG4qXqpIDe6K9g8KT
	 byUojuDhYxw7dBuFWU92j7OMAQDM1NhGb/R6P0dMv+QT8aCfbjIWTQcx6dqy5kT540
	 2tsQmgyB86+3DGgr843M8lZzhFVokGg4SkO9KY9Q=
Date: Fri, 30 Aug 2024 12:35:11 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Yibin Ding <Yibin.Ding@unisoc.com>
Cc: djakov@kernel.org, rafael@kernel.org, yibin.ding01@gmail.com,
	niuzhiguo84@gmail.com, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Hao_hao.Wang@unisoc.com,
	Ke.Wang@unisoc.com
Subject: Re: [PATCH 1/2] interconnect: Add character pointer initialization
Message-ID: <2024083004-laptop-outrank-9710@gregkh>
References: <20240830102244.409058-1-Yibin.Ding@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830102244.409058-1-Yibin.Ding@unisoc.com>

On Fri, Aug 30, 2024 at 06:22:44PM +0800, Yibin Ding wrote:
> From: Yibin Ding <Yibin.ding@unisoc.com>
> 
> When accessing a node whose data type is a character pointer and has not
> been initialized, a crash will occur due to accessing a null pointer. So
> it is necessary to add the operation of initializing the character pointer.
> Since the debugfs_write_file_str() function performs a kfree() operation
> on the node data, memory is allocated to the node pointer during
> initialization will be released when data is written to the node.
> 
> Signed-off-by: Yibin Ding <Yibin.ding@unisoc.com>
> ---
>  drivers/interconnect/debugfs-client.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/interconnect/debugfs-client.c b/drivers/interconnect/debugfs-client.c
> index bc3fd8a7b9eb..d62ba56b7bbe 100644
> --- a/drivers/interconnect/debugfs-client.c
> +++ b/drivers/interconnect/debugfs-client.c
> @@ -16,6 +16,7 @@
>  #undef INTERCONNECT_ALLOW_WRITE_DEBUGFS
>  
>  #if defined(INTERCONNECT_ALLOW_WRITE_DEBUGFS) && defined(CONFIG_DEBUG_FS)
> +#define INITNODE_SIZE 1

Why is this needed?  Why not just use the size of the structure?

>  
>  static LIST_HEAD(debugfs_paths);
>  static DEFINE_MUTEX(debugfs_lock);
> @@ -147,8 +148,13 @@ int icc_debugfs_client_init(struct dentry *icc_dir)
>  
>  	client_dir = debugfs_create_dir("test_client", icc_dir);
>  
> -	debugfs_create_str("src_node", 0600, client_dir, &src_node);
> -	debugfs_create_str("dst_node", 0600, client_dir, &dst_node);
> +	src_node = kzalloc(INITNODE_SIZE, GFP_KERNEL);
> +	dst_node = kzalloc(INITNODE_SIZE, GFP_KERNEL);

Wow, how did this ever work at all?

What commit id does this fix?

And where are you freeing this memory you just allocated?

thanks,

greg k-h

