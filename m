Return-Path: <linux-pm+bounces-13874-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 15FB3970C0D
	for <lists+linux-pm@lfdr.de>; Mon,  9 Sep 2024 04:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A357FB20C15
	for <lists+linux-pm@lfdr.de>; Mon,  9 Sep 2024 02:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC851AC43C;
	Mon,  9 Sep 2024 02:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="psMgtIkz"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB0C14277
	for <linux-pm@vger.kernel.org>; Mon,  9 Sep 2024 02:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725850448; cv=none; b=M0ilD11Z9TxTVCqPkxlC2NrCxhtzeAuUcy0bE4r6ZsfkpzZYYGFld9NEVuvWCYPMkBah7tlEDE7Q1ovjifCkB0YbY4MJaHGmuFAxkJTq+HQC/R/DTfUkFAcZss3QshmwvRadBN5Vhvppznl1RFaTBgzwnyBleH4GpOSiR+JmYu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725850448; c=relaxed/simple;
	bh=l3OHCFZTpsPXKVQf67zWc1G7CYCJa+oOHsZeyZR2yeg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OuEuIrUSc9njaJeWoL5PdbGupxl1bKWwCt2cRGAmDgHykNpFzfTP2kxUZfaJypjCq4DRmIHguD16ivzS/A8zQnph74frHT9mbn9nokKVMoeKVeDaid8OegXiutGabUFUdxeKzrIuUGFpIUC84jRHVivhAJklFv2n/uJFO2xmVUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=psMgtIkz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 417B7C4CECD
	for <linux-pm@vger.kernel.org>; Mon,  9 Sep 2024 02:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725850448;
	bh=l3OHCFZTpsPXKVQf67zWc1G7CYCJa+oOHsZeyZR2yeg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=psMgtIkz1w0lqOTjNm1ws9f3QdZR2t8apLX2a97BMotI529xV8nFcEuWU/dbdZCA9
	 u/gzcycrhWG1VZ6pjvDjxnDBq+C1rXHmUN18V1wALz9fwaPm+vg0ipS6GpKT19fFRB
	 HUaQBo94Gh/1G/PDfKzDjQ1PUSuVOx35FIGFxm3+A4cdm3s1SR7HiWFatVm+jbs9iO
	 kU8FG0ci+DW7964qPQX8ciH4qOVqoDZEj4nbPvUbL786QLHLRGDOypS8VE4V9LhTMu
	 EcA1Ofp9gmJb4PIPlm3wbBW7AfOKcYe7tcr/k/ibM6Ud2S9q7lJGpdHM4aA17MfnzC
	 aHVtGE1G5MmQA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 3BA4EC53BC7; Mon,  9 Sep 2024 02:54:08 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218686] Fail to set energy_performance_preference of amd
 processor on asus ga403uv
Date: Mon, 09 Sep 2024 02:54:07 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: al0uette@outlook.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: DOCUMENTED
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-218686-137361-2QFrxNvHxJ@https.bugzilla.kernel.org/>
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

--- Comment #82 from al0uette@outlook.com ---
Created attachment 306832
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D306832&action=3Dedit
Patch for cppc_set_epp_perf

I've made a patch to make the kernel write to the epp register even when the
register is not in PCC. The patch seems to work for me, I can set epp witho=
ut
unknown error 524 and the power consumption is lower than before.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

