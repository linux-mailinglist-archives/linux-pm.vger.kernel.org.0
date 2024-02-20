Return-Path: <linux-pm+bounces-4174-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 361BF85CB9E
	for <lists+linux-pm@lfdr.de>; Wed, 21 Feb 2024 00:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E568D284467
	for <lists+linux-pm@lfdr.de>; Tue, 20 Feb 2024 23:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEDAE154434;
	Tue, 20 Feb 2024 23:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jNmShmcn"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BA9154427
	for <linux-pm@vger.kernel.org>; Tue, 20 Feb 2024 23:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708470078; cv=none; b=qUBZZ7x/3guULameWa7AsxoTGIxhDnYp37SarHs8amDdTQXZLFEjvu+5aspM1T1qBcp19zMN93oeEitXFENUfDXJiHsnj8Yfrnz9SmU82W0KFNgsruXhD+Jsza5sb2NOeDxFPEwEBvVkDRQO8wopVXWpqks0QUXif7o1xjAOyzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708470078; c=relaxed/simple;
	bh=p+PIqQVpnnJUECR+GtkF0R/jlhHxmcf3NG22en4JFlA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZX/2/bzYs9cc7hYaQ3kjt+173NnHwl6oO2YhNTKhfoFj3yWb4JmezSFUxjTMDuv8wrpkbcnPNW6gsRDHQGWlc8/DFWSB3J0S/FwF2JoPffNvq141Ba+wg3GKS5rbL7Ae8ETBdDklwd5kOPtSfhV0riQsj29v6dP68/q81JYsKvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jNmShmcn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2CFCAC43394
	for <linux-pm@vger.kernel.org>; Tue, 20 Feb 2024 23:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708470078;
	bh=p+PIqQVpnnJUECR+GtkF0R/jlhHxmcf3NG22en4JFlA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=jNmShmcnaAd5GNJVYewh3Ey0a/4PJ1V8WRpVu7FunbDk8/2ZVVbix+5iQ1+3yFsyA
	 a4QHGkD7kAZoU4SgyuB972yYrXu/zr9uRaJd4IisBBClmVv1FX/UJsjQVQxhMIed5y
	 j2Cm37+k0NyDh6WljDl2w4ImeMmM1dSEFKsZBMvb5FKh0RcE0oiqudVgim/XUEYDN0
	 7UUjTjcnib7vcfP0gKEwmmKITDks4l61137/WekTuFSxuzDm4p4q3jfv7K5NFj9GAp
	 kiNgvUamCw5TZ6RGlkHfPHLYNMiS64EjH6B9JZBcsSnWkAka93Gc/7amU4fLjJIm0V
	 bVTDbVGdh5uqA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 16737C53BD4; Tue, 20 Feb 2024 23:01:18 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 217931] amd-pstate lacks crucial features: CPU frequency and
 boost control
Date: Tue, 20 Feb 2024 23:01:17 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: sfjuocekr@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217931-137361-IIt0zvbQAE@https.bugzilla.kernel.org/>
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

--- Comment #54 from Sjoer van der Ploeg (sfjuocekr@gmail.com) ---
(In reply to Perry Yuan(AMD) from comment #53)
> How about the output of "lscpu -ae"?

Sorry for the late reply:

CPU NODE SOCKET CORE L1d:L1i:L2:L3 ONLINE    MAXMHZ   MINMHZ       MHZ
  0    0      0    0 0:0:0:0          yes 4550.0000 550.0000 3569.5090
  1    0      0    1 1:1:1:0          yes 4550.0000 550.0000 3552.6860
  2    0      0    2 2:2:2:0          yes 4550.0000 550.0000 3559.3779
  3    0      0    3 3:3:3:0          yes 4550.0000 550.0000 3854.7759
  4    0      0    4 4:4:4:0          yes 4550.0000 550.0000 3590.6599
  5    0      0    5 5:5:5:0          yes 4550.0000 550.0000 3552.8989
  6    0      0    6 6:6:6:0          yes 4550.0000 550.0000 3840.7690
  7    0      0    7 7:7:7:0          yes 4550.0000 550.0000 3584.2910
  8    0      0    0 0:0:0:0          yes 4550.0000 550.0000 3546.3811
  9    0      0    1 1:1:1:0          yes 4550.0000 550.0000 3551.5229
 10    0      0    2 2:2:2:0          yes 4550.0000 550.0000 3591.2500
 11    0      0    3 3:3:3:0          yes 4550.0000 550.0000 3594.0801
 12    0      0    4 4:4:4:0          yes 4550.0000 550.0000 3552.0400
 13    0      0    5 5:5:5:0          yes 4550.0000 550.0000 3572.1050
 14    0      0    6 6:6:6:0          yes 4550.0000 550.0000 4124.7349
 15    0      0    7 7:7:7:0          yes 4550.0000 550.0000 3583.7170

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

