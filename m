Return-Path: <linux-pm+bounces-33606-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8851AB3F619
	for <lists+linux-pm@lfdr.de>; Tue,  2 Sep 2025 09:02:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 767A47AC6F4
	for <lists+linux-pm@lfdr.de>; Tue,  2 Sep 2025 07:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127E82E2F05;
	Tue,  2 Sep 2025 07:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gno/sq5v"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A059E1FBC92;
	Tue,  2 Sep 2025 07:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756796545; cv=none; b=qsA4jyCbfiClKkOsRuEk/2utwe1/c+NkB/yM4hwlrDylRGy2rysR+c40rptdj4h0YgzF+kEeBFh0jdUN6mpETNVki2WAeWpQv6ve52636/Dgc3YvoWs0jnGrvGQ/hxj4utNchWWctNntBYL5d1zfGAKoLYOIPl7azL7mjTIwDm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756796545; c=relaxed/simple;
	bh=5GZIVrAP+PmodAO9ccxQjXKJpoHiRp4wDndnZKF1804=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ouZFcPoJDtccpe6xh0XmqiUPxp3nEGRRJlFmJ1hs0rwSzEW8fKt6Pva3PeRFBrPJIDWeCxdgENubVGCIyFHSIspAjpU0OWE7O98+l40vArMMnEwGS4OQ7ZHBumgrDsEVIIbueZWT3HoTQaN0XS6t6fTpWgiG12tCdVVTPJOVDws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gno/sq5v; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b4d118e13a1so2249434a12.3;
        Tue, 02 Sep 2025 00:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756796543; x=1757401343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S71AVW9uJ7Y0klqZS4hYcMNS4PENPkQ3VjLHPQJ+HWU=;
        b=Gno/sq5v5UzrsOUkFAtqhAuqS9BkD2LyTwLFMWSXLhuhuVla80gy8ll07408UHgPtE
         YHG2Ia4qsfIdn5MD9HnMMOzuxMZOrlTDK1nuF6Z8WLJyfae2R4RBE4ghHdvfo0g7mXRT
         OpTmYmVsTi5yTKsQ38xsngYgzTaAJyJ2gaNJQEhiKSg04e9zvvA8SW5P4rncb20fZz/I
         hyUjxVHxrbGfUq4aQmZDhhKymWJ6ComMH+MLTjCVBvHheiW5rICukWtwWGdBMIdd5/eS
         14On3McVYRwaBs9041K1fOEmHjtxaocXPA6lqPhvTRbrf3M+DLbW0X5klSzxCGePIEbx
         G16Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756796543; x=1757401343;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S71AVW9uJ7Y0klqZS4hYcMNS4PENPkQ3VjLHPQJ+HWU=;
        b=H8+JNsEXwLtckqm6Ccl6foaHyXwGYEELyESymb90uxVxvZFJ9OcCDpXeFYNWn8JLXi
         gmS+osKYooEtbl/pwjpZRqcJVskhUtjj5OzxkUgmRzTITdD1YHEFvB5Y0EqeS2/8PMST
         UO6YNs54D+LVgpSLQygXyCYoCw07J+H8aFpg7drOGGFLzyXE+0DJN6d0ShRbZ7wlwuBT
         mAe4zF5W3TSf/hRQkvou4omUZ3A/L8xnCevtco3NyVsWqn2ffs4ySwklHSc/uezMCQVM
         4oGaHoFFGTUKjeh2YtFygq0q0/GmO3q3WM/IjiDBuqOWlGTswINp/GTpd7X4h40R9n3R
         CyYA==
X-Forwarded-Encrypted: i=1; AJvYcCUVKSKyOPhimKcwk4dqaTVypY7UDYNuVR9qqZ4mhj3Nrdjbz+2Iq03wiB7FR27KjVcWecxwQnmGGSs=@vger.kernel.org, AJvYcCV9mnYde2RJpNQF740ve7BG7g5AxxiplAtSChc1aZy/uIbHCa+OAK40lPlMz1XnepGZczZ1uOTG@vger.kernel.org, AJvYcCW7g8ZIvGfL/a54J5SNKFoZvr6bHRuwUyvmownkUGyso7YEtcN7Fu1Gru44pZxyK3t1eEMBjWU1ppstxSk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbIW8tb9iuLNLlIWGV7vHvJdFOPG0iK8IbEm32UVyRnAlJZW58
	aB/QQYnw3b4mcyAyeStDT5OLuzHmtWWRyKCGTk56wrV2t36NzBmv2MBscCquh6Uvz4U=
X-Gm-Gg: ASbGncvbDrlfnRDFblYXtZTkY1/nRCqfqIVFWS5vPllmWNf+c8AIz8hVZJPO+02v98O
	GCFK7+035dFsmb43BicVDrClGPB+4hhMvKnPT7lbHHlNCYUS8TjoWrTGqYE7dIl8wj8odwWPVOJ
	6ve1qS82oZaVPvAA4kUqEk8kzz4nzqcOwVAGkdJBGb332POeNDGRBDN5RR6LmoD1QXYLkM4tVfS
	Yfcmuar5HzNpYSgZUN5SGVfPNUsl05NHBelrYHrjkg+lcRiqRXjP0Q0+fnotEA4adv89CHvjT9E
	7NLReZ92lFjK8klviPkwZ2oi1mF4lS23XaW951HY3hy5+JrNbVMIQUt9JDGrLhj3y6n2Qfy7YAw
	o08hcM2Vcm5T0o1UuF0HFQkXbezETqK2fa+l5BgHxAG/21+AH2k+ZcOnXeHoZMVZDWOXdctC5DT
	KAqw88H5arf+5LOAO+GQMwranrGM3zIBfO3lGRruunSntVKqxbj+4XdU7MeDm7m/ZMo08=
X-Google-Smtp-Source: AGHT+IGxK55EAS7ohPg8W/lb6ran9pJekTStpJKyxIxfvVXNQVCyazXehd4bgAMUBBcwZrVklM2+zQ==
X-Received: by 2002:a17:903:41c4:b0:249:36b6:f211 with SMTP id d9443c01a7336-249448f8acdmr157542095ad.1.1756796542784;
        Tue, 02 Sep 2025 00:02:22 -0700 (PDT)
Received: from vickymqlin-1vvu545oca.codev-2.svc.cluster.local ([14.116.239.36])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-249066e042asm123811015ad.146.2025.09.02.00.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 00:02:21 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linmq006@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] cpufreq: nforce2: fix PCI device reference leaks in nforce2_fsb_read
Date: Tue,  2 Sep 2025 15:02:13 +0800
Message-Id: <20250902070215.2383320-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.35.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add missing pci_dev_put() calls to release device references
obtained via pci_get_subsys().

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/cpufreq/cpufreq-nforce2.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq-nforce2.c b/drivers/cpufreq/cpufreq-nforce2.c
index fedad1081973..0a49cb9d7ba1 100644
--- a/drivers/cpufreq/cpufreq-nforce2.c
+++ b/drivers/cpufreq/cpufreq-nforce2.c
@@ -148,13 +148,16 @@ static unsigned int nforce2_fsb_read(int bootfsb)
 	/* Check if PLL register is already set */
 	pci_read_config_byte(nforce2_dev, NFORCE2_PLLENABLE, (u8 *)&temp);
 
-	if (bootfsb || !temp)
+	if (bootfsb || !temp) {
+		pci_dev_put(nforce2_sub5);
 		return fsb;
+	}
 
 	/* Use PLL register FSB value */
 	pci_read_config_dword(nforce2_dev, NFORCE2_PLLREG, &temp);
 	fsb = nforce2_calc_fsb(temp);
 
+	pci_dev_put(nforce2_sub5);
 	return fsb;
 }
 
-- 
2.35.1


