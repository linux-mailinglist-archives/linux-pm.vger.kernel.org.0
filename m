Return-Path: <linux-pm+bounces-39806-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7374ECD723D
	for <lists+linux-pm@lfdr.de>; Mon, 22 Dec 2025 21:50:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80CB93085924
	for <lists+linux-pm@lfdr.de>; Mon, 22 Dec 2025 20:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A70F3446C4;
	Mon, 22 Dec 2025 20:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ejlr3a6j"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFF430BF62;
	Mon, 22 Dec 2025 20:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766435881; cv=none; b=eLaTxjkhe8InpXO7A6iiYvE/i6wGby3j07HMZnHT4z1t7Wdux6ONF+di3RwavYdY4TtYQ1HEVtWTzj9LHMek1qzLsrNaMY62vZZ8GHt5i1mU1PgiQvHJKw685gHAUDbxwiAQ3Kq6ceURCQ68P8C/XGPaG0hvKSJeShxBmosojVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766435881; c=relaxed/simple;
	bh=Bib9KNCO9PkYkoUxSea/AkbvyVEBdlzoPe1J67Uyctw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rkDnpoT4Cz2f/O8woL4WQR1EYCfC0DGb2zvjiefjobcaSH4urxa6PWDWk+4SsqIJd2KL2tOCdqLke3Nt6Sttd1+KZkolNPFeVhTFSOZIjGrUNELjlt4GwSjcf7hrniUTSwLPRLLGnqVnYPxd0DdeWDM4W5TIFoNoJL1lSM97V+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ejlr3a6j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 704AFC19421;
	Mon, 22 Dec 2025 20:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766435880;
	bh=Bib9KNCO9PkYkoUxSea/AkbvyVEBdlzoPe1J67Uyctw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ejlr3a6j5yCS6z/eXIDPXzhKH9PYXDuJ7ttFxoWtLUGPOOp7oDcw75vv+JBOj24B/
	 Z/w1Th+8ozU0sQZexkgvd7Z0TF8z0m+6OzWnNF66oMr/6TahLrsFBLI6iE5QGQ3Llo
	 XpfTiXhNgr/333pXl+PLt8bSrHZRJWfk/ouIcQYpaQMJr2Nl2fmOwROuqtz7OS8H3R
	 CxDuDIzoaxIzAgentKjslAnPNmfbaVwrALnMnFfYxPdw9znsFJEHiO62lkXT7cbmXi
	 t1C8A6fBNZULTTUlSzO7rk1Q3Jbzbd4TFJhj6eLwxBSKncP/7dw3xuL74gROSlhUQ5
	 nq5IVblAO/5Dw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Brian Norris <briannorris@chromium.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org
Subject: [PATCH v1 06/23] media: ccs: Discard pm_runtime_put() return value
Date: Mon, 22 Dec 2025 21:03:25 +0100
Message-ID: <22966634.EfDdHjke4D@rafael.j.wysocki>
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

Passing the pm_runtime_put() return value to callers is not particularly
useful.

Returning an error code from pm_runtime_put() merely means that it has
not queued up a work item to check whether or not the device can be
suspended and there are many perfectly valid situations in which that
can happen, like after writing "on" to the devices' runtime PM "control"
attribute in sysfs for one example.  It also happens when the kernel is
configured with CONFIG_PM unset.

Accordingly, update ccs_post_streamoff() to simply discard the return
value of pm_runtime_put() and always return success to the caller.

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
 drivers/media/i2c/ccs/ccs-core.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/media/i2c/ccs/ccs-core.c
+++ b/drivers/media/i2c/ccs/ccs-core.c
@@ -1974,7 +1974,9 @@ static int ccs_post_streamoff(struct v4l
 	struct ccs_sensor *sensor = to_ccs_sensor(subdev);
 	struct i2c_client *client = v4l2_get_subdevdata(&sensor->src->sd);
 
-	return pm_runtime_put(&client->dev);
+	pm_runtime_put(&client->dev);
+
+	return 0;
 }
 
 static int ccs_enum_mbus_code(struct v4l2_subdev *subdev,




