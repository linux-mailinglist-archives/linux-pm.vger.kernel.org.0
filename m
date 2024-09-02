Return-Path: <linux-pm+bounces-13316-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6326C967F28
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2024 08:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 933BF1C218F9
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2024 06:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1BA114F9FE;
	Mon,  2 Sep 2024 06:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="i9dEJpww"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA3576048;
	Mon,  2 Sep 2024 06:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725257409; cv=none; b=NsZUSgV+ohwXdu2XGAADSjLgUQpj3f8IPwD7+ovRmOg7iQy5sW02uutEXRYcuPelofbfzF7p5dKiVo8nuXikBCK1sl4fnpdjI8URwYOIYMpwFnuCF1AbnaPGJiYsQ112C0LyvKHz9ieHrlwEu7LO8lb0SI5ww8CYPVhL73bHnLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725257409; c=relaxed/simple;
	bh=teyeAxz7phKRIExdKB5gUuUw0a7C5G4sEHDPBCfzvDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KvbnD+PfwRhJvxbBqeunKYYQVAGI/Dv8+fmaDsYn4+W0JDQPKkEJ6sF+ti0kNQyH39MkQ0dVJhTO7jcHSM29JSe5RUloj3qQ4k2kNyAFY0QY5KUCuAnJQ43UKXG0GkILcoOulncaJzFctP+3qjRipS5v2VyifQ8x3hyNM2NSlic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=i9dEJpww; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B09DC4CEC2;
	Mon,  2 Sep 2024 06:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725257409;
	bh=teyeAxz7phKRIExdKB5gUuUw0a7C5G4sEHDPBCfzvDA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i9dEJpwwdaCp792sJx7BvzHofOta0k2EP9Jwg19QnRcNrVQsAjLyCv17CP/sARuGM
	 y9reaQijzlrky42k+JRdQavgywfhfnWljeZ1kb3amf8pPZQJiq+ndeYo/tF4Jj3pLm
	 guB704LGZywcrPp96nimLSr6UoeXZc6hfby2e/wY=
Date: Mon, 2 Sep 2024 08:10:05 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: yi'bin ding <yibin.ding01@gmail.com>
Cc: Yibin Ding <Yibin.Ding@unisoc.com>, djakov@kernel.org,
	rafael@kernel.org, niuzhiguo84@gmail.com, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Hao_hao.Wang@unisoc.com,
	Ke.Wang@unisoc.com
Subject: Re: [PATCH 1/2] interconnect: Add character pointer initialization
Message-ID: <2024090244-showpiece-backboned-4aa5@gregkh>
References: <20240830102244.409058-1-Yibin.Ding@unisoc.com>
 <2024083004-laptop-outrank-9710@gregkh>
 <CAC6ZDY_V1w92gg=ZugbHhWfBJpVqNpuTdgvURk0WYVnzqMKkjA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAC6ZDY_V1w92gg=ZugbHhWfBJpVqNpuTdgvURk0WYVnzqMKkjA@mail.gmail.com>

A: http://en.wikipedia.org/wiki/Top_post
Q: Were do I find info about this thing called top-posting?
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top

On Mon, Sep 02, 2024 at 11:03:29AM +0800, yi'bin ding wrote:
> Thanks in advance，
> 
> Why is this needed?  Why not just use the size of the structure?
> 
> answer:Because the memory allocated here is not actually used, it is just
> to prevent the occurrence of null pointer.In order to prevent memory waste,
> I applied for a small amount of memory as possible. If necessary, I can
> submit another revision to change it to the size of the structure or just
> to "1" without the macro definition.

Make it correct please.

> What commit id does this fix?
> 
> answer:commit id：770c69f037c18cfaa37c3d6c6ef8bd257635513f （interconnect:
> Add debugfs test client）
> This commit creates some debugfs nodes, where the src_node and dst_node
> character pointers are not initialized. This will result in accessing null
> pointers when accessing them directly.

Please put the proper Fixes: tag in the changelog text then.

> And where are you freeing this memory you just allocated?
> 
> answer:The memory allocated here will be released when data is written to
> the node. The write operation will call debugfs_write_file_str() function,
> in which a new piece of memory will be allocated to save the new data, and
> then the old memory will be released.

That happens if you write to the file, but what happens if you never
write to the file?  What happens when you remove the driver/module,
shouldn't you free the memory then as well?

thanks,

greg k-h

