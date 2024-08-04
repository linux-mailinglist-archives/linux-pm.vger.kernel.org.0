Return-Path: <linux-pm+bounces-11895-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38437946F72
	for <lists+linux-pm@lfdr.de>; Sun,  4 Aug 2024 17:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4F28281476
	for <lists+linux-pm@lfdr.de>; Sun,  4 Aug 2024 15:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC843B290;
	Sun,  4 Aug 2024 15:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RibuL8xO"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A334481B4
	for <linux-pm@vger.kernel.org>; Sun,  4 Aug 2024 15:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722783616; cv=none; b=HQqNRmNqKOxgorh+itxSxUT42ufZY+i87pXhMGeczRmwOMme+5vnUYIXlzxjau6JB4N3yNl0fTzy7UnWkNke1Aq5RlRIO05Mxi/jz0QjsOvxPehz3HXwNTnQCTjEHe1k6E++aieRIf+AoA+t/xtYvuGoW48oN5njltgBPeXj1uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722783616; c=relaxed/simple;
	bh=CypcIKPCc3+zIZGzOV2/hNWVISeOnxl/v5aO2FnOsDo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mkUG0lptljfreOnCYdblID8GWdjcoNbY9njIO63cfM5MNeWknbCHXcpB/hCE69RDPtfRrI2h5ys02kfkBlu6wODWFmqzcQpEVhDT+vkywOnJlwrhNM36u8+7tDEWF7YvZRHQt+o/Egnxnk2qpjLO1PpTYEk3lbYjq0dVCPrrIMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RibuL8xO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CC278C4AF11
	for <linux-pm@vger.kernel.org>; Sun,  4 Aug 2024 15:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722783615;
	bh=CypcIKPCc3+zIZGzOV2/hNWVISeOnxl/v5aO2FnOsDo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=RibuL8xOA2N//F1sPKTmfeIyZ5RQzHZsyV5vhDJ26iRgGPH5tM2EbrPI4G9vUqz7z
	 OuBlhMo80aePbG7E487jtvxnvEYdaymr6Ufr3EFWQhFvH5XjXbauJLKWlQpUw+T+AK
	 56nAxRGHrLXybVJV66xxaRvmfhiuB0VK1+/domeBpcBP7O5ik1P9TWwzIeITCf5dQ4
	 F/IgfEemVvvBeEOUO7MDuCKtoeBT54MXjTIMuMZhQ0FT+21mno1TO/DlFJN2Ohf2rk
	 DtdJo60TLBofedvtTuMPVJeBvphcJbkbq36IYUdss3d2XfSl8VeMzPattIc/IBVnwr
	 7mopkdjKbNL0Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id C24A9C53B50; Sun,  4 Aug 2024 15:00:15 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218686] Fail to set energy_performance_preference of amd
 processor on asus ga403uv
Date: Sun, 04 Aug 2024 15:00:15 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: dacian.bujor@phoneresq.eu
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: DOCUMENTED
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218686-137361-i3CAl5mhCY@https.bugzilla.kernel.org/>
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

--- Comment #71 from Dacian B (dacian.bujor@phoneresq.eu) ---
After reading @Chema's last comments, i also booted up Smokeless UAMF and t=
ried
to find the CPPC setting, but for me it seems its not there... From Arch's
wiki: "Change Enable CPPC , usually found in the AMD CBS > NBIO > SMU > CPP=
C,
from Auto to Enabled, or any similar settings in your UEFI. If they are not
present, consult the vendor website for an update."

When i access the CBS section in UAMF i have options only to set iGPU stuff
(and limited at the frame buffer size).

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

