Return-Path: <linux-pm+bounces-8182-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7DF8D0556
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2024 17:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 024A41F21F31
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2024 15:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30001155C94;
	Mon, 27 May 2024 14:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zhb1+Scy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629AF73443
	for <linux-pm@vger.kernel.org>; Mon, 27 May 2024 14:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716821145; cv=none; b=SWYByUqUIttD7mmeHgoKa5p1vYaHqGZiyfm8Xjw4HMCRAiF6d3X8Yxpt32EO7r9iA4MD2F8HcNvcCUSfS/xGLhfA51DKb6y9OvJ1BB4qnFj1+el5HxikHzN+SvmnLncAd7R+bY+gSBT2u1xlnKx3CGCNLy1xAal+R+Im09ceieI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716821145; c=relaxed/simple;
	bh=7Gmig81o8VCtO+jw8ZG0v3vKCZkx6IgJP+6S9UFxNjU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rwSF4p4J9P3gmJJMsiTt0EOYnR1rU1qWAkcZQc4VsiGR4JtL3MPActEDSf8WTJVKKFZtUPktGi6OSVm3KjMXgLOniojswVqOSGh/bSEXeIFMVF6ZlJvBOgYoXtLj0Vx9wKf7y+POMUNmAvDidyksnDznQXaJRERkC4vjNQvDYqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zhb1+Scy; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2e73441edf7so83493181fa.1
        for <linux-pm@vger.kernel.org>; Mon, 27 May 2024 07:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716821141; x=1717425941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E0zp8EmCNFr7PZtWolAKP7vPxVa4oV0/0CpIkN5A1xM=;
        b=zhb1+ScyJTSS4FBTYI4INJd/fZjQaZdkv+B6306eEuwKDo2q7tj1WsIUCjbGCNckao
         Afm52lzF2jVO0o7mkpxscJXZ+/rff6tRpirJUaYSqlxEgpfYOhZSEKrYQe7pYlmImiKI
         wlcae/b5tqHfwuoYwFBcRv4l5P5lBFUxF+6ojYCS1psjTmHUuGfeEU1MJ/QwfoVT3Nwf
         R+6/7QwHCtQQHWJ5QXPI8MVNQW6fh9UVuJg3SK0uRf/8hkEsiAzIybkdLt+OTB5RVcmr
         LzGYSQO5eHYeFCm4fVwuxAfM+ra+57ybx6D8EfFL2rop3b6QTHQ8bJdVn9eVNN2NJmtO
         97uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716821141; x=1717425941;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E0zp8EmCNFr7PZtWolAKP7vPxVa4oV0/0CpIkN5A1xM=;
        b=qYXov0qT5i3cPsDyCU5DGs+54tOyGHuKlk6v5pBohAtxzBPv9mXlCeJH3xj2BfCwpe
         JDCTJpamodgz13v/7ig9gXdjKKvXGgb57K9jcPpN+96dCiyfh4+ma3+XT9wszdzzYrnu
         Q57Dd03CLl4aXVJcofQOvbWSTXCTxm47iCH8ZWq3FxSbhiw7oEikFf1xSo2ZyZkUSsAl
         pWWVYAJwAmyTC3XxA0MUUJdUutHFdFgBkrsU7dx5vHkWYCg5+qq5NAF8n8Uh71O0usbv
         lBgI3T8LVig5D0nVcnSfz+xpIlZLpRMeMEKU2Cg43VkdPKvJjRKl2BD6Ej89erPzvli3
         jdIQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9P3ygDv9lT11zJyTdr+9BV4XXXtJElvyuPjIXZSfUmCzN9188+Pqu5FgFOBFaiOcxYVGhMYM1wX1i8t5c8wQrv13Y+/D0zXE=
X-Gm-Message-State: AOJu0Yz6ZO/CJoz6gI+MB06384TEHALTlGGjLQoyKcItJ/k0zEkpjbuI
	bktXLCPfqfUg7OaNU6mU7GApN2fpC9eFdrp5d3i2fvLlUf/v7dOLNyIxA0fyaXo=
X-Google-Smtp-Source: AGHT+IGFJ8k0xWDQVcil8mB8eiFAQ8o0MJDi9mGfT1OCI0XAbK25IWHMiAlNTsDqUatDQdXfJTqNUA==
X-Received: by 2002:a2e:700c:0:b0:2e9:5380:615c with SMTP id 38308e7fff4ca-2e95b099b5emr56591841fa.12.1716821141510;
        Mon, 27 May 2024 07:45:41 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e95bf2866dsm19350491fa.139.2024.05.27.07.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 07:45:41 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL] pmdomain fixes for v6.10-rc2
Date: Mon, 27 May 2024 16:45:40 +0200
Message-Id: <20240527144540.323019-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Here's a PR with a pmdomain fix intended for v6.10-rc2. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 8f6a15f095a63a83b096d9b29aaff4f0fbe6f6e6:

  Merge tag 'cocci-for-6.10' of git://git.kernel.org/pub/scm/linux/kernel/git/jlawall/linux (2024-05-20 16:00:04 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.10-rc1

for you to fetch changes up to e8dc41afca161b988e6d462f4d0803d247e22250:

  pmdomain: imx: gpcv2: Add delay after power up handshake (2024-05-21 12:21:01 +0200)

----------------------------------------------------------------
pmdomain providers:
 - Fix regression in gpcv2 PM domain for i.MX8

----------------------------------------------------------------
Shengjiu Wang (1):
      pmdomain: imx: gpcv2: Add delay after power up handshake

 drivers/pmdomain/imx/gpcv2.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

