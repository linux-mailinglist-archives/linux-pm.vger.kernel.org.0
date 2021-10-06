Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27E5B424914
	for <lists+linux-pm@lfdr.de>; Wed,  6 Oct 2021 23:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239725AbhJFVlQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Oct 2021 17:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239651AbhJFVlI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Oct 2021 17:41:08 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C7AC061746;
        Wed,  6 Oct 2021 14:39:14 -0700 (PDT)
Date:   Wed, 6 Oct 2021 23:39:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1633556353;
        bh=1qAb2Niz1SCraMQINx1guoV8FQWObaMymyIyOyPR1eY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=inboIkRUaOVXJhvc9FWK7pMn3+/w+gvGbih7Qjvgz796xNrW3FjMIUtRp1riNvTB6
         wxYjpM6/eWo4/HN57O7za1NlXFRHWlzNCJmWDpVZ+PxSlr9HeW9qyFWgsbr3QBxUtz
         S3OPTAdFQqOYstvCrDV8oA62kOqo3o3EAY2bHEGM=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@weissschuh.net>
To:     Thomas Koch <linrunner@gmx.net>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        =?utf-8?Q?Nicol=C3=B2?= Piazzalunga <nicolopiazzalunga@gmail.com>,
        linux-pm@vger.kernel.org,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "smclt30p@gmail.com" <smclt30p@gmail.com>
Subject: Re: [RFC] add standardized attributes for force_discharge and
 inhibit_charge
Message-ID: <cdc45a93-dd17-4ff1-8ce7-9002ae6ae23b@t-8ch.de>
References: <77e39b3e-fa51-54fe-1898-4f43895ac2c6@redhat.com>
 <20211005162352.emaoveimhkp5uzfw@earth.universe>
 <06fa7a23-4dec-cba9-4e00-c00cf0bf9337@redhat.com>
 <20211005220630.zurfqyva44idnplu@earth.universe>
 <8cbf7671-d9ee-6bfc-d8fd-d360ccb2c595@redhat.com>
 <f2e99c38-2e2f-4777-8318-fb4dae6e8bf1@t-8ch.de>
 <04693bb2-9fd1-59fa-4c21-99848e8aa4c4@redhat.com>
 <20211006162834.ujxfcn7jjrdl4kjx@earth.universe>
 <9ec694b7-48a9-5d86-0970-daefdf204712@redhat.com>
 <10fe30d4-f076-0612-002b-8bdf4e0a1fd5@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <10fe30d4-f076-0612-002b-8bdf4e0a1fd5@gmx.net>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2021-10-06T21:24+0200, Thomas Koch wrote:
> Date: Wed, 6 Oct 2021 21:24:14 +0200
> From: Thomas Koch <linrunner@gmx.net>
> To: Hans de Goede <hdegoede@redhat.com>, Sebastian Reichel
>  <sebastian.reichel@collabora.com>
> Cc: Thomas Weißschuh <thomas@weissschuh.net>, Nicolò Piazzalunga
>  <nicolopiazzalunga@gmail.com>, linux-pm@vger.kernel.org,
>  "platform-driver-x86@vger.kernel.org"
>  <platform-driver-x86@vger.kernel.org>, "smclt30p@gmail.com"
>  <smclt30p@gmail.com>
> Subject: Re: [RFC] add standardized attributes for force_discharge and
>  inhibit_charge
> User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
>  Thunderbird/78.13.0
> 
> Hi,
> 
> On 06.10.21 19:47, Hans de Goede wrote:
> > Hi,
> > 
> > On 10/6/21 6:28 PM, Sebastian Reichel wrote:
> > > Hi,
> > > 
> > > On Wed, Oct 06, 2021 at 05:27:22PM +0200, Hans de Goede wrote:
> > > > On 10/6/21 4:49 PM, Thomas Weißschuh wrote:
> > > > > On 2021-10-06T10:10+0200, Hans de Goede wrote:
> > > > > > On 10/6/21 12:06 AM, Sebastian Reichel wrote:
> > > > > > > On Tue, Oct 05, 2021 at 08:01:12PM +0200, Hans de Goede wrote:
> > > > > > > > Right, force-discharge automatically implies charging is
> > > > > > > > being inhibited, so putting this in one file makes sense.
> > > > > > > > 
> > > > > > > > Any suggestion for the name of the file?
> > > > > > > 
> > > > > > > Maybe like this?
> > > > > > > 
> > > > > > > ---------------------------------------------------------------------
> > > > > > > What: /sys/class/power_supply/<supply_name>/charge_behaviour
> > > > > > > Date: October 2021
> > > > > > > Contact: linux-pm@vger.kernel.org
> > > > > > > Description:
> > > > > > >   Configure battery behaviour when a charger is being connected.
> > > > > > > 
> > > > > > >   Access: Read, Write
> > > > > > > 
> > > > > > >   Valid values:
> > > > > > > 
> > > > > > >   0: auto / no override
> > > > > > >      When charger is connected battery should be charged
> > > > > > >   1: force idle
> > > > > > >      When charger is connected the battery should neither be charged
> > > > > > >      nor discharged.
> > > > > > >   2: force discharge
> > > > > > >      When charger is connected the battery should be discharged
> > > > > > >      anyways.
> > > > > > > ---------------------------------------------------------------------
> > > > > > 
> > > > > > That looks good to me. Although I just realized that some hw may
> > > > > > only support 1. or 2. maybe explicitly document this and that
> > > > > > EOPNOTSUPP will be reported when the value is not supported
> > > > > > (vs EINVAL for plain invalid values) ?
> > > > > 
> > > > > Would that not force a userspace applications to offer all possibilities to
> > > > > the user only to tell them that it's not supported?
> > > > > If the driver knows what is supported and what not it should make this
> > > > > discoverable without actually performing the operation.
> > > > > 
> > > > > Maybe something along the lines of /sys/power/mem_sleep.
> > > > 
> > > > Good point, but something like /sys/power/mem_sleep works
> > > > very differently then how all the other power_supply properties work.
> > > 
> > > Actually we already use this format in power-supply for USB
> > > types, implemented in power_supply_show_usb_type().
> > > 
> > > > In general if something is supported or not on a psy class
> > > > device is communicated by the presence / absence of attributes.
> > > > 
> > > > So I think we should move back to having 2 separate attributes
> > > > for this after all; and group the 2 together in the doc and
> > > > document that enabling (setting to 1) one of force_charge /
> > > > inhibit_charge automatically clears the setting of the other.
> > > > 
> > > > Then the availability of the features can simply be probed
> > > > by checking for the presence of the property files.
> > > 
> > > If it's two files, then somebody needs to come up with proper
> > > names. Things like 'force_discharge' look sensible in this context,
> > > but on a system with two batteries (like some Thinkpads have) it
> > > is easy to confuse with "I want to discharge this battery before
> > > the other one (while no AC is connected)". > Ah I did not realize there was already some (read-only) precedence
> > for this in the psy subsystem.
> > 
> > Since there is precedence for this using
> > /sys/class/power_supply/<supply_name>/charge_behaviour
> > 
> > with an example contents of say:
> > 
> > [auto] inhibit-charge force-discharge
> > 
> > Works for me and having 1 file instead of 2 is better then
> > because this clearly encapsulates that inhibit-charge and
> > force-discharge are mutually exclusive.
> In fact they do not reset each other on ThinkPads. It's possible to
> 
> 1. set force_discharge=1 -- discharging commences
> 2. set inhibit_charge=1 -- discharging continues, force_discharge remains 1
> 3. set force_discharge=0 -- battery does not charge, inhibit_charge
> remains 1

But in the end there are only three states the user cares about, or?
(inhibit, force_discharge and normal)

So when selecting inhibit or force_discharge the driver itself can reset the
other option so the users do not have to care about the internal state of the
EC.

Thomas
