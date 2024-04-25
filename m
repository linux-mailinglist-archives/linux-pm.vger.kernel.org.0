Return-Path: <linux-pm+bounces-7102-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0916E8B2514
	for <lists+linux-pm@lfdr.de>; Thu, 25 Apr 2024 17:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15F8BB2680B
	for <lists+linux-pm@lfdr.de>; Thu, 25 Apr 2024 15:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B941149E0A;
	Thu, 25 Apr 2024 15:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u+gO74Te"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E5338398
	for <linux-pm@vger.kernel.org>; Thu, 25 Apr 2024 15:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714058857; cv=none; b=oVScK8CRVSWUf8ODO16MFtoVm+JPDU6UqP757jNHKUg+eHPYkx1LTt9yky63dzhpvSIQZUe1CWcp3qga6bp3xk2GmgT5z7/aPdP0Ioot5fhUuiyTmTAbfvjnGrl47eFcZ37CuvlLwg/ClaORrNzdojAVpe5/jJbyec4tGFGutxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714058857; c=relaxed/simple;
	bh=GIh/3srXHk2peVa9pIwuWQ94oVDzzEMAMu0P+aNXSgY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XIFsROnQR7jH0nAVHHwRL24cQ28yhFfB1oMTNvW531/Qd39DolDqgVTzy91P4x+Huusdt7mHNLwv7IltOsexFcH+UMZY3wcLVBFrJwUvYzw55vTJ3620ztXfqTdoWgkrTL/x4DzFMpYCg2GFoQ8G11Q+MAG6hXZOU5UL/FKHkw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u+gO74Te; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B1683C2BD11
	for <linux-pm@vger.kernel.org>; Thu, 25 Apr 2024 15:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714058856;
	bh=GIh/3srXHk2peVa9pIwuWQ94oVDzzEMAMu0P+aNXSgY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=u+gO74TeOCZubFcthr781uAGvQu5wOVSG9URG9boNT+CCkYYnCtqo8bSDxKeyyKg9
	 tm60U5w+0zBqzBsf1q1sLei5wkPsAo3hWaDIi/2nVzh6gbYmIoZ1eOLt56wLBxgNIW
	 sr7NbMzTryq7xV+0SZ5kCflZWRAGcIqR4SIErCZjG5y0DjWMS972G7ghMknsjSDbBZ
	 uoeBL2KLaQWn9HjtAMkGKS6dB4ey/Zvs8ad+3IuFQitkcNbB7ocfbXu2KWalIRu6QS
	 LyHH0lN7kWOBR6ih3vYKjEkdEGN0uRpp5HI9k6wZmVSb0TGIfdEMu7xMXoGJ1zdKKC
	 scVh+ntJ6mB+g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id AA932C16A72; Thu, 25 Apr 2024 15:27:36 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218705] amd_pstate fails to load on AMD 5950x with Asus ROG
 CROSSHAIR VIII DARK HERO x570
Date: Thu, 25 Apr 2024 15:27:36 +0000
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
Message-ID: <bug-218705-137361-LdEMb9SiIQ@https.bugzilla.kernel.org/>
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

--- Comment #13 from Andrei Amuraritei (andamu@posteo.net) ---
Created attachment 306211
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D306211&action=3Dedit
dmesg with amd_pstate.dyndbg and amd_pstate=3Dactive

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

