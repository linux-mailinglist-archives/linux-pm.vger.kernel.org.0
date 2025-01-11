Return-Path: <linux-pm+bounces-20267-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F7BAA0A37D
	for <lists+linux-pm@lfdr.de>; Sat, 11 Jan 2025 13:11:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43C81188BC0E
	for <lists+linux-pm@lfdr.de>; Sat, 11 Jan 2025 12:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783FD1925BA;
	Sat, 11 Jan 2025 12:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QdHkIiwL"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5484129A2
	for <linux-pm@vger.kernel.org>; Sat, 11 Jan 2025 12:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736597498; cv=none; b=gH0QVsUUtwJ/lanj9ajv/I+zBzTURHGeEs6ss8jpTncfAJgzC7nvOwCRs4rSjORq8g+M0i+KU5artB7Zhynt4xtpQ1YDTvEQSXmKG90pO6H3NMcdKiEd7IygfKFCeUr8LJYlA5pPFZW1UqePIAqE7/5xrAfCg9W5TQQF1j18T7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736597498; c=relaxed/simple;
	bh=74aftzWOJOaYouCmyvofFgE80dwRm6J/KBfyja9AosY=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=HdgsWi0VEhIvzzPsnHApcUInr+CUMKesj424FlNgbE0xfad5u9FfRpQdCHsu/GWAWnVbIGbXeSH4nJ241HySfds5byi5DJ5zlKchS/z1YiAseFggc6iP/fQIXKh9px01FynTj/pQWTXRnnMGF+3pEgK2xWoGdC3ecejXusF4M3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QdHkIiwL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACCD2C4CED2;
	Sat, 11 Jan 2025 12:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736597497;
	bh=74aftzWOJOaYouCmyvofFgE80dwRm6J/KBfyja9AosY=;
	h=Date:From:To:Cc:Subject:From;
	b=QdHkIiwLzO6wXFD36YdRCKYiDdqFUrffUMIlmwig6/iQygrM+2BpZ3VCaDnZ8wIkH
	 ZEfDn7TKQJHpjS5sDe5ije1nwFtq/wcPsjlXR0lCTVTuO++zcdFuZLHOQko5IRzcOb
	 AzBByG/hCaAa4FIGqs7kA8MICoLK4fKJ4c5kchXfr4DF19MZNuOluZ7ExhN35t/Nki
	 lAux8BcTPKwMdF+i2hzH3S2TSpZk6DHqqFFAZsh5TRyu9vqMVfVuz1bBZVtLQ3S7Ka
	 on0Kt0JWGclHUTmoJidvWOp4fwdj/kbN/3Vk8v1Hi5MEKZwW0a7vz1BJuQQQfc4MFW
	 zyfhinYaluHVw==
Message-ID: <d9ae7d64-19b1-443b-b3c1-e8187bab11e1@kernel.org>
Date: Sat, 11 Jan 2025 21:11:35 +0900
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Chanwoo Choi <chanwoo@kernel.org>
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "open list:DEVICE FREQUENCY (DEVFREQ)" <linux-pm@vger.kernel.org>,
 Chanwoo Choi <cw00.choi@samsung.com>, Chanwoo Choi <chanwoo@kernel.org>,
 MyungJoo Ham <myungjoo.ham@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>
Subject: [GIT PULL] devfreq next for 6.14
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Dear Rafael,

This is devfreq-next pull request for v6.14. I add detailed description of
this pull request on the following tag. Please pull devfreq with
following updates.

Best Regards,
Chanwoo Choi


The following changes since commit 40384c840ea1944d7c5a392e8975ed088ecf0b37:

  Linux 6.13-rc1 (2024-12-01 14:28:56 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git tags/devfreq-next-for-6.14

for you to fetch changes up to f3253b23535fda2436b2d5a3172260a75ca64091:

  PM / devfreq: exynos: remove unused function parameter (2025-01-11 21:03:07 +0900)

----------------------------------------------------------------
Update devfreq next for v6.14

Detailed description for this pull request:
- Call of_node_put() only once in devfreq_event_get_edev_by_phandle() on devfreq-event.c
- Remove unused function parameter of exynos_bus_parse_of() on exynos-bus.c

----------------------------------------------------------------
Jeongjun Park (1):
      PM / devfreq: exynos: remove unused function parameter

Markus Elfring (1):
      PM / devfreq: event: Call of_node_put() only once in devfreq_event_get_edev_by_phandle()

 drivers/devfreq/devfreq-event.c | 8 ++------
 drivers/devfreq/exynos-bus.c    | 5 ++---
 2 files changed, 4 insertions(+), 9 deletions(-)

