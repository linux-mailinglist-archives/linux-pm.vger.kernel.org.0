Return-Path: <linux-pm+bounces-15119-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D88B298F6FB
	for <lists+linux-pm@lfdr.de>; Thu,  3 Oct 2024 21:26:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 115CD1C20B11
	for <lists+linux-pm@lfdr.de>; Thu,  3 Oct 2024 19:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0254B1ABEAB;
	Thu,  3 Oct 2024 19:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gJpYk+oC"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FCABA41
	for <linux-pm@vger.kernel.org>; Thu,  3 Oct 2024 19:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727983558; cv=none; b=hWA/E5/6nbemgE0Tp2JISuEtofEeT4HQjUm2a0eQPWuNiTs+k4udLMhx47kaQ7IGkeBIjwP8lBiAC2xjdauXZ3BA6x/aCpI5OKVCSKyX0TqycynMen7W4Lv4IA8IWQU33PdSI/NwhMfrPcJzTq5BMD49smtXuOSP+/FPrtFXxkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727983558; c=relaxed/simple;
	bh=ZFCuIxj9BN2G/U6DembzImF93pa33BAgwlW5jkQcdhI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EZT78gnvtCBpr0I08Wv6B5eL7DGHRF/PBlQFxXTlul5Q4GxcEVAotMzaY+nhWhK9geknU+8K8qPKnvbyWQm6JA/NwgsmonE6hT+XabpFjg/xg5QI4ZnfteUk1lfwLBgcossibD+r6IIBhevNnQRvXny4gsbhZBDVpr3nCUnnMlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gJpYk+oC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A8DF0C4CECC
	for <linux-pm@vger.kernel.org>; Thu,  3 Oct 2024 19:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727983558;
	bh=ZFCuIxj9BN2G/U6DembzImF93pa33BAgwlW5jkQcdhI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=gJpYk+oCC65ZKPG7eu8C0nT9dBIby0W5Ca1ji3QstrVDcxM/+gIIF7C79OT5OLnO7
	 6NYQWkTfuJu8YDu/CkncmxmFoDK41lVuL1xkpcVvMukiKn83tmYsI88MuaUi9lrt7A
	 DFnYrIAGfRW4WiFEX5MOxigLdu8R2JDXJ0IGuNINr7/2Xz7najbIAPbTCui72DCnYh
	 YLMWnrxdv+qUjLNlgOJsK49z1ktU8hswaO/LU6H3lpfLQYF0qZhEVtgBCroUQYL9iM
	 lB2WuSPvZX7ApoeOpdN0kAtlZyJYj8grya9lxWIw8Dfn3o7XpCrIjD7G/iC36kjuP5
	 mr3V2JgJbb1MQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id A38B5C53BC8; Thu,  3 Oct 2024 19:25:58 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 219348] [6.12] amd cpb boost disabling does not lock frequency
Date: Thu, 03 Oct 2024 19:25:58 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: mario.limonciello@amd.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: mario.limonciello@amd.com
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: assigned_to
Message-ID: <bug-219348-137361-xFoJEY2HKq@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219348-137361@https.bugzilla.kernel.org/>
References: <bug-219348-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219348

Mario Limonciello (AMD) (mario.limonciello@amd.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
           Assignee|linux-pm@vger.kernel.org    |mario.limonciello@amd.com

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

