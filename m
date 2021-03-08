Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC66E3308F6
	for <lists+linux-pm@lfdr.de>; Mon,  8 Mar 2021 08:51:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbhCHHvC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Mar 2021 02:51:02 -0500
Received: from verein.lst.de ([213.95.11.211]:54491 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235227AbhCHHuv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 8 Mar 2021 02:50:51 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id EB41168B02; Mon,  8 Mar 2021 08:50:48 +0100 (CET)
Date:   Mon, 8 Mar 2021 08:50:48 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: driver notification when switching between battery vs AC power?
Message-ID: <20210308075048.GA983@lst.de>
References: <20210305080748.GA17954@lst.de> <CAJZ5v0gjO24-Gb-8ejTCkS2z6MFR7ZVAbYveVPkW1B_71u-LsQ@mail.gmail.com> <357ec08b83bef385162c23f37b4efa439a120947.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <357ec08b83bef385162c23f37b4efa439a120947.camel@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Mar 07, 2021 at 09:53:06PM +0800, Zhang Rui wrote:
> Thanks for adding me in the loop.
> 
> Yes, an ACPI notifier callback should be sufficient for this purpose.
> 
> Usually, we get an ACPI notification upon AC plug/unplug, so what we
> need in the NVMe driver is to get the notification and then get the
> status of AC adapter. As ACPI AC driver always sends the AC events to
> acpi notifier chain, what we need is 
> a) define a notifier callback, and in the notifier callback
>    1. ignore non-AC devices,
>    2. get AC status, you can refer to acpi_ac_get_state()
> b) register the notifier cb to ACPI notifier chain, by invoking
>    register_acpi_notifier()

Not my direct priority now, but would there be any objections to
wire up a power_source_notifier method in struct dev_pm_ops to
avoid boilerplate code and ACPI dependencies in drivers?
