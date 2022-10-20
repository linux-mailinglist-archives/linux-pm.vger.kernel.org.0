Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 102A8605986
	for <lists+linux-pm@lfdr.de>; Thu, 20 Oct 2022 10:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbiJTIUJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Oct 2022 04:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiJTIUI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Oct 2022 04:20:08 -0400
X-Greylist: delayed 565 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 20 Oct 2022 01:20:07 PDT
Received: from outbound-smtp42.blacknight.com (outbound-smtp42.blacknight.com [46.22.139.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 308AE2EF48
        for <linux-pm@vger.kernel.org>; Thu, 20 Oct 2022 01:20:05 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp42.blacknight.com (Postfix) with ESMTPS id 1F41529C5
        for <linux-pm@vger.kernel.org>; Thu, 20 Oct 2022 09:10:37 +0100 (IST)
Received: (qmail 8911 invoked from network); 20 Oct 2022 08:10:36 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 20 Oct 2022 08:10:36 -0000
Date:   Thu, 20 Oct 2022 09:10:35 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Mario Limonciello <mario.limonciello@amd.com>,
        linux-rtc@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Todd Brandt <todd.e.brandt@linux.intel.com>
Subject: Re: [PATCH] rtc: rtc-cmos: Fix wake alarm breakage
Message-ID: <20221020081035.4lafnpunbacrhdqs@techsingularity.net>
References: <5887691.lOV4Wx5bFT@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <5887691.lOV4Wx5bFT@kreacher>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Oct 18, 2022 at 06:09:31PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Commit 4919d3eb2ec0 ("rtc: cmos: Fix event handler registration
> ordering issue") overlooked the fact that cmos_do_probe() depended
> on the preparations carried out by cmos_wake_setup() and the wake
> alarm stopped working after the ordering of them had been changed.
> 
> Address this by partially reverting commit 4919d3eb2ec0 so that
> cmos_wake_setup() is called before cmos_do_probe() again and moving
> the rtc_wake_setup() invocation from cmos_wake_setup() directly to the
> callers of cmos_do_probe() where it will happen after a successful
> completion of the latter.
> 
> Fixes: 4919d3eb2ec0 ("rtc: cmos: Fix event handler registration ordering issue")
> Reported-by: Zhang Rui <rui.zhang@intel.com>
> Reported-by: Todd Brandt <todd.e.brandt@linux.intel.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Boot test that previously hit NULL pointer exceptions also completed successfully.

-- 
Mel Gorman
SUSE Labs
