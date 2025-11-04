Return-Path: <linux-pm+bounces-37346-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B1FC2FDDA
	for <lists+linux-pm@lfdr.de>; Tue, 04 Nov 2025 09:28:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5893426947
	for <lists+linux-pm@lfdr.de>; Tue,  4 Nov 2025 08:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3AB3128AE;
	Tue,  4 Nov 2025 08:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EJkd9JGt"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E6A30F941
	for <linux-pm@vger.kernel.org>; Tue,  4 Nov 2025 08:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762244442; cv=none; b=XvXXyltUkCZAsO3IH3V4GX5LV7iVKffctGK0Dik5qBblN3eEOLCJ37KmvnJFFW1nsSzCJb/IonEIGzhigWQesMOJiwXMxx+i1fmpdngLRY+GVGLdJP2wapZDDsBQbv8KCwhx8aOmrAMJ1nQZW+P3rKF1jLAy7/7ivNVy7IMqD9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762244442; c=relaxed/simple;
	bh=mriUUgDpMI3rDeXfO9Fk+PqE+Ac5ru5SneErXbM3JHI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P2RV70zqhgCO6kgdS7C6VXkpqf9b1xv2i8vmRHIegNyB06Bhsa/HI4OnuyabBSKx/j41nDJxVpd3i+5XQUioLyFyLA76NawzIX6yfq6atBbEMevWz7bmv+gxC2AeF7uiyEVOISBw9LDFUmo8DO46HXWnCPnOrtOaA98cRbk5y5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EJkd9JGt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 39BD7C4CEF8
	for <linux-pm@vger.kernel.org>; Tue,  4 Nov 2025 08:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762244442;
	bh=mriUUgDpMI3rDeXfO9Fk+PqE+Ac5ru5SneErXbM3JHI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=EJkd9JGtfAk6ZOaIhLQY+EQHdaFZJDHck1XNXoB4uqBcIG7cqzTYx3qjfnERBY/KV
	 3xJAf98OpiIKiCw/4QrE/uGK1Lrv0RuNfnTdfUKmEK5DvFN672F6c+ZWXwXiMos6nH
	 d8QTOmlsodllachJQEe9tsljms4pk0Ld2GpFM+PIew9CVzfN3gqFZCPEnnWgvDCgxY
	 ApwOzkxMzn/nRWT6zQGSmT3usfe6YLgv8OIpie3erCAfLPa4OdaXZYGHdrR9PXNQpG
	 9SKnR9l1YM3Ny4awDDwQjG8xPbc1iiee+65jnk4GGdvMYD8pYPzWFPjzVWx1e8clcA
	 uinTF4PEV0tCA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 33777C53BC5; Tue,  4 Nov 2025 08:20:42 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 220715] [REGRESSION] AMD P-State fails with "_CPC object is not
 present" on AMD Zen 4 between 6.10 and 6.11
Date: Tue, 04 Nov 2025 08:20:41 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: chris.harris79@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-220715-137361-SK5cswiiua@https.bugzilla.kernel.org/>
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

--- Comment #18 from Chris Harris (chris.harris79@gmail.com) ---
Thanks for your engagement Gautham.  I tested the 'prefcore' patch you prov=
ided
on v6.17 and unfortunately it fails as well. dmesg attached.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

