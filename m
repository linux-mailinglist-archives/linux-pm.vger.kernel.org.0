Return-Path: <linux-pm+bounces-11736-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D1699425E3
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2024 07:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E5261C23795
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2024 05:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C664C634;
	Wed, 31 Jul 2024 05:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rePAAnLJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA2A49643
	for <linux-pm@vger.kernel.org>; Wed, 31 Jul 2024 05:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722404484; cv=none; b=pqAnyE5Ue2shMOvQVOMFt/pjOyU2tA+ho16gaNFL8XHQmXc0XDkWa2ajRVMsA4GIkQZxo9o6/i4UMPxh7oh81hhLCJo05Rix40ma/wtmLJ08XF+5yaveRevOkwTU/LOZleDHX+PEQTY7niqC23TUWtiwsv0rf8DhKwqgxpkiwfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722404484; c=relaxed/simple;
	bh=udgawWT/viH4w3BqItpWKohYjFnRYuoHE3e+68sQ8zA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N8r6H68mgQbTzKT4IFwHWyACXUq9x29e8j7qJuMkmTluS4dDs0KhLXdxoO5u2U8teKyUuBlap41/oZyKV2d/ASsJ4Kaw134aTEiPXBIzBF3h8npNwvNhA/C8VszTf8Rni/SO4DLD+FR8NvfFUi0KlYaW3FMztNbDtI17JFa2QWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rePAAnLJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AB939C4AF11
	for <linux-pm@vger.kernel.org>; Wed, 31 Jul 2024 05:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722404484;
	bh=udgawWT/viH4w3BqItpWKohYjFnRYuoHE3e+68sQ8zA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=rePAAnLJ50ZmJG7bdxoY01IJmmYUKRD5mHxzkTRT6WCTe7bRXUsGMY4IQKldxD6Nd
	 bW7AHnX1olUyIigHvq4yw1ZUNj3cNemrr22917dDcxszPVagfQalvQPfwFdbRjvN5l
	 pOD9IA5/pEN27XTabFxEPUD4wHfcP/upsfSTbGvt5PNZP8oqwC/z0BpWjw1J245ITn
	 vTjxLpGJiZZzH9mO5o6kNg+OUm8UlaFTLJrp1jMPVp6JpKmqLSV/1n2zHkYhL+4CYD
	 sPcAXLoZfTTB0OmnJ1A6GsjryQt0Ssn1bXpiSPivy7Uy5EWrLjWiF0eJ11A7A7Z/Zp
	 Uy/Y4fr3QARHg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id A44B5C53B50; Wed, 31 Jul 2024 05:41:24 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218686] Fail to set energy_performance_preference of amd
 processor on asus ga403uv
Date: Wed, 31 Jul 2024 05:41:24 +0000
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
X-Bugzilla-Resolution: DOCUMENTED
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218686-137361-x8fyLVswoI@https.bugzilla.kernel.org/>
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

--- Comment #63 from Perry Yuan(AMD) (Perry.Yuan@amd.com) ---
Hello,   Thank you for your message. I am currently out of the office for L=
abor
Day Holiday. If you have any urgent issues or need CPPC, Hetero Core related
urgent assistance, please reach out to [Limonciello, Mario]. For non-urgent
matters, I will respond to your email as soon as possible upon my return on
[5/6]. Best wishes, Perry Yuan

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

