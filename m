Return-Path: <linux-pm+bounces-43567-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBOOGy0GqGmEnQAAu9opvQ
	(envelope-from <linux-pm+bounces-43567-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 11:15:09 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7332D1FE28D
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 11:15:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5FE4F30095DA
	for <lists+linux-pm@lfdr.de>; Wed,  4 Mar 2026 10:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF393368A9;
	Wed,  4 Mar 2026 10:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SKSDuzq5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99EAC398911
	for <linux-pm@vger.kernel.org>; Wed,  4 Mar 2026 10:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772619304; cv=none; b=KkBJnUsj8ziUZSBBMOPykxUkL2qT/pkXUr+irpeCCm4j1/HEqlMyHwnPvc6jeo1Zh5ypoJFsCeTcpGkcH3i76OPVol32YrxU7CCNbNgkVbqIl9lEQtakyP6KAVtC0yiBr++0Q1ja3j+xSo6/uiUR7VmYGf3g4dPNs8DHea7NRuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772619304; c=relaxed/simple;
	bh=4sTqdoVtxIVe8ztceUvqH0vr1KFn6QFMvGvuTz1nYbE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GnDZO8mB5y7A6m27rPSTQwIBOJk0EESlmm1WMqTlCI7vyoZ6gpGlkVcWQYah7pUTefvcBvEEtJa3r/T1+wuKI8Qr+nDoakp9QZC0yYpKEqGNU4lrLhOt2cFDgD1pue/sNrS1NtfmGUnE3MhoUoK6qsPKpKWkG/aLnbgH1qiqGqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SKSDuzq5; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-38704f70ea3so118823431fa.2
        for <linux-pm@vger.kernel.org>; Wed, 04 Mar 2026 02:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772619301; x=1773224101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uakOWlLezjhnuaH8mro0N46VAkqU0tG4gdp3L9C60EM=;
        b=SKSDuzq5A99wgShriuzSOKF7MOHP2JfW+P0pQ1xp/1G51B8PRgUv4htuTeDxdk7ZI6
         GDBEdAo0WSjojMp9n9iqRKKfp/Y6z7Rxs6yj4EKTlFdOAg8hrY9CF3xbbgAw/R9YsKhf
         0BO5gQ3WDYQIoHzZGuLRtwAj7VjX810ofrCCbkDRfdfyKIfZkGCGtjdhxB6vhQ1927+X
         24+BGixe0zTpccimYVebOHUOyVyGRVfcVBkDshJRMYm5xy7OUwHzS8hVEwugUneqAUm8
         x7OAbN0d9gFHQK/W0IwGxrKDFsSRPSqdIcVUa21uJv0K4s04BtfVxo508lv3/kSaoKZ/
         UdYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772619301; x=1773224101;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uakOWlLezjhnuaH8mro0N46VAkqU0tG4gdp3L9C60EM=;
        b=ZwIFCHAqN1tuMr9jxU5jWowWBskOnMvDyNYlAKZwbHMDFujk5XHeUjebSxKraZXqWJ
         HGWRVaEkay92GRgJ0ZBDga3eTjp5HiyMdbR7SqyKmqY2+uPuqUuB7SSt4VEBYmJaDuhK
         IIu4T/jQxo1S6Ze6uHE9+MFOhSlPV4obJSsWWxCDlHFwxcI3CxyoiIt8layoal16z+9O
         nRcA5ZkG53kpiJVdxpy65iD+uN7ztGg135QPyMiQvJlwrMHqfMEgxnWu1OQub7/ty/Xw
         eThar32BsE/EPWOhWIsRjLr++f4DQHlV6wby2qxy8vJ7G3pb+JSwi0Sw6jQ7OZDkrOlY
         WGBg==
X-Forwarded-Encrypted: i=1; AJvYcCUBsHZo/7bUdwxjvx9ptTaAb2305aj6N7MS2rMF9UFMtisT2R8s9lhWBDoErQKDRl649s2rDmaQmA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7sKIDit3cEf9OCcfZReyhCbfm5+QLBdjYkAuA6qnHS+50xszK
	lnf3QbhCydjqsQD+vZXMJulvRh27eFxYSFYwujHZhJ9oHTmnsdnQeKSsqUdK2Up7kf4=
X-Gm-Gg: ATEYQzx8aW+utum3JlHIf+CGhkgCAAfo2Sv014pQF6ogstbtlDfVSNkNDIddcokJ+Pe
	yVMQIWhUGSH1kFMSNlWVT7VitHRm4tVUPEczFYEn6Iep7fw/nxvE0D89tAOoiguqzv1Cynb7NrO
	KtTMOhpSu8iW4Zp2jXoV8CUJgqd+i2SCosf3DOjsHVsr5d7K2fNlb52VgspZSIihGUMHUnA401p
	TMDmgD51opNljWJZSgvbC4Gh9zFMj/j79eUnXb7x6H7HG74UW91+C66EbdOvt5keGNvDFmKF5cX
	/GMPIpQaPyziBVjCTgBfDn6liSd9tNoG3h0A/Tuv63lp6WcqJXtFNUrYgk8mvPsZEIstxgfyOoe
	byWtC0M/KneBesLIZY+k5g4mBzuurx5tocEE77iMrlD/RfNx+j0dXTz3Tl/i5S8ZDLNj/ZiDGTL
	PFPb9OfbrqF/6whBLlIOssg6pWPVcD1M+0ZB39gL9XdlYT6JiFOewOFpHkkvUsfrSSwaRCe/4m
X-Received: by 2002:a05:651c:1509:b0:386:91a1:f1f2 with SMTP id 38308e7fff4ca-38a2c55fac0mr11929111fa.7.1772619300617;
        Wed, 04 Mar 2026 02:15:00 -0800 (PST)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a123573db0sm1200985e87.67.2026.03.04.02.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 02:15:00 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-pm@vger.kernel.org,
	arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] pmdomain: arm: Add print after a successful probe for SCMI power domains
Date: Wed,  4 Mar 2026 11:14:57 +0100
Message-ID: <20260304101457.7470-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7332D1FE28D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linaro.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43567-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ulf.hansson@linaro.org,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linaro.org:dkim,linaro.org:email,linaro.org:mid]
X-Rspamd-Action: no action

It can be discussed how useful a print is after a successful probe. In the
SCMI power domain case it's seems valuable, as it let us inform about the
number of initialized power domains too, which is fetched from firmware.

Therefore, let's add a print about this, which also aligns with the
behaviour of the SCMI perf domain driver.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/pmdomain/arm/scmi_pm_domain.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pmdomain/arm/scmi_pm_domain.c b/drivers/pmdomain/arm/scmi_pm_domain.c
index b5e2ffd5ea64..5454faed7d5d 100644
--- a/drivers/pmdomain/arm/scmi_pm_domain.c
+++ b/drivers/pmdomain/arm/scmi_pm_domain.c
@@ -113,6 +113,7 @@ static int scmi_pm_domain_probe(struct scmi_device *sdev)
 		goto err_rm_genpds;
 
 	dev_set_drvdata(dev, scmi_pd_data);
+	dev_info(dev, "Initialized %d power domains", num_domains);
 
 	return 0;
 err_rm_genpds:
-- 
2.43.0


