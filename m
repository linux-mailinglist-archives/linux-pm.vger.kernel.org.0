Return-Path: <linux-pm+bounces-39794-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A65CCD7195
	for <lists+linux-pm@lfdr.de>; Mon, 22 Dec 2025 21:39:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B4723059524
	for <lists+linux-pm@lfdr.de>; Mon, 22 Dec 2025 20:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E7333C195;
	Mon, 22 Dec 2025 20:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jnluz/Zp"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7561F33B6E5;
	Mon, 22 Dec 2025 20:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766435839; cv=none; b=Mv2+3dTuex4uwQOi+OHxAQhwNdroKk67hzl6XKTpatQ7ROPQAHiurmzV3OlVg7TW4er5GNGeIUYMg44HTpmWpTqda0xPhKMGIzrhCGKvzdRv5lpXuQhadoJGhw7pyR6uOEUHqZMNSvxX/jilHu4rB4EeEURdUPF4ANQfIn6TNc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766435839; c=relaxed/simple;
	bh=QbzXfoaXOmMLMGZusixmDO7h0/cIemFlXGyOYaX0hqU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j5JpgB3jb2x79f/C+hwr9KMzQVCVS1590qcN1hC6t0eKXEcBUgbPz0f3KXX1D7RGueRz3LkNxICZGNyVuhzz+LKz7UhcKMeyTud38mRAzdRpWs/RL52/VGvqRWRwJAwpEnsARg+5N3dKOl5HNx+8qau3yUkD8XhJwXNwESp1Zo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jnluz/Zp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94AFCC4CEF1;
	Mon, 22 Dec 2025 20:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766435839;
	bh=QbzXfoaXOmMLMGZusixmDO7h0/cIemFlXGyOYaX0hqU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jnluz/ZpoOUeAeV5kE28mDQTda78EbxGqRAs5xCLeYDajajcXoVl1oyNwm9Oo4mTC
	 PjwMIK9xZDdhdemJc5fPjbSxQ7ZpLPSp2Z2Zyhykld5FZU8xdZbukN8bfSMp9EwjfN
	 1EK8x2kkyfe538uRBnB699EF3eP4ihJPDZJMpyTkNTwxBUfsc9nbx7xCfXAmDvrMvC
	 f1jozqckUUvc4nlUKVnsMUm7DQ0r3sHKsJcEJtVoK14p7q04eqHuZI6O+j8CjjKP3b
	 Kqolkm9Rw0K1e/F0gEtKylgRMnJ/J4xIgMxJbIeXYLZk1u6NpEZeviAZWk4UIKG8Ri
	 3fjwqOxxho80A==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Brian Norris <briannorris@chromium.org>,
 Dan Callaghan <dcallagh@chromium.org>,
 Sami =?ISO-8859-1?Q?Ky=F6stil=E4?= <skyostil@chromium.org>,
 Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>,
 chrome-platform@lists.linux.dev
Subject:
 [PATCH v1 18/23] platform/chrome: cros_hps_i2c: Discard pm_runtime_put()
 return value
Date: Mon, 22 Dec 2025 21:27:44 +0100
Message-ID: <2302270.NgBsaNRSFp@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <6245770.lOV4Wx5bFT@rafael.j.wysocki>
References: <6245770.lOV4Wx5bFT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Passing pm_runtime_put() return value to the callers is not particularly
useful.

Returning an error code from pm_runtime_put() merely means that it has
not queued up a work item to check whether or not the device can be
suspended and there are many perfectly valid situations in which that
can happen, like after writing "on" to the devices' runtime PM "control"
attribute in sysfs for one example.  It also happens when the kernel is
configured with CONFIG_PM unset.

Accordingly, update hps_release() to simply discard the return value of
pm_runtime_put() and always return success to the caller.

This will facilitate a planned change of the pm_runtime_put() return
type to void in the future.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

This patch is part of a series, but it doesn't depend on anything else
in that series.  The last patch in the series depends on it.

It can be applied by itself and if you decide to do so, please let me
know.

Otherwise, an ACK or equivalent will be appreciated, but also the lack
of specific criticism will be eventually regarded as consent.

---
 drivers/platform/chrome/cros_hps_i2c.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/platform/chrome/cros_hps_i2c.c
+++ b/drivers/platform/chrome/cros_hps_i2c.c
@@ -46,7 +46,9 @@ static int hps_release(struct inode *ino
 					       struct hps_drvdata, misc_device);
 	struct device *dev = &hps->client->dev;
 
-	return pm_runtime_put(dev);
+	pm_runtime_put(dev);
+
+	return 0;
 }
 
 static const struct file_operations hps_fops = {




