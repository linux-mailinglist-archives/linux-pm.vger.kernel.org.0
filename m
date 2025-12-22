Return-Path: <linux-pm+bounces-39792-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39FD9CD7189
	for <lists+linux-pm@lfdr.de>; Mon, 22 Dec 2025 21:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5AFCA30443CD
	for <lists+linux-pm@lfdr.de>; Mon, 22 Dec 2025 20:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B29D3328E2;
	Mon, 22 Dec 2025 20:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tQyJgYJZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8A931C567;
	Mon, 22 Dec 2025 20:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766435832; cv=none; b=SQ6Ig9I49r4Md0G29FVN3nwRNM+KaZlqahxrMD3VVg4+xMC3NY/bwwq+sMye1WlXlSWFLjaLwtNRwxXt91W99YpeSvntxYwU6GkJ1YGY8D+fCGu2twAJcQy1SGTLOuEVpbaRvMxuIMHdylLKMRiwj5zKNCQQzIl/KuXRu/MsM4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766435832; c=relaxed/simple;
	bh=baWMgIZkHykOT1ScfB8/YYG3UmBK88tHYQ90EaBhlXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bMZ/C561NH5WELb8ZGUUCD/Xf7atKbJzrDk9F2bbUeLCUf1L64KnOa1pnO6XoByHTefXJ/6uHCEJqXYARXx5OTyek7RI3CoBdAdFyFLRU3wn3wzfh6mmott2fW+fFF8+QQhiS0cJp2jwIEbFBltBaJRa35orN1uL5eqHrgAmPZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tQyJgYJZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2805C116D0;
	Mon, 22 Dec 2025 20:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766435832;
	bh=baWMgIZkHykOT1ScfB8/YYG3UmBK88tHYQ90EaBhlXY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tQyJgYJZ5iNhWWLNp2uUFisGdSW86mj5oSFYlovUZfWyaxHqAqJcF6IFZTW8M+IBk
	 srLF7j8sshluG661lbGaqLZlWvbSUh79GP1U2Ow+vZWHG6sa1ZS6rnnWg5lXb1C91U
	 omWOxo6d8v9MtTw5IuLZPB+WV3nwPccZ8KDTxLyj945Ucujsi5CuFlxB6iDugkLUMj
	 AL1e+eNkeTHAmfIcrbNUuYRERfpeFXzL2YyhFJel5nsq7sbRgK+6mzjxg0ZL94eX7c
	 9ySp2LZiC/U9egaNDr3SUF1UZcx5ao+cztEOACORijhaItiIDWWlxLZnBooCxYJhH3
	 P6+Eqnttwljwg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Brian Norris <briannorris@chromium.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>,
 Bart Van Assche <bvanassche@acm.org>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>, linux-scsi@vger.kernel.org
Subject:
 [PATCH v1 20/23] scsi: ufs: core: Discard pm_runtime_put() return values
Date: Mon, 22 Dec 2025 21:31:45 +0100
Message-ID: <2781685.BddDVKsqQX@rafael.j.wysocki>
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

The ufshcd driver defines ufshcd_rpm_put() to return an int, but that
return value is never used.  It also passes the return value of
pm_runtime_put() to the caller which is not very useful.

Returning an error code from pm_runtime_put() merely means that it has
not queued up a work item to check whether or not the device can be
suspended and there are many perfectly valid situations in which that
can happen, like after writing "on" to the devices' runtime PM "control"
attribute in sysfs for one example.

Modify ufshcd_rpm_put() to discard the pm_runtime_put() return value
and change its return type to void.

No intentional functional impact.

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
 drivers/ufs/core/ufshcd-priv.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/ufs/core/ufshcd-priv.h
+++ b/drivers/ufs/core/ufshcd-priv.h
@@ -341,9 +341,9 @@ static inline int ufshcd_rpm_resume(stru
 	return pm_runtime_resume(&hba->ufs_device_wlun->sdev_gendev);
 }
 
-static inline int ufshcd_rpm_put(struct ufs_hba *hba)
+static inline void ufshcd_rpm_put(struct ufs_hba *hba)
 {
-	return pm_runtime_put(&hba->ufs_device_wlun->sdev_gendev);
+	pm_runtime_put(&hba->ufs_device_wlun->sdev_gendev);
 }
 
 /**




