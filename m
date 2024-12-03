Return-Path: <linux-pm+bounces-18501-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A76BA9E2C33
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 20:42:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68703283B22
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 19:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07021F9F6C;
	Tue,  3 Dec 2024 19:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MYuNfr/a"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F847E0E8
	for <linux-pm@vger.kernel.org>; Tue,  3 Dec 2024 19:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733254953; cv=none; b=B/X+WYOIuqWUvLOweoTJHVd45LsnprXMnmAdws0sumZfVmQk5be4Q0osjPLy5oXwgwhthswc3+VYz46A90+KixnohyNxgQzEQd/btYGHWwbx9xfbfebQLnjW3dGreusMZYxeGY9XahkypvCDVQe3YPfeL/GKJhoYZ6yXJvCeRxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733254953; c=relaxed/simple;
	bh=REaIPkXCTynsZsk+XqxgWfCgB9lHOJRqwUIuqT7VvEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U6finaZbmHubeqoQEAUQpnFRZCCj8zPFkUYN4J2ebwxLIsa+5kqVAcVzhFm9lVZFyaM0guYC0dGazVx4Ii/He8og46YliDJopYTH86v+SHNgVNCSz3L1dbfBpUrtRKh373Lp1z2RY09HHtjiADcDXjjW7CB51ZFHoQJk5pd2oqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MYuNfr/a; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733254951; x=1764790951;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=REaIPkXCTynsZsk+XqxgWfCgB9lHOJRqwUIuqT7VvEE=;
  b=MYuNfr/aJzBpEAiicfFfQQWH+gDYuX07B2aggs99vNWpgVbx0Jm5+oeP
   pVsgJXqEIEDyj3LgINicygdwCbxTf7PYpWADjDaizAxdb8Sptl03Kdbh7
   Dg8cs9B/rEXtmCd4IZYfXDV1RoZDO4AAdV7lnqaBVxW6XhrvUPTyF9gA0
   28giUD9HniSL2gfCVqrBgW4h+dx4zn8dJMLp8Ozeij1FlVWXjwX+22R0Y
   CXq6hXr2YA+HPzr28mjjmmxT4AJbNgXT3D5GFE9HWV/N+SlJJkrSfbMa3
   TM7nCBvsDOPONn1npreaAOTFSJPfHWxx2nAvW8qAlsUyu9gwkwqaQHOuu
   w==;
X-CSE-ConnectionGUID: gPdJ4zaeQraPFfqp9XJmTw==
X-CSE-MsgGUID: kOTw4dYyQxaBeaadzNyugg==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="33746055"
X-IronPort-AV: E=Sophos;i="6.12,206,1728975600"; 
   d="scan'208";a="33746055"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 11:42:30 -0800
X-CSE-ConnectionGUID: V3Sk1IBwRQuPdTtUWDkUMA==
X-CSE-MsgGUID: N3UTuALYTuaes/aOwunXiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,206,1728975600"; 
   d="scan'208";a="97969656"
Received: from ldmartin-desk2.corp.intel.com (HELO ldmartin-desk2) ([10.125.108.15])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 11:42:29 -0800
Date: Tue, 3 Dec 2024 13:42:21 -0600
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: "Furquim, Ulisses" <ulisses.furquim@intel.com>
Cc: "Saarinen, Jani" <jani.saarinen@intel.com>, 
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>, "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>, 
	"Krogerus, Heikki" <heikki.krogerus@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	"Kurmi, Suresh Kumar" <suresh.kumar.kurmi@intel.com>, "Coelho, Luciano" <luciano.coelho@intel.com>, 
	"Nikula, Jani" <jani.nikula@intel.com>, 
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, 
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, 
	Sebastian Reichel <sebastian.reichel@collabora.com>, "Vivi, Rodrigo" <rodrigo.vivi@intel.com>
Subject: Re: Regression on linux-next (next-20241120) and drm-tip
Message-ID: <e6bc4n7do2wcdarvcuktndkohfr6psjrcjfnr42bdlq7zd2ort@hgak345jvrnj>
References: <5e405ad4-34d6-4507-978f-3d81d4af2455@t-8ch.de>
 <CAJZ5v0iXKvaxz-hmW2+qwTcSmtPJ23Hv04CMnmT=qPE0ytNwLg@mail.gmail.com>
 <56d574c6-6eab-4388-8cb8-70cd615a8941@t-8ch.de>
 <CAJZ5v0gFwu+6Cm7ORs7+TAc5jzXZRBO1uGcttBTTvK4OqT3Q6g@mail.gmail.com>
 <2ad31476-3f37-43cb-96cf-379d50d7b799@t-8ch.de>
 <SJ1PR11MB61295BDE8405A1A5FFC1CB7FB9362@SJ1PR11MB6129.namprd11.prod.outlook.com>
 <1ed0ba64-4e8d-416a-8718-34e7f045d443@t-8ch.de>
 <886084c8-2f5e-4f89-bd10-e9c2a24b0aea@t-8ch.de>
 <DM8PR11MB5655708BD0D1FAA569A3F010E0362@DM8PR11MB5655.namprd11.prod.outlook.com>
 <SJ0PR11MB5632ABF513064D2A9B76AF27E6362@SJ0PR11MB5632.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SJ0PR11MB5632ABF513064D2A9B76AF27E6362@SJ0PR11MB5632.namprd11.prod.outlook.com>

On Tue, Dec 03, 2024 at 05:24:27PM +0000, Furquim, Ulisses wrote:
>+Rodrigo
>________________________________
>From: Intel-gfx <intel-gfx-bounces@lists.freedesktop.org> on behalf of Saarinen, Jani <jani.saarinen@intel.com>
>Sent: Tuesday, December 3, 2024 8:22 AM
>To: Thomas Weißschuh <linux@weissschuh.net>; Borah, Chaitanya Kumar <chaitanya.kumar.borah@intel.com>; Krogerus, Heikki <heikki.krogerus@intel.com>
>Cc: Rafael J. Wysocki <rafael@kernel.org>; Kurmi, Suresh Kumar <suresh.kumar.kurmi@intel.com>; Coelho, Luciano <luciano.coelho@intel.com>; Nikula, Jani <jani.nikula@intel.com>; De Marchi, Lucas <lucas.demarchi@intel.com>; intel-gfx@lists.freedesktop.org <intel-gfx@lists.freedesktop.org>; intel-xe@lists.freedesktop.org <intel-xe@lists.freedesktop.org>; linux-pm@vger.kernel.org <linux-pm@vger.kernel.org>; Sebastian Reichel <sebastian.reichel@collabora.com>
>Subject: RE: Regression on linux-next (next-20241120) and drm-tip
>
>+@Krogerus, Heikki
>
>> -----Original Message-----
>> From: Thomas Weißschuh <linux@weissschuh.net>
>> Sent: Tuesday, 3 December 2024 18.08
>> To: Borah, Chaitanya Kumar <chaitanya.kumar.borah@intel.com>
>> Cc: Rafael J. Wysocki <rafael@kernel.org>; Kurmi, Suresh Kumar
>> <suresh.kumar.kurmi@intel.com>; Coelho, Luciano <luciano.coelho@intel.com>;
>> Saarinen, Jani <jani.saarinen@intel.com>; Nikula, Jani <jani.nikula@intel.com>;
>> De Marchi, Lucas <lucas.demarchi@intel.com>; intel-gfx@lists.freedesktop.org;
>> intel-xe@lists.freedesktop.org; linux-pm@vger.kernel.org; Sebastian Reichel
>> <sebastian.reichel@collabora.com>
>> Subject: Re: Regression on linux-next (next-20241120) and drm-tip
>>
>> On 2024-12-03 16:57:21+0100, Thomas Weißschuh wrote:
>> > On 2024-12-03 15:42:23+0000, Borah, Chaitanya Kumar wrote:
>> > >
>> > >
>> > > > -----Original Message-----
>> > > > From: Thomas Weißschuh <linux@weissschuh.net>
>> > > > Sent: Tuesday, December 3, 2024 8:20 PM
>> > > > To: Rafael J. Wysocki <rafael@kernel.org>
>> > > > Cc: Borah, Chaitanya Kumar <chaitanya.kumar.borah@intel.com>;
>> > > > Kurmi, Suresh Kumar <suresh.kumar.kurmi@intel.com>; Coelho,
>> > > > Luciano <luciano.coelho@intel.com>; Saarinen, Jani
>> > > > <jani.saarinen@intel.com>; Nikula, Jani <jani.nikula@intel.com>;
>> > > > De Marchi, Lucas <lucas.demarchi@intel.com>;
>> > > > intel-gfx@lists.freedesktop.org; intel- xe@lists.freedesktop.org;
>> > > > linux-pm@vger.kernel.org; Sebastian Reichel
>> > > > <sebastian.reichel@collabora.com>
>> > > > Subject: Re: Regression on linux-next (next-20241120) and drm-tip
>> > > >
>> > > > On 2024-12-03 15:33:21+0100, Rafael J. Wysocki wrote:
>> > > > > On Tue, Dec 3, 2024 at 1:04 PM Thomas Weißschuh
>> > > > <linux@weissschuh.net> wrote:
>> > > > > >
>> > > > > > On 2024-12-03 12:54:54+0100, Rafael J. Wysocki wrote:
>> > > > > > > On Tue, Dec 3, 2024 at 7:51 AM Thomas Weißschuh
>> > > > <linux@weissschuh.net> wrote:
>> > > > > > > >
>> > > > > > > > (+Cc Sebastian)
>> > > > > > > >
>> > > > > > > > Hi Chaitanya,
>> > > > > > > >
>> > > > > > > > On 2024-12-03 05:07:47+0000, Borah, Chaitanya Kumar wrote:
>> > > > > > > > > Hope you are doing well. I am Chaitanya from the linux
>> > > > > > > > > graphics team
>> > > > in Intel.
>> > > > > > > > >
>> > > > > > > > > This mail is regarding a regression we are seeing in our
>> > > > > > > > > CI runs[1] on
>> > > > linux-next repository.
>> > > > > > > >
>> > > > > > > > Thanks for the report.
>> > > > > > > >
>> > > > > > > > > Since the version next-20241120 [2], we are seeing the
>> > > > > > > > > following regression
>> > > > > > > > >
>> > > > > > > > > `````````````````````````````````````````````````````````````````````````````````
>> > > > > > > > > <4>[   19.990743] Oops: general protection fault, probably for non-
>> > > > canonical address 0xb11675ef8d1ccbce: 0000 [#1] PREEMPT SMP NOPTI
>> > > > > > > > > <4>[   19.990760] CPU: 21 UID: 110 PID: 867 Comm: prometheus-
>> > > > node Not tainted 6.12.0-next-20241120-next-20241120-gac24e26aa08f+
>> > > > #1
>> > > > > > > > > <4>[   19.990771] Hardware name: Intel Corporation Arrow Lake
>> > > > Client Platform/MTL-S UDIMM 2DPC EVCRB, BIOS
>> > > > MTLSFWI1.R00.4400.D85.2410100007 10/10/2024
>> > > > > > > > > <4>[   19.990782] RIP:
>> 0010:power_supply_get_property+0x3e/0xe0
>> > > > > > > > > ````````````````````````````````````````````````````````
>> > > > > > > > > `````` ``````````````````` Details log can be found in
>> > > > > > > > > [3].
>> > > > > > > > >
>> > > > > > > > > After bisecting the tree, the following patch [4] seems
>> > > > > > > > > to be the first
>> > > > "bad"
>> > > > > > > > > commit
>> > > > > > > > >
>> > > > > > > > > ````````````````````````````````````````````````````````
>> > > > > > > > > `````` ```````````````````````````````````````````
>> > > > > > > > > Commit 49000fee9e639f62ba1f965ed2ae4c5ad18d19e2
>> > > > > > > > > Author:     Thomas Weißschuh <mailto:linux@weissschuh.net>
>> > > > > > > > > AuthorDate: Sat Oct 5 12:05:03 2024 +0200
>> > > > > > > > > Commit:     Sebastian Reichel
>> > > > <mailto:sebastian.reichel@collabora.com>
>> > > > > > > > > CommitDate: Tue Oct 15 22:22:20 2024 +0200
>> > > > > > > > >     power: supply: core: add wakeup source inhibit by
>> > > > > > > > > power_supply_config
>> > > > > > > > > ````````````````````````````````````````````````````````
>> > > > > > > > > `````` ```````````````````````````````````````````
>> > > > > > > > >
>> > > > > > > > > This is now seen in our drm-tip runs as well. [5]
>> > > > > > > > >
>> > > > > > > > > Could you please check why the patch causes this
>> > > > > > > > > regression and
>> > > > provide a fix if necessary?
>> > > > > > > >
>> > > > > > > > I don't see how this patch can lead to this error.
>> > > > > > >
>> > > > > > > It looks like the cfg->no_wakeup_source access reaches
>> > > > > > > beyond the struct boundary for some reason.
>> > > > > >
>> > > > > > But the access to this field is only done in __power_supply_register().
>> > > > > > The error reports however don't show this function at all,
>> > > > > > they come from power_supply_uevent() and
>> > > > > > power_supply_get_property() by which time the call to
>> __power_supply_register() is long over.
>> > > > > >
>> > > > > > FWIW there is an uninitialized 'struct power_supply_config' in
>> > > > > > drivers/hid/hid-corsair-void.c. But I highly doubt the test
>> > > > > > machines are using that. (I'll send a patch later for it)
>> > > > >
>> > > > > So the only way I can think about in which the commit in
>> > > > > question may lead to the reported issues is that changing the
>> > > > > size of struct power_supply_config or its alignment makes an
>> > > > > unexpected functional difference somewhere.
>> > > >
>> > > > Indeed. I'd really like to see this issue reproduced with KASAN.
>> > > >
>> > > > > AFAICS, this commit cannot be reverted by itself, so which
>> > > > > commits on top of it need to be reverted in order to revert it cleanly?
>> > > >
>> > > > All the other patches from this series:
>> > > > https://lore.kernel.org/lkml/20241005-power-supply-no-wakeup-sourc
>> > > > e-v1-
>> > > > 0-1d62bf9bcb1d@weissschuh.net/
>> > > >
>> > > > Could you point me to the full boot log in the drm-tip CI?
>> > >
>> > > Here is the log for drm-tip CI
>> > >
>> > > https://intel-gfx-ci.01.org/tree/drm-tip/IGT_8136/bat-arls-5/boot0.t
>> > > xt
>> >
>> > Thanks!
>> >
>> > > I carried out another bisect and it points to the following commit
>> > >
>> > > commit 226ff2e681d006eada59a9693aa1976d4c15a7d4
>> > > Author: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>> > > Date:   Wed Nov 6 17:06:05 2024 +0200
>> > >
>> > >     usb: typec: ucsi: Convert connector specific commands to bitmaps
>> > >
>> > >     That allows the fields in those command data structures to
>> > >     be easily validated. If an unsupported field is accessed, a
>> > >     warning is generated.
>> >
>> > Suspicous: The bitmaps introduced in this commit are right before the
>> > psy and psy_desc members of 'struct ucsi_connector'.
>> > So any out-of-bounds writes into these members would corrupt those
>> > fields.
>> > A corrupted power_supply_desc would fit both reported stacktraces.
>>
>> struct ucsi_connector {
>>        ...
>>
>>         struct typec_capability typec_cap;
>>
>>        /* Cached command responses. */
>>        DECLARE_BITMAP(cap, UCSI_GET_CONNECTOR_CAPABILITY_SIZE);
>>        DECLARE_BITMAP(status, UCSI_GET_CONNECTOR_STATUS_SIZE);
>>
>> DECLARE_BITMAP() takes the size in number of *bits*
>>
>>         struct power_supply *psy;
>>         struct power_supply_desc psy_desc;
>>         u32 rdo;
>>
>>        ...
>> }
>>
>> static int ucsi_get_connector_status(struct ucsi_connector *con, bool conn_ack) {
>>        u64 command = UCSI_GET_CONNECTOR_STATUS |
>> UCSI_CONNECTOR_NUMBER(con->num);
>>        size_t size = min(UCSI_GET_CONNECTOR_STATUS_SIZE,
>> UCSI_MAX_DATA_LENGTH(con->ucsi));
>>        int ret;
>>
>>        ret = ucsi_send_command_common(con->ucsi, command, &con->status,
>> size, conn_ack);
>>
>> ucsi_send_command_common() takes the size in number of *bytes*.
>> This call corrupts psy and psy_desc in con.
>>
>>        return ret < 0 ? ret : 0;
>> }
>>
>> >
>> > > Reverting it seems to help locally. However, to confirm I have sent out a patch
>> to our "try-bot"


Yeah, I can confirm it fixes it for me too - I reverted both
"usb: typec: ucsi: Convert connector specific commands to bitmaps"       
"usb: typec: ucsi: Fix a missing bits to bytes conversion in ucsi_init()"

Looking at the patch and what the second commit is fixing it looks
suspicious.... adding some additional warnings shows e.g.:
ucsi_get_connector_status(). It's passing con->status as arg, but
size can be up to 152.

Considering UCSI_GET_CONNECTOR_STATUS_SIZE is used for DECLARE_BITMAP,
that's also bit-sized.  This fixes it for me, although it could also use
the BITS_TO_BYTES:

-----------8<-------------
diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index c435c0835744a..69caae84879e9 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -651,7 +651,8 @@ static void ucsi_unregister_altmodes(struct ucsi_connector *con, u8 recipient)
  static int ucsi_get_connector_status(struct ucsi_connector *con, bool conn_ack)
  {
  	u64 command = UCSI_GET_CONNECTOR_STATUS | UCSI_CONNECTOR_NUMBER(con->num);
-	size_t size = min(UCSI_GET_CONNECTOR_STATUS_SIZE, UCSI_MAX_DATA_LENGTH(con->ucsi));
+	size_t size = min(sizeof(con->status),
+			  UCSI_MAX_DATA_LENGTH(con->ucsi));
  	int ret;
  
  	ret = ucsi_send_command_common(con->ucsi, command, &con->status, size, conn_ack);
-----------8<-------------

Let me send that as a patch to the right mailing list.

Lucas De Marchi

