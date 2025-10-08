Return-Path: <linux-pm+bounces-35807-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D20D9BC51B6
	for <lists+linux-pm@lfdr.de>; Wed, 08 Oct 2025 15:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AA3544F754A
	for <lists+linux-pm@lfdr.de>; Wed,  8 Oct 2025 13:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB971FCF41;
	Wed,  8 Oct 2025 13:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KPb/DnBj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E8A34BA22;
	Wed,  8 Oct 2025 13:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759928533; cv=none; b=IxipNPWHmEIpnyoN022zYkL7jQxnTvdgh8PyYNZ7LVWasMAU0xkqIBpeaKGyVjdBPA6zL0Hu+j/ljF/6i8KNB4ajGQvAKJcWavQtdqr1MjLohwssTuCEOEYM6QzA/XWWJO9dnizOB+e1KGJZO2tAUiKApmNVh2GKwIJgRiWqsqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759928533; c=relaxed/simple;
	bh=j9Kfj0xN5arYuTix1NPXhwgjJHzi3aBAQYTQBtG2S7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fTYpUb7p3x8bxzNGWAb7xuxwSNfpd+CPj36GleFa06k7G9L314aj/clcnQuNYYEwXiilHfdxtOe5YEveiNyF/IrxhQkAeLlUe5OjQteD3E6S7fcIXuqgoikaQpiH4lQkvWQ/ZaqKqhrqpQDFHNUeJ2HoeHTC/ATDDUwnKM0TUcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KPb/DnBj; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759928531; x=1791464531;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=j9Kfj0xN5arYuTix1NPXhwgjJHzi3aBAQYTQBtG2S7s=;
  b=KPb/DnBjQ4eaUWOwyGgC+1S+UPDgLTXJtmYp+YojCzmxltdqo7QTVK/N
   x5XyS4llMm5pfDTSeEJNguKhPCub/YjKEpcGITLZgSb8UWZrRKfmjqalE
   iDJo/xS4J8oTg9MMbHBQwwXQ6ERnZ7HMqZyFuNwuziiLjUi7DjLh/WH8a
   SPhRO52Qq86uI3aEf58pn3KosrWup/AQ9Syn2rg5iZWuHR6EGUx1fxyVz
   AHeSazbiP3HNj5b8591GSVkyYPgQpqvg7hyWgacHZXKKrfCLk0bJrXrwV
   CEMcWCMHWU8D+i0bOpBApqHXy/AjHIG2pfCmvdFBGnHA7anxknRF8+lWw
   A==;
X-CSE-ConnectionGUID: 7MrvXb+oSxOEz+/69zMpJQ==
X-CSE-MsgGUID: oJ/W13eTT4+xJA+7XReDXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11576"; a="72795694"
X-IronPort-AV: E=Sophos;i="6.19,213,1754982000"; 
   d="scan'208";a="72795694"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2025 06:02:10 -0700
X-CSE-ConnectionGUID: OUeGOgmmTiCcMeSxiiO/sQ==
X-CSE-MsgGUID: HYAs4nqDSqe+rtEt0z4PSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,213,1754982000"; 
   d="scan'208";a="180103197"
Received: from iherna2-mobl4.amr.corp.intel.com (HELO kuha.fi.intel.com) ([10.124.220.169])
  by fmviesa007.fm.intel.com with SMTP; 08 Oct 2025 06:02:05 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 08 Oct 2025 16:02:03 +0300
Date: Wed, 8 Oct 2025 16:02:03 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Jameson Thies <jthies@google.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	dmitry.baryshkov@oss.qualcomm.com, bleung@chromium.org,
	gregkh@linuxfoundation.org, akuchynski@chromium.org,
	abhishekpandit@chromium.org, sebastian.reichel@collabora.com,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/6] usb: typec: ucsi: psy: Add support for DRP USB type
Message-ID: <aOZgy-ngtrilVQ5N@kuha.fi.intel.com>
References: <20251007000007.3724229-1-jthies@google.com>
 <20251007000007.3724229-3-jthies@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251007000007.3724229-3-jthies@google.com>

On Tue, Oct 07, 2025 at 12:00:03AM +0000, Jameson Thies wrote:
> The USB Type registered with the power supply class is based on the
> current power operation mode of the port. When the port is using USB
> PD and is connected to a DRP partner, report that the power supply's
> USB type is USB PD DRP.
> 
> Signed-off-by: Jameson Thies <jthies@google.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/ucsi/psy.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/ucsi/psy.c b/drivers/usb/typec/ucsi/psy.c
> index 2b0225821502..985a90d3f898 100644
> --- a/drivers/usb/typec/ucsi/psy.c
> +++ b/drivers/usb/typec/ucsi/psy.c
> @@ -209,8 +209,16 @@ static int ucsi_psy_get_usb_type(struct ucsi_connector *con,
>  {
>  	val->intval = POWER_SUPPLY_USB_TYPE_C;
>  	if (UCSI_CONSTAT(con, CONNECTED) &&
> -	    UCSI_CONSTAT(con, PWR_OPMODE) == UCSI_CONSTAT_PWR_OPMODE_PD)
> +	    UCSI_CONSTAT(con, PWR_OPMODE) == UCSI_CONSTAT_PWR_OPMODE_PD) {
> +		for (int i = 0; i < con->num_pdos; i++) {
> +			if (pdo_type(con->src_pdos[i]) == PDO_TYPE_FIXED &&
> +			    con->src_pdos[i] & PDO_FIXED_DUAL_ROLE) {
> +				val->intval = POWER_SUPPLY_USB_TYPE_PD_DRP;
> +				return 0;
> +			}
> +		}
>  		val->intval = POWER_SUPPLY_USB_TYPE_PD;
> +	}
>  
>  	return 0;
>  }
> -- 
> 2.51.0.618.g983fd99d29-goog

-- 
heikki

