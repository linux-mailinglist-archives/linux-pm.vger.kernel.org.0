Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81ECD19651A
	for <lists+linux-pm@lfdr.de>; Sat, 28 Mar 2020 11:41:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbgC1KlH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 28 Mar 2020 06:41:07 -0400
Received: from mga02.intel.com ([134.134.136.20]:24251 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725973AbgC1KlH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 28 Mar 2020 06:41:07 -0400
IronPort-SDR: hBg2sFQHt1JubBncDNw55azrPrybNHMWrBnlIG0FTxnX4fe5ih5vfaYyRuY/lPpn/EM8IF1/r+
 Q0eYptqAbkQw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2020 03:41:06 -0700
IronPort-SDR: Ty0aWSLn7xpvRb45MfRsnCppMnFf+6knk25yfjfkwR5OCsTTF24GCKsio6GBkmz3/D3rLsgV3l
 Dk6wYFjpylZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,316,1580803200"; 
   d="scan'208";a="271856236"
Received: from chenyu-office.sh.intel.com ([10.239.158.173])
  by fmsmga004.fm.intel.com with ESMTP; 28 Mar 2020 03:41:02 -0700
Date:   Sat, 28 Mar 2020 18:39:50 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-pm@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] PM / sleep: Add pm_debug_messages boot command control
Message-ID: <20200328103949.GA16999@chenyu-office.sh.intel.com>
References: <20200327111141.14324-1-yu.c.chen@intel.com>
 <a9843786-e7da-2c3c-30e2-c4887e9af4c6@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9843786-e7da-2c3c-30e2-c4887e9af4c6@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Randy,
On Fri, Mar 27, 2020 at 08:39:44AM -0700, Randy Dunlap wrote:
> On 3/27/20 4:11 AM, Chen Yu wrote:
> > Debug messages from the system suspend/hibernation infrastructure
> > is disabled by default, and can only be enabled after the system
> > has boot up via /sys/power/pm_debug_messages. This makes the hibernation
> > resume hard to track as it involves system boot up across hibernation.
> > There's no chance for software_resume() to track the resume process,
> > eg.
> > 
> > Turning on the pm_debug_messages during boot up by appending
> > 'pm_debug_message'.
> 
> Please add that command line option to
> Documentation/admin-guide/kernel-parameters.txt.
> Thanks.
> 
Thanks for pointing it out, I'll add it in the v2 patch.
Thanks,
Chenyu
> ~Randy
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
