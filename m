Return-Path: <linux-pm+bounces-43796-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yKmVEb+wqmluVQEAu9opvQ
	(envelope-from <linux-pm+bounces-43796-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 11:47:27 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E6F21F19B
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 11:47:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F15D3063637
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2026 10:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B4C37C91E;
	Fri,  6 Mar 2026 10:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n/Y7veE+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB3837BE8E
	for <linux-pm@vger.kernel.org>; Fri,  6 Mar 2026 10:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772793863; cv=none; b=YjN7ATm9Bt1OdBVfFADm6RB8RA3cRH9bjZ2h1e4bU2OW1qY8IepgocZ/sjEFWbGNoLy7nlfOFCUlL5VOMc+jbly/74Sv21H6DqDItL0TvtJyd535ODHHqScc78YK5ul4mlWZzXzFL/HtoV1MvuIInnXLhAoO/OQjNhqkq9AN8yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772793863; c=relaxed/simple;
	bh=nSmMKLwo52N4Oie4oGR6HFou9FP737YgnARYFzY2/Aw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tlJT5nc2sUK+gJesDYS/JSgtXSZK1sUD3wL1nsckPs6V9CrceOS0La2IVydjCvCZgkr2fQx67+ClY3bp3v1BqP0wxJQN92hHBTqd21C7kLaWQRvmxfa1HPIMZ0HSLY6gqxctHuxXFCB2lX+5TdsfkO5hdtV6X6f4jDYDnphTy00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=n/Y7veE+; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3878de20527so128103671fa.3
        for <linux-pm@vger.kernel.org>; Fri, 06 Mar 2026 02:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772793860; x=1773398660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7wc96x2Km5MRcB3LJal5Kw6RV2T1teZ1rXwvu8I4aDs=;
        b=n/Y7veE+xTbQ5tMOMwwEow/bfXmMIYrIbDJ4d9hqlKbwPSa3JqHGovcvQyd0Hk8Bpn
         unjekmwsb275aELyny5I1zlJ9bui4oHbxSRIaPpD3Ewdvvb6JRLXz7iYYTNj7WDzmVDN
         kCi6TKEDYZ0cWcW1YsFOoYSrcEoKqNH/+9cVH+5adgV59p1ATUfzGywONFx2iwUZ8Yzr
         9icKtpV5ROV6xOXBrVnIHg8xz/t1ADbhqCcdUhERt1UQIeOmokFq5PlYi7z3ldmnUWEj
         VVxwntse4zLGmp/xl/qqUFt1KtopvLs/XmsVEGCffodzcWCNqoEh4stF+gxwBNSn0dGE
         cf+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772793860; x=1773398660;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7wc96x2Km5MRcB3LJal5Kw6RV2T1teZ1rXwvu8I4aDs=;
        b=PQuZVvY0sgAxsKjFAtCN/Su/Ezho2VN9FHfAPjyMvCEctBr/zjV77p8AEI7IaMSC2i
         Y2uWfNav2SLrdoLdLChUtHv/oN/88iGOBF4CDe8weFJDqX/pJ6gAmzGhhFIvtkHwSEsO
         lBnflW8DoVyZZtUDda+P7vYRxeb8X4M76cnr8flPBGn7S1SXX+GuspDgrratvwHHVnWR
         9uNWuaF3K1eKPr0K/WTUleuwggx+vE00Wv5/XFHZApLJyT70GiZnoEK0vB8NNKltLVyO
         8g+wKW5as2EbC8MPDR40OXzXp4YR2YFdm1u5269mtWaGMtO7lulr3o6KA1wLQmBM08T6
         UMDA==
X-Forwarded-Encrypted: i=1; AJvYcCVVgfeDXc5Uainrkf/3DieLuhewZk8Bchgm218HY9M00sE4RrMRPHiB1VDtAa/QstLPTcMBQS73Rg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyxu+DCsdiOd14MkdjGJ5rJHCZJrVktYIfQXXAqXuBlOl0wUEsV
	w0ee91E/NuGsVZnAXwzg3dhsyzmO4CaFKNWjuIObVkO93tlH5Oof+qAEiJSmenHn3a5u0Wfpgdg
	JY1+sB7U=
X-Gm-Gg: ATEYQzwFi6OGISuzZM0GK7ASjzN348fxNDtAg1X03PKF0PXmTPHo7zbKN63SgiPS4O1
	6auHmf+eD2NK1ndI5KlmYBFLDg460okQoQR2CeMegko/5kevGIaoba/yuRD9eKjVVOaaf1R5l4A
	lgXNCHv1GeDfUVKmdRDasxhqjmI8xxYb97Xn1mPgMm9OQeP6CFOvHgFq3VYsdhcBR2MKbyd4mDv
	qxLK8ovnK/KPSI+yJbz8MJnMJI1cjuUzGNn/Rvq9KGDMnsFwSjqpvEd3Wt5vlpCaUHSGtVFl+yj
	Mkm4xRFaDbqbuOKBc4zlVyWnjsCk+khGJPpx+8d5r13R+BeKtgnqbMAuDfu7MIV91uq3ExZZ1cD
	qRgrP665kD4bS2YHlFcIt4/REtrzkyBC5O9abvXr2d+Bf9JkPjczvY33tbBrI3Y/t8H76DC4xiU
	twX2FuIuBIgLFkIJ1VpBk1tZPfZe8LRPjSoF8ThvGB/wHZmVYibC2+J6p+Q5zZbCOyMpANrR88b
	uVicwEu/2o=
X-Received: by 2002:a2e:a4b1:0:b0:38a:1a50:d842 with SMTP id 38308e7fff4ca-38a40d6681dmr5483721fa.30.1772793860101;
        Fri, 06 Mar 2026 02:44:20 -0800 (PST)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38a41fb441fsm1715781fa.20.2026.03.06.02.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 02:44:19 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL] pmdomain fixes for v7.0-rc3
Date: Fri,  6 Mar 2026 11:43:53 +0100
Message-ID: <20260306104356.60885-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 98E6F21F19B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43796-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linaro.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ulf.hansson@linaro.org,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pm];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:dkim,linaro.org:mid]
X-Rspamd-Action: no action

Hi Linus,

Here's a pull-request with a couple of pmdomain fixes intended for v7.0-rc3.
Details about the highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f:

  Linux 7.0-rc1 (2026-02-22 13:18:59 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v7.0-rc1

for you to fetch changes up to 0fb59eaca18f1254ecdce34354eec3cb1b3b5e10:

  pmdomain: rockchip: Fix PD_VCODEC for RK3588 (2026-03-04 11:22:36 +0100)

----------------------------------------------------------------
pmdomain providers:
 - rockchip: Fix PD_VCODEC for RK3588
 - bcm: Fix broken reset status read for bcm2835

----------------------------------------------------------------
Maíra Canal (1):
      pmdomain: bcm: bcm2835-power: Fix broken reset status read

Shawn Lin (1):
      pmdomain: rockchip: Fix PD_VCODEC for RK3588

 drivers/pmdomain/bcm/bcm2835-power.c   | 6 +++---
 drivers/pmdomain/rockchip/pm-domains.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

