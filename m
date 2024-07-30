Return-Path: <linux-pm+bounces-11704-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DEBA941F91
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 20:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B382285FF4
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 18:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807291482F3;
	Tue, 30 Jul 2024 18:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lSnLDQzT"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7891A76BE
	for <linux-pm@vger.kernel.org>; Tue, 30 Jul 2024 18:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722364304; cv=none; b=qcHTDNEBOpw4pQb1jj8pqI+yz/PaMCaEq2MLQVbhgp7TQq69T5DgPk7Q8BgQq1cMX9fCg1Rb3P2dHPo0/V0NRHpokAc0+qH3SSbnN+3j+RDjo6ATf7R6vlQQaKlKd/07bVISPptNQ/oMQ/YXZhJKteHkic1EAE5k9/x98xTl4pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722364304; c=relaxed/simple;
	bh=yu4MkBt+A5FPSswLoTztS01ERieWVN45hrl7O7QRw4A=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MqoyH+nUMmWwIT0olNRX3s/HbTryMaJO9WUfflGiRAzCRaRQBbEBg44HpmCM3intos10rtDr1zYGXnZqYi2KoXMfVX+u05y0pKTxwQQ+UAl9KOxDCUh+FnDJBBIDLi+HF08I98pbqx1alyldfHkN+bubN2kPQP71xesttPaIJDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lSnLDQzT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CBD8CC4AF0A
	for <linux-pm@vger.kernel.org>; Tue, 30 Jul 2024 18:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722364303;
	bh=yu4MkBt+A5FPSswLoTztS01ERieWVN45hrl7O7QRw4A=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=lSnLDQzTKJ0KSU/c7/E7wbxBSpEuyA5THwgXrAcYv9giarGNNsDWWKvuluYCA9jZp
	 tfvoRoLH6agFmYje6i5BOBJodVI9sFTH0JIWfWKqRkhJyjUGIEERqTPrXo+xToA0fK
	 zSNJNWqq+lRkBcr83uhp9UKzNMx/sDJuyk7KRJT4csuyU2hy5I2T5ekNAvShjn0EuX
	 VfA2erNAqulPBwir8CNqCKVEf3eKXj8YR18SH4GApTqp+QVUQzBEaGw/6XmkCemjJo
	 n9c4tqEd+/CRHkuh5CeLbdExS0Ws7PwaTXmJN+DpgOPrvdIJbj9dK5xkBt1LX0u6k/
	 kekiGuAwzMiDg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id C33B7C53B73; Tue, 30 Jul 2024 18:31:43 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 219110] amd-pstate's balance_performance
 energy_performance_preference doesn't survive suspend resume
Date: Tue, 30 Jul 2024 18:31:43 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: low
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P5
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: priority bug_severity
Message-ID: <bug-219110-137361-PLsfJLvBdn@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219110-137361@https.bugzilla.kernel.org/>
References: <bug-219110-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219110

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
           Priority|P3                          |P5
           Severity|normal                      |low

--- Comment #4 from Artem S. Tashkinov (aros@gmx.com) ---
> Our team now lacks resources, both human resource and project funding
> support.

That's really sad to hear.

> So it will take time.

Thanks a ton, there's no rush.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

