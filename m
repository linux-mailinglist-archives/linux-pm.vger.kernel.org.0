Return-Path: <linux-pm+bounces-14397-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A248197B9AD
	for <lists+linux-pm@lfdr.de>; Wed, 18 Sep 2024 10:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D59F41C23BD0
	for <lists+linux-pm@lfdr.de>; Wed, 18 Sep 2024 08:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0034F18990C;
	Wed, 18 Sep 2024 08:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YTea15gU"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0D917E44F;
	Wed, 18 Sep 2024 08:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726649833; cv=none; b=MY7p8qywpIzeKY6ToFduGekYMvOqVdJwL2NhXt0sdRMMjpdoRkH6LHcH62MSHyLhxdHl0bsa16EF1VrclFiJPrRmv/2wZy0OjthsEsMNxMpMVPOxddSMm+GQtodgfuzcu+F7QOULEfIT1L8ExLB6Y9vOgIcOWCT00UBnNBd2Tj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726649833; c=relaxed/simple;
	bh=UTxj8vuCMB1ru676BOaJabnV1LTuk+LYZM9c+fS0doc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=qIZEMS7SytUEZVsjR5MFz4icZNuEBD4ds/jkDsCQCAjP2q3pPptp6CS/LzI7vzdAQdE3g9u6Ba/hTupzXEcYubfFQo/NwlwsEUuk0ge2tdXBFiQlRswqki5ly9RDfJKUHzWCCBuitj2hVd50ua2G+N7eZy3AdjnOIjcgFDXoAE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YTea15gU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0FAFC4CEC3;
	Wed, 18 Sep 2024 08:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726649833;
	bh=UTxj8vuCMB1ru676BOaJabnV1LTuk+LYZM9c+fS0doc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=YTea15gU9uo/vt0rso8dV5JqkZOWGmK6/PRVLe7AvDv7VF65a5rvuwRKcEK+0Ljhh
	 Lv5wSsaxgFpKjX0Cv4nWVNYVS4aupvjK2CDp9R0rBcgMaSzcrN05Yva3lb/aZOd5g9
	 rQ9rgcakP2wP+6uQ48ENSjiUQTBnOJC5up/A6E1aexvfO+qnf/EC/oZw14zHZPtpm4
	 u3Qr4jeoW+21l9z/GYdJ89tHk24YrkKk3HxL6f5L3S2bujNxUAJO+WotIwiGm71ySd
	 sSqzuWpRbzbSbpDVAk3TnqbY/gUBBwBFEfuzSRwWvVFMm9cTnHpgsetqKQyeb+i03I
	 0k8b+W+qZ+i8A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE4853806655;
	Wed, 18 Sep 2024 08:57:16 +0000 (UTC)
Subject: Re: [GIT PULL] power-supply changes for 6.12
From: pr-tracker-bot@kernel.org
In-Reply-To: <yzvnkktljfia7cuatut6nzbgt3rl2sxrewxfvufs3bffipqru7@owejanrgjppt>
References: <yzvnkktljfia7cuatut6nzbgt3rl2sxrewxfvufs3bffipqru7@owejanrgjppt>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <yzvnkktljfia7cuatut6nzbgt3rl2sxrewxfvufs3bffipqru7@owejanrgjppt>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v6.12
X-PR-Tracked-Commit-Id: e50a57d16f897e45de1112eb6478577b197fab52
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 288cb34ead03c0d09932317b239f1f4d38fc9d4f
Message-Id: <172664983532.725883.8218840254823307863.pr-tracker-bot@kernel.org>
Date: Wed, 18 Sep 2024 08:57:15 +0000
To: Sebastian Reichel <sre@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 15 Sep 2024 22:41:02 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v6.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/288cb34ead03c0d09932317b239f1f4d38fc9d4f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

