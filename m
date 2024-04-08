Return-Path: <linux-pm+bounces-6029-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D5589B5B9
	for <lists+linux-pm@lfdr.de>; Mon,  8 Apr 2024 03:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89B8D1F21351
	for <lists+linux-pm@lfdr.de>; Mon,  8 Apr 2024 01:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611F8EBB;
	Mon,  8 Apr 2024 01:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g4VyTpF8"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAC715C3
	for <linux-pm@vger.kernel.org>; Mon,  8 Apr 2024 01:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712540914; cv=none; b=BvmzhZTrGDCgHL7yH9kQshVNHKy/oGfJZcUp4fmtN4XEuo8nsYV+tCh3bQhb/+McARPtaVQmXoNn1u9AtPGWGqNXBsdRNeCH/9ftNkc6J5igdC0iEQSfezvj2qnapeh24oh3+nFl1cgyG714NaMZMWsg9t2geBN0DbKbRjvHT7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712540914; c=relaxed/simple;
	bh=/ozPfJuKE5kXcBQ/kzBjfeWUCc1WLNoSo52BrFBw8fc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IX7Oju3JbwLu+6SxKspRK1awGN9NmKJDsX2sQmH7XXz9nA9giXODMJp103WLoDoymltwgqgtOxHtD6n2qMjE9mphcDzlzsekFiApUfVVdZX0PYGS4P5Y/c7xyKCmQIX4SdKd8ooGTjFcz3YswIufTWgymzYn+XQtIGCoZ0oZMhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g4VyTpF8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C8C29C43390
	for <linux-pm@vger.kernel.org>; Mon,  8 Apr 2024 01:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712540913;
	bh=/ozPfJuKE5kXcBQ/kzBjfeWUCc1WLNoSo52BrFBw8fc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=g4VyTpF86F4+1EJ4w2l5GmpFQE6Dvj9L6l4OF54Oht488n6XfenwCLKHfag3tqNe8
	 pOvIXPZ+LbcF2UafohOaOEdsH1dCfC/gK7AkbWhUDA3/WvbhCum6ik439/+HbsOSBs
	 Dl+4yh4YKXJ8DMQSokJ2CHTrk0z6hXRV1yqQoURuKuyA1dt3MejYvmpAu7bj2rA0Ve
	 37p00RcBGNtiUc1Rh1Q7BGlnSBtBAT2m1iYB6O6tJa9eWlJz2vZ0flx7O/PAuiDNdb
	 rL5DCWk3/TKOtB/M9aWA/7tf2QL8/3DYAkoQhksvXOZJD+cFJm+jRo7PLmHN+osffU
	 pyBjVP+Nxgi/g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id B7B72C53BD3; Mon,  8 Apr 2024 01:48:33 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218686] Fail to set energy_performance_preference of amd
 processor on asus ga403uv
Date: Mon, 08 Apr 2024 01:48:33 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: al0uette@outlook.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cf_kernel_version
Message-ID: <bug-218686-137361-nXrsEMaShh@https.bugzilla.kernel.org/>
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

al0uette@outlook.com changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
     Kernel Version|                            |6.8.x, 6.9.0-rc1

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

