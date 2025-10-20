Return-Path: <linux-pm+bounces-36480-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 775C4BF28F2
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 18:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 631083A69C3
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 16:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C0F330307;
	Mon, 20 Oct 2025 16:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V31gZRXY"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF222609D0
	for <linux-pm@vger.kernel.org>; Mon, 20 Oct 2025 16:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760979209; cv=none; b=CluQ7eAIHix/P7j/E624QoEd+7bGA5T2bSqUBNR7aAEbziSWRuF4KjhyavCVw+eCEJP5ZaiXsvRlyOppRe9DlAQLHyIInMZ/Gf93j0y2QX3ZtjKBq4+ND0vJ5ubf3QRWMSkqm9vCRGgEiYIdp+0G7mitsHbbwSHGxCHAE3/w3Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760979209; c=relaxed/simple;
	bh=lSpNsv9v6YOmH4+DfxjS+7hp9aTjSqVplCul5KPB2Rg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uFMem9aCKvY6sB/MqOqyw9A2HvadX+wtGrCK0rNmQwIzcjHBY0MiKK1yMAxoAL0bwLBnRIJNX97fJP3UMyGD6PWmyET4t3ScPSJZQNwQamOtK21QuM3auD/xjNYCUU/CW6OvDZZus9g24RsU5jGdLS6cK+eIJ42rUV2LXWv+rIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V31gZRXY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF85FC4CEF9;
	Mon, 20 Oct 2025 16:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760979209;
	bh=lSpNsv9v6YOmH4+DfxjS+7hp9aTjSqVplCul5KPB2Rg=;
	h=From:To:Cc:Subject:Date:From;
	b=V31gZRXYFgWtn+tcQgu3Ix3cijzMWjCCuedzMlAUgG36jMV+EOpmTXGIROWsVJK7A
	 Ia5oMtvHMQVWIYj5DzoSS/o8hM1gd3jlxeHztxtZDzZhdEK16sdYjHak7bjW4aIUnd
	 vEGQickJhtw7i14VcYniLON+eSRsFCeE8aJnF6wR9ybL9bSbB3l0BBCBjRbUfm/Rkj
	 h51tiFm8TsweNPRwSlVUtv8/3e6fe6Ap/IW4kbO/IhMRhGlxI2gtMofKh1x0t1iTXk
	 zO5YcEWzyvcETckzniGqPJAXbt08wu4CQ6uV2XDROtaaE4Ps5RvHFci6GDfdbe4YLO
	 5glPNahM29RFg==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: mario.limonciello@amd.com,
	airlied@gmail.com,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	dakr@kernel.org,
	gregkh@linuxfoundation.org,
	lenb@kernel.org,
	pavel@kernel.org,
	rafael@kernel.org,
	simona@ffwll.ch
Cc: "Mario Limonciello (AMD)" <superm1@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-pm@vger.kernel.org
Subject: [RFC 0/3] Fixups for cancelled hibernate
Date: Mon, 20 Oct 2025 11:50:46 -0500
Message-ID: <20251020165317.3992933-1-superm1@kernel.org>
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

To fix this allow devices to return -EBUSY and adjust the PM
core handling of this case.

Link: https://lore.kernel.org/all/20251018142114.897445-1-usama.anjum@collabora.com/ [1]
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
Mario Limonciello (3):
  PM: Mark device as suspended if it failed to resume
  PM: Don't pass up device_resume() -EBUSY errors
  drm/amd: Return -EBUSY for amdgpu_pmops_thaw() on success

 drivers/base/power/main.c               | 7 ++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 +-
 2 files changed, 7 insertions(+), 2 deletions(-)

-- 
2.43.0


