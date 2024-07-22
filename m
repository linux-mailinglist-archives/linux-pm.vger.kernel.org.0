Return-Path: <linux-pm+bounces-11296-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A97D8938FF1
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jul 2024 15:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47402B210FE
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jul 2024 13:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA44416B397;
	Mon, 22 Jul 2024 13:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TVsv/nmY"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED721D696;
	Mon, 22 Jul 2024 13:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721655138; cv=none; b=W7ogIOzhua/oXFlXMD8g3yAlEr1rEvcqJktvjv5Qfweuup3Xvo331CDAlbauAd9THG7qiMH9pAJAyc5HvlAkCKN5Cmm23mLF5yq53TdyWm4iSATdvB6TDa6tne/jmdltMQrHfp0ur+ESJKO8GbRtIUv9cZlPEBXV7aeJDJPVwJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721655138; c=relaxed/simple;
	bh=4/MciXAVEYXOQiKtZ20xWLme7knbhaIxn5XnVqLxNDI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=aOennTmp89sAfSBA/wpPY1hBVEhBbPRW/rY3dwBJ/Q5LTUnkutuuS7+Ol79/BPlIVyDWiTFyU1D5M59Z9ijFJ1uMi5QP14k4Jj9PUjcpi4afn6jbjf1eRo41OgFDx2VhVQX3Wk7w04NpUzS85WblpMc2vVn1GMT2kiyAd28+e18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TVsv/nmY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BC6DC4AF0D;
	Mon, 22 Jul 2024 13:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721655138;
	bh=4/MciXAVEYXOQiKtZ20xWLme7knbhaIxn5XnVqLxNDI=;
	h=From:Date:Subject:To:Cc:From;
	b=TVsv/nmYh5M3BG1KePxzty81gUjI1NCa6ztgxEHS29U+Jai8/SCLskVhPGng32FVM
	 cVkpjYUNGtEnnQVQPAPqLXVrP6BTa/OY5/c9rMJBGwNQt9S9E/8hHcf5vtCV+NRpzE
	 jtfDzZNYlTyszhQaRwRF6WwuMoa0nDksAGNgYOojYvhkJhWHlKXU28qmCxlU2wGo7q
	 7ht87CZcJeQX96EUWUpkwwQ3VQfRW1KZmjta7m/BwEye/YDO5V4Ssc0f9lRq4V8562
	 kdKzVLfkNlZ5/sBx6WJytf0qBiJVJN+uUMzWC3axQConRz4Gg4HUHE+tHBINbZxpoA
	 5tpMWmGSUiOKw==
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3d92531469fso127378b6e.3;
        Mon, 22 Jul 2024 06:32:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWjoCzuZsKliq/70oUI4RX8uikT6ZS/eMxwiaSo2oZTgTtfiMYsqaOY9Cpp9Bkk5oJ9kPlJfizIBK63S04NPBs+nqjC5nVKXjEgc+OE
X-Gm-Message-State: AOJu0YzMQnSDnoMkJYe3r8f/vrm/XvlIqmGwlS1LpTepeUdQkNxzS3yX
	65yTYgPHI5RLRTowMZDZIcKUJm3xq2eq/lXSyb8VobgDp0ahPoS2iaqVoBkB6tV4eruo92HoMQj
	JX0mNAuAub4b0T8K84VqnUVI1cEk=
X-Google-Smtp-Source: AGHT+IGAWV19IiTVJdNvqoWmOhbK2AoUlgeSwQlzIi7IxbZsDROH0sdLM7U6BqJfjVN493c2rgvPfZDarRHVCOKGMPg=
X-Received: by 2002:a05:6808:30a1:b0:3da:9fd6:a14f with SMTP id
 5614622812f47-3dae5fad610mr4758308b6e.2.1721655137367; Mon, 22 Jul 2024
 06:32:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 22 Jul 2024 15:32:06 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hTH0JtVLWDe1obo0g2fiT4n8zqf72k14eusf9sESLpXw@mail.gmail.com>
Message-ID: <CAJZ5v0hTH0JtVLWDe1obo0g2fiT4n8zqf72k14eusf9sESLpXw@mail.gmail.com>
Subject: [GIT PULL] Thermal control fix for v6.11-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 thermal-6.11-rc1-2

with top-most commit e528be3c87be953b73e7826a2d7e4b837cbad39d

 thermal: core: Allow thermal zones to tell the core to ignore them

on top of commit 51835949dda3783d4639cfa74ce13a3c9829de00

 Merge tag 'net-next-6.11' of
git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next

to receive a thermal control fix for 6.11-rc1.

This fixes a flood of kernel messages coming from the thermal core on
systems where iwlwifi is loaded, but the network interfaces controlled
by it are down.

Thanks!


---------------

Rafael J. Wysocki (1):
      thermal: core: Allow thermal zones to tell the core to ignore them

---------------

 drivers/net/wireless/intel/iwlwifi/mvm/tt.c | 10 ++++--
 drivers/thermal/thermal_core.c              | 51 ++++++++++++++---------------
 drivers/thermal/thermal_core.h              |  3 ++
 drivers/thermal/thermal_helpers.c           |  2 ++
 4 files changed, 37 insertions(+), 29 deletions(-)

