Return-Path: <linux-pm+bounces-11750-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E4B942D7B
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2024 13:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 609801F22895
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2024 11:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B37C1A8BE6;
	Wed, 31 Jul 2024 11:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PWQdXAoH"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BB6193072
	for <linux-pm@vger.kernel.org>; Wed, 31 Jul 2024 11:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722426618; cv=none; b=j3JfkLp1UbkWunZM18omfpLbXCBa1vXQmUWA2StyxKTu9m1mX4V2IVhDOd0gQnwEV21DCbL+uIgv8K4UqlbqyltfAoymOrRq/nzO9BwaUCs49KBMITDmG/tY5EmxoDIQwDPKzunC/6GDhHgd6NPw8vugeFbA0mq+keStByFMUqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722426618; c=relaxed/simple;
	bh=o9FBaBGAQnOBGcmp9KMElnaMPPq+wMxBUc79lz7kDCk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ga+rqqvCV/31kodsOT0PynYiJqZWoBbC0gkH+VCFJWkkR6OPynZWTJLPkYu5mdYa3tSPOKMktI6b1X67sFNjRrFrdCbmpwEMbltiIZqhs//YSP3XGONOMzHe1xNW1DbKLqLeFRpHrQYQr/WBX/Ziz5Hij64QMyEpxz+VPqEFKs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PWQdXAoH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E2BB7C4AF10
	for <linux-pm@vger.kernel.org>; Wed, 31 Jul 2024 11:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722426617;
	bh=o9FBaBGAQnOBGcmp9KMElnaMPPq+wMxBUc79lz7kDCk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=PWQdXAoH7/MQEdXyRZsrEsYfdg5bZ027WexX3Mq2NjH6xlQVFS2rM85udsSJlh8Rs
	 gpgABKvTRV/8Brnx0rqhWdjrzg3Y7pL40MxWR/xyVQqOota2g2zjDh+xZRpcL8kWTi
	 xWk4Adntbb2Q3SuVMjrhM+YcFWTwnOGue64wvr2c2wtMgalzLBNurzknnW050p+yby
	 z6lM5qTCoSDIOSx9tzIeZDWd2mn7lZVR+pmLi60todn0aZ9PTd3bKZT29aU92bRt90
	 5s7HqkgRY86KNP7hNsZKZrLUmN8gSayzzc1mf1xL2blwMfESJGKMo8kJ7YUgBrJ1Jp
	 AvknhS46zsSaQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id D7ECDC53BB9; Wed, 31 Jul 2024 11:50:17 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218686] Fail to set energy_performance_preference of amd
 processor on asus ga403uv
Date: Wed, 31 Jul 2024 11:50:17 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: chemasanchezgarabito@gmail.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: DOCUMENTED
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-218686-137361-V0zVRAnGud@https.bugzilla.kernel.org/>
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

--- Comment #64 from Chema (chemasanchezgarabito@gmail.com) ---
Created attachment 306645
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D306645&action=3Dedit
CPPC working on windows asus ga403uv

The windows kernel log are showing that asus ga403uv in windows 11 is using
CPPC

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

