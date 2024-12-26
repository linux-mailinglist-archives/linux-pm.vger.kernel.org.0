Return-Path: <linux-pm+bounces-19754-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 879A19FCA84
	for <lists+linux-pm@lfdr.de>; Thu, 26 Dec 2024 12:28:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA50216304E
	for <lists+linux-pm@lfdr.de>; Thu, 26 Dec 2024 11:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689B31D4612;
	Thu, 26 Dec 2024 11:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="dsYy7Ozz"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CA51B86F6;
	Thu, 26 Dec 2024 11:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735212477; cv=none; b=I6X743VzfhfdyaveYrY9XylADj27N0RrNA+oLKhdvRhreK7ZdbO2biLYaTrunFP9FetWPaZ0usPZHo0XqbnXj7vD9DZfXYkwkUOSdYnKF3GQpMYiQGKnl2dte9YADed2Aq0lxdvRHN2BypvfVcS7s8Efi5KFJXpoCsGluJnc1QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735212477; c=relaxed/simple;
	bh=jk0VU4v1klmKX/2HLXtWmTQfpi1u60Ha3PA9FSqrB90=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c7e/yrtwrtDg5Vefxn6zY7EzPtf7b5NB6q56TSV5+ugEyRFTwGUaqbOjtyULwSOnb+wNVeO9hIBLDDeHSUMEhSCD09+pYYvXrm+jcXIF6H1RIh8RZkDE53xKewtvilrbI75UvyiH4sg9tkBEFUY8hdKVopDkarqGep9b3jIWfro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=dsYy7Ozz; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from localhost.localdomain (unknown [IPv6:2a02:2149:8b14:7c00:7f68:a54:8871:387f])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 78D802E005C1;
	Thu, 26 Dec 2024 13:27:43 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1735212464;
	bh=9wtaZnw1xMpPN2Hpqu4lXlfFiLOEZHktcrPAz/pEEBA=; h=From:To:Subject;
	b=dsYy7Ozz/z5AAVyZv52rFxhTszaZRu68azguySetM/6zMjANPm24e6TrKoy+JVfsX
	 wjKaSOht5eOQ60uYSvzVE1Vm5LFgxmYnHGARVEnSB25gGhPPPuOROP5yg2ToL4JFW3
	 N+HvOb25Ao9dK4WX1T2Sj9zu6oEVcCL5sJHnvcFc=
Authentication-Results: linux1587.grserver.gr;
	spf=pass (sender IP is 2a02:2149:8b14:7c00:7f68:a54:8871:387f) smtp.mailfrom=lkml@antheas.dev smtp.helo=localhost.localdomain
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
From: Antheas Kapenekakis <lkml@antheas.dev>
To: linux-hwmon@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Jean Delvare <jdelvare@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Joaquin Ignacio Aramendia <samsagax@gmail.com>,
	Derek J Clark <derekjohn.clark@gmail.com>,
	Kevin Greenberg <kdgreenberg234@protonmail.com>,
	Joshua Tam <csinaction@pm.me>,
	Parth Menon <parthasarathymenon@gmail.com>,
	Eileen <eileen@one-netbook.com>,
	Antheas Kapenekakis <lkml@antheas.dev>
Subject: [PATCH 00/10] hwmon: (oxpsensors) Add 2024 OneXPlayer line-up,
 add charge limiting and turbo LED, fix ABI
Date: Thu, 26 Dec 2024 12:27:30 +0100
Message-ID: <20241226112740.340804-1-lkml@antheas.dev>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <173521246418.10748.1646876848026847725@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

This three part series updates the oxpsensors module to bring it in line
with its Windows OneXPlayer counterpart. First, it adds support for all
2024 OneXPlayer handhelds and their special variants.

Then, it adds the new charge limiting and bypass features that were first
introduced in the X1 and retrofit to older OneXFly variants and for
controlling the turbo led found in the X1 models. For Bypass, it adds a new
bypass variant BypassS0 that is only active while the device is in the S0
state.

Finally, it performs a minor refactor by moving around switch statements
into their own functions, in order to allow for fixing the pwm1_enable ABI
in the final patch. Currently, pwm1_enable sets the fan to auto with the
value 0 and allows manual control with the value 1. This patch makes it
so 0 sets the fan to full speed, 1 sets the fan to manual control, and
2 sets the fan to auto. This requires both setting enable and the fan
speed when the enable sysfs is written to as 0, hence the refactor.

As this is a breaking ABI change and there is userspace software relying
on this previous behavior, the last patch also changes the /name of the
hwmon endpoint to "oxp_ec" from "oxpec" (mirroring WMI module conventions)
such that userspace software that relied on the previous behavior can be
retrofit to the new kernel while enabling correct functionality on old
and new kernels. Failing that, software that is not updated will just
stop controlling the fans, ensuring no malignant behavior.

As part of this series I also updated my userspace software [1] to work
with this change and verified it works correctly on both 6.12.6 and when
using this module on my X1.

To make testing possible this patch series is rebased on top of the tag
kernel-6.12.6 (hash e4cc9a13) on remote [2]. None of the files changed
in-between master and this tag, but in case this does not apply clean,
you can pull that remote or reference [3].

[1] https://github.com/hhd-dev/adjustor/commit/4b02087ae39bef39288f26431af0ec221da089c4
[2] https://gitlab.com/cki-project/kernel-ark
[3] https://github.com/hhd-dev/patchwork/tree/upstream/oxpsensors

Antheas Kapenekakis (10):
  hwmon: (oxp-sensors) Distinguish the X1 variants
  hwmon: (oxp-sensors) Add all OneXFly variants
  ABI: testing: sysfs-class-power: add BypassS0 charge_type
  hwmon: (oxp-sensors) Add charge threshold and bypass to OneXPlayer
  hwmon: (oxp-sensors) Rename ec group to tt_toggle
  hwmon: (oxp-sensors) Add turbo led support to X1 devices
  hwmon: (oxp-sensors) Move pwm_enable read to its own function
  hwmon: (oxp-sensors) Move pwm value read/write to separate functions
  hwmon: (oxp-sensors) Move fan speed read to separate function
  hwmon: (oxp-sensors) Adhere to sysfs-class-hwmon and enable pwm on 2

 Documentation/ABI/testing/sysfs-class-power |   6 +-
 drivers/hwmon/oxp-sensors.c                 | 647 ++++++++++++++++----
 2 files changed, 523 insertions(+), 130 deletions(-)

-- 
2.47.1


