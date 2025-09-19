Return-Path: <linux-pm+bounces-35021-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31344B88FC4
	for <lists+linux-pm@lfdr.de>; Fri, 19 Sep 2025 12:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D17B5A4739
	for <lists+linux-pm@lfdr.de>; Fri, 19 Sep 2025 10:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F6030C351;
	Fri, 19 Sep 2025 10:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YO3VnQy/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24AAC30C109
	for <linux-pm@vger.kernel.org>; Fri, 19 Sep 2025 10:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758277716; cv=none; b=Kfhefku7xRQ/A5XHIJYYrjsxltchRn3hqq2tuSsaL8B3yAySsl9orS/iq5kX+7S4pqKdAjfnAAZ8zwNRLzB/Cjgfwb2BK528nClsWeQZYKJEhB9HysiH/Mpy4z/PkjHanHql78b+GcMUFaad7/u+39r1u1G1g9+UncVUjcaqQNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758277716; c=relaxed/simple;
	bh=jPptXR8NGJB64pS2KaBD1Hd4nTNBbsT4o5H8w9yHHrg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JS5rfv7waftGKvfKKELQ0SF2I43QsFZ6hjaJ7ZNJLWhEJ75wYgb1rc4LOyRzJVsJg44swLxhabhqH3pZQ0Jf7fHgrXZggrJjCCYYT/O0lx5CmzBIT4/DBOhWom/lfbiCflZoRUOcWr+JZRDTckPVHFBir15RDVfPDH6ivoqjFpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YO3VnQy/; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-57992ba129eso1333330e87.3
        for <linux-pm@vger.kernel.org>; Fri, 19 Sep 2025 03:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758277712; x=1758882512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qQQVvpAmXSFXhkPIfMzRXcNKNt7LSya8fPUUSNlSXhk=;
        b=YO3VnQy/UCZXDNmtBP/IpOgHKs6heyNppYtUAEegtIaeyQkpehG5iiCLNnU9hh8K1d
         UNBOKjJRCuSpcKar1auLQatgeH8Xe3tDzXfUSYa9Hd9HZPLoVGP6iqrvQfo5M4pSWeXt
         o+Ci5kWZFZ0IAzVBSUecgRLUqoiGQ8JvxL+ss1nKpW8WI7JLFSJDErrJ4N5RG9M3EGoQ
         DIx51u/TMkWkhxT9KLhvAjCDEwP9QrjPIZ+A5fNnYvs0i2Zo56+BbwO0d+M51KLdt6n/
         bFjatjMADg33SKaYA+iN5IGghd/6Hbc38OaDLX/8e/S0qlWwqgt9T8eX/eT6gfSMXFUw
         rPLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758277712; x=1758882512;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qQQVvpAmXSFXhkPIfMzRXcNKNt7LSya8fPUUSNlSXhk=;
        b=leOx85slNle7iv1IXTwjMaj9uo6pWROIBbds4KHM/seJs2yRfOpbqGVjMtD5n6shZF
         hF3sedID9zWeJryytSwnFbSAkCsrDff+jUsJBjYT83ygdfTvHfoD3dkVGgDlv1FF/YDN
         xVX0IbjtltkRLt5sumI3Pcp2X1FfoldLv1dR9nxHjr7SvaEfQHpzAseZwVLPNS63TwS0
         b6k7C4wwRo0/Y8mioX2SFeTgags1b0GNlfxVwfhXIDjrUpNBMLP65ddtGsah2lH3OgpF
         VtC8HpA8t+SUuYiiLxfW6ApSn/JZdbnp3jJxN0nOoAo5XDxBi20DSy77W+8zsXXT2ziu
         LvqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZiwrODG54b5UFdbUBPXtu5e5t3nA3lOdDc0PUYPFIQ8PDyxjIA63NVMVcupW447JO4SFSbn5B0g==@vger.kernel.org
X-Gm-Message-State: AOJu0YziRvTIsG1wqrFa0LFeM0mvLQE51EerM440KKSkvXxKprdaw8q/
	g2+n9woAHoBADhOHJmbaSXIuxlX/2aqDsnt+YThllPLUUnaUBDmAK0vHqeRfUj7WwgNvarFsxQ9
	0/M0G
X-Gm-Gg: ASbGncuJDejHh7LnKlCJ+GXfcyW8CvXmDwdMNQ504I9KoP3DyvoLX8gIYCTnP2N2p0c
	5GsECgKDT8vUt5mxFWCXQx0l4H+2u1xARFBls2NfUZ9zlwRg6OASIccM1TdZJEuw2X3EP73585d
	vyEJxMW7kRi7VmHXNAMas67eYumh+/zqfUEKVEEkHY4+hsAmiIAq3eBq8iIDaAOT/AyK4NDDTqY
	w++KaiaO/KY/zWqAZlreeqPElJMr+EK0a0GxgsWdv/r47fpQUkFBo+x0fsEJHjC+b7Eemmu5NR6
	lsZwK4EaZiyt4BUl/ecuxIhZlMmvdPCbmVjenmei1sofQQ7S/CiFPdXs4ycY3JB8NrosOLlTqE1
	KDwyPURIP2c4RQ0H8pwMPsgmL2DKqkeCUp2DZEAHz+MxWiwi3QMeMl6ydNNU3I0i5qmwzafsm
X-Google-Smtp-Source: AGHT+IETmUnQlGUARBZSFBOrd6464VLoS8WXVDGEarMvcetfBwFqWJjqKJS/dx8EIEPRIYxLAxnydg==
X-Received: by 2002:a05:6512:79a:b0:55f:595f:9a3f with SMTP id 2adb3069b0e04-579e1c5f94amr819145e87.15.1758277712193;
        Fri, 19 Sep 2025 03:28:32 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-578a9950683sm1280054e87.114.2025.09.19.03.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 03:28:31 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL] pmdomain fixes for v6.17-rc7
Date: Fri, 19 Sep 2025 12:28:29 +0200
Message-ID: <20250919102829.151957-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Here's a pull-request with a couple of pmdomain fixes intended for v6.17-rc7.
Details about the highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9:

  Linux 6.17-rc2 (2025-08-17 15:22:10 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.17-rc2

for you to fetch changes up to 303010f4658cb134eb27cee88026fb5d065a48cd:

  pmdomain: renesas: rmobile-sysc: Don't keep unused PM domains powered-on (2025-09-11 12:36:55 +0200)

----------------------------------------------------------------
pmdomain core:
 - Restore behaviour for disabling unused PM domains and introduce the
GENPD_FLAG_NO_STAY_ON configuration bit

pmdomain providers:
 - renesas: Don't keep unused PM domains powered-on
 - rockchip: Fix regulator dependency with GENPD_FLAG_NO_STAY_ON

----------------------------------------------------------------
Geert Uytterhoeven (1):
      pmdomain: renesas: rcar-sysc: Make rcar_sysc_onecell_np __initdata

Ulf Hansson (5):
      pmdomain: core: Restore behaviour for disabling unused PM domains
      pmdomain: rockchip: Fix regulator dependency with GENPD_FLAG_NO_STAY_ON
      pmdomain: renesas: rcar-sysc: Don't keep unused PM domains powered-on
      pmdomain: renesas: rcar-gen4-sysc: Don't keep unused PM domains powered-on
      pmdomain: renesas: rmobile-sysc: Don't keep unused PM domains powered-on

 drivers/pmdomain/core.c                   | 20 ++++++++++++++------
 drivers/pmdomain/renesas/rcar-gen4-sysc.c |  1 +
 drivers/pmdomain/renesas/rcar-sysc.c      |  3 ++-
 drivers/pmdomain/renesas/rmobile-sysc.c   |  3 ++-
 drivers/pmdomain/rockchip/pm-domains.c    |  2 +-
 include/linux/pm_domain.h                 |  7 +++++++
 6 files changed, 27 insertions(+), 9 deletions(-)

