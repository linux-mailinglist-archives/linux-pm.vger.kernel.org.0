Return-Path: <linux-pm+bounces-22227-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF8BA38B6E
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 19:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DE793ADECA
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 18:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E775236420;
	Mon, 17 Feb 2025 18:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q5QhkWIk"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C1E22DFB4
	for <linux-pm@vger.kernel.org>; Mon, 17 Feb 2025 18:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739817874; cv=none; b=uAe69hcrEMsJazpII0Tm8yGviDu0MKyFRUh4as7h3O5nJD6/b/Zw/8vdIwncKifm2LGrebdTwZgyFtTkGjONjz2j1FmtfI6Kp5NLgGbBE2blnbIh+Oa8SBm3rAn6TfLd82spd9TfZRHiwxzUqf2Rqt2DrhHK1+ueIejRNNAF8eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739817874; c=relaxed/simple;
	bh=c6CRpEk56eIAp5nVbcBUDWhboyt1gmRg9l3tyRQTvy8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AlhEjENtVRL5E0pl0k6KobfRuq0B+lL7qAguZaPuFXydwevLCRH8a3BbbC/Xe2cHfscjBDmuQAEcX+nZJdTrVBU4cEZqouBPML/2NiD8xwULlFonZueTsXsS9+NFO6SFa9okvxYwEEIf/imVXa4tfHoxs998jWhYa7x8djXw4zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q5QhkWIk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D63B1C4CEEC
	for <linux-pm@vger.kernel.org>; Mon, 17 Feb 2025 18:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739817873;
	bh=c6CRpEk56eIAp5nVbcBUDWhboyt1gmRg9l3tyRQTvy8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Q5QhkWIkWtDQQUgV8zfhfMKHZGYL4DomWqxmdeEisUuAlNplZNnjNdIiBn/tHl3pM
	 0awBNEb0tF6tqWbPNlUdM3lILUaW9JkOw53aDcbfL8KB0WPvFnRHJg29mfVBhEIHRd
	 4BNn9SAxlIilT8YMUpH7kruT7KsJ90r+VhYrq4e9TH+Qfv1kbvbVDnZeOSJpOJWwt5
	 DyqZGPf48jQPnSJo9lXhQ4dPvk55UK/PSmpy9Jk/+080Mb5JA68LDsXvMtKnejqh3a
	 E/6nTjphfnZBlzJCp8cQ7D7ty1QvZapB4wnNnOimZlKXA+zg4PxZte/6X9eqvk9vGn
	 aBZZYrpfGbmbA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id CCFF7C41614; Mon, 17 Feb 2025 18:44:33 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 217931] amd-pstate lacks crucial features: CPU frequency and
 boost control
Date: Mon, 17 Feb 2025 18:44:33 +0000
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
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-217931-137361-9qAdzpblxj@https.bugzilla.kernel.org/>
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

--- Comment #69 from Miroslav Pavleski (miroslav@pavleski.net) ---
Created attachment 307677
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D307677&action=3Dedit
2025.02.17 Testing report

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

