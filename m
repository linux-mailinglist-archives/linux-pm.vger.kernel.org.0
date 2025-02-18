Return-Path: <linux-pm+bounces-22295-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D44A397BF
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2025 10:57:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16B6C16B9B2
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2025 09:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857A2232379;
	Tue, 18 Feb 2025 09:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WA8J0MHI"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F23653
	for <linux-pm@vger.kernel.org>; Tue, 18 Feb 2025 09:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739872426; cv=none; b=SQjFbITU7UKl8HjbOZ04zBoKFKrsbaQ6GG+nsrBS6IhMYagxuU4j7YxgC/alotTMdfqi+uOzRI22oYvsHId73rpDq9l5cpNvO1NI+gEvyMuriQir7wK2bfkkgOp8sL9L3hfuLYggrczl6cJzTo8ayX4Ljo2nJHBvuMrZyDwqgWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739872426; c=relaxed/simple;
	bh=S0CfAoPndi2JuasW8OIciFgMWdJNvhex/d7ZyE7/G7U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jsg0zYjxk+H9wls8VLeNUczBADNT/KBKixBLQK7ZDqsJy8T7ax/1nEG8P9pnQp/DiEDG+2IPs8myClypJQFpF1BBhHtM6JA1EdbekaGNDXQegF8zaLUaD+tOwWtsF16fKuZqXn7IZsQyoX4ZAoyjSgTdbVl34JdNrvsKcCkrBWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WA8J0MHI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C203DC4CEED
	for <linux-pm@vger.kernel.org>; Tue, 18 Feb 2025 09:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739872425;
	bh=S0CfAoPndi2JuasW8OIciFgMWdJNvhex/d7ZyE7/G7U=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=WA8J0MHITA7tSlIiimX48CR0yzSj2Iu0q/F1xMYLoDFBG4DlEAsIb8X+BnvLl+yXJ
	 q07SECzuQDVP/r1CGuUyC/hfJVYqgsqZrEh8IFeYTsyVFcqNnR13FeAmOE6DOnAAi4
	 0z0vkpz3sdDCuyaF5K7ldcPri4jKcIRvHJMRpx3puifj1zolALC5apFvlpeR5Mja5n
	 T6Nso8boJrVXu9FWAW4LaSJ+mlwUL9UpfJukYwhoLW3LkCky/Uvp7FyJTQ2u7qMZfm
	 wY2ZFu/r/jlWUbMvISKA+3kostz+CJ0cjVGCZrN5DnIAqTj3F1oXI56Bw5Ijvwt2bC
	 Jly8MC/SidFVA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id BB1CDC41615; Tue, 18 Feb 2025 09:53:45 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 217931] amd-pstate lacks crucial features: CPU frequency and
 boost control
Date: Tue, 18 Feb 2025 09:53:45 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-217931-137361-9p0mKrxqnz@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217931-137361@https.bugzilla.kernel.org/>
References: <bug-217931-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D217931

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |CODE_FIX

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

