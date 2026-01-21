Return-Path: <linux-pm+bounces-41239-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sCXEBtAUcWkEdgAAu9opvQ
	(envelope-from <linux-pm+bounces-41239-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 19:02:56 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B70625AF31
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 19:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 52B9B72744D
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 16:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999DF365A11;
	Wed, 21 Jan 2026 16:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lZt4phtW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5F8364055
	for <linux-pm@vger.kernel.org>; Wed, 21 Jan 2026 16:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769012315; cv=none; b=Z0wx4C2JqFiDhkb7iF+NvHNjDrvG4Rk/AyesEszFW4+25p7FF3fcVTBtJ5mkVzx9qr8LmRLzTsJtFKVGliChh9Qz3NY3ZcQPxPGLvtQm0RMil6XtJDgmE7+gzOUdSwyMC4BD/C63ZMfqsahGIfLHb0irwQadUm7NZ9I7pxa1oFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769012315; c=relaxed/simple;
	bh=ba3WhcSk6P2p36HdxyacePi62nLw08KJ6HZda1xuPT4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=aUJLu+jemZXj2+QVUbTjPNmdwRLGTDd66qA+qxH+OlQ0MCY8qQFKD/ttFMwhbxH5105c4c4CHlMDt8ZS4QJC8DkcALRMM7dUUnYllqeGFlMWcUjfORMhC0DNNOy9LnOdUQEneSv/PnoE5Hh1+yFOj0deEHkXyTiZg/f+myhayog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lZt4phtW; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4801d1daf53so190285e9.2
        for <linux-pm@vger.kernel.org>; Wed, 21 Jan 2026 08:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769012311; x=1769617111; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zKklyqyTrKSpvhGgd6jrC26at1itayOZjiSVWtQUXJo=;
        b=lZt4phtWzsnPruTSJmCvJ5/ItDOH0o7gTr9IUvY49vyIEBGseO1On4E5SJ1fwdMUag
         CPFbnNbiQvfha1EP+10XRjDScxSYCxHmhiM1kxQM/4tQtZz/jWQmv0q+dmEIVZwosUaa
         EYFdtARLvzaA+TR35QRomG5rV+6dyt4argByg9PXNtWu1yrjl7tA+ZaFdD5fe7GWF1+4
         VWz1StUHgpcNjQdtblLUoirSLzKKd98/dZvbCvxCRcv2vm62DSsJ21Jz9OFHGJ53yqDD
         XQrgrLvXZHff9QaLSNsxaIujEPbCQUfv48IJNSmAd89j+XDiTQe8DkpDllGUW3PTs79x
         iDiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769012311; x=1769617111;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zKklyqyTrKSpvhGgd6jrC26at1itayOZjiSVWtQUXJo=;
        b=btxqFB3K35pmZRECpuG7sJzJee84D2+4yaKvHvryR1dWbj7Pnsnr3b26fRWyrqpAnz
         tZdtg4eaiuF3yy3ftYQ06qWLS1KOfYNdB5oSe0WBBhureMLIY2h0hDFcfLhriA1XQ4oM
         tNOHFpYpaahBbxxzNtCQl0zj8YHRzSU6kw2gRrPLxjCK5nDyyNy8BRaAtViAlWqheko0
         6rj9w1TwokLftIN5WYD1dYBB24Bc5ZdcaMN3tXEq9BOKFJwL4Q/aGGaVSmFW0HhhcOOQ
         G69mdCBctsXSuIE3barlStog4arWpstXRb1n3d8yCdV3PFhHPzOz5tm/SVTb2rwz0nGP
         JC2g==
X-Forwarded-Encrypted: i=1; AJvYcCXGSv9oyxbXKATEhXHvBm6OzwWUaGWRFyuDw9Zw3Hm5YrEGEZsxfG39l8lZmQHrn7M6umtDN85dYw==@vger.kernel.org
X-Gm-Message-State: AOJu0YznchW6/CV/v0Q997kWDq0/BnulxYJPdZraEd/IQFrkAmVN8Kp8
	W+1P5ePy8Pl6sExGrnhnMsG91Oy09RdAPrRri4twdi2iSA5DqsP0fulQ
X-Gm-Gg: AZuq6aJ5L7VWC0S6JlCAeM4Rr4TPq6mEEZfsNH+GgmERahJu/3DvnrgrgQ5r03ywftT
	MydkqQOw15H89pvFAn4Ls5EKgGJrjgRYNABsbQ77SzS7Gw4EtkZpUEmZJmdq+r4cCB/AGEiwZW9
	OnFk1Yw1riLWNKOkG5ZS+OKlFkC7M5XIHEsC5/r/ZQo/0a1lZ7CNaiYEvutFcmyuy5LNgVxIjZD
	e0lyADcwz25LYmkZ1nLML7DwDTf3XA9fAn6JmIF90PFF9K9wfR1tGWwFXLVmcYGtr1XRqw7HMFc
	qk018hwL/+LZ/0sFs9FxjqMY7xJ9GVe2IcZp55ZdUspwWYgf/ZQqngcU69gqnCuPsohj1Gex3yB
	XLofKZVsJBFkKkQADJSdtY9/sSrHkyBo46vMsl+y63nyfJf6HozZxU2ht1aggKB8eA677T37+7m
	x4LaMvCFf8pwTh1Iuyf5Hr5Kvy3KWWA9zrzAsgDo24
X-Received: by 2002:a05:600d:644f:10b0:47b:da85:b9ef with SMTP id 5b1f17b1804b1-4801e2fef40mr224325935e9.16.1769012310980;
        Wed, 21 Jan 2026 08:18:30 -0800 (PST)
Received: from [192.168.0.253] (5D59A51C.catv.pool.telekom.hu. [93.89.165.28])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-47f4289b83csm373525615e9.3.2026.01.21.08.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 08:18:30 -0800 (PST)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Wed, 21 Jan 2026 17:18:25 +0100
Subject: [PATCH] pmdomain: qcom: rpmpd: drop stray semicolon
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260121-qcom-rpmpd-semicolon-v1-1-9bbdd9478ba8@gmail.com>
X-B4-Tracking: v=1; b=H4sIAFD8cGkC/x3MSwqAMAwA0atI1gaagqJeRVxojRqwH1sQQXp3i
 8u3mHkhcRROMFQvRL4liXcFVFdgjtntjLIWg1a6VaQJL+MtxmDDiomtGH96h7T1XTOTIlYLlDR
 E3uT5t+OU8wcBlqVTZgAAAA==
X-Change-ID: 20260121-qcom-rpmpd-semicolon-1f985a101e0b
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Gabor Juhos <j4g8y7@gmail.com>
X-Mailer: b4 0.14.2
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-41239-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[j4g8y7@gmail.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pm];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: B70625AF31
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Drop the unnecessary semicolon after the rpmpd_send_corner()
function's declaration.

Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
 drivers/pmdomain/qcom/rpmpd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pmdomain/qcom/rpmpd.c b/drivers/pmdomain/qcom/rpmpd.c
index f8580ec0f73785544aeb6f686438f39b477d134d..a7b311f966a04210dbb499066cd1105e2c621cd5 100644
--- a/drivers/pmdomain/qcom/rpmpd.c
+++ b/drivers/pmdomain/qcom/rpmpd.c
@@ -978,7 +978,7 @@ static int rpmpd_send_corner(struct rpmpd *pd, int state, unsigned int corner)
 
 	return qcom_rpm_smd_write(rpmpd_smd_rpm, state, pd->res_type, pd->res_id,
 				  &req, sizeof(req));
-};
+}
 
 static void to_active_sleep(struct rpmpd *pd, unsigned int corner,
 			    unsigned int *active, unsigned int *sleep)

---
base-commit: 95fad101a21d31b4facd1b9e0713bba1c517db6e
change-id: 20260121-qcom-rpmpd-semicolon-1f985a101e0b

Best regards,
-- 
Gabor Juhos <j4g8y7@gmail.com>


