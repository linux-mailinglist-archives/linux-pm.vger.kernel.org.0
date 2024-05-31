Return-Path: <linux-pm+bounces-8488-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5BE8D67A1
	for <lists+linux-pm@lfdr.de>; Fri, 31 May 2024 19:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1230D283FAF
	for <lists+linux-pm@lfdr.de>; Fri, 31 May 2024 17:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2733E16FF26;
	Fri, 31 May 2024 17:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TxDVehbV"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FBB16F83D
	for <linux-pm@vger.kernel.org>; Fri, 31 May 2024 17:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717175158; cv=none; b=nr0KsgJCUb1qpkuv2SPxD9xfE5iB+75O1bGIe09YCeXDtuZNvQkCzy3nrh8oTLtUicj1YlWwEqRX6zMAnn8czGMTiAAvCazCYi4hF8rUalB5ceqbXsRHQwIemj3FmMYnJIZpyqGFdNQQKveoHAe1zpjwQ1LIK1B+2vdIGgWWOAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717175158; c=relaxed/simple;
	bh=YdjLhqcRvge5AiubYgBpZiLU3M6uyaEmiA+cZB6ip/k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mgq0/3tYMU89052CUxKo0clKbdpYQ/QI+DgxJuxlExslbFL03A9VZKw3CvxwSwBuX9cluLdiI/V8T261lREkySFzMXarC5ghHiP/EccCKeU68vHpANd9E4PjI5MitagaS4pTFsJ0vdvkt7yhgtGYNcNY6b3lK2nC4V0NnDh5Ki4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TxDVehbV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8A654C2BD10
	for <linux-pm@vger.kernel.org>; Fri, 31 May 2024 17:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717175157;
	bh=YdjLhqcRvge5AiubYgBpZiLU3M6uyaEmiA+cZB6ip/k=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=TxDVehbVoqw+y9Ort8GntXvmMw1CoED3c97nBjxJNh23/MFlpK2x05y47xJUhMgFD
	 OtAnzYAbd51E5piTOfxcZa4S3LAm+mqmBFxfvT0z44trJx6yRaAbnKx7S31C47vTmk
	 g0Zal0lN+6UWFS/QlGeRcOa/kGgu8i4Csv5/w1Uc5VLPWhHD5eGxdwxT78NwQ+TUCL
	 NHPryYWc7YNzeqeKNJA5pgU4WbYnbNPV9v6ds8Qf4j9qmJtM/Z8FxepiAhGp+hsyPa
	 oixqe9hejSDBeXd6ehv2qDIEdIii0Yr7AvvbV+8d9ul9s6f0pIn1La9dh0jTxHein4
	 GZ5iJZ3UU53cw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 8110EC53B7F; Fri, 31 May 2024 17:05:57 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218919] My machine enter automaticaly in ondemand but my kernel
 config have default CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE enable by default
Date: Fri, 31 May 2024 17:05:57 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: ionut_n2001@yahoo.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cf_kernel_version
Message-ID: <bug-218919-137361-2310JlW9lR@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218919-137361@https.bugzilla.kernel.org/>
References: <bug-218919-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218919

sander44 (ionut_n2001@yahoo.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
     Kernel Version|                            |6.8.11

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

