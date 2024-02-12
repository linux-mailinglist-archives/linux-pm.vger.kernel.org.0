Return-Path: <linux-pm+bounces-3839-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51883851D24
	for <lists+linux-pm@lfdr.de>; Mon, 12 Feb 2024 19:45:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 754921C21F3D
	for <lists+linux-pm@lfdr.de>; Mon, 12 Feb 2024 18:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2275B4E1C8;
	Mon, 12 Feb 2024 18:42:39 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCC34C63D;
	Mon, 12 Feb 2024 18:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707763359; cv=none; b=Q5hehO6TQprwc6rU8k/4Qk88AfmDvTf4j4R+XE7mGO2gKwLaWxqf1fCMYDnaPsX4or2sr3PrhpDaFK3X2bfIfvwBAbsbTDpz5Fc32kVGKf5p3EU8MGgbLWTHU3xiGD1JE4FdoK87ZTYakHCEpuEPB7LXeAJ/QLigAqxuVyUZ9Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707763359; c=relaxed/simple;
	bh=AZVaCsAriHLBfg1CD2bjELKhsNVl1DMTTJvKn6jlgmo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ecPSuY2QrzaeCpWXtaD0ZprFUpWRQdd1LdpA8ClWmny4IIXKu2N/Agu8yx+kl337DgXp4iYQVkVnaHeu8mV1gMVHW4m7wVqC7H0dylGAk8k7dsHwfzSrBWNI5UUHFt2NAKWVGarpHI0hY4EDvv2D42WAU80zaLMciCJHb2CaOco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.4.0)
 id eb00a7d99c467735; Mon, 12 Feb 2024 19:42:34 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id EE0EA669CF2;
	Mon, 12 Feb 2024 19:42:33 +0100 (CET)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Lukasz Luba <lukasz.luba@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>, netdev@vger.kernel.org,
 Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
 Miri Korenblit <miriam.rachel.korenblit@intel.com>,
 linux-wireless@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
Subject: [PATCH v2 0/9] thermal: Writable trip points handling rework
Date: Mon, 12 Feb 2024 19:25:03 +0100
Message-ID: <6017196.lOV4Wx5bFT@kreacher>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrudefgdduudegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepgeffhfdujeelhfdtgeffkeetudfhtefhhfeiteethfekvefgvdfgfeeikeeigfehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeduiedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhn
 rghrohdrohhrghdprhgtphhtthhopehsthgrnhhishhlrgifrdhgrhhushiikhgrsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=16 Fuz1=16 Fuz2=16

Hi Everyone,

This is an update of

https://lore.kernel.org/linux-pm/3232442.5fSG56mABF@kreacher/

fixing a few bugs and renaming the new trip point flags introduced by it.

The original description of the patch series is still applicable:

"The purpose of this patch series is to allow thermal zone creators
 to specify which properties (temperature or hysteresis) of which
 trip points can be set from user space via sysfs on a per-trip basis
 instead of passing writable trips masks to the thermal zone registration
 function which is both cumbersome and error prone and it doesn't even
 allow to request different treatment of different trip properties.

 The writable trip masks used today only affect trip temperatures (that is, if
 a trip point is in a writable trips mask, its temperature can be set via
 sysfs) and they only take effect if the CONFIG_THERMAL_WRITABLE_TRIPS kernel
 configuration option is set, which appears to be assumed by at least some
 of the drivers using writable trips masks.  Some other drivers using them
 simply select CONFIG_THERMAL_WRITABLE_TRIPS which pretty much defeats its
 purpose (and imx even sets this option in its defconfig).

 For this reasons, patch [1/9] removes CONFIG_THERMAL_WRITABLE_TRIPS and makes
 the writable trips masks always work.

 Moreover, trip hysteresis, which is not affected either by the writable trips
 masks or by CONFIG_THERMAL_WRITABLE_TRIPS, can only be set via sysfs if the
 .set_trip_hyst() operation is provided by the given thermal zone, but currently
 this thermal zone operation is used by no one, so effectively trip hysteresis
 cannot be set via sysfs at all.  This is not a problem for the majority of
 drivers that want trip temperatures to be set via sysfs, because they also
 don't want trip hysteresis to be changed for any trips (at least as far as I
 can say), but there are use cases in which it is desirable to be able to
 update trip hysteresis as well as trip temperature (for example see
 https://lore.kernel.org/linux-pm/20240106191502.29126-1-quic_manafm@quicinc.com/).
 Those use cases are not addressed here directly, but after this series
 addressing them should be relatively straightforward.

 Namely, patch [2/9] adds flags to struct thermal_trip and defines two of them
 to indicate whether or not setting the temperature or hysteresis of the given
 trip via sysfs is allowed.  If a writable trips mask is passed to
 thermal_zone_device_register_with_trips(), is it is used to set the
 "writable temperature" flag for the trips covered by it and that flag is
 then consulted by the thermal sysfs code.  The "writable hysteresis" trip
 flag is also taken into account by the thermal sysfs code, but it is not set
 automatically in any case.

 Patch [3/9] is based on the observation that the .set_trip_hyst() thermal zone
 operation is never used - it simply drops that callback from struct
 thermal_zone_device_ops and adjusts the code checking its presence.

 Patches [4-8/9] update drivers using writable trips masks to set the new
 "writable temperature" flag directly instead and some of them are simplified
 a bit as a result.  After these patches, all of the callers of
 thermal_zone_device_register_with_trips() pass a zero writable trips mask
 to it, so patch [9/9] drops that mask from the functions argument list and
 adjusts all of its callers accordingly.

 After all of the changes in this series, allowing the hysteresis value to be
 set via sysfs for a given trip is a matter of setting its "writable
 hysteresis" flag (and analogously for trip temperature)."

Thanks!




