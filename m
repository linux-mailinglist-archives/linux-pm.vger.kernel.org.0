Return-Path: <linux-pm+bounces-42383-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OP41B0+VimmuMAAAu9opvQ
	(envelope-from <linux-pm+bounces-42383-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 03:17:51 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D2AA911639C
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 03:17:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9C77B302BDD5
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 02:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C972D3ECF;
	Tue, 10 Feb 2026 02:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f3mFHdyO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF332BD597
	for <linux-pm@vger.kernel.org>; Tue, 10 Feb 2026 02:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770689869; cv=none; b=Kk/29uM+yrQL7buLHlIEM0GUEvfQRLPjYapxT+wK3Hjew8c+IvimY5nfk4YqMxCSsNPCdW8mfDSwKW9mDCJOAOSrgiKnOtn5pBltmQDI47Ygf//RXoea8fnnE8OGuhynJ1WJU7EOyTz7eOSJE+NjrOduVPF59yIxBM2bKr50qxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770689869; c=relaxed/simple;
	bh=q0l/IFdNUOrbgH5VkX+Ntm6uWvWVBaEQ5fVCuOy9WmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ILVdL7UDnTQ7ztwdok2/L5HdjDVL6xCmIq2GIBvzs6wnw2DN14vRdnV2eaXy9ga6ba6VazRPWjnOFTQoHWd6CRtqBuI1fSoofRgRhYVugEOShkepeC84LviDXkc9Eyxdf/ucLtWHtUNGdeMtVkO4ya53+QIBdvuQJ7AumShntY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f3mFHdyO; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-896ff127650so26837336d6.3
        for <linux-pm@vger.kernel.org>; Mon, 09 Feb 2026 18:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770689867; x=1771294667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lZ0SptXf6V+p9mpcL89pKBpX2aGQtF7sm9wlbyJP5XY=;
        b=f3mFHdyOOTX9l9hFJ/WfUYZmf2ThZDC4Ljjki+eX6iZSNrCj49rd6+dDcWN06X5E16
         xYaIaGr1mDSYxf/iiZPlXuch0+MhFH4C3sMfB8/o9EGn1BT2W/YUldXbaD0fLiQkrKEN
         iki01gm05xo+FmncOA1BAiM9kHtHZDurOCsWmm0CWN/dFDojKBQ4gVE8jk2tx+fqNqvM
         HtkDGoiDr+W4oeL3e5D1eVSehw/q3+A68k1EBR7IQfGoF6TEwLp5JXs92MJv+2enwF1d
         46m86gb3OdWHw34SkqrT2V2AupHx0S2D3ORvuN4MfxSq5B7buNXmMBjtGEj2a9Iofhlw
         ZFbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770689867; x=1771294667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lZ0SptXf6V+p9mpcL89pKBpX2aGQtF7sm9wlbyJP5XY=;
        b=NfJnRWRQM7IHuP3gl8rnJhEDRNKLa9lo+SRTpLqwibSb4Ma/UwWg4j8aGlIOwinhg4
         kPNYj3JY7x1HcdvWTwbdLjMYWqsxsHP6Nq9eS76tdI8tdJTjd7dxB1cNEhiqN/4ZTkIE
         ORS85vTE3iUijDAyod9+COct/hrPxTt/n0x6AlqJbnWjycv4DzLlCjcPO1St1jMJJ2Z3
         XNf9rAfIWRwjnbdqUNEpkwZto3F4ZTHxndXumYoABiZCl+zofDJ+lvFos+mvOBtZjBd1
         tIi4f3prcEfTg368ppYEABEBZ4IPRU6BRBhyMVFvrjqdQ6kClCgKaEKze2eDMxeaROCl
         a1/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUr2iMxwP5H6ffBpr3WK3DzhpeNSU3bDw/M1Lj5KDKVzDwVC7a/gAKxVKTIRwET5iezUv+hQW92cQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyoJju2OWA0kdvsnxtPe6vvmkTeFdEAhmDv8RCt/GEaNdWLTaGq
	p/ckhUHGixwVZ1zoiLB1X/CJLISdUWDssiXivS45D3GiLxtsXec0ho/E
X-Gm-Gg: AZuq6aJ127F4NLl0UVj5qxfL63s+Z+VV2IAQMM8j0KVOIXgAYTMwUslpTlbRIlVdbY9
	NpOOwzL5KbFW9dtvcLwCQ6yV7oWYOzxZlE5v+yrLlaQLlSEc3moNjSLcD5k7wRwqC5BERi1dpa5
	SWEPMlb/cRVyTBs+dGhRORh2+RSwUMVdbbzRC55ipNx8E4dqkSB4JozAzRqC2I20uQtp31nf7zX
	r61ivmA6pyHCqFcL2ihBS2GBPycd8qZ5Dd/KZXiEeYY7GuDUo6Bbrbpm84rSG3kBHtRpUxhKpfd
	vAongkwZewg6rrXdKdUQBy7KJwcJUziM8+RrGokd3OI+T18u4v7SxSRYSQ6Ql5ju8iElSKhCJOd
	VbcRNfaP31z5BjT6eObsctOVMNYK+xKpyixH3UHr2QiBkPxiCqvzi8XWvBwItyBo2UPLqXNtmsc
	RhMkiPKAMmId3OlbaXA6EOOSHQJxbessaU6M3av0cj7mh52nZegZkyKLWYiWLz8KHhp2CqQJ4FX
	xTfgNgOrHRgxEk=
X-Received: by 2002:a05:6214:e66:b0:895:635:c00e with SMTP id 6a1803df08f44-8953cb80e8fmr203705356d6.45.1770689867064;
        Mon, 09 Feb 2026 18:17:47 -0800 (PST)
Received: from localhost (bras-base-toroon21-grc-75-184-144-58-243.dsl.bell.ca. [184.144.58.243])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8963ac2ab29sm57519146d6.3.2026.02.09.18.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 18:17:46 -0800 (PST)
From: Richard Acayan <mailingradian@gmail.com>
To: Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Amit Kucheria <amitk@kernel.org>,
	Thara Gopinath <thara.gopinath@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Dmitry Baryshkov <lumag@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org
Cc: Richard Acayan <mailingradian@gmail.com>
Subject: [PATCH 2/3] thermal: qcom-spmi-adc-tm5: Correct the voltage-code scaling for HC
Date: Mon,  9 Feb 2026 21:18:18 -0500
Message-ID: <20260210021819.12673-3-mailingradian@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260210021819.12673-1-mailingradian@gmail.com>
References: <20260210021819.12673-1-mailingradian@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42383-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,linaro.org,intel.com,arm.com,vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mailingradian@gmail.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D2AA911639C
X-Rspamd-Action: no action

When support was added for the HC variant, the full_scale_code_volt
value was copied from the tm5 variant. From the downstream kernel, the
scaling value is 0x70e4 on PMI632 (tm5 variant), but it is 0x4000 on
PM660 and PM8998 (HC variant). Correct the ADC code to voltage
scaling factor for the HC variant.

Fixes: f6c83676c6097 ("thermal/drivers/qcom/spmi-adc-tm5: Add support for HC variant")
Signed-off-by: Richard Acayan <mailingradian@gmail.com>
---
 drivers/thermal/qcom/qcom-spmi-adc-tm5.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
index d7f2e6ca92c2..6ccd02fe0e4c 100644
--- a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
+++ b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
@@ -909,7 +909,7 @@ static const struct adc_tm5_data adc_tm5_data_pmic = {
 };
 
 static const struct adc_tm5_data adc_tm_hc_data_pmic = {
-	.full_scale_code_volt = 0x70e4,
+	.full_scale_code_volt = 0x4000,
 	.decimation = (unsigned int []) { 256, 512, 1024 },
 	.hw_settle = (unsigned int []) { 0, 100, 200, 300, 400, 500, 600, 700,
 					 1000, 2000, 4000, 6000, 8000, 10000 },
-- 
2.53.0


