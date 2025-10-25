Return-Path: <linux-pm+bounces-36809-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9734C087C1
	for <lists+linux-pm@lfdr.de>; Sat, 25 Oct 2025 03:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A8D53BBC72
	for <lists+linux-pm@lfdr.de>; Sat, 25 Oct 2025 01:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BC51A9B46;
	Sat, 25 Oct 2025 01:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GxZVus3A"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BB418E3F
	for <linux-pm@vger.kernel.org>; Sat, 25 Oct 2025 01:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761354070; cv=none; b=DNLGsLHX6yCp2O64jq4r9d1iE8Ce7S84uaUKeW7xnR9qSrhJLTy+D4O1u8nr69mGnOVHsPvfB3ZcuGw1pVQPBh2Rd6YXe53pCD/6oRYyjOO44jyrXtX3B1u2Vj5UJ4sM3nTjJ+NrloCK9Mm8QFvjrcIHVVB8XF3eWWXpjcwo2qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761354070; c=relaxed/simple;
	bh=6ZiKsKmTo0RJCIul+IFqyu/pr8d2o5E09pcxoSIVdsA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qa4VHwNp/oqSN0XgemykPWGBTyGf7dXa8tfReCQni+2GLSN/MCh/27eTVdlW71v7tvLku6PwAvzW3jl5GyU0Cs0B6dGjdPpfhLW2DugQMTL39YUWT3nJaQ2zapYPbM1ABET22EMySiBd755Gw1lekNrUi2t2xPKLyoLxk5aSNts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GxZVus3A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26689C4CEF1;
	Sat, 25 Oct 2025 01:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761354069;
	bh=6ZiKsKmTo0RJCIul+IFqyu/pr8d2o5E09pcxoSIVdsA=;
	h=From:To:Cc:Subject:Date:From;
	b=GxZVus3A/TsCipntPKMMp14RJnawnKL0tJ+fXgLQB5eWOZkG8m6PiUrhdBNBxnCIp
	 8aQZBNUDJWiJI1ic39+zqvm+yxiVEO+UtLEdr10+3TdZhxWuBYhXr7A457TY1i4/Lx
	 vWtHeeD3CF3kY0gSsERydWMj4z364Y2u/KOjBYULGh54yPOjwnJhN1T38/vEr3+q+M
	 kvhpIsmsX+0CZ60WeQYC1fSrEJgGfyMu00OnjWjrilR1ELAU6zIdNMmBPzOmkf/dNJ
	 sFZPs7djOPT2BO/NAZyQJ/fChHSGnVpjwBinq8wdZ7+EHVbEWNeYXo2v95CT0Ll4g1
	 HiT3oNjoYiQWw==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Alex Deucher <alexander.deucher@amd.com>
Cc: linux-pm@vger.kernel.org (open list:HIBERNATION (aka Software Suspend, aka swsusp)),
	amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
	"Mario Limonciello (AMD)" <superm1@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Subject: [PATCH v2 0/2] Fixups for cancelled hibernate
Date: Fri, 24 Oct 2025 20:00:56 -0500
Message-ID: <20251025010058.2417352-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Muhammad Usama Anjun's recent series for being able to cancel
the hibernate sequence [1] exposes a bug with amdgpu handling for
skipping the thaw step.

Because the thaw step is skipped in most cases, cancelling the
hibernate means that the device is left in an inconsistent
state.

Add support to the PM core to let a driver track it's frozen
state when an error code is returned during thaw(). This will
ensure that the poweroff() and restore() callbacks get run.

Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>

I suggest this patch series merge through linux-pm.

v2:
 * pick up tag
 * rebase on linux-pm/bleeding-edge
 * fix lkp robot issue

Mario Limonciello (AMD) (2):
  PM: Allow device drivers to manage the frozen state of a device
  drm/amd: Manage frozen state internally

 Documentation/driver-api/pm/devices.rst    |  8 ++++++++
 drivers/base/power/main.c                  |  7 +++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 10 ++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  2 +-
 include/linux/pm.h                         |  3 +++
 5 files changed, 29 insertions(+), 1 deletion(-)

-- 
2.43.0


