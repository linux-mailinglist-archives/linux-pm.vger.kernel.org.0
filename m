Return-Path: <linux-pm+bounces-25201-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5325DA85142
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 03:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94751177430
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 01:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6047417C21C;
	Fri, 11 Apr 2025 01:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="BYcE7RSW"
X-Original-To: linux-pm@vger.kernel.org
Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454FC2572;
	Fri, 11 Apr 2025 01:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744335223; cv=none; b=n5y8FD7o/88BmaHkzRT0c2vlhUlFbe8s59k84kPHEa/7m+y46gV4MgWzNyCey3nsFHf8D9RwDZ8PPR8DZ0/24qcC0O3thRJ/byMGOcXld2dd11olDOFiBP9OoEXOGJp+b2PqRXnOttWg0qmeMXqTFOKBEJEff3DGbJSSpl00F7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744335223; c=relaxed/simple;
	bh=hGCh7kA2+bRIRVnJON1ffOpq+SDsWUqLmA/JelpqzXM=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=TtMSSlBCFXLoYhjWykAeisjABN05XzmohKKdbMc/S+rTRfWsdRK7gz3MrVu5qHU4j8l3iwAfBpuJ+WttNXNmOo0yjXILGxO7352f4Tb7d4GxTZP9IolIYR87T7QvhIuEvDhK1qhD0HsanqMhyUSMT/ino6hQHEhrC3WGO1ohCCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=BYcE7RSW; arc=none smtp.client-ip=162.62.57.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1744334905; bh=nJ5w2zPDFEQ9dl0Cxqt4gZXORo+iBIQnVvHhz6r4NpY=;
	h=From:To:Cc:Subject:Date;
	b=BYcE7RSW7JQ9fmjXHKQtogYQR2zc15wrFLM1nkfXAI60ttFwUi30Fbj+zRp88AgDE
	 dTIb6jRTUY/90jW69RrrbMVvjrOtxkYrdyEpJExkPkIOcf1t/jRP68fo0MiTNzspCh
	 Z7HxDUjBdVpqJNddOeMnCvYYSypDTmVtGYAsjs8s=
Received: from localhost.localdomain ([116.128.244.169])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id 717B2E57; Fri, 11 Apr 2025 09:28:23 +0800
X-QQ-mid: xmsmtpt1744334903t2fzg2zhk
Message-ID: <tencent_EE27C7D1D6BDB3EE57A2C467CC59A866C405@qq.com>
X-QQ-XMAILINFO: OQ59tfF64tJLVPZYM9A6w/qx8MuYhy4MSSGwTKJt15c6EQSY9FxX2Afti/pF8B
	 dtE0FQS16WmVIkVBpGiyollQmwsczVfqks3i49gXt6LmBizQpveQ2yHqH3KncFlHtABDbWH3Wq9c
	 6rK9C0zKNFhhhbledMIibXl4J/4tW98Jt4owPOxnR27DW0/qbyUzeTKBm1K7x10sM5Pf6f9wD+xb
	 DXFAxYrH+CnRHdwLII3HCzLxNglEOLjvqpE0XV3VeVP2ocgi0/yx5HMgsHCqCDmI37IN3oFKx/2s
	 t/2YVFU3He+PRzq2yQePzkyHzpq29G4U0F2lDX2JmWybiTfeUJjohIOslNhQhXhaxoSaM/NIy9xN
	 Ahq6GqcI2ogb3Ul3PYH9Z+2wUUH/e0E6bPBE43MRzQHsDpi52zGXMNRV5aWwLK5qmgv2+vPGyFp7
	 d12S1RI0WHLt0TfTpHjc4SCFXLHXDjfvnmABRQ2ZLmcSDk6m3IfxpWDzCTqQvKJdgHaSx3rs71HJ
	 h+W3zKyt9jHsxsSGfsjgScf06tsaPiGn0/LzEb9k0Eym3KOUaCTnN/odWNbG4WjbUgvCn18vQ82Z
	 kw/aPgxpOYsZ4Mn483wAFzcxr5MWD07QDujfDV1Znt+bZr4/ob5V4MLqiiDBwTMN89bOEK+xbTUC
	 ecmOIlY5ewaG67e4sLyXORygJeOqG/26VeeN+tAw+J43NiaPc04Tc9RyRJ7ecLabKUcllye7eCVf
	 BJDxs1cmjCs6V8m7DcErV4LXUvCFos66z2eO8itmqqTfLWTT+kXnINEBaqdACH4KzFggeSxOXPGV
	 pvaahFOvvAVKzRUJHR6HjRQB33aKONN4DLVuUYh40qiFGxaKXNI7Mze+ZS5fHZh9dYSi4zvSgLzp
	 kI6mt10b7gworg7m96dhXRVFClmoT0tisqkjCvEW90QjRYzPCU4vXwK0LJGyDYb+vyOk3nFrBN2x
	 OWgy9LKr72ghuFArv/Ea/hWRQ1ywQ1
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Yaxiong Tian <iambestgod@qq.com>
To: rafael@kernel.org,
	lukasz.luba@arm.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yaxiong Tian <tianyaxiong@kylinos.cn>
Subject: [PATCH v2] PM: EM: Fix potential division-by-zero error in em_compute_costs()
Date: Fri, 11 Apr 2025 09:28:21 +0800
X-OQ-MSGID: <20250411012821.87829-1-iambestgod@qq.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yaxiong Tian <tianyaxiong@kylinos.cn>

When the device is of a non-CPU type, table[i].performance won't be
initialized in the previous em_init_performance(), resulting in division
by zero when calculating costs in em_compute_costs().

Since the 'cost' algorithm is only used for EAS energy efficiency
calculations and is currently not utilized by other device drivers, we
should add the _is_cpu_device(dev) check to prevent this division-by-zero
issue.

Fixes: <1b600da51073> ("PM: EM: Optimize em_cpu_energy() and remove division")
Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
---
 kernel/power/energy_model.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index d9b7e2b38c7a..d1fa7e8787b5 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -244,7 +244,7 @@ static int em_compute_costs(struct device *dev, struct em_perf_state *table,
 					cost, ret);
 				return -EINVAL;
 			}
-		} else {
+		} else if (_is_cpu_device(dev)) {
 			/* increase resolution of 'cost' precision */
 			power_res = table[i].power * 10;
 			cost = power_res / table[i].performance;
-- 
2.25.1


