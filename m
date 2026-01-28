Return-Path: <linux-pm+bounces-41651-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yIgsGc+Oeml+7wEAu9opvQ
	(envelope-from <linux-pm+bounces-41651-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 23:33:51 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C08EFA996B
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 23:33:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8AD4530276B6
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 22:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8312344046;
	Wed, 28 Jan 2026 22:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y0A1RO+N"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qk1-f194.google.com (mail-qk1-f194.google.com [209.85.222.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D976283CBF
	for <linux-pm@vger.kernel.org>; Wed, 28 Jan 2026 22:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769639602; cv=none; b=rveM5e/I056YEMmX5dp4TTGvkHoDuejK7e+eoCZsX8d2pztGe2xtlOO2QlfpFjSIWLWJypd9m1N6F2u8qw2jl6MZ2LBsopvat33jHOl0zi7w270wG/NuU0dbY8kxZftO9rMCtmgQJv3KAzMxpdZTB9GyJgggXDdpECN1NM2exKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769639602; c=relaxed/simple;
	bh=W0dpzkY31LWTDwRu4wDVYre+5cqJ/knXQKg0SbghrOs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Aq1U11SdmLKiUynTxy/PkEG1zSpod5yFQNyivpmCqchePE0/jUbWFetUgQkxXY3uBIEP93S5A2PJVMV1FtA4uT0t9yCfNKsgs8VY3r4WhwSIBMNRZPB423mT4oe6IHamq+gjK/8Rfefhrwr7rcl5JaafEQTpxJFxfMwbszfqYsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y0A1RO+N; arc=none smtp.client-ip=209.85.222.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f194.google.com with SMTP id af79cd13be357-8c533228383so26358185a.3
        for <linux-pm@vger.kernel.org>; Wed, 28 Jan 2026 14:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769639600; x=1770244400; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oThOkEs4Bt35iidNFvfsXAeU6jJXTeE+JreK8ol4aUk=;
        b=Y0A1RO+NwdBp5AD9YbXYbshQ6/ZpOfg1n8wyvNsiucbA9KNv8mPMlXgoNVovuGPd/S
         2+u9eNVxER3RNDcvDeC+INb1Ahe+3MFP09qyxylnKA3gRJhL3nPuMhuMdmlDYHIG2ydx
         +/k3WLkgfPTRY/ueW8w3afksohC2Fni/WXghXJQkF6Dehz8jN5ijFQMaZ2hHn0aZr1Xp
         7i6AhKWH6xmH6SLPYNgFT9zP5LirCeJebqvQ5fKdPXE2yt6+mSMYTu1HBRZ3Cdlx5AaL
         7LjKEURmATu5oSaIKpKWrn4hB1vngTcpOjbWv0gSYQdzHzDFE5xzOnMs4q2tgT1L1uFw
         WMXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769639600; x=1770244400;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oThOkEs4Bt35iidNFvfsXAeU6jJXTeE+JreK8ol4aUk=;
        b=wR1DdIZqDuG2AOrtQH48SpX4bMrn6A0gDPzwJv9fMWF6Qh8uNFGU6CL9ZiDO6WmBed
         vQPZu2obvqB7WvEzym2oQm7fywxNJ4Y2D0h1HyjY5+c8OzXddG/iT03iARasl++nDtYZ
         OG6riGQ6aj957vGrdwuIMe7ea7W8g/39AXu3g8Wcky6qR3uAsDhFwzWFYwk3sWjBZkXt
         ncT9YRuh88mr0bD/04Vo8NFB5mIL7YxQyweE98C5iIa8lbauIPUlycBgU9q0KCeWBZ29
         li7ORN3DcY9zeJyT76onLOrMolPZ+kyz7JpKLDDI8GdVcvALmscWK+LLPA6AktlGXfrY
         YlAw==
X-Gm-Message-State: AOJu0YzZGLoqi3Y+PJJFvVlOG7ELRMc14x2aMmooF5XAzqt7oo8HZl5M
	hYklfCrGQa3L23aRlsJqkNuK7FqGKFw2b8YToiyGNQyu4zf3eZ87s0eR
X-Gm-Gg: AZuq6aL+5020paeWZCclzZA5mhCbHziZZFYHe+n6Tw6bxykB9ZAt520nyE9JB4VO8yk
	ooNEA4VIiYRbDNMujd1ek5V388RJOTXV8fpsBq2x7Br66SVvcXpSyjAaA9zK/Oc2MfCzcVTm7JA
	JsV/h3oawC+3gZK2BcxS5+NB3d1Nfy3syiTcVfDicDp+FJISQKcnJ8bSzwCDCclJRuD8gR8YgHH
	66qnnZC7FIxEl15bLQzy6RmZ2rGsSTdSwXYrhHIEUUJ0l0wicZPnZjeRG7n+eu1jF5wCdsaa0rx
	wK6SdSYsIoDSXu+6BtxIAvET90uPxHSR+aWUGFn25EEw9vodRsusb7y/PP/q9sNDrpcOT8Zn7tN
	kaDNf1iZp1EI7MK/dUWx1bIu/C3Dc84DQxFEuDRoDUa1QCViSywoN9TdsAcx7T/vmooJz9ntCkg
	RnrBeacT73Hdb6lysrKMpe
X-Received: by 2002:a05:620a:408c:b0:8c0:e5ac:af12 with SMTP id af79cd13be357-8c70b856874mr825295385a.5.1769639600127;
        Wed, 28 Jan 2026 14:33:20 -0800 (PST)
Received: from [127.0.0.1] ([154.7.78.65])
        by smtp.googlemail.com with ESMTPSA id af79cd13be357-8c711b95e4esm304528085a.15.2026.01.28.14.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 14:33:19 -0800 (PST)
From: Patrick Little <plittle@gmail.com>
Subject: [PATCH 0/2] Fix grammar and example code in Documentation.
Date: Wed, 28 Jan 2026 16:33:10 -0600
Message-Id: <20260128-documentation-fix-grammar-v1-0-39238dc471f9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MQQqEMAxFryJZT6CtKOJVBhfBpppF65DqIIh3N
 7h8/PffBZVVuMLYXKD8lypbMfCfBuaVysIo0RiCC73zYcC4zUfmstNuJiY5cVHKmRTbFIaOkne
 pi2D/n7LNb/s73fcDn3/wSWsAAAA=
X-Change-ID: 20260128-documentation-fix-grammar-3f285af10f5d
To: Joseph Kogut <joseph.kogut@gmail.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Patrick Little <plittle@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=669; i=plittle@gmail.com;
 h=from:subject:message-id; bh=W0dpzkY31LWTDwRu4wDVYre+5cqJ/knXQKg0SbghrOs=;
 b=owGbwMvMwCW2/Ptzn70V3ucZT6slMWRW9a0qOSatYFTx4M78Zd6LdY5bMvH2zMnK5VeJjt3Sa
 XlaMnJ6RykLgxgXg6yYIstON7HCLOfpuTO9Vk+CmcPKBDKEgYtTACYS+ojhryznt8M3NkZc+mPT
 9YFjRcj7KLGaBpdNOQmX5n1vPfDT9Bcjw8RcNdN0n2uTeTWZLi3083oS4PjgSJDTjPNCXTHnTvg
 d4gUA
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
	TAGGED_FROM(0.00)[bounces-41651-lists,linux-pm=lfdr.de];
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
X-Rspamd-Queue-Id: C08EFA996B
X-Rspamd-Action: no action

I split these into:
  Text updates
  Example code updates

If it would be better split more or differently, I'm happy to do that.
These are strictly typo fixes, no clarification or rewording.

---
Patrick Little (2):
      Documentation: Fix typos
      Documentation: Fix bug in example code snippet

 Documentation/power/energy-model.rst     | 18 +++++++++---------
 Documentation/scheduler/sched-energy.rst |  8 ++++----
 2 files changed, 13 insertions(+), 13 deletions(-)
---
base-commit: 63804fed149a6750ffd28610c5c1c98cce6bd377
change-id: 20260128-documentation-fix-grammar-3f285af10f5d

Best regards,
-- 
Patrick Little <plittle@gmail.com>


