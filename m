Return-Path: <linux-pm+bounces-2348-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F18FE831FF7
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jan 2024 20:54:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30E641C2256F
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jan 2024 19:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0312E635;
	Thu, 18 Jan 2024 19:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uXuF/VWt"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB5731A9A
	for <linux-pm@vger.kernel.org>; Thu, 18 Jan 2024 19:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705607622; cv=none; b=uSwD9zTcIavrxKQ8omvMhdIeFvZvIzKUTXTv+cyCe2Cc3qe5iH3U1vmcgFoH9Wqwg6qWTVz/AtJkRGGB5WiEvjIj8wYDZNvfGqk1f0DJyoGeFZK6J15NvOwbRvksqHiHn9tznRV/dAQuuCzlywbYOuSsGzUm2dwkZxKmHyvvPQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705607622; c=relaxed/simple;
	bh=eQzig7rKoIntXYXVOGVMzqfYgboikkUsHDD0FstAPvw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qIdInu1y19Skl6d2g9hZcteFwYsLk+r5dRallbz5isNpiJxV+wMYPiYrmwj3gLdbfq0hsludjEdu9lz1m08JONVd7eIj4RQ23KJpb6AGkJwbZ9WT0xITFFnbY/PzA1BjmEzue2zDbUSIABYv3G3g8D/m5X4LHCQbafXB9Nss4pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uXuF/VWt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 507A5C433B1
	for <linux-pm@vger.kernel.org>; Thu, 18 Jan 2024 19:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705607621;
	bh=eQzig7rKoIntXYXVOGVMzqfYgboikkUsHDD0FstAPvw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=uXuF/VWtiWUSkuGQ+v9jfktiQ7mvAxQCYRQnqJqr+pZ9SN+bLJM9Sn+t27DbX8f/p
	 KOY6hE0dhTAdmPcDY7sjRYKOBs1XbXLqpv8R2i/oVQwCvkwI/Xs7Raf0vTmfol99gy
	 R/ZPyoTfUtSZWorT8A4KBhYW3bgJiueECLj02RvQ1RDGt1CBU08VpMMX75KcQK8kzF
	 8J5EXn/21mg87cRI4Qg8CpyhU5Xo0/o24jeu6Tuwnsh94t9IPpUgYegaKU4LQFFI2k
	 cIGcxfo52tbmfk/2R7OuiHMf/0J4XafLQC670XBMKaA6Tn5W0EJITT1vEnhvDV1xAI
	 dfGdZCkSH7BxQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 4057BC53BD0; Thu, 18 Jan 2024 19:53:41 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 217931] amd-pstate lacks crucial features: CPU frequency and
 boost control
Date: Thu, 18 Jan 2024 19:53:40 +0000
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
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217931-137361-Tmj3JLKLs3@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217931-137361@https.bugzilla.kernel.org/>
References: <bug-217931-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D217931

--- Comment #23 from Mario Limonciello (AMD) (mario.limonciello@amd.com) ---
6.7-rc4 was /supposed/ to fix the kind of bug that Pedro described.  See th=
is
commit.
https://github.com/torvalds/linux/commit/febab20caebac959fdc3d7520bc52de8b1=
184455

There must be another problem though; I wonder if something isn't getting
flushed out still.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

