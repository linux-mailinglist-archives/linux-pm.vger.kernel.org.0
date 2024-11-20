Return-Path: <linux-pm+bounces-17797-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F16DB9D31CE
	for <lists+linux-pm@lfdr.de>; Wed, 20 Nov 2024 02:16:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D7EA1F2157A
	for <lists+linux-pm@lfdr.de>; Wed, 20 Nov 2024 01:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0BC11B95B;
	Wed, 20 Nov 2024 01:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hjPvmXU8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228641EA80;
	Wed, 20 Nov 2024 01:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732065260; cv=none; b=BAARl78JllJkXnl0Z5chV6pRSdQnWxh+gktNvPRE8RIdbZtBmfGPlSYB3Nw39F2vFdlyWtqDD3M5DCfiOfd1WRfGvSEIrZpH84cg8iYWBauUCJ9Ie+NPVnL8rjjZpatRJsjIKymqT9BSByeiEXnjHA9L7ZM1ZX3JVSvKG5WqcmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732065260; c=relaxed/simple;
	bh=CchtCVTtZWpemdzarjCDqaFEHemolUA6d641/1V7IpI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=mOarweABp1VqIK8x0ltx1cDqJrtoOCM2dUaqnTyup+rOP3iWVaAWWVPn5N0ELBAbb3twdiPEBq/kF9QikBZfrU/UwTfTSh2qt+j7oCuye5L4+JdjoWjJxkV1CLcUAVwYvIcOj6wBybQaD0R4YIGQYN/ldMAYPBdpFiZNh0kpUmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hjPvmXU8; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4316cce103dso52133595e9.3;
        Tue, 19 Nov 2024 17:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732065255; x=1732670055; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8u1cHBLy2nRoBqLa17zAhfXpRTEukBBEVletJcfclTU=;
        b=hjPvmXU8vkAddCIFPMXxoaqlopSD/1yYCMw/X5a3wi8zKIxMYQ+oh2Y2L/aUDrPUqU
         4bdDxxt2sFaTaB0PaRlWs1nT6Xas8fxjQUMTeeJMOFEOqKdxZeQgSBYt5HD9dgacRjy3
         b0WU3D63m9q+Tz7u4oIXmHETfZ6LRsHswdliRaSA1GkPszm8Y1wPBN8iBxB8cLhsv0Qj
         MOA+PqlUzixaybh5WhSbdpAZevQ4ch27l64jh453BSBOQgF9oUTK/meuyxNwrMUvDnL2
         J3+III4iHWWHq1XbaMB9PcfDEssN8cE8gMXwWRSnV76t03Ww5C4jIGNpXY0J03gpPN3z
         2xgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732065255; x=1732670055;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8u1cHBLy2nRoBqLa17zAhfXpRTEukBBEVletJcfclTU=;
        b=HW8d1emwTkF+Y9lFueXp4m1qiD7k8A0MaB1GVViOOFU0LPNkD6rKptF7vtUY6L5drL
         lXJhyU91ZUuAgBPEpVOLkN3KrAHWb0oBchJc6ajb9riW0n3tLQGec+Qdv0ZcD0ZaNuDx
         X1LTL088IBxkESYmktTx1XPRu/4HkxYVcJgvRnoVBMiTFvcqxa32DiqYupn0Xu77faKM
         xnfV6goVayS9iXRja3a8jYMXQScuiOFQgg/VJCJxUWK+M7RpdUwC2i+H+jdlbHPPW1Be
         bqeTE8VVRgI8yv+0vKBJ6bN7xv3Wxe15Z7CaiuTlaBVpO9mlxV4xM6DCwyvlxtfWOP92
         O1YA==
X-Forwarded-Encrypted: i=1; AJvYcCUsmToeRMssFD9pXXKwuBqEG39QHdtKf2xS8PLK2u+2QP9XOjiZgkcrB+x3UxRYPv8iHtYM3SSgQpXxPcwR@vger.kernel.org, AJvYcCVL2USoCJB+Ocz7XOTAfhNn1pp8s+IKAmr9bqZ3CjQdenvMf3ME3bOI4v3OSIGoNC9+ZLC6mHoQX4E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPNabP+M/HiZU7GfVRr0xXXow5OOuoi4JcG0Thq1BMtnYj0YF9
	tGLCWR0FJ++f7xPB32nUqGTZ9xbJfT2PO1sJcMfCrVMVoZ1f8EtCwUzTDg==
X-Google-Smtp-Source: AGHT+IH4ny5/INzEb8VSmq8l9JHiitIjkkGzy5s6QWu6pRai0HDdvQfIF8/Hw9wd/w/pIQ4TJCqDBA==
X-Received: by 2002:a05:600c:502a:b0:42c:b508:750e with SMTP id 5b1f17b1804b1-433489a06ebmr8494935e9.11.1732065254996;
        Tue, 19 Nov 2024 17:14:14 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-48fc-0cdb-fd19-6ed4.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:48fc:cdb:fd19:6ed4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-382549107e8sm682379f8f.52.2024.11.19.17.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 17:14:13 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Wed, 20 Nov 2024 02:14:07 +0100
Subject: [PATCH] Documentation: pwrseq: Fix trivial misspellings
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241120-pwrseq-doc-trivial-fixes-v1-1-19a70f4dd156@gmail.com>
X-B4-Tracking: v=1; b=H4sIAN43PWcC/x3LSwqDQBBF0a1IjS2wmzZ+tiIZiP2iBeKnKqgg7
 j1NhofLvcmgAqM2u0lxiMm6JLg8o2HqlxEsMZl84YNzvuDtVMPOcR34q3JIP/NHLhgDdRXCqyl
 j6Sntm+If0t29n+cHIWQ5aGoAAAA=
To: Bartosz Golaszewski <brgl@bgdev.pl>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-pm@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732065252; l=2567;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=CchtCVTtZWpemdzarjCDqaFEHemolUA6d641/1V7IpI=;
 b=zt07yqt6g453uiYnMWSEvyPdCPqtfs4yK+IP2RhAwSI0tJnFRbVfTiVM+cpSh+Sp0Yee0WXwb
 CkWiNVn1KtCDVatxY6hnJrmOwgoy6d5DgrYvjQw1V5cfyELlUYHv43U
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Use proper spelling for 'discrete'. When at it, capitalize 'Linux',
which is common practice in the documentation.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 Documentation/driver-api/pwrseq.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/driver-api/pwrseq.rst b/Documentation/driver-api/pwrseq.rst
index a644084ded17..ad18b2326b68 100644
--- a/Documentation/driver-api/pwrseq.rst
+++ b/Documentation/driver-api/pwrseq.rst
@@ -11,7 +11,7 @@ Introduction
 ============
 
 This framework is designed to abstract complex power-up sequences that are
-shared between multiple logical devices in the linux kernel.
+shared between multiple logical devices in the Linux kernel.
 
 The intention is to allow consumers to obtain a power sequencing handle
 exposed by the power sequence provider and delegate the actual requesting and
@@ -25,7 +25,7 @@ The power sequencing API uses a number of terms specific to the subsystem:
 
 Unit
 
-    A unit is a discreet chunk of a power sequence. For instance one unit may
+    A unit is a discrete chunk of a power sequence. For instance one unit may
     enable a set of regulators, another may enable a specific GPIO. Units can
     define dependencies in the form of other units that must be enabled before
     it itself can be.
@@ -62,7 +62,7 @@ Provider interface
 The provider API is admittedly not nearly as straightforward as the one for
 consumers but it makes up for it in flexibility.
 
-Each provider can logically split the power-up sequence into descrete chunks
+Each provider can logically split the power-up sequence into discrete chunks
 (units) and define their dependencies. They can then expose named targets that
 consumers may use as the final point in the sequence that they wish to reach.
 
@@ -72,7 +72,7 @@ register with the pwrseq subsystem by calling pwrseq_device_register().
 Dynamic consumer matching
 -------------------------
 
-The main difference between pwrseq and other linux kernel providers is the
+The main difference between pwrseq and other Linux kernel providers is the
 mechanism for dynamic matching of consumers and providers. Every power sequence
 provider driver must implement the `match()` callback and pass it to the pwrseq
 core when registering with the subsystems.

---
base-commit: 414c97c966b69e4a6ea7b32970fa166b2f9b9ef0
change-id: 20241120-pwrseq-doc-trivial-fixes-ee8744695d52

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


