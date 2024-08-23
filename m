Return-Path: <linux-pm+bounces-12831-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3DD795D01F
	for <lists+linux-pm@lfdr.de>; Fri, 23 Aug 2024 16:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22B851C218E4
	for <lists+linux-pm@lfdr.de>; Fri, 23 Aug 2024 14:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D45C18786B;
	Fri, 23 Aug 2024 14:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WBXezxNw"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147F5156C69;
	Fri, 23 Aug 2024 14:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724423506; cv=none; b=coCHjzI8m0yZVYA5Z4k7LJXC4LnTv2x/2Fc2LYXPL/Y+xVzg0Xe+ItESTBnjl6rptIJTScok/GiQDnndgtNXJzDxg6KDX4RQLiJ0R7dMQWtMjUMcAMoLcLh2Q1OQWzKj0tbMF9R9dxA6zC4f4yv+iG8Kx+aYVvRzMAf6abC6YpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724423506; c=relaxed/simple;
	bh=LwUq28SkG8E+/YKm/8sOQQ48YIzJcrP8OzR6eBypW9o=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=qhtPygKnsN0pBwzNLGgjFMxc7KfhYqn9yvEyKCrC+qqhp1kzhhivqlATCv+RLlOY/KGJSUSPSoThDOpSkFm/7nruvbyXG1pMFkhYPwS9uIvNtKwNwjW0l4nE7Xolv7rCsOjx3RHWXk4pOwJsbgo3Z3wx22KNDb0f1HxF+lfmKmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WBXezxNw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2D64C32786;
	Fri, 23 Aug 2024 14:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724423505;
	bh=LwUq28SkG8E+/YKm/8sOQQ48YIzJcrP8OzR6eBypW9o=;
	h=From:Date:Subject:To:Cc:From;
	b=WBXezxNw/9eO8SRZv3rgkB5wE9BknD+pDegRnzf+mlsppx/sKAe5O+zwDfVPtZCPO
	 6g/GnvcA8LqW2ditXlgggWzADDs4lc1nZE5kEV4XVqZNpb2Fzw7u0yQy0ROG6PN64E
	 4NVW3vSDx4EJ7iR0yRgCVjbBC3zKRkf2b5sJ9UZtYS+f9XxJKb1m83yRiQ6lUmZf50
	 ORyXiltJRJG/llUJpYS13K5iH4nS/lyR0+2Swhf/EyLzDsIOa7BMctnP0s1kBuEtNA
	 o6dpo4r7YcqRrO+ZRIFklDA+8RUvb960xjdOHRwW3x6pqM/Ddhou8Kf22+c/8IC7Gx
	 81xZeXEo5dIoQ==
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-270298a3b6eso1406853fac.3;
        Fri, 23 Aug 2024 07:31:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUhztWJL8HoQEXcN3oxgK/9or0QHjAdAC2Cl2EYoxqBmHun/DmWCI7LjkE8TsdMmMd/zAHQUkAvWwbc1g4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXRBS4KlOCJZBgAg5fOUWYsPErRqm/2UJrILJSo/ySvOzneYPd
	8vbN4CuBHZ0sar2z/iPV5umR6Q5fTDdACNLDT+Xwl8VdWz+BGANHYL76pl9AQv+/WVAdwi8HY72
	Lz4IoE4Zka5RMzQLvrgU6Mp5EZnU=
X-Google-Smtp-Source: AGHT+IHPQq0WNeAxgjoc5b5cM9PZ4/F3qN8QyagMqFqWhbOgEOmqXftpk5cOGZme5orPcNWBO0JJoZlvQofeacWH4fY=
X-Received: by 2002:a05:6870:2807:b0:261:23f6:78d with SMTP id
 586e51a60fabf-273e6697212mr2727261fac.41.1724423505029; Fri, 23 Aug 2024
 07:31:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 23 Aug 2024 16:31:33 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hKYgjNEwQd+veUh01goACD4L1BWAsj7h-=4NCfFwRN-g@mail.gmail.com>
Message-ID: <CAJZ5v0hKYgjNEwQd+veUh01goACD4L1BWAsj7h-=4NCfFwRN-g@mail.gmail.com>
Subject: [GIT PULL] Thermal control fixes for v6.11-rc5
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 thermal-6.11-rc5

with top-most commit c0a1ef9c5be72ff28a5413deb1b3e1a066593c13

 thermal: of: Fix OF node leak in of_thermal_zone_find() error paths

on top of commit 47ac09b91befbb6a235ab620c32af719f8208399

 Linux 6.11-rc4

to receive thermal control fixes for 6.11-rc5.

These fix error handling in the thermal debug code and OF node reference
leaks in the thermal OF driver.

Specifics:

 - Use IS_ERR() in checks of debugfs_create_dir() return value instead of
   checking it against NULL in the thermal debug code (Yang Ruibin).

 - Fix three OF node reference leaks in thermal_of (Krzysztof Kozlowski).

Thanks!


---------------

Krzysztof Kozlowski (3):
      thermal: of: Fix OF node leak in thermal_of_trips_init() error path
      thermal: of: Fix OF node leak in thermal_of_zone_register()
      thermal: of: Fix OF node leak in of_thermal_zone_find() error paths

Yang Ruibin (1):
      thermal/debugfs: Fix the NULL vs IS_ERR() confusion in
debugfs_create_dir()

---------------

 drivers/thermal/thermal_debugfs.c |  6 +++---
 drivers/thermal/thermal_of.c      | 23 ++++++++++++++---------
 2 files changed, 17 insertions(+), 12 deletions(-)

