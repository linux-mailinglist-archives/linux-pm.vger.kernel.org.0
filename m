Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEA86197CEA
	for <lists+linux-pm@lfdr.de>; Mon, 30 Mar 2020 15:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbgC3N3f (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Mar 2020 09:29:35 -0400
Received: from foss.arm.com ([217.140.110.172]:53712 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726548AbgC3N3f (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 30 Mar 2020 09:29:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 66730101E;
        Mon, 30 Mar 2020 06:29:34 -0700 (PDT)
Received: from [10.57.60.204] (unknown [10.57.60.204])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2F53F3F71E;
        Mon, 30 Mar 2020 06:29:32 -0700 (PDT)
Subject: Re: [PATCH v2 3/3] driver core: Replace open-coded list_last_entry()
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Basil Eljuse <Basil.Eljuse@arm.com>,
        lkft-triage@lists.linaro.org,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Ferry Toth <fntoth@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>
References: <20200324122023.9649-1-andriy.shevchenko@linux.intel.com>
 <20200324122023.9649-3-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0gg=V8uDd4afJ3MULsgKYvWajKJioANk4jj7xEhBzrRrQ@mail.gmail.com>
 <CA+G9fYvFnXqSnoQSJ-DkQvAFv87iWmhH6dT1N79qrq=Aeuv4rw@mail.gmail.com>
 <028b636f-6e0f-c36a-aa4e-6a16d936fc6a@arm.com> <20200330095707.GA10432@bogus>
 <0a374eaa-92b3-0201-f357-4181542c98b6@arm.com>
 <CAHp75VdBm8ZYOMWmQEA8LD6uGcJ0sZ=M6n3MSYxmO6UkXbu+-A@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <f2706518-def8-1566-149f-00fc1d8cc19f@arm.com>
Date:   Mon, 30 Mar 2020 14:29:30 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VdBm8ZYOMWmQEA8LD6uGcJ0sZ=M6n3MSYxmO6UkXbu+-A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2020-03-30 2:11 pm, Andy Shevchenko wrote:
> On Mon, Mar 30, 2020 at 3:49 PM Robin Murphy <robin.murphy@arm.com> wrote:
>> On 2020-03-30 11:13 am, Sudeep Holla wrote:
>>> On Fri, Mar 27, 2020 at 07:40:25PM +0000, Robin Murphy wrote:
> 
> ...
> 
>> AFAICS the difference is down to whether deferred_probe_timeout has
>> expired or not - I'm not familiar enough with this code to know
>> *exactly* what the difference is supposed to represent, nor which change
>> has actually pushed the Juno case from one state to the other (other
>> than it almost certainly can't be $SUBJECT - if this series is to blame
>> at all I'd assume it would be down to patch #1/3, but there's a bunch of
>> other rework previously queued in -next that is probably also interacting)
> 
> JFYI: patch #1/3 wasn't applied.

OK, so if anyone's invested enough to want to investigate, it must be 
something in John's earlier changes here:

https://lore.kernel.org/lkml/20200225050828.56458-1-john.stultz@linaro.org/

Thanks,
Robin.
