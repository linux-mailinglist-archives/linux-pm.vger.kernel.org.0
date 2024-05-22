Return-Path: <linux-pm+bounces-8035-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7B98CB8DC
	for <lists+linux-pm@lfdr.de>; Wed, 22 May 2024 04:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DAA51C2264F
	for <lists+linux-pm@lfdr.de>; Wed, 22 May 2024 02:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9DC33DF;
	Wed, 22 May 2024 02:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CNQ/5rlM"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862D717F3
	for <linux-pm@vger.kernel.org>; Wed, 22 May 2024 02:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716343978; cv=none; b=n1dA5ZSQCZ8b7vIxXkoxLlRBaNMMbFdY4ecTSGya3dAPNz/MuUr+tL38z5tofPctDXmW9KibxantrVGyfN1/jKtUhmNdPOh87/qtZ4802p9qdrRWeTKQdXerjxaulTVHITxM61DmWZkpMnqLgvC9obeoTHF+uGbCnDMMUg5m2ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716343978; c=relaxed/simple;
	bh=01JLXKNtBWjHcBipbccXjtrSMa0pYDrUsOUNRB08Gro=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ufH11CkJouCA+j/0lh//L2QEDhI9hOiq/De5tENGoQsPBvxxn9dZSwsA0lmPP5rQpfWS2p1vTCbwQ7Yiyxlufdjp80AFE8KVsEuh8IMFcFMIVK+WfZSiPYyZ8eZp89yUp205u408ESFlPHvuzpOqqMK03az6vSY1AV8qqzuuIic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CNQ/5rlM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 17A4EC32786
	for <linux-pm@vger.kernel.org>; Wed, 22 May 2024 02:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716343978;
	bh=01JLXKNtBWjHcBipbccXjtrSMa0pYDrUsOUNRB08Gro=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=CNQ/5rlM7bCHbx1MuhY8CY2Rhh9EGpLw6ka03Is5CA5OAdM4cdoWMi+mq4RqmeLS4
	 4hb2C9sDf7xUJGgNtgVi9GkgNnKlNomRZzpobGumsdQCMPMC50Zj1oBZcFaoqlc5Ny
	 R/5N8reI2IVfSWWS8GURSEbTrLUvtyyNkcA1zXAAJCNEMBs4zxekSGgNxRw5xolbAC
	 d2pz0wsHrRj7Uzx3oh+tnOK3+RvA3sXEc4FwA6KS9F0GhoBo7X+aLpimNxsMv7fO3Q
	 kCMLyObocanJ7sUWBDcVRa38vbvxCic+1Zx5oQ5aBJkhYHTQLVAZOEhqFUXRCOeM02
	 QNaG9FGpHKbSQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 02AF4C53BB8; Wed, 22 May 2024 02:12:58 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 217618] Changing maximum frequency and boost state does not
 work with amd-pstate in passive mode plus the schedutil governor
Date: Wed, 22 May 2024 02:12:57 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: Perry.Yuan@amd.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217618-137361-77O7jQjvAb@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217618-137361@https.bugzilla.kernel.org/>
References: <bug-217618-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D217618

--- Comment #6 from Perry Yuan(AMD) (Perry.Yuan@amd.com) ---
(In reply to Prajna Sariputra from comment #5)
> With kernel 6.9.0, it looks like limiting the frequency control now works=
 in
> both active and passive mode, and in the latter case both the schedutil a=
nd
> ondemand governors respect the frequency limit, so this appears to be fix=
ed
> for me, thanks!

good to know that.=20
thanks for your feedback.=20

Perry.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

