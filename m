Return-Path: <linux-pm+bounces-6147-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B1F89EB2B
	for <lists+linux-pm@lfdr.de>; Wed, 10 Apr 2024 08:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54ADF1C21000
	for <lists+linux-pm@lfdr.de>; Wed, 10 Apr 2024 06:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7692F48CF2;
	Wed, 10 Apr 2024 06:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fbOc8bFl"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481AF45974
	for <linux-pm@vger.kernel.org>; Wed, 10 Apr 2024 06:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712731369; cv=none; b=Gk3Ds6E2cHWXoieGz18QzbuDCsxOBSPmllL3KSG9AB7J+fskE9kR0oC5EMQJofirwR09l7SY0M5+GfeYMNzjFcZRMVCUMzBqO6UTs6To53bh6hvOUt0cfdVo2ES7yYUk0NtusDO/3r587YVLUvLS68ov6sCLnJtPYrNh8SfkO/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712731369; c=relaxed/simple;
	bh=Qhx5+i7qZB02oMYYQ0NE8kwF5ieNeHqsSyfBWrl5f0g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pwfSCyLzaD1bSGfs94troOeKeU6L2G0ql6zEmueNT7EhsVsvYR7Y2Qf9KjntEsclN1VufNftqIYJhXiRcZo+fY7LUovQv7wJRGS+mh2yHjaGpmw9/N8vGxxExRsIyJ9zwug0BnxEUErxtNAyv2C48uv8Z1Tcj4RoeC0v3okHYCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fbOc8bFl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9B91DC43399
	for <linux-pm@vger.kernel.org>; Wed, 10 Apr 2024 06:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712731368;
	bh=Qhx5+i7qZB02oMYYQ0NE8kwF5ieNeHqsSyfBWrl5f0g=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=fbOc8bFla2O+B5Wrs3lk/aZPsyA+XlRKmGFh6JeCSRoW+q3rN2Aif2wvNJyL07FTj
	 /ZAOYixBTpdbvTZSWU4mP12/r2/uBBOeHVzdwG1XPKwurQFDezt3zsT+TjBZPgqs0B
	 jRL08f67vhGINnnAbgS4QiFA7u3m8nM5CN1ZpgxDTt4+gOzBdSU6imK1Qbl/ATyaDt
	 qCMxmZsI8uMYNZH9/K6pCNHwg1/PjKRQDkeRkQziGSVDKKxc4vfSkSGaoYdcStCxlu
	 yE2mvhOCbZbfqmmtRfc3SAe6kae0hnuJ5e4GQvGFrtLA4nMht2skWHHZTKaFQbRUFn
	 6YBxC2h8gHQ1Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 6804DC53BD9; Wed, 10 Apr 2024 06:42:48 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218686] Fail to set energy_performance_preference of amd
 processor on asus ga403uv
Date: Wed, 10 Apr 2024 06:42:48 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: al0uette@outlook.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218686-137361-AW0tyXgpnc@https.bugzilla.kernel.org/>
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

--- Comment #13 from al0uette@outlook.com ---
(In reply to Perry Yuan(AMD) from comment #10)
> =EF=BC=83=E3=80=80sudo apt install msr-tools
> =EF=BC=83=E3=80=80sudo rdmsr 0xc00102b3 -a
> please try this to capture the msr values.

It turns out that the segfault is cause by my distribution/kernel version. I
changed to archlinux with 6.9.0-rc2 and got all zeros after executing rdmsr

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

