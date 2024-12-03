Return-Path: <linux-pm+bounces-18492-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 958D19E260A
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 17:08:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55817288CB6
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 16:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066D21F76AD;
	Tue,  3 Dec 2024 16:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="ZlfsdpYI"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCEF1E766E
	for <linux-pm@vger.kernel.org>; Tue,  3 Dec 2024 16:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733242081; cv=none; b=kVM2Cc/ggNEfBYAVlrRfw62ijQK5deUqzC0vSZTnTwTNFEktO7gARWJlxdFZpfhobH4UJsyuvZoorIqiKuHa/AD7uLPoVOa3Sj3O+z+deJmPQx5lgYk1NITT8ldz9xvDhvTZ/7zmwyGFIh28WBKjcNNo83DoRdjLEww4nvyteuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733242081; c=relaxed/simple;
	bh=/0y7SBDUVxqjtpxm9yML9VoV7Jgb8YxmRVDVpMdr7Rg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O8qcbp4C71+aCb6LHig5Mzd+xx2aoqapUOLG5GIjHYdQ8QOPl4PyC352zqKgVIMvErHi+8dBkKN0PSJE25a0xRu0Isnr1NVeMYVRxCVk4umdtAkBS7PMwUflGfuTroezXTSbLJvCLRtn62FYJhnvLT2sf1STaWt87srwmP6R//U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=ZlfsdpYI; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1733242076;
	bh=/0y7SBDUVxqjtpxm9yML9VoV7Jgb8YxmRVDVpMdr7Rg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZlfsdpYIpCbGFb9Xe9niae1ebWeO2rflwuwZdET77yomETPT9XQ8u5bMa2WtxLThQ
	 zRJcH9Z4dO6yDD5SYA4eZHulPnGbn+H61PhP9CE+D3G5G5QtWhZoTWVF3EAE1sfqWp
	 yfs/HwCisMXUjLlOLYu6Ex058pgSDjcy3Jk07LVo=
Date: Tue, 3 Dec 2024 17:07:55 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	"Kurmi, Suresh Kumar" <suresh.kumar.kurmi@intel.com>, "Coelho, Luciano" <luciano.coelho@intel.com>, 
	"Saarinen, Jani" <jani.saarinen@intel.com>, "Nikula, Jani" <jani.nikula@intel.com>, 
	"De Marchi, Lucas" <lucas.demarchi@intel.com>, 
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, 
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, 
	Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: Regression on linux-next (next-20241120) and drm-tip
Message-ID: <886084c8-2f5e-4f89-bd10-e9c2a24b0aea@t-8ch.de>
References: <SJ1PR11MB6129CCD82CD78D8EE6E27EF4B9362@SJ1PR11MB6129.namprd11.prod.outlook.com>
 <SJ1PR11MB612965ACA3E84745346F0400B9362@SJ1PR11MB6129.namprd11.prod.outlook.com>
 <5e405ad4-34d6-4507-978f-3d81d4af2455@t-8ch.de>
 <CAJZ5v0iXKvaxz-hmW2+qwTcSmtPJ23Hv04CMnmT=qPE0ytNwLg@mail.gmail.com>
 <56d574c6-6eab-4388-8cb8-70cd615a8941@t-8ch.de>
 <CAJZ5v0gFwu+6Cm7ORs7+TAc5jzXZRBO1uGcttBTTvK4OqT3Q6g@mail.gmail.com>
 <2ad31476-3f37-43cb-96cf-379d50d7b799@t-8ch.de>
 <SJ1PR11MB61295BDE8405A1A5FFC1CB7FB9362@SJ1PR11MB6129.namprd11.prod.outlook.com>
 <1ed0ba64-4e8d-416a-8718-34e7f045d443@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1ed0ba64-4e8d-416a-8718-34e7f045d443@t-8ch.de>

On 2024-12-03 16:57:21+0100, Thomas Weißschuh wrote:
> On 2024-12-03 15:42:23+0000, Borah, Chaitanya Kumar wrote:
> > 
> > 
> > > -----Original Message-----
> > > From: Thomas Weißschuh <linux@weissschuh.net>
> > > Sent: Tuesday, December 3, 2024 8:20 PM
> > > To: Rafael J. Wysocki <rafael@kernel.org>
> > > Cc: Borah, Chaitanya Kumar <chaitanya.kumar.borah@intel.com>; Kurmi,
> > > Suresh Kumar <suresh.kumar.kurmi@intel.com>; Coelho, Luciano
> > > <luciano.coelho@intel.com>; Saarinen, Jani <jani.saarinen@intel.com>;
> > > Nikula, Jani <jani.nikula@intel.com>; De Marchi, Lucas
> > > <lucas.demarchi@intel.com>; intel-gfx@lists.freedesktop.org; intel-
> > > xe@lists.freedesktop.org; linux-pm@vger.kernel.org; Sebastian Reichel
> > > <sebastian.reichel@collabora.com>
> > > Subject: Re: Regression on linux-next (next-20241120) and drm-tip
> > > 
> > > On 2024-12-03 15:33:21+0100, Rafael J. Wysocki wrote:
> > > > On Tue, Dec 3, 2024 at 1:04 PM Thomas Weißschuh
> > > <linux@weissschuh.net> wrote:
> > > > >
> > > > > On 2024-12-03 12:54:54+0100, Rafael J. Wysocki wrote:
> > > > > > On Tue, Dec 3, 2024 at 7:51 AM Thomas Weißschuh
> > > <linux@weissschuh.net> wrote:
> > > > > > >
> > > > > > > (+Cc Sebastian)
> > > > > > >
> > > > > > > Hi Chaitanya,
> > > > > > >
> > > > > > > On 2024-12-03 05:07:47+0000, Borah, Chaitanya Kumar wrote:
> > > > > > > > Hope you are doing well. I am Chaitanya from the linux graphics team
> > > in Intel.
> > > > > > > >
> > > > > > > > This mail is regarding a regression we are seeing in our CI runs[1] on
> > > linux-next repository.
> > > > > > >
> > > > > > > Thanks for the report.
> > > > > > >
> > > > > > > > Since the version next-20241120 [2], we are seeing the
> > > > > > > > following regression
> > > > > > > >
> > > > > > > > `````````````````````````````````````````````````````````````````````````````````
> > > > > > > > <4>[   19.990743] Oops: general protection fault, probably for non-
> > > canonical address 0xb11675ef8d1ccbce: 0000 [#1] PREEMPT SMP NOPTI
> > > > > > > > <4>[   19.990760] CPU: 21 UID: 110 PID: 867 Comm: prometheus-
> > > node Not tainted 6.12.0-next-20241120-next-20241120-gac24e26aa08f+
> > > #1
> > > > > > > > <4>[   19.990771] Hardware name: Intel Corporation Arrow Lake
> > > Client Platform/MTL-S UDIMM 2DPC EVCRB, BIOS
> > > MTLSFWI1.R00.4400.D85.2410100007 10/10/2024
> > > > > > > > <4>[   19.990782] RIP: 0010:power_supply_get_property+0x3e/0xe0
> > > > > > > > ``````````````````````````````````````````````````````````````
> > > > > > > > ``````````````````` Details log can be found in [3].
> > > > > > > >
> > > > > > > > After bisecting the tree, the following patch [4] seems to be the first
> > > "bad"
> > > > > > > > commit
> > > > > > > >
> > > > > > > > ``````````````````````````````````````````````````````````````
> > > > > > > > ```````````````````````````````````````````
> > > > > > > > Commit 49000fee9e639f62ba1f965ed2ae4c5ad18d19e2
> > > > > > > > Author:     Thomas Weißschuh <mailto:linux@weissschuh.net>
> > > > > > > > AuthorDate: Sat Oct 5 12:05:03 2024 +0200
> > > > > > > > Commit:     Sebastian Reichel
> > > <mailto:sebastian.reichel@collabora.com>
> > > > > > > > CommitDate: Tue Oct 15 22:22:20 2024 +0200
> > > > > > > >     power: supply: core: add wakeup source inhibit by
> > > > > > > > power_supply_config
> > > > > > > > ``````````````````````````````````````````````````````````````
> > > > > > > > ```````````````````````````````````````````
> > > > > > > >
> > > > > > > > This is now seen in our drm-tip runs as well. [5]
> > > > > > > >
> > > > > > > > Could you please check why the patch causes this regression and
> > > provide a fix if necessary?
> > > > > > >
> > > > > > > I don't see how this patch can lead to this error.
> > > > > >
> > > > > > It looks like the cfg->no_wakeup_source access reaches beyond the
> > > > > > struct boundary for some reason.
> > > > >
> > > > > But the access to this field is only done in __power_supply_register().
> > > > > The error reports however don't show this function at all, they come
> > > > > from power_supply_uevent() and power_supply_get_property() by which
> > > > > time the call to __power_supply_register() is long over.
> > > > >
> > > > > FWIW there is an uninitialized 'struct power_supply_config' in
> > > > > drivers/hid/hid-corsair-void.c. But I highly doubt the test machines
> > > > > are using that. (I'll send a patch later for it)
> > > >
> > > > So the only way I can think about in which the commit in question may
> > > > lead to the reported issues is that changing the size of struct
> > > > power_supply_config or its alignment makes an unexpected functional
> > > > difference somewhere.
> > > 
> > > Indeed. I'd really like to see this issue reproduced with KASAN.
> > > 
> > > > AFAICS, this commit cannot be reverted by itself, so which commits on
> > > > top of it need to be reverted in order to revert it cleanly?
> > > 
> > > All the other patches from this series:
> > > https://lore.kernel.org/lkml/20241005-power-supply-no-wakeup-source-v1-
> > > 0-1d62bf9bcb1d@weissschuh.net/
> > > 
> > > Could you point me to the full boot log in the drm-tip CI?
> > 
> > Here is the log for drm-tip CI
> > 
> > https://intel-gfx-ci.01.org/tree/drm-tip/IGT_8136/bat-arls-5/boot0.txt
> 
> Thanks!
> 
> > I carried out another bisect and it points to the following commit
> > 
> > commit 226ff2e681d006eada59a9693aa1976d4c15a7d4
> > Author: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > Date:   Wed Nov 6 17:06:05 2024 +0200
> > 
> >     usb: typec: ucsi: Convert connector specific commands to bitmaps
> > 
> >     That allows the fields in those command data structures to
> >     be easily validated. If an unsupported field is accessed, a
> >     warning is generated.
> 
> Suspicous: The bitmaps introduced in this commit are right before the
> psy and psy_desc members of 'struct ucsi_connector'.
> So any out-of-bounds writes into these members would corrupt those
> fields.
> A corrupted power_supply_desc would fit both reported stacktraces.

struct ucsi_connector {
	...

        struct typec_capability typec_cap;

       /* Cached command responses. */
       DECLARE_BITMAP(cap, UCSI_GET_CONNECTOR_CAPABILITY_SIZE);
       DECLARE_BITMAP(status, UCSI_GET_CONNECTOR_STATUS_SIZE);

DECLARE_BITMAP() takes the size in number of *bits*

        struct power_supply *psy;
        struct power_supply_desc psy_desc;
        u32 rdo;

	...
}

static int ucsi_get_connector_status(struct ucsi_connector *con, bool conn_ack)
{
	u64 command = UCSI_GET_CONNECTOR_STATUS | UCSI_CONNECTOR_NUMBER(con->num);
	size_t size = min(UCSI_GET_CONNECTOR_STATUS_SIZE, UCSI_MAX_DATA_LENGTH(con->ucsi));
	int ret;

	ret = ucsi_send_command_common(con->ucsi, command, &con->status, size, conn_ack);

ucsi_send_command_common() takes the size in number of *bytes*.
This call corrupts psy and psy_desc in con.

	return ret < 0 ? ret : 0;
}

> 
> > Reverting it seems to help locally. However, to confirm I have sent out a patch to our "try-bot"
> > 
> > https://patchwork.freedesktop.org/series/142049/
> > 
> > We can wait for its results.
> > 
> > Regards
> > 
> > Chaitanya
> > 

