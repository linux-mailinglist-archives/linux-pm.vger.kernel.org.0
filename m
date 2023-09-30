Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5587B405A
	for <lists+linux-pm@lfdr.de>; Sat, 30 Sep 2023 14:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbjI3M4d (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 30 Sep 2023 08:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbjI3M4c (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 30 Sep 2023 08:56:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A79E6
        for <linux-pm@vger.kernel.org>; Sat, 30 Sep 2023 05:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696078590; x=1727614590;
  h=message-id:subject:from:to:date:in-reply-to:references:
   content-transfer-encoding:mime-version;
  bh=+jzxsnMthYf3WHNVyrLaqviqu8E/OxxZMPICmWOtaww=;
  b=hVdRQbSclq+Dxkst2EHxfEaqrFoyzZOPPQhuyINM79QogplMAyj9HBxm
   +B4Y/ACT2T7tETCvMO7oXz/aaRzu6vmAw5u/dZO8iMTrPEzbfqsVU87ra
   MA2n+S3QFaUsaJS/3PvU7aSKB5kL07FHmBLNLxWhPTlg2pnFNgVl4ybiB
   OzCsJFsizobtRS18pzlTWbMZ+mEAN7OSBPRrc0KMuHR8bQFQsC2njCt9g
   48FQRq/SurNujNkfXRrMHEzwE7pjfDozzVtz3Nw7YMDrlCRLJeg1yecvN
   BZe+VCuj4xn5yVmkaLfeZeyHsSrsv0TlZr9DUD0/LMt5F6TO129nvAuvS
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10849"; a="362699847"
X-IronPort-AV: E=Sophos;i="6.03,190,1694761200"; 
   d="scan'208";a="362699847"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2023 05:56:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10849"; a="815847069"
X-IronPort-AV: E=Sophos;i="6.03,190,1694761200"; 
   d="scan'208";a="815847069"
Received: from spandruv-desk.jf.intel.com (HELO spandruv-desk.amr.corp.intel.com) ([10.54.75.14])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2023 05:56:30 -0700
Message-ID: <af63ea6bbd769730a84bf91c6161cd2afd9955d6.camel@linux.intel.com>
Subject: Re: [RFC] docs: thermal/drivers/intel: Reading trip point
 previously set to 0
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Vasilis LIaskovitis <vliaskovitis@suse.com>,
        linux-pm@vger.kernel.org, rjw@rjwysocki.net
Date:   Sat, 30 Sep 2023 05:56:29 -0700
In-Reply-To: <d9b13ed7-e173-43f7-73c0-840014a6c4d4@suse.com>
References: <eaf4ab5f-2ce1-4e87-a31c-f2b5ebd15c19@suse.com>
         <d9b13ed7-e173-43f7-73c0-840014a6c4d4@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-3.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Vasilis,

On Thu, 2023-09-28 at 20:05 +0200, Vasilis LIaskovitis wrote:
> Hi,
>=20
> ping, any thoughts on this?
>=20
> > Since commit:
> > eb8500b8 "thermal/drivers/intel: Initialize RW trip to=20
> > THERMAL_TEMP_INVALID"
> >=20
> > writing 0 into thermal trip point temp sysfs files cannot be read
> > back:
> > ~ # echo 0=C2=A0 >=20
> > /sys/devices/virtual/thermal/thermal_zone1/trip_point_0_temp
> > ~ # cat
> > /sys/devices/virtual/thermal/thermal_zone1/trip_point_0_temp
> > -274000
> >=20
> > Prior to this change, the value 0 could be "read". Afaict only
> > because=20
> > 0 was always returned for uninitialized trip points, and not only
> > when=20
> > 0 was actually written into the trip_point_*_temp by userspace.
> >=20
> > A customer uses scripts to set the trip_point_*_temp value to 0,
> > and=20
> > then checks that the value is indeed 0. Their userspace test suite=20
> > breaks because of this change.
> >=20
> > Should userspace still be able to read the set value of 0 (meaning
> > the=20
> > thermal subsystem confirms no notifications will be sent)? I=20
> > understand this is a corner case (maybe it's even non-sensical to=20
> > check a value of 0 is returned, after setting it), but I wanted to
> > ask=20
> > since the sysfs value read by userspace is now
> > THERMAL_TEMP_INVALID.
> >=20
> > Or should we instead update documentation to reflect the fact that=20
> > uninitialized trip points and trip points set to 0 return an
> > invalid=20
> > value THERMAL_TEMP_INVALID? E.g.:
> >=20

I think better to update documentation, Please submit a change, if you
can.

Thanks,
Srinivas

> >=20
> > diff --git=20
> > a/Documentation/driver-api/thermal/x86_pkg_temperature_thermal.rst=20
> > b/Documentation/driver-api/thermal/x86_pkg_temperature_thermal.rst
> > index 2ac42ccd236f6..2e6f2728b5b94 100644
> > --- a/Documentation/driver-
> > api/thermal/x86_pkg_temperature_thermal.rst
> > +++ b/Documentation/driver-
> > api/thermal/x86_pkg_temperature_thermal.rst
> > @@ -43,8 +43,10 @@ User can set any temperature between 0 to TJ-Max
> > temperature. Temperature units
> > =C2=A0are in milli-degree Celsius. Refer to=20
> > "Documentation/driver-api/thermal/sysfs-api.rst" for
> > =C2=A0thermal sys-fs details.
> >=20
> > +An uninitialized trip_point_*_temp returns an invalid value=20
> > (THERMAL_TEMP_INVALID).
> > =C2=A0Any value other than 0 in these trip points, can trigger thermal=
=20
> > notifications.
> > -Setting 0, stops sending thermal notifications.
> > +Setting 0, stops sending thermal notifications. Having set 0, the=20
> > value returned by the
> > +trip point remains invalid (THERMAL_TEMP_INVALID).
> >=20
> > =C2=A0Thermal notifications:
> > =C2=A0To get kobject-uevent notifications, set the thermal zone
> >=20

