Return-Path: <linux-pm+bounces-2265-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F2082FF34
	for <lists+linux-pm@lfdr.de>; Wed, 17 Jan 2024 04:14:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B3F7B23417
	for <lists+linux-pm@lfdr.de>; Wed, 17 Jan 2024 03:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CDE210F5;
	Wed, 17 Jan 2024 03:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I6OjvojU"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F85125B0
	for <linux-pm@vger.kernel.org>; Wed, 17 Jan 2024 03:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705461162; cv=none; b=cSzlnJBVUdzY03xDMFT+BjubgKMjuXJlmYZU2+M6kag3XYZFSeoqZvaoeVY6K2swwY43Hs2eX/bjoZhMtiuETnfZUhOliNp0+mnshb4GjeCeTKON3aN4Z9O564O+6CSckN5uuFhwn5Y4Qp3hIqd2r5NEpgyxrdkvBt0HyOGjAzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705461162; c=relaxed/simple;
	bh=+9SjZAyPtPr8ezs3ZjuAl23icD+OeqjNw+bRC2lJRAo=;
	h=Received:DKIM-Signature:Received:From:To:Subject:Date:
	 X-Bugzilla-Reason:X-Bugzilla-Type:X-Bugzilla-Watch-Reason:
	 X-Bugzilla-Product:X-Bugzilla-Component:X-Bugzilla-Version:
	 X-Bugzilla-Keywords:X-Bugzilla-Severity:X-Bugzilla-Who:
	 X-Bugzilla-Status:X-Bugzilla-Resolution:X-Bugzilla-Priority:
	 X-Bugzilla-Assigned-To:X-Bugzilla-Flags:X-Bugzilla-Changed-Fields:
	 Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:X-Bugzilla-URL:Auto-Submitted:
	 MIME-Version; b=RVurWE073JVu48UdK30QSH9dM8L1NSkMOYtMwq1bhfRK1VJYJ9LGUOBSNa3zvdgNYN2eK7cnTt3jiaPtaoeh1rCHbYFMX5FhnnttZSn16Z3Por1bXZG4YqIdG8VcAIL9OXGsM29okqhvzv6PyG95r9Tcg8ip0G5TByvQYyI4tPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I6OjvojU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BE37CC43394
	for <linux-pm@vger.kernel.org>; Wed, 17 Jan 2024 03:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705461161;
	bh=+9SjZAyPtPr8ezs3ZjuAl23icD+OeqjNw+bRC2lJRAo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=I6OjvojUdhvp9gkuQFBScCab0+gVNoC/Nle9xmbcfvk1XUFAXOhUKHN1pJdnbOMW1
	 /lBgO66xyD4wynnqVZxnBNxoAOq0+wDSITwv6iHPUSYbuv/YSchc1gN9QvRlPRyNPT
	 Ssqbmd9Jn8KGps/LkwQH5hGhQDrq/NZZllEue+wHeMBSoLn8I30rDfgKn8DsBYZT64
	 Li1IXOBNT9wjSxZRe1WM97vb+poIRml4FoPRLjBRpC6cvQ7mPnnmbRWI2nu+aEeS3r
	 +oihQiwh4FrM/hACfHKGcOc9U+uHSrJEo7vRJ7xba2AsEMH5ne487TGy5408Q+P8TT
	 /jaFTyhg974sg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id AB91DC4332E; Wed, 17 Jan 2024 03:12:41 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218171] amd-pstate not loading on zen2 threadripper 3960x
 (trx40
Date: Wed, 17 Jan 2024 03:12:41 +0000
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
Message-ID: <bug-218171-137361-RA2LrMYzys@https.bugzilla.kernel.org/>
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

--- Comment #26 from Perry Yuan(AMD) (Perry.Yuan@amd.com) ---
(In reply to Alessio Di Sandro from comment #25)
> Comment on attachment 305722 [details]
> ACPI tables for TR 3970X on MSI Creator TRX40
>=20
> Same behaviour on a MSI Creator TRX40, TR 3970X, BIOS version 7C59v17
> (latest), CPPC options enabled in the BIOS, Linux 6.6.11.
>=20
> It may very well be the board vendors being lazy, but it seems a bit fishy
> that ALL of them have the same CPPC problem. With my MSI report, aren't
> these the entirety of the TRX40 boards?

thanks for the more information, please also submit ticket to board vendor =
to
request the issue fix, looks like the Bit Offset values are not correctly
initialized.=20


   ResourceTemplate ()
            {
                Register (PCC,
                    0x20,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            },

            ResourceTemplate ()
            {
                Register (PCC,
                    0x20,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000004, // Address
                    ,)
            },

 Perry.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

