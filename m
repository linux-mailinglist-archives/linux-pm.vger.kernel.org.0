Return-Path: <linux-pm+bounces-35809-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68CD5BC5198
	for <lists+linux-pm@lfdr.de>; Wed, 08 Oct 2025 15:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9149E18888A0
	for <lists+linux-pm@lfdr.de>; Wed,  8 Oct 2025 13:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 057BE22A7E0;
	Wed,  8 Oct 2025 13:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PDAYALvY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241231E412A;
	Wed,  8 Oct 2025 13:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759928579; cv=none; b=JWRV2pDHS3YWaa5VhylvkWa3/3OWx71bWyQqNLNlU0YKCk9vSuRdr9/1ebKdBo7ANRwp4x1Iysdtlio/RBx85ABZl6mUGAsmmAkeMGGTxhbGcBkKx7BUrq1saQ1SQ3PQV0sZUfbq028isFKe3/uU0ifjfkdSzXGyeTgR/JIOo2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759928579; c=relaxed/simple;
	bh=SQCbRJjxaJKKB4eaQUG9YIb7cEpUqHa0I/QnsFrMryo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d8Aj1G41TakvhkQk35DvapHlxFxhFD3nxSD2jWC//8Ge5NfmAa4enzWlbT7Qb1FejU4ArGYnpvyFkCK/K5Qz2I92Dm/bCsTueknBa0ePxZ/0XGk45OmXJMFsn0D+BGgFQjO5y5QmfsjiB46tuK5Dd/4XsX+L83AZAZIUTJfwWKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PDAYALvY; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759928578; x=1791464578;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SQCbRJjxaJKKB4eaQUG9YIb7cEpUqHa0I/QnsFrMryo=;
  b=PDAYALvYVREo7y1c/QMUixqlk+UMfKdIB2Q+t1zw6gO2/VBtSS8gqGub
   I13OvbQpN1XaySAs8s+7+vTjMrNeq5oA0IiY+C6vdkhGZJASCcaIyrdad
   e+B35oRnZjeobBAdlUNI9eZDR1apRVdyYcCqm0d8tede5RtZIa55Zg8O0
   Xbyevd9F/D9lA0xzNVDkDd0fGreYeJSNtpOmfvqNm6WHC7HMQoh1x4uV0
   u+mARpbTKfDFLXC/ORb4cYfOf6C/l4Eon1UNI7EZtJKOEXUEbHezKb8cf
   ACxyzZPLoLqpW+bH+s9RGWs/MDdt7JzWsoiCZYQxgSun5aSIQLzEUHRkd
   A==;
X-CSE-ConnectionGUID: 1xm22gveSq+r4eajodh6gg==
X-CSE-MsgGUID: 7XwjFGscTwSjWU7y0z0NoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11576"; a="61325638"
X-IronPort-AV: E=Sophos;i="6.19,213,1754982000"; 
   d="scan'208";a="61325638"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2025 06:02:57 -0700
X-CSE-ConnectionGUID: QxN/Lun8TdiJqH2MkpdYrg==
X-CSE-MsgGUID: bG/6yHB8Toa0yquEOfPLCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,213,1754982000"; 
   d="scan'208";a="184472644"
Received: from iherna2-mobl4.amr.corp.intel.com (HELO kuha.fi.intel.com) ([10.124.220.169])
  by orviesa003.jf.intel.com with SMTP; 08 Oct 2025 06:02:52 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 08 Oct 2025 16:02:51 +0300
Date: Wed, 8 Oct 2025 16:02:51 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Jameson Thies <jthies@google.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	dmitry.baryshkov@oss.qualcomm.com, bleung@chromium.org,
	gregkh@linuxfoundation.org, akuchynski@chromium.org,
	abhishekpandit@chromium.org, sebastian.reichel@collabora.com,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH 3/6] usb: typec: ucsi: Report power supply changes on
 power opmode changes
Message-ID: <aOZg-5hIU25-y0Ya@kuha.fi.intel.com>
References: <20251007000007.3724229-1-jthies@google.com>
 <20251007000007.3724229-4-jthies@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251007000007.3724229-4-jthies@google.com>

On Tue, Oct 07, 2025 at 12:00:04AM +0000, Jameson Thies wrote:
> Report opmode changes from the PPM to the power supply class by calling
> ucsi_port_psy_changed(). If the current opmode is USB PD, do not call
> ucsi_port_psy_changed(). The power supply class will be updated after
> requesting partner source PDOs.
> 
> Signed-off-by: Jameson Thies <jthies@google.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/ucsi/ucsi.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> index 3f568f790f39..7b718049d0d1 100644
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -1022,14 +1022,17 @@ static void ucsi_pwr_opmode_change(struct ucsi_connector *con)
>  	case UCSI_CONSTAT_PWR_OPMODE_TYPEC1_5:
>  		con->rdo = 0;
>  		typec_set_pwr_opmode(con->port, TYPEC_PWR_MODE_1_5A);
> +		ucsi_port_psy_changed(con);
>  		break;
>  	case UCSI_CONSTAT_PWR_OPMODE_TYPEC3_0:
>  		con->rdo = 0;
>  		typec_set_pwr_opmode(con->port, TYPEC_PWR_MODE_3_0A);
> +		ucsi_port_psy_changed(con);
>  		break;
>  	default:
>  		con->rdo = 0;
>  		typec_set_pwr_opmode(con->port, TYPEC_PWR_MODE_USB);
> +		ucsi_port_psy_changed(con);
>  		break;
>  	}
>  }
> -- 
> 2.51.0.618.g983fd99d29-goog

-- 
heikki

