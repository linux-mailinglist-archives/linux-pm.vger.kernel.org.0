Return-Path: <linux-pm+bounces-20990-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BAC8A202D9
	for <lists+linux-pm@lfdr.de>; Tue, 28 Jan 2025 02:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69FA1164061
	for <lists+linux-pm@lfdr.de>; Tue, 28 Jan 2025 01:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92BBD42070;
	Tue, 28 Jan 2025 01:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FRxQ67Iy"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682453BBF0;
	Tue, 28 Jan 2025 01:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738026423; cv=none; b=MlytdYOeyfVP3aT67ij0Hi75CoQ+b9SEtzaTolBN0/KwNSICofPuQ23AGOHqJszLaJKLCyi5XIbvkd8M4cjSdpZwObHmP+es974sYJdnk3t1xtICiQ8AQ2CjdANrFtQzMr49aQ/OW57+m9UmoszKC4ztXSxPTBnpMC9gTue7UIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738026423; c=relaxed/simple;
	bh=jfJnJJ3Cwm+qjvVQTSPSIoPlaFtef1eAjpF5bZdUQWU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=pAuduZUFCxqQ9fhew6Wk/6BhGM9uGYZJPkCvKF3ij+TBykw6ibAxEab804gGRyu5hwG7j09vrfGBh+iji9OZShKa/yHZUjbEZq3w0/3qe1NvjWN2oe0XDTW6UEniCjnu4vpbRjLsQErX+ZehGYveyFdaZKW4/R9dgB1dvPEsu8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FRxQ67Iy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1173C4CED2;
	Tue, 28 Jan 2025 01:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738026422;
	bh=jfJnJJ3Cwm+qjvVQTSPSIoPlaFtef1eAjpF5bZdUQWU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=FRxQ67Iyqsk9Z7hf7Uhvrr5G3LvzKF3tJYtajFxmEXf4d17JWeRjQVHc7MJSiY4Jx
	 cbZVCGcqjVBpnpKVAwCr4ID68av9jBB3MlZznfCAgsE8GWTDCVEsN6CNg7gBsD04WV
	 pBTi0lNHc2e4dIyfoxklkkNr8EMCf/CNWdclQKhGAVf4vfZP79bBNte3p2CwquL8CR
	 XkD44doZ2fePFzsjN8UEBKlD7f1VnnzgqBZBKLR4eFPi/POWArDldIFpIw+Sz6rPsu
	 HtHOpyIqW9tpKx+9x6u6cJ0hgO7jT9ONePjfTKuqaIxwPPjtrH1DTonIbCwdd9XSRa
	 f3WH0nHNPa8sw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADDFA380AA63;
	Tue, 28 Jan 2025 01:07:29 +0000 (UTC)
Subject: Re: [GIT PULL] power-supply changes for 6.14
From: pr-tracker-bot@kernel.org
In-Reply-To: <epxxhdzetjg55wv4gmzaszcoao26p6n5onujohcvgf7accw2eq@tx5qg6nr2c5y>
References: <epxxhdzetjg55wv4gmzaszcoao26p6n5onujohcvgf7accw2eq@tx5qg6nr2c5y>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <epxxhdzetjg55wv4gmzaszcoao26p6n5onujohcvgf7accw2eq@tx5qg6nr2c5y>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v6.14
X-PR-Tracked-Commit-Id: b4a95b8fd3e67c1222c76bdd1078d43c9a11d132
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f28f4890454cc97c18d31ab4686957857cc862b5
Message-Id: <173802644838.3281647.15041967415552750979.pr-tracker-bot@kernel.org>
Date: Tue, 28 Jan 2025 01:07:28 +0000
To: Sebastian Reichel <sre@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 27 Jan 2025 16:26:34 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v6.14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f28f4890454cc97c18d31ab4686957857cc862b5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

