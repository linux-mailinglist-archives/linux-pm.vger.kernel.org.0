Return-Path: <linux-pm+bounces-37478-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69AF8C37686
	for <lists+linux-pm@lfdr.de>; Wed, 05 Nov 2025 20:01:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C1093A7902
	for <lists+linux-pm@lfdr.de>; Wed,  5 Nov 2025 19:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B44C8296BDC;
	Wed,  5 Nov 2025 19:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sva390Rg"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F03F27F75C
	for <linux-pm@vger.kernel.org>; Wed,  5 Nov 2025 19:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762369262; cv=none; b=TJ8po92aj4evqX+6ysGM/3E5gGomF485gzuiZ+kvZ5jb6a9Q++ovywJ3VNQ2sAFXF+IQfb60t7q3Tj+vrO74PAs0dv20+RP/zSKcoKb/UvQ2ttTY/DpsQuaqe31lyIjIDtoS0w8hPHOhVcG+reeXSnisP2UUqU3xU2FSYLnkXO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762369262; c=relaxed/simple;
	bh=PQnzVQ/HaLpoxtrP/gNAggucl4iiGSnYhz/gs599LKg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T5o7rjbh1DLpL66Z97iNd0GzOXMmhOhm+rmthzUdSm5HKXW5K2+kCQduO2j4AbdGTIbGsd4hQFSNfMwuVV+52/jES9RtD0BL5OjYK69vo875dPhGnGdIjI1GPpLrQpnuM6f8b7YFwrnEk0JqiVikjWu2Gq2BuvJk6yWVwC1mlmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sva390Rg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 26D19C19421
	for <linux-pm@vger.kernel.org>; Wed,  5 Nov 2025 19:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762369262;
	bh=PQnzVQ/HaLpoxtrP/gNAggucl4iiGSnYhz/gs599LKg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=sva390RgtiEKwE5Hatx8n+qP2A4rloc8+TK+lCHcJ/Da4TnfZG8RoqJumq1aXR/ZJ
	 Y6O1sqwEZkkMAWShv0kTEJm4d7obIbDlbXXkmOPqvBNFQukj066ZOtcHHqvlXRH4Vf
	 G7VCoyqlJjpDdmqtIy8scqJ0uOznbyRlLcVcm6ZnlW16JjL2nYa1yI+WHkgWFvsaC/
	 q7X0DesV6bm7HXIb0S9CPf2Df7R/7RWa6W1cOC1qV0/QfklYoEga7Tln/3Ps7k2MFA
	 GxPrr5/LzZ18hrEQd3mHXyR8mxu7M+9joUzCGDJw/TJG0ukbEfrNFmFUFyLuyuhdeq
	 r+Xyg0OoSfxnw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 226DCC433E1; Wed,  5 Nov 2025 19:01:02 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 220715] [REGRESSION] AMD P-State fails with "_CPC object is not
 present" on AMD Zen 4 between 6.10 and 6.11
Date: Wed, 05 Nov 2025 19:01:01 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-220715-137361-kqM4chpcBw@https.bugzilla.kernel.org/>
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

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |CODE_FIX

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

