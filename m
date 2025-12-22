Return-Path: <linux-pm+bounces-39807-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 615ABCD7234
	for <lists+linux-pm@lfdr.de>; Mon, 22 Dec 2025 21:49:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E329305D9BB
	for <lists+linux-pm@lfdr.de>; Mon, 22 Dec 2025 20:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21920345749;
	Mon, 22 Dec 2025 20:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tfyfl54p"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66893451D5;
	Mon, 22 Dec 2025 20:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766435886; cv=none; b=PW94tYwYdbHdHezNfU5NgbblPiJujTsjPkcKB5GkCMZaANtkFIWqw4EF8VASiGt25obTQgoDb3pbG7SubTF0B3S2VnleS+m9jugO6miioMt42hjk0+LV98jhyNGz1WEQlP4ZOCje7b1BwRMiTKlPc/VTuREMFgZqHh6pHTjrrrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766435886; c=relaxed/simple;
	bh=UTYYzZeRaa3Nn7UveWqQ/IsQZ7Vog6LpCWp1SfFhYXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YqD5rEdQuQqfjpmu4w3p6yGUbAaVFdl6nT5ylkEYK8oljHQmTdkE0xZUzprD55coCn770dS5sVWfl5HMEKNEND+OpQe4gD7VtEOi+bbNxuochStS13tZfvoYIho7QHUZ7YcdN46+LLKK7mN3+ZMq5FHoulepjPtRT1XrFJe3Bg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tfyfl54p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BB7DC4CEF1;
	Mon, 22 Dec 2025 20:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766435884;
	bh=UTYYzZeRaa3Nn7UveWqQ/IsQZ7Vog6LpCWp1SfFhYXw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tfyfl54peFOU5xH7PnoXeaj1xjaYIDHNRnzhCKkWT1lKZJ4OwchQJD8wlBbzNy6v/
	 lhd7SaTRat2v+Gqb3UhdHhd1qJliUWEmv2B+publBRQkbNopXtTsf4ifagWDuVFT01
	 FlWSH5XWr2lJOMfUhlAB7nsjuMv2vMMDYUy7/L46o3j5ukitFwZRKoFhiU+NOGyIH7
	 RSVxwpaIMoMukVH5XEIchqRcQtvCO52xx3nCypj03hi6cGjAQNs83HTzQ88HxfDLAT
	 xV3spGFSoYSuWSMIsmBQEwAu89E100EseXo9Qv3uQaDIOqet0wrn4mOKNXlsAlcDpy
	 57oSulRGFs0Dg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Brian Norris <briannorris@chromium.org>,
 Dafna Hirschfeld <dafna@fastmail.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: [PATCH v1 05/23] media: rkisp1: Discard pm_runtime_put() return value
Date: Mon, 22 Dec 2025 21:01:55 +0100
Message-ID: <2356323.iZASKD2KPV@rafael.j.wysocki>
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

Printing error messages on pm_runtime_put() returning negative values
is not particularly useful.
 
Returning an error code from pm_runtime_put() merely means that it has
not queued up a work item to check whether or not the device can be
suspended and there are many perfectly valid situations in which that
can happen, like after writing "on" to the devices' runtime PM "control"
attribute in sysfs for one example.

Accordingly, update rkisp1_vb2_stop_streaming() to simply discard the
return value of pm_runtime_put().

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
 drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

--- a/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
+++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
@@ -1123,7 +1123,6 @@ static void rkisp1_vb2_stop_streaming(st
 	struct rkisp1_capture *cap = queue->drv_priv;
 	struct rkisp1_vdev_node *node = &cap->vnode;
 	struct rkisp1_device *rkisp1 = cap->rkisp1;
-	int ret;
 
 	mutex_lock(&cap->rkisp1->stream_lock);
 
@@ -1132,9 +1131,7 @@ static void rkisp1_vb2_stop_streaming(st
 	rkisp1_return_all_buffers(cap, VB2_BUF_STATE_ERROR);
 
 	v4l2_pipeline_pm_put(&node->vdev.entity);
-	ret = pm_runtime_put(rkisp1->dev);
-	if (ret < 0)
-		dev_err(rkisp1->dev, "power down failed error:%d\n", ret);
+	pm_runtime_put(rkisp1->dev);
 
 	rkisp1_dummy_buf_destroy(cap);
 




