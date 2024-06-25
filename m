Return-Path: <linux-pm+bounces-9970-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9FE89170AB
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2024 20:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CF431F223B4
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2024 18:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A118C17DE0C;
	Tue, 25 Jun 2024 18:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D/y94YhO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E854717D8A3;
	Tue, 25 Jun 2024 18:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719341642; cv=none; b=EnlDlu1c/zJqO4J3fRzJQDeRErcqCm2izFh0SZCyfEsDP61rSJT8EAGznXbzb/HMluHoAENAbsg4uAhjyqhGzjJy+fuTwJYfeqDsCjoKyJcMj5PITbHnhbRguf1TFeG9SY3MqYNiifprv49pHc2RuekZ9pdkv+rfILr/+zH/uv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719341642; c=relaxed/simple;
	bh=SSl7W/LMXfkGpEaojIweMuX3+g7tACrRINVNHy3t5Hg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MUfXhIhrQlYgboEdxKL12fMaijoqBjnvPksumJbI1isxNTEijCV90RzgERrPGHJQe+mCxClsz3dTpqq0wQC+TT7YiHMgJNPhMo59+ImrCsVtzjEWpWE1dwOsOAJXM5gyJ3toX2UNheKnJKK3/41n1L1g+/LrIGM3EAgWDQffGIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D/y94YhO; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-57cc1c00ba6so7453820a12.1;
        Tue, 25 Jun 2024 11:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719341639; x=1719946439; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c6krUym7LbJOKrZm5m5rQIK5d5Boqq/EmHx9VevqWD0=;
        b=D/y94YhOLvTdnWdic7Zv01zTQLOGtRFwlb5A0A/EfrrKt+dEvOhLQOnBpEWMP0EK2M
         32Blzv9DGzCbbFjmV/LO6C4FZPY0L4jkn3An6Qfcw49M5PohZTCs34cRL0CKPNI975HV
         4Qf5heDG1cjjRgd9vMuEtrAF4SeUxoK364xbmUCoxNn9XDheInSpwyZFAEKBnT2atUEu
         pBCPuP+68hVo0NniLjrCTIi62VQEM++YrTCL7LLjrQYFdUM5GJoGH9PlXU3r6WI1ch6H
         QlJzRn6ttdjyieXWrcdozOe+fQa3FF5hI3SLsPArxirkfJNuTexOnkuxFU0HnRvp4+gr
         THpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719341639; x=1719946439;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c6krUym7LbJOKrZm5m5rQIK5d5Boqq/EmHx9VevqWD0=;
        b=ID/fK+JZ2/xjwlIv9Fargg/DB+sBxBFRq4hTGQ5B0rl5cYq7Dh+lnrKHzGCMs6UuDu
         UAQ3jdV+aS8r2XS5Mev4mHEP0hFMl+/BmdtAbo6Iff9ZWBJjcDMAzkyMrcXU5tE7BF3e
         fW83QbJb7BoNO1InvMUjNE1Lch2yJaJkyGv4t572UxKjAXsdx7Jg7gXyHhMVQiYnkUHJ
         G3n4RFDMtIQ83dMK4eCxuwP+JKRVOTUcr2+MUqU4GoOMpPibPo1mZ0tJcbhkQyxiWfgU
         1vTFbZeIRZNJWY4v91zCrGrFttE6LXPbPPCj0PPHJ9sBxXkhrlsduC8plLypNJ5JbtXv
         Q3Xg==
X-Forwarded-Encrypted: i=1; AJvYcCUUUAClQQVTC1XlSDgbILSG+cVd1WzizPKLrWexVbnculc3v2tptmzHD/IZx9dfMC3xm/e4LG8Y2RL9Zs7lwXG82rltOid0vSZp3ebv
X-Gm-Message-State: AOJu0Ywvs+mssGuv2lZqa7IDnviWqnNCtCE/ZmKR8CLceGpDBjWV+oDk
	3A7bgxYj0hdVRv439UvMMPvQGfxdVPWbSOMqKIrSaZ6ApPuJPQWF
X-Google-Smtp-Source: AGHT+IHqeplcY6EPdujD/snXaz4irRERquhgDR9fzmGAacBIIClLxtCqKM0+MpG0XwXwOdnP3iePSQ==
X-Received: by 2002:a50:ab1d:0:b0:57d:4d12:61bd with SMTP id 4fb4d7f45d1cf-57d4d1264b8mr5283317a12.37.1719341639074;
        Tue, 25 Jun 2024 11:53:59 -0700 (PDT)
Received: from [127.0.1.1] (31-179-0-202.dynamic.chello.pl. [31.179.0.202])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d30562ef3sm6201650a12.91.2024.06.25.11.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 11:53:58 -0700 (PDT)
From: Roman Storozhenko <romeusmeister@gmail.com>
Date: Tue, 25 Jun 2024 20:53:56 +0200
Subject: [PATCH 2/2] cpupower: Add 'uninstall' target for 'debug/x86_64'
 subproject
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240625-add_uninstall-v1-2-ab031bbd98e6@gmail.com>
References: <20240625-add_uninstall-v1-0-ab031bbd98e6@gmail.com>
In-Reply-To: <20240625-add_uninstall-v1-0-ab031bbd98e6@gmail.com>
To: Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-pm@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
 linux-kernel@vger.kernel.org, Roman Storozhenko <romeusmeister@gmail.com>
X-Mailer: b4 0.14.0

Add 'uninstall' target for the 'debug/x86_64' subproject.
The target removes binaries previously installed to the
'${DESTDIR}${bindir}' dir.

Signed-off-by: Roman Storozhenko <romeusmeister@gmail.com>
---
 tools/power/cpupower/debug/x86_64/Makefile | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/power/cpupower/debug/x86_64/Makefile b/tools/power/cpupower/debug/x86_64/Makefile
index b1b6c43644e7..37fd414835b8 100644
--- a/tools/power/cpupower/debug/x86_64/Makefile
+++ b/tools/power/cpupower/debug/x86_64/Makefile
@@ -28,4 +28,8 @@ install:
 	$(INSTALL) $(OUTPUT)centrino-decode $(DESTDIR)${bindir}
 	$(INSTALL) $(OUTPUT)powernow-k8-decode $(DESTDIR)${bindir}
 
-.PHONY: all default clean install
+uninstall:
+	- rm -f $(DESTDIR)${bindir}/centrino-decode
+	- rm -f $(DESTDIR)${bindir}/powernow-k8-decode
+
+.PHONY: all default clean install uninstall

-- 
2.34.1


