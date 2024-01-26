Return-Path: <linux-pm+bounces-2785-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB4383D378
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jan 2024 05:34:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1703D1F24400
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jan 2024 04:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82759637;
	Fri, 26 Jan 2024 04:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tVNq/+Wo"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBD219B
	for <linux-pm@vger.kernel.org>; Fri, 26 Jan 2024 04:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706243637; cv=none; b=YmI92pZNk4YFEEB9FYhh6q8gS2vOZyuXCk/UiBEWtNlgIjq3655YBy4zUyDGsZ26JQ7MRyc0/fIwqxQebYFctweTkc+wgki/ubW6kAl4bTe4OumWdYgt5P91qbeDClMQpbgFBgcTle4dicDfCrIVeVBVrrbB6f81X7SZVlHHQ0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706243637; c=relaxed/simple;
	bh=2oZ8DiliGEk4Wk0rsZWIUpKqrWqN19Dt+uNUU2ifqbI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LBjcD7Plx2S18OpL4MqTYc8kVh3genD59CuOVKa5Dx+y0fflVysoMwuJ68frOcuK0i+pqaAq6p7uqF1yP8tOc7227gh0XZb4IgaEsOHUq6JhbQbv2+2rtmVaQCC7uYn8rjYZ4RucL0ELHFonXB94kQnBU0G0o5xtYVmdgSHY6Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tVNq/+Wo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B3BF9C433A6
	for <linux-pm@vger.kernel.org>; Fri, 26 Jan 2024 04:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706243636;
	bh=2oZ8DiliGEk4Wk0rsZWIUpKqrWqN19Dt+uNUU2ifqbI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=tVNq/+WojgdIKJ4JgmnJsxR0qLBGKT2Aj0fZ50x7sD/SzJFWRTFVX1YYlePrV64C8
	 wbU7sN9Igr9ggar+Z9/DuXfkxJ5Bi4tNemA2L0oteBaJMekaK/OucB6u2OAafzspp0
	 a187jM6Gkx9ewdyWfgKQuB3KKhZGh4uuBaJIqxdfh0b+I5xjqAm6PSkMaqHbLAucv7
	 Bepw4kxilkz67wVpqd30l5sM2FfSL2bcpHpM2ftA8d35ijMET/+s/0laktdsk5GfTo
	 Qo+Xw4TKJSqxiHaY1uNHlzhgfbzptlatq7izG+2bevO33Rj9Dctfm/hTK7KpReqxTH
	 gmeCc9MyCCAag==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 9C6BBC53BD4; Fri, 26 Jan 2024 04:33:56 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218171] amd-pstate not loading on zen2 threadripper 3960x
 (trx40
Date: Fri, 26 Jan 2024 04:33:55 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: Perry.Yuan@amd.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: ANSWERED
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218171-137361-0K2vCmwnDf@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218171-137361@https.bugzilla.kernel.org/>
References: <bug-218171-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218171

--- Comment #40 from Perry Yuan(AMD) (Perry.Yuan@amd.com) ---
Thank you everyone for the testing results!!

Because of the TR40 CPU hardware pstate was implemented by CPPC V2 and shar=
ed
memory design(PCC channel), so the ACPI table is not same as MSR solution. =
it
is expected after I confirmed with internal team.=20

   ResourceTemplate ()
            {
                Register (PCC,
                    0x20,               // Bit Width
                    0x00,               // Bit Offset --> expected
                    0x0000000000000000, // Address
                    ,)
            },

Looks like all the CPPC capabilities on above tested systems are filled
correctly.
I will post the patch for kernel review.=20
Let me know if you have any other questions about this issue.=20

Perry.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

