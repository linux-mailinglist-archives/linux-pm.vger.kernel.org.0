Return-Path: <linux-pm+bounces-22230-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D52A38BB8
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 19:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A6F916DBEA
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 18:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D2F239588;
	Mon, 17 Feb 2025 18:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jdMDnPTh"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DA323957F
	for <linux-pm@vger.kernel.org>; Mon, 17 Feb 2025 18:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739818594; cv=none; b=kPNea1gG91ULnnNlo3Tqft7+Qv1/vwjCEuF/KC4vmm9bxDG9XPnZCxX/yIPrkQph0SG/+wYLdaVU4YCyEhcwEBkyY++rbEOvgV3OFjsO1NByDLbwBNsqiGQ5izauymRVLPyR3cwqrBrUr9zFHGg/wIs28jIBCUO2+gBFkU84YVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739818594; c=relaxed/simple;
	bh=D1IdoU5Hfg9DanvvaTs1rxhK6J61jtYPwhqxrMKRz+E=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mZCiF8lie6PD7yP59hGEWmn0KTXlFWQuBt3pmGcSJfZuxpxkUxzEwtUOESHB1qBe0iQEdiAcbQDw4IUQMMP3GF8dG7aYNsF+UDWNqqYGq4un5oRyaWasgjedxelNWcVycvVMKxX2/YPEFjuw/nPhvRy3RTAHOeviQk+xoCcx0f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jdMDnPTh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 70B64C4CEF8
	for <linux-pm@vger.kernel.org>; Mon, 17 Feb 2025 18:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739818593;
	bh=D1IdoU5Hfg9DanvvaTs1rxhK6J61jtYPwhqxrMKRz+E=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=jdMDnPThSbgC4kciZP+gdMf9QvNq1Ajko8blt5wgp9jz0sK72biZ06PQEg36Rj0On
	 p6qfivBt85i1d3CxliNwYV3drZ5WYhjzfExu9cyT9wfBCrWK0iHZQIOMyixIeP/8A/
	 P6Iv4K2QD1Ct/Iim7Ycm+g9l38cMbFLDmfUNw53qiu0ibznWt+530qMZCs4muoDZSX
	 Oi+Pn3FtdO9l4CdrH1WV9G23VYdEHfACz8pN1NFJ+dGu8R21QsdyV7Dq2/mK7V5C4j
	 3H+IwhvBZGOcJiIhfvFiUH3ik/rbFUmt7ppUE25+ZH2DwSFoo/DeHsW1UKvjWFLR/G
	 y+MbRI+Zd7Afg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 67357C3279E; Mon, 17 Feb 2025 18:56:33 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 217931] amd-pstate lacks crucial features: CPU frequency and
 boost control
Date: Mon, 17 Feb 2025 18:56:32 +0000
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
Message-ID: <bug-217931-137361-80XC4RPKrg@https.bugzilla.kernel.org/>
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

--- Comment #72 from Miroslav Pavleski (miroslav@pavleski.net) ---
Created attachment 307678
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D307678&action=3Dedit
amd_pstate.py test results

I'm adding the amd_pstate.py reports as 2025.02.17_pstate_reports_Miroslav.=
zip.

I've added a screenshot after resume (did not crash this time). It shows CP=
Us
going above 1.6GHz.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

