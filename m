Return-Path: <linux-pm+bounces-2329-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3101C83137F
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jan 2024 08:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD333283FE4
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jan 2024 07:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D999C14F;
	Thu, 18 Jan 2024 07:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n+5Az7+W"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A537C126
	for <linux-pm@vger.kernel.org>; Thu, 18 Jan 2024 07:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705564683; cv=none; b=u2iASj8TmTrtoqr8m85RObjS9T01X5Wt7ro3q8MkBwpEk2fQEstsBzRsWhUZNK221ClONIaGjY9axLukWjVS+BeP9QWprElPoIf3obVn+7/6w4q0JS0Xqhg2js0PcZP4NPwJaRzz3qOvAA8V7LoOWJr5fD7VcE+0iHAaV/hn6WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705564683; c=relaxed/simple;
	bh=jivxUz3kKmBZhFvt9dSnA9QvT6zjeJ8yBX422Ok2d8U=;
	h=Received:DKIM-Signature:Received:From:To:Subject:Date:
	 X-Bugzilla-Reason:X-Bugzilla-Type:X-Bugzilla-Watch-Reason:
	 X-Bugzilla-Product:X-Bugzilla-Component:X-Bugzilla-Version:
	 X-Bugzilla-Keywords:X-Bugzilla-Severity:X-Bugzilla-Who:
	 X-Bugzilla-Status:X-Bugzilla-Resolution:X-Bugzilla-Priority:
	 X-Bugzilla-Assigned-To:X-Bugzilla-Flags:X-Bugzilla-Changed-Fields:
	 Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:X-Bugzilla-URL:Auto-Submitted:
	 MIME-Version; b=HgGIF1/svd6jka7UuMH1ekyeRg9IxJdsS1kENj7GQzhZsspGt0xpt5I3rrO3EbKoNiXtu0AETE8cR8QvAblOuIpk3c2/UUgUhHYQ5lTeaKFgx0/EpkJ1WBfaK+MoMPtrGSPHJL0Ft3WhaGUTYZrf9P6wOuU9hq6mMt/1gvurpyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n+5Az7+W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D4D8BC43399
	for <linux-pm@vger.kernel.org>; Thu, 18 Jan 2024 07:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705564682;
	bh=jivxUz3kKmBZhFvt9dSnA9QvT6zjeJ8yBX422Ok2d8U=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=n+5Az7+We9AO88cacvDmek8PgIFDGx772eej/FGCqQ5C30hj/cHqVljO0Rz7M4p0b
	 jza1sgqXnWweVlep6P+TV6PJuz49o/7FJGBsQW7R4vIhNXnhkc8rHzvE4RxLHhC0VW
	 wJiiuW0pVHdVwiFJfTxTBKE9X5VlyN+FjOrvir6Fi+pjpRoGtI/TvCzBxwr9csIHET
	 lN5aMr0pSiBSozJd0gthwssBYhxBMxiDDnok8OGVBGM0GOCINUp7ZToiW7XoqJpUIg
	 hiKiZgkEjer1biD5U2Ru04jShOB3po87m3qpL+x3RJ3v+egneUJuNSmk9dT1AGEgCw
	 LqkMHhoQot1jA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id C0F46C53BCD; Thu, 18 Jan 2024 07:58:02 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 217931] amd-pstate lacks crucial features: CPU frequency and
 boost control
Date: Thu, 18 Jan 2024 07:58:02 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: alex.delorenzo@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-217931-137361-FN2bIibP0q@https.bugzilla.kernel.org/>
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

AlexDeLorenzo.dev (alex.delorenzo@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |alex.delorenzo@gmail.com

--- Comment #15 from AlexDeLorenzo.dev (alex.delorenzo@gmail.com) ---
Can confirm the same behavior Pedro experienced with 6.7.0. Definitely is o=
dd.=20

One way I've reliably found to set a max frequency is to first set the
frequency you desire, and then set the max frequency to a value that is eit=
her
lower than the minimum, or higher than the maximum, supported frequencies.

Seemingly related, but as of 6.7.0, the system sometimes gets stuck at its
lowest supported frequency, requiring a manual increase to the maximum
frequency that involves the process I described above. It's the issue that =
led
down this rabbit hole originally.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

