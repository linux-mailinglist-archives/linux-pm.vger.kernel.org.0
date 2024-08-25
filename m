Return-Path: <linux-pm+bounces-12855-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D5695E2E6
	for <lists+linux-pm@lfdr.de>; Sun, 25 Aug 2024 11:54:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E4F0281FE4
	for <lists+linux-pm@lfdr.de>; Sun, 25 Aug 2024 09:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5659874C1B;
	Sun, 25 Aug 2024 09:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J0fmVaC/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC756A59;
	Sun, 25 Aug 2024 09:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724579683; cv=none; b=Oxl4ZyofSaeIZwx+UygybcK6lMCEduPAAKfX3TRq2pEf9J/ICbTcGuxJDN4i3Weh4xn92qkhEzyMRsUR0v/qQsap15w7GZZB2Q/fNoKdKa/VMSgsAVoWT12JS9LTgKveMH2SC2hHT0qZVtGAhFhm6R165mm3gA+wbw5h/o98au0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724579683; c=relaxed/simple;
	bh=1mBkGNFlDFxDWfPDkvYSxSHFHU6QkD9OAkyQG8G6pzE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RzQdCm8X36PFOqVA8pCRN4rAGgOI+wwQ87qMsNMUR5tr8QHSCyfL7BHIiQpG/qynscmpl9RpkDLeu77+KpegwGOJz0TERDOqUXmGcNoO5kQuP8hPln3Cs4RpRmsjT6mJG5AHYcC76KV22UsFQCn8+aZ7Gk/N8nxqNyi8UcxuZ+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J0fmVaC/; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2d3da6d3f22so2578495a91.0;
        Sun, 25 Aug 2024 02:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724579681; x=1725184481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ki9s/U4Sut/kkvy/DZiEXTPLLw1z1KDsCl7bqzPU3h4=;
        b=J0fmVaC/PQkmek+IbE3UOtcKUr5O2FmYJA4aOP7+400Cge0IMyfclnlD2rTLKeM1bx
         tau3fOd75UmVfxy6ayaII4LfEIpGjvJqUzBka9n0ndAAxxMmIBogriRwzEHK111v8uDH
         vZlh6uJ3V1ifKns1QfsoZqASvu84prxM4nOan50E+39x/k/ig/iHUcuxPA+9x84MtNUq
         LsU3AWcW04CFJRPbdd4IE0GtjNhht6uWUfkfnsDnoLVFkUamvvbGh/P8FW4WkK1v0660
         ZKbAuoKMvRWUDqL21lzpV8oZnFt06cBI/mjZnRhvhaKnP0rh4TQWQH3Z7Gm/397OG2Vw
         cN4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724579681; x=1725184481;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ki9s/U4Sut/kkvy/DZiEXTPLLw1z1KDsCl7bqzPU3h4=;
        b=wB0KWtiADUvF9IHfUGO8oZWXU2yKNgbuFITWUIUmH4JZTuONoVxxoa2y1d52EZbc98
         loyyFqxSJvVzIm3L8T88eC+oBYcJliTdZweC6GhoUyr+d6xZ2/9Y99DO5ssdxVNbKDRi
         ENYlMFYFpC4n0RdVJiaD1VtgpYCRBY7PkZZVFAJPMi49UpE3o37h93p3c9oRg2gLEWXD
         kgiyrGDPzZXD/P3GVTqj5SvUhrQg2muUPKjl5joHaBP56RL8e6t0kCpcfS1COateEckf
         n95yUA+HhiRN4KeI42otM4EO+yMZzr8YYtZ2rkhV1bKQd8xftGOMm+URyJpCJ65KPyit
         5Tag==
X-Forwarded-Encrypted: i=1; AJvYcCVS/OL7YmINkEBA/DmnKJIPCMreNVCrqKUsrWEAN+x3fX/NN2XwiNy3BBcGTNNqEo1x3p4IkB3yuNw=@vger.kernel.org, AJvYcCX1AMC5UgVsG2b/s2kH+96SKo47muARpMys6C0m0gyiN6tY+gzM/s4CDPwFIKsP5D0cwqQL68Vv2UfirWY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz03nrCsBNARkuRaTcbFaaT6eI/qRPEB3Aty5uk47iBk9G7WgAw
	Gupu5mBOVJFKGKyCFXtomR8WOXdGgssH8G+zScA+fpNvhSq6Eej1
X-Google-Smtp-Source: AGHT+IGKDKyuEjDmKJ2HrlrT1n9OAVS1IkrqVYeL/JSUzQu9Op5OuYi5ifOBX9DZtCv3vpe88REJ7A==
X-Received: by 2002:a17:90a:39c2:b0:2d3:c088:9c54 with SMTP id 98e67ed59e1d1-2d646bcd8a3mr7648841a91.6.1724579681173;
        Sun, 25 Aug 2024 02:54:41 -0700 (PDT)
Received: from 0x7f800001.. (2001-b400-e2db-5f0d-8150-1fac-9fab-d218.emome-ip6.hinet.net. [2001:b400:e2db:5f0d:8150:1fac:9fab:d218])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2d613b1cb38sm7454970a91.50.2024.08.25.02.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2024 02:54:40 -0700 (PDT)
From: "Yo-Jung (Leo) Lin" <0xff07@gmail.com>
To: 
Cc: linux-kernel-mentees@lists.linuxfoundation.org,
	ricardo@marliere.net,
	skhan@linuxfoundation.org,
	0xff07@gmail.com,
	Todd E Brandt <todd.e.brandt@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH] pm-graph: ignore sleepgraph.py artifacts
Date: Sun, 25 Aug 2024 17:53:50 +0800
Message-Id: <20240825095353.7578-1-0xff07@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

By default, sleepgraph.py creates suspend-{date}-{time} directories
to store artifacts, or suspend-{date}-{time}-xN if the --multi option
is used. Ignore those directories by adding a .gitignore file.

Signed-off-by: Yo-Jung (Leo) Lin <0xff07@gmail.com>
---
 tools/power/pm-graph/.gitignore | 3 +++
 1 file changed, 3 insertions(+)
 create mode 100644 tools/power/pm-graph/.gitignore

diff --git a/tools/power/pm-graph/.gitignore b/tools/power/pm-graph/.gitignore
new file mode 100644
index 000000000000..37762a8a06d6
--- /dev/null
+++ b/tools/power/pm-graph/.gitignore
@@ -0,0 +1,3 @@
+# sleepgraph.py artifacts
+suspend-[0-9]*-[0-9]*
+suspend-[0-9]*-[0-9]*-x[0-9]*
-- 
2.34.1


