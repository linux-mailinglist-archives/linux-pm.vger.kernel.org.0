Return-Path: <linux-pm+bounces-35812-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E5BBC5232
	for <lists+linux-pm@lfdr.de>; Wed, 08 Oct 2025 15:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 123AB4E5C4F
	for <lists+linux-pm@lfdr.de>; Wed,  8 Oct 2025 13:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A93B2741C6;
	Wed,  8 Oct 2025 13:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M9ewXMw4"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8111E224B15;
	Wed,  8 Oct 2025 13:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759929027; cv=none; b=kjP+rxHdAM9qtMFaVunTljRUmUoCiTcO9FDHKpgwYdvVb1Mr+kz8Epfpxxj8CGi/PgkOJaZRbuP9qFI3+U8BXcOTUJP3mAS3jM7lr9YWOMouf1TYcqBSmGoLk6EC24OB/1VbrdQy5MXYoWIlvyy87ld75Nr/WrZWsJsFXPwXUJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759929027; c=relaxed/simple;
	bh=pYDUazjmcYD33BJ5AkAmHdD5wv1LirXDwJ5jsZRuf20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fqUSJ1DsHXs+HOIXgVGXHxbgHAiocABW8SwzMO86I9H06NClZ12MeqnQRW+u+/tqBFmOPgchztvoCGEkXVcQcnCa8qajalN+9e5ZC41cf4k/s+tVaarbpco5ROaLITBERvfXg6mGRBnvv8D/0Dqd1WXv6qRVvtFrluhW5DTnhsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M9ewXMw4; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759929026; x=1791465026;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pYDUazjmcYD33BJ5AkAmHdD5wv1LirXDwJ5jsZRuf20=;
  b=M9ewXMw4JaeXbMyOjtNXuVqDqrph0KI2P9SNGnHZI5xbcKXOISqZtI4d
   EqBqXuO7OxB60d6PjWxmwc0GPT+ayKKOocNjyqU56l5elH8eZhYf9IX9O
   3iYPwRGSDfJRTHqrLIQTL34YdRfpq3Wed+jtbFUhcBzHa3ZkYxrlIogrT
   Ni3V9ITcdBA8HvGMxj/kwZgkl8AMhti7QCEJQJFpNQT8KEk8P2zQ815Md
   ximBg0aUVho/CGgzwUsglcIBANf+jt0aqn/MhYe8G2LOSadgQVrGiX2+k
   tSD6GmRtZ0z+M7ZnitwB6UurLXkEc8tDkIgrDN0z4X5ISJS01wSnV7loh
   w==;
X-CSE-ConnectionGUID: ko+3HeIxTf22LkI/7kUFgA==
X-CSE-MsgGUID: H/Ic36+cS6Cuhmpr0H1RrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11576"; a="79556395"
X-IronPort-AV: E=Sophos;i="6.19,213,1754982000"; 
   d="scan'208";a="79556395"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2025 06:10:25 -0700
X-CSE-ConnectionGUID: wtXe4uENQn+4uBnfj1Gb2Q==
X-CSE-MsgGUID: Sy0tqK/USxqEMoxFSiOyPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,213,1754982000"; 
   d="scan'208";a="180262659"
Received: from iherna2-mobl4.amr.corp.intel.com (HELO kuha.fi.intel.com) ([10.124.220.169])
  by orviesa007.jf.intel.com with SMTP; 08 Oct 2025 06:10:21 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 08 Oct 2025 16:10:19 +0300
Date: Wed, 8 Oct 2025 16:10:19 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Jameson Thies <jthies@google.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	dmitry.baryshkov@oss.qualcomm.com, bleung@chromium.org,
	gregkh@linuxfoundation.org, akuchynski@chromium.org,
	abhishekpandit@chromium.org, sebastian.reichel@collabora.com,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH 6/6] usb: typec: ucsi: pr_swap should check
 connector_status
Message-ID: <aOZiuxDfwYql6ZUu@kuha.fi.intel.com>
References: <20251007000007.3724229-1-jthies@google.com>
 <20251007000007.3724229-7-jthies@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251007000007.3724229-7-jthies@google.com>

Hi,

On Tue, Oct 07, 2025 at 12:00:07AM +0000, Jameson Thies wrote:
> From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> 
> Power role swaps initiated by the host system doesn't generate
> connection status change notifications.
> 
> >From UCSIv3.0 spec, section 6.5.10 Set Power Direction Role:
> 
> The execution of this command might require PPM to initiate a power
> role swap. If the power role swap fails for any reason, the command
> returns, and error and the power direction should remain unchanged.
> Note that if the execution of the command resulted in a successful
> power role swap, it should not result in a connector status change
> notification.
> 
> Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> Signed-off-by: Jameson Thies <jthies@google.com>
> ---
>  drivers/usb/typec/ucsi/ucsi.c | 30 +++++++++++++++++++++++++-----
>  1 file changed, 25 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> index 1a7d850b11ea..6e3797d7a144 100644
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -1526,20 +1526,40 @@ static int ucsi_pr_swap(struct typec_port *port, enum typec_role role)
>  	if (ret < 0)
>  		goto out_unlock;
>  
> -	mutex_unlock(&con->lock);
> +	command = UCSI_GET_CONNECTOR_STATUS | UCSI_CONNECTOR_NUMBER(con->num);
> +	ret = ucsi_send_command(con->ucsi, command, &con->status, sizeof(con->status));
> +	if (ret < 0)
> +		goto out_unlock;

Couldn't you use the helper ucsi_get_connector_status() ?

> -	if (!wait_for_completion_timeout(&con->complete,
> -					 msecs_to_jiffies(UCSI_SWAP_TIMEOUT_MS)))
> -		return -ETIMEDOUT;
> +	cur_role = !!UCSI_CONSTAT(con, PWR_DIR);
>  
> -	mutex_lock(&con->lock);
> +	/* Execution of SET_PDR should not result in connector status
> +	 * notifications. However, some legacy implementations may still defer
> +	 * the actual role swap and return immediately. Thus, check the
> +	 * connector status in case it immediately succeeded or wait for a later
> +	 * connector status change.
> +	 */
> +	if (cur_role != role) {
> +		mutex_unlock(&con->lock);
> +
> +		if (!wait_for_completion_timeout(
> +			    &con->complete,
> +			    msecs_to_jiffies(UCSI_SWAP_TIMEOUT_MS)))

Please align those properly.

> +			return -ETIMEDOUT;
> +
> +		mutex_lock(&con->lock);
> +	}
>  
>  	/* Something has gone wrong while swapping the role */
>  	if (UCSI_CONSTAT(con, PWR_OPMODE) != UCSI_CONSTAT_PWR_OPMODE_PD) {
>  		ucsi_reset_connector(con, true);
>  		ret = -EPROTO;
> +		goto out_unlock;
>  	}
>  
> +	/* Indicate successful power role swap */
> +	typec_set_pwr_role(con->port, role);
> +
>  out_unlock:
>  	mutex_unlock(&con->lock);
>  

Maybe this could be send separately? It does not seem to be directly
ucsi psy related.

thanks,

-- 
heikki

