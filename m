Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F19B197979
	for <lists+linux-pm@lfdr.de>; Mon, 30 Mar 2020 12:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729012AbgC3Knm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Mar 2020 06:43:42 -0400
Received: from mga09.intel.com ([134.134.136.24]:26454 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728912AbgC3Knm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 30 Mar 2020 06:43:42 -0400
IronPort-SDR: 9vD//3wRp0uiwiAWTFBn2VEfbc04iqkKNRVwgobCD24G/KasMYrH4tHI5ZZjIqPs6cELvTcNtD
 lcd3MON3X/hw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2020 03:43:41 -0700
IronPort-SDR: wwUk+Jwnmz7vf91weyeKOqaGAh9J/oT3rFSilVdm0crTq+p/bvI0oy+69NMMUJGR3TGHDRKVQt
 zBxK7pVfY7Sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,324,1580803200"; 
   d="scan'208";a="294549884"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by FMSMGA003.fm.intel.com with ESMTP; 30 Mar 2020 03:43:38 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jIrtM-00EAdz-DH; Mon, 30 Mar 2020 13:43:40 +0300
Date:   Mon, 30 Mar 2020 13:43:40 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Basil Eljuse <Basil.Eljuse@arm.com>,
        lkft-triage@lists.linaro.org,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        fntoth@gmail.com, Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>
Subject: Re: Re: [PATCH v2 3/3] driver core: Replace open-coded
 list_last_entry()
Message-ID: <20200330104340.GO1922688@smile.fi.intel.com>
References: <20200324122023.9649-1-andriy.shevchenko@linux.intel.com>
 <20200324122023.9649-3-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0gg=V8uDd4afJ3MULsgKYvWajKJioANk4jj7xEhBzrRrQ@mail.gmail.com>
 <CA+G9fYvFnXqSnoQSJ-DkQvAFv87iWmhH6dT1N79qrq=Aeuv4rw@mail.gmail.com>
 <028b636f-6e0f-c36a-aa4e-6a16d936fc6a@arm.com>
 <20200330095707.GA10432@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330095707.GA10432@bogus>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Mar 30, 2020 at 11:13:21AM +0100, Sudeep Holla wrote:
> On Fri, Mar 27, 2020 at 07:40:25PM +0000, Robin Murphy wrote:
> > On 2020-03-27 5:56 pm, Naresh Kamboju wrote:
> > > The kernel warning noticed on arm64 juno-r2 device running linux
> > > next-20200326 and next-20200327
> >
> > I suspect this is the correct expected behaviour manifesting. If you're
> > using the upstream juno-r2.dts, the power domain being waited for here is
> > provided by SCPI, however unless you're using an SCP firmware from at least
> > 3 years ago you won't actually have SCPI since they switched it to the newer
> > SCMI protocol, which is not yet supported upstream for Juno. See what
> > happened earlier in the log:
> >
> > [    2.741206] scpi_protocol scpi: incorrect or no SCP firmware found
> > [    2.747586] scpi_protocol: probe of scpi failed with error -110
> >
> > Thus this is the "waiting for a dependency which will never appear" case,
> > for which I assume the warning is intentional,
> 
> Is that the case ?
> 
> Previously we used to get the warning:
> "amba xx: ignoring dependency for device, assuming no driver"
> 
> Now we have the kernel warning in addition to the above.
> 
> > since the system is essentially broken (i.e. the hardware/firmware doesn't
> > actually match what the DT describes).
> >
> 
> Not sure if we can term it as "essentially broken". Definitely not 100%
> functional but not broken if the situation like on Juno where SCP firmware
> is fundamental for all OSPM but not essential for boot and other minimum
> set of functionality.
> 
> Either way I am not against the warning, just wanted to get certain things
> clarified myself.

How this warning related to the patch in the subject? Does revert of the patch
gives you no warning? (I will be very surprised).

-- 
With Best Regards,
Andy Shevchenko


