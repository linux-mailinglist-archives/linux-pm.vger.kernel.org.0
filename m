Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20B05424070
	for <lists+linux-pm@lfdr.de>; Wed,  6 Oct 2021 16:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239163AbhJFOvh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Oct 2021 10:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239171AbhJFOvf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Oct 2021 10:51:35 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DAFAC061767;
        Wed,  6 Oct 2021 07:49:43 -0700 (PDT)
Date:   Wed, 6 Oct 2021 16:49:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1633531779;
        bh=wilfjwMGDzmiVTTyv4EBqKEWGybhxtRzIviaxmZd9Fc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EGep5WVYNJjg7hXw4/ovtbA+W8OevLRpxI5/TCn97W5HMayWQyINPOYsCup+F/1eB
         qxuykAsLvos01wKOwsts+Rj1SXQ0C26EsTuwqRih+I/7CxHWQ0nobTd+Ao3oBk+5EE
         /8Xy35I/omF9RcOchQdKRmbfojst4FTQVztq0FbA=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@weissschuh.net>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        =?utf-8?Q?Nicol=C3=B2?= Piazzalunga <nicolopiazzalunga@gmail.com>,
        linux-pm@vger.kernel.org,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        Thomas Koch <linrunner@gmx.net>,
        "smclt30p@gmail.com" <smclt30p@gmail.com>
Subject: Re: [RFC] add standardized attributes for force_discharge and
 inhibit_charge
Message-ID: <f2e99c38-2e2f-4777-8318-fb4dae6e8bf1@t-8ch.de>
References: <21569a89-8303-8573-05fb-c2fec29983d1@gmail.com>
 <77e39b3e-fa51-54fe-1898-4f43895ac2c6@redhat.com>
 <20211005162352.emaoveimhkp5uzfw@earth.universe>
 <06fa7a23-4dec-cba9-4e00-c00cf0bf9337@redhat.com>
 <20211005220630.zurfqyva44idnplu@earth.universe>
 <8cbf7671-d9ee-6bfc-d8fd-d360ccb2c595@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8cbf7671-d9ee-6bfc-d8fd-d360ccb2c595@redhat.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2021-10-06T10:10+0200, Hans de Goede wrote:
> Hi,
> 
> On 10/6/21 12:06 AM, Sebastian Reichel wrote:
> > Hi,
> > 
> > On Tue, Oct 05, 2021 at 08:01:12PM +0200, Hans de Goede wrote:
> >> Right, force-discharge automatically implies charging is
> >> being inhibited, so putting this in one file makes sense.
> >>
> >> Any suggestion for the name of the file?
> > 
> > Maybe like this?
> > 
> > ---------------------------------------------------------------------
> > What: /sys/class/power_supply/<supply_name>/charge_behaviour
> > Date: October 2021
> > Contact: linux-pm@vger.kernel.org
> > Description:
> >  Configure battery behaviour when a charger is being connected.
> > 
> >  Access: Read, Write
> > 
> >  Valid values:
> > 
> >  0: auto / no override
> >     When charger is connected battery should be charged
> >  1: force idle
> >     When charger is connected the battery should neither be charged
> >     nor discharged.
> >  2: force discharge
> >     When charger is connected the battery should be discharged
> >     anyways.
> > ---------------------------------------------------------------------
> 
> That looks good to me. Although I just realized that some hw may
> only support 1. or 2. maybe explicitly document this and that
> EOPNOTSUPP will be reported when the value is not supported
> (vs EINVAL for plain invalid values) ?

Would that not force a userspace applications to offer all possibilities to
the user only to tell them that it's not supported?
If the driver knows what is supported and what not it should make this
discoverable without actually performing the operation.

Maybe something along the lines of /sys/power/mem_sleep.

Thomas
