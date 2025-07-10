Return-Path: <linux-pm+bounces-30586-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E0E0B00313
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 15:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3CA316CBFB
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 13:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102062C15B7;
	Thu, 10 Jul 2025 13:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t4eB/E96"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D973F27F749;
	Thu, 10 Jul 2025 13:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752153173; cv=none; b=Y0jE/7FRzpbhaOOGG2XUKQt999IFcD7CCdZ5YvcN8La7KDRqw5eAWvvNtaYA1Ss1biA8ZTj7Dxt3CUa4ANngm8WkL61FZWOK5aESlf4BS8OYKh3+YuMvzu7OIRJ/uQJd0eCS9xfQpMsDEUhLoW8Iz0+HXJLXEKSBGuwjJt48lMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752153173; c=relaxed/simple;
	bh=q9abc7oDZLcrtsMuNt1PO9GtWY5Cpp2InagfHvwx58A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vGwN0N/Sjl0jiPQaKhzR/G+CB4P6i2jkuU/b/gDNO5TYHN6DQl9CvfFPKdSu1eWAIWbOF44Yl18lCugnF+cK7or5i17ybOrufx4SwcTOuVyWy5Y0wPErM3St/oUqF64ShX4RtEefs8g1m/WtTr5XHwR0uwHxdHK706IdQkZw7jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t4eB/E96; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC2B7C4CEE3;
	Thu, 10 Jul 2025 13:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752153172;
	bh=q9abc7oDZLcrtsMuNt1PO9GtWY5Cpp2InagfHvwx58A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t4eB/E96oPfoYrzKEEkI+GgqjVDfIsE8xFcwhS0OUm/BBiiSk2RYf2RUf0N9rFBqa
	 cyeWTdcEiHkGjmWnAQ4+PqdIss7v/rC5faUUdtvgrSBKIfUzFHlXD/BLb1Y5P+Iwtn
	 Dm+9JdtsGuzG2cBgU5Sx+UJ2YyTLfwDlmE+nYHCVknsIVXg+YOR4SdyywciLOShV6j
	 FsqIzluUatlkHPWYrfk6D/MsKAn65jl9ezdWI1S9csY1M6VB/f/Tnsa24lSdojVjJX
	 5kG38VgKR0AoFKfy6Z0dsL6F03PhwxR3jgNJd/BI/HEus9uKShLrl6AkZ93Smo2OkV
	 SzYf97dkstYHA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: kexec@lists.infradead.org
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH v1 1/2] kexec_core: Fix error code path in the KEXEC_JUMP flow
Date: Thu, 10 Jul 2025 15:10:41 +0200
Message-ID: <2396879.ElGaqSPkdT@rjwysocki.net>
Organization: Linux Kernel Development
In-Reply-To: <5046396.31r3eYUQgx@rjwysocki.net>
References: <5046396.31r3eYUQgx@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

If dpm_suspend_start() fails, dpm_resume_end() must be called to
recover devices whose suspend callbacks have been called, but this
does not happen in the KEXEC_JUMP flow's error path due to a confused
goto target label.

Address this by using the correct target label in the goto statement in
question.

Fixes: 2965faa5e03d ("kexec: split kexec_load syscall from kexec core code")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 kernel/kexec_core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -1080,7 +1080,7 @@
 		console_suspend_all();
 		error = dpm_suspend_start(PMSG_FREEZE);
 		if (error)
-			goto Resume_console;
+			goto Resume_devices;
 		/*
 		 * dpm_suspend_end() must be called after dpm_suspend_start()
 		 * to complete the transition, like in the hibernation flows




