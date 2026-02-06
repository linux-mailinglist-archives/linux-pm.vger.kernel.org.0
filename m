Return-Path: <linux-pm+bounces-42198-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yKgUKtfLhWlWGgQAu9opvQ
	(envelope-from <linux-pm+bounces-42198-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Feb 2026 12:09:11 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 18593FD078
	for <lists+linux-pm@lfdr.de>; Fri, 06 Feb 2026 12:09:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46B45302AE37
	for <lists+linux-pm@lfdr.de>; Fri,  6 Feb 2026 11:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A384B364E8E;
	Fri,  6 Feb 2026 11:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QyZR0t/N"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337E02D5C76
	for <linux-pm@vger.kernel.org>; Fri,  6 Feb 2026 11:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770375958; cv=none; b=V4T1zhfHXxw4S7XFZvzAaTc4F9FUVhExjVDfDfwE2psBAi7EtJSNkST/Adi/tRn7SWLAK+TcTxeUJM73KnzaasUjpr60T0YRB3HU89CJG/84KFTbpzS6WTKfOJZirFM1Lng80I4xVi7tKYD4YA4ICct5ArShz0ODAG6APyLothk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770375958; c=relaxed/simple;
	bh=OXCOzIC0pQMpUay04vLBX3PqRjjT2+sjKKzGBOUKbIM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BMlD3HXwP9xQpMPmfgR/Gi/MxTiIlMdHPU9ms8gYQnR3EERKQ7Yx8rkP3UM3GV6P52OGAmtfBFj/4fnlHNhrm5Jbt8kD6oFB3dvqq3ErpPoMNb/Jcw0CzgnppvNZObTQL16b8D1kT3xH5tJ3fqyVJoUyMlyqxYjCC+o9/Jr6Flg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QyZR0t/N; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-59dd3e979ceso714403e87.1
        for <linux-pm@vger.kernel.org>; Fri, 06 Feb 2026 03:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770375956; x=1770980756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a8YgULvPUysHanJexoM4PJO6EAhVNc01J/9HL0jGN3c=;
        b=QyZR0t/NVOS5M7zjf/+WHjF3xUtl2aT5uwM1jTenIr1bksm+FG6fsmX2EGreZ/ibZJ
         tO71dFTCxaxZH+QYcGmLlj1hIAd6n27Lr6AcA+eFmoFmY5PE4jSlKQ7HXnr/AmNW2LHm
         ByYn1pOBETVP3MbZDqevtBhZ+YzoaW9D84Zfh5Np/wmNkd6mzfBE9sIOuu2ebAlK76/2
         AwMmLBb8SGgWZa3pDUUIN/dfssTO0d/CDJjY01Cu8kbRagqpBFIA5xmSY+KF7o7JiLjl
         kSNW7h+7INSP5axpbf8fCUVQ0SxE71O7gjZuazl3JTh6hCiwwAKVcmC+dW36Ws+vOpXr
         QQcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770375956; x=1770980756;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a8YgULvPUysHanJexoM4PJO6EAhVNc01J/9HL0jGN3c=;
        b=DaQfl7GDHez+NlDvJJtHz8VM05AA+LkDPQeoz7bz9pVHgC5tnviOgn5y4DKT9iZU6V
         jULPNFbGGVFI7LLlNYqAT47p1++VF+srzl6TnijLuh48VxDpDRtMSLdWSEqbvB9DB7zW
         rJO9CZ1wGz+rIuYvgytBO0xL8vTPBe3fLtlAJuadgIIr0epEWOi1CBQOtEOLbzlxCk+G
         UwUfQqvHJ+lt1mcizIWsjuE+9122o3CsxUpdBXowWu45BhCG0XwspCbRn7J9yqiqW9Cl
         wQm/GMFfKl/+8U0NuOHo1AaA/g+N+b6I5w9OCtHNjifL3f5Kr5NB4ZMGVdBEOu/CrOSk
         UYLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMmPiTtA8IOwUGCPDcGdS18RKHuI/QJdHOyrMHXHXhusg2rGYrXt2sQGT+g6V6Ee1V7sAnm2tNyg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzAeze3tS+C9+0a+Tq03w4O7OBtL1y0BnO/EZvd4wLatObnCvvq
	O0Ttbk+vlaUysv9MkExTCvN7mm6+yFMs5LmUh2MdCv8Ao97OuL4huuQ6BKvO8ewBAMU=
X-Gm-Gg: AZuq6aKhzI9waZrmTmlqHF+X95eyUUP8aIHbJL1giRk3PtLgHOo46XYP87300XupgGJ
	nO9rh9UTGLQXIpets+AqLAYIlmdzpON591pph166Lazj6Crye/o4KXVH96CdL1JylJ2zTGapIvO
	J4Y3nB0EXmTA5rp/AteZlu8PrEZV14OxcgswNTR46GHHw9GeNv47tyw7D9FsVmbVuXlSHfn8xei
	L19EaTGRp6MPH4I1Li4DX2Zr/Ky1NQiw88XL5kkqHc6kuUyfJkLcgirpHJIzyDQskUKpwbKdBmW
	Kvg2aBj+L2GUbk2TsCOqNWTYnbcvBnRcPrc8pEQ3NbkgDIS3jkdG10Vmz7cD6Cs9TK77/tkO2h4
	y4Hib0MWii9RRuttO8Pkf9N6J38+DyPnJ/gwTj+VqMIs1W47QjpSd3xEjyj2hXopUEC7g+5cBvm
	yvWpfqvlu8Xpfax401wuy0jh8CvCKN0kVRvAG325uQ66S/Ku3HNYIbsOAyY4u3
X-Received: by 2002:a05:6512:ba7:b0:59d:fac0:3a14 with SMTP id 2adb3069b0e04-59e45169082mr649867e87.28.1770375956334;
        Fri, 06 Feb 2026 03:05:56 -0800 (PST)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e44cff6a5sm510395e87.34.2026.02.06.03.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 03:05:55 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL] pmdomain fixes for v6.19-rc9
Date: Fri,  6 Feb 2026 12:05:55 +0100
Message-ID: <20260206110555.539300-1-ulf.hansson@linaro.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42198-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ulf.hansson@linaro.org,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linaro.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linaro.org:mid,linaro.org:dkim]
X-Rspamd-Queue-Id: 18593FD078
X-Rspamd-Action: no action

Hi Linus,

Here's a pull-request with a couple of pmdomain fixes intended for v6.19-rc9.
Details about the highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 861d21c43c98478eef70e68e31d4ff86400c6ef7:

  pmdomain:rockchip: Fix init genpd as GENPD_STATE_ON before regulator ready (2026-01-15 13:39:16 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.19-rc3-3

for you to fetch changes up to e2c4c5b2bbd4f688a0f9f6da26cdf6d723c53478:

  pmdomain: imx8mp-blk-ctrl: Keep usb phy power domain on for system wakeup (2026-02-05 11:33:30 +0100)

----------------------------------------------------------------
pmdomain providers:
 - imx: Fix system wakeup support for imx8mp power domains
 - imx: Fix potential out-of-range access for imx8m power domains
 - imx: Fix the imx8mm gpu hang
 - qcom: Fix off-by-one error for highest state in rpmpd

----------------------------------------------------------------
Gabor Juhos (1):
      pmdomain: qcom: rpmpd: fix off-by-one error in clamping to the highest state

Jacky Bai (1):
      pmdomain: imx: gpcv2: Fix the imx8mm gpu hang due to wrong adb400 reset

Xu Yang (3):
      pmdomain: imx8m-blk-ctrl: fix out-of-range access of bc->domains
      pmdomain: imx8mp-blk-ctrl: Keep gpc power domain on for system wakeup
      pmdomain: imx8mp-blk-ctrl: Keep usb phy power domain on for system wakeup

 drivers/pmdomain/imx/gpcv2.c           |  8 ++------
 drivers/pmdomain/imx/imx8m-blk-ctrl.c  |  2 +-
 drivers/pmdomain/imx/imx8mp-blk-ctrl.c | 30 ++++++++++++++++++++++++++++++
 drivers/pmdomain/qcom/rpmpd.c          |  2 +-
 4 files changed, 34 insertions(+), 8 deletions(-)

