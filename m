Return-Path: <linux-pm+bounces-24248-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF84BA673D7
	for <lists+linux-pm@lfdr.de>; Tue, 18 Mar 2025 13:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4557B188A64C
	for <lists+linux-pm@lfdr.de>; Tue, 18 Mar 2025 12:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E41B20C015;
	Tue, 18 Mar 2025 12:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iDRB15o/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F36220C000
	for <linux-pm@vger.kernel.org>; Tue, 18 Mar 2025 12:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742300755; cv=none; b=lZmr3WxiAJKYplcZ9omatILLwwk7TzohHnpZ0VcXfE8qiGFlv/+lipSZpaTxmOCSTLVMP4x8si9AuaEuzDrOR0hjIfJKNasO1FHQxroryWHtdrUSh6jCIoqdj3ipmdTGweBcCQ0tB6+n31jdRSy8GztgoZm0gmAaH0U0CrYKrXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742300755; c=relaxed/simple;
	bh=uWcup4zSOhXmCE7f8utEF9MDkob5Y3GjPtl0Flu5Fv4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JfDmlZYaKsvtPZ24W2qfvtgiTtfZ+P2wmjqFlpG7QbbgcQOpXjBjMGY3ow2q2lIi6j+TWSRvYEdX+gCRO1G24e5tvTDOQwuayI4G33OPDwHQ/+MelU0d6Zip9Yyht1GHcUBRxUXpD3e1QwIw2eAO1p1RWBj7X8AhCGliJqXkjLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iDRB15o/; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5497590ffbbso6161202e87.1
        for <linux-pm@vger.kernel.org>; Tue, 18 Mar 2025 05:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742300751; x=1742905551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZtPLa6Gx4FxVSml/wkB43YfMAD/jyTKQtWnRVh8gh1s=;
        b=iDRB15o/ymQM2Rs92dvh3gSbiKZaPScBH/Y3PK/cvrrKtcDHz6V0lEd3i7jy1yNPpZ
         lJNFkQb5RhnpBVYlyYkYP+p1/BWbKkrv0Nu9a8A9Fe/aIpxnwGYoxPdIeiAf8b3lN2Ku
         /Oaz0GSICvdCXq9uebrfNcv+syXkzvZRKUT1xVWay8TIpx/vG1IZGcxLYarIwqlSsJFW
         4nd9W/1RkOAJo/O9lhXQH5KgnY5MQGf7oIiOoWBfPUcBFbZQyioTrvz843iipLcSTebK
         jKuvlXsUIaEvcu9gY33cCddiL7CvjGNXpPHxu4VI/URCZKfY33axAcoaaZeg1AJq0S7C
         /JRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742300751; x=1742905551;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZtPLa6Gx4FxVSml/wkB43YfMAD/jyTKQtWnRVh8gh1s=;
        b=mU9v4k9pRVu/jpwLmipfXkTmMsKe7YXmOY2WmUEllJeVIHsTKby+XRhWn05Lz9pj+X
         XJV/oMYd+eMLYCRT1iZ8UfO6Ud9TQ76FvlTJUtcZoctdyIjTYc34tG/6a7/Wt2XbAaTb
         iy9Vi/9vgzebqLwjzJ/Hb5ainX7C4BYeYqWDtAb2t+oMI5APaTuEUoH1S3x1IyyvIs/m
         93KMYQDcoLy2VYDKb+vr/oVik+KkYVDIxY0Hu9Hk2jKS58H96lo1bEFyPC0fe8NiUD3D
         F3xF+W2db9x6ajxw7IM6DKHb7yab0QcqZcLLiinJcd+JDEFBQ8iNNokd+fHaGD32E7tc
         SDlg==
X-Forwarded-Encrypted: i=1; AJvYcCXME72CBeKHUEMPBVoBV7938CxIMroBx9mgbOm578PHa6t+pI32Eq9ky2G5l+Xs2W4ELVNJDupMTA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxKdOlBhXUli1LBtw9P8JWeP37gUUnE58A0KMXRrdIC9OCkNKiS
	GpiYJKwq9tFqFG4I/U7aXFvXe1s2p1YyYzC6lOWStX7qGDNmTNWY+CL7vvmaM5Bvu++KlhDkIaV
	L
X-Gm-Gg: ASbGncs8IQYAkq7TYbCveQHwuAHdGcODWLK9ZGrAg0FuKAB3isWjLN4ZqgOuorQpS0q
	KM6HQHvGeIXiIAzDsU9bXJU0S3FFJJH/CaUp6Rm1+cRpgkPIRxI1nQkb40kCjHzUk66SqlVsaav
	NsrjcSBt57oXGh0aehD3V1YTQi3GoWjdc7wUeZaYUVVrUf2rRMhWGH/PyBhJwQ/WqX26bQ3WhX2
	zW+/M67lZNIjs0nIk3TXdbxbo023L1DP8OgTrzG+KfJvF6RamrrNMTdbdIVReyCwroNyLtKACiA
	Vxm3t0bGpltt/K7RPgSgGLWKfSx2IQV3bQIs0Ju3iFmlPH/Ka2xPmZ2WK+MoKf/AUVo3pPE5XlD
	cd3blOHYCK42WqHBl7YI=
X-Google-Smtp-Source: AGHT+IGVZaHWKtN8hvWXYb4jPz6o8jybr9YNPIgsaj0qZXf8oAQIfNC+5+M6VxE6U6PaRzmbGl48Vg==
X-Received: by 2002:a05:6512:3d8a:b0:545:1d96:d6f7 with SMTP id 2adb3069b0e04-549c396e431mr11868418e87.32.1742300751071;
        Tue, 18 Mar 2025 05:25:51 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba86528dsm1626584e87.138.2025.03.18.05.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 05:25:49 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL] pmdomain fixes for v6.14-rc8
Date: Tue, 18 Mar 2025 13:25:48 +0100
Message-ID: <20250318122548.1328552-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Here's a PR with a pmdomain fixe intended for v6.14-rc8. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit d082ecbc71e9e0bf49883ee4afd435a77a5101b6:

  Linux 6.14-rc4 (2025-02-23 12:32:57 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.14-rc4

for you to fetch changes up to ef17b519088ee0c167cf507820609732ec8bad1a:

  pmdomain: amlogic: fix T7 ISP secpower (2025-03-05 15:51:04 +0100)

----------------------------------------------------------------
pmdomain providers:
 - amlogic: Fix T7 ISP secpower

----------------------------------------------------------------
Xianwei Zhao (1):
      pmdomain: amlogic: fix T7 ISP secpower

 drivers/pmdomain/amlogic/meson-secure-pwrc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

