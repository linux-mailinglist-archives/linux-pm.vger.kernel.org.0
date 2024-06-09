Return-Path: <linux-pm+bounces-8821-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B82F89014DE
	for <lists+linux-pm@lfdr.de>; Sun,  9 Jun 2024 09:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3D541C20C2B
	for <lists+linux-pm@lfdr.de>; Sun,  9 Jun 2024 07:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5858DDA0;
	Sun,  9 Jun 2024 07:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kKWR0226"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7812D17997;
	Sun,  9 Jun 2024 07:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717919602; cv=none; b=UGYJSVlxuTM8S5MG17PQK6+q+UE3zEhBJXU0EYfLOxMUTp5o6dxE2ttPQS+ldOSX0xSIKvQQhGzMTYTqg7nLLtZ+csZPHEvpZdyiNQre4PVJtovs0/S345HhEh/zjpGccEdreo+fd1cgtJdE1NXrOWh/V5cgGU2SmInthFwySWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717919602; c=relaxed/simple;
	bh=WKtvi7NoYsj3nIwgBQA3DkE/NuftdY0qLGUWPUJfuwc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hQNzhIie5+GK69qEWRjB7veBoKA1Dj3gtZhMToiqmy1jj2/3ZcX5QDbYVq+qvxruwuHP1AQKINQzG53T/L07nsJkaO+jSG1F/WSW4AVzw/a5WsZ5E2z6hT/5ILltu1BgJdEwRhsvdXNsvqoeSnsMA5gKMU22/sRIiHB3WGnlhCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kKWR0226; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3A67C2BD10;
	Sun,  9 Jun 2024 07:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717919602;
	bh=WKtvi7NoYsj3nIwgBQA3DkE/NuftdY0qLGUWPUJfuwc=;
	h=Date:From:To:Cc:Subject:From;
	b=kKWR0226WA/BuBYJ8MZCA/Zhj1LRGVFzuerR8ZyV+/NWCdrJ6xIiEs4rLH38I3etf
	 aCJRqSKoQ3SxBnubpDUC9TgjRLoP5CLA+jJM9BX5u001nzXtTBj8ZwTLNLzP/kNMKs
	 Vudykrl8SoCo2tnY7s2WR0h8Yk98uedOcFzG3r3qaYphFxeLa52bDmPPDur6FSlXb2
	 d8dHjMBghQV6LbsFagYrJYMGLKN2sYfz5j8YlO3zX6yRlnRjD6RkEKlJJEhAooXzop
	 /mYrf4MqNti7O3tyAN3FT2Z9Xrnia/2MHIzJB7P6uQYhK3PljnuoODalMFNUHpaVqW
	 U1157BgYYhpPQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1sGDMf-0000000081I-0194;
	Sun, 09 Jun 2024 09:53:21 +0200
Date: Sun, 9 Jun 2024 09:53:20 +0200
From: Johan Hovold <johan@kernel.org>
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Steev Klimaszewski <steev@kali.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev
Subject: cpufreq/thermal regression in 6.10
Message-ID: <ZmVfcEOxmjUHZTSX@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Steev reported to me off-list that the CPU frequency of the big cores on
the Lenovo ThinkPad X13s sometimes appears to get stuck at a low
frequency with 6.10-rc2.

I just confirmed that once the cores are fully throttled (using the
stepwise thermal governor) due to the skin temperature reaching the
first trip point, scaling_max_freq gets stuck at the next OPP:

	cpu4/cpufreq/scaling_max_freq:940800
	cpu5/cpufreq/scaling_max_freq:940800
	cpu6/cpufreq/scaling_max_freq:940800
	cpu7/cpufreq/scaling_max_freq:940800

when the temperature drops again.

This obviously leads to a massive performance drop and could possibly
also be related to reports like this one:

	https://lore.kernel.org/all/CAHk-=wjwFGQZcDinK=BkEaA8FSyVg5NaUe0BobxowxeZ5PvetA@mail.gmail.com/

I assume the regression may have been introduced by all the thermal work
that went into 6.10-rc1, but I don't have time to try to track this down
myself right now (and will be away from keyboard most of next week).

I've confirmed that 6.9 works as expected.

Johan


#regzbot introduced: v6.9..v6.10-rc2

