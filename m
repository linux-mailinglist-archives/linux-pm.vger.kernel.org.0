Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4C8253629
	for <lists+linux-pm@lfdr.de>; Wed, 26 Aug 2020 19:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbgHZRrz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Aug 2020 13:47:55 -0400
Received: from mga06.intel.com ([134.134.136.31]:46505 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726820AbgHZRrs (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 26 Aug 2020 13:47:48 -0400
IronPort-SDR: tSkMt0h2C2xvxL20YBYOVsfOddsy0s7nIl8V1v/DHaRRZOCfBLxVXFSo4+gDbebgXZLOi0ThEN
 UscQ4ZQsd38Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9725"; a="217902690"
X-IronPort-AV: E=Sophos;i="5.76,356,1592895600"; 
   d="scan'208";a="217902690"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2020 10:47:48 -0700
IronPort-SDR: 8AHFNJF+3w8JSgd/qPHH74lfBlMW2ftlBY3qS9VhpxGUhQk3o9DQvNNzE5+uzuO7gqJVgD88Lg
 oLXajWwEF7EQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,356,1592895600"; 
   d="scan'208";a="500328324"
Received: from leike-mobl.ccr.corp.intel.com ([10.255.28.177])
  by fmsmga005.fm.intel.com with ESMTP; 26 Aug 2020 10:47:46 -0700
Message-ID: <82c789766e71d29cf1a90f519d21ba310ae8fa95.camel@intel.com>
Subject: Re: [PATCH] intel_idle: Add ICL support
From:   Zhang Rui <rui.zhang@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Guilhem Lettron <guilhem@barpilot.io>
Cc:     Artem Bityutskiy <dedekind1@gmail.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Thu, 27 Aug 2020 01:47:44 +0800
In-Reply-To: <CAJZ5v0gJscMWLsjCm_L6jCDdZ2hdRB2mPtUBSgd1va7Xm7GyVA@mail.gmail.com>
References: <20200826120421.44356-1-guilhem@barpilot.io>
         <CAJZ5v0i8XUF39Vv=EM4TgyXgK6zHniZW3tGYFPweO3kg+BrxOQ@mail.gmail.com>
         <CAGX5Wg2OOgY6d1RH514Kh9D6b+siga+jzH7qubcmE+ukq+6KKA@mail.gmail.com>
         <d0ca671465e6ce72c6c4d5178440ebc1e4814da8.camel@gmail.com>
         <e82c121057c4496238d3de7f7c919b7039d23b7c.camel@gmail.com>
         <CAGX5Wg0LrzPwf=2pGrQHAbFMVkOoYDxOoFa+ZmLBYshPvZQUXg@mail.gmail.com>
         <8fa7622dacc03f2fbd67e810f53389e3ede544e8.camel@intel.com>
         <CAGX5Wg0=K5AaTut5KH3R3+oasM5MM7PaJ9Z_L56xSNckMbWC9g@mail.gmail.com>
         <CAJZ5v0j4FXH26rZCjM9Csd56skPVbRpM7iFcKYAFMmLFX54+bg@mail.gmail.com>
         <e9e6823d63fe2b9938e43a14c136b89aec0c503b.camel@gmail.com>
         <CAJZ5v0gPY+7YBeWwszoNBwsbKLFOEeuLaekdX62_gvbHXB8xoA@mail.gmail.com>
         <CAGX5Wg3bVpgaFXHb1=4ikGk0P+4=XRqROBU4pqw1mpsY06dbHQ@mail.gmail.com>
         <CAJZ5v0gJscMWLsjCm_L6jCDdZ2hdRB2mPtUBSgd1va7Xm7GyVA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 2020-08-26 at 19:00 +0200, Rafael J. Wysocki wrote:
> On Wed, Aug 26, 2020 at 6:46 PM Guilhem Lettron <guilhem@barpilot.io>
> wrote:
> > 
> > I've done more tests, maybe it can give you more hints.
> > I don't see that much differences between both (with and without
> > patches) in this cases.
> 
> OK, thanks!
> 
> I'm assuming that the topmost two sets of data are for the "without
> the patch" case whereas the other three correspond to the "with the
> patch" case.

I think the sample period is too short.
Even with the same kernel, I can see the Busy% varies from 1% to 9%,
and the PkgWatt varies from 0.4W to 2.4W.

thanks,
rui

> 
> If so, the processor clearly enters PC10 in both cases and the
> residency percentages are similar.
> 
> The numbers of times the POLL state was selected in the first test
> look kind of unusual (relatively very large), but other than this the
> patch doesn't seem to make much of a difference, so I'm not going to
> apply it.
> 
> Thanks!

