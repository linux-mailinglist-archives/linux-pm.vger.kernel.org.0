Return-Path: <linux-pm+bounces-19247-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 140669F2274
	for <lists+linux-pm@lfdr.de>; Sun, 15 Dec 2024 08:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 657C17A076B
	for <lists+linux-pm@lfdr.de>; Sun, 15 Dec 2024 07:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE0314263;
	Sun, 15 Dec 2024 07:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b="TemHNU3n"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0F3881E
	for <linux-pm@vger.kernel.org>; Sun, 15 Dec 2024 07:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734246623; cv=none; b=gd0YtvFwaajvuWJOzq1VOG9Xifi0CkWSql/pNg3z4+lVIeo97T4OYYnl4/JyeWrNezI7dtv52rQIEx2STQuP37vNZ7Mk4yFgUO6ZO7U9bZDFyl/TSjgGHxqF7/JSVCSnfwAbGyP0z9Os/tZ0YBFFFNXjq6AmYt0UP3XfnIX2vm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734246623; c=relaxed/simple;
	bh=4y8pyZl0sDO4uolquMxdGIbrAQbmpwf4Sq00Vc2dSk4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LC7jRe4DPBSIZCKvVIkC+sCknG9N77QRxzAFxRHYOH4yyDaAqtEYxAnj7j8xs6oiL/i4vWB6Axv9Q1UTpg48/JjeXmxlBGH+nqHB9/6s4a24t8OeMMe9WWE0jSx4/i8K7kjNdP7FA8u+PLnjX09aQuIQ4igTDitB8pUDvDUUyvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp; dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b=TemHNU3n; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2ef87d24c2dso2319893a91.1
        for <linux-pm@vger.kernel.org>; Sat, 14 Dec 2024 23:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com; s=20230601; t=1734246620; x=1734851420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S4+Cu+jWnEpuv2bxfR77QO1MKzm+m0kZ0gvNUZL6BOc=;
        b=TemHNU3n1upChBDmeL5rf5XGjw22/oNCAkoyCfvnSV4VjsR6itL/Rs/Zmi4fpeH4Ue
         ZJnFZxx8EJR553wVuwcMhpweZazN+sIvKlhqK5oMghvrWinN/8bUX9yUXGSee369URF/
         ujDVD+4cPG7DBL3Bt4SYPdW188WnBkR58WnQ2riZwp440TVIzudTiZc1MLJIEBzsavbr
         mPCcD78CpO9Q2LgtLe/lOU1dQ+AQ8VozBecggbBnLUbSr6uJima8uQUk1fp7kgMc1c/z
         muGYVCOxvWU4cbyZBJuZD0/bwInoq5nFWh6V72nPcflI6/tNWXSpzVbTeQV7RXWQ9e0l
         eYsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734246620; x=1734851420;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S4+Cu+jWnEpuv2bxfR77QO1MKzm+m0kZ0gvNUZL6BOc=;
        b=wwjNXOkxvY/+xwz4+/Zg7Q6qXKBKB4/zzOEQnPs+r7jGEaEH37tYgdecOPmkGyjhT7
         nhIAn/Yniu7v2T0BnqjCtsE4VA/eqM7JfIuB+KaE9ANh7T1s1D7CQW/Fli+lgMeiRVfq
         +ThMcT8ABAK8/1J3nFH26koPg7cCr9edQII1peCxeu7BfZZ2U7ta6xH5eR+4jrN0SPnS
         ZcMTkrgTGZP8d2m/axb+ZTDFKDGlz96Iirgj7WdzbNqbGrUNZ92SdgpbiBM9DjTeBJCh
         YOguUR5KQFggzqV7HTyxGBworHxvq9uT6K43JGETSYm0eHVRyd/EmYv2c95y1P1ilJcI
         HxQA==
X-Gm-Message-State: AOJu0YxAlHlMKYtzbRol/hr/rryuwvZcscwtu3Iue3CV14YvxoWkHYnk
	ECcmy4fv3Ixyo6HJN5ExiaA6Wo45DNnTzrq3e1oIsaEauq6yxjlzfz9g7cqIpki0D0LgkRrq1mY
	ts+StGw==
X-Gm-Gg: ASbGncs41S/kbbe8UBtNSRE4MAaEL2mbReaC2K55IzwLgoLVTz/mE8214W6Q4Jhbgdv
	JQ1TJO/K8JRqc59WPgXPgz3f1txB/SKLvLGRcJdVjEbrxz9L8Y78r8S5knVl0QDMnjbTPwKnI27
	mUrsLV2KaPhmG5qam3dxYB/CQi/l7rqwsvl3aQVcCVew9DFCbH6eemvXpReAhP7KeanRcyaiOjN
	PU8gVxLEAda3EQeAdZWsO4ot9ZPh+puQT73st5WjsXr9jakz4JmNf432TEJrfi/nurT3IhYhAAE
	+0CrMbGvkCB6ZfxR33jb8nEf99h3Nid14td7xvu6i4A=
X-Google-Smtp-Source: AGHT+IG+DsXSN0bl8CWTYwEETCpDiFXAqw6pzdz5hUm44u15iXc5achy7KhSDOVyPHPM0d6rB5aF+A==
X-Received: by 2002:a17:90b:1c05:b0:2ee:889b:b11e with SMTP id 98e67ed59e1d1-2f28ffa7df0mr12595803a91.30.1734246620309;
        Sat, 14 Dec 2024 23:10:20 -0800 (PST)
Received: from localhost.localdomain (133-32-227-190.east.xps.vectant.ne.jp. [133.32.227.190])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1db7c82sm22269925ad.13.2024.12.14.23.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Dec 2024 23:10:18 -0800 (PST)
From: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
To: rafael@kernel.org
Cc: linux-pm@vger.kernel.org,
	Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Subject: [PATCH] powercap: balance device refcount in powercap_register_control_type()
Date: Sun, 15 Dec 2024 16:10:12 +0900
Message-Id: <20241215071012.59208-1-joe@pf.is.s.u-tokyo.ac.jp>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

powercap_register_control_type() calls device_register(), but does not
release the refcount of the device when it fails. Call put_device()
before returning an error to balance the refcount.

This bug was found by an experimental static analysis tool that I am
developing.

Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
---
 drivers/powercap/powercap_sys.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/powercap/powercap_sys.c b/drivers/powercap/powercap_sys.c
index 52c32dcbf7d8..c2d36dbe29e1 100644
--- a/drivers/powercap/powercap_sys.c
+++ b/drivers/powercap/powercap_sys.c
@@ -627,6 +627,7 @@ struct powercap_control_type *powercap_register_control_type(
 	dev_set_name(&control_type->dev, "%s", name);
 	result = device_register(&control_type->dev);
 	if (result) {
+		put_device(&control_type->dev);
 		if (control_type->allocated)
 			kfree(control_type);
 		return ERR_PTR(result);
-- 
2.34.1


