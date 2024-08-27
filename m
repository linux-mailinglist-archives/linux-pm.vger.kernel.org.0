Return-Path: <linux-pm+bounces-12927-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2E596018A
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2024 08:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85ADBB210F9
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2024 06:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0FD146D68;
	Tue, 27 Aug 2024 06:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ecpazkLb"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A74D13DB99
	for <linux-pm@vger.kernel.org>; Tue, 27 Aug 2024 06:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724739943; cv=none; b=EdRBKbW95G5N/H+d9eQGXfbDdJzTwQTxyO2fWRM49M+INvs4HpCU+eKOM3fG+g+LF2gO19u8zXRRczTHMXuNrqiaM74l082ku7vv0W3Kp37efG2y72zYN9hB6Xd2lOJx3Ox1VN0a6SG8YUg94jjC3YB2EuPTQlL0r6AEeR/yHOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724739943; c=relaxed/simple;
	bh=wLOZRoP2rCUX34UsELGnogltijstDh57sTW3CSCim8I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n3ffYE9hEtlFzwc/tGVQK81oVCnCNzscvg49jS8VyFZThDrXOFiOFsSxN/XKL7Vr1ZTP9weTsRPcO65Ae931Mmys25Tunt5nBEHdXrV5UM2Z727AmIidNuzgQnp6GJGNtNeAu+NqoZpKdUuyJCRZkOdQplNtDDKq6WOeR/f5qhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ecpazkLb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724739941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XeQMIYTnf+XexoNiwV2cnhT2tLUAhCdUh4JVRVTo888=;
	b=ecpazkLbVxpkU2dKWPpgX60GyxZeycyFnLsinXSDAlH76bsPS0Ay0o7q1uYklICC2GqojL
	VV5fyA4xT5y5C4Z4jCGj/rjvy/RqZPSmwSRIcW+MQiOsOSTh0bzd9WeZ51Ogb2K3V1ku1U
	MsBiYtWyvmNyxgWYNzHl3jriKmZdTDM=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-ZFPDJhXtNFmLFTqxooS8FA-1; Tue, 27 Aug 2024 02:25:37 -0400
X-MC-Unique: ZFPDJhXtNFmLFTqxooS8FA-1
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-843006de550so809426241.1
        for <linux-pm@vger.kernel.org>; Mon, 26 Aug 2024 23:25:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724739936; x=1725344736;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XeQMIYTnf+XexoNiwV2cnhT2tLUAhCdUh4JVRVTo888=;
        b=cAllxREFl3AJhCAQMe/zTuMCmpoFvD1XPSf4jvBVnXyVBuksobQvKl0ZTITjnqiGEG
         XmYZ1BIWN6VOitLsJNCRsIp+FOjVZh82pLZxxW0AkNE2gsqNgaDHbVjCJd6JrWXVXJwJ
         53PWG+MMg+e0LYWSFfh6G4MJa9C0UQxWZH3yxrODV2UxHc9xvMBUVfnhDZXxJlz4I0+a
         D1sWtTvoGvT9RvGMSKOUUP8R5Ecpk0blcQL96mpfxMNGfb8zU5E6HPWEGgOJNpimCION
         BUl/4a8G8GsVw4FDVyMKdDrUfIdvggPYWc7DaPPgagG8X4k+gjoGFdPc58LxR1EWfPIu
         nVHw==
X-Forwarded-Encrypted: i=1; AJvYcCWgLSC7ybPvRKC+49LIJWXg1yItEZ0T11TyGF+5kXZflJCPW7BubEqtvW2x8QIU/AJGVqTKa248MQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzGZhZbsSnoEMyBrCNy5iIKJ0nd4fMWMcPmdAyp3KJzH72FJSoU
	HS4ERcKDw+3AZX/rKq+dvRdjJdrEnUZbDlfHJQdCuMFdkFxTTC3hQ9nZYKPMu9XwsbLFL74LVho
	I9X8MJBoJ6gc2piB8i+PY9BN29w7iDuDHoztNZmER7Uu2owIFtOpml5Df
X-Received: by 2002:a05:6102:3a06:b0:492:9394:d1e with SMTP id ada2fe7eead31-498f4640371mr9096225137.14.1724739936655;
        Mon, 26 Aug 2024 23:25:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvhJviliNCP7B1YX1z0Y/cJT0ncQOEY0a3jmJLi7NjKouv2pIFbOuxOJci5vzkeIFAoYzsSQ==
X-Received: by 2002:a05:6102:3a06:b0:492:9394:d1e with SMTP id ada2fe7eead31-498f4640371mr9096205137.14.1724739936184;
        Mon, 26 Aug 2024 23:25:36 -0700 (PDT)
Received: from rhfedora.. ([71.217.43.75])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a67f1fe176sm521044185a.0.2024.08.26.23.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 23:25:35 -0700 (PDT)
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: "John B. Wyatt IV" <jwyatt@redhat.com>,
	linux-pm@vger.kernel.org,
	Thomas Renninger <trenn@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	John Kacur <jkacur@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	Arnaldo Melo <acme@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"John B. Wyatt IV" <sageofredondo@gmail.com>
Subject: [PATCH v2 0/4] Add SWIG Bindings to libcpupower
Date: Tue, 27 Aug 2024 02:24:32 -0400
Message-ID: <20240827062438.71809-1-jwyatt@redhat.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SWIG is a tool packaged in Fedora and other distros that can generate
bindings from C and C++ code for several languages including Python,
Perl, and Go. Providing bindings for scripting languages is a common feature
to make use of libraries more accessible to more users and programs. My team
specifically wants to expand the features of rteval. rteval is a Python program
used to measure real time performance. We wanted to test the effect of enabling
some levels of idle-stat to see how it affects latency, and didn't want to
reinvent the wheel. Since SWIG requires the .o files created by libcpupower at
compilation it makes sense to include this in the cpupower directory so that
others can make use of them.

The V2 of this patchset includes:
* the full definition of libcpupower headers that is needed for the bindings
* dummy implementation in C of a function listed in the header of libcpupower
(requested by Shuah Khan)
* test_raw_pylibcpupower.py demonstrates an example of using the bindings
* adding myself and John Kacur to the cpupower section of the maintainers file
(requested by Shuah Khan)
* addressed review comments about doc, makefile, and maintainers file
* small style and other fixes

The name raw_pylibcpupower is used because a wrapper `pylibcpupower` may be
needed to make the bindings more 'pythonic' in the future. The bindings folder
is used because Go or Perl bindings may be useful for other users in the
future.

Note that while SWIG itself is GPL v3+ licensed; the resulting output, the
bindings code, has the same license as the .o files used to generate the
bindings (GPL v2 only). Please see
https://swig.org/legal.html
and
https://lore.kernel.org/linux-pm/Zqv9BOjxLAgyNP5B@hatbackup/#t
for more details on the license.

Sincerely,
John Wyatt
Software Engineer, Core Kernel
Red Hat

John B. Wyatt IV (4):
  Add SWIG bindings files for libcpupower
  Implement dummy function for SWIG to accept the full library
    definitions
  Include test_raw_pylibcpupower.py
  MAINTAINERS: Add Maintainers for SWIG Python bindings

 MAINTAINERS                                   |   3 +
 .../power/cpupower/bindings/python/.gitignore |   8 +
 tools/power/cpupower/bindings/python/Makefile |  31 +++
 tools/power/cpupower/bindings/python/README   |  59 +++++
 .../bindings/python/raw_pylibcpupower.i       | 247 ++++++++++++++++++
 .../bindings/python/test_raw_pylibcpupower.py |  42 +++
 tools/power/cpupower/lib/powercap.c           |   8 +
 7 files changed, 398 insertions(+)
 create mode 100644 tools/power/cpupower/bindings/python/.gitignore
 create mode 100644 tools/power/cpupower/bindings/python/Makefile
 create mode 100644 tools/power/cpupower/bindings/python/README
 create mode 100644 tools/power/cpupower/bindings/python/raw_pylibcpupower.i
 create mode 100755 tools/power/cpupower/bindings/python/test_raw_pylibcpupower.py

-- 
2.46.0


