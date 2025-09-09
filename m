Return-Path: <linux-pm+bounces-34285-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB155B50279
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 18:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA49E360E13
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 16:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401D5350D77;
	Tue,  9 Sep 2025 16:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="u6IrV4w2"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCE73451BF;
	Tue,  9 Sep 2025 16:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757435113; cv=none; b=jUPCXULaWqxMoHAimjyg9SZpNkgFH+OEMtM7050w4osFb2DP0kaBioIyEGIUCKh1IqJdcjC0ntwBKPF8ZEcXvID8MWf9zK2OOQE7Z3VJZ32N5ZJWvKhmr9ayzsgx4hebDXAhuPkT7FEG6HpZs9T/NOiXqid1Pku1CE8U88OnL1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757435113; c=relaxed/simple;
	bh=yLKqdTtK6qqHxJHthspIZS95kNGp5ZeXCY4av6UkJGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dfgZ8u50z76Y+Mwy0SdbIx5k/frYDf1G/GE6peESMOQAVyE11zR3pE8eNMyfyz79MMqDlQcV4BUDg4KOuxdGRcGG1Rw+7JtpyFvBPju/dedVMoXFoyjzQNdSs2TEM6ZexJTdItHMnD4Y9HTudOveI/fiS0ymS/nUlnftqP94mkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=u6IrV4w2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC429C4CEF4;
	Tue,  9 Sep 2025 16:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757435112;
	bh=yLKqdTtK6qqHxJHthspIZS95kNGp5ZeXCY4av6UkJGw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u6IrV4w2HvC4I+bLToQa4k6FaS2nbB+VmNncKHbQfl5WZmUZoLUKeOKgEs1aTN4bT
	 PcyY+mox4pxAA7r1IkBf0/e4hptRmJ2kO1oUXBtjJJc4jPNkql8VUquUWyzBVlwg39
	 dvKs3SdIf4/fLeGRsJwFHY9Q2XP6MgtPi28a/RTc=
Date: Tue, 9 Sep 2025 18:25:09 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ryan Zhou <ryanzhou54@gmail.com>
Cc: stern@rowland.harvard.edu, Thinh.Nguyen@synopsys.com,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-usb@vger.kernel.org, rafael@kernel.org, royluo@google.com
Subject: Re: [PATCH v2] drvier: usb: dwc3: Fix runtime PM trying to activate
 child device xxx.dwc3 but parent is not active
Message-ID: <2025090959-italicize-silly-f628@gregkh>
References: <385dccf3-234a-4f83-9610-81ac30bf1466@rowland.harvard.edu>
 <20250909161901.10733-1-ryanzhou54@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909161901.10733-1-ryanzhou54@gmail.com>

On Wed, Sep 10, 2025 at 12:19:01AM +0800, Ryan Zhou wrote:
> Issue description:During the wake-up sequence, if the system invokes
>  dwc3->resume and detects that the parent device of dwc3 is in a
> runtime suspend state, the system will generate an error: runtime PM
> trying to activate child device xxx.dwc3 but parent is not active.
> 
> Solution:At the dwc3->resume entry point, if the dwc3 controller
> is detected in a suspended state, the function shall return
> immediately without executing any further operations.
> 
> Signed-off-by: Ryan Zhou <ryanzhou54@gmail.com>
> ---
>  drivers/usb/dwc3/core.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 370fc524a468..06a6f8a67129 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -2687,6 +2687,9 @@ int dwc3_pm_resume(struct dwc3 *dwc)
>  	struct device *dev = dwc->dev;
>  	int		ret = 0;
>  
> +	if (pm_runtime_suspended(dev))
> +		return ret;
> +
>  	pinctrl_pm_select_default_state(dev);
>  
>  	pm_runtime_disable(dev);
> -- 
> 2.25.1
> 
> 

What commit id does this fi?

thanks,

greg k-h

