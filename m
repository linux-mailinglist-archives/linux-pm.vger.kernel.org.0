Return-Path: <linux-pm+bounces-13766-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3566996EEDF
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2024 11:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7179289253
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2024 09:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C31C1C7B98;
	Fri,  6 Sep 2024 09:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qI7WYMhK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2EF1C7B82
	for <linux-pm@vger.kernel.org>; Fri,  6 Sep 2024 09:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725614071; cv=none; b=mcjzxOm1WKYvnqFOgubRrSo475xcGOMcp9t8O9SYoLZGOhFDZukdmE0UKkub+X/5jJfup9cD06w0pXutnyC8eTQOgonOBT+6aoxnd8OCGM7iMOfqTmlZrEw2d1glxaMWcFarP6pe/tR5DhDMVqAVOuda0lnqY2zelgmuRrYTAxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725614071; c=relaxed/simple;
	bh=BAk63GNH7zv2eCZ6zJQ4aSyrV+JmqJBYJazqvBs7yok=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=R9ULCXLz2MwGNVOcZpJmuWdwMzbQ2RrX9UDvbFgb2+GnRcHQYFy8an172PUslhLlJ9GwDeWiEvVGi3hJvIBql/2PDoK5I2Z3zT4kQj8rLr9XqBX4/wNZwgdXY48c26Y87u44ZZBRxqXliQRgwiUP2pe80XgagfBsp7T3YxRcwwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qI7WYMhK; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2f4f2868783so19512551fa.2
        for <linux-pm@vger.kernel.org>; Fri, 06 Sep 2024 02:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725614067; x=1726218867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U+e87R7FGYS1kSpMh90TGIRaqFWfWTQZT+9IVNpQkCg=;
        b=qI7WYMhKNw7TbwC41FER6OK0thud/cNdYUMNRlfWRMg9SOB2GaGn0tRPlJR4Yj1Hrs
         2vXZA1Y383vKW5blVf5Od8YaCrxVpkGLP0sykHMSnNrBYAjK2W3M0BjtOmaAyvBPP6OZ
         xJAP7iN77Om6zOnLip9H8bXOstcsJX1OH2JYcdIxfJzo3/sFY5FWyjSs7az8QTnMIFWK
         7by2RgwGxvgw23tnFEhRYgI+cyBcYQ8wpTH75CW9pvYsHrmEJW2Q/37ZmDtUJr9GhUW0
         29A9JFsqHGGO8Rq+Bgu6cB2OinPuQBLUqwn7cJrasnfss2iXKNrcabuSYk/53mCoYIR6
         oWhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725614067; x=1726218867;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U+e87R7FGYS1kSpMh90TGIRaqFWfWTQZT+9IVNpQkCg=;
        b=njmABEwjKBxUOmfwva618G5PZf4/meXZnY3gf64Poh46hefdgs3px+n1Mb/n4p0Oka
         qtOdhRgGF4SheIsAGnRIvyjSSzjAw7/260PDrzHKsHK6AQLwaVJzBg/CEs15IQ7GgCbY
         qaGcf2SE7zBnueqTIAPHO7EBhCdNYFinXqr7s7Exbe6K9uICsGO2g3CLprkSIgsdWXt5
         eGOuQeYFaTlaCvoT2i4JQIfNg4jNNMjZ06qQgEosQkFnAIRLJH1y4RaCb4U7O/lbCcm4
         Nk0HgaBf7nlc4AboGDMdwdyM2GBWBllOnXPw/qp7h/7P9AxJj03KXPDpUmLq2/myGPJF
         x6ww==
X-Forwarded-Encrypted: i=1; AJvYcCVUNKXd3MPWs7BWeVfO8aAc1n7xMOjCS+yUr3rOzICjTqekvw4tHMz6OmDUBrOLkAMfUb9pNCkYlQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4I91KO4MNiYPFU0ubARcA4bHpUshYApAuki6QgkMok8v3wm/I
	zEWnqqCAAhwmOo7Z7idUgoL7gZOjobScQD26LYkt/L9Qkr1IMEk9+7TXEztUeg0=
X-Google-Smtp-Source: AGHT+IFEUhV1ciV9jyrK+eJJBbqBxS2WmmWYbLgdbNMBbisCr7UEYpC48Ax91t9tYCtSTb2NRtqaPw==
X-Received: by 2002:a05:6512:3088:b0:535:6892:3be6 with SMTP id 2adb3069b0e04-5365880bf79mr972206e87.54.1725614066879;
        Fri, 06 Sep 2024 02:14:26 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53568035c30sm648770e87.81.2024.09.06.02.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 02:14:26 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL] pmdomain fixes for v6.11-rc7
Date: Fri,  6 Sep 2024 11:14:25 +0200
Message-Id: <20240906091425.194581-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Here's a PR with a OPP/pmdomain fix intended for v6.11-rc7. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 52dd070c62e4ae2b5e7411b920e3f7a64235ecfb:

  pmdomain: imx: wait SSAR when i.MX93 power domain on (2024-08-15 12:47:09 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.11-rc2-2

for you to fetch changes up to 9ec87c5957ea9bf68d36f5e098605b585b2571e4:

  OPP: Fix support for required OPPs for multiple PM domains (2024-08-23 11:57:44 +0200)

----------------------------------------------------------------
OPP/pmdomain core:
 - Fix support for required OPPs for multiple PM domains

----------------------------------------------------------------
Ulf Hansson (1):
      OPP: Fix support for required OPPs for multiple PM domains

 drivers/opp/core.c | 56 +++++++++++++++++++++---------------------------------
 1 file changed, 22 insertions(+), 34 deletions(-)

