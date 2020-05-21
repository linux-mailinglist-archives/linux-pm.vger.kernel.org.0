Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07A541DD6C9
	for <lists+linux-pm@lfdr.de>; Thu, 21 May 2020 21:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729856AbgEUTLg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 May 2020 15:11:36 -0400
Received: from mga11.intel.com ([192.55.52.93]:19619 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729600AbgEUTLf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 21 May 2020 15:11:35 -0400
IronPort-SDR: maLjh0r2EZlqqjIjIriJ+oUX0H682Zgx+FEfV0VdNBzwLC2/lZJVfzHqRt9vPJyup9FaQ6tyac
 DKBZaHMydaLA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2020 12:11:34 -0700
IronPort-SDR: M2uM81xHsIDBAngYqcyS5CezqP/4gMRRL2Po6CAnz7jzgwtwBnjoEFPQVngT9UVeUmAteoNyei
 xWkHjXDaLfcw==
X-IronPort-AV: E=Sophos;i="5.73,418,1583222400"; 
   d="scan'208";a="309143304"
Received: from spandruv-mobl.amr.corp.intel.com ([10.254.97.114])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2020 12:11:24 -0700
Message-ID: <8f8731690b52266cf87050844e34af93349b54df.camel@linux.intel.com>
Subject: Re: [RFC][PATCH 3/5] thermal: Add support for setting notification
 thresholds
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Amit Kucheria <amit.kucheria@verdurent.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Date:   Thu, 21 May 2020 12:11:12 -0700
In-Reply-To: <CAHLCerOsZrrZYcRLH+iZFT9FPL8zfmy2Y-Py6f61YXUrMrkcbg@mail.gmail.com>
References: <20200504181616.175477-1-srinivas.pandruvada@linux.intel.com>
         <20200504181616.175477-4-srinivas.pandruvada@linux.intel.com>
         <a9af415d-9fd0-dcea-79ee-0fb90f45045e@linaro.org>
         <2cd6c73b890b3eab12420adf4ae29101672e6a0b.camel@linux.intel.com>
         <CAHLCerMfnHPuJnj6G4EvRPvODf1_Se4xM-OobA1o7eao5eetzg@mail.gmail.com>
         <703fcf3b2b6769f5e469f0b035846ee95193ef7d.camel@linux.intel.com>
         <CAHLCerOsZrrZYcRLH+iZFT9FPL8zfmy2Y-Py6f61YXUrMrkcbg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Amit,

On Thu, 2020-05-21 at 10:41 +0530, Amit Kucheria wrote:
> Hi Srinivas,
> 
> On Wed, May 20, 2020 at 11:46 PM Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
> > On Wed, 2020-05-20 at 09:58 +0530, Amit Kucheria wrote:
> > > On Tue, May 19, 2020 at 5:10 AM Srinivas Pandruvada
> > > <srinivas.pandruvada@linux.intel.com> wrote:
> > > > On Mon, 2020-05-18 at 18:37 +0200, Daniel Lezcano wrote:
> > > > > On 04/05/2020 20:16, Srinivas Pandruvada wrote:
> > > > > > Add new attributes in thermal syfs when a thermal drivers
> > > > > > provides
> > > > > > callbacks for them and CONFIG_THERMAL_USER_EVENT_INTERFACE
> > > > > > is
> > > > > > defined.
> > > > > > 
> > > > > > These attribute allow user space to stop polling for
> > > > > > temperature.
> > > > > > 
> > > > > > These attributes are:
> > > > > > - temp_thres_low: Specify a notification temperature for a
> > > > > > low
> > > > > > temperature threshold event.
> > > > > > temp_thres_high: Specify a notification temperature for a
> > > > > > high
> > > > > > temperature threshold event.
> > > > > > temp_thres_hyst: Specify a change in temperature to send
> > > > > > notification
> > > > > > again.
> > > > > > 
> > > > > > This is implemented by adding additional sysfs attribute
> > > > > > group.
> > > > > > The
> > > > > > changes in this patch are trivial to add new attributes in
> > > > > > thermal
> > > > > > sysfs as done for other attributes.
> > > > > 
> > > > > Isn't it duplicate with the trip point?
> > > > A trip point is where an in-kernel governor takes some action.
> > > > This
> > > > is
> > > > not same as a notification temperature. For example at trip
> > > > point
> > > > configured by ACPI at 85C, the thermal governor may start
> > > > aggressive
> > > > throttling.
> > > > But a user space can set a notification threshold at 80C and
> > > > start
> > > > some
> > > > active controls like activate some fan to reduce the impact of
> > > > passive
> > > > control on performance.
> > > 
> > > Then what is the use of thermal trip type "ACTIVE" ?
> > This is an example.
> > The defaults are set by the OEMs via ACPI. User can't modify that
> > if
> > they want to optimize for their usage on Linux. There are fan
> > control
> > daemon's which user use on top.
> 
> -ENOPARSE. Are you saying users "can" modify these?

Most of the x86 laptops will not have an active trip as the fan control
is done by embedded controller. This is a safety and regulatory issue.
Even when you have an active trip it will be read only and also ACPI
fan cooling device will have few fix states to control.

There are fine grain controls on top are available outside of thermal
drivers via hwmon or others.
https://wiki.archlinux.org/index.php/Fan_speed_control#ThinkPad_laptops

Like in thermald we have XML config, which can be used to set different
speed levels at different temperatures. Instead of polling of
temperature, these attributes allow notification of temperature
threshold. We currently mimic this behavior via adding a RW passive
trip (The RW passive trips has a well defined usage different than what
we are using for).
There can be already existing RO passive/active trips in that zone
already bound to some cooling device. So from user space we search for
some RW passive trip and hope this is will give notifications. This I
believe is a hack to use a fake trip point for notifications for
temperature thresholds.

Thanks,
Srinivas


> 
> In any case, how is what you described earlier not possible with an
> ACTIVE trip point directly wired to the fan as a cooling device or
> with a HOT trip point that causes the platform driver to send
> notification to userspace where a fan control daemon can do what it
> needs to?
> 
> Basically, I think the issue of polling is orthogonal to the
> introduction of the new attributes introduced in this patch and I
> don't understand the reason for these attributes from your commit
> description.
> 
> > > > We need a way to distinguish between temperature notification
> > > > threshold
> > > > and actual trip point. Changing a trip point means that user
> > > > wants
> > > > kernel to throttle at temperature.

