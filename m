Return-Path: <linux-pm+bounces-6268-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 565558A12BE
	for <lists+linux-pm@lfdr.de>; Thu, 11 Apr 2024 13:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB8A71F2135B
	for <lists+linux-pm@lfdr.de>; Thu, 11 Apr 2024 11:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBAB0147C7E;
	Thu, 11 Apr 2024 11:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V4wTvvQa"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98397147C77
	for <linux-pm@vger.kernel.org>; Thu, 11 Apr 2024 11:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712834043; cv=none; b=KXtc90N3BQZgRlguRaQdxA1fCa4obYyFiDBCFUjyUruRV2feo3SClpbCU9sFTfIU0IxKZ5SdXhKQNA3FgfYZM9/7RyRq8iIcUsBJk5P0QWxhgXcvoOtjnBcDy6ThmwSBb712qiqW3yWe09iv3xYOh2kzaPA4cEVsvZCX7oIr6+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712834043; c=relaxed/simple;
	bh=0hGxv/Y7yLWYpyCQV7OAdlAU3YJ08rMN39dW7DtkkEw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mWhAh4+xFkHmqCzMJXZF5n+dvNu3WpgS7oEisUYQl0CUI8olJ4FMCsIjNDW0Y+6ograAp1w4ZChahh6wfit/haDCtyo6nx7E3fdh9otkariCh1Rcq5raS8/mkqObOZV0jLxHFPHsYXvq70Erv1cbOCysmgivnNMR+pmnksmlr9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V4wTvvQa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 31015C43390
	for <linux-pm@vger.kernel.org>; Thu, 11 Apr 2024 11:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712834043;
	bh=0hGxv/Y7yLWYpyCQV7OAdlAU3YJ08rMN39dW7DtkkEw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=V4wTvvQadks3EBWs3ygUzqVHBfl8CL//yUwXZNy2Xk5wifgmQ8VuQvdxXSXfxIyRd
	 pe4OlfoqVytKz7HqoltxGQO89YR6KH2uaXKse6uTEu/uk+XXy2ClnrilSsgnorzd81
	 F8NH5Smz/VNPWVVKxEVm3mBf/xJjMPlObH/zet6HJ9FsrZ1nnrN616y4yckgpC0d9h
	 bttR6l/j1ex+6MN1g/+oqjhrW57mr1yQjUledtRjrwnocbycLZlrMlZETm/N7W5GBQ
	 nWTz9koetwcrPAOiw5bqW3iSiF8i+cETubAimTvzEf7aVFZUzUgnqHG70iPxSOuZGi
	 2JqUN39jm07lw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 1F7ECC53BDA; Thu, 11 Apr 2024 11:14:03 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218686] Fail to set energy_performance_preference of amd
 processor on asus ga403uv
Date: Thu, 11 Apr 2024 11:14:02 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: mario.limonciello@amd.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: DOCUMENTED
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218686-137361-4kw8ESb6iI@https.bugzilla.kernel.org/>
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

--- Comment #34 from Mario Limonciello (AMD) (mario.limonciello@amd.com) ---
Well now that you know it happens in Windows too maybe it's easier to repor=
t to
them.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

