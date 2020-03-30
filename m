Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54490197CA6
	for <lists+linux-pm@lfdr.de>; Mon, 30 Mar 2020 15:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730266AbgC3NQw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Mar 2020 09:16:52 -0400
Received: from foss.arm.com ([217.140.110.172]:53396 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730191AbgC3NQw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 30 Mar 2020 09:16:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 964A030E;
        Mon, 30 Mar 2020 06:16:51 -0700 (PDT)
Received: from bogus (unknown [10.37.12.97])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4CD203F71E;
        Mon, 30 Mar 2020 06:16:49 -0700 (PDT)
Date:   Mon, 30 Mar 2020 14:16:46 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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
Message-ID: <20200330131646.GC20031@bogus>
References: <20200324122023.9649-1-andriy.shevchenko@linux.intel.com>
 <20200324122023.9649-3-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0gg=V8uDd4afJ3MULsgKYvWajKJioANk4jj7xEhBzrRrQ@mail.gmail.com>
 <CA+G9fYvFnXqSnoQSJ-DkQvAFv87iWmhH6dT1N79qrq=Aeuv4rw@mail.gmail.com>
 <028b636f-6e0f-c36a-aa4e-6a16d936fc6a@arm.com>
 <20200330095707.GA10432@bogus>
 <20200330104340.GO1922688@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330104340.GO1922688@smile.fi.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Mar 30, 2020 at 01:43:40PM +0300, Andy Shevchenko wrote:

[...]

>
> How this warning related to the patch in the subject? Does revert of the patch
> gives you no warning? (I will be very surprised).
>

I did a quick check reverting the $subject patch and it doesn't remove
extra warning. Sorry for the noise, I assumed so hastily, I was wrong.

--
Regards,
Sudeep
