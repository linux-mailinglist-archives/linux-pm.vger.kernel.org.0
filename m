Return-Path: <linux-pm+bounces-7097-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D797D8B24F0
	for <lists+linux-pm@lfdr.de>; Thu, 25 Apr 2024 17:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D8B71F215A7
	for <lists+linux-pm@lfdr.de>; Thu, 25 Apr 2024 15:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B4514A4F7;
	Thu, 25 Apr 2024 15:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gN+93CER"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39A438398
	for <linux-pm@vger.kernel.org>; Thu, 25 Apr 2024 15:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714058484; cv=none; b=hAAoQDMVeMmedoRaRGRre70LxTO7NQ2vNK1DDK2uUqVndYEU3mQ6n0OsuyCwL6EAnyJ/fKrti7kbC4cAPPR9ct/mKZLt/mUxdZgWK2WniFQ4qlocR7jfCMog3QEQGXv4TCMh99WlIC8+hpoaa/o19mUAmKS6kPJZV/Pumckqa/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714058484; c=relaxed/simple;
	bh=ouOnUXASRjQbAQY7DZIkPJtTchNF7rdC28disU828Ac=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GQl9dBnC9hzyvk4O0w16/zvwkZkbzk9bESe8BX0tCrMLLW+VZyRywT1DZKBkwWDrGFq6UYm0YIBB4UJIUyNlsO5+CWz5uX2a948N9hOqY0mZXjGvJ2pEIo/UpTTwk3MjDoiJZEPnMOb//+jvGeXe7VX3PRYXLuq0U5WfFcGwTaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gN+93CER; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BFA8CC113CC
	for <linux-pm@vger.kernel.org>; Thu, 25 Apr 2024 15:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714058483;
	bh=ouOnUXASRjQbAQY7DZIkPJtTchNF7rdC28disU828Ac=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=gN+93CERSm0nOVY1Tx/67npG3x5g/cjnSjp5Ez+OgHvVyt0uZdoaoMM1AH7wXUmYm
	 RSo3JGQVDQvMUshPeGPfS5/QpONJJxn+vQciLaRUhYoP4VFo2kI7EUZUGsRtFHTFkT
	 9SSREeC0WYk8oMrYr1rfBfQNa0ZblAgU2DFxfQBaq2WF3kl9iWXgMS4rd7wX9JGqwP
	 oFo0tZf4Stn2BDQ3+smf8CCQpMVvQdQAA27uA98mvchSWuvAwnJzeOGtSMXOHGM1po
	 AbqNLuo+8FNtxhxQ+nvFgdpF4bSEfKe5uQQrtXI9dofs/tqmUh+r8wSWOriRl3DCQO
	 vREajhMNTJhwg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id B31AAC43230; Thu, 25 Apr 2024 15:21:23 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218759] 6.9-rc kernels - with Ryzen 7840HS CPU single core
 never boosts to max frequency
Date: Thu, 25 Apr 2024 15:21:23 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: gahabana@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218759-137361-aouEBDZW92@https.bugzilla.kernel.org/>
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

--- Comment #7 from Gaha (gahabana@gmail.com) ---
FYI - sorry if obvious to you & the team - i tried manually compiling 6.8.7=
 and
it works fine. I tried to see if these patches can be applied to it, but th=
at
is not the case.
Therefore am certain that whatever is causing scaling in single core worklo=
ads
not to work it is result of the changes made between 6.8 and 6.9
Appreciate this may not help but here it is.

thank you

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

