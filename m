Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDFC5408F84
	for <lists+linux-pm@lfdr.de>; Mon, 13 Sep 2021 15:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242518AbhIMNn5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Sep 2021 09:43:57 -0400
Received: from mga12.intel.com ([192.55.52.136]:49535 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241447AbhIMNlz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 13 Sep 2021 09:41:55 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10105"; a="201184502"
X-IronPort-AV: E=Sophos;i="5.85,288,1624345200"; 
   d="scan'208";a="201184502"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2021 06:30:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,288,1624345200"; 
   d="scan'208";a="608982398"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 13 Sep 2021 06:30:09 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 13 Sep 2021 16:30:08 +0300
Date:   Mon, 13 Sep 2021 16:30:08 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-pm@vger.kernel.org, bleung@chromium.org, badhri@google.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sebastian Reichel <sre@kernel.org>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [RFC PATCH 2/3] power: supply: Add support for PDOs props
Message-ID: <YT9SYMAnOCTWGi5P@kuha.fi.intel.com>
References: <20210902213500.3795948-1-pmalani@chromium.org>
 <20210902213500.3795948-3-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210902213500.3795948-3-pmalani@chromium.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Prashant,

On Thu, Sep 02, 2021 at 02:35:00PM -0700, Prashant Malani wrote:
> Add support for reporting Source and Sink Capabilities
> Power Data Object (PDO) property. These are reported by USB
> Power Delivery (PD) capable power sources.
> 
> Signed-off-by: Prashant Malani <pmalani@chromium.org>
> ---
>  Documentation/ABI/testing/sysfs-class-power | 30 +++++++++++++++++++++
>  drivers/power/supply/power_supply_sysfs.c   | 18 ++++++++++++-
>  include/linux/power_supply.h                |  5 ++++
>  3 files changed, 52 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
> index ca830c6cd809..90d4198e6dfb 100644
> --- a/Documentation/ABI/testing/sysfs-class-power
> +++ b/Documentation/ABI/testing/sysfs-class-power
> @@ -562,6 +562,36 @@ Description:
>  			      "Unknown", "SDP", "DCP", "CDP", "ACA", "C", "PD",
>  			      "PD_DRP", "PD_PPS", "BrickID"
>  
> +What:		/sys/class/power_supply/<supply_name>/source_cap_pdos
> +Date:		September 2021
> +Contact:	linux-pm@vger.kernel.org
> +Description:
> +		Reports the Source Capabilities Power Data Objects (PDO) reported by the USB
> +		PD-capable power source. 13 PDOs are listed. PDOs 1-7 represent the Source Caps
> +		for devices which only support Standard Power Range (SPR), whereas PDOs 8-13
> +		are for Extended Power Range (EPR) capable sources.
> +		NOTE: The EPR Source Caps message is a superset of the Source Cap message, so on
> +		SPR-only sources, PDOs 8-13 will be 0.
> +
> +		Access: Read-Only
> +
> +		Valid values: Represented as a list of 13 32-bit PDO objects in hexadecimal format.
> +
> +What:		/sys/class/power_supply/<supply_name>/sink_cap_pdos
> +Date:		September 2021
> +Contact:	linux-pm@vger.kernel.org
> +Description:
> +		Reports the Sink Capabilities Power Data Objects (PDO) reported by the USB
> +		PD-capable power source. 13 PDOs are listed. PDOs 1-7 represent the Sink Caps
> +		for devices which only support Standard Power Range (SPR), whereas PDOs 8-13
> +		are for Extended Power Range (EPR) capable sinks.
> +		NOTE: The EPR Sink Caps message is a superset of the Sink Cap message, so on
> +		SPR-only sinks, PDOs 8-13 will be 0.
> +
> +		Access: Read-Only
> +
> +		Valid values: Represented as a list of 13 32-bit PDO objects in hexadecimal format.

My plan is to register a separate power supply for each PDO. So for
every source PDO and every sink PDO a port has in its capabilities,
you'll have a separate power supply registered, and the same for the
partner when it's connected. With every connection there should always
be one active (online) source psy and active sink psy (if the port is
source, one of the port's source psys will be active and the partner
will have the active sink psy, or vise versa - depending on the role).

Each PDO represents a "Power Supply" so to me that approach just
makes the most sense. It will require a bit of work in kernel, however
in user space it should mean that we only have a single new attribute
file for the power supplies named "pdo" that returns a single PDO.

Let me know if you guys see any obvious problems with the idea.
Otherwise, that is how we really need to do this. That will make
things much more clear in user space. I have a feeling it will make
things easier in kernel as well in the long run.

Adding Adam and Guenter. It would be good if you guys could comment
the idea as well.

thanks,

-- 
heikki
