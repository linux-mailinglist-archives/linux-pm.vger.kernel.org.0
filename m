Return-Path: <linux-pm+bounces-18315-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A14FC9DFAA8
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 07:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10A9BB216EF
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 06:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7BDA1E25FC;
	Mon,  2 Dec 2024 06:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FJ/tMWFI"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8662C33F6;
	Mon,  2 Dec 2024 06:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733120509; cv=none; b=t6/K4LbTm49ECXpzDzeZ0fP38O5G9t/1NYRa78l7FlWNvWzSZ3Ai9DXN+udnRFv5T6LMoK7FF7hIzvu7gJ7jYzsy1oud02aY4gTfn0agF2lr/b7ez93Hr00Jb6KDielq3dGK1sfu2ZlAgWP5VwsJZHb529sWYnp9BwiNZZJw5Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733120509; c=relaxed/simple;
	bh=JGezjuwwFGzX9lUeZQzT2kiu3Pg7zGUe5QL9nrx2+Qo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oaN7CJUe/QsJtsWkv5ce1D6ACm167wULY7Vw1Zw6xgwodOmr/ab2sHnpFpKHraGpwmJ4tuEIzeke/lafjw+y1auqcDWdjh44RDcWiYjfv3pW90BQaXFtO6omzIIOdAmJEFWLC8F1Jj77ueZoMM8v7gj3Q0TNpw7G9XwVuF8Zb8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FJ/tMWFI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C862C4CED2;
	Mon,  2 Dec 2024 06:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733120509;
	bh=JGezjuwwFGzX9lUeZQzT2kiu3Pg7zGUe5QL9nrx2+Qo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FJ/tMWFIrXfncTUlqTtk/koDx3Z2tov+flweSCYKslVMizwDfmWivUBrbrmF9VviW
	 ORThfc+NDt71N5vjdXzJRxPRP7TsPnNpoI1eNq3GVIg+lTJoySrmTGnjZHD/kRJ4I0
	 F9THiBttONhnVJ+Bu9oDKGRX2iR5oZ7rzd56iWM8=
Date: Mon, 2 Dec 2024 07:21:45 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: xueqin Luo <luoxueqin@kylinos.cn>
Cc: rafael@kernel.org, pavel@ucw.cz, len.brown@intel.com,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] drivers: base: power: Optimize array
 out-of-bounds access logic
Message-ID: <2024120206-gigolo-parish-2be3@gregkh>
References: <20241202032306.24671-1-luoxueqin@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202032306.24671-1-luoxueqin@kylinos.cn>

On Mon, Dec 02, 2024 at 11:23:06AM +0800, xueqin Luo wrote:
> The code previously used snprintf to format a string into a buffer and
> manually checked for potential buffer overflows by comparing the returned
> length with the buffer size. This approach introduced unnecessary
> complexity and was prone to subtle errors.

What errors are in the original code here?  Is it incorrect?

> Replaced snprintf with scnprintf, which directly returns the actual number
> of characters written to the buffer (excluding the null terminator). This
> change eliminates the need for manual overflow checks and simplifies the
> buffer offset and size adjustment logic.

Your lines should be wrapped at 72 columns, right?

> 
> Signed-off-by: xueqin Luo <luoxueqin@kylinos.cn>

Why is this a resend?  What was wrong with the first version?

> ---
>  drivers/base/power/trace.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/base/power/trace.c b/drivers/base/power/trace.c
> index cd6e559648b2..d8da7195bb00 100644
> --- a/drivers/base/power/trace.c
> +++ b/drivers/base/power/trace.c
> @@ -238,10 +238,8 @@ int show_trace_dev_match(char *buf, size_t size)
>  		unsigned int hash = hash_string(DEVSEED, dev_name(dev),
>  						DEVHASH);
>  		if (hash == value) {
> -			int len = snprintf(buf, size, "%s\n",
> +			int len = scnprintf(buf, size, "%s\n",
>  					    dev_driver_string(dev));
> -			if (len > size)
> -				len = size;

How was this tested?  I think if code could just be cleaned up
automatically like this, it would have already, right?

thanks,

greg k-h

