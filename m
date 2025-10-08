Return-Path: <linux-pm+bounces-35811-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA9F6BC5214
	for <lists+linux-pm@lfdr.de>; Wed, 08 Oct 2025 15:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 355CF18849FF
	for <lists+linux-pm@lfdr.de>; Wed,  8 Oct 2025 13:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740D72741C6;
	Wed,  8 Oct 2025 13:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DhgWGk2A"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8461582866;
	Wed,  8 Oct 2025 13:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759928892; cv=none; b=i1gVrNg4fVfIPo6MLjK0f2V2SbKORhR9/P+r2kjaVjB63CsQvv2obD7sUWzg4Kr2BzEkiuHnxjIOZUOIUwd7fyDEhDDjeeDeYovnpdAIMjeDGFWfF4I/Ac92hXKhMRzBagg+GTFNZSh1zp4eGI9fjhu9BLFLS8pI6wxvbuwINm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759928892; c=relaxed/simple;
	bh=Mv5oczhOGVfVfVYG1uth6aFgEe6kihw7TkAxnQR9Tms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nDbkEMboCWT4SzOA+hIWMPaZ7D3GwTZx60uqOa+7cdrgW1+Hy1NV2Hd4n9JzJ8NZAynGBucObK9vsLCnxJNryVtrLsJAnKoV7xxPXS5YGfHPJXiRXhobB+avxyixzXPMhgofLCt9NKkjHspBzjm+pg3hSoEqH3fNtEROl/117lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DhgWGk2A; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759928890; x=1791464890;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Mv5oczhOGVfVfVYG1uth6aFgEe6kihw7TkAxnQR9Tms=;
  b=DhgWGk2A+c8rc9Rl+R2I0OH+qMb6/SV5qFH0FTM7hiZxBOh+NQKcYJMd
   4cokiZYOnw5o+izsSGj3JzU3S/y4yMyPTzITQmYRrWxwEmtgFhXsr38If
   1ucovFSBlMgzqzko2uEcLgbjRkT7ny9WW46K7+QyeI0bYQEDtNIiJ/2eh
   cy4nzhABcuEw4OoaGfh7viF9A79nOmkqDJrfx29tWjw5QXo66l3KMDSgc
   tRgsNTfl3lCukKLl/3aDN3UCXI05wsCwxInG0/hGdJAzO1EIxxTL6H8NF
   v6+yQQ9UntgYlN9/XEvdl9ZMiNFIQa/vI6oi0Dxg8iR64CV9knaVJLRTP
   g==;
X-CSE-ConnectionGUID: vWzeImCKQq++UYhD/uy8pw==
X-CSE-MsgGUID: Dj8+pc1LSS+qwT2/wzC6+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11576"; a="65765309"
X-IronPort-AV: E=Sophos;i="6.19,213,1754982000"; 
   d="scan'208";a="65765309"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2025 06:08:10 -0700
X-CSE-ConnectionGUID: UEHZUsjGStuTSx9mnvqISg==
X-CSE-MsgGUID: NMm7OjUSR1ONbBUar9z5Hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,213,1754982000"; 
   d="scan'208";a="185561140"
Received: from iherna2-mobl4.amr.corp.intel.com (HELO kuha.fi.intel.com) ([10.124.220.169])
  by orviesa005.jf.intel.com with SMTP; 08 Oct 2025 06:08:07 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 08 Oct 2025 16:08:04 +0300
Date: Wed, 8 Oct 2025 16:08:04 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Jameson Thies <jthies@google.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	dmitry.baryshkov@oss.qualcomm.com, bleung@chromium.org,
	gregkh@linuxfoundation.org, akuchynski@chromium.org,
	abhishekpandit@chromium.org, sebastian.reichel@collabora.com,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH 5/6] usb: typec: ucsi: psy: Set max current to zero when
 disconnected
Message-ID: <aOZiNH7UIMlHS2j2@kuha.fi.intel.com>
References: <20251007000007.3724229-1-jthies@google.com>
 <20251007000007.3724229-6-jthies@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251007000007.3724229-6-jthies@google.com>

On Tue, Oct 07, 2025 at 12:00:06AM +0000, Jameson Thies wrote:
> The ucsi_psy_get_current_max function defaults to 0.1A when it is not
> clear how much current the partner device can support. But this does
> not check the port is connected, and will report 0.1A max current when
> nothing is connected. Update ucsi_psy_get_current_max to report 0A when
> there is no connection.
> 
> Signed-off-by: Jameson Thies <jthies@google.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/ucsi/psy.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/usb/typec/ucsi/psy.c b/drivers/usb/typec/ucsi/psy.c
> index 985a90d3f898..3a209de55c14 100644
> --- a/drivers/usb/typec/ucsi/psy.c
> +++ b/drivers/usb/typec/ucsi/psy.c
> @@ -169,6 +169,11 @@ static int ucsi_psy_get_current_max(struct ucsi_connector *con,
>  {
>  	u32 pdo;
>  
> +	if (!UCSI_CONSTAT(con, CONNECTED)) {
> +		val->intval = 0;
> +		return 0;
> +	}
> +
>  	switch (UCSI_CONSTAT(con, PWR_OPMODE)) {
>  	case UCSI_CONSTAT_PWR_OPMODE_PD:
>  		if (con->num_pdos > 0) {
> -- 
> 2.51.0.618.g983fd99d29-goog

-- 
heikki

