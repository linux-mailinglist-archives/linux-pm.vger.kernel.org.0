Return-Path: <linux-pm+bounces-24396-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0569A6BFA1
	for <lists+linux-pm@lfdr.de>; Fri, 21 Mar 2025 17:20:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F36DA48541B
	for <lists+linux-pm@lfdr.de>; Fri, 21 Mar 2025 16:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A338822D4F1;
	Fri, 21 Mar 2025 16:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rcUunUx8"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2C822D4EB
	for <linux-pm@vger.kernel.org>; Fri, 21 Mar 2025 16:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742573938; cv=none; b=VRNfSV+oh3wOpjAvXlepWa3jRcwyOqVhydOWGdoZVrc1m6orUtt+2Dg2uSf7HBlUUyXep9s9cSrQffzOlCAWydpmFT42TyzF3CPRC9X8FhVSCGqC/qtrs8T6ZJdH77xATFap+65bYT7KhIsJWEJPtd37v0VISTArqR49W6DS21E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742573938; c=relaxed/simple;
	bh=6yHsATWOqEw5DDf04Pq1SRKIVpjpOOw68aszmWtDVU4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M+y73ChHwLQf2xFk8kQJS3kPA1h9gMh8gTH7fLn0vlciJ7kI1W/9Vks+enCdCzpi8a8lHQ1iliez4lPuxf05oyjZ0UBNC0wtjPIR9ex8yF1Vk/i5LwQkYfIRpmiLVJz6E3b4moCj1wq8hp5tXtrYcps1Gv5BdSpbX79TC1xNqd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rcUunUx8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id ECC69C4CEF2
	for <linux-pm@vger.kernel.org>; Fri, 21 Mar 2025 16:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742573937;
	bh=6yHsATWOqEw5DDf04Pq1SRKIVpjpOOw68aszmWtDVU4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=rcUunUx8AWds6lYh8VWmIyo0KFqtaTGPZLJoQosJPiXIkfny5EuYp4Z5t2DkXYMRk
	 66xIARCZV0xHo40184kvj+fhiiXr+HADBLE311xtVvAlp1vThEU6GsgxwcC3/rOlDv
	 PrjdAIQM3hQhdqC7fpIrLCuJNXGaLKczQnB7yc0An2rpsXJmEHZis8DubaSFhexKgI
	 0/jLXqQFgWhuqm7ZohTS+qgIX+ML9gX2FDdAzmYuJICsnDaoFdgbuy/V3Z2EpK9wy8
	 pfuk55P85+1GgZxedjsbBuCo9y42Tlky0ncYvt467X8E8h0rU4ipKftuk5h/9ijup5
	 b87gyy0mKb7bg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id E5282C4160E; Fri, 21 Mar 2025 16:18:56 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 219858] AMD Zen 2 broken power management after sleep
Date: Fri, 21 Mar 2025 16:18:56 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: mario.limonciello@amd.com
X-Bugzilla-Status: ASSIGNED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: mario.limonciello@amd.com
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status assigned_to
Message-ID: <bug-219858-137361-G3UPgTH9Vj@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219858-137361@https.bugzilla.kernel.org/>
References: <bug-219858-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219858

Mario Limonciello (AMD) (mario.limonciello@amd.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |ASSIGNED
           Assignee|linux-pm@vger.kernel.org    |mario.limonciello@amd.com

--- Comment #8 from Mario Limonciello (AMD) (mario.limonciello@amd.com) ---
> not sure that was the best way to send the report, sorry!

Yeah attachment would have been better.  But no worry, hopefully it's the r=
oot
cause I suspect and thus a duplicate of
https://bugzilla.kernel.org/show_bug.cgi?id=3D217931

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

