Return-Path: <linux-pm+bounces-42378-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IBoqMsiUimmaMAAAu9opvQ
	(envelope-from <linux-pm+bounces-42378-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 03:15:36 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4891311633F
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 03:15:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E7A24302C34E
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 02:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B160F234984;
	Tue, 10 Feb 2026 02:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LI76BZnj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237EA72622
	for <linux-pm@vger.kernel.org>; Tue, 10 Feb 2026 02:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770689734; cv=none; b=AmOP2Yzx9I/AlloT5vMvkmhSCP/x7UHRBg0aKFKg3fDpat/KPZ1WFRlXXmkQk97f6tTQYIH54hiopU6CdwYL+Vted1UecT0TfccEkFcOjR9+REfPuxZyI/JplkZCBUaQO7U19jCvnD3h9+MIjWznpnb3eTea607F67QfhoeCKAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770689734; c=relaxed/simple;
	bh=PYF6GGpA4VC27CzUfRPvR54hVi4OMmubGDvWHm9sKZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dJA97FJm77vqh1k3iRLU01/6YgsDuL8XvdSVvOtwRR9qjdW2CRnANCdQF8mLyEbF6zv95ndrrPFZ/gJ6NrNaRxf3L/DQZuIrmxxYX1KRErZt0w0vsPpnW0GDn/ETsyUlg9vKplJD6gjJaPK3yJajZqvKd5YFxXHv7N6RoJ4IUd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LI76BZnj; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-896fb37d1f0so31394706d6.2
        for <linux-pm@vger.kernel.org>; Mon, 09 Feb 2026 18:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770689731; x=1771294531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ttADsLPyGnDD9HmF8NPbd2abaPuuxASj+uxqjOd6zVo=;
        b=LI76BZnjjygaa5tZDiWacQ2/TD5YYEXb/m34VS7Bmu6n9yM7/WITiIZM6hdzZ5gxlc
         jdnA+Wkp4mS2B9W+p+siQpisDR/4F4KNgmH1VblIIlrzdssSLgb6tO4ZTzCocw1mh3ZY
         a5HNGdY8eAp2PcDcI8vx/Yz+UBpkkEYDrkr3Z5oe4DCVR3n2aeEZT/VEIx5lJhwby6hn
         9w+aHGFrMKOeh8tWQ0uwTSkyyvkEKPgYwpwVLRgFIYN/Igebb4rxtZDvTfjZyWxib/ki
         jo3bQIAJy8G7FKNBtQzEPyKaizhbqODb6ulG+yj8xJFxILbltfz1dTwzqepoT6i6s0Kr
         dWpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770689731; x=1771294531;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ttADsLPyGnDD9HmF8NPbd2abaPuuxASj+uxqjOd6zVo=;
        b=NaL1qdoYWip2B/7Niwe8VifBB8jfejYN/W6Kf9vhRlYIkEA4+bbocXqNeBCu6JZ/ix
         p3T3sj04Js/Hvk99Vuq365WH6mpnAbSV7eCqcRSMykVh+izQh2Ke2NxHoY6ajNAE+OBT
         lCeU+t9iqMbLCLeiwAkMBdkCU0jdtCc4ej9S0h6jkekrAsJx6TcLt8gim1HbhO4BW2V1
         XjiGU2UDtyYhQgUQJfXBsIHiNZWeQzO+0RLfxpKbeQmYd0TGV35HRTJgqyuw/wWnt/pw
         +x0Y4YAesIY98xCTU5f37yfjo9x7ifYpIvGps8TUY140bOQossHvp0xnwkgHBbPawAZV
         sAJA==
X-Forwarded-Encrypted: i=1; AJvYcCX7X6HmYvQtEd8HZeKldpiTHob2DmqWFmcibyzZPvNDoNiKpfU9fzwY0x4Rf2L72G6r/yWrLRr5bQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwQKNQdyinftMFJvQrAPbROlFVoIwHYSkSr0DMjlwXRIqCPo2pg
	6OgxyYz3dqnVgwX/n/j4mYelPACfOE/c0YPj2HU8R+NEdFKtvY/dvfoa
X-Gm-Gg: AZuq6aIS11nEm1x3VCEO8WDVP0WWkBAreBEpiyKIp3vsFgVafsfy7p7I+jOGI4LWX9b
	mZ6msW40qqf3N+083OkUfdHmJYT8FHBVx20VJKZi1qNsQ3lGNaQhn2nWI+gtl2g6/xuNWehqw6Z
	/jB1+c5D3W5OEcqff0PZS5dbLMtBPSs5PKrA52nhwt8v2AyjfoAln817/fywdB6iO7EYSpcAibL
	2WCRVM0mlIHIsCOMJsoiNOUzkCh6YjQfPqnZdfa8CcoDXnc+YuX3YCsCSo8W/zNDsFGWvI+aW2a
	KsbEMKsEhfwW67YLmaPBskKuAQfPzF4q3GWgbnUVM6nyGnS59sj9bxuxCMetPEkSwuAF2fJ1f/V
	S/NtzQRzLztLSFaJBJIfnuoFvpeeD0Ot9fNNI90g2ivH/k4fFvOfqsH2DpuUR4TIIsLLE/7Q0+A
	nAKy8z1uISk+d3QfIvX0pgNT/OnpHli7so3nV4qn5U+sSL32/gCvhAxMqzG0dzR/DXcEvOdiEq8
	6KAlV1Oq58p6O4=
X-Received: by 2002:a05:6214:1243:b0:890:6331:7e88 with SMTP id 6a1803df08f44-8953cb97190mr213113396d6.44.1770689731173;
        Mon, 09 Feb 2026 18:15:31 -0800 (PST)
Received: from localhost (bras-base-toroon21-grc-75-184-144-58-243.dsl.bell.ca. [184.144.58.243])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8953bf3b6b2sm91521796d6.6.2026.02.09.18.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 18:15:30 -0800 (PST)
From: Richard Acayan <mailingradian@gmail.com>
To: Amit Kucheria <amitk@kernel.org>,
	Thara Gopinath <thara.gopinath@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: Richard Acayan <mailingradian@gmail.com>
Subject: [PATCH 0/2] SDM670 Basic SoC thermal zones
Date: Mon,  9 Feb 2026 21:16:05 -0500
Message-ID: <20260210021607.12576-1-mailingradian@gmail.com>
X-Mailer: git-send-email 2.53.0
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42378-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4891311633F
X-Rspamd-Action: no action

This adds support for the thermal sensor and for thermal-based CPU
throttling.

Richard Acayan (2):
  dt-bindings: thermal: tsens: add SDM670 compatible
  arm64: dts: qcom: sdm670: add thermal zones

 .../bindings/thermal/qcom-tsens.yaml          |   1 +
 arch/arm64/boot/dts/qcom/sdm670.dtsi          | 558 ++++++++++++++++++
 2 files changed, 559 insertions(+)

-- 
2.53.0


