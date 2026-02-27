Return-Path: <linux-pm+bounces-43276-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SL1jHjz7oGlXogQAu9opvQ
	(envelope-from <linux-pm+bounces-43276-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 27 Feb 2026 03:02:36 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BDED91B1C12
	for <lists+linux-pm@lfdr.de>; Fri, 27 Feb 2026 03:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 81C8E305C8EB
	for <lists+linux-pm@lfdr.de>; Fri, 27 Feb 2026 01:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12822BDC2A;
	Fri, 27 Feb 2026 01:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jG8kCl1E"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA1825B1CB;
	Fri, 27 Feb 2026 01:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772157402; cv=none; b=egLzpi0nwTJ0Rbh7zXMuZ/kihlLCIu9QpIwps5mlQP4PQzJII0I61Vxibj39tRJurGjJn+9UdTZGU9I77M0i78G8YdBkQ6KMNBi+kFx0rJ0v8LrI4NVdNuxKocYtuoIu02c2vlYWglkIV9NIZcGNAT0IxBjDDL+wNXEusOfwGt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772157402; c=relaxed/simple;
	bh=Dr7UQksTjxeMkU1mHhZS0EURLgjJ1bWBKq4vfHMz54M=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=KdaIIVExmFz2hmPo7a2CIax6z1iql0z0h/oRGu5VcBeYu35WPfaLMW0RasrR6rqMhrmf6/0qYZE0cAOJWfH+X6M1CEnIPteFYOhLG79DvIIpLlZirY+shbx3uJ09ham4F0aps1iKz9y3jTLCK4sHH7gfFQmq+/4UD9fLn31ODCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jG8kCl1E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F6EEC116C6;
	Fri, 27 Feb 2026 01:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772157402;
	bh=Dr7UQksTjxeMkU1mHhZS0EURLgjJ1bWBKq4vfHMz54M=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=jG8kCl1EG6kA2XN40Hm6wlfs+4gwXS9G+dR8teuXvhHrJtw9omz9UDJfIr/ThzwCC
	 PRkmVuZs0DmsnjmKUwWbXWfhdtS+KvUjlPVdgr77wcISxtlCGWMKo8Xj5z6zczI1Gv
	 v5q7jJ428sUFH1IVXNayLpVhVPo7nO6yY5Vg7oSuV8A4oZrLBR+NLuiZ+4ryZPPC2Q
	 6+m4YqfI3nn+0jofD8S8V6f3EmSZyEkL24PPOBiJJJV1xE/UdKi/1wnVOeXcJzFiM2
	 J8xjhinhZxqzNPEH1x28Z4eevHzXJ9TlvuzyGvGXRnVTzjuTkdtJBpH/9irSJkP5RH
	 xvLF9jY0dbDKA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 10BD1393109B;
	Fri, 27 Feb 2026 01:56:48 +0000 (UTC)
Subject: Re: [GIT PULL] Power management updates for v7.0-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0iDdCnCYAfQVut_uFnzc46EifhRVBns2cT04M_xw-eo9w@mail.gmail.com>
References: <CAJZ5v0iDdCnCYAfQVut_uFnzc46EifhRVBns2cT04M_xw-eo9w@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0iDdCnCYAfQVut_uFnzc46EifhRVBns2cT04M_xw-eo9w@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-7.0-rc2
X-PR-Tracked-Commit-Id: b78030d0f10570845568153637c5831e27d9871f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: db5781c407dde9f1f037d312c8e0ca986f661e1a
Message-Id: <177215740677.1937342.14308318623265647073.pr-tracker-bot@kernel.org>
Date: Fri, 27 Feb 2026 01:56:46 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43276-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pr-tracker-bot@kernel.org,linux-pm@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BDED91B1C12
X-Rspamd-Action: no action

The pull request you sent on Thu, 26 Feb 2026 22:09:41 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-7.0-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/db5781c407dde9f1f037d312c8e0ca986f661e1a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

