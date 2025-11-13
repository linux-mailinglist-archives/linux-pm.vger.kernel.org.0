Return-Path: <linux-pm+bounces-37954-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EEDA5C57474
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 12:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3CDE04E3109
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 11:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A36234D911;
	Thu, 13 Nov 2025 11:56:15 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13F434B186;
	Thu, 13 Nov 2025 11:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763034974; cv=none; b=jJljM352cBIDA5EMgZc02v8OP61bWngEycK44UTGH8mLHFh9wBJbeJr8u0PkH0WtHW0E9Ie0zNuSVLKV2MFMTlRGEgPdrf66p9Rz5rFz/gIrZugD60e+wUZQjlviwM07Sf2x9xMI8oiEyWFNmah4Qsc1snH2HGQLWNreF5TIaKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763034974; c=relaxed/simple;
	bh=mu6KsYLk3gqGxKjE6WtBf8pesH+jfo9fAeTNW9JO4z8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=heJIYJPnAVWJ3yfQ83Y8A7gF2Q90yhtg0Fg0c1AeRkBpkWx97uPta4aJdMboMk55utDdwAzJXR+dveTCaRsKGMDr6QGwuydANhB3+ZTpz+TM9/BDc4pY3mvvvebkUZb0daRXoEzv9ClvlVJTktCEkqqATl/isK8694lsvzMGchk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id C2624431F3;
	Thu, 13 Nov 2025 11:56:03 +0000 (UTC)
Message-ID: <dd5d8e8ca634724ab4f77ac2ed8ab56956551bc3.camel@hadess.net>
Subject: Re: [RFC PATCH v2 1/3] HID: input: Introduce struct hid_battery
From: Bastien Nocera <hadess@hadess.net>
To: Benjamin Tissoires <bentiss@kernel.org>, Lucas Zampieri
	 <lzampier@redhat.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Kosina
	 <jikos@kernel.org>, Sebastian Reichel <sre@kernel.org>, 
	linux-pm@vger.kernel.org
Date: Thu, 13 Nov 2025 12:56:03 +0100
In-Reply-To: <tuya626zqiabd6ejwbaafj4cq3nlngc2vzvvjwdl3rc5wkwhhh@2k6ehu62tviu>
References: <20251113001508.713574-1-lzampier@redhat.com>
	 <20251113001508.713574-2-lzampier@redhat.com>
	 <tuya626zqiabd6ejwbaafj4cq3nlngc2vzvvjwdl3rc5wkwhhh@2k6ehu62tviu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdeikeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkuffhvfevffgjfhgtgfgfggesthhqredttderjeenucfhrhhomhepuegrshhtihgvnhcupfhotggvrhgruceohhgruggvshhssehhrgguvghsshdrnhgvtheqnecuggftrfgrthhtvghrnhepieffgfehtedtgefgjeeggfffgeeuvdegveekveejfeekkedujeehteffueefffeunecukfhppedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfedphhgvlhhopeglkffrvheimedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfegnpdhmrghilhhfrhhomhephhgruggvshhssehhrgguvghsshdrnhgvthdpnhgspghrtghpthhtohepjedprhgtphhtthhopegsvghnthhishhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehliigrmhhpihgvrhesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhinhhugidqihhnphhuthesvhhgvghrrdhkv
 ghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjihhkohhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrhgvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: hadess@hadess.net

On Thu, 2025-11-13 at 11:47 +0100, Benjamin Tissoires wrote:
> On Nov 13 2025, Lucas Zampieri wrote:
> > Add struct hid_battery to encapsulate battery state per HID device.
> > This structure will allow tracking individual battery properties
> > including capacity, min/max values, report information, and status.
> >=20
> > The structure includes a list node to enable support for multiple
> > batteries per device in subsequent patches.
> >=20
> > This is a preparation step for transitioning from direct
> > power_supply
> > access to a more flexible battery management system.
> >=20
> > Signed-off-by: Lucas Zampieri <lzampier@redhat.com>
> > ---
> > =C2=A0include/linux/hid.h | 30 ++++++++++++++++++++++++++++++
>=20
> I know Bastien asked you to split out this into a separate commit,
> but I
> hate having a header change when noone uses it. It is painful for
> people
> needing to backport the further changes (imagine you are fixing a CVE
> without noticing it), as they also need to pull this one.

I usually find that a stand-alone "this can't possibly introduce bugs"
commit to be better (and it makes it easier to concentrate on smaller
amounts of content).

For the CVE use case, I don't really understand the problem. Either you
forget to backport the commit that added the type, in which case it
just doesn't compile, or you can backport the whole series (I would
hope that there's enough metadata in the kernel git to figure that out,
isn't there?).

In any case, your subsystem, your rules, just thought I'd mention why I
asked Lucas to split this up.

Cheers

>=20
> > =C2=A01 file changed, 30 insertions(+)
> >=20
> > diff --git a/include/linux/hid.h b/include/linux/hid.h
> > index a4ddb94e3ee5..63422130de20 100644
> > --- a/include/linux/hid.h
> > +++ b/include/linux/hid.h
> > @@ -634,6 +634,36 @@ enum hid_battery_status {
> > =C2=A0	HID_BATTERY_REPORTED,		/* Device sent unsolicited
> > battery strength report */
> > =C2=A0};
> > =C2=A0
> > +/**
> > + * struct hid_battery - represents a single battery power supply
> > + * @list: list node for linking into hid_device's battery list
>=20
> For the first inclusion of the new struct, please drop the list
> field.
> This should go into the last patch when you actually make use of it.
>=20
> > + * @dev: pointer to the parent hid_device
> > + * @ps: the power supply device
> > + * @capacity: current battery capacity
> > + * @min: minimum battery value
> > + * @max: maximum battery value
> > + * @report_type: type of report (HID_INPUT_REPORT,
> > HID_FEATURE_REPORT)
> > + * @report_id: report ID for this battery
> > + * @charge_status: current charge status
> > + * @status: battery status (unknown, queried, reported)
> > + * @avoid_query: if true, don't query battery (wait for device
> > reports)
> > + * @ratelimit_time: time for rate limiting battery updates
> > + */
> > +struct hid_battery {
> > +	struct list_head list;
> > +	struct hid_device *dev;
> > +	struct power_supply *ps;
> > +	__s32 capacity;
> > +	__s32 min;
> > +	__s32 max;
> > +	__s32 report_type;
> > +	__s32 report_id;
> > +	__s32 charge_status;
> > +	enum hid_battery_status status;
> > +	bool avoid_query;
> > +	ktime_t ratelimit_time;
> > +};
> > +
> > =C2=A0struct hid_driver;
> > =C2=A0struct hid_ll_driver;
> > =C2=A0
> > --=20
> > 2.51.1
> >=20
>=20
> Cheers,
> Benjamin

