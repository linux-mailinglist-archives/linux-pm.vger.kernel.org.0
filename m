Return-Path: <linux-pm+bounces-37246-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0ECDC287B9
	for <lists+linux-pm@lfdr.de>; Sat, 01 Nov 2025 21:20:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 165FA189A7B5
	for <lists+linux-pm@lfdr.de>; Sat,  1 Nov 2025 20:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2249248F6A;
	Sat,  1 Nov 2025 20:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ITn099vA"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD401684B0
	for <linux-pm@vger.kernel.org>; Sat,  1 Nov 2025 20:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762028400; cv=none; b=tKhH0ExUo4I3FE0GuyAtdax1p8r68FtKCa9yvwTsnj5BPk3A6p2VHZCTykhN/qJJpi9M2lWJr7ivTSMwiKARVryUTVT+giIBMYOfGYSnThJkXfslsbQqyzBzl0KlW4Az9XfvOluENwsl2y8cWOUR/lpfSzKEoO5+IYagkV74jrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762028400; c=relaxed/simple;
	bh=mq76htPgvRGx5PW7sLY1tevzMaLcv3taD9FtH8zIXoc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JN44ca1vr/dbjsbwGdoJB4YnyBO8J+W52jmrAkSoCN+hrZz2ziLZw77bm6C9IcCAeMBI8Umg8leQUipHezJ69JrbZHCkNnFO4pKd7uB83CbZeNesIDiI9E/2jraoA6ICn8/frzVAwimtTQBLdgzAej/B2FatJR0YDSzwerV5Bn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ITn099vA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 82007C113D0
	for <linux-pm@vger.kernel.org>; Sat,  1 Nov 2025 20:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762028400;
	bh=mq76htPgvRGx5PW7sLY1tevzMaLcv3taD9FtH8zIXoc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ITn099vApXeDwTemIK498xZ+InII/xGlu/k7BdRGWtARtVmkk+GmUNV/tNbJOzIfk
	 hJ36iCLs3pY89IgUm8MX9czQS4ru6Dqi8TwGrn9VJEtqp++Bzzl5Rd+f8LKSSXtIwz
	 P6JlsMV+L/qsMyOS9Ks8zg++FM6cc4bmnatMbagN/DH6BEnhdzLwjfFmBKkuXQyj7P
	 QmduVvCHjCFjfzzBT8lowOvvb3DMW07h56KYBk0qnB9hi34wE0kteaInlNGkyjV7DY
	 qTpYZzTzco2aDXBMXn2xHTU2x0j8EOppOikyJstVe/GzN3DU0iEr1o+QqkzsEKkrtu
	 TQlbTNBoPKIDw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 7AB91C4160E; Sat,  1 Nov 2025 20:20:00 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 220715] [REGRESSION] AMD P-State fails with "_CPC object is not
 present" on AMD Zen 4 between 6.10 and 6.11
Date: Sat, 01 Nov 2025 20:20:00 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: chris.harris79@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-220715-137361-mdzgZhklMB@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220715-137361@https.bugzilla.kernel.org/>
References: <bug-220715-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220715

--- Comment #4 from Chris Harris (chris.harris79@gmail.com) ---
Created attachment 308880
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D308880&action=3Dedit
Complete Bisect Log

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

