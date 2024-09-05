Return-Path: <linux-pm+bounces-13645-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0ED096CC8D
	for <lists+linux-pm@lfdr.de>; Thu,  5 Sep 2024 04:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 142E6B23D38
	for <lists+linux-pm@lfdr.de>; Thu,  5 Sep 2024 02:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1E713B2A2;
	Thu,  5 Sep 2024 02:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NBdo2u4Q"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4515113B293
	for <linux-pm@vger.kernel.org>; Thu,  5 Sep 2024 02:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725502783; cv=none; b=DHKEl3F/3SZ/XkFl9oJ7hMCsiDO4GwC5KsYW1a/x1/ZeyHl/ne1yl1sW7oi6KPktxleZkmaWUPUhf+Wpd8HY+nQoflGRGm1bNfcLMNZr7O9UifWqjQYYVWS5T76vb9PWAtvjsIDCEYljBvfRkIK6NGxJQuLYvpvXU5+wZ3Dj3z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725502783; c=relaxed/simple;
	bh=b+T73L+tj+3Z7fE8SEEquxnXMNFolcHTPEGwqPx1iEY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZPB9ZP88K0deDtB5ACBapUY+sTcGe52/YCgllBWBU+sp8UdKmhfm0LogPaUaqRDQcgIUGLdbqSUzDujbckdYAzhCzmH/2zVKKl2VWTJ+SSrm3g1An9iYFT/0XbfeJb2VmlLf4z+LgF8c9AMxy9+Rco/VP3Bv0svhqver4AtrODY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NBdo2u4Q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725502778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EUF/NBcLA8q8t9cAM4xsQXEfKKe9p1yR3ynq7HjYVB4=;
	b=NBdo2u4QG12oeBji2+1EvBW+WtAJrd1++pb4DclsFPcLcoogBeSUv+vhx6dmRl2YCUUN1I
	l43P+cBMjsHVdsMAvNx7+Pg2RkjOF9c0HrlzYfhIAv6VMACR6DQIZPG0OjzG6f27ZOBLAR
	/WDq6ol4m2usXpJtz/ZU32jsx+YDz4k=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-201-CG3X1HFjMFWgZSHiqvf0qQ-1; Wed, 04 Sep 2024 22:19:36 -0400
X-MC-Unique: CG3X1HFjMFWgZSHiqvf0qQ-1
Received: by mail-yb1-f199.google.com with SMTP id 3f1490d57ef6-e1cefe6afc4so603653276.2
        for <linux-pm@vger.kernel.org>; Wed, 04 Sep 2024 19:19:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725502775; x=1726107575;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EUF/NBcLA8q8t9cAM4xsQXEfKKe9p1yR3ynq7HjYVB4=;
        b=UUaJr/CPo+HNaJLrnEeqbKJy5Yt82CjaOdnY133Ff4Zhcs5lnCV2Hs9bKrfGUxYiIz
         10rBbOG2mSVo3cKJp/0NPTGeHaD8eWXPJ0U7+BI9EmJN4G2tcOYOMfH93+tJv8VX+Gaa
         bALxZYvCvBYVMzrUsQGR4Yod+75Oskh1AhPC8NFPm7RDazQ0+cfgtM8vIdI+c0Z0+yEu
         bZnO4TxFbGjiRpYEb4MPglQ+ggULRglvRV/aCXb0Gs/zVUPoQBWj4AmheVCjV6Qd7Hdr
         h7UDhMa5zssIyokkpVNoUkIlfr60MruA0AmAI5BRsFqScbege3tbP5AxS9qJEPhg3u/6
         rYHg==
X-Forwarded-Encrypted: i=1; AJvYcCXAzEn1EPEcmqjXExQfOMh1e6XiMWfNmyypGbilwIKpt/X3hJysVlxvofyVDxUxxwYwutnCNNQFxA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1HuyuG0UUmu8S9TjoMEn1sX5wdfCqn633LhklVGumkNOm/+Jz
	w0XL/GgXuDRwnVargcqA35ZPBs4IQFGN5KudHDUHxsjcs2H7xucrQ2gUhHbdaQS7mFsqWfCAM+h
	5a7k+xtUHf65sxDFLTFsuVjDKibP/DzS0cYJHe2UjpKSSSLdgv5gI8gtD
X-Received: by 2002:a05:6902:178c:b0:e13:d32f:b0b9 with SMTP id 3f1490d57ef6-e1a7a1c8502mr21137524276.47.1725502774944;
        Wed, 04 Sep 2024 19:19:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSZf/dVwMJ8dlS8WJRTQcc0mc/swRBAzIWDCysLiNBsT4XwBG0ZTuLADHdZ9+HD7IpmNM8Ow==
X-Received: by 2002:a05:6902:178c:b0:e13:d32f:b0b9 with SMTP id 3f1490d57ef6-e1a7a1c8502mr21137513276.47.1725502774594;
        Wed, 04 Sep 2024 19:19:34 -0700 (PDT)
Received: from rhfedora.redhat.com ([71.217.47.229])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45801db22b5sm3531181cf.72.2024.09.04.19.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 19:19:34 -0700 (PDT)
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: "John B. Wyatt IV" <jwyatt@redhat.com>,
	linux-pm@vger.kernel.org,
	Thomas Renninger <trenn@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	John Kacur <jkacur@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	Arnaldo Melo <acme@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"John B. Wyatt IV" <sageofredondo@gmail.com>
Subject: [PATCH v3 0/4] Add SWIG Bindings to libcpupower
Date: Wed,  4 Sep 2024 22:19:07 -0400
Message-ID: <20240905021916.15938-1-jwyatt@redhat.com>
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

The V3 of this patchset includes:
* renaming header messages as requested and adding people to Cc as
requested
* moving the stub (dummy) commit to the front of the patchset
* small punctuation fixes

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
  pm:cpupower: Add missing powercap_set_enabled() stub function
  pm:cpupower: Add SWIG bindings files for libcpupower
  pm:cpupower: Include test_raw_pylibcpupower.py
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


