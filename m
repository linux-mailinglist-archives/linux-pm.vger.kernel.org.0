Return-Path: <linux-pm+bounces-8124-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABAB28CF5FF
	for <lists+linux-pm@lfdr.de>; Sun, 26 May 2024 22:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6701A28108C
	for <lists+linux-pm@lfdr.de>; Sun, 26 May 2024 20:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF73838F9C;
	Sun, 26 May 2024 20:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gULSIVME"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE111A2C2C
	for <linux-pm@vger.kernel.org>; Sun, 26 May 2024 20:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716755804; cv=none; b=u2Btsp1nCk3896uLIFi84uELzExkaXnVfSIxqV5mRTfHxL4Ys+SshCkoXUKIy+Iu4O3kc5Jf9bGbjii+4TkxdY9Z82se7cfNLLV9G5CxJn3xu3rVfRuLLxF7uOTRKGFNE8I/5TApkdoxBZplq7MEeTDIaN4+M+bXaxFF7nXX/7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716755804; c=relaxed/simple;
	bh=Ac+vW4SGwHc2aP+J7pmPbGNjRiqfbgfdLnyok54UXto=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MVzIjZZfyiAjyvqfZ1YytFJ/QXO48/g4DsdgYDLyhWFPXWb9Sx0UTntM8BjYik2gdDEE8xUFbmvhgXF8J03v2AbEBahcZ+CwB8JYGj5Yr0OtMvQftwzSEglERaqPbcXFAXTHKAr0SWKGnHluvmZY0EnPI8wb6cAaYYps+FWo660=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gULSIVME; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4EBC5C32781
	for <linux-pm@vger.kernel.org>; Sun, 26 May 2024 20:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716755804;
	bh=Ac+vW4SGwHc2aP+J7pmPbGNjRiqfbgfdLnyok54UXto=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=gULSIVMELRrtaTd/eOatnSkpi6xEfB0vwaptVERNaPtk2QF7ymgCC6MS/jouMYry1
	 57BogwHCo0/WYH/XnfjbRCEYEsu20NWlvR1FeQb8c0cLA4SRJslc/r+txhBRAe/C+m
	 LF/fG5MBamzKWdjOsXuxkhISSUaJhumC1Kn+C0iTz8SfF9DdPaHJNlPmiivz+cNbtG
	 1ptONJMxBQjriJVVw+KunNEjA1tikw317Rikkf7JAIqBee9+SsVfcUtyRbvqqICfPc
	 pp9uv/e/2123gNfn6ZlgYxCCbrJORXwxwp5z1xV68zinOnA5Yqs5SJirLSrdWNvM1P
	 KNTVC+RPkro6A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 46E5DC53B73; Sun, 26 May 2024 20:36:44 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218865] NULL pointer reference if X86_AMD_PSTATE_DEFAULT_MODE=1
 on a AMD CPU that supports CPPC
Date: Sun, 26 May 2024 20:36:44 +0000
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
X-Bugzilla-Resolution: PATCH_ALREADY_AVAILABLE
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status cf_kernel_version resolution
Message-ID: <bug-218865-137361-nhnrN84A3Q@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218865-137361@https.bugzilla.kernel.org/>
References: <bug-218865-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218865

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
     Kernel Version|                            |6.6.22
         Resolution|---                         |PATCH_ALREADY_AVAILABLE

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

