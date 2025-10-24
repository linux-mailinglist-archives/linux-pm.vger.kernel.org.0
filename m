Return-Path: <linux-pm+bounces-36797-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA6AC078A2
	for <lists+linux-pm@lfdr.de>; Fri, 24 Oct 2025 19:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7E2C14F623F
	for <lists+linux-pm@lfdr.de>; Fri, 24 Oct 2025 17:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7CCD34405F;
	Fri, 24 Oct 2025 17:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d5wVANKv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1B333DED3
	for <linux-pm@vger.kernel.org>; Fri, 24 Oct 2025 17:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761326985; cv=none; b=op7j2SISi5KTjvLI911mbRNP2dSY8rD1xdcroribwOQfsZkkUZ2aKTuYyGhdX6xmm09o3RWfpG4BiNwMv4zamCMNs39l59MJbTtR6FQD4v35DJQNSp2NOdkuG5Baepl7ol5ywqxachZ43XwHdG5Up+MhFiybrYsff0FvSm5n3q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761326985; c=relaxed/simple;
	bh=UZ2BE5GPybLE7CmLT7dIgGDbZyKLOU9ISpTX4FoMbcA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ernsF6fJMyqTkunwtuYvqywy3Yt5dfvavKoGD9zJT22LBUqrB6fuySMguH1q/g2ezguXGNf1MGGrzt5Gj6KS7s3C8UwaaLnk5wPoybJr3fRJQKDzXWU5l/dnjuBrSCQ4NgjRa+2V8+H85BPuGGpro/8+HUesAPFAK1xo2llXEAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d5wVANKv; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-28a5b8b12a1so24221985ad.0
        for <linux-pm@vger.kernel.org>; Fri, 24 Oct 2025 10:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761326984; x=1761931784; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a2E6IemruVg75xkrWi4SiWqjFMrX39+ybWZzL7YhtdU=;
        b=d5wVANKvbeOk9Va36U4mi+S/z+7eP1GrR92RhjxVXgPwlXt6+oHQhQDv89upqNGkgN
         OVgYBQbZ6q506UrsrYG6XmqMDoyl05y8MAW0ZM1/u7ZZ7ZSPuDsUnfR4wjyINKa/FoiV
         EuFglLtvo8N80EvziDoLA1MYPgZCorLOWPBdZVqru2DgnW5M5P0W8OuWBPXL4sRn3ZcW
         5+om1IFNuW/CG5dGQpBWkgKg8RYxpt/zG8ql27YHWP2pgnAWt3ZBgjaMDT/3zL4qZ4I9
         rxDcda5UkkHzOwgeXCHwyUlXTAfKoQ+6CtTxOowdPyyNoBesBoaXNpmtkYzDa3t0YhOT
         My4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761326984; x=1761931784;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a2E6IemruVg75xkrWi4SiWqjFMrX39+ybWZzL7YhtdU=;
        b=j5O/nghc1R4fG/HLcpspU4swwN0K5IDg1AJXrScNPE2eZklshYnho9NB60QqyIcMJ/
         ZP2SQqP4fw82Hnj/xn0W5Mt5xEWOogmAZH9iDmPsY1gZDAUj7XGSVa044o05E7kDXP7q
         qn0lZL5ngYcPhmuir8QAhq4SsTP86XGXwMH5tz/qqIOsdlR8VuU4z2C0ATHaaExw4CE/
         hh3XzbeZL9MfUjJ8Q//osHGbcyzq5qWhqxvu0coqEitHYoP+SulAdfhOPN/sLn++FXVo
         uy6Nux7fYRrnI5OqNQSesKzNut/pphka3etDKLO/LnNDUV6KHhKXbfQ2zWs52OwFJAz2
         jcuA==
X-Forwarded-Encrypted: i=1; AJvYcCWhvueN5FqveD1UgxSmzToHnU4IsUHp8w+FwdnNs0bGAPEDOiS5qq3WiSRx9LsKB0ypY45B5k+F2A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0pDecPuFW//BSJVQ4mgWbL6jnmLS9CBhun779+mYtNW2pmOL0
	hQC6Xux8nxqGpEbH2HJ9+r8Wgf4jc4M1XgZnscxh/buLJd132smjZIA9
X-Gm-Gg: ASbGncs/T8EQxuTPP+qgmidbVCjLxfVYFTBY2R/6PiGvNo9UuKgxRRM2CccDlJJ4YOR
	jagQm9aPdsxHUT3KuY2bLn7CboGPxfQrW/drRAYHgUUs2zCpix9aYu+7wf7/wqwDG1WMimmZ7Bb
	urxW1cCimSc/DGGPH1ChmD6+Omts1cFrxD+jmDM9XyUdtfEMD+KfsvZb63jTM/4km5zquVQ6ZY2
	k3x/aamYaAtDHLrs/eCxtdiBKmLikHRmE+e9/EP2wChC/SAWi0DUZ8hFwcZaomZFtaSawQckgub
	trnIG5Yl70rN1SE6xZZXaj1x1gD0Lad9SpG3Xh3nPWEH/Z7U3P1TsoEKR3HMw3Oqxriy01tmHOt
	CV0sw27olmB7bQzySG95uy6dqjt43s7tHaRDyCgIZLFWx32LoRvJLPSAEQQ2UGqdFqv53G0k11A
	Hjlr9uo+SfPA==
X-Google-Smtp-Source: AGHT+IFDckuW4U3/23hRsjFB0HpKtIlUoNugINuYueWTdcIWu6YG/tXUlw0Eque8u+bVzB/zHd6Frw==
X-Received: by 2002:a17:903:244b:b0:290:9a31:26da with SMTP id d9443c01a7336-290c9d31109mr366942675ad.16.1761326983580;
        Fri, 24 Oct 2025 10:29:43 -0700 (PDT)
Received: from aheev.home ([2401:4900:88f6:d7b0:8f5e:ff90:677:7d74])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946dda85e7sm61719615ad.11.2025.10.24.10.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 10:29:43 -0700 (PDT)
From: Ally Heev <allyheev@gmail.com>
Date: Fri, 24 Oct 2025 22:59:15 +0530
Subject: [PATCH v2 1/2] checkpatch: add uninitialized pointer with __free
 attribute check
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-aheev-checkpatch-uninitialized-free-v2-1-16c0900e8130@gmail.com>
References: <20251024-aheev-checkpatch-uninitialized-free-v2-0-16c0900e8130@gmail.com>
In-Reply-To: <20251024-aheev-checkpatch-uninitialized-free-v2-0-16c0900e8130@gmail.com>
To: Dwaipayan Ray <dwaipayanray1@gmail.com>, 
 Lukas Bulwahn <lukas.bulwahn@gmail.com>, Joe Perches <joe@perches.com>, 
 Jonathan Corbet <corbet@lwn.net>, Andy Whitcroft <apw@canonical.com>
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>, 
 David Hunter <david.hunter.linux@gmail.com>, 
 Shuah Khan <skhan@linuxfoundation.org>, Viresh Kumar <vireshk@kernel.org>, 
 Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
 linux-pm <linux-pm@vger.kernel.org>, dan.j.williams@intel.com, 
 Ally Heev <allyheev@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2471; i=allyheev@gmail.com;
 h=from:subject:message-id; bh=UZ2BE5GPybLE7CmLT7dIgGDbZyKLOU9ISpTX4FoMbcA=;
 b=owGbwMvMwCU2zXbRFfvr1TKMp9WSGDJ+b6/Z//XcY448pxeb7gaJ6YeWXdy1T9L89Lvdhv++f
 xdrU3/U11HKwiDGxSArpsjCKCrlp7dJakLc4aRvMHNYmUCGMHBxCsBEoj4z/K/z/XZvSmxsi9RN
 nymf96asu+Dsf7nugcdxGbtfGgWMDVaMDJP/HWi4da9gv5pijnz9n5XSwt5PDmnsdTn6JGm+cH6
 ELzcA
X-Developer-Key: i=allyheev@gmail.com; a=openpgp;
 fpr=01151A4E2EB21A905EC362F6963DA2D43FD77B1C

uninitialized pointers with __free attribute can cause undefined
behaviour as the memory allocated to the pointer is freed
automatically when the pointer goes out of scope.
add check in checkpatch to detect such issues

Suggested-by: Dan Carpenter <dan.carpenter@linaro.org>
Link: https://lore.kernel.org/all/8a4c0b43-cf63-400d-b33d-d9c447b7e0b9@suswa.mountain/
Acked-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Ally Heev <allyheev@gmail.com>
---
 Documentation/dev-tools/checkpatch.rst | 5 +++++
 scripts/checkpatch.pl                  | 7 +++++++
 2 files changed, 12 insertions(+)

diff --git a/Documentation/dev-tools/checkpatch.rst b/Documentation/dev-tools/checkpatch.rst
index d5c47e560324fb2399a5b1bc99c891ed1de10535..1a304bf38bcd27e50bbb7cd4383b07ac54d20b0a 100644
--- a/Documentation/dev-tools/checkpatch.rst
+++ b/Documentation/dev-tools/checkpatch.rst
@@ -1009,6 +1009,11 @@ Functions and Variables
 
       return bar;
 
+  **UNINITIALIZED_PTR_WITH_FREE**
+    Pointers with __free attribute should be initialized. Not doing so
+    may lead to undefined behavior as the memory allocated (garbage,
+    in case not initialized) to the pointer is freed automatically
+    when the pointer goes out of scope.
 
 Permissions
 -----------
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 92669904eecc7a8d2afd3f2625528e02b6d17cd6..1009a4a065e910143dabeee6640b3b3a4bd3fe06 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -509,6 +509,7 @@ our $InitAttributeData = qr{$InitAttributePrefix(?:initdata\b)};
 our $InitAttributeConst = qr{$InitAttributePrefix(?:initconst\b)};
 our $InitAttributeInit = qr{$InitAttributePrefix(?:init\b)};
 our $InitAttribute = qr{$InitAttributeData|$InitAttributeConst|$InitAttributeInit};
+our $FreeAttribute = qr{__free\s*\(\s*$Ident\s*\)};
 
 # Notes to $Attribute:
 # We need \b after 'init' otherwise 'initconst' will cause a false positive in a check
@@ -7721,6 +7722,12 @@ sub process {
 				ERROR("MISSING_SENTINEL", "missing sentinel in ID array\n" . "$here\n$stat\n");
 			}
 		}
+
+# check for uninitialized pointers with __free attribute
+		while ($line =~ /\*\s*($Ident)\s+$FreeAttribute\s*[,;]/g) {
+			ERROR("UNINITIALIZED_PTR_WITH_FREE",
+			      "pointer '$1' with __free attribute should be initialized\n" . $herecurr);
+		}
 	}
 
 	# If we have no input at all, then there is nothing to report on

-- 
2.47.3


