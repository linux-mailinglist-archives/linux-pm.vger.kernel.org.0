Return-Path: <linux-pm+bounces-7160-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B008B3248
	for <lists+linux-pm@lfdr.de>; Fri, 26 Apr 2024 10:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3E1828375C
	for <lists+linux-pm@lfdr.de>; Fri, 26 Apr 2024 08:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4252A13C9A1;
	Fri, 26 Apr 2024 08:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gEMhhyUF"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D34F33981
	for <linux-pm@vger.kernel.org>; Fri, 26 Apr 2024 08:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714120112; cv=none; b=pmFFAo8d1975Obqmqb2scgZBnnSZzKEUeUMO1fNNgt1EPqhczfOVu3gkugIadLIlkvq1bWNR0woJrlHiHgTL/7chJylJPG0+HfVIcTpnqaKpkn8lGw+fCLGuODd0nnXsbGEEAtoImXcTlq0KJKZHzWkRFVP4w7B9MQXIQTLqJxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714120112; c=relaxed/simple;
	bh=4PmogKOFSZIcCPJJNYNSru3u9LHFFmdX+L5/KWEg1jI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bAveskIvTdrzIu2prWO4xVYRNJt9AU9yxD7g6k7WVBgButzgVdATXDUav4GfllXbn1B/QireFI8tS7PefaW7fbWktuiS48BNrsvltoMsXN90TQfvoV7Wr8HN8iq3tCgm2MDrpqmilY7lC6J6oPggUlJPP+11BEJKMarSCQmJ9FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gEMhhyUF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 86CF0C2BD10
	for <linux-pm@vger.kernel.org>; Fri, 26 Apr 2024 08:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714120111;
	bh=4PmogKOFSZIcCPJJNYNSru3u9LHFFmdX+L5/KWEg1jI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=gEMhhyUFOvLRXaQYFXA6vs4ke2nqSgGmyMIzO506AvvbM3GTki7u8BN6p/uXl/eBy
	 +jFpzs+MQQYRZT7hOTN0MOQxpnJUJFTnbFp+tb7+vHJbckmDUkWn4QqJEaAI6hmfZG
	 chWP8psk5XccUAnJGnK+VlVWNkg6MnB98bc8VtaDlmG5L+gkGytINIlAxdMsjA9b+n
	 8VEd/6IK06vEj08+8RWZGIYB3dB6J4ifsxljaLbwQD4PxHeflv0xiFN9IjAvmqdETj
	 1idXXYT94qUxa4fLcHhRb3R/w07tkFwF8p5VQI48bUYDeCOlPQ6zpj7xX2Xezh9B02
	 FJsx9tKPKyXDw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 79243C433E5; Fri, 26 Apr 2024 08:28:31 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218759] 6.9-rc kernels - with Ryzen 7840HS CPU single core
 never boosts to max frequency
Date: Fri, 26 Apr 2024 08:28:31 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: Perry.Yuan@amd.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218759-137361-CsgGmwZxvZ@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218759-137361@https.bugzilla.kernel.org/>
References: <bug-218759-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218759

--- Comment #14 from Perry Yuan(AMD) (Perry.Yuan@amd.com) ---
Hi all,

I have got issue root cause and working on new fix patch=EF=BC=8C there is =
one power
firmware change on this generation CPU.

will share the testing patch once I got it done.


Perry.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

