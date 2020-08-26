Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFAAE25357E
	for <lists+linux-pm@lfdr.de>; Wed, 26 Aug 2020 18:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbgHZQxA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Aug 2020 12:53:00 -0400
Received: from mga01.intel.com ([192.55.52.88]:8075 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726739AbgHZQw6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 26 Aug 2020 12:52:58 -0400
IronPort-SDR: kukMBqYf7ya60bqwi5Z8Q61ahgOHiI53jnyEKXD/DhVOoJNixLt5jRfusB1HrPzAoEJjYZBbPp
 fhE/5ocEZ6Mw==
X-IronPort-AV: E=McAfee;i="6000,8403,9725"; a="174383946"
X-IronPort-AV: E=Sophos;i="5.76,356,1592895600"; 
   d="scan'208";a="174383946"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2020 09:52:57 -0700
IronPort-SDR: Npc9IP5GJnDHn3tW7dPtZlA7CcT6572KfKtlCH/xLBwxlDLiErCqnJYoij4YqNtKHAawJOKpk+
 ueTtmAjdNZ+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,356,1592895600"; 
   d="scan'208";a="299538165"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 26 Aug 2020 09:52:55 -0700
Received: from abityuts-desk1.fi.intel.com (abityuts-desk1.fi.intel.com [10.237.72.186])
        by linux.intel.com (Postfix) with ESMTP id AC9E25805ED;
        Wed, 26 Aug 2020 09:52:53 -0700 (PDT)
Message-ID: <39d26cecd7e911c6527e05fbe5049b13a5d53788.camel@gmail.com>
Subject: Re: [PATCH] intel_idle: Add ICL support
From:   Artem Bityutskiy <dedekind1@gmail.com>
Reply-To: dedekind1@gmail.com
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Guilhem Lettron <guilhem@barpilot.io>,
        Zhang Rui <rui.zhang@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Wed, 26 Aug 2020 19:52:52 +0300
In-Reply-To: <CAJZ5v0gPY+7YBeWwszoNBwsbKLFOEeuLaekdX62_gvbHXB8xoA@mail.gmail.com>
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
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 2020-08-26 at 18:43 +0200, Rafael J. Wysocki wrote:
> > I am curious, somehow that patch makes a difference.
> 
> It does make a difference, because it makes the processor spend more
> time in PC2.  Which very well may be because the processor cannot
> enter deeper C-states.

OK, you are right, we do not indeed have PC10 in both cases. The file
was wrapped and I unwrapped it incorrectly. So indeed this is the real
problem to solve, and the patch does not solve it.

