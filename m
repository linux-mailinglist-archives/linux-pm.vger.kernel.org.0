Return-Path: <linux-pm+bounces-43487-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EIhzOtTgpmkPYQAAu9opvQ
	(envelope-from <linux-pm+bounces-43487-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 03 Mar 2026 14:23:32 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C421F01EE
	for <lists+linux-pm@lfdr.de>; Tue, 03 Mar 2026 14:23:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B806F3077CF5
	for <lists+linux-pm@lfdr.de>; Tue,  3 Mar 2026 13:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3E9423A8E;
	Tue,  3 Mar 2026 13:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wBR5y2LS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B85200110
	for <linux-pm@vger.kernel.org>; Tue,  3 Mar 2026 13:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772544208; cv=none; b=VazS3bHb761KTGqWv4rdlax4oRwlYIyMH+QuORbAs04f9NJKYNnemV3Hau3o6SJ73g7odh8rY3VZ1xkYLJfj+Dph75wwPiHyqDGla0XsNLUqjOv1gBGAjPMYx1e5wg6iD8DdoVgFxpp9lVOpwlCSyhlU7ChCNfKfpxlrqn+mAks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772544208; c=relaxed/simple;
	bh=V7v+r1QYUPnNR6nJDxstY6mnjNsM8LyYyLc+S3vImmM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FMhb59DIj8BEbw5kvL+8YJX+JWktpXLUYCmw5z84ixVyjTPNylEe4g4u9rznghb8w/qKnmAEKy4WWz9IYh+yehdkXiDzaRxziy/6/G96boH06pkhFTSJpxTz4WBto4nkrOhVoiqn/SAByFTW1eylrF2M6WpVFA4FX8TW8mOlcXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wBR5y2LS; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-389fa352b0eso83821181fa.1
        for <linux-pm@vger.kernel.org>; Tue, 03 Mar 2026 05:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772544205; x=1773149005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H74/YoTLDFTCdfk0PaElicwo3G9NiezT55+TiFByfrU=;
        b=wBR5y2LSh/VOsfSXe0hkYwCEPEEfU72pSMzYR658fvMmTrN2IleVJ0/6CYL+QYAplc
         +S7MLpxe1a1MyHbDY1rmVLt47YWOAusbvcWHLptwUAyyrDsXHdVwkov8iPT5t+1w8A3m
         2WSudkPZSfLcERq4ALe4ChbCGMukAFakoZu/5vSR2JeBkIEtaKbMEgJaW7oUU9uLWMHm
         1t7Vvd6AeFXNwH0qBfgFGuL/dW7QZipFtRa7CBRd1ousm5oo3RsUCmy89ee04XXhxJzl
         HILHBvbLEpU0s4gBT27Lp6+NtvSyju0ibtuwzH0nAKxpNBWQBMPEs0O1PnR8nt8jFA7S
         niVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772544205; x=1773149005;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H74/YoTLDFTCdfk0PaElicwo3G9NiezT55+TiFByfrU=;
        b=wfisxosUqX7STTkOuRb4Y0prIyoCJp8etKdIQVM99qXDohO2MXsFou9vOhuTMhBmot
         UX8EvZKtrz6csBTbIfT7JLYhGrK1zQONVdcIXqOpA7EckeLt3xz+Bv1S5lE2A2TOrrjk
         nWF2WP94IrOxsNy+6nGeC7UMRC7T65WIcxZl7j8TM/pjS/3M60vxsCqpCoJj/iFHhM4B
         nZp7fLOJTMu1rVM9Ea+3Ry3KHWxMF4B4jeQLrq1caQyzvmcw1+braW1hUyuAgzktGM8t
         9fyWausRtgDT5v99cgrhMlIpddKAE7c9ZHZAUzdW+8zGFYGy6TqCXEPCGbdrK2Q+xdXm
         wKJA==
X-Forwarded-Encrypted: i=1; AJvYcCVc/LmziIOJ31Mee+i3U7cZCyiL+OJQ4/5lV2AbuYNBae7pxl+HUh99vIrDdy8nLKAecM2da5a9QA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+xaEjQMNuInfEDOArfQZIeDeq0rr5l0sE4ICjVgT1w/vQmS8T
	uCrko0rLdaK32GKFFe8UKn1Lj3stzBpA5kG7q9chlynL8IoZlc75vUuY/7w3ZDTAVuQ=
X-Gm-Gg: ATEYQzyFuLMqK4WZUTp4PQFSeoHGLAbnZ6Tqe+tIJ85CV8w4qd4cV8/h0qd9fGJ3VE5
	BJRFkLDohxw0BRGzNUnoyusxT6HNZE8ohidIC5t0ERXhBWYhE9ClEEJboDyIDgdLlZXF1pxrEKS
	WeoauVgi/C5MqAoctfmXVt0SGBHe0nljrXM6AfCJlYM2iBE5eKqoqy6grZ/CMdXBf4C34edbYnf
	KmLFZCTmuJzmHKb21JC2FUjiGeOHWNfCtovIj+ngxjMP2qrGePc3RzyZeqwY8Lcy1+QteFRgYve
	BmbpVn5EppAqdw0d6IsBLPF1exXpLMP+Y19flDghVIULiwwfYu18KR54Ez3lu3VWNTP04tOBjQ9
	99HUw4qU/MWdW8UHRwuovL6HTfo1glXI87XYYMvG1NaR77HzbPqDr5MDfAWAmcqo/7pH0zBoDe7
	1oKzLFhxlxAYPto47dXLSuyDo7PXBG0yWbKQrZQmSE42HTVDqUBk4OF4djS5AgGxTrAdcmaOIN
X-Received: by 2002:a05:651c:2123:b0:382:4d6b:993b with SMTP id 38308e7fff4ca-389ff365a4bmr120386311fa.35.1772544204835;
        Tue, 03 Mar 2026 05:23:24 -0800 (PST)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a1235811e3sm587866e87.29.2026.03.03.05.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 05:23:24 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Saravana Kannan <saravanak@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pm@vger.kernel.org
Cc: Kevin Hilman <khilman@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Abel Vesa <abel.vesa@oss.qualcomm.com>,
	Peng Fan <peng.fan@oss.nxp.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Maulik Shah <maulik.shah@oss.qualcomm.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/9] driver core / pmdomain: Add support for fined grained sync_state
Date: Tue,  3 Mar 2026 14:22:46 +0100
Message-ID: <20260303132305.438657-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 67C421F01EE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[baylibre.com,kernel.org,samsung.com,oss.qualcomm.com,oss.nxp.com,ideasonboard.com,gmail.com,nvidia.com,linux-m68k.org,linaro.org,lists.infradead.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-43487-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ulf.hansson@linaro.org,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pm];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linaro.org:dkim,linaro.org:mid]
X-Rspamd-Action: no action

Since the introduction [1] of the common sync_state support for pmdomains
(genpd), we have encountered a lot of various interesting problems. In most
cases the new behaviour of genpd triggered some weird platform specific bugs.

That said, in LPC in Tokyo me and Saravana hosted a session to walk through the
remaining limitations that we have found for genpd's sync state support. In
particular, we discussed the problems we have for the so-called onecell power
domain providers, where a single provider typically provides multiple
independent power domains, all with their own set of consumers.

In these cases, the generic sync_state mechanism with fw_devlink isn't fine
grained enough, as we end up waiting for all consumers for all power domains
before the ->sync_callback gets called for the supplier/provider. In other
words, we may end up keeping unused power domains powered-on, for no good
reasons.

The series intends to fix this problem. Please have a look at the commit
messages for more details.

Please help review and test!

Kind regards
Ulf Hansson

[1]
https://lore.kernel.org/all/20250701114733.636510-1-ulf.hansson@linaro.org/


Ulf Hansson (9):
  driver core: Enable suppliers to implement fine grained sync_state
    support
  driver core: Add dev_set_drv_queue_sync_state()
  pmdomain: core: Move genpd_get_from_provider()
  pmdomain: core: Add initial fine grained sync_state support
  pmdomain: core: Extend fine grained sync_state to more onecell
    providers
  pmdomain: core: Export a common function for ->queue_sync_state()
  pmdomain: renesas: rcar-gen4-sysc: Drop GENPD_FLAG_NO_STAY_ON
  pmdomain: renesas: rcar-sysc: Drop GENPD_FLAG_NO_STAY_ON
  pmdomain: renesas: rmobile-sysc: Drop GENPD_FLAG_NO_STAY_ON

 drivers/base/core.c                       |   7 +-
 drivers/pmdomain/core.c                   | 208 ++++++++++++++++++----
 drivers/pmdomain/renesas/rcar-gen4-sysc.c |   1 -
 drivers/pmdomain/renesas/rcar-sysc.c      |   1 -
 drivers/pmdomain/renesas/rmobile-sysc.c   |   3 +-
 include/linux/device.h                    |  12 ++
 include/linux/device/driver.h             |   7 +
 include/linux/pm_domain.h                 |   3 +
 8 files changed, 200 insertions(+), 42 deletions(-)

-- 
2.43.0


