Return-Path: <linux-pm+bounces-11375-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70FC793B90F
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jul 2024 00:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C2C128216C
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jul 2024 22:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6FA13C9B3;
	Wed, 24 Jul 2024 22:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UlY9qnid"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D75D13D255
	for <linux-pm@vger.kernel.org>; Wed, 24 Jul 2024 22:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721859232; cv=none; b=an2vDfyNNFT3UWK+aRzclAwaa7UhAXXFD8w1Qmkii5HPT2q6nONsyay9xK+NeAXgo8XmSEDo6rJMy4RNzyHw2rtKY5wZkElIGFbDgfns/apPys1JfyJfIe8/O+MwXERpT2W69G1odzOliDq8l6E3j8FdibxsWx3DeY68Y8vZYXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721859232; c=relaxed/simple;
	bh=vkAFNqSKVtspiIRHbQN+ZkiEShAr8Nf/frkNHKbW+e8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mZs1qjElVcO9Q2B2sYtMECoWs6me0f107gBZpRPzBF862l4cjseXuoML1SDfCA5QtFzDJAYbw8axsXPfqqahDlKA2iEwv1Dj6c4pWaBPs2DQ/bVLzWnCjWqQgB+sa/r91TaXnPeI4FYJBalw6ZOPhs/0seXA/P6Wl8RdQeffGuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UlY9qnid; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721859230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sw0iKaz8jS4fOk9hmPzbaMCL/H5mNOf+IQSC96CENPU=;
	b=UlY9qnidfJd13Nk59hvtTp7JBlHljAXRfgx7a6dKe/zZAoUrZuWvMM94p3LMXg7Xuork5n
	CYD4pHp90LpQgyS2PPduIilFLuQpSsQxKr+bHSxxjYODTd3C0kJIhYNoc23hvra+bzmyrL
	TMYzGQXmzoBjcp8ExRIqGqvXcy9M45I=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-KMz5TSB2MtqNBK0OP_Zhlg-1; Wed, 24 Jul 2024 18:13:45 -0400
X-MC-Unique: KMz5TSB2MtqNBK0OP_Zhlg-1
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-81f331938a1so68961241.0
        for <linux-pm@vger.kernel.org>; Wed, 24 Jul 2024 15:13:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721859224; x=1722464024;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sw0iKaz8jS4fOk9hmPzbaMCL/H5mNOf+IQSC96CENPU=;
        b=pHqlfxkFv8MKIKMLrBDDtWOhNtxviHvC/zbyO007JMaF7CDkgM3bzUQfEvDGmbmpm3
         Sz3aySE5k9HDX8DjiyXdze316iTeRGRuUN59peFKm1AdLCO6B2ETAe6r89l5gzNwP2gO
         i3dI/8IA/8JcBdLlA//xxrIb+Ni+DFAUkpFt2NHiLv7aFRwykY+i1rj7k1WpiffwHZMn
         kT2i04uzFin6hgWuhtyHn3DV9H8p0Pf62ucx/UpyLhXAy+Gqg5VGpYYGSzLcyr/fnPpP
         URY8QxiOZzdwWgnLIi8POBXyyHF9ouYFNXR2vKx3fbjYAsgt1h2+xQd5hPivbutcYuYU
         vqmw==
X-Gm-Message-State: AOJu0YxlAAhukhqTJbsViDx/VRmdKiv+85HIXSGFEc1B+wDaYc6VrYJo
	zmvplDenOBSyORdUU9Co9mIWdTaVJ1ELnB085LEOwpdxAd7g1aLJG63/CVs+qhTYXuzxjUl/WVE
	e/CzeNk4V6ZqnmFM5RQ6Wp7KaotP96u4ULSDWsM1ZRgCj/1vnL3leS2DDIrDAM34NvO37dM8a3Z
	6XHvWR0KFYc5z+bG+WAlmEXcOHULUwz4RjmU/G/dhZ
X-Received: by 2002:a05:6102:4a98:b0:493:c348:4d9f with SMTP id ada2fe7eead31-493d6500ae6mr1344853137.19.1721859224391;
        Wed, 24 Jul 2024 15:13:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsQ+cIsHRVZ68O/7a6DwUI1enp6pkDl9AmUC4S8XL9tjjdHqZ+lltGBlLy6WAluX50lBmZPQ==
X-Received: by 2002:a05:6102:4a98:b0:493:c348:4d9f with SMTP id ada2fe7eead31-493d6500ae6mr1344835137.19.1721859224052;
        Wed, 24 Jul 2024 15:13:44 -0700 (PDT)
Received: from hatbackup.redhat.com ([71.217.44.209])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1d7435227sm7542685a.82.2024.07.24.15.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 15:13:43 -0700 (PDT)
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: linux-pm@vger.kernel.org,
	"Thomas Renninger" <trenn@suse.com>,
	"Shuah Khan" <shuah@kernel.org>,
	"Shuah Khan" <skhan@linuxfoundation.org>
Cc: "John B. Wyatt IV" <jwyatt@redhat.com>,
	linux-kernel@vger.kernel.org,
	"John Kacur" <jkacur@redhat.com>,
	"Tomas Glozar" <tglozar@redhat.com>,
	"John B. Wyatt IV" <sageofredondo@gmail.com>
Subject: [PATCH 0/2][RFC] Add SWIG Bindings to libcpupower
Date: Wed, 24 Jul 2024 18:11:18 -0400
Message-ID: <20240724221122.54601-1-jwyatt@redhat.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SWIG is a tool packaged in Fedora and other distros that can generate
bindings from C and C++ code for several languages including Python,
Perl, and Go. We at Red Hat are interested in adding binding support to
libcpupower so Python tools like rteval or tuned can make easy use of it.

This RFC provides a limited subset of bindings as a demonstration. The second
commit provides a Python test script to verify the bindings. I wanted to get
feedback on this before implementing (and possibly testing) the entire library.

The name raw_pylibcpupower is used because this is a demonstration example that
only provides direct bindings for a few functions. A wrapper `pylibcpupower`
may be needed to make the bindings more 'pythonic'. The bindings folder is used
because Go bindings may be useful for Kubernetes or OpenShift in the future.

How should the bindings be built? The current example requires the makefile
in cpupower directory be run first to generate the .o files needed before
running the makefile in the python directory in a seperate step. Would the
maintainers prefer the two makefiles integrated?

Another question is do you want more test files like the .py example? Would
this be used as part of a greater test suite?

Note that while SWIG itself is GPL v3+ licensed; the resulting output, the
bindings code, is permissively licensed. Please see
https://swig.org/legal.html for more details.

John B. Wyatt IV (2):
  Add SWIG bindings files for libcpupower
  Include test_raw_pylibcpupower.py

 .../power/cpupower/bindings/python/.gitignore |  8 ++++
 tools/power/cpupower/bindings/python/Makefile | 31 +++++++++++++
 tools/power/cpupower/bindings/python/README   | 33 ++++++++++++++
 .../bindings/python/raw_pylibcpupower.i       | 45 +++++++++++++++++++
 .../bindings/python/test_raw_pylibcpupower.py | 42 +++++++++++++++++
 5 files changed, 159 insertions(+)
 create mode 100644 tools/power/cpupower/bindings/python/.gitignore
 create mode 100644 tools/power/cpupower/bindings/python/Makefile
 create mode 100644 tools/power/cpupower/bindings/python/README
 create mode 100644 tools/power/cpupower/bindings/python/raw_pylibcpupower.i
 create mode 100755 tools/power/cpupower/bindings/python/test_raw_pylibcpupower.py

-- 
2.45.2


