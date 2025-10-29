Return-Path: <linux-pm+bounces-37015-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9198AC19220
	for <lists+linux-pm@lfdr.de>; Wed, 29 Oct 2025 09:43:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D14CB4EE972
	for <lists+linux-pm@lfdr.de>; Wed, 29 Oct 2025 08:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74DB3396F4;
	Wed, 29 Oct 2025 08:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PDkJji5N"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA486338906
	for <linux-pm@vger.kernel.org>; Wed, 29 Oct 2025 08:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761725911; cv=none; b=QbKd7Nb5DntALgO9iellrNK8V5mkiCXCokKd8K6fnCUxAE7qFu7roLY510GEUil9i0I6bkRTDys1xr37J4UZtSxRljbed3pT6qZy+C7Xlim+tXcm/X9YMPWYgHMUHh6APOonIZv3NDqQmouC/R7FeYCCNlstwTxBSl8cdldqpKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761725911; c=relaxed/simple;
	bh=ytOgLBaFXH0MjHGi3HQFFq5SOoOzuPaSnXx/JqK3xmY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HkcnPZPBswDzboShWNmjOigWwMoS+YP+yZ6qqUxrBbaOwdr/HrwSu1IyKyOkEmLJUCgLraJJ9DwNHl7wAe2wjVDHSOLg9AiKRLyWep2qjoAN2UH9RfgrWpl/DL/7Kud9nuW/lhEOajGZXeOhAZdQEZ2g5k1Q1459Aq6cQkyubew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PDkJji5N; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3304dd2f119so5365282a91.2
        for <linux-pm@vger.kernel.org>; Wed, 29 Oct 2025 01:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761725908; x=1762330708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BU/2ChziUWHxejZHVNmmLwHaGHaf0EEXiVZ1de6fJz8=;
        b=PDkJji5NpIy/iINL419GnAk+9+qYddfkAKyMuKwFe4mlyO6WGqcObFtOQ+Lptky7WR
         KJ1Wl2S7CV7RZyN7rjes5T1aweYJdAO3cVjnyE1eIOkSiJxpn0vYDb+9Aowm6Gdv9QCg
         NqipBCPtCxKEbyo8m9dUSyjA9lKk1B4e/OponYrV6bspekPHH4sAJl3T2EI1Y0xFxgUG
         XkgNhNQ3p5DvmFratLinp+c/jIfPeTtnog6V0XMo/IJ02fBZAWcgERwN6LMbe8S7mdWK
         psAfWnLveVVJaQR/Sqfq9Uw3UNAGesj6k0wht6v5yM/SLk6BbMr3MLsh/TK/vfviHkhX
         Hucw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761725908; x=1762330708;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BU/2ChziUWHxejZHVNmmLwHaGHaf0EEXiVZ1de6fJz8=;
        b=b/2v1eOefiiRDmKHhmwxSL6kX+Wry+sQJ2jKLV7kvSUGnFRDMtzKXzB0Zz57b8zCYS
         lOarFfU9qwXiheW9j8QAc/itt1+9wZlD7busWcN7BFGWakLAOOGDP4jv34gzxoLVBng5
         I6t5aTRCvEx19eBWmJYm//yI2DNRU1fCf57Dm7ntP5w39ExYW/YTjwdliosIvj86shZM
         6qWNRthodUYvyhFhP6ozNyzDU11lEOymttS22buUIvU6Hu6PpH4aF7fv0lTBKkOarwyK
         UN5GO2/pDqdP1n2Xts3nObzkwnznQ5gk+r1Afozh+qT3pR13I15W3FGTH4DDq7QbQy19
         JIcg==
X-Forwarded-Encrypted: i=1; AJvYcCXDEAb12xmx1DelEOOXRhFRE4YQr57dT/GPM8YY0RdIvxbwP53SDCyH8bjL1X+xDZH4FFKYdshGEg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxhJhT7rPb5oQAfC/Z4zhhWUIWbeqdKTwtx0HO5spapvWUWqZwC
	GDpNYsDtTCzkSqghkwA+MKUKzZIGc9w1MWSRztdwY7TuFJgUaKYI7O4m
X-Gm-Gg: ASbGncvM8YlwQx8AEie96c7DnuEPWYFG8yj4qnJMECBol60/dpE8b3eaPqp+NmHwley
	8KgfLOxUFMpBtd2wZ4hMTvACY0gjmK3bGIrHvH82CJ0VOpPlTvE21jKy2WpCMQfBS7kwUGaK16F
	Bipscj4W57oYjYpqlqfnblcNNH0vAmzbonHGluurFNQ2uBOnBZxFQMMlCWLHIZ1ouFEHOpSnmMv
	T1UUAHLQoxDUFZ4EWpoebOL41xsWYTWOxCGsF5qGSfnYEw7eDItCKhORmR/tUbk7PQtbC/zG4ov
	lvLKZrEyMCed1K08zkseidBByU26yuRN/9qjmz3KDrWHhnN7A4nn+eXHxrTMNfTUI0qiIDqwPVq
	mYwNG7XQDpoOitYv49VvZqodW/IC+BY5AsOXqs/LOKfJtLwFpm6aXD/kmk4AX5EVi10VJC+snrx
	PoGOaLOQY=
X-Google-Smtp-Source: AGHT+IG0hKoAdUsMURHNX2F0gCSO4GHclR682zY7XisnLdYkrJ5vgKbkXR26X+9oYI+y2cVVLM86Wg==
X-Received: by 2002:a17:90b:514c:b0:336:b60f:3936 with SMTP id 98e67ed59e1d1-3403a26500bmr2931834a91.12.1761725907889;
        Wed, 29 Oct 2025 01:18:27 -0700 (PDT)
Received: from LilGuy ([2409:40c2:1057:4837:724a:2122:38a7:2755])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-33fee84db04sm7905429a91.2.2025.10.29.01.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 01:18:27 -0700 (PDT)
From: Swaraj Gaikwad <swarajgaikwad1925@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	linux-doc@vger.kernel.org (open list:DOCUMENTATION),
	linux-kernel@vger.kernel.org (open list)
Cc: skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	Swaraj Gaikwad <swarajgaikwad1925@gmail.com>
Subject: [PATCH] Documentation: pm: fix duplicate hyperlink target errors
Date: Wed, 29 Oct 2025 13:47:37 +0000
Message-ID: <20251029134737.42229-1-swarajgaikwad1925@gmail.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix reST warnings in
Documentation/admin-guide/pm/intel_pstate.rst caused by missing explicit
hyperlink labels for section titles.

Before this change, the following errors were printed during
`make htmldocs`:

  Documentation/admin-guide/pm/intel_pstate.rst:401:
    ERROR: Indirect hyperlink target (id="id6") refers to target
    "passive mode", which is a duplicate, and cannot be used as a
    unique reference.
  Documentation/admin-guide/pm/intel_pstate.rst:517:
    ERROR: Indirect hyperlink target (id="id9") refers to target
    "active mode", which is a duplicate, and cannot be used as a
    unique reference.
  Documentation/admin-guide/pm/intel_pstate.rst:611:
    ERROR: Indirect hyperlink target (id="id15") refers to target
    "global attributes", which is a duplicate, and cannot be used as
    a unique reference.
  ERROR: Duplicate target name, cannot be used as a unique reference:
  "passive mode", "active mode", "global attributes".

These errors occurred because the sections "Active Mode",
"Active Mode With HWP", "Passive Mode", and "Global Attributes"
did not define explicit hyperlink labels. As a result, Sphinx
auto-generated duplicate anchors when the same titles appeared
multiple times within the document.

Because of this, the generated HTML documentation contained
broken references such as:

  `active mode <Active Mode_>`_
  `passive mode <Passive Mode_>`_
  `global attributes <Global Attributes_>`_

This patch adds explicit hyperlink labels for the affected sections,
ensuring all references are unique and correctly resolved.

After applying this patch, `make htmldocs` completes without
any warnings, and all hyperlinks in intel_pstate.html render properly.


Signed-off-by: Swaraj Gaikwad <swarajgaikwad1925@gmail.com>
---
 Documentation/admin-guide/pm/intel_pstate.rst | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/admin-guide/pm/intel_pstate.rst b/Documentation/admin-guide/pm/intel_pstate.rst
index 26e702c7016e..9cdd9dad6516 100644
--- a/Documentation/admin-guide/pm/intel_pstate.rst
+++ b/Documentation/admin-guide/pm/intel_pstate.rst
@@ -62,6 +62,8 @@ a certain performance scaling algorithm.  Which of them will be in effect
 depends on what kernel command line options are used and on the capabilities of
 the processor.

+.. _Active Mode:
+
 Active Mode
 -----------

@@ -94,6 +96,8 @@ Which of the P-state selection algorithms is used by default depends on the
 Namely, if that option is set, the ``performance`` algorithm will be used by
 default, and the other one will be used by default if it is not set.

+.. _Active Mode With HWP:
+
 Active Mode With HWP
 ~~~~~~~~~~~~~~~~~~~~

@@ -192,6 +196,8 @@ This is the default P-state selection algorithm if the
 :c:macro:`CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE` kernel configuration option
 is not set.

+.. _Passive Mode:
+
 Passive Mode
 ------------

@@ -432,6 +438,8 @@ the ``energy_model`` directory in ``debugfs`` (typlically mounted on
 User Space Interface in ``sysfs``
 =================================

+.. _Global Attributes:
+
 Global Attributes
 -----------------


base-commit: f30d294530d939fa4b77d61bc60f25c4284841fa
--
2.51.1


