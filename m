Return-Path: <linux-pm+bounces-35806-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B37BC5018
	for <lists+linux-pm@lfdr.de>; Wed, 08 Oct 2025 14:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 21CDC4F5CEE
	for <lists+linux-pm@lfdr.de>; Wed,  8 Oct 2025 12:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A64D25782A;
	Wed,  8 Oct 2025 12:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E66yc/6x"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E315322576E;
	Wed,  8 Oct 2025 12:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759928031; cv=none; b=itd3rfpV6W6F64dAGAcAkEvdh8kCkQV931N+TQlIuBvkUJJXihjzLc9hOSYsFUPPm0B9C+LI2ByDTlS3e35mm0VaoYODW9TLs3pJGtV9515nVa+bZBrqOh4O0ucHlsgOFJoxJVb25Vc0JvvF1sOLkxxuQu7JINnUvDuQCQ4IGX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759928031; c=relaxed/simple;
	bh=pljbK3SHOyft78K3bW0h+fZisJ0+v+pfNCKFjCcv3w0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fKwSg7C8ykmtyD/m3ljU0jf2Hyj3630qKsDEC/7jO+cOr+9rzgnGu8gh5iwLfmDuGkGgdcrYzF8/YoH0HCaq8U9Athd3y2BHk+85fRBx5lYPzyQnn6cDGm4vEsSKLpSDT/KlsgRXShXylmqwvTcG+xec8+gTf+T27o4ImLP62iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E66yc/6x; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759928030; x=1791464030;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pljbK3SHOyft78K3bW0h+fZisJ0+v+pfNCKFjCcv3w0=;
  b=E66yc/6xBcEOvlPggNzQBYV2T2b1TO6m7Rbl/zL3E3aeHoC5YtLx3YIa
   0dapMMe5W0oZ0udyz18YUr4b1XZpGfo1AQhqg7DDkww7tHSl6YbMx5UAx
   j5lyvir8+zOnsJ+XGdlDD5jL2fdrw/ZK+JxGHsLHK72H9nvB5MvgnjABd
   4CjxCp7xKLXpiiu4TEdpZo9x2rM9SUGufneOWh6P5xxzTWJAQM87jCOE3
   poiYC5wfGyjiJPBp7QAwBKSbvOmlgbFyjkrGol3dLJtqQnGEM6s1nIMCV
   qIWWnmF7X8jZTifb1JEqQqXijZJIu90nLdab6oTCcb9DHplFcOxfNph81
   A==;
X-CSE-ConnectionGUID: Fo5cxWVXSVqdswnqEcc6UQ==
X-CSE-MsgGUID: kC/jtn3oQSyiJjq1eL637Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11576"; a="65971691"
X-IronPort-AV: E=Sophos;i="6.19,213,1754982000"; 
   d="scan'208";a="65971691"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2025 05:53:49 -0700
X-CSE-ConnectionGUID: kl3ktiOyT0GsmL8qmav1ow==
X-CSE-MsgGUID: I/IcAiWZSleIuhReZfZKOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,213,1754982000"; 
   d="scan'208";a="185723571"
Received: from iherna2-mobl4.amr.corp.intel.com (HELO kuha.fi.intel.com) ([10.124.220.169])
  by fmviesa004.fm.intel.com with SMTP; 08 Oct 2025 05:53:45 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 08 Oct 2025 15:53:44 +0300
Date: Wed, 8 Oct 2025 15:53:44 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Jameson Thies <jthies@google.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	dmitry.baryshkov@oss.qualcomm.com, bleung@chromium.org,
	gregkh@linuxfoundation.org, akuchynski@chromium.org,
	abhishekpandit@chromium.org, sebastian.reichel@collabora.com,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/6] usb: typec: ucsi: psy: Add power supply status
Message-ID: <aOZe2CbQuT2J8Itd@kuha.fi.intel.com>
References: <20251007000007.3724229-1-jthies@google.com>
 <20251007000007.3724229-2-jthies@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251007000007.3724229-2-jthies@google.com>

On Tue, Oct 07, 2025 at 12:00:02AM +0000, Jameson Thies wrote:
> Add support for power supply status. If a port is acting as a sink
> with the sink path enabled, report it is charging. If a port is
> source, report it is discharging. If there is no connection or the
> port hasn't enabled the sink path, report not charging.
> 
> Signed-off-by: Jameson Thies <jthies@google.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/ucsi/psy.c  | 26 ++++++++++++++++++++++++++
>  drivers/usb/typec/ucsi/ucsi.h |  3 +++
>  2 files changed, 29 insertions(+)
> 
> diff --git a/drivers/usb/typec/ucsi/psy.c b/drivers/usb/typec/ucsi/psy.c
> index 62a9d68bb66d..2b0225821502 100644
> --- a/drivers/usb/typec/ucsi/psy.c
> +++ b/drivers/usb/typec/ucsi/psy.c
> @@ -29,6 +29,7 @@ static enum power_supply_property ucsi_psy_props[] = {
>  	POWER_SUPPLY_PROP_CURRENT_MAX,
>  	POWER_SUPPLY_PROP_CURRENT_NOW,
>  	POWER_SUPPLY_PROP_SCOPE,
> +	POWER_SUPPLY_PROP_STATUS,
>  };
>  
>  static int ucsi_psy_get_scope(struct ucsi_connector *con,
> @@ -51,6 +52,29 @@ static int ucsi_psy_get_scope(struct ucsi_connector *con,
>  	return 0;
>  }
>  
> +static int ucsi_psy_get_status(struct ucsi_connector *con,
> +			       union power_supply_propval *val)
> +{
> +	bool is_sink = UCSI_CONSTAT(con, PWR_DIR) == TYPEC_SINK;
> +	bool sink_path_enabled = true;
> +
> +	val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
> +
> +	if (con->ucsi->version >= UCSI_VERSION_2_0)
> +		sink_path_enabled =
> +			UCSI_CONSTAT(con, SINK_PATH_STATUS_V2_0) ==
> +			UCSI_CONSTAT_SINK_PATH_ENABLED;
> +
> +	if (UCSI_CONSTAT(con, CONNECTED)) {
> +		if (is_sink && sink_path_enabled)
> +			val->intval = POWER_SUPPLY_STATUS_CHARGING;
> +		else if (!is_sink)
> +			val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
> +	}
> +
> +	return 0;
> +}
> +
>  static int ucsi_psy_get_online(struct ucsi_connector *con,
>  			       union power_supply_propval *val)
>  {
> @@ -245,6 +269,8 @@ static int ucsi_psy_get_prop(struct power_supply *psy,
>  		return ucsi_psy_get_current_now(con, val);
>  	case POWER_SUPPLY_PROP_SCOPE:
>  		return ucsi_psy_get_scope(con, val);
> +	case POWER_SUPPLY_PROP_STATUS:
> +		return ucsi_psy_get_status(con, val);
>  	default:
>  		return -EINVAL;
>  	}
> diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
> index e301d9012936..cce93af7461b 100644
> --- a/drivers/usb/typec/ucsi/ucsi.h
> +++ b/drivers/usb/typec/ucsi/ucsi.h
> @@ -360,6 +360,9 @@ struct ucsi_cable_property {
>  #define   UCSI_CONSTAT_BC_SLOW_CHARGING		2
>  #define   UCSI_CONSTAT_BC_TRICKLE_CHARGING	3
>  #define UCSI_CONSTAT_PD_VERSION_V1_2		UCSI_DECLARE_BITFIELD_V1_2(70, 16)
> +#define UCSI_CONSTAT_SINK_PATH_STATUS_V2_0	UCSI_DECLARE_BITFIELD_V2_0(87, 1)
> +#define   UCSI_CONSTAT_SINK_PATH_DISABLED   0
> +#define   UCSI_CONSTAT_SINK_PATH_ENABLED    1
>  #define UCSI_CONSTAT_PWR_READING_READY_V2_1	UCSI_DECLARE_BITFIELD_V2_1(89, 1)
>  #define UCSI_CONSTAT_CURRENT_SCALE_V2_1		UCSI_DECLARE_BITFIELD_V2_1(90, 3)
>  #define UCSI_CONSTAT_PEAK_CURRENT_V2_1		UCSI_DECLARE_BITFIELD_V2_1(93, 16)
> -- 
> 2.51.0.618.g983fd99d29-goog

-- 
heikki

