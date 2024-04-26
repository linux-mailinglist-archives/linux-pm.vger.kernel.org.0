Return-Path: <linux-pm+bounces-7211-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A62688B3E33
	for <lists+linux-pm@lfdr.de>; Fri, 26 Apr 2024 19:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 458F21F2495A
	for <lists+linux-pm@lfdr.de>; Fri, 26 Apr 2024 17:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CEFC16D4CE;
	Fri, 26 Apr 2024 17:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mmfCqvJN"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9E917276D
	for <linux-pm@vger.kernel.org>; Fri, 26 Apr 2024 17:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714152336; cv=none; b=RRlrR4a9xF/B93a4oTCE8bEhLyxbe4gB/CaoQT9p2XitUMHLZkwhFa7jnUvdVU0c2ooOgJ5aoWxwIMBu7EGVPV/oAjV3VbSLjZauNVISF/73EnkLIE5EYrYLWnZfhM41vnYN1tdHQkvmUNdWoRG2WdK1Y4e9YsKO/oGtVRlO7as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714152336; c=relaxed/simple;
	bh=5F8AUtAepzgZwgU2p86bv6smGR4xOdpP/703bjgRIds=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NNIIk8GPdACEnV5hhh0n2TFH9xXvJVTNVIkkomK5vMh81F8ERq12/G0/65fp0WWcsGAgW0/nl4GS5WmBtRk9EnGcLS7HzVzlG+Z3v27R10G0JPyF+CDrMJdGvjH9QTKa/+n5HC9TY3fpzwL3HTgFwRZI7zpRSG5p/8iulC+lfLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mmfCqvJN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 57B0AC2BD11
	for <linux-pm@vger.kernel.org>; Fri, 26 Apr 2024 17:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714152336;
	bh=5F8AUtAepzgZwgU2p86bv6smGR4xOdpP/703bjgRIds=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=mmfCqvJNPJLkdvGVgOipMwSHW29b1TzCjOs0RXtGz49ry09MKgnx+1TgcFm4ZixA8
	 0UIYtyiU3CURpyrR06WTH/UCqHYqk2pFKaPlUQO4bVIQkHSxsc1K6ECdpTYiko2Bbe
	 aab6kV01M+GIupgJHVTIcXeAoLbO7iQsA8MYKm8WNKaJmAmexHMZeC8cy9QyWGblWR
	 +O+cPYvp99yHygoakinbPw2MFTpxAs3Qad9kJewDwTUIxw3LuxLEtD3zBBxu/XCErj
	 U65lF6mjlulvF2IGIZWnSNv05sxMoPsKQt3gu12sH50ewTYlcmouHHh3te+yMqz7qI
	 N+j3MprEslaQw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 50B58C433DE; Fri, 26 Apr 2024 17:25:36 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218705] amd_pstate fails to load on AMD 5950x with Asus ROG
 CROSSHAIR VIII DARK HERO x570
Date: Fri, 26 Apr 2024 17:25:35 +0000
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
Message-ID: <bug-218705-137361-6bC6XL62Zx@https.bugzilla.kernel.org/>
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

--- Comment #19 from Andrei Amuraritei (andamu@posteo.net) ---
Created attachment 306224
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D306224&action=3Dedit
cpufreq_grep with amd_pstate=3Dpassive

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

