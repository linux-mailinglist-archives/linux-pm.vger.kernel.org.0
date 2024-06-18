Return-Path: <linux-pm+bounces-9427-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3895990CAD6
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 14:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37276B24704
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 11:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EBA1143865;
	Tue, 18 Jun 2024 11:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DBQRklkh"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5F513AD0A;
	Tue, 18 Jun 2024 11:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718708429; cv=none; b=dHJF9uXeL69za1lKp3frXAAaSjE3qZRzd2YEdF9pI3NEu6QzRE4osmJnFQdNs4Rxl9MWAF9lRBw3KkooQNNgtyROZ/j9XDzaX22lGEWdQ8t3rmtnNvcbetX05v93EB9di8rhZsP7jDB2rSKbDN09uUI67VUxWl4tPDt0tsHVbCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718708429; c=relaxed/simple;
	bh=OlrEDjb8Rw5lmOSzwM2ITWdrVaxm+tF1mLhCMzWx26Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jqt/ivM9w/zUXyOe3JxY56k8rt0CA50E1Wwoa0pjuDrHKXwoIv5GGq/Bjj51NGzSmxSFojUd/SXPiECBIS9yNY3lzR7DblCRSLVErbix1lKVw+tgrc5C1HFoN+6plixlA49ldNkS9SZfcqeIEsvOfesVthTYnRERBIUzEE8vj8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DBQRklkh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 497DEC3277B;
	Tue, 18 Jun 2024 11:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718708428;
	bh=OlrEDjb8Rw5lmOSzwM2ITWdrVaxm+tF1mLhCMzWx26Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DBQRklkhBaaL0aEAZI3KusmVtqCEdQuchktLHjlyzQl89PPqkOWHpj6FiHTPaVZ1t
	 CN1bS+EzfG2FKlr03ukIo/bvLDEucMbaaCVPqirGNrfgXIJlg4Y8HOcd3Mw70Xuucu
	 n5HZxqeKr7l96C5Fv6gFRFpEImSnF0tSYZVD4gc4=
Date: Tue, 18 Jun 2024 13:00:25 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Kaiyen Chang <kaiyen.chang@intel.com>
Cc: rafael@kernel.org, pavel@ucw.cz, len.brown@intel.com,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] PM: Start asynchronous suspend threads upfront
Message-ID: <2024061801-epilogue-hacker-0494@gregkh>
References: <20240618093507.2143-1-kaiyen.chang@intel.com>
 <20240618093507.2143-2-kaiyen.chang@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618093507.2143-2-kaiyen.chang@intel.com>

On Tue, Jun 18, 2024 at 05:35:07PM +0800, Kaiyen Chang wrote:
> Currently, when performing a suspend operation, all devices on the
> dpm_list must wait for preceding "synchronous" devices to complete
> before the main suspend thread can start their suspend routines,
> even if they are "asynchronous". If the suspend routine of a
> synchronous device must enter a waiting state for some reason, it
> will cause the main suspend thread to wait as well, thereby
> delaying the processing of all subsequent devices, including
> asynchronous ones, thus ultimately extending the overall device
> suspend time.
> 
> By starting the asynchronous suspend threads of asynchronous
> devices upfront we effectively move those devices towards the
> beginning of dpm_list, without breaking their ordering with respect
> to their parents and children. As a result, even if the main
> suspend thread enters a waiting state, these asynchronous threads
> can continue to run without delay.
> 
> Signed-off-by: Kaiyen Chang <kaiyen.chang@intel.com>
> ---
>  drivers/base/power/main.c | 90 +++++++++++++++++++++++++--------------
>  1 file changed, 57 insertions(+), 33 deletions(-)

Sorry, but please follow the Intel-documented rules for how to submit
kernel patches before sending them out to the community.

thanks,

greg k-h

