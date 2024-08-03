Return-Path: <linux-pm+bounces-11877-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F407946AE7
	for <lists+linux-pm@lfdr.de>; Sat,  3 Aug 2024 20:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8F761F214B6
	for <lists+linux-pm@lfdr.de>; Sat,  3 Aug 2024 18:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3521BC40;
	Sat,  3 Aug 2024 18:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ld1Mm7JM"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9EC182C9
	for <linux-pm@vger.kernel.org>; Sat,  3 Aug 2024 18:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722711382; cv=none; b=aj/jJf6R+uZ8zxSJrewZE1YvbalAva4PMA8hzWz1k07UHFZs5tM0eTwT4X++cCONH9IE2BOyFpfrCtxA4pc7iuTmI/wmI4TKTPULLIc7tEcabGP3D5Ew4+O7Q16KILChGefNDFC6bviqSWw5pIUcYjWFkks9PpNkhCIk+2ilUjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722711382; c=relaxed/simple;
	bh=2mBuMQeepXc5izbWCgUMF2AA1aYiSvlK3RkJWBMd4RM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CnhJPEKqqW91dwePkcaJQi6roRYcOfNQ2Yc6QMBqN9vK4tiusK58qL7rOrhnTHXU6FcQyh+whwMDIsY7+NYJyBRpqEoaz2fUtl+8PMegNAjNmrw25bAtf8/u2cw2k4FXlZUSqAMl0wCzmGnQJ+s0/hNlqyuPdM1o0XSdAUbxc5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ld1Mm7JM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B6E67C4AF0F
	for <linux-pm@vger.kernel.org>; Sat,  3 Aug 2024 18:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722711381;
	bh=2mBuMQeepXc5izbWCgUMF2AA1aYiSvlK3RkJWBMd4RM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Ld1Mm7JMXYq9HI0Wst5oAQt8DbEAjdImHrv+B7E7eDrCv4+AIfBn9L/uKBLjgVWUN
	 pTr8aeIwYkJr/S5Vz6PsfSpEsqn7B7AzCe1rD9xoGwBpNYrqXp2yHrfOgukv6VwJNe
	 9k8+KTPEqX4Io7e4LM1o/8DNQI8hzo1MmNzmymofl/dA5/cftauwVPll9tE3H/dc7M
	 +CvNINtqi+7XzSvfylFojk0gZDf6qBsDby5tvYsJx8JSRL89p5lY802jMDE172IeNu
	 atKGJeTfNehFqKmbPPRfHsqpmNuX1dQ7t9kYEnfWxKYtph9ewkFqH18Q6KU66y6ei/
	 yiJBIBcBYQYpg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id B0050C53B7E; Sat,  3 Aug 2024 18:56:21 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218686] Fail to set energy_performance_preference of amd
 processor on asus ga403uv
Date: Sat, 03 Aug 2024 18:56:20 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: chemasanchezgarabito@gmail.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: DOCUMENTED
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-218686-137361-J3Co6JyDhT@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218686-137361@https.bugzilla.kernel.org/>
References: <bug-218686-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218686

--- Comment #70 from Chema (chemasanchezgarabito@gmail.com) ---
Created attachment 306662
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D306662&action=3Dedit
The second video of the smokeless uamf video

Second video

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

