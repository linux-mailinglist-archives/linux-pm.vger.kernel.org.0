Return-Path: <linux-pm+bounces-13862-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D51D97086B
	for <lists+linux-pm@lfdr.de>; Sun,  8 Sep 2024 17:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC351281E25
	for <lists+linux-pm@lfdr.de>; Sun,  8 Sep 2024 15:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A2A16630E;
	Sun,  8 Sep 2024 15:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MXUtkTqq"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF90C36B0D
	for <linux-pm@vger.kernel.org>; Sun,  8 Sep 2024 15:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725809667; cv=none; b=qkj/lcvmkSjfha+kFMvac4TsDiu+TlOAxL2ja0lviZRrQG39VrDUmhH+vLgqZzuMcaJpy0UropJbVA2jq8wHv4qJOIKGx4dV8HCQiLEd+CzlO0pr9PtLaHzOoJefQfOF8XbkrVr8wd6QCMJQwwbHvRND0HAm5rVzdZUGcTNm0AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725809667; c=relaxed/simple;
	bh=SlaGt6oX9i2HkxYTdRAcsqbvKC9vKBuk4v546CvZMTc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mOhH28GGFeDkSmS/0bySWRNdo+sSZerGs0U5CitHvEj+PYzDlKhhCOHbkjkGXC6rJeNKy7siUKUaAbN71XyjDNjE3rrRUapWlTjTSxo4xHtFaLuwSCFG+rDN86eZki2RC12a8FJxV0JghIIkfUpoxsgDO6rWb4J1//Y+kAqiVuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MXUtkTqq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0914FC4CECE
	for <linux-pm@vger.kernel.org>; Sun,  8 Sep 2024 15:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725809666;
	bh=SlaGt6oX9i2HkxYTdRAcsqbvKC9vKBuk4v546CvZMTc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=MXUtkTqq9xKfOVmaGUmUQ1gkg+wahPvew3eAHF8a8fsSlO/yoBsamrlPvH/3+qMm9
	 Snm8Y0SE/IK31WuS0072nMpv9JBN1af1RsbcYvtIZHMkhwqoPNiMp/SYs3aU17mxAH
	 hmw5OfdoOqHTt+6vwdlt1rcLSqOZvlIoQ45D9x4lFdetPTTfOBf32NrYaElPll60+Q
	 0ZpoLZP+u2r0dVFeW7OlWH/1cQ6NdUnF5CSrgZBu5797oK8S1R0+aixxHrqniFJ6CL
	 ENFOyaXSlZ6iUSJaKm/60x8+wdbhCkFYYlF9xS44xyfThI+JbhETFcc/kXDW2wR6iD
	 d+vB7Zo2GG2cw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 0427CC53BC3; Sun,  8 Sep 2024 15:34:26 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218686] Fail to set energy_performance_preference of amd
 processor on asus ga403uv
Date: Sun, 08 Sep 2024 15:34:25 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: al0uette@outlook.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: DOCUMENTED
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218686-137361-v9TSSqz85N@https.bugzilla.kernel.org/>
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

--- Comment #81 from al0uette@outlook.com ---
(In reply to al0uette from comment #80)
> Just found that pcc_ss_id =3D=3D 1 is also because many element in _CPC is
> Functional Fixed Hardware

Edit: pcc_ss_id =3D=3D -1

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

