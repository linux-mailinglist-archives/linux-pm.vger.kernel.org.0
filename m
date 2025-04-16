Return-Path: <linux-pm+bounces-25507-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3FFA8AFC8
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 07:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA04C17E104
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 05:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4E4229B0C;
	Wed, 16 Apr 2025 05:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oo+rBnmP"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1529121C184
	for <linux-pm@vger.kernel.org>; Wed, 16 Apr 2025 05:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744781717; cv=none; b=G1qqtk2QYQGKsiPXozRWUygzYztK7+9/AjgH9j7y6LgCwoiJRwlUIwJiMDfbacemAwhep8mxaoLN4T85EadKxZlUBDd8IdQxKbEx6rA/JCyRIO2plMELHzTkqOsZ2mrPE0knxhuh95dNUQosUMcXW2JkMcrbD/cu62rp9mt+49w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744781717; c=relaxed/simple;
	bh=Cp8/Cqe4QKDSkvjfyEaewrZK4OH1duUEk7QZkhktPuM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RXY1+nla8u780LZbEFyHm4ckOhJrq3I2vEJsyKGlhoiFZjA2Oc9+FLUM/cfSOCGASYRHfnERxNM5AEMIOZN4n27MjKfk54jxwJirE6OVaBkX1/bhh31vw4X+zzvjrkKdPmjzQY2enn+KaVkY2k/l3YHOHWa79KyjY28CFZNLK/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oo+rBnmP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 804ACC4CEED
	for <linux-pm@vger.kernel.org>; Wed, 16 Apr 2025 05:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744781716;
	bh=Cp8/Cqe4QKDSkvjfyEaewrZK4OH1duUEk7QZkhktPuM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=oo+rBnmPcWDBR7GR6wbTAINskU0hPXtonjFV9rgKRyz7GU1fwgcSc5OlJjenboukc
	 WtebNJFvAdXC1CUh4Spqg9xQwwVOJ56rgw0lW/aFZaZcLqNCGF6nzrq27FwXej9QQS
	 E6q3ybF8ivq3pfQFGlxJpjOo+1wcpSHXb1RJfGWm4LfpcxMGQYe/VMK0xbiVNY3HK0
	 ExV85Aij+drIRRwVKLoXtqoi53abW1JHnz7YaoD0QCKL7+u7+ebyMtvgQUygS67DEP
	 1N/PMktfrO1fHU2yAfm0AP/aywVVEp3Nc4dhMaQxP56QfZz09mzUa6Vhax99ftJOxY
	 v3P+l1ajiawBQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 6EE40C53BC5; Wed, 16 Apr 2025 05:35:16 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 220013] [REGRESSION, BISECTED] acpi-cpufreq: Boost disablement
 not being restored after resume from suspend
Date: Wed, 16 Apr 2025 05:35:16 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: viresh.kumar@linaro.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-220013-137361-EqvBav2JR0@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220013-137361@https.bugzilla.kernel.org/>
References: <bug-220013-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220013

--- Comment #4 from Viresh Kumar (viresh.kumar@linaro.org) ---
Sorry about the build failure earlier.

Thanks for testing this out. I have sent a formal fix now and cc'd you.

https://lore.kernel.org/all/2c788c2ca0cab09a8ef4e384f272af928a880b0e.174478=
1329.git.viresh.kumar@linaro.org/

Please test that once and provide your Tested-by to get it merged.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

