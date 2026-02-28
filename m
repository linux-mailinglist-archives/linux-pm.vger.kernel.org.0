Return-Path: <linux-pm+bounces-43363-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2IgeEpTaoml06AQAu9opvQ
	(envelope-from <linux-pm+bounces-43363-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sat, 28 Feb 2026 13:07:48 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CDBC1C2CE7
	for <lists+linux-pm@lfdr.de>; Sat, 28 Feb 2026 13:07:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE20F3045AAC
	for <lists+linux-pm@lfdr.de>; Sat, 28 Feb 2026 12:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4394842B73E;
	Sat, 28 Feb 2026 12:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VNlWQLsy"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C6D22B8C5
	for <linux-pm@vger.kernel.org>; Sat, 28 Feb 2026 12:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772280406; cv=none; b=RizSghyca7sczm66DAl2mR1I4DEBtASYLwaif9g3eXAI6wMcygWKhSdW2P2EKtGmgi/zlGwC+EwC3MAf5PNf1/ugk7HkyY/O/EoXzRt3OaX7F4grMXzfae2XtNF+mUjp3LFwRf8M0gZ0I1ybTFe4JGb1d/+zTaeGTHiFuXWUhhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772280406; c=relaxed/simple;
	bh=HHYboqCDTjGlzPcaEVKP5LjjuWWFid5rgAOZWTUrzBo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HB/fdfQ7MQ618DqIlxKLxX1wZW+xJfSGlmjRoIyrmE9941YZaDMjmGSXrPSv17CEz7BFP2ws3pbMmnfeqmplM5EZywTMAYaM1sbmOBGpt2HZbS+gqxBcg90B+f7hLy5pyvbgQog9FIPa/KassNBUt30f8YevbiMszQ3e8oWwnNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VNlWQLsy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A9CFCC19421
	for <linux-pm@vger.kernel.org>; Sat, 28 Feb 2026 12:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772280405;
	bh=HHYboqCDTjGlzPcaEVKP5LjjuWWFid5rgAOZWTUrzBo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=VNlWQLsyDwFEf2H4LrBjotrG4PXUSQcRhkrCQafnfFiGxAkSGEEh/a3CHNurxuEus
	 QKonTkX8als1d2iVOzx3zYZuQwOA57uHt59PgdgGGljtT6N8vSP/LCHZtAEkzmBDFI
	 4TC4rwgNsqzRW7NzfcYrlINYhxOj87iWeyiTNbh8SjLuKEK51YIZlgKAbEjFOTfaZV
	 H7tm9DxT4ZAa3izTwuwQFuVRDj9YRg2yKLH+rCzsA9uIPLWg4SuJfySxSbk6j5GPRX
	 LgCMrYcuNbuGTc30cmrNdJmez6FoGZyCNQnCvPa+sg9dnNGbPOricfIEn4NhyR/PA3
	 Rof/1Kxi4yfdA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 9A506C41613; Sat, 28 Feb 2026 12:06:45 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 220117] cpufreq performance governor doesn't correctly apply in
 combination with isolcpus
Date: Sat, 28 Feb 2026 12:06:45 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: bugzilla.kernel.org@21.leggewie.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-220117-137361-BMJCHGLFJP@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220117-137361@https.bugzilla.kernel.org/>
References: <bug-220117-137361@https.bugzilla.kernel.org/>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_ONE(0.00)[1];
	FROM_NEQ_ENVFROM(0.00)[bugzilla-daemon@kernel.org,linux-pm@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_FROM(0.00)[bounces-43363-lists,linux-pm=lfdr.de];
	TAGGED_RCPT(0.00)[linux-pm];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Queue-Id: 9CDBC1C2CE7
X-Rspamd-Action: no action

https://bugzilla.kernel.org/show_bug.cgi?id=3D220117

Rolf Leggewie (bugzilla.kernel.org@21.leggewie.org) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |bugzilla.kernel.org@21.legg
                   |                            |ewie.org

--- Comment #2 from Rolf Leggewie (bugzilla.kernel.org@21.leggewie.org) ---
so, this is not a bug and can be closed?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

