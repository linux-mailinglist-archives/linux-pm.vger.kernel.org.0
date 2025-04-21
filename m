Return-Path: <linux-pm+bounces-25796-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1E9A94DC2
	for <lists+linux-pm@lfdr.de>; Mon, 21 Apr 2025 10:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70D68188B646
	for <lists+linux-pm@lfdr.de>; Mon, 21 Apr 2025 08:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B9E120F069;
	Mon, 21 Apr 2025 08:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nMUhLDZJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAB71C8605;
	Mon, 21 Apr 2025 08:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745223216; cv=none; b=GWVOPnBTHZvdoPdrUaoezJukZW9bEDGq5Dgc+wJpfhfWbaLL8IdFi8y7PfY1LKK6HXE8Cm6PyRn8kGFxXQxUpHK3swiujTXOozRBaYMaLV8umegg2upvZ/y0CSb6OyqL4AI+4uj7vYndMUw6/P8An7AaCWo3T0DmG/1NvdsbTns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745223216; c=relaxed/simple;
	bh=YKZ1FL0fNS0oYeN9YSlOYG2O01H5uqXci4arY1uaZ4M=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YOT9Ad8VB7hL0zenxKgh3EahE2zuiVLFUD/xXwpbetyBEayELJlenxNpUx+EIkIJVFDi/kyWODMU80gJrBA/WrnKf8Go3Pha3qf6PWQRM+e1ocQtslgZwXYLQEyyskS8qWtHMhO0jpaFSaTFDwBtqczPbRaYR1cQwqdXCI5R1VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nMUhLDZJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6BB2FC4CEEB;
	Mon, 21 Apr 2025 08:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745223215;
	bh=YKZ1FL0fNS0oYeN9YSlOYG2O01H5uqXci4arY1uaZ4M=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=nMUhLDZJl9Mh30GZlM4kiXW4kA56cZmo3Rh89IC2eHaMDofArKDrmalsYB3KuWK/k
	 AohPr0kg0ESVXg985obJmbFwDga70IAGA/PyeYgHu3/c63dyniwVlYM2GLtT17K3Yk
	 ZXFCoEEz2Wvhy6aglXFCfoXAk+hE3d6hv+SoxPj7JeJCCcUFEiVoVfVQSANOwp/4sh
	 Cgf/qdWmxyUHb4GGoEuKzj5DkkceDQ7mcVb4c+X0vDGELIk1lSCrCEJEvjcR/HiRZZ
	 v3li5cTtbA8yWAsx+dU5eMeVWrapfeCoQveH8u8DeQAyAU0DB7BA1rL1NCDPvhFJCR
	 Z74cxxtHoiUhA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C63FC369AB;
	Mon, 21 Apr 2025 08:13:35 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Subject: [PATCH v2 0/2] Support building tegra124-cpufreq as a module
Date: Mon, 21 Apr 2025 03:13:30 -0500
Message-Id: <20250421-tegra124-cpufreq-v2-0-2f148cefa418@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACr+BWgC/2WNywrCMBBFf6XM2shkiJW68j+ki5BM0gH7MKlFK
 f13Y3Hn8hy4566QOQlnuFQrJF4kyzgUoEMFrrNDZCW+MBDSCQ1qNXNMVpNRbnqGxA8VfGNM8I5
 rclBmU+Igrz15awt3kucxvfeHRX/tL0b4H1u0QoXWnANrqrHR19hbuR/d2EO7bdsHIB6aDbAAA
 AA=
X-Change-ID: 20250401-tegra124-cpufreq-fd944fdce62c
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-tegra@vger.kernel.org, Aaron Kling <webgeek1234@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745223214; l=947;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=YKZ1FL0fNS0oYeN9YSlOYG2O01H5uqXci4arY1uaZ4M=;
 b=r+t8R12J9K6HoVxKRR1im5Q3oEBYOPWgY2nTw6QjMOaZYNb4fLfpmyaStn2uE2lIvZlQGr7Ss
 BVfvN+pG2YaAW0pQIMWkoPzX6j/LZiZlaQ2ZVEZiXwiTDw7LKIdlVgO
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
Reply-To: webgeek1234@gmail.com

This adds remove and exit routines that were not previously needed when
this was only available builtin. It also converts use of an unexported
function to a more sane alternative.

Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
---
Changes in v2:
- Replace patch 1 with a patch to not use the unexported function
- Update patch 2 to add remove and exit routines
- Link to v1: https://lore.kernel.org/r/20250420-tegra124-cpufreq-v1-0-0a47fe126091@gmail.com

---
Aaron Kling (2):
      cpufreq: tegra124: Remove use of disable_cpufreq
      cpufreq: tegra124: Allow building as a module

 drivers/cpufreq/Kconfig.arm        |  2 +-
 drivers/cpufreq/tegra124-cpufreq.c | 31 ++++++++++++++++++++++++++-----
 2 files changed, 27 insertions(+), 6 deletions(-)
---
base-commit: 91e5bfe317d8f8471fbaa3e70cf66cae1314a516
change-id: 20250401-tegra124-cpufreq-fd944fdce62c

Best regards,
-- 
Aaron Kling <webgeek1234@gmail.com>



