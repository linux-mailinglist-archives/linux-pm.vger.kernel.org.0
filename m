Return-Path: <linux-pm+bounces-26673-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 095D1AAA428
	for <lists+linux-pm@lfdr.de>; Tue,  6 May 2025 01:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 918385A6881
	for <lists+linux-pm@lfdr.de>; Mon,  5 May 2025 23:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C28272E40;
	Mon,  5 May 2025 22:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VQyDDuNx"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85DD2FA7EF;
	Mon,  5 May 2025 22:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483943; cv=none; b=pZTd7ZQT9X/qkYDAREIz+wUp5Ozp+mohad81eBRbOwkPHaBi3ahJd9MiQqD6SAz3C93IgRtfwnhegjJNa2J7m1SbJfhjY0B/w+Kp+IFucjqgarVnx53CVbI/usbHGdYcnyUKCS6MfclfT/rg535lzpgaJJS83jY1tuTaqziDZ64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483943; c=relaxed/simple;
	bh=ZfPM/aHeq4ZfGih9em7jB1Wfp4SBiRBC5F7tjJW9MD0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CjlnCi+sfVncDl7PnaP3Ehk2TGfcLxpCc2SmC2qc5aLJS0Aaxj8vRWilQHOoqRYDXX61fGSjIpY3WqnXtce3uwMaHIDJ1Lg14ikqeyHcvcL+89M4QSr0Q38teTMrpheYCzwSirKQzTWvgTltPCbkJjLGMjp64wTAh5mqQcb3FZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VQyDDuNx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68726C4CEEF;
	Mon,  5 May 2025 22:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483943;
	bh=ZfPM/aHeq4ZfGih9em7jB1Wfp4SBiRBC5F7tjJW9MD0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VQyDDuNxFEGoro1Hv8UM/njllPPkBtKsijj9XQNvADkxM5BF+7Rr8gu0ymxuHW1De
	 Hvff6hEF5RHBLeCiI7q7RJQrXii5O2xO/z4MDDuJzBkkbanXEc2BP9+GOyD2TqokvA
	 cz5ag2GjHEbt60ZZEeLS1uuwMCm0NOk4NX+E+iKVQQLCBR1WCLb04w17ngiBMOjGQ9
	 EKGRjgbI0RVqxvVZZECjlml/sHL0177zDkTe3UjDhjHHMs2WpxP2aL+u4v5QJ1UNWT
	 NHVHYW81AhbeM55UaIZ7M2eSgPaFgkvZSH7icuvyqgyllP9DkTm7bSYgjMRCJGbHNL
	 7KOwvAJMUWEFw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Xu Yang <xu.yang_2@nxp.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	len.brown@intel.com,
	pavel@kernel.org,
	gregkh@linuxfoundation.org,
	dakr@kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 282/642] PM: sleep: Suppress sleeping parent warning in special case
Date: Mon,  5 May 2025 18:08:18 -0400
Message-Id: <20250505221419.2672473-282-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Xu Yang <xu.yang_2@nxp.com>

[ Upstream commit e8195f0630f1c4c2465074fe81b5fda19efd3148 ]

Currently, if power.no_callbacks is set, device_prepare() will also set
power.direct_complete for the device.  If power.direct_complete is set
in device_resume(), the clearing of power.is_prepared will be skipped
and if new children appear under the device at that point, a warning
will be printed.

After commit (f76b168b6f11 PM: Rename dev_pm_info.in_suspend to
is_prepared), power.is_prepared is generally cleared in device_resume()
before invoking the resume callback for the device which allows that
callback to add new children without triggering the warning, but this
does not happen for devices with power.direct_complete set.

This problem is visible in USB where usb_set_interface() can be called
before device_complete() clears power.is_prepared for interface devices
and since ep devices are added then, the warning is printed:

 usb 1-1: reset high-speed USB device number 3 using ci_hdrc
  ep_81: PM: parent 1-1:1.1 should not be sleeping
 PM: resume devices took 0.936 seconds

Since it is legitimate to add the ep devices at that point, the
warning above is not particularly useful, so get rid of it by
clearing power.is_prepared in device_resume() for devices with
power.direct_complete set if they have no PM callbacks, in which
case they need not actually resume for the new children to work.

Suggested-by: Rafael J. Wysocki <rafael@kernel.org>
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
Link: https://patch.msgid.link/20250224070049.3338646-1-xu.yang_2@nxp.com
[ rjw: New subject, changelog edits, rephrased new code comment ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/power/main.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 23be2d1b04079..37fe251b4c591 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -933,6 +933,13 @@ static void device_resume(struct device *dev, pm_message_t state, bool async)
 		goto Complete;
 
 	if (dev->power.direct_complete) {
+		/*
+		 * Allow new children to be added under the device after this
+		 * point if it has no PM callbacks.
+		 */
+		if (dev->power.no_pm_callbacks)
+			dev->power.is_prepared = false;
+
 		/* Match the pm_runtime_disable() in device_suspend(). */
 		pm_runtime_enable(dev);
 		goto Complete;
-- 
2.39.5


