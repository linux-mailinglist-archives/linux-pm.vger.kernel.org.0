Return-Path: <linux-pm+bounces-6080-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A72289CF63
	for <lists+linux-pm@lfdr.de>; Tue,  9 Apr 2024 02:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DD031C23EF1
	for <lists+linux-pm@lfdr.de>; Tue,  9 Apr 2024 00:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8554A07;
	Tue,  9 Apr 2024 00:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gWDF4LVk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88E04A3C
	for <linux-pm@vger.kernel.org>; Tue,  9 Apr 2024 00:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712622712; cv=none; b=lBGpZ442o7rNMKcWm8is+0VX3Y+UiPttgIoKWHRYiXqi+kug4PrbF2aGIC8OUDUnO1on7xRif0Y/rk1eO09GWo5wW+5Jg5dFlY+YzyEzwhuZ0zLjZh5JGUl1lkvWZKtXsaRyK8iV6qARF1t12du13hFBMZv+NW4i1VHx8pW4Nhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712622712; c=relaxed/simple;
	bh=jXiPvsskOnL5VXB0VpQ5PqnNDSsGX3Z7sjocpispkeI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Gf8W2htEZHZG+JOXvgOHE6vmhkkb+xis1rgsYtFb695BMZsXgmmoTI8ru+wks00yeG3f/+SPqcBc/Q/izi/U7+dS4amK1SAV8oVfm/+sECQhbJtHxn4oKshBzTZVz7fymIky6JVV71QZ57nGYQQhlrYiZeQo/ckv3OLBryn4egE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gWDF4LVk; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dcc7cdb3a98so4783528276.2
        for <linux-pm@vger.kernel.org>; Mon, 08 Apr 2024 17:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712622709; x=1713227509; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zSVzoM6L/1RhDiYBhn/bN1xPS8uLhIhHDTLclZ9XNM0=;
        b=gWDF4LVkpT3vsRrLDlNZrInG/X42MoQtyfvQnQ704dI6nCMzuE4i4BvDJj1gj/+g2N
         cozzJtIZrEj27mACPCcH087lepGVCPiB5/GfkLkpSXw6ztTuNuOMPYLsfPsvCRaEZElY
         +dJrfGwGtDrVVN+YYOZOh2OpwNNRKfDaDE/VdcSHVsX8rgbu7PpPf4lKFLQgecwCdJHR
         UTvvl7d+q/dw9MOOA8nQh3Z2+EBNh83DtGW0PaY9raRwjm3PSlCZTulcFA2RvnwAeDxS
         jr2OaDUz2wIT04/ZytTfEZE+X1PwAhOFgZhPiZqkUpQ+W7YrCD/4ZRLwLDwgr7U7eKgy
         6r0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712622709; x=1713227509;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zSVzoM6L/1RhDiYBhn/bN1xPS8uLhIhHDTLclZ9XNM0=;
        b=uPBEe2HR+5YHoxQakSKJ9dnv+6dznwMbnIZLkC1vtsHr2uOM3C8p0H3ceRe0CdfTxg
         7CmQ6gBRImt8wWyXwxeVLnExeUeDgQx4IVE1JYuZX5/z2Y0v07vgVd+wypvuRmwIZAcK
         bKIMBXfP1o+OQQUSggbgOYQJW8zB4WYWgkHbYZSO6JqatuqG+FoCpqIMfWTBD1B9lrmF
         23qxxSc+uOB+TloLeqEP7zynV2s8Ca4ZqtnM2Lb9p2ESr0AeDSptLQRBdE3Ci+vxANjg
         pke7ZTiw8Ys2JjBTbKSTAwPRMlizwODl4Tto+kt6WD328YdzMfm80V2QEm7qAWmVfQPe
         5jog==
X-Gm-Message-State: AOJu0Yw0TvLYuHvBJuV+84WOpvgoHA8wOPdw9di+m6/HXm+6JmndroHN
	sXpMb8D1mbZsYlR4UdMZecwN3vofOw7ugrVVfcPquyfMoOUjTKt7Xo6Val1b
X-Google-Smtp-Source: AGHT+IFE/7+X71nauBylICCBtPADJDQMkXqGMwsjMAd+qJVZSgOO8/MtTWZ4TD8g3uxyO8E3djzjoA==
X-Received: by 2002:a25:a84:0:b0:dd0:972d:921 with SMTP id 126-20020a250a84000000b00dd0972d0921mr8098890ybk.22.1712622709635;
        Mon, 08 Apr 2024 17:31:49 -0700 (PDT)
Received: from lenb-Intel-NUC8i7HVKVA.search.charter.net (2603-9000-9f01-67cf-100c-5508-c194-b194.inf6.spectrum.com. [2603:9000:9f01:67cf:100c:5508:c194:b194])
        by smtp.gmail.com with ESMTPSA id h6-20020a25e206000000b00dc74ac54f5fsm1531949ybe.63.2024.04.08.17.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 17:31:49 -0700 (PDT)
Sender: Len Brown <lenb417@gmail.com>
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>
Subject: [PATCH 08/26] tools/power turbostat: Fix warning upon failed /dev/cpu_dma_latency read
Date: Mon,  8 Apr 2024 20:31:02 -0400
Message-Id: <b6fe938317eed58e8c687bd5965a956e15fb5828.1712621427.git.len.brown@intel.com>
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

From: Len Brown <len.brown@intel.com>

Previously a failed read of /dev/cpu_dma_latency erroneously complained
turbostat: capget(CAP_SYS_ADMIN) failed, try "# setcap cap_sys_admin=ep ./turbostat

This went unnoticed because this file is typically visible to root,
and turbostat was typically run as root.

Going forward, when a non-root user can run turbostat...
Complain about failed read access to this file only if --debug is used.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index c35c48b6a99a..531f37e5f92a 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -5545,7 +5545,8 @@ void print_dev_latency(void)
 
 	fd = open(path, O_RDONLY);
 	if (fd < 0) {
-		warnx("capget(CAP_SYS_ADMIN) failed, try \"# setcap cap_sys_admin=ep %s\"", progname);
+		if (debug)
+			warnx("Read %s failed", path);
 		return;
 	}
 
-- 
2.40.1


