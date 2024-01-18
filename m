Return-Path: <linux-pm+bounces-2340-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E35831DA6
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jan 2024 17:38:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6E8D1C22670
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jan 2024 16:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588DD2C1AA;
	Thu, 18 Jan 2024 16:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mstHRZKR"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353C32C19E
	for <linux-pm@vger.kernel.org>; Thu, 18 Jan 2024 16:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705595896; cv=none; b=FUCoTkp2ilj6ao1JChbgcF2E8exTZ+d3rP68KOtNkX4+uE5/W0cHCGPUMj6Tdyvml5MbMZ6EgDiXNuD0JO1JVO4A1ovTBtjPxTBlD5OmDSc/5L5rW+KvJPKMfuhdzvY4gaw0gRaQ1k/UVkl+gsaQNdcyJUh3e/goel/UVD+bDmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705595896; c=relaxed/simple;
	bh=BvacPmTulCRQboI4Nf9UWxjsjaedjvNVPmi5msyxAV0=;
	h=Received:DKIM-Signature:Received:From:To:Subject:Date:
	 X-Bugzilla-Reason:X-Bugzilla-Type:X-Bugzilla-Watch-Reason:
	 X-Bugzilla-Product:X-Bugzilla-Component:X-Bugzilla-Version:
	 X-Bugzilla-Keywords:X-Bugzilla-Severity:X-Bugzilla-Who:
	 X-Bugzilla-Status:X-Bugzilla-Resolution:X-Bugzilla-Priority:
	 X-Bugzilla-Assigned-To:X-Bugzilla-Flags:X-Bugzilla-Changed-Fields:
	 Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:X-Bugzilla-URL:Auto-Submitted:
	 MIME-Version; b=SytOeKHnCgNOudubkfCvkTvg1Fn8TmAJvzqQOMVtVg6iQexW88VojJR4hvsDAM+zGu135q6BArYsyK0sNzWGhYKVTZHooq0zgjPhege3QjM+WxVsG3NJRxshV7b93k05nP51HTF57DB9OQ+bWnBGt9UREuE2QoRqsVpTJE30CKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mstHRZKR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B5E85C43143
	for <linux-pm@vger.kernel.org>; Thu, 18 Jan 2024 16:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705595895;
	bh=BvacPmTulCRQboI4Nf9UWxjsjaedjvNVPmi5msyxAV0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=mstHRZKR5Sfy/cBMBcMnRNRzgKpUC1OtcX+vjRDhZFX7+0BFf4crO26z5kIYh4tYj
	 hfkjImUejV0aM4up9wnqRTH83JShsWXAvygIh18FNAhGEs6RWRGJPomVtQmgoCAUAb
	 kwGpnfFaJrrmAmrseVHoDOmEZgLcn8wetQCtfBi4JG1KgNu5wOGTtXcRaYEQDx8YAK
	 EQ4QdcyDgedJZ11oGw1+tkIADjsroDDRMfKJXht8nf12W2n6yOxZcCIaHqyMUavbue
	 j6QGbmejjaqy6uICoBYJN4WHmDbcQCza+Vf1f7qJShRbrAD6s9X8azsbc9JpJcGjNV
	 uEnXc96rmxR9w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id A2F39C53BD3; Thu, 18 Jan 2024 16:38:15 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 217931] amd-pstate lacks crucial features: CPU frequency and
 boost control
Date: Thu, 18 Jan 2024 16:38:15 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: mario.limonciello@amd.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217931-137361-DuMLUSLOEf@https.bugzilla.kernel.org/>
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

--- Comment #16 from Mario Limonciello (AMD) (mario.limonciello@amd.com) ---
When you say getting stuck in lowest supported frequency does it resemble b=
ug
218305 perhaps?

What is your CPU scaling governor when it happened?  And does it only happen
with suspend/resume or only with reboot?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

