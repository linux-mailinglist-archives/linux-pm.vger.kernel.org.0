Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A73040AC2D
	for <lists+linux-pm@lfdr.de>; Tue, 14 Sep 2021 13:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbhINLGO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Sep 2021 07:06:14 -0400
Received: from mga02.intel.com ([134.134.136.20]:13473 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231732AbhINLGO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 14 Sep 2021 07:06:14 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10106"; a="209189708"
X-IronPort-AV: E=Sophos;i="5.85,292,1624345200"; 
   d="scan'208";a="209189708"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2021 04:04:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,292,1624345200"; 
   d="scan'208";a="609576766"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 14 Sep 2021 04:04:52 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 14 Sep 2021 14:04:51 +0300
Date:   Tue, 14 Sep 2021 14:04:51 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Benson Leung <bleung@google.com>
Cc:     Prashant Malani <pmalani@chromium.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-pm@vger.kernel.org, bleung@chromium.org, badhri@google.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sebastian Reichel <sre@kernel.org>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [RFC PATCH 2/3] power: supply: Add support for PDOs props
Message-ID: <YUCB0yDK1S6GDrM6@kuha.fi.intel.com>
References: <20210902213500.3795948-1-pmalani@chromium.org>
 <20210902213500.3795948-3-pmalani@chromium.org>
 <YT9SYMAnOCTWGi5P@kuha.fi.intel.com>
 <YT+M+CSyWYj1eqNZ@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YT+M+CSyWYj1eqNZ@google.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Mon, Sep 13, 2021 at 10:40:08AM -0700, Benson Leung kirjoitti:
> Hi Heikki,
> 
> On Mon, Sep 13, 2021 at 04:30:08PM +0300, Heikki Krogerus wrote:
> > My plan is to register a separate power supply for each PDO. So for
> > every source PDO and every sink PDO a port has in its capabilities,
> > you'll have a separate power supply registered, and the same for the
> > partner when it's connected. With every connection there should always
> > be one active (online) source psy and active sink psy (if the port is
> > source, one of the port's source psys will be active and the partner
> > will have the active sink psy, or vise versa - depending on the role).
> > 
> > Each PDO represents a "Power Supply" so to me that approach just
> > makes the most sense. It will require a bit of work in kernel, however
> > in user space it should mean that we only have a single new attribute
> > file for the power supplies named "pdo" that returns a single PDO.
> 
> There's a few downsides to this approach (one psy for each pdo).
> 
> The PDOs returned by Source Capabilities and Sink Capabilities do not just
> contain possible Voltage, Current, and Power combinations, but they also contain
> additional information in the form of properties.
> 
> In the Fixed Supply PDO, the following bits convey information about the supply
> or sink (See USB PD Spec R3.1 V1.0 Table 6-9):
> 
> * B29 - Dual-Role Power
> * B28 - USB Suspend Supported
> * B27 - Unconstrained Power
> * B26 - USB Communications Capable
> * B25 - Dual-Role Data
> * B24 - Unchunked Extended Messages Supported
> * B23 - EPR Mode Capable
> 
> These bits exist in every single 32-bit Fixed Supply PDO, however, 
> Section 6.4.1.2.2 requires that they be appropriately set in the vSafe5V Fixed
> PDO (which is required for all sources and sinks), and set to 0 in all other
> PDOs in the caps.
> 
> > Since all USB Providers support vSafe5V, the required vSafe5V Fixed Supply
> > Power Data Object is also used to convey additional information that is
> > returned in bits 29 through 25. All other Fixed Supply Power Data Objects
> > Shall set bits 29…22 to zero.
> 
> So, splitting out a particular port partner or port's PDOs into individual
> power supplies runs the risk of the information above not properly being
> attributed to the actual power supply.
> 
> For example, if you're connected to a 18W power supply that has a vSafe5V PDO,
> and a 9V Fixed PDO, and you're operating at 18W, the 9V Fixed PDO will be Active
> but the inactive vSafe5V PDO has information in those higher order bits that
> remain relevant.
> 
> Just something to keep in mind.

The section 6.4.1 dictates that the Capabilities Message (source or
sink) shall always contain the vSafe5V Fixes Supply object and that
it's always the first object. Therefore we should expect it to also
represent the first source and/or sink psy under the port/partner psy.

It would probable be easiest to just expose the missing details from
those extra bits in vSafe5V object under the typec port and partner
devices by providing separate sysfs files for them if needed.

thanks,

-- 
heikki
