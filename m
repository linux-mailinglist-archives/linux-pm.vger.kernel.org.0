Return-Path: <linux-pm+bounces-41319-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kI9SBiVpcmnckQAAu9opvQ
	(envelope-from <linux-pm+bounces-41319-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jan 2026 19:15:01 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E5C6C26D
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jan 2026 19:15:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2383B3036A78
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jan 2026 17:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB30938A9D9;
	Thu, 22 Jan 2026 17:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BvmUpGT8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E6136923F
	for <linux-pm@vger.kernel.org>; Thu, 22 Jan 2026 17:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769102443; cv=none; b=WQK3H/LRW3T4fTZum4ib6uVMTfX417u2HTc7U57rgqmOVkFinl1VbhFDQ1+I2DTIOH4bK+9osfg591ZjtJ1sVVjSQGuFxLrkPOSe8Cc5Z1tDKd83UHl1B0h9Pl5FTMpsNvCwiAEGQqlahnf9DPXQh/Gc6zHQoVHpBLC+OXzcirQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769102443; c=relaxed/simple;
	bh=n9RZtPFllLNwOyCjbUMdTCvnrM02g20QTY6jzHJIkQk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=OgxfhIWw6fmc3iKZTX4xm4CK/58ycTdtP3iHZQMl6iq69jFjNxbP79gVyGjsnp2PkQxl9EsjWkklUirKpEFhE6uhc1Bc4UgnvHButbaPARzhFdjRp16MAvOETGLxbH6azqBINZZcVVsbLp8s8oPN+eoYYeLdvdOuUsIQf4quHKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BvmUpGT8; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-42fb4eeb482so912751f8f.0
        for <linux-pm@vger.kernel.org>; Thu, 22 Jan 2026 09:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769102428; x=1769707228; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vp66PoEMaro4oICpmfiKYxfo9XQqIbFmXqoLz93VEMo=;
        b=BvmUpGT82iiIhC3Xk+d071xVm7e+IRxoewBvylH+AeIcLMLqpCYXu9E9WU6iWUvdcW
         QoP9DWr6MAZQNO8wr/BBC2AV2LnYm/EHIuBtRmLYqvt9rWMuDD8koYNMNE75+v2pTtuy
         3LgvRDirQKYmuvFmITKEioZlvQ7uZ6t5QhKclecL/U1zKP9W1Sjb2Dhh61CvvzmzMXMq
         0+EXWZ1uMJeqCLAcOEnlDAUjYXXeClfNYXj3T9i5lQb3lT6TVh8ypWUK2+Ww2LjEMdBB
         OmmUolQrBCFTscJINHcKwoBU3zjXcDbgSF/Flm8NgUA4PWBIS56W3CUOBWRGUQVCmKry
         q2Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769102428; x=1769707228;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vp66PoEMaro4oICpmfiKYxfo9XQqIbFmXqoLz93VEMo=;
        b=F6oXkZhw6sCXg3T6F+xHSPBmshOHR46GIMZBT3B1G0JLqsz2VuJ2W9rJ21ki+8DblP
         PJY/qKAH2lwehY6N6Ioufh52MzwmM5aiDZ/SBeeji34TkO25hYDmkUzgF4me8i+tRFt2
         AQa05JweZznvRm6pklppCqZKz4N9dGBi24a6DVP9TvCUfuQDSLrhOznZ5yvRj4ieCRpG
         iOw9opy1I6VPQEsprzJKxfRRACygMfxojyaXprTy4Ti8iHNlKEtVbpWDNhGfQ5nJrF+9
         93ia7fCrfJkMCfmIIWUk1sdHo3g7e+wJxJnraspd4rRDCZUjX/Uld6EfiGkWmUD9SwYv
         009w==
X-Forwarded-Encrypted: i=1; AJvYcCWgcUV1MHJYeAwr4kdPd/RtuNv3xz6QI3QaI2BJuxZLXbMZascjxX0RACt32xAStB46LAU6NxeLkQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5NPWtP33PT9VZU1ruYc/bBbx160JSIFwSV5bdh+zlxRuh+2DU
	dWEWS2lu/Lf4TCb3GEXwjQdQdqAx6kYx4E0ikR2OXKKlT2q7LknGf5xV
X-Gm-Gg: AZuq6aLTDbSrkfwKJtrHILObrjlgdcuiME8BlP3kd2OTmQsnNE4L51sRooVbzVstg11
	9tVctJL7HBWYLYhEMj/MLD7j4ZoJk+8huf7lGwz/3D7ojUmPxMtlOzM594gtDs0x4l+g2BdLS12
	4uyUEimSCIa3WH3Lh1ulfKQSb0geM1Q0U+3TEyqja+BdVDOMpfakdBBOBJ0xBxQyX6aDD/xTdjH
	n8Sd5mb5Sn9vW3CB59qAdvAALBbCn0xqb2vCvY4r/n+kvp8TCKUE4ebaqfzszU4aURaUsXsFbDV
	ug9jmbYv8DDKOlzaPZ4XMim9tUVq3LKpZD11gpOFQmg1qMI+N0RkZzlJz3QaOWQ8stLY5Pd8TMQ
	DdLfn14l3lGUIoomESf74a05E6LAOZaXS7y0co5mu9NqPtBnFm+ZHR6R49yLvrCzOyA8U0ORpr4
	QTP5uwYa7WkxZLTnsvQgxdopgdfaTJTR9qftPZaHnM
X-Received: by 2002:a05:6000:2dc3:b0:435:ae97:b37 with SMTP id ffacd0b85a97d-435b161343bmr424678f8f.52.1769102427581;
        Thu, 22 Jan 2026 09:20:27 -0800 (PST)
Received: from [192.168.0.253] (5D59A51C.catv.pool.telekom.hu. [93.89.165.28])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-435b1f7ba0bsm51378f8f.40.2026.01.22.09.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 09:20:27 -0800 (PST)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Thu, 22 Jan 2026 18:20:12 +0100
Subject: [PATCH] pmdomain: qcom: rpmpd: fix off-by-one error in clamping to
 the highest state
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260122-qcom-rpmpd-clamp-fix-v1-1-7b6a67975a69@gmail.com>
X-B4-Tracking: v=1; b=H4sIAEtccmkC/x2MQQqAIBAAvxJ7bsEkjPpKdJB1q4U0U4hA+nvSc
 QZmCmROwhmmpkDiW7KcoULXNkC7DRujuMqglTaq0xovOj2m6KNDOqyPuMqDyqiVnB3JDT3UNCa
 u+t/Oy/t+432zk2YAAAA=
X-Change-ID: 20260122-qcom-rpmpd-clamp-fix-060fcda9cd74
To: Ulf Hansson <ulf.hansson@linaro.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Gabor Juhos <j4g8y7@gmail.com>
X-Mailer: b4 0.14.2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-41319-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[j4g8y7@gmail.com,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A1E5C6C26D
X-Rspamd-Action: no action

As it is indicated by the comment, the rpmpd_aggregate_corner() function
tries to clamp the state to the highest corner/level supported by the
given power domain, however the calculation of the highest state contains
an off-by-one error.

The 'max_state' member of the 'rpmpd' structure indicates the highest
corner/level, and as such it does not needs to be decremented.

Change the code to use the 'max_state' value directly to avoid the error.

Fixes: 98c8b3efacae ("soc: qcom: rpmpd: Add sync_state")
Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
 drivers/pmdomain/qcom/rpmpd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pmdomain/qcom/rpmpd.c b/drivers/pmdomain/qcom/rpmpd.c
index f8580ec0f73785544aeb6f686438f39b477d134d..98ab4f9ea9bff431614739f37cd32b7b3bb407e4 100644
--- a/drivers/pmdomain/qcom/rpmpd.c
+++ b/drivers/pmdomain/qcom/rpmpd.c
@@ -1001,7 +1001,7 @@ static int rpmpd_aggregate_corner(struct rpmpd *pd)
 
 	/* Clamp to the highest corner/level if sync_state isn't done yet */
 	if (!pd->state_synced)
-		this_active_corner = this_sleep_corner = pd->max_state - 1;
+		this_active_corner = this_sleep_corner = pd->max_state;
 	else
 		to_active_sleep(pd, pd->corner, &this_active_corner, &this_sleep_corner);
 

---
base-commit: 95fad101a21d31b4facd1b9e0713bba1c517db6e
change-id: 20260122-qcom-rpmpd-clamp-fix-060fcda9cd74

Best regards,
-- 
Gabor Juhos <j4g8y7@gmail.com>


