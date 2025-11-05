Return-Path: <linux-pm+bounces-37476-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A16D1C373E3
	for <lists+linux-pm@lfdr.de>; Wed, 05 Nov 2025 19:05:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24FDD188912B
	for <lists+linux-pm@lfdr.de>; Wed,  5 Nov 2025 18:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9FBC2FDC42;
	Wed,  5 Nov 2025 18:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jYrDwk9y"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5941F4615
	for <linux-pm@vger.kernel.org>; Wed,  5 Nov 2025 18:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762365912; cv=none; b=oT1Pk1QAdIE0TEdUmcCqCqXl3dQGZJ5IFbRwESaBkOUacPIq5RqWql2Gk1UnbNp9o8Jow/GJ8Mz5SUoJuPeFNMyGAR4etjgoPsaoXKCj+Arzo4iHDpf8RJ2QIR5UcwiQbuOZd35QoWydVyQ6O2gt/6f+iQnTWY6P4QKPy1LfkOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762365912; c=relaxed/simple;
	bh=SLlEzq/aHHznoF5NtEnXd89nH9yrisCZS8IvSbSkoX8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RFJjZP2RZgugX8Y7DNl1+Ko7AR+GQSmrVi0JGhsGcveW6HWTfMccHq/UXP5EW2+UdKs6sglAoOmm7HanE8uKx4JIO9zS18Ef2Lq7vlQj6s9jucLxZdH77sctGcx0nF0Kl48IH4b8/M4lQemnwzPdZ/Mq6r3Tit/xtNtUSXsKqo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jYrDwk9y; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3ece1102998so71727f8f.2
        for <linux-pm@vger.kernel.org>; Wed, 05 Nov 2025 10:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762365909; x=1762970709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g7Y3LSh825KmwZimhlKVYdvvUH4zjD7r/BAWVMm2aBY=;
        b=jYrDwk9yVFe3NBna2p33Id/9h/dRXLKnWISCG1fEYJEc72JueVZYQ1yAPvEuXLfXpx
         jQaGVJVgmlIkOnR8ugpN6ZccoDgi2JV1HpZp/TBcqCHNlMMFyyB+e7V4BF4WyPTLd2HR
         NbB4zEJGVicuxiUhv43Gy+/kpyi5ha75ugQ+OGU3tSo9lOesfupO8OMFWOVqFy1VHn6A
         IRHiR+SKhUKjpmzdX5Q8nkFj2nAL9Fy6eQXoHJnlQmFYzDQLtbCAD4i9dGKGYlg8rzWD
         mOlkg0EA1cYfxpRehTP/8H1adN6KggqHdN/aaagk0eGURoA7a0oPKjJh+fjaWPigJIjj
         4Ghg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762365909; x=1762970709;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g7Y3LSh825KmwZimhlKVYdvvUH4zjD7r/BAWVMm2aBY=;
        b=qnJ34kJl/OixwYr/NyOx1OyLnQM7Yn4d5rQHf83SfaRm1lLphmiAGIW/+tpEmrVlpD
         LdjVZ67qmyByxD4TWQt4twzeoqsHfu00V1Q077XMKj6zEZjm6jcCDxgOqgKXhH+JPcyO
         U9F7+r0O8VsRsRtN68FZQrVbv5oolSHozRgMB8A4TNGrJCcc0SzTFToS6orGkJlVPcy7
         5bHMpKqtKbG4V5UTfEF0tAdFPEgDPg70jkPGXoZNFRdM3PClhDW0YeoLCwjLb/SupJkQ
         2ciuz24Hzd6wg/tL/hlGOk24aI57SNJ7+m/n225w6uTPpCIEkhBJOMbWfOm4yYEb6s88
         98qQ==
X-Gm-Message-State: AOJu0YzDgXy8E4vO+Ly30hqVIOZo8/Q9eJoy5bVMfMIx029MdythDeXH
	f3WnUhIYbAwg1y4irwKMZ9zKRuqeJBoMqqZ68o80hZSGiHNu/Lk3AHTxdci9BA==
X-Gm-Gg: ASbGncuP3ORda7X5e+vamkj0SKS+1oZS3rxpA/KLVatHIB0UqQQufE+bRMQ4LLdNYhi
	01OIXAoQZupuNj4NL2rh43IRpr8/NKJtwrilaaXGn8ap8dtAPS0LCuiroVlHdR1so3Xpr1nw2o0
	JoNWPunlyAPQZaYZxrsd/2iqebhj3GNnZHpPxLSc+YK24Esv2Fh1/zQgwx3kfjs9jGBMkaunJzz
	vuMXvPzV3bgwzv5+Qmt3sV0QHkr6s5e/dixS8LNTmh7GULRSjJWeA5lQpcbkMT2p7TmSXvmxpXG
	pkVW17e4EyeG0OFfvij17He8CT0ocECCXRF5nkXIUPMKCBklYcZRahl3M9rooc9IZv1cKEY8T0L
	Z2+ZlZwBeUWpBGYciXZ0jhMwB4pM3xsCMXWn4P2lpRhF6wdH9VxNZjdQInii6Qo1Txl/yvfTT
X-Google-Smtp-Source: AGHT+IFvjz6KaeHi9KvXSNZLQFBICoxSxvjX7MeOrDe5/OMGDLBMUyAaLnCNl7AQt8k5pY3UrxxYqg==
X-Received: by 2002:a05:6000:210c:b0:429:d6fa:da05 with SMTP id ffacd0b85a97d-429e3306238mr2949216f8f.38.1762365908996;
        Wed, 05 Nov 2025 10:05:08 -0800 (PST)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-429eb4037c7sm87922f8f.3.2025.11.05.10.05.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 10:05:08 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	superm1@kernel.org
Subject: hibernate bug: "Image size after compression: -1210935 kbytes"
Date: Wed,  5 Nov 2025 21:05:03 +0300
Message-ID: <20251105180506.137448-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I found hibernation bug: kernel sometimes reports negative size of
hibernation image.

Steps to reproduce:
- Your memory size should be 10000 MiB
- Your swap size should be 3000 MiB
- Mount ramfs
- Create 4000 MiB file with random (uncompressable) data in that ramfs
- Try to hibernate
- Of course, hibernation will fail, because you cannot fit 4000 MiB random file to
3000 MiB swap
- But you will see very strange message in kernel logs
"Image size after compression: -1210935 kbytes" (or similar)

Here is script for reproduction this bug in Qemu:
https://zerobin.net/?7d87d78855b41e07#yvP+T2c/v9A1AJr2d1tjWCbA6KUZZscDeESvbHqfqOo=

Here is resulting output (dmesg):
https://zerobin.net/?76c5a5e312ff7e6d#fH6jAkatrtRvtOWvFdo5EldWWP86wVxJrzzOCzvCQZc=

Reproducibility in Qemu: always (assuming you use script above).

The bug reproduces (in Qemu) on current master (284922f4c563).

I see two bugs in this output. First, negative size of hibernation image.
Second, "dmesg" doesn't contain any hibernation error. I. e. "dmesg" looks like
hibernation succeed, but it did not.

The bug is reproducible both in Qemu and on real hardware.
(Note: I reproduced it on real hardware with v6.12.48 kernel.)

This looks like integer overflow. I suggest double-checking that all
size calculations are 64-bit (on 64-bit systems) in hibernation code.

-- 
Askar Safin

