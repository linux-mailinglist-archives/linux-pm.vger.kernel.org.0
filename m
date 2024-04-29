Return-Path: <linux-pm+bounces-7296-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21EA58B63DA
	for <lists+linux-pm@lfdr.de>; Mon, 29 Apr 2024 22:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D85F1C21595
	for <lists+linux-pm@lfdr.de>; Mon, 29 Apr 2024 20:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B3FB1779AB;
	Mon, 29 Apr 2024 20:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iQlsfeP3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-il1-f201.google.com (mail-il1-f201.google.com [209.85.166.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E8633C0
	for <linux-pm@vger.kernel.org>; Mon, 29 Apr 2024 20:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714423835; cv=none; b=FeBwNR149+oM9vxzYK90Ea4ZOA4R87/x4MfQSjZa5a4xWSakKVSkcBj2TAsMZ84vtMlqjD6S9XVrQjo4I+DqRIIEepjfubCvfLBPskCkNJSKq6qfZCWb8vLRgZ0JuYeGJ/OuXLPgq/Lv1zLCnaUdlTUmEc8BaFg+63tLEjzlnyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714423835; c=relaxed/simple;
	bh=E51RN5MCBslyxtFShtUwThE7vElft68Pwp0ik5uTa94=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=uP2IIy7JSK4mawf6wp2VCRcyQzJ1g/dvnlLMOj+X8+Aop8cISnjeszwL265D3YkAMykaGOrmCI3VY1fPhn/XQF/xnH+VoiQAUSBbAKC9Q//eJP99Lk4/Fz6qzBYNTdN1mMFY5Cr5owUG4Cv3mXJn2OedCMFc5HFmqVLi35B1+1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iQlsfeP3; arc=none smtp.client-ip=209.85.166.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Received: by mail-il1-f201.google.com with SMTP id e9e14a558f8ab-36c05c86944so54423425ab.0
        for <linux-pm@vger.kernel.org>; Mon, 29 Apr 2024 13:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714423833; x=1715028633; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=p+KWfUI7WWjJz2aEzllZVt1Sw+QNmzAz/2DNTRseciU=;
        b=iQlsfeP3PNVldcJa9zzyk5dcdlNcSO4Hs6D8TTNB2xJ2WCMdN/zxTziC/KLYbw/0AC
         vs7ddWBnIMzgwG9JKcXCibZLcjD+KeeF9e3V9MVkW/B94ARTVhELXNsUHSlN/LW68vvY
         qf/Mfrshqq/heqZ3ZLXSvWMnvjoi6U3Vv7wsU6cWgwBHf7MZze+qA9r396FOiuXRj1sL
         2F3S/qqPvmPk7VYncU0baxJoOnFS4i9B2/VRdORqZ2AjZgJUG9+HNQVVyVmQDWUtpqN1
         6uG3iZ6VwVKDhT87CyuuPGxceZiZKd6+kDKLHgAj1MxZ7iFfJcH5CG+dstD/gy4kp7lv
         LNyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714423833; x=1715028633;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p+KWfUI7WWjJz2aEzllZVt1Sw+QNmzAz/2DNTRseciU=;
        b=nEoWN7flR+Kk88PPaIXI8GopzYN76qTQXwO5e0fudXIJ3T9evAez8ZIMUPHof7xgoE
         6ZpPUjnV3VzdsLCNz0e+CNxNRCSbDW/OsBmzC1FgBtG/6EKfjXOFi1RUhkV6upvekv0S
         bonfMrVPQlZo+5jci5VamwPGwvphhiuIHsZ0yFySNjCGoLikYFyI22Z61rv3Yipb5U68
         CqrkmHmpazNNHXicfMVtYhHyHLgzJnUVM9xPssHoJ2upvreoiDVFNXFy2KL1kS7r6OW/
         sbYOUZYtI+Cwo7pwJBLTdZFEbWso3s64dxyEqbvJ0GaDYQmmXE+KSHFUDvIcIUcV7hRD
         tkZQ==
X-Gm-Message-State: AOJu0Yw36DVDJsyxgidvKSF8lnU0eA53k7Dt6UNkM6HU6mOFTYn9g3C5
	1fr2u6HAKhL3sp6swNwXxJj1tDj3Ww7GPxj3x8x42gM+W+IK3/Nw+S9delea+1S2Dxi6bag0s19
	EfHEWunkhv5bbPYsob8bgNw==
X-Google-Smtp-Source: AGHT+IFmrEC39GW//zFmGOIhRKDWCLIzg+5DId6LIi/jSAtahHuWsAG/CndMnYRnHSw3kt3DwU65bT4uzvQA4TMr2A==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6e02:f13:b0:36c:4405:68af with
 SMTP id x19-20020a056e020f1300b0036c440568afmr265464ilj.6.1714423832942; Mon,
 29 Apr 2024 13:50:32 -0700 (PDT)
Date: Mon, 29 Apr 2024 20:50:30 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIABUIMGYC/x3Nyw6CMBBG4Vchs2YSqJXbqxAXWH9lIinNtFEI4
 d1tXH6bcw6KUEGkoThI8ZEoq8+oy4LcPPkXWB7ZZCpjK1sbjkm9Czu/oR4Lh/UL5VnumVMCO27 bvrs2fWPtxVHOBMVTtv9ivJ3nD+WqHI9yAAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714423831; l=1762;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=E51RN5MCBslyxtFShtUwThE7vElft68Pwp0ik5uTa94=; b=KRsbfMxM48ZQuhpUdtIv3IR8y1K3aT/WjQXifMOc/OUMsw4zO+bfvDG1CgeQ8ial9UKusJEFS
 EIocTm4zPwKBfi9QfaKdU3X/YObu5KAKXEKmxSx6ktLmw/kSeaBYng3
X-Mailer: b4 0.12.3
Message-ID: <20240429-strncpy-kernel-power-hibernate-c-v1-1-8688f492d3e6@google.com>
Subject: [PATCH] PM: hibernate: replace deprecated strncpy with strscpy
From: Justin Stitt <justinstitt@google.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

This kernel config option is simply assigned with the resume_file
buffer. It should be NUL-terminated but not necessarily NUL-padded as
per its further usage with other string apis:
|	static int __init find_resume_device(void)
|	{
|		if (!strlen(resume_file))
|			return -ENOENT;
|
|		pm_pr_dbg("Checking hibernation image partition %s\n", resume_file);

Use strscpy [2] as it guarantees NUL-termination on the destination
buffer. Specifically, use the new 2-argument version of strscpy()
introduced in Commit e6584c3964f2f ("string: Allow 2-argument
strscpy()").

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 kernel/power/hibernate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 43b1a82e800c..0a213f69a9e4 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -1361,7 +1361,7 @@ static int __init resume_setup(char *str)
 	if (noresume)
 		return 1;
 
-	strncpy(resume_file, str, 255);
+	strscpy(resume_file, str);
 	return 1;
 }
 

---
base-commit: d7ad0581567927c433918bb5f06f3d29f89807d3
change-id: 20240412-strncpy-kernel-power-hibernate-c-77985696443c

Best regards,
--
Justin Stitt <justinstitt@google.com>


