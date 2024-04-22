Return-Path: <linux-pm+bounces-6764-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EBAF8AC66B
	for <lists+linux-pm@lfdr.de>; Mon, 22 Apr 2024 10:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23DE61F214EB
	for <lists+linux-pm@lfdr.de>; Mon, 22 Apr 2024 08:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F08C4E1D1;
	Mon, 22 Apr 2024 08:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hgrdzqkq"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C8C4D5BD
	for <linux-pm@vger.kernel.org>; Mon, 22 Apr 2024 08:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713773567; cv=none; b=bdlytZ1Yqcir910VYsNrzFqeriGUuV+qqjDWmj3h0NJHdxwky3AFLM6Qp/GQWK1DHt7Ah48EeMMZ39hVtmyNGmx9AXntSkxKB6wxzwJEqR6eCx7qJRrK/RI8FGKihxuLv+aTW4L2v7OJmz5CFPu3c1dHxfYMmQaGHQIVQA753zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713773567; c=relaxed/simple;
	bh=aaDvbP+95YtbC7gw8qS4pecOd1aYwbZPFlBevu0qIEs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MInhtyO0vYAI33W78gUmAztcWuAOdFJ8fZcPkQ2woP2fuuYg4RCislmxA9UX9NAkxD09liKu8M/quQPVZgUSZZIpwuvDrsQo/OqAmelXvQD+WlVmx0ERCUORmaRp0dQLwrCmMzDI22Ai+sBDBGP/R/YLRudcw26r7E63k63SGvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hgrdzqkq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1F20DC113CC
	for <linux-pm@vger.kernel.org>; Mon, 22 Apr 2024 08:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713773567;
	bh=aaDvbP+95YtbC7gw8qS4pecOd1aYwbZPFlBevu0qIEs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=HgrdzqkqkD85mIspJ2wR3WEzZU9tx5W2S6a+5oGXgF+DOOQ5ftr/pwqQ6hjoPs2/y
	 C6iqa+RIU6avFRSs/w8o3T06mHw1B1e6t9aC63jLXw42zQinqSnekToDWOIe6uYa5A
	 Cw0tG1ZSo9pYn9BORnCHPeHiMSB5bdCW92kITyoVrcIh1f7WASaO1RjuUMb6wuTqrL
	 5P6rAfiTSczT+dVk/oZ5f+EgJSdoAdG+KvURs4wtB8jheR7HVFFaaZBriDCqJl298W
	 jeSE/maiO7JjBI/o+cZTEL+hC8H2FG9PQ+XSt+hWMB3GhowW4HxgN7zvY9vkFCjgja
	 Bd0V5BjucYSKA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 12431C433E3; Mon, 22 Apr 2024 08:12:47 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218759] 6.9-rc kernels - with Ryzen 7840HS CPU single core
 never boosts to max frequency
Date: Mon, 22 Apr 2024 08:12:46 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: Perry.Yuan@amd.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-218759-137361-WNluPOeLqO@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218759-137361@https.bugzilla.kernel.org/>
References: <bug-218759-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

https://bugzilla.kernel.org/show_bug.cgi?id=3D218759

--- Comment #1 from Perry Yuan(AMD) (Perry.Yuan@amd.com) ---
Created attachment 306193
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D306193&action=3Dedit
cppc check script

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

