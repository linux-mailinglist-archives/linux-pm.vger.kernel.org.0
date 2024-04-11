Return-Path: <linux-pm+bounces-6274-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D9A8A151B
	for <lists+linux-pm@lfdr.de>; Thu, 11 Apr 2024 14:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A45741C216F1
	for <lists+linux-pm@lfdr.de>; Thu, 11 Apr 2024 12:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DCA347773;
	Thu, 11 Apr 2024 12:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oyq1tSdG"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9813399F
	for <linux-pm@vger.kernel.org>; Thu, 11 Apr 2024 12:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712840207; cv=none; b=H2gpMFQUO3hwv1GopQNMFHFPru5q/O8vZEzrXiBuFn0CuD9iPSYEovqRdj7OMteGOmpqXfNPBGxElR5OzzLlH96rfDuRp7sF1arDN0yzcfrmdf1J0hzjJsFggCcKW4ACjttPKSRwRskFYHTjOW6nX/lfpuOGmqrmmbrCSv9G28Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712840207; c=relaxed/simple;
	bh=kbTxxTbJV+Dk2o7FN5YsPjcEzWn9Y+mLFz3tDGgKh8g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CHGZUzzwmzqDcoCz1awv1ei6E7McTXkrlHuhTsmee67xsktzwpbDYjxSRPyZstTRlmACDVtWVva+TPRapUw92fTlHwY8IEV9A41UYC4JTDt3qCFJ/QJzbVVP2kzEHE/a79LgmQ8uFwlsh1AN/VzQcCP3ruR48KedZQ5ij5Rq+EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oyq1tSdG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7832CC433C7
	for <linux-pm@vger.kernel.org>; Thu, 11 Apr 2024 12:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712840206;
	bh=kbTxxTbJV+Dk2o7FN5YsPjcEzWn9Y+mLFz3tDGgKh8g=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Oyq1tSdGpJVDb/woGi6fWFif5fLdXAohV5lKIOveMYyrQifE9o04P/XSlmf5386f7
	 ffqoUUWQIXZ2FbkNh3I3qtwu00rZaobpGeChKooicCYw/KsVFeTeHZdrdGI06nyURe
	 XgXM3enZFQGVqVGRlADsFpg9i4flgRDvFPSoUTnQ/LZuHC7KfQMCK5jHar7tl5vn6R
	 MbWNTVebrX7ckvbPp/RGk3HU1zEWnOYNHp2Z5pm5jMAatZNxQO2D187JXSlIKLjESw
	 OP/+dE3f3tTuP/07SyM8LqYOj5nZpi9iZerJgg3wWGTHu71yvnWknWJeAofs468hyS
	 tEVRI5VWzlcQw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 5AD32C53BDA; Thu, 11 Apr 2024 12:56:46 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218686] Fail to set energy_performance_preference of amd
 processor on asus ga403uv
Date: Thu, 11 Apr 2024 12:56:46 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: mario.limonciello@amd.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: DOCUMENTED
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218686-137361-kLUlIG5cB1@https.bugzilla.kernel.org/>
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

--- Comment #35 from Mario Limonciello (AMD) (mario.limonciello@amd.com) ---
One more idea for you. Can you please try to go into BIOS and do "reset BIOS
default settings"? Even if you haven't changed anything this will reset any
hidden settings too in case there is a problem with one of them.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

