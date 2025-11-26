Return-Path: <linux-pm+bounces-38745-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0668BC8BC3E
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 21:05:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 408734E7B1D
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 20:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38881342535;
	Wed, 26 Nov 2025 20:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H3/yAfMF"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124BE34252E;
	Wed, 26 Nov 2025 20:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764187523; cv=none; b=bnFatfB1mPORC5rR8Ov5nTve5yfcyMTzrD17DXvKo7kDtVjovT6Q7z2CFhUoPv8D8wfN23MQGbK8fUgMj7BswIxPe2J1v49QcgQCl3P4KGjAms9d6sBq6i8uyhvgexiQ3d+ieFSRnmC+mmqhDaoGRj/7smnaBUdyO/zm3l6ogjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764187523; c=relaxed/simple;
	bh=mCA3PyJ/6+FEyx8OrOOSRCeGxDoAzMZQFmgnixE0bxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fukw6jTMH+W7sTHmcxYZAHsyldWH868RPAmAoQw8uy3anLv/zfPpeVPYWIWuDZbz7gw+cNmlz+O4u4FymhBMTHiTaFFKC3BaZCoDHO9Oen/KO/zdifWjqWcL7zi5dPJSePs8Y20q931Wfq0OEBbpU5azywDZLYOaARyKByUem1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H3/yAfMF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60404C116D0;
	Wed, 26 Nov 2025 20:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764187522;
	bh=mCA3PyJ/6+FEyx8OrOOSRCeGxDoAzMZQFmgnixE0bxQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H3/yAfMFY9Bb6QoZlMM7IXBFGASN0eoqfmKizDomTbvZaHGMOmQtUKKUe5WwLL9Wl
	 a3O6wrkoVL51mGtBkiyPDC52tSK67BFEJ5O6zBzTUMC44GofjvRyQAserkmeFbv8ad
	 APLGpKHq6dnHVe2V2UAvUsFb5DAZPRChbKxNf4xs5tazLr2QDCymgsoGmdQ9nl9A9p
	 mydyhbTNMzL+yHAygo59k7QUsyfu4I5AJVClfl4CY2WzHMeWrVPQIRu/VZnKaN1fF6
	 vbn2Mm4SQbwe3zOrbASloCnKXTz1yXvKV/vTQYf+aaIE62cLfM/8XdqDaWWYGrid3/
	 r2/omq/f/RDdA==
From: Bjorn Andersson <andersson@kernel.org>
To: linux-pm@vger.kernel.org,
	Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-kernel@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: (subset) [PATCH 00/80] treewide: Remove redundant pm_runtime_mark_last_busy() calls
Date: Wed, 26 Nov 2025 14:10:44 -0600
Message-ID: <176418784431.1591314.15273685348396747534.b4-ty@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250704075225.3212486-1-sakari.ailus@linux.intel.com>
References: <20250704075225.3212486-1-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 04 Jul 2025 10:52:25 +0300, Sakari Ailus wrote:
> Late last year I posted a set to switch to __pm_runtime_mark_last_busy()
> and gradually get rid of explicit pm_runtime_mark_last_busy() calls in
> drivers, embedding them in the appropriate pm_runtime_*autosuspend*()
> calls. The overall feedback I got at the time was that this is an
> unnecessary intermediate step, and removing the
> pm_runtime_mark_last_busy() calls can be done after adding them to the
> relevant Runtime PM autosuspend related functions. The latter part has
> been done and is present in Rafael's tree at the moment, also see
> <URL:https://lore.kernel.org/linux-pm/CAJZ5v0g7-8UWp6ATOy+=oGdxDaCnfKHBG_+kbiTr+VeuXZsUFQ@mail.gmail.com/>:
> 
> [...]

Applied, thanks!

[58/80] remoteproc: omap: Remove redundant pm_runtime_mark_last_busy() calls
        commit: 7f07a5c3e2f5f50f354dab622c1b9cc46ee89f67

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

