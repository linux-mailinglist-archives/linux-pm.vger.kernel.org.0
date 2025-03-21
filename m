Return-Path: <linux-pm+bounces-24387-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F2FA6BE6F
	for <lists+linux-pm@lfdr.de>; Fri, 21 Mar 2025 16:42:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2527E465A1B
	for <lists+linux-pm@lfdr.de>; Fri, 21 Mar 2025 15:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F808216E01;
	Fri, 21 Mar 2025 15:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iOaS6WAv"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0ED1D7E26
	for <linux-pm@vger.kernel.org>; Fri, 21 Mar 2025 15:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742571714; cv=none; b=rZsXgsyDOyPmsxut180XTXrvGq/jxMsOWEEoMN9WlDYRgv6OoRo/Bhkr8mMwarBdi149cVihsZx1Vj5iGeCbyRfRR2W6fN6eQH+9HzlsRir/j1HB5I/RcZweQxrdEq2v3VhtDawD6j8kDvauhFyZl2qfH5EU6cBy4vkumQb+/Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742571714; c=relaxed/simple;
	bh=kPX+yrGuuxaE5MBESKe/Dm0XxUItEnx6JqNw9O1SB2c=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lxK4nXgmpiedIAQC4qA4ZZH4bB9oautYWy7r3Z2GQyXxDLjk9ueblIuzOkx/w6FpETrpK9quKYhWwgTmrKEPYmvc4pQS74dSxL+ALSdkhziQQ3hukRg1akubVPDpzVnz1YBctFjf4GnlqnXrcAuLlLGZ6tTBSpm5GLHQV01vVwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iOaS6WAv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5DD52C4CEE3
	for <linux-pm@vger.kernel.org>; Fri, 21 Mar 2025 15:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742571713;
	bh=kPX+yrGuuxaE5MBESKe/Dm0XxUItEnx6JqNw9O1SB2c=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=iOaS6WAvwGxtOsbW3BwYHwT7jW5XurfRQMo/8yPxJkdT5L90zsC3rpwW1FlpQtjJN
	 JfmkDCW4Rxv+0EeP6P5unrYQIzW2lPvJ5twmqTLprpH7zyd6MuVo0BAFLj9Wbr/8TT
	 XP3Hc+PubNcmBHGZsMguPoXAML55CvoJIhDy9HTzJu35iMYok9x07INVGtP7lhHFxj
	 BGWf3O8tfJR4ll9SoE5NVgumZSMkeOklweChImrPG7In0SDV0QeFzrpC6+aAusD5Nk
	 AI8LM8IcRfsDL1JE9mXJwusBetbS7o6VvuBHsU+P9R4HYgPJQ8G9gcNoRRRowPB4Kg
	 P6l/qgIkEucyg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 5049FC41612; Fri, 21 Mar 2025 15:41:53 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 219858] AMD Zen 2 broken power management after sleep
Date: Fri, 21 Mar 2025 15:41:53 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: diogotavc@protonmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc cf_regression
Message-ID: <bug-219858-137361-VxkAFaxetG@https.bugzilla.kernel.org/>
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

Diogo Carvalho (diogotavc@protonmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |mario.limonciello@amd.com
         Regression|No                          |Yes

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

