Return-Path: <linux-pm+bounces-22185-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA66A37C84
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 08:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F26616ED72
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 07:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6403192D70;
	Mon, 17 Feb 2025 07:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lbz49tFo"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B168618DB25
	for <linux-pm@vger.kernel.org>; Mon, 17 Feb 2025 07:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739778604; cv=none; b=BLAK6JLz5PuHVElA2lNiFVpK4la0TjmcWpTjHIUb04vA+DlHIbnNe73y5+7V0+OCV1/5bb/jH3c5M3MMcI/KDxEOV5BG0anEPF21IoA8+XuF4USoqC2d3lZHE8gUqKRbo0df4AEYnzNc78vb8LT3ohIbJpP/TXu8b3xyPBxYWto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739778604; c=relaxed/simple;
	bh=bABBQzNNTfrZxCNrv5DRhdksoi/c9fP8FrD2tNMFGk8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bxnqGnlUghjej5zq2XxzKJwSTilVy9vCklol//9z6pnoiXWh2xpTfzm+WjzReZ4VV7rbK3pzljjX0+icDbEKJs9BRbXiHTcSv1Zq0iBSpVabCv9MnB7m4zL7IBieV0317XYXO48okWQ8l4MMQr7EsHCs6niOq0GR93/IHQz+ffE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lbz49tFo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 35476C4CEEB
	for <linux-pm@vger.kernel.org>; Mon, 17 Feb 2025 07:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739778604;
	bh=bABBQzNNTfrZxCNrv5DRhdksoi/c9fP8FrD2tNMFGk8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=lbz49tFovUUbAH19LuzHDoL+nI3c2Un097hK1xdXjMwHJcK02C6c8o/vDkkBxz5Tw
	 E7ug4F/XMr5Udd8DCogSWL5NhutVfCrsWkIEKNKDFiGUoVcjhHkp3J/wd3KBuqr86p
	 4MzMNfefnd9ujtYCqoS8EGrWvxCHuyadWiUPob4EVSAJj5i0qe9c7KQkwK8boTB8Nd
	 H3oeRphccYbeQ8tRgJr6ylfsvsXMzuEjBjmEDvcBOh+OtEng50JXgbObfdKJj0D+tq
	 eOsAk4m3+G/qEg7pBfm8Cd8wAbS75rNlbFthSHPeFTzWwXCeqs6oMbKIMwEizi7VXF
	 C6fI2kzbVUvNw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 2B73DC41606; Mon, 17 Feb 2025 07:50:04 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 217931] amd-pstate lacks crucial features: CPU frequency and
 boost control
Date: Mon, 17 Feb 2025 07:50:03 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: miroslav@pavleski.net
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217931-137361-45XHnZZlzP@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217931-137361@https.bugzilla.kernel.org/>
References: <bug-217931-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D217931

--- Comment #65 from Miroslav Pavleski (miroslav@pavleski.net) ---
AMD Ryzen 9 6900HS, ROG Zephyrus G14 GA402RK

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

