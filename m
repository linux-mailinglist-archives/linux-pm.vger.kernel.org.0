Return-Path: <linux-pm+bounces-41370-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yMF6AJhmc2mivQAAu9opvQ
	(envelope-from <linux-pm+bounces-41370-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jan 2026 13:16:24 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9A375A10
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jan 2026 13:16:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 84213302BDCF
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jan 2026 12:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017A73242B1;
	Fri, 23 Jan 2026 12:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oWl6XBZe"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CDD319617
	for <linux-pm@vger.kernel.org>; Fri, 23 Jan 2026 12:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769170480; cv=none; b=ZNMPJpYYtkZv3ADv9aL477Y+ESUYPuxXmKJn37ui+BQaDkIZ/SBJLaJ+r8JasM3b4Wtwn3hLWMeV0SM/yt1yFokVcghwrE6iMhNKHpTVbTItVjXjJ/vTM26vCU4+DGkTxX07gRoy9Vu1yB9yjh8ySKV6l4ZDnzRM+jEYiLJELxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769170480; c=relaxed/simple;
	bh=UjLTFHTr7y4qXtlMOA1qJ0VlQCkgpBneNXnEqJJeJro=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TmkwfKyk/qTxvqD3Y7UkcVb0exjJ8QK6vOe2kprmc7SptQN9G21b595bD+prjF+xLdhi0WWFVNpXNS+3j79Xwn4dfkPDc97DT0G5kxPMJqLIBNw86zGyh7jhxmjeBBXvmWFytoJcG642R+H7x1c5MxmjAFoASWfhu9vBlZPA3q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oWl6XBZe; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-59de77e2e30so581280e87.2
        for <linux-pm@vger.kernel.org>; Fri, 23 Jan 2026 04:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769170477; x=1769775277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kjcefJz4wS8+wx0G0+wWmYZBrJXxWpwsLQGj5HJOf1Y=;
        b=oWl6XBZe7+F2napLgyxWhXlzrcwzjt9buSkLKOx9iwPDdP7KXlb1Ozyz1imSKy9xvk
         vSmskIEZmebU2/AO7Ljw9PB6jpk+/5fwNsg93eXiwWBWmvd+BbznNV8KWx3zjI+hGe6G
         DNOwgumkCy6qA7qHcQEkvp1oWEcKHYPBX6niiUoCNU7N17HaJJOR6gBVHwn3XfvPeI15
         R75WXcQAGTwrbXN4FwM92bj+FaACSwd+pGVIKw46JNrnt/tWFTXQZrgcdk4y6F5bqMhn
         ScEtNV1NAsmjTFzwxWYooOwJmEF9mJP+g3uMgyD8hC2byEJNU/EFF2m3DjkkFCEnq3A8
         ioyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769170477; x=1769775277;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kjcefJz4wS8+wx0G0+wWmYZBrJXxWpwsLQGj5HJOf1Y=;
        b=bu4lpkfQdRVAZFWFWn//CWxGDvx8qWWFUgr/MFsmO1Y0pC07/uqsEj0DWv8uJ6/I9+
         WgDugkVjky3QFzBOdHeJ/w7QJrSv9T2Dy/pDG1rc1kL/IB0wHpQC33fHzLlRoNqhpLBp
         bGX0Dp2/T2AkBM1YXDAhalu2Dr2ONOOHS0iT+l8I1sDSiVqYS4CsgJF9qPb3tKclFX0M
         Us6yvGMA152A9bWfWsNGfznzzFhNm43A54CsPxYhuvPNiskFB/d0dAWfCrHKrwrAnORt
         UVgAhDbj1sQIf0I79te7mFkkk/XYj7cveKkwuo3W6Tn3xQLw/8ipzWG2YWuksZR4q23A
         4iLg==
X-Forwarded-Encrypted: i=1; AJvYcCVbQmTmnc8qF1f+p6WQ0yzB4G2SOFCjFM0ou2sKA2KuOzr4ieQcwiu1klsW7DxDcb5qYvteo0HkIA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyDWZCJzBVtFfaHfxfOjwSuuNrkt8HtipCiCPU+lQEtbDATEFXb
	xW+iQ4xYLhPW8t595y8/l8nMGELE42ThOFXd+Gehd7PvDAiGqjUaE9SI+1XcQxg7UDo=
X-Gm-Gg: AZuq6aIDMoHMfwLEudNrP6inZAwa3y70+LAO9YgCJjUde1FFFfTqZpgDPcBbqUzmnyC
	jNO31AEx0OUKbVlUcrhDhcpCwSdxu2jj/XJFg15BCqu11NsJO94G1nzkg7qEzbijmDxBTBzNiLG
	KOqKQkwkk62AYOjBGiP/kGenVIt6PajOR9RN2z1TJqBmCaf/e+fvaRgCrfZ9w8NyRRAS9jI/eyt
	Dgd5uSxisQ1XgoREsTfs1wBu6+pJEArf0nKwbIlqGm5IMlDfZUhE5sKivlg3anYqg8xbt2I0VGp
	vAlwBhBV23PjNX31+PdMHDfnzs7VD4kOaK8ihRn65or8qXvZq74+cWZ1xIYEs3w49EnhtWwqaNy
	frppulMeo5XKV8kzk/v8r1Vkclw/IMVkoTKy/Kpx+ZVq7JeOX11X4CQ/4c1N9O/am6PprwqpnMG
	gQwPccprG8ebSPf1ZI30H6wRggU3VOJn8ot23QMzkXiYIlmilrlJGDpYq1uJiA
X-Received: by 2002:a05:6512:3dab:b0:59d:e93e:a8ae with SMTP id 2adb3069b0e04-59de93ea9demr413953e87.47.1769170476892;
        Fri, 23 Jan 2026 04:14:36 -0800 (PST)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59de48eb4d1sm639031e87.39.2026.01.23.04.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 04:14:36 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL] pmdomain fixes for v6.19-rc7
Date: Fri, 23 Jan 2026 13:14:35 +0100
Message-ID: <20260123121435.245253-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-41370-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ulf.hansson@linaro.org,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pm];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 6F9A375A10
X-Rspamd-Action: no action

Hi Linus,

Here's a pull-request with a couple of pmdomain fixes intended for v6.19-rc7.
Details about the highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 73cb5f6eafb0ac7aea8cdeb8ff12981aa741d8fb:

  pmdomain: imx: Fix reference count leak in imx_gpc_probe() (2025-12-29 11:41:09 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.19-rc3-2

for you to fetch changes up to 861d21c43c98478eef70e68e31d4ff86400c6ef7:

  pmdomain:rockchip: Fix init genpd as GENPD_STATE_ON before regulator ready (2026-01-15 13:39:16 +0100)

----------------------------------------------------------------
pmdomain providers:
 - imx: Remove incorrect reset/clock mask for 8mq vpu
 - rockchip: Fix initial state of PM domain

----------------------------------------------------------------
Frank Zhang (1):
      pmdomain:rockchip: Fix init genpd as GENPD_STATE_ON before regulator ready

Ming Qian (1):
      pmdomain: imx8m-blk-ctrl: Remove separate rst and clk mask for 8mq vpu

 drivers/pmdomain/imx/imx8m-blk-ctrl.c  | 11 +++++++----
 drivers/pmdomain/rockchip/pm-domains.c | 10 ++++++++++
 2 files changed, 17 insertions(+), 4 deletions(-)

