Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C570D330172
	for <lists+linux-pm@lfdr.de>; Sun,  7 Mar 2021 14:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbhCGNxL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 7 Mar 2021 08:53:11 -0500
Received: from mga11.intel.com ([192.55.52.93]:58325 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231574AbhCGNxL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 7 Mar 2021 08:53:11 -0500
IronPort-SDR: oYy4JL65nmFKxKb1A2jQk/xpJzD9NlwuAT2IkL31W2ubc/MR0wRMw68AjJEHcsQysxczAjBjfp
 epqtmq+atupQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9915"; a="184528540"
X-IronPort-AV: E=Sophos;i="5.81,230,1610438400"; 
   d="scan'208";a="184528540"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2021 05:53:10 -0800
IronPort-SDR: 969AsZV7czI1jFMGhhPU2uhgUFrhXAdcn2h+r4h4IL2A3N82c2jDOh7fkno8g3a3FvPXh+wLoO
 9xT8MscgFtMg==
X-IronPort-AV: E=Sophos;i="5.81,230,1610438400"; 
   d="scan'208";a="601818915"
Received: from txu4-mobl.ccr.corp.intel.com ([10.255.30.172])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2021 05:53:09 -0800
Message-ID: <357ec08b83bef385162c23f37b4efa439a120947.camel@intel.com>
Subject: Re: driver notification when switching between battery vs AC power?
From:   Zhang Rui <rui.zhang@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Christoph Hellwig <hch@lst.de>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Date:   Sun, 07 Mar 2021 21:53:06 +0800
In-Reply-To: <CAJZ5v0gjO24-Gb-8ejTCkS2z6MFR7ZVAbYveVPkW1B_71u-LsQ@mail.gmail.com>
References: <20210305080748.GA17954@lst.de>
         <CAJZ5v0gjO24-Gb-8ejTCkS2z6MFR7ZVAbYveVPkW1B_71u-LsQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 2021-03-05 at 16:18 +0100, Rafael J. Wysocki wrote:
> Hi Christoph,
> 
> On Fri, Mar 5, 2021 at 9:07 AM Christoph Hellwig <hch@lst.de> wrote:
> > 
> > Hi Rafael,
> > 
> > do we have infrastructure that notifies the driver when a system is
> > switching from batter to AC power?
> 
> On systems with ACPI that can be done through an ACPI notifier, see
> amdgpu_acpi_event() for one example.
> 
> Adding Rui who's likely to be more familiar with this topic than I
> am.

Thanks for adding me in the loop.

Yes, an ACPI notifier callback should be sufficient for this purpose.

Usually, we get an ACPI notification upon AC plug/unplug, so what we
need in the NVMe driver is to get the notification and then get the
status of AC adapter. As ACPI AC driver always sends the AC events to
acpi notifier chain, what we need is 
a) define a notifier callback, and in the notifier callback
   1. ignore non-AC devices,
   2. get AC status, you can refer to acpi_ac_get_state()
b) register the notifier cb to ACPI notifier chain, by invoking
   register_acpi_notifier()

thanks,
rui
> 
> > There is a proposal to make the
> > Linux NVMe driver power management match the policy used by the
> > Windows driver more closely, which does this and we'd like to
> > prototype
> > that to check what difference the policy makes.

