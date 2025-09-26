Return-Path: <linux-pm+bounces-35463-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A47BA3A90
	for <lists+linux-pm@lfdr.de>; Fri, 26 Sep 2025 14:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3201717096D
	for <lists+linux-pm@lfdr.de>; Fri, 26 Sep 2025 12:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321312EC0BC;
	Fri, 26 Sep 2025 12:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JmtkoTuM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EBF2D6E5C
	for <linux-pm@vger.kernel.org>; Fri, 26 Sep 2025 12:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758890614; cv=none; b=HkuID9hjVzMLWWOBzAjGP9uWzLzQGFFnLbcCmApv1jB3IIXveoUwg7GGCag45y1bn0nkRod2xw27uKEd7H8uh8YkXJ1tVQIP0ZCq4tyb2EIxbSPMSAweVnGcwCb7D3SRBYCX2cihA/vr4PMVHNKsXYXRIaIo1sNBw2Wvi8F/e1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758890614; c=relaxed/simple;
	bh=WwwCAulaw0W5eNIPLrL7FCFXtw/5faEavn2inNn9x+E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mvh1UByW36UZE72M6cdUxZlZeidFJPdJBJMiuQU2GqKRdnt19NQN6YT9nDyaZJ/obDA198IurvTUitPAwtUpV47qSN6yzMz56hacWSE6hFDzXZ4F6MVwDi2crmtLr3paLrzbccs8L0J+dYkG5zugSh2Ta3AoIPcklttCBwI2scM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JmtkoTuM; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-57bf912cbf6so2374463e87.3
        for <linux-pm@vger.kernel.org>; Fri, 26 Sep 2025 05:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758890609; x=1759495409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m3TrlPJojLwz8IDO7vEe8n5bv1r1AjxKFd90MIa952c=;
        b=JmtkoTuM2+FTraahVrcbpWK8lAMLgU6rSy2onKbA00DrsxMm1CTWlrypMRPlgZLZod
         uHQHV5Rk7lovxKanm7v1RieW7pHABQlNf5awZCS5kEut0/k0zM+gR60sWz5KmK+fM4nK
         GFy/Mv+3Xb5jHiaggfGZjdPkJo/WODMTB0AWw/EMuBrvpC83cjG4woz3fcv1Omk5Wa1D
         sw/NDd4zgOTPYIxnBbYH/VTDUl1PitNF0rAFPH7RsXDWulO9QVh0c/VQMDTcd9ELyu3H
         trdMoLYeeD37zvje+t4hh8aggHf2OuevZ3YOLrqLypc1GNZRTfIltpHAUHIMS8mhhceK
         VB0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758890609; x=1759495409;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m3TrlPJojLwz8IDO7vEe8n5bv1r1AjxKFd90MIa952c=;
        b=db2LCQ8OHMmzuSZzNqR9AWvZsea7j/5kORHdWtrBtiB+Zz1oKjlXjUft4C+CBp6BS2
         tdBCBGDKCa6FnpU9L8ttAgLWOT+0vkl0coCmdSg+L7i//ioS2FuGzNNy19JGRVXqHhmf
         RuBmv53u/eLvho+vWSK2YZh+hT+WGvVoWLOtlcqrm9gygbCupVvHiz4dv1D8EF7SdS76
         a5PCkFnlhZhWwNbUIKVPR/fwWcP/RiFqlWp+hq4k+Ey/sdCBh5xPbNGHj1rLFWajSLqi
         lbQ2N7wsV8EwnaK9H7dxqg/V49qR9dcHjpCarBX6SuLzLN0L2FBFmaXQ1HhARGMiTI5x
         g+TA==
X-Forwarded-Encrypted: i=1; AJvYcCWc+PxE7FiFD9c+LLDXwW9gfr0jYjxAikdYCNQUh4RttZV9fgqupUUopbzDrDmtxmY/d1RX2K21WQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyFdxHDdAcWjN2qbN6E7qvfs0JdXFqk5wvRZgj7Z++3N2cPZSc7
	Vs+RKcaUxbBlgH3yT3tAzf2M3mACT8E/Da8yxsGpx2vu/p+eFTo88ThoXWwqUyldi0g=
X-Gm-Gg: ASbGncvlaMbtSjCFAHXXkVhFQfL8fpio5ZtEXuo5zHWTtSrBDi2CPqri1Nx2MC+HqhP
	59U3EBHeREgf/VpcfaOI5hoZt5qK0LxDgJ3OK28kKW7nG4D2usNCdE20QYPNG2LQGzqlEuE57J9
	ekLUrTTljuoxttRdjzkyVXdWP0RvJCThgh8VE6+rV22l8LoSAEO5wnG37SSxzRy1+/bzwCYiNxk
	vJun1VXIMHBcHqOeJSMJ0wR8u5dUBNEfqUNZrBMXgh14O1Diu6oS0+9/0XSMw4Lo/1XB5KrAakW
	pE6N7wPZ53yK5Jr6XHL8J0O47g8tDL/fvYRKyln6J7bvvR+Gvncb5oBWZ2iyybMyVmunYvWcuv9
	I5sGeNljAOIpfNoTSd+2MfScpyFlw5CyXTTHyYpIk/WDxDxQRLyG7zUwxBs1PcpvrI8hgIEbY
X-Google-Smtp-Source: AGHT+IFSMUZyGErx/ATx84tcpejpRIj9agjrcxBG83lEZJRIvJ1l/sc/CKJcJP/p3DJDSM8naP+IrA==
X-Received: by 2002:a05:6512:3b20:b0:579:c694:fbd1 with SMTP id 2adb3069b0e04-582d2f27ee6mr1917262e87.29.1758890608833;
        Fri, 26 Sep 2025 05:43:28 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5831665671csm1724276e87.75.2025.09.26.05.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 05:43:28 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL] pmdomain fixes for v6.17-rc8
Date: Fri, 26 Sep 2025 14:43:27 +0200
Message-ID: <20250926124327.212581-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Here's a pull-request with a pmdomain fix intended for v6.17-rc8.
Details about the highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 303010f4658cb134eb27cee88026fb5d065a48cd:

  pmdomain: renesas: rmobile-sysc: Don't keep unused PM domains powered-on (2025-09-11 12:36:55 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.17-rc2-2

for you to fetch changes up to 5fc4ab3269dea6a0b00c7256cb6f6c0101b6a44b:

  pmdomain: mediatek: set default off flag for MT8195 AUDIO power domain (2025-09-23 16:33:34 +0200)

----------------------------------------------------------------
pmdomain providers:
 - mediatek: Make sure MT8195 AUDIO power domain isn't left powered-on

----------------------------------------------------------------
Louis-Alexis Eyraud (1):
      pmdomain: mediatek: set default off flag for MT8195 AUDIO power domain

 drivers/pmdomain/mediatek/mt8195-pm-domains.h | 1 +
 1 file changed, 1 insertion(+)

