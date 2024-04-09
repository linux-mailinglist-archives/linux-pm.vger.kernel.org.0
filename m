Return-Path: <linux-pm+bounces-6090-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 274AA89CF6D
	for <lists+linux-pm@lfdr.de>; Tue,  9 Apr 2024 02:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8808284AB1
	for <lists+linux-pm@lfdr.de>; Tue,  9 Apr 2024 00:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5848827;
	Tue,  9 Apr 2024 00:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ddwUNXvx"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735656FD5
	for <linux-pm@vger.kernel.org>; Tue,  9 Apr 2024 00:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712622722; cv=none; b=KvbQjh7hW3NlKIHtSiiUAj2c5hr9qGg+bK4hvLTmOp+PlcWUReUVv1WVk1GIshG56tnQwhDFjvC3t0dGGL0OPUgI1xzcN7k6v+YFVLpn9jZkLbFYwc59OwCSOuumwMZTmpm62cFJG2EyYCAha9N8Z/pcWTp5fx+hgZjYkuoml2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712622722; c=relaxed/simple;
	bh=yenTKRj6kNUFU+zG0Vghl68RJAlRqZkEzZBCIO0yjqA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rFzJJoGFz2IqOtXAA+aWL3A0dVsd1zRSjS9ahdvaw5sf+Bk4lJ7S0vefstRkTSiFD7hX27FOSh9HCiGU7YGIwVSpW3oW8APOWnqf31vrmmdZwbsf57xLJ9rIGK3oH2gRykugpH8pJEJdDJeZM2d4Z3rtnVu3Q2qFXMZZWmh02zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ddwUNXvx; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6150670d372so47196487b3.1
        for <linux-pm@vger.kernel.org>; Mon, 08 Apr 2024 17:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712622720; x=1713227520; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kkxM0r+iZ3PYDJxmmawWKLRyX3WMxGpccQe4KO+bInE=;
        b=ddwUNXvxV0Tl6AqRrvyg/KdHXBk/8SVUuJOP37uhWIfLUpnZU3+283OyfvZ0Krl1Zd
         X6Ght9sO+BFH5JnEQajHLxYmUDBThfQKqIxX7csqy8Z7vwiu3GhsSXdQ3gY0KKYykXV6
         jeCEmYQhvm6KW3HiusjrCSlRueK+mzkNZCzPiVjVSb16K/09l3z1Uxj6vue8FKFhYtvI
         gTWsd3mh9EkEuuJyxfd7S5yR+QdMnM23SLFH9ypoxiNqjNYPIRcre5F2ccg5zexuoeOT
         p6zySv9Kooq4wevJJ1t9y4KKoQBlPFmFJOdyqcee0PyMSgJw5ppZiXtvG8xZ62cdHnW6
         8vPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712622720; x=1713227520;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kkxM0r+iZ3PYDJxmmawWKLRyX3WMxGpccQe4KO+bInE=;
        b=kJn0GcAw1Xo807qgLsYsqftOAdtAIudWKzjjlbjj+wyvi297iDFhwnMDcwPEUERyG8
         wDab0W/abIEjfnav56SqIXm8M5vdQrClza/2pE9VTQnulOInj2YAKv/qRPKjcm7jMDau
         rOJeJHACar9hmOvv1LuxCz1NsWpCGcYtmEHOybGABm+UvWbP2DJLmBuqbgY3PDmA0aDN
         qf+l1cPRlobYuU/KMMZPVZ9Zzr8VwohoLOsb2BR1HywQzfotoSyoE1oOP4NJPOU9UBbA
         qzquvWkqIffLiD03ckGap7MW+Bc+K5wq5eGZ/dtcnt1ft+l/himyZ00N1UQfJ4j43ys6
         E/sQ==
X-Gm-Message-State: AOJu0YyAY0FzxbwZ8EPDL5iq2S2EUZuX0WwD8xkzGpKIM9s+a50Fl/0J
	ItodDZT9zcBplsUfbtxQdgRtIWsX1MUDQyWzSFz0fMbMWa7cY8T/VwNOtebS
X-Google-Smtp-Source: AGHT+IEPoCsu0B5+aiaIKsB7QWs3WfEyE2axyadnz4vVTaE8a7RDp7ADL/0PbAzFtrbTAW1nUBE/qQ==
X-Received: by 2002:a25:1e07:0:b0:dcc:5a25:ae88 with SMTP id e7-20020a251e07000000b00dcc5a25ae88mr8159348ybe.19.1712622720403;
        Mon, 08 Apr 2024 17:32:00 -0700 (PDT)
Received: from lenb-Intel-NUC8i7HVKVA.search.charter.net (2603-9000-9f01-67cf-100c-5508-c194-b194.inf6.spectrum.com. [2603:9000:9f01:67cf:100c:5508:c194:b194])
        by smtp.gmail.com with ESMTPSA id h6-20020a25e206000000b00dc74ac54f5fsm1531949ybe.63.2024.04.08.17.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 17:32:00 -0700 (PDT)
Sender: Len Brown <lenb417@gmail.com>
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 19/26] tools/power/turbostat: Enable MSR_CORE_C1_RES support for ICX
Date: Mon,  8 Apr 2024 20:31:13 -0400
Message-Id: <d8644ae58157edbd575d372e8eeed2b01eb892f1.1712621427.git.len.brown@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <e5f4e68eed85fa8495d78cd966eecc2b27bb9e53.1712621427.git.len.brown@intel.com>
References: <e5f4e68eed85fa8495d78cd966eecc2b27bb9e53.1712621427.git.len.brown@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit

From: Zhang Rui <rui.zhang@intel.com>

Enable Core C1 hardware residency counter (MSR_CORE_C1_RES) on ICX.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index e813831e73a5..c8b148942fa0 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -664,6 +664,7 @@ static const struct platform_features icx_features = {
 	.bclk_freq = BCLK_100MHZ,
 	.supported_cstates = CC1 | CC6 | PC2 | PC6,
 	.cst_limit = CST_LIMIT_ICX,
+	.has_msr_core_c1_res = 1,
 	.has_irtl_msrs = 1,
 	.has_cst_prewake_bit = 1,
 	.trl_msrs = TRL_BASE | TRL_CORECOUNT,
-- 
2.40.1


