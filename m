Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA3FC19789B
	for <lists+linux-pm@lfdr.de>; Mon, 30 Mar 2020 12:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728739AbgC3KNd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Mar 2020 06:13:33 -0400
Received: from foss.arm.com ([217.140.110.172]:49108 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728257AbgC3KNd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 30 Mar 2020 06:13:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3AAAC31B;
        Mon, 30 Mar 2020 03:13:32 -0700 (PDT)
Received: from bogus (unknown [10.37.12.97])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CA8EF3F52E;
        Mon, 30 Mar 2020 03:13:28 -0700 (PDT)
Date:   Mon, 30 Mar 2020 11:13:21 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Basil Eljuse <Basil.Eljuse@arm.com>,
        lkft-triage@lists.linaro.org,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        fntoth@gmail.com, Arnd Bergmann <arnd@arndb.de>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Anders Roxell <anders.roxell@linaro.org>
Subject: Re: Re: [PATCH v2 3/3] driver core: Replace open-coded
 list_last_entry()
Message-ID: <20200330095707.GA10432@bogus>
References: <20200324122023.9649-1-andriy.shevchenko@linux.intel.com>
 <20200324122023.9649-3-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0gg=V8uDd4afJ3MULsgKYvWajKJioANk4jj7xEhBzrRrQ@mail.gmail.com>
 <CA+G9fYvFnXqSnoQSJ-DkQvAFv87iWmhH6dT1N79qrq=Aeuv4rw@mail.gmail.com>
 <028b636f-6e0f-c36a-aa4e-6a16d936fc6a@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <028b636f-6e0f-c36a-aa4e-6a16d936fc6a@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Mar 27, 2020 at 07:40:25PM +0000, Robin Murphy wrote:
> On 2020-03-27 5:56 pm, Naresh Kamboju wrote:
> > The kernel warning noticed on arm64 juno-r2 device running linux
> > next-20200326 and next-20200327
>
> I suspect this is the correct expected behaviour manifesting. If you're
> using the upstream juno-r2.dts, the power domain being waited for here is
> provided by SCPI, however unless you're using an SCP firmware from at least
> 3 years ago you won't actually have SCPI since they switched it to the newer
> SCMI protocol, which is not yet supported upstream for Juno. See what
> happened earlier in the log:
>
> [    2.741206] scpi_protocol scpi: incorrect or no SCP firmware found
> [    2.747586] scpi_protocol: probe of scpi failed with error -110
>
> Thus this is the "waiting for a dependency which will never appear" case,
> for which I assume the warning is intentional,

Is that the case ?

Previously we used to get the warning:
"amba xx: ignoring dependency for device, assuming no driver"

Now we have the kernel warning in addition to the above.

> since the system is essentially broken (i.e. the hardware/firmware doesn't
> actually match what the DT describes).
>

Not sure if we can term it as "essentially broken". Definitely not 100%
functional but not broken if the situation like on Juno where SCP firmware
is fundamental for all OSPM but not essential for boot and other minimum
set of functionality.

Either way I am not against the warning, just wanted to get certain things
clarified myself.

--
Regards,
Sudeep
