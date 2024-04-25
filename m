Return-Path: <linux-pm+bounces-7103-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 516628B2515
	for <lists+linux-pm@lfdr.de>; Thu, 25 Apr 2024 17:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D89B2824C7
	for <lists+linux-pm@lfdr.de>; Thu, 25 Apr 2024 15:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66B514A0BD;
	Thu, 25 Apr 2024 15:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P0ZTkorL"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9202838398
	for <linux-pm@vger.kernel.org>; Thu, 25 Apr 2024 15:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714058875; cv=none; b=P19ubwDmkPhRP1Jgy3lvvmRVuo2+32WORopr04ALiyvLRAxS6tYyG3dCYd3Bu2HvllCdg89E6nPijYP5JtyEVHbpTQN4WnDM3nRD+3DIovqwMjmYFjeumykm9dLDC4R+LJmkMeu3vWKiGkZ3sI/MOhJ/YKqSfdIPGmBfs77TWYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714058875; c=relaxed/simple;
	bh=9m8EToH4wUiBqhVSmCS64wMgwupAWOok4G1w46gUdN4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c3q72d7iFeY+RraqjLtKmH4n6mI4ev/oiskHy3xT4dJG0h/r9EmRXoeUn57j7ztRsuMsXNyr9HIdK32HuDVABW3TeRRvaiC/Sj1SqWbaRajgfhZjeh4YKL47g+ZwVPjDMDL8oGwbZzhq9Q0fF/ibroermoLBsJPS7fHzTdgS5WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P0ZTkorL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 71A0DC113CE
	for <linux-pm@vger.kernel.org>; Thu, 25 Apr 2024 15:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714058875;
	bh=9m8EToH4wUiBqhVSmCS64wMgwupAWOok4G1w46gUdN4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=P0ZTkorLu7XBTbw74qIzQaP3ZExW/iBrHzJ2o6bgOngR9yKZa9Lpocooznmx7U9Rr
	 BLOWv7CWBriLLLZ4kSVzr/TeNk3sLBOmUiWEi66FS3pQi/iZRTxEMi2EWLINN9zQId
	 hUTgLtNAcVsLkdiTdjS3Je3ToO8/H749rit9gpS4hDkyiwtRHvtAjjttxZ/SpL+DV+
	 yxXUOAu9kakcEsy6lRtLbj3UGyxTPUL01UZLyzg3fmi1xJhyVxTRQfIb1N8aRj0f8b
	 IQWBoqW9waEpblBUP1gF+TUcDPq3DadNLNyrGJu6u9fyFFeuBpz4Vvwn2hgDdoQ7jV
	 BUhHd/n4YF3Yw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 6B9E5C433E5; Thu, 25 Apr 2024 15:27:55 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218705] amd_pstate fails to load on AMD 5950x with Asus ROG
 CROSSHAIR VIII DARK HERO x570
Date: Thu, 25 Apr 2024 15:27:54 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: andamu@posteo.net
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-218705-137361-cvBUqKNUbG@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218705-137361@https.bugzilla.kernel.org/>
References: <bug-218705-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218705

--- Comment #14 from Andrei Amuraritei (andamu@posteo.net) ---
Created attachment 306212
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D306212&action=3Dedit
lscpu -ae with amd_pstate=3Dactive

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

