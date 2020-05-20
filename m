Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C90241DBC75
	for <lists+linux-pm@lfdr.de>; Wed, 20 May 2020 20:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbgETSQs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 May 2020 14:16:48 -0400
Received: from mga03.intel.com ([134.134.136.65]:36517 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726566AbgETSQs (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 20 May 2020 14:16:48 -0400
IronPort-SDR: gDbAchNiwHK19UtAx+ApftL1LK5Fa5N+C4OVh0AcQsBO0TCUKLYxXBIvIgtVNzkBlyePI6nvY2
 SlcW/bVSxEjA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2020 11:16:47 -0700
IronPort-SDR: ofFGhnpg3DUpJ9SIJyXv07e73SpxgvDhO9X0Jdqak6vhbQpUWzgUpbNM2bo0n61b22CsFbtdhQ
 Km+XHytHFrXg==
X-IronPort-AV: E=Sophos;i="5.73,414,1583222400"; 
   d="scan'208";a="440129382"
Received: from spandruv-mobl.amr.corp.intel.com ([10.255.228.34])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2020 11:16:47 -0700
Message-ID: <703fcf3b2b6769f5e469f0b035846ee95193ef7d.camel@linux.intel.com>
Subject: Re: [RFC][PATCH 3/5] thermal: Add support for setting notification
 thresholds
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Amit Kucheria <amit.kucheria@verdurent.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Date:   Wed, 20 May 2020 11:16:46 -0700
In-Reply-To: <CAHLCerMfnHPuJnj6G4EvRPvODf1_Se4xM-OobA1o7eao5eetzg@mail.gmail.com>
References: <20200504181616.175477-1-srinivas.pandruvada@linux.intel.com>
         <20200504181616.175477-4-srinivas.pandruvada@linux.intel.com>
         <a9af415d-9fd0-dcea-79ee-0fb90f45045e@linaro.org>
         <2cd6c73b890b3eab12420adf4ae29101672e6a0b.camel@linux.intel.com>
         <CAHLCerMfnHPuJnj6G4EvRPvODf1_Se4xM-OobA1o7eao5eetzg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 2020-05-20 at 09:58 +0530, Amit Kucheria wrote:
> On Tue, May 19, 2020 at 5:10 AM Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
> > On Mon, 2020-05-18 at 18:37 +0200, Daniel Lezcano wrote:
> > > On 04/05/2020 20:16, Srinivas Pandruvada wrote:
> > > > Add new attributes in thermal syfs when a thermal drivers
> > > > provides
> > > > callbacks for them and CONFIG_THERMAL_USER_EVENT_INTERFACE is
> > > > defined.
> > > > 
> > > > These attribute allow user space to stop polling for
> > > > temperature.
> > > > 
> > > > These attributes are:
> > > > - temp_thres_low: Specify a notification temperature for a low
> > > > temperature threshold event.
> > > > temp_thres_high: Specify a notification temperature for a high
> > > > temperature threshold event.
> > > > temp_thres_hyst: Specify a change in temperature to send
> > > > notification
> > > > again.
> > > > 
> > > > This is implemented by adding additional sysfs attribute group.
> > > > The
> > > > changes in this patch are trivial to add new attributes in
> > > > thermal
> > > > sysfs as done for other attributes.
> > > 
> > > Isn't it duplicate with the trip point?
> > A trip point is where an in-kernel governor takes some action. This
> > is
> > not same as a notification temperature. For example at trip point
> > configured by ACPI at 85C, the thermal governor may start
> > aggressive
> > throttling.
> > But a user space can set a notification threshold at 80C and start
> > some
> > active controls like activate some fan to reduce the impact of
> > passive
> > control on performance.
> 
> Then what is the use of thermal trip type "ACTIVE" ?
This is an example.
The defaults are set by the OEMs via ACPI. User can't modify that if
they want to optimize for their usage on Linux. There are fan control
daemon's which user use on top.

Thanks,
Srinivas

> 
> > We need a way to distinguish between temperature notification
> > threshold
> > and actual trip point. Changing a trip point means that user wants
> > kernel to throttle at temperature.

