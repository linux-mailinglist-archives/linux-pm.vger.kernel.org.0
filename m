Return-Path: <linux-pm+bounces-9969-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 984429170A9
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2024 20:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40BFF1F22ACD
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2024 18:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2F217D8B2;
	Tue, 25 Jun 2024 18:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UEvtx91K"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2381D17D88F;
	Tue, 25 Jun 2024 18:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719341641; cv=none; b=JgUfubfiIVL5+YDCOf4GZDkFdex2ydc/4ksRN3l4hbn4gU7qVGf0PnQtsQmi6Y/XQyAvZwxMRqIN4QBhj6sCtINtwVStShAE8n2/U8sEun6beSh7S7290COTpvH8ZlrJoxuiT7lF75i38PGzPyj3lZ6FzVPlpJLgnz6QYSPZafw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719341641; c=relaxed/simple;
	bh=1cdOCd8XjLCkgJAFNvN+vahzYa0+JWtKcvY//VUQRW8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lTDHm6zbIlfKhN8leEH7cxmeI97EGbLgSsEcflSLD070Vt/EJU/xqS++PzJGx7WA8jyT4Vq/WrJQrsq1Sol3uOF8CXuVkRZQZCCtjWsitftL945f3NGcNJXFURhCd4OnUF0rBkO664TUPsP8KPw41CQO9/bYof1ZTMfsdU5ETrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UEvtx91K; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52ce6c8db7bso3146836e87.1;
        Tue, 25 Jun 2024 11:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719341638; x=1719946438; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tTqAF0m5NgmNYSmy9QWkbOBTT6cudWzYwZuUJYss6eA=;
        b=UEvtx91KY8xmnxFLV61doWH8WGUY+kLFTj5oPFWEOf3oV38CphJua3YSQCq3RodgC6
         G5Z4y7v58Ppiur2zpGKzVW7RpaVL2UBE8RCDbeRvr/jmI2hr90hDwmG49P8ibum/Qa4O
         lyPM4raeYN4slLLVSZ4o6xJXzarab4hjskceKCzGq/nm1kRF4PeGk8SceuEG99Bo9xN0
         5ywXrBhdUud7QOooMNG6prYqBFvEvro26kuICTZhhC01lQ8AnujvpIRAZGWriZ/wPRsb
         Hn8g/GWne3DwF0AdprICQsvcB0WimioAyJ0C18MjO+/i6K9JLljOlt0FkG12yfF6d/3d
         hjJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719341638; x=1719946438;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tTqAF0m5NgmNYSmy9QWkbOBTT6cudWzYwZuUJYss6eA=;
        b=k6GrrgaqkHSVWhzCE8hTjno84fVkjsUZaGrNxHeGtaG0TO0m0OdZNhzfjlF9sY8Wr+
         L7bgT1kK+kDcY/0Mvz5Qf9RRA1a+iPeH6OXBa9Pa/s9g74tW27boSSEJIDYhd0kDr2OZ
         HCwqNzmx9sMhel9uL92NZnF5GjDjA82t6NKjuLFeN7BPu8tz0sa02xM6b9P5wIlYVHAA
         Z1NPZsCnzyIpRH6XRWkatw1yXpbw9/9FHf8zrH8itIQU+Fw9nxu0C4yrK2imV18yJwNb
         S1cjH+6sIuYGUPhgwz5rzUDtYS5x23eUx6vt/bR9HHMZNs8GvI7nQWs2k84dVjKDn8Pd
         K9hg==
X-Forwarded-Encrypted: i=1; AJvYcCVCi5jh9eD4+HZULep5af1HQAJ87e4t2G202mr0OqTvWCbUbp8HmPJYUPIgRxrh1hfTkEInRcqaRJrbcH3fu3zxXnJMgTbOji1RImOY
X-Gm-Message-State: AOJu0YxgKqEsFw4wBpcyckLWdUzLVEhovpRLhTtJNUlGAKqTpC1U+qCx
	+jkj8RtDAslU5TZmtdl/PYfWAf/vBveZ41YEF7M/5oamwRb7MrAAtowHWA==
X-Google-Smtp-Source: AGHT+IEJAA7XJTdOGBAvwMgGxVd/JOtwaGFJL206n0vAobtmLfTO8rlJwjQ9JVtpVK+2nIQx9Go0kw==
X-Received: by 2002:a05:6512:3ba9:b0:52c:df4d:bb9e with SMTP id 2adb3069b0e04-52ce183b7e5mr7491623e87.41.1719341638198;
        Tue, 25 Jun 2024 11:53:58 -0700 (PDT)
Received: from [127.0.1.1] (31-179-0-202.dynamic.chello.pl. [31.179.0.202])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d30562ef3sm6201650a12.91.2024.06.25.11.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 11:53:57 -0700 (PDT)
From: Roman Storozhenko <romeusmeister@gmail.com>
Date: Tue, 25 Jun 2024 20:53:55 +0200
Subject: [PATCH 1/2] cpupower: Add 'uninstall' target for 'debug/i386'
 subproject
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240625-add_uninstall-v1-1-ab031bbd98e6@gmail.com>
References: <20240625-add_uninstall-v1-0-ab031bbd98e6@gmail.com>
In-Reply-To: <20240625-add_uninstall-v1-0-ab031bbd98e6@gmail.com>
To: Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-pm@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
 linux-kernel@vger.kernel.org, Roman Storozhenko <romeusmeister@gmail.com>
X-Mailer: b4 0.14.0

Add 'uninstall' target for the 'debug/i386' subproject.
The target removes binaries previously installed to the
'${DESTDIR}${bindir}' dir.

Signed-off-by: Roman Storozhenko <romeusmeister@gmail.com>
---
 tools/power/cpupower/debug/i386/Makefile | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/power/cpupower/debug/i386/Makefile b/tools/power/cpupower/debug/i386/Makefile
index b3f771039b17..355f44dafa00 100644
--- a/tools/power/cpupower/debug/i386/Makefile
+++ b/tools/power/cpupower/debug/i386/Makefile
@@ -39,4 +39,10 @@ install:
 	$(INSTALL) $(OUTPUT)dump_psb $(DESTDIR)${bindir}
 	$(INSTALL) $(OUTPUT)intel_gsic $(DESTDIR)${bindir}
 
-.PHONY: all default clean install
+uninstall:
+	- rm -f $(DESTDIR)${bindir}/centrino-decode
+	- rm -f $(DESTDIR)${bindir}/powernow-k8-decode
+	- rm -f $(DESTDIR)${bindir}/dump_psb
+	- rm -f $(DESTDIR)${bindir}/intel_gsic
+
+.PHONY: all default clean install uninstall

-- 
2.34.1


