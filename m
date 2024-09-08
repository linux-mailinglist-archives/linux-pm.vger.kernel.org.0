Return-Path: <linux-pm+bounces-13857-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A0A2970832
	for <lists+linux-pm@lfdr.de>; Sun,  8 Sep 2024 16:42:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FF091C214A0
	for <lists+linux-pm@lfdr.de>; Sun,  8 Sep 2024 14:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A9B170A39;
	Sun,  8 Sep 2024 14:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gssYXX+l"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268F1EACD;
	Sun,  8 Sep 2024 14:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725806550; cv=none; b=k3GDTp2iGagM/nr7Wxo8ous4HOe5Wg0E3TdvT9UKhjpw/WfkWj2Bb7FO4RMeGBxoo4DZaS4NUMymwb7nAIq6EN1cNC1Fwq8+Vsr2T83qqtctWA2emX1JvtWrjoVbS0FwELDEtV+nd2vYUJSxCBjy8fzxdm5Zc/C6VoxaBVUXawA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725806550; c=relaxed/simple;
	bh=5ueBFh6FnrnDNPBpwYqbTTAHKcFmDARYM4p9RCkGkNc=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=CVjqZn76r/1ZFiAGTHOdmYFZJ9voJg2IKZeKhr7kPtJglFdKJ8SrOnqDVgavSICqIZFUbxwQdjhNs8lBuHRC1Xr3YBiaD/lrLtheCBxpyRpry+ajo2ry1ncQgW1MCu8mGE6Vf9qY6vmRVsEn36TWbW77OTfzg0AdUVwyFtMsNDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gssYXX+l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 970E5C4CEC3;
	Sun,  8 Sep 2024 14:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725806549;
	bh=5ueBFh6FnrnDNPBpwYqbTTAHKcFmDARYM4p9RCkGkNc=;
	h=Date:From:To:Cc:Subject:From;
	b=gssYXX+lejHaAGxt7/jrLqTRVTMOmsGeU4b7+0lI1sa+Umf7J2HgbuKK0waMDX9vT
	 Jd4TULID1/+0BxxmxjQpA5NcoTAzYBP8ICyyjDzh2J0KS/opPqA8Mesammns+1EB39
	 t3Y9cWQ5tEUSYlYsi6bLAcN2Kse4UE5T+tdnHS/QZpJmYr856ajCfGLQyKurntGKWe
	 OdS4WvqYqeB4Qf0ydUuGH6EoHlJB9nkOPYtGnET2ooTLGqVGuGBeYhAZ1lUPix0BeE
	 eqLX4CoswsNBpq7SBRN7WqwNvu/ZAzlJ9wKfPJ+gBg4o6MZ6EyCOHBBI6uLCbl49uc
	 80BgnbyxcQtcA==
Message-ID: <a9d9f0ec-1744-4543-a190-138facf8c552@kernel.org>
Date: Sun, 8 Sep 2024 23:42:25 +0900
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Chanwoo Choi <chanwoo@kernel.org>
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "open list:DEVICE FREQUENCY (DEVFREQ)" <linux-pm@vger.kernel.org>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi <chanwoo@kernel.org>
Subject: GIT PULL] devfreq next for 6.12
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Dear Rafael,

This is devfreq-next pull request for v6.12. I add detailed description of
this pull request on the following tag. Please pull devfreq with
following updates.

Best Regards,
Chanwoo Choi

The following changes since commit 431c1646e1f86b949fa3685efc50b660a364c2b6:

  Linux 6.11-rc6 (2024-09-01 19:46:02 +1200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git tags/devfreq-next-for-6.12

for you to fetch changes up to d47552124bb0b9527da7a95357ae7d2e6046c4f6:

  PM / devfreq: imx-bus: Use of_property_present() (2024-09-05 01:23:56 +0900)

----------------------------------------------------------------
Update devfreq next for v6.12

Detailed description for this pull request:
- Add missing MODULE_DESCRIPTION() macros for devfreq governors.
- Use Use devm_clk_get_enabled() helpers for exyns-bus devfreq driver.
- Use of_property_present() instead of of_get_property() for imx-bus devfreq driver.
----------------------------------------------------------------
Anand Moon (1):
      PM / devfreq: exynos: Use Use devm_clk_get_enabled() helpers

Jeff Johnson (1):
      PM/devfreq: governor: add missing MODULE_DESCRIPTION() macros

Rob Herring (Arm) (1):
      PM / devfreq: imx-bus: Use of_property_present()

 drivers/devfreq/exynos-bus.c              | 22 +++++-----------------
 drivers/devfreq/governor_performance.c    |  1 +
 drivers/devfreq/governor_powersave.c      |  1 +
 drivers/devfreq/governor_simpleondemand.c |  1 +
 drivers/devfreq/governor_userspace.c      |  1 +
 drivers/devfreq/imx-bus.c                 |  2 +-
 6 files changed, 10 insertions(+), 18 deletions(-)

