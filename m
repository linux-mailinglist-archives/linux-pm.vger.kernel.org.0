Return-Path: <linux-pm+bounces-8043-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1348CC35E
	for <lists+linux-pm@lfdr.de>; Wed, 22 May 2024 16:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18A51281573
	for <lists+linux-pm@lfdr.de>; Wed, 22 May 2024 14:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F99B15AF6;
	Wed, 22 May 2024 14:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m2PBI/Af"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5C617550
	for <linux-pm@vger.kernel.org>; Wed, 22 May 2024 14:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716388778; cv=none; b=aEaeDQkVQDB0OexmBIl1NjCGhiLfP9eXdN8PveJUwqTkt6nkAZ8DT7Ix+hE4khurcP9G61gmPG7ddM4U05rsPL8e2w2Zz7kWP7zhx6W1hfWGwyCEtQSXtJTNTNVTNOAxaOEGk4clfcZaFaYIS7cDVmk4+ZXLIPIqSDscQe+e88U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716388778; c=relaxed/simple;
	bh=TO/3SJdZmDrJO6iGjZiL3tV1xAkgvcQhNNQ9tRU9ino=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cpvHJ4W7rI7cmzYYhCnGMEcgeBKMifB48+IVifEUuI2vPOlwq4iQNGAQQRd+/YNf00SZ6zyF77sz5VTkzRqCZw7+W8C8vj37LygAK1ldCU61/Kgdl/8OjDEk3L5gCiwq14ubmpVQwedHXsjJRa6zZ0upa82fOmANj499riVa+Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m2PBI/Af; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B36FFC32789
	for <linux-pm@vger.kernel.org>; Wed, 22 May 2024 14:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716388777;
	bh=TO/3SJdZmDrJO6iGjZiL3tV1xAkgvcQhNNQ9tRU9ino=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=m2PBI/AfR/Ajw00TeKtEm3/HuIDNIvWz4aVlyOkFuf3uJ6LYQa683pM7lfxo+p19J
	 JuuxfkNmOGx67tPzP93XUhVNIHwy7HywRGhfw1DcXQPaAYecoEkXiM5QRIGLZrgtMZ
	 GlOczMmKW0Cn1WlF0FFvr7mKO7+vqjITG9dnf3OhDlv5Kqmt4KhA1jwI9ERFc/Y3AM
	 T7vWiN5BdkhT5QMOJPeneuO5OqVJi2gG0Qdlz6sJTde2jWFtVtrh0jvSG7CzvmZlSP
	 uVTvzQ23nCOIT1+w64W29BykrMIMM4QL77LNS+dscRAE9ofaqLpE1vM618IxG4Dcmg
	 6PqGoWAzDk9iQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 9E723C53BB8; Wed, 22 May 2024 14:39:37 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218686] Fail to set energy_performance_preference of amd
 processor on asus ga403uv
Date: Wed, 22 May 2024 14:39:37 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: mike.stokes85@gmail.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: DOCUMENTED
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-218686-137361-LlMC2XkNy0@https.bugzilla.kernel.org/>
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

Mike (mike.stokes85@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |mike.stokes85@gmail.com

--- Comment #49 from Mike (mike.stokes85@gmail.com) ---
Hi All,

I have the same ga403uv system.

watch -d cat /sys/devices/system/cpu/cpu*/acpi_cppc/feedback_ctrs

Returns changing values, does't this mean cppc is active?

Mike.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

