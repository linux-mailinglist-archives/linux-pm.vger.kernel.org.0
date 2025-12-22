Return-Path: <linux-pm+bounces-39790-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5197BCD7171
	for <lists+linux-pm@lfdr.de>; Mon, 22 Dec 2025 21:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9674130303BC
	for <lists+linux-pm@lfdr.de>; Mon, 22 Dec 2025 20:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C0532827E;
	Mon, 22 Dec 2025 20:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PKSzpzo7"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E68230BBB6;
	Mon, 22 Dec 2025 20:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766435826; cv=none; b=if9/jfHmM/fHzx3+vvmdnREpeahMjvRuFs3IBb7WqzI+B23X5PB37542STO4Q1WSZGAgQm2zQrDP1iZtX540EmyjRvIpRLVq0+UhP5iNwdXC+IBRxbWgI03rcAH6vRdBllZh7rqhSAvfU2ePCCPGv14FB0lpDpVWywvA3W2cUuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766435826; c=relaxed/simple;
	bh=qU1xEqH8d5/3tAVNsT6IV9ERtj/PGsYjFsn2yDftN5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hsk7UMbHAJB4BJlNUcdvgxWSHwgK8/4FGSEQrDw/sk7Lcjb6H5mDk8LWdgFOWVtmKgyBVf3czKkFRhP3XPFqicayzUx2dF5IM7DUwOHRL0guAMdNZMUzTHFVcP17HVC+noKb/1HstjFsaO3VsObrkMmAplW2mbIAZEOR8BApGko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PKSzpzo7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAFDEC16AAE;
	Mon, 22 Dec 2025 20:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766435825;
	bh=qU1xEqH8d5/3tAVNsT6IV9ERtj/PGsYjFsn2yDftN5Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PKSzpzo7dZvCE4otps9jA7DCZ+mGvpTC/qTJK1+mCdPoaOo2UXkYVRtAVg6c97RTp
	 uwjQTaFHqYu1SeoMeggsmQ9Ku0NRc4NhXYj6G7zxWcALjh2r1wMggGUuTKXeM1Cyw2
	 R+/W0sK3Gwbg3oZlkrpHXCnkfYPMveJCeD94dBivJCn4IXRyuIQV+/RKSrlkb8l8Uf
	 3H+CecKKAdH39vTExCZjz5qklsUAh0PD7jS/Eejus3xFsvP3rg1fSy86FYofbMnwUi
	 n0dlARVZElTNtzk5TV2rCGmBp4d3TPbP+05PqLX2oSrgDqB0eXNp4XqHE0Q5nnyWLP
	 JNTMq/KxbtHhA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Brian Norris <briannorris@chromium.org>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org,
 linux-sound@vger.kernel.org
Subject:
 [PATCH v1 22/23] ASoC: rockchip: Discard pm_runtime_put() return value
Date: Mon, 22 Dec 2025 21:35:33 +0100
Message-ID: <5160923.0VBMTVartN@rafael.j.wysocki>
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

It is better to check directly whether or not CONFIG_PM has
been enabled instead of relying on an error value returned by
pm_runtime_put() in that case because pm_runtime_put() may also return
an error value in other cases, like after writing "on" to the devices'
runtime PM "control" attribute in sysfs for one example.

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
 sound/soc/rockchip/rockchip_sai.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/sound/soc/rockchip/rockchip_sai.c
+++ b/sound/soc/rockchip/rockchip_sai.c
@@ -1487,8 +1487,9 @@ static int rockchip_sai_probe(struct pla
 	return 0;
 
 err_runtime_suspend:
-	/* If we're !CONFIG_PM, we get -ENOSYS and disable manually */
-	if (pm_runtime_put(&pdev->dev))
+	if (IS_ENABLED(CONFIG_PM))
+		pm_runtime_put(&pdev->dev);
+	else
 		rockchip_sai_runtime_suspend(&pdev->dev);
 
 	return ret;




