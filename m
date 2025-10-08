Return-Path: <linux-pm+bounces-35810-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B81ABC51F9
	for <lists+linux-pm@lfdr.de>; Wed, 08 Oct 2025 15:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D36794F551A
	for <lists+linux-pm@lfdr.de>; Wed,  8 Oct 2025 13:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E7525A2A2;
	Wed,  8 Oct 2025 13:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="co1HbHCr"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117D8241691;
	Wed,  8 Oct 2025 13:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759928785; cv=none; b=BioTucOo0Qzb784ft9DXjhQ4q3sIDXIS51iC3H+FmA+Cw7Z8hw/yZOxf0M2iTn/g6hDI+28/wVwlbK/OxlTQZd64wcg74vTu/G5CyrzUTnXL7mGt10hB1QCTTIcIY5otxvbYQNr6iezXZKFbZtFcH4cMxrUqUqBdgo4gVPiJYBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759928785; c=relaxed/simple;
	bh=pMZ8QAPk2EMEFxUsj3OKnW2tQfavlpNCzXru0X4AEmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cbxY0SsgsNRYHqP4Qq08SDJoonw7nVUbR/s5lSxalwdeEc8sZBtmCWx96yHKcbF/rAl9kesOemZ12avvE8ikcM3SkF13/okOlIRTUA360A+Ndwm+uKF5Z8xqlP4YT0ZrvxhKTi/J2msHmpSxb5gtep7KdYnODBbu+2A2qAD6hhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=co1HbHCr; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759928784; x=1791464784;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pMZ8QAPk2EMEFxUsj3OKnW2tQfavlpNCzXru0X4AEmU=;
  b=co1HbHCrKkoP+jRPeb68dO+mDiWiBlUipkgoNm/Psyh6qpUl98/i9SXY
   d+/9iYd+SR1hRLAbYJc86Zix0Atd8X5ixuSn4lZu5ZlLlVTSgogb1IebX
   T+cxFpiz1K/qX31Nbj5rQitoDiazJzzg6sQslVJDTMRzVA6pGMo876j0m
   lQxgR3MWp/LPGrnqtYx3hWGbUjVG5rlWG+T302LH/t/cumTC68j7lzDZG
   No5x/saCLMJAaFxC8fIFNwnvjL635oHnD0NXsDbG5uXbO7l0NHNVKc1zE
   VQR2cvl+gTnAbTW1yRgpEvAXmPCjUScJj35jvGypwBAYIXTESLfIF8n4z
   Q==;
X-CSE-ConnectionGUID: NqljjOOoT52qwFPn4/w6Qg==
X-CSE-MsgGUID: uqZuy9LaR6GSkswX4uhQdA==
X-IronPort-AV: E=McAfee;i="6800,10657,11576"; a="72796201"
X-IronPort-AV: E=Sophos;i="6.19,213,1754982000"; 
   d="scan'208";a="72796201"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2025 06:06:23 -0700
X-CSE-ConnectionGUID: IOKbufxjR7GFM1ACgd2qlw==
X-CSE-MsgGUID: tx04jD8+QIe+cYT8FbEpBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,213,1754982000"; 
   d="scan'208";a="180103705"
Received: from iherna2-mobl4.amr.corp.intel.com (HELO kuha.fi.intel.com) ([10.124.220.169])
  by fmviesa007.fm.intel.com with SMTP; 08 Oct 2025 06:06:19 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 08 Oct 2025 16:06:18 +0300
Date: Wed, 8 Oct 2025 16:06:18 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Jameson Thies <jthies@google.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	dmitry.baryshkov@oss.qualcomm.com, bleung@chromium.org,
	gregkh@linuxfoundation.org, akuchynski@chromium.org,
	abhishekpandit@chromium.org, sebastian.reichel@collabora.com,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH 4/6] usb: typec: ucsi: Report power supply change on sink
 path change
Message-ID: <aOZhyhmIv_d_knXK@kuha.fi.intel.com>
References: <20251007000007.3724229-1-jthies@google.com>
 <20251007000007.3724229-5-jthies@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251007000007.3724229-5-jthies@google.com>

On Tue, Oct 07, 2025 at 12:00:05AM +0000, Jameson Thies wrote:
> Update the UCSI interface driver to report a power supply change when
> the PPM sets the Sink Path Change bit.
> 
> Signed-off-by: Jameson Thies <jthies@google.com>
> ---
>  drivers/usb/typec/ucsi/ucsi.c | 2 +-
>  drivers/usb/typec/ucsi/ucsi.h | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> index 7b718049d0d1..1a7d850b11ea 100644
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -1293,7 +1293,7 @@ static void ucsi_handle_connector_change(struct work_struct *work)
>  	if (change & UCSI_CONSTAT_CAM_CHANGE)
>  		ucsi_partner_task(con, ucsi_check_altmodes, 1, HZ);
>  
> -	if (change & UCSI_CONSTAT_BC_CHANGE)
> +	if (change & UCSI_CONSTAT_BC_CHANGE || change & UCSI_CONSTAT_SINK_PATH_CHANGE)

How about:

if (change & (UCSI_CONSTAT_BC_CHANGE | UCSI_CONSTAT_SINK_PATH_CHANGE))

>  		ucsi_port_psy_changed(con);
>  
>  	if (con->ucsi->version >= UCSI_VERSION_2_1 &&
> diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
> index cce93af7461b..35993bc34d4d 100644
> --- a/drivers/usb/typec/ucsi/ucsi.h
> +++ b/drivers/usb/typec/ucsi/ucsi.h
> @@ -382,6 +382,7 @@ struct ucsi_cable_property {
>  #define UCSI_CONSTAT_BC_CHANGE			BIT(9)
>  #define UCSI_CONSTAT_PARTNER_CHANGE		BIT(11)
>  #define UCSI_CONSTAT_POWER_DIR_CHANGE		BIT(12)
> +#define UCSI_CONSTAT_SINK_PATH_CHANGE		BIT(13)
>  #define UCSI_CONSTAT_CONNECT_CHANGE		BIT(14)
>  #define UCSI_CONSTAT_ERROR			BIT(15)
>  
> -- 
> 2.51.0.618.g983fd99d29-goog

-- 
heikki

