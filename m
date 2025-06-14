Return-Path: <linux-pm+bounces-28708-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5237AD99A2
	for <lists+linux-pm@lfdr.de>; Sat, 14 Jun 2025 04:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 508AD7AB6E7
	for <lists+linux-pm@lfdr.de>; Sat, 14 Jun 2025 02:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9298684D13;
	Sat, 14 Jun 2025 02:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="XUAPZz+f"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CE8BA42
	for <linux-pm@vger.kernel.org>; Sat, 14 Jun 2025 02:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749867642; cv=none; b=O6+Ep5BaRUa1Javn39PjP+JmJ1BK5ZLMLGJyvdMhzJn5pWmR20dWInFOq6RaIT9eYtJBOfiEGNoh959YoC8KKigFQfbhDKN1J/CsOHq917Nv3REuzOceII5A9cmE6lOVxutRqO1tM9Ewpj+DPOVXs7DZNwgcsNWAA+P0g3OVKzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749867642; c=relaxed/simple;
	bh=qnHnh/eh5pvaU9wU23V4kDzRq5bjKim08WvNI6Fua80=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XHqE1Xw4dTJAwdZaslK+Qd9vE4VmfnrpZA0SPL7JITaqUCiFkjoJMte/XoMvqW+WtUEshvQqr2ci2skVmzKEJwGzaE1FL/ZAqI7SjUubo3Psvxp39SUPS0lmt58TdyVnkFd1WZnhiyVVs4UmmE608wzxc7R0vfnZjylwEgw9FTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=XUAPZz+f; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b271f3ae786so2148391a12.3
        for <linux-pm@vger.kernel.org>; Fri, 13 Jun 2025 19:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1749867638; x=1750472438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0TCpdrHqvVyx+/z5RHafQUI6EpwCZP78GRIUPCgFN0w=;
        b=XUAPZz+fCjAAYwbBxybGVle8xhbZ+qZnaYwujspfZSJoFOcd3rNK2KVRxXn7k79Sco
         iHbo1mDNkqPKqbdPRgHvuWpQKSce3ZigMkAXApyjjrtYHySHlX4aauMLC5/ErKCDkTVC
         oyzbgAjye/YNV4L34tZoJktnLtibvfRfVhVOiKcvda7eBjvxaMwK7+JmdmB3gYJsS7IO
         I6zelS0R8Wk8JJViLUReXGVAdLVpab2zJPyIEkfkbI8u/KsYW4gnjGJO+ePUbLdrDRMi
         OyPGe6jcbsOSo3PA1J/rOCfT98N+Hub+74UQgYn3aJ79KWqUHGCrzrPG7XOacpw28f+v
         NACw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749867638; x=1750472438;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0TCpdrHqvVyx+/z5RHafQUI6EpwCZP78GRIUPCgFN0w=;
        b=Jpb9Ms9KR2YEh+H3tx7cAq3/TKBCpI4ydasdxsgyVrcCbKcFBNcdEzQKjA47MZOOfI
         xyZXlGOZF34s1bNrOO/em/OSKqTtndfNkC0sibcuB3/tQvtB9u5x9oA4mdt5fJwqhmzY
         riQMAuHMeck6AU/reafQ1qj8o/kQbkavInP+sAihCQk1MDUrYy0CrxLvM1tLqaSuRzZx
         bbY/R16arrAZlNhNAeLxgjMNNvVkQ8Kv/q56JB0StSlqpdHMgH7eHR8Us03NjzWOhTMx
         HZ8mM+FfwFX4ium06BSxELTHWQxc58sXk9RQibQ6ouj4PxJmtUrRxRZ3M9H7uavfaRyy
         lfiw==
X-Gm-Message-State: AOJu0Yw6Rn/uBEIihg53qdS+Elbajw4s3KuES1Em+0ToGzFGpJsjRSDt
	rSpc/4fOztgCO/nC8r8quIZ/dagrc+xHixtrgODlTokcTYnEICVQn2x1J1avBAOH67WDQTnLn4Z
	yuZE4
X-Gm-Gg: ASbGnctrWbi5h5HNUY0Kr+E43GlwP7M84FCS9fzpUc4JlfQed7/8Y6I3c2Ifj/jPI3u
	QaqvZfPX9pcEBMVwzGrqUJx2DPOGr+FQoD6RRdOyeAQxPz+9PLrRBZTly8UTcXjvWIhOyaVgPH5
	aLTNf8K11g9CtFYhVuEXfl24op2UJar9N1aeC6MlLsWpu4lwLn5/ZMM9TYOw18XMw1yjQ3OmlXB
	gQRxmiA7mlo660XX6wWUejqaD6rTMfPfpEPPnS1DShEr2NAGoe7t7mPyyrCg2QECywlozCgeYbW
	6/dwk52FsucFKizuZgBPcybL1t97zZ6bcYPms98N8Bcgxy7LWNTinGiynioTrV8Xg0/hCLIB7DT
	kvqkbW2KrlP6EcFN4L+6mSFGfqczetPM=
X-Google-Smtp-Source: AGHT+IGO/t+Jv/rmdF2kqCa8WUSlji+mz6WDWVoeL7ZLdOjABOPGoI//E1v0p8MAykSAF3XJd20QAw==
X-Received: by 2002:a17:90b:586b:b0:2fc:3264:3666 with SMTP id 98e67ed59e1d1-313f1e129cdmr2206003a91.30.1749867638329;
        Fri, 13 Jun 2025 19:20:38 -0700 (PDT)
Received: from mozart.vkv.me (192-184-162-253.fiber.dynamic.sonic.net. [192.184.162.253])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-313c19cd3cbsm4132857a91.11.2025.06.13.19.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 19:20:37 -0700 (PDT)
From: Calvin Owens <calvin@wbinvd.org>
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org,
	Len Brown <lenb@kernel.org>
Subject: [PATCH] tools/power turbostat: Fix MSRs with CONFIG_MULTIUSER=n
Date: Fri, 13 Jun 2025 19:20:28 -0700
Message-ID: <81f4c402d1fda7c2419aac1148061a0789112e76.1749849645.git.calvin@wbinvd.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Handle ENOSYS from cap_get_proc() in check_for_cap_sys_rawio(), so
turbostat can display temperatures when running on kernels compiled
without multiuser support.

Signed-off-by: Calvin Owens <calvin@wbinvd.org>
---
 tools/power/x86/turbostat/turbostat.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 925556b90770..f7d665913a52 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -6496,8 +6496,13 @@ int check_for_cap_sys_rawio(void)
 	int ret = 0;
 
 	caps = cap_get_proc();
-	if (caps == NULL)
+	if (caps == NULL) {
+		/* Support CONFIG_MULTIUSER=n */
+		if (errno == ENOSYS)
+			return 0;
+
 		return 1;
+	}
 
 	if (cap_get_flag(caps, CAP_SYS_RAWIO, CAP_EFFECTIVE, &cap_flag_value)) {
 		ret = 1;
-- 
2.47.2


