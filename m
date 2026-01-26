Return-Path: <linux-pm+bounces-41500-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oOpyGxjUd2mFlwEAu9opvQ
	(envelope-from <linux-pm+bounces-41500-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jan 2026 21:52:40 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C58B78D529
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jan 2026 21:52:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 808F03026A93
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jan 2026 20:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8986283FC5;
	Mon, 26 Jan 2026 20:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cb2GuO1V"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDDD2D877B
	for <linux-pm@vger.kernel.org>; Mon, 26 Jan 2026 20:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769460583; cv=none; b=Vrly+/YJyPvB701+la97erY5Iu3Mij2wEz5Tej7pq6e2wplDchQiShxVNkuBpCZamVWiIrxEGRsPI8X9XT3Kvp7Zap5vqp41iANhnGy9ZUD2gb+3suAB2n9QsCN0QXqpZ5EVipvFO6lJG8VyONRXm7u/rDJRPCMwBr6dR2oPxwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769460583; c=relaxed/simple;
	bh=A6jn/yMvWVBB5veD5BMs8jFFmGnBj7lxblIDGmq5K94=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=roF03g3WH9AtgqmoKGdd4lmzFbNB6kEGHOQ/o2eAByCT6J7mcaIsyWYSGwApNOZ7nme0O0Qr4nFWys569D8glmNKwdAGsvnEklN3SRbU1rRhEk6e0gtDmthCH8KaT6sZs7OCuv/MQ29Zvn8dDxONRe6rg7+s2WC8KpGs4jZ/d4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cb2GuO1V; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-59dd9aef51eso5532648e87.2
        for <linux-pm@vger.kernel.org>; Mon, 26 Jan 2026 12:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769460580; x=1770065380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jxc9IQWx5I6gbjdfSuWld71CQkfV0DDDCIijMstKBuE=;
        b=cb2GuO1VeZGWxHJkteEKTDCs4ny/NClGRdaL2RJhipnvT8iDv8k6yiuKiNwvALyL51
         gJalw8dPVL/tkg59Jl69WOWB49CUJrNMVJ4ZWBf32ba/GgMnUS1Bkpn541pqV6ou7V8g
         eP8NwHkNA/zL/jieXislaXAGxIGXsNjHdIefNh5SyKsx8qXjcbZ7f8i6I4sJgYHd0dpe
         yYdHjajgwHSGMMVA+UTv60+FVVAjEZJ6cX4s7qyjtcUnliL4T9rYMCsJm1UTh4uucNQj
         LnVE5GQmudiCqmF1os/6swZULieoPXl7+eJvkdjKf6zqS2rpGvu92s5YdMG41ll/KBEm
         bWyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769460580; x=1770065380;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jxc9IQWx5I6gbjdfSuWld71CQkfV0DDDCIijMstKBuE=;
        b=m10pvNXECFddl1ov+POc3ETp1wHSEHeJ6jbkVUZD0hg88g2fk/D7fDACdNDvLw5iME
         Y+Q86FD4jdpWnBV29ljC7fsda7no9mkzELxBwLAnZJlTIJQHFqiSfg9Ro7JZgkIzkosQ
         /QBW0m9776ncPCTidrcfnZA4OppPZ7WAw3tfV2JZZjIvwMdB9khVcDPWgNXxaKK+tmId
         EKwx1YCtKn8jPD8gkRm+N6PZSbKxvDrtVNctldkOZTiPSkv2M+f3Fw/4+xJLpSA96Xxm
         W7Uo6mE4elIF9vlW6+WrWNIq02tqband2Di7uZeBg6M6JFPVat6D+OiC0S5joYaLyXBV
         RLvA==
X-Gm-Message-State: AOJu0Yz5dWG4T5/BI9nkGL/+XI0CbjC7fKpfD/WUTqt56GRvfRtZen9D
	gDMkkpaRaVs91FAt6pX1jLgCbcfTSCSvYuR9hF+dOE+3TvNd5KSaZgOA
X-Gm-Gg: AZuq6aLBuYtbPILcBJebApqn0PdE+eGekkkQU2w+Q0MrBlG0wEFdcTwthKIuB0Wtxq/
	LVc4Ewk5mz0/nnSo3a0aIKesdt+647sVWdUfL3rdwW1acA1xjGSpWDdBWMIkZW7aPtMkoAag/KA
	fwP6MycIj+wGUh9rxS4jlnc5qEuEfyXH6d48G1WVKjIBEi85D8ceg4TnrYUjg5sTRKyk98U8i0n
	fF68c3+Kcbq4qPkQTG7WxMJRBLMJiG15jH6/yUzvaNnpO9jQaIDdCNDA5M67YS8sE0FLxo7L0wB
	a8OW6zJrWp1iaaiHCeLTqZuRpSyymC6UN5BU0oKHpVx/kJB0pmG6D+4/yKxE6YsU7XdUEgKp3mY
	L4ns7giDrq42qo77MkRCfm2IUOSi6NR8SU6ZbAhVPwsh033oUAGU4aVyL9YAFjO6yCKMfY5m72A
	wo
X-Received: by 2002:a05:6000:4010:b0:435:b67d:c304 with SMTP id ffacd0b85a97d-435ca1ada2amr8949251f8f.38.1769453687028;
        Mon, 26 Jan 2026 10:54:47 -0800 (PST)
Received: from xeon ([188.163.112.49])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1f742d6sm31793947f8f.30.2026.01.26.10.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 10:54:46 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-pm@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/1] devfreq: tegra30-devfreq: add support for Tegra114
Date: Mon, 26 Jan 2026 20:54:22 +0200
Message-ID: <20260126185423.77786-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-41500-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,samsung.com,nvidia.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[clamor95@gmail.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-pm];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C58B78D529
X-Rspamd-Action: no action

Lets add Tegra114 support to activity monitor device as a preparation to
upcoming EMC controller support.

Part of previous patchset: https://lore.kernel.org/lkml/20251125120559.158860-1-clamor95@gmail.com/

Svyatoslav Ryhel (1):
  devfreq: tegra30-devfreq: add support for Tegra114

 drivers/devfreq/tegra30-devfreq.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

-- 
2.51.0


