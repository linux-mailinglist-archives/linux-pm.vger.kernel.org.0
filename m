Return-Path: <linux-pm+bounces-7101-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A36C8B2513
	for <lists+linux-pm@lfdr.de>; Thu, 25 Apr 2024 17:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 940E4B267B0
	for <lists+linux-pm@lfdr.de>; Thu, 25 Apr 2024 15:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E40149E0A;
	Thu, 25 Apr 2024 15:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ue9pDcWd"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B5A12A17F
	for <linux-pm@vger.kernel.org>; Thu, 25 Apr 2024 15:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714058828; cv=none; b=NdA3rfKbwWKYKIf66ivPfH/Ac4ha3lQCqea92NptUcsiqqgXYBMzjNVZsA9eNpAeVJgBnyPnQFt3QoOOaONtGaqQgjUous+Qm/ULq0GJ9PkID7ISO61tdQVMLRZMte15G582u1gGUI5NHO8fKxxLHeYFc22+oQPwiGmvX7ptgyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714058828; c=relaxed/simple;
	bh=AX93TSue8Cm4u7+4u5UmUZYYtdiSADk9XoU3TSX561s=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aUN1AVfjYorp18V9dCAMIunkubud84BFXytvmOSQXmuVzSCYfKvTMwgXyOUMPWDWIWugy1sMWew0hSoG5nnmu06YMl63odnkAO1+f5G9GqepD90cGWD3onoDRfSJuE+oGsSgyzcFAquxlzk5B8Tafjva3vMWV97a1T/hv9KqIvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ue9pDcWd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3F353C2BD10
	for <linux-pm@vger.kernel.org>; Thu, 25 Apr 2024 15:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714058828;
	bh=AX93TSue8Cm4u7+4u5UmUZYYtdiSADk9XoU3TSX561s=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ue9pDcWdczoOA7DbU0H5h5Jmi9abPlRKUuGkJwi9hAt04Dkrl03ci7GFOQET5r9eT
	 E2RSNTxT3pVsSeEGI34ei3CULCQg+bszD16/F15huR4MiS4oHisG/YaBiNYEdk/X3V
	 /oGMxr5fuY6zHjAZMxPsPe+WlL0eSbIgBEFah8fEaCJpZY6xY4rTa1+F7XxB8hN04T
	 e+OIk8UuPRJCkJx4rRKjSnpDyxWOqxANThMQB1eC5k5FISSe+1gaIwUAbKc0ivlhnn
	 r9lpn40dQ7Xxr+Oe2RLZjspWD1NC7zE3hkXv0g0hDW1jnEOr0H/zkh8dGqfL73GIf9
	 WgkCrSHpSiQkQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 383DEC433E5; Thu, 25 Apr 2024 15:27:08 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218705] amd_pstate fails to load on AMD 5950x with Asus ROG
 CROSSHAIR VIII DARK HERO x570
Date: Thu, 25 Apr 2024 15:27:07 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: andamu@posteo.net
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-218705-137361-dCvxKyjvqF@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218705-137361@https.bugzilla.kernel.org/>
References: <bug-218705-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218705

--- Comment #12 from Andrei Amuraritei (andamu@posteo.net) ---
Created attachment 306210
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D306210&action=3Dedit
cpufreq_grep with amd_pstate=3Dactive

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

