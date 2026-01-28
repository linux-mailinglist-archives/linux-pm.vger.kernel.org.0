Return-Path: <linux-pm+bounces-41653-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IIgfFfiOeml+7wEAu9opvQ
	(envelope-from <linux-pm+bounces-41653-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 23:34:32 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E7BDFA99C2
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 23:34:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D892C30602F0
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 22:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 883DA344D9D;
	Wed, 28 Jan 2026 22:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DjOcwbZ3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qv1-f66.google.com (mail-qv1-f66.google.com [209.85.219.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA7E344D90
	for <linux-pm@vger.kernel.org>; Wed, 28 Jan 2026 22:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769639605; cv=none; b=nNs4PNe1Lo4zcL7TrcXvxKU8kNDkreBmpMNoWhD/6IUNu/0xNDgAXsUem1R3SA4pac+zhlg6JirrdnQebc4KMbSQMO4hs7t46IUuEqdyp3DBXUnWCuWBqj3KPk/E9iZ+s8PAeZjCbzD49MOn8PlLAkZgX1bmZN3sglXhANmd26Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769639605; c=relaxed/simple;
	bh=/tBnQTjEep2ws12SiZlf0MTyXA2SNfUMQKmSH5r54mQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=baSTNf4mSUokOiIBFIxKg3PH6bMSyDxOd8dQ7zE3OHSvOMiDdTjK+3vMb11bBWj/VDQegByv69jnDdoxvgGu0M44mpYx9FUHbqJwkzo0A8NeBX8V7d1gmK+7dnMaTL4cspDP4j0Obb6bNSSrkRwFbMuNXBMKj1RHRR9FiKDQgec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DjOcwbZ3; arc=none smtp.client-ip=209.85.219.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f66.google.com with SMTP id 6a1803df08f44-8946a794e4fso4648226d6.2
        for <linux-pm@vger.kernel.org>; Wed, 28 Jan 2026 14:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769639603; x=1770244403; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Twb2Mn6eFSbnhF2U8WEvYnbtdTbNFMWzq+PnSQfsHzM=;
        b=DjOcwbZ35dEqtdcnY2MIvRdP1i9OAzh6+Z1ZJwQ3XhNaOp/Ffg5JRiTxZNN+NhAhjj
         KEjaPm2XYakS7uGazCodEtZ4xqNmhMFXZBeQ3Cs/JcXmjBGGU7sBOevn+2Fe8tQf+6ZR
         xnCpyf2UUxNh1yM+8dhGzTg8NllaU56nfC7WQu3o+rlbS8uodl6EuwTySI64B/5O55ML
         j2euDpqriIjufIbjB21N/Zun7tCDWHpPG+ncllnnoegS4/gIGkyLFt9mNkZFBtIjqrH0
         b+z2hwuAcombqyeH8NIbAKUVB8Q+Igr28VGWzlRchoLImoI9Co86q7UouwaS8eZCHYij
         2yOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769639603; x=1770244403;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Twb2Mn6eFSbnhF2U8WEvYnbtdTbNFMWzq+PnSQfsHzM=;
        b=peuW4IEjvSN6kpqfEi4Yn1r7Em6P54aNFfGzDCT8j/+QCS9AhBRvKhU4wBtp7jAAt+
         Dzfs60DGoYgkPkuVWqdIZIPbmMLHD/nyB/QQt074pY4+ZD7QrHhpj7LoE9Z+E+/5cBAq
         DHHkSzyLFpxdFE0JChn/7h3P2WExkBo5q5BP3ING/6oh466w/LbTVQcN0fvtzPMra/76
         kY/H0W5YvIKgOGG5S6C/enK4SO4f+H1CX6W9qPpwqWZCjiVJ767FuQsx1H6AN6xeTABB
         RkwO8/VwOHajwAtx1joML67n61Pss2PInzYLdGVMC/SmM0o8+HBmUuT1pbXywoyiTLXE
         3MMA==
X-Gm-Message-State: AOJu0YxplwFK1Kbf1GDTgSXsEbj2FQRnklTsOu2Z2L3oQ/qjEtKUxFTE
	c6p7Ck7dEizk9GoLgBhhb5XHbulKFSBEFc9lY21e4CeKuLMO8Ga6DyWO
X-Gm-Gg: AZuq6aKoY4CFwquCrUHtskwMuh0opU6KIBIV19RmnMGFSbBozG4H4xxXJrOjytDCBiV
	YnQrTdJqaFrmeSpoLar2vd0TGMsnnVJ7NfSrMqnA1IHN1zyQiS2zhD01QXTHAU52j0W5HWDDDbm
	4qfsHFmGTZ6WczwxvpmuSYkbxviI2JdXRW1lkXRvCmJclALfAYujRKnBPDXxrvJAO+dWFSjDEv2
	AOez7cpiwg+s63rLss7ypAM4jbLGG95HBnZHe4Gz78PpfwuV7Ep+FT7BVG37vV6CUuINPzC6oR8
	LtRMSoyP6eIlg/55IxrOOOkxg0n0zFsD4YC8O62qrsdkvkTcPQm6M63H+HHiWH3meT9wJfcsVlH
	KTeIcjBHA6rhzhRthK5eA9nvsWBrdG4pLdeTG0+DeHCN1GwJ1YeBYlpL5uMAXLcoxIyJvEhJA1A
	sE8qV5PndWyo06CoS14nvzv8P7fh3qSOg=
X-Received: by 2002:a05:6214:2a8b:b0:88f:ca79:844a with SMTP id 6a1803df08f44-894cc910231mr107230816d6.48.1769639602822;
        Wed, 28 Jan 2026 14:33:22 -0800 (PST)
Received: from [127.0.0.1] ([154.7.78.65])
        by smtp.googlemail.com with ESMTPSA id af79cd13be357-8c711b95e4esm304528085a.15.2026.01.28.14.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 14:33:22 -0800 (PST)
From: Patrick Little <plittle@gmail.com>
Date: Wed, 28 Jan 2026 16:33:12 -0600
Subject: [PATCH 2/2] Documentation: Fix bug in example code snippet
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260128-documentation-fix-grammar-v1-2-39238dc471f9@gmail.com>
References: <20260128-documentation-fix-grammar-v1-0-39238dc471f9@gmail.com>
In-Reply-To: <20260128-documentation-fix-grammar-v1-0-39238dc471f9@gmail.com>
To: Joseph Kogut <joseph.kogut@gmail.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Patrick Little <plittle@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1104; i=plittle@gmail.com;
 h=from:subject:message-id; bh=/tBnQTjEep2ws12SiZlf0MTyXA2SNfUMQKmSH5r54mQ=;
 b=owGbwMvMwCW2/Ptzn70V3ucZT6slMWRW9a3bV+92Sdl4Zklt+tuss3xGD3W8vQ5f/BoSfL65z
 vZt+m2RjlIWBjEuBlkxRZadbmKFWc7Tc2d6rZ4EM4eVCWQIAxenAEwk9w4jw0mBK7lfOjqbVW3V
 532VO9Au1sed1fOjh181cKad/NWt8gz/403qhaeZn/pw+fa+7Njl99sTP+r2fHl0PHud8UTehTN
 MeAE=
X-Developer-Key: i=plittle@gmail.com; a=openpgp;
 fpr=B94616716A43976D994AAB92A7F7E74CBD784BCF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-41653-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,arm.com,kernel.org,lwn.net];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[plittle@gmail.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: E7BDFA99C2
X-Rspamd-Action: no action

A semicolon was mistakenly placed at the end of 'if' statements.
If example is copied as-is, it would lead to the subsequent return
being executed unconditionally, which is incorrect, and the rest of the
function would never be reached.

Signed-off-by: Patrick Little <plittle@gmail.com>
---
 Documentation/power/energy-model.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/power/energy-model.rst b/Documentation/power/energy-model.rst
index 65133187f2ad..0d4644d72767 100644
--- a/Documentation/power/energy-model.rst
+++ b/Documentation/power/energy-model.rst
@@ -308,12 +308,12 @@ EM framework::
   05
   06		/* Use the 'foo' protocol to ceil the frequency */
   07		freq = foo_get_freq_ceil(dev, *KHz);
-  08		if (freq < 0);
+  08		if (freq < 0)
   09			return freq;
   10
   11		/* Estimate the power cost for the dev at the relevant freq. */
   12		power = foo_estimate_power(dev, freq);
-  13		if (power < 0);
+  13		if (power < 0)
   14			return power;
   15
   16		/* Return the values to the EM framework */

-- 
2.51.0


