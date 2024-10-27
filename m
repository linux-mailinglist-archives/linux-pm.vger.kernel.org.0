Return-Path: <linux-pm+bounces-16524-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 034A99B1FC2
	for <lists+linux-pm@lfdr.de>; Sun, 27 Oct 2024 19:44:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 547751F213FE
	for <lists+linux-pm@lfdr.de>; Sun, 27 Oct 2024 18:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9154C156F45;
	Sun, 27 Oct 2024 18:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pNDPzLMA"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0FA1CABA
	for <linux-pm@vger.kernel.org>; Sun, 27 Oct 2024 18:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730054661; cv=none; b=iYSXoUjuLo+tOaUVy/OdDF0fHOfNLyh4PA4ndFSO3NYMOIZZLWhJE2HJnnPXvouItKfyhxfqdIpYdsIcS7l4RkMjck0FriKTSK22/Mu5+35iXyO10AEgoFNQWGFv+EChlwCKOawgJPUW5zaGzP+wXUFoQMtVyQUIC622DbsLe1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730054661; c=relaxed/simple;
	bh=Up0evkG8haGYs1hW7wOOHuv7kGxqMcX9ZKWBvoSse2s=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N+FaFTl9imVLJxhHv/knSSNbNkuhviBK8OBnGf0H+Qe5zvuMkptd+nGKnucfVUN6gDnZIluPDm5sV/IfZt5ak8OlRqkiNd3KqOY7a3qJ5XeOexsLUSOhaNxkzS8V385IMZWqbwUX/V9fbOrT5PBbeifPapUpLyFFL1WH1gOVSLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pNDPzLMA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 112C2C4CEE4
	for <linux-pm@vger.kernel.org>; Sun, 27 Oct 2024 18:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730054661;
	bh=Up0evkG8haGYs1hW7wOOHuv7kGxqMcX9ZKWBvoSse2s=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=pNDPzLMAw445apr5y6bjMsv70tKiSXxcgiZ0l3gB85tXQapA/7/29Ah0NSTOtQCGT
	 v0zzPcA2CheXvOb0E8KGTFptSNd0+bSTRiBxBPstkHnCwLKNSFyrKBLTcl4RjRl2Mz
	 pijpE2b8hsF2I8hPYRxY6PTc9gn6wXp7q0CJoJ1/SgYdD/kryKY+NxumlyjpE4WnDa
	 445KmHfLYy38u8O3F+opDQJqThZ35bToPzg1i57pn4kjW0/lFPPk8G2aO7oLmM++59
	 OidhAtT7byuOTweQme6IL6nYSS+6Gkkph6ggvPvCxP+NBprKPfdpDhYJjQf9idPMnc
	 quQDNEppDn7bg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 0705AC53BC4; Sun, 27 Oct 2024 18:44:21 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 219431] [6.12] amd-pstate / Ryzen 5xxx (Zen 3, Vermeer): Could
 not retrieve highest performance (-19)
Date: Sun, 27 Oct 2024 18:44:20 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: intelfx@intelfx.name
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-219431-137361-vGGBlWU8yy@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219431-137361@https.bugzilla.kernel.org/>
References: <bug-219431-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219431

--- Comment #2 from Ivan Shapovalov (intelfx@intelfx.name) ---
Created attachment 307077
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D307077&action=3Dedit
/proc/config.gz

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

