Return-Path: <linux-pm+bounces-36379-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D64B7BEC95A
	for <lists+linux-pm@lfdr.de>; Sat, 18 Oct 2025 09:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6751219C77F3
	for <lists+linux-pm@lfdr.de>; Sat, 18 Oct 2025 07:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB44286426;
	Sat, 18 Oct 2025 07:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CvcJ3Rey"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B6D7082A;
	Sat, 18 Oct 2025 07:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760772539; cv=none; b=nfFOZ1CWhW1KR0fmZ00r+N78e9SPyiZ0+qaqdgLgFczAHVdXW09OlZSZdjAej5yA/Il2YZPqRphE4PlC7TlYA28qVvWREhy/IFP3VLarVb+NtBvB2XaBXzQt9RKrb/Pw29IMpeccWX8Xuqe9Pr4mao23cZxx54hpLmQo4/upHoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760772539; c=relaxed/simple;
	bh=vNWHIejyNgeAjj/yP4OEU+1cL7lMtWgCcdaXyxFMFWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MtQUwpIw7+SNGwz8iE46TTCNdFTYZrwcEB64s8YLjxFSRFIxqmTb08m6EChfYlxZoNukbKWapxHO8TOh9MfhG3hzt+p1QhcK7ko4Scio8eFsj3YlNx1mqioMQEQbDl+ZlaaTIfWAdtfp+dm/cdD4MQRD+/uu++j4NWmO9+mwS0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CvcJ3Rey; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98AE8C4CEF8;
	Sat, 18 Oct 2025 07:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760772539;
	bh=vNWHIejyNgeAjj/yP4OEU+1cL7lMtWgCcdaXyxFMFWw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CvcJ3ReyaXPPslwlWdIZL4FEe7QpsFYYG6NVPNq8SjZMeD5e9m0CAkfUxyZJftFpK
	 Fy67kWTRI0BVHNZmU0FlDKZogL/nqVuLjF7WmPUMxifUZy8h10PmX5bCZim2JmPlgo
	 AxV1XechTYn+F9J+U6QlHPVzUao7Ka27VE98W2J8=
Date: Sat, 18 Oct 2025 09:28:56 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jameson Thies <jthies@google.com>
Cc: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, dmitry.baryshkov@oss.qualcomm.com,
	bleung@chromium.org, akuchynski@chromium.org,
	abhishekpandit@chromium.org, sebastian.reichel@collabora.com,
	kenny@panix.com, linux-pm@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] usb: typec: ucsi: psy: Set max current to zero when
 disconnected
Message-ID: <2025101839-startup-backwash-3830@gregkh>
References: <20251017223053.2415243-1-jthies@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017223053.2415243-1-jthies@google.com>

On Fri, Oct 17, 2025 at 10:30:53PM +0000, Jameson Thies wrote:
> The ucsi_psy_get_current_max function defaults to 0.1A when it is not
> clear how much current the partner device can support. But this does
> not check the port is connected, and will report 0.1A max current when
> nothing is connected. Update ucsi_psy_get_current_max to report 0A when
> there is no connection.
> 
> v2 changes:
> - added cc stable tag to commit message
> 
> Fixes: af833e7f7db3 ("usb: typec: ucsi: psy: Set current max to 100mA for BC 1.2 and Default")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jameson Thies <jthies@google.com>
> Reviewed-by: Benson Leung <bleung@chromium.org>
> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Tested-by: Kenneth R. Crudup <kenny@panix.com>
> ---
>  drivers/usb/typec/ucsi/psy.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/usb/typec/ucsi/psy.c b/drivers/usb/typec/ucsi/psy.c
> index 62a9d68bb66d..8ae900c8c132 100644
> --- a/drivers/usb/typec/ucsi/psy.c
> +++ b/drivers/usb/typec/ucsi/psy.c
> @@ -145,6 +145,11 @@ static int ucsi_psy_get_current_max(struct ucsi_connector *con,
>  {
>  	u32 pdo;
>  
> +	if (!UCSI_CONSTAT(con, CONNECTED)) {
> +		val->intval = 0;
> +		return 0;
> +	}

What prevents this from changing right after checking it?

thanks,

greg k-h

