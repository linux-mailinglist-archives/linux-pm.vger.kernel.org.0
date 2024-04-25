Return-Path: <linux-pm+bounces-7099-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0A48B250A
	for <lists+linux-pm@lfdr.de>; Thu, 25 Apr 2024 17:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D13AB211B5
	for <lists+linux-pm@lfdr.de>; Thu, 25 Apr 2024 15:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4EB014AD24;
	Thu, 25 Apr 2024 15:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vuw/gXjc"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF00414AD0D
	for <linux-pm@vger.kernel.org>; Thu, 25 Apr 2024 15:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714058774; cv=none; b=WlGJ7gYDcZcqTdwq5EkzWei6bkvSoP6z/dwq8QCLgoZEFKmw1DJfpnu3MTas4sjHsnbl9xZ6Dr9wg0pH+3kT8rmEogMbZFDRQV72SB+CJtN7+Uqs6qVUlMOsyGRgP2gdQSo3eWHMzFQOl23rjUzmedYKG16lGw2UAjDcnQ3tuok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714058774; c=relaxed/simple;
	bh=uGQfIa0IXb5Bqr1vTlMIt9JleALRTUQtiMOXXfrQ8Ww=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jf5Sjl2NVsTDXeBOJXyC3LdJFG2i3VlMSA1ZLwu5kN5Gm2rzjOAnPceNeLpd9txfvF+esnIY/HGEjaAwDOc4BPyS0F7OB4x0sM4d6Rq9p/ivjrATY621LcFEMANriIriukoRd2u8smEuVtHHnvD8+cAa06WRQPFUkTJokhgv/so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vuw/gXjc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 43EA4C2BD11
	for <linux-pm@vger.kernel.org>; Thu, 25 Apr 2024 15:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714058774;
	bh=uGQfIa0IXb5Bqr1vTlMIt9JleALRTUQtiMOXXfrQ8Ww=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Vuw/gXjcKtokfmyhQKbCqo7IepMRMtRZKqvvcZIRqxpb6+3jz7fMWszeF7MeZmt8k
	 8LvsrQtvzt6lyCn3pkoYoVGEvMTY0/RUVjFm80Hqo3nV8Rf5rmmywd6ofRZoZv5d6E
	 lBTl8+bDdKVMqCpO6kFO/cJ7Bjy00ghZg+tzi20Dpm/33d6xw4bh1PUlZcTTcZW/jz
	 glX7nQNfzp2WFHxp6X0DpevF2+jawIsw+S2sZFDQ8DXMYxVK43PDklwBhAkfMCKRn2
	 lZdwW8T0Ozrp8mDCtsNturRsLWFDtv8Lzu2z5slP2OokvF8FHiVse5M7VFBzqCRay+
	 /A5/kBUz7TEVA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 38C71C433DE; Thu, 25 Apr 2024 15:26:14 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218705] amd_pstate fails to load on AMD 5950x with Asus ROG
 CROSSHAIR VIII DARK HERO x570
Date: Thu, 25 Apr 2024 15:26:13 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: andamu@posteo.net
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-218705-137361-tpzKSubq05@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218705-137361@https.bugzilla.kernel.org/>
References: <bug-218705-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218705

--- Comment #10 from Andrei Amuraritei (andamu@posteo.net) ---
Created attachment 306208
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D306208&action=3Dedit
dmesg with amd_pstate.dyndbg

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

