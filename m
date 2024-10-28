Return-Path: <linux-pm+bounces-16550-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B7C9B238F
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 04:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5E421C20FA2
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 03:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6870B83A18;
	Mon, 28 Oct 2024 03:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="XCmbdrT3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704121EA91
	for <linux-pm@vger.kernel.org>; Mon, 28 Oct 2024 03:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730086778; cv=none; b=maxQD/wQeBKDnBl6kDsYbifnp7QrM6RIo4ZgVJqNIbOX9B1QMW92Z350bVpy8L8G2285UTJkMgbhk1U0GMrkb7vy9+6YFw0ZTfC4aDdRxLNA9wk8BpJ5db6UWUJypok5i+wBB0wc56YP67nBp4WnGWXvjiw0hQ9TmQCHKDT9YiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730086778; c=relaxed/simple;
	bh=zf03nR63oUi9aIQcnTxeMplp8aLVBVNxqpkRqOwZrzs=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=PLFfwYY9vTNfHx+I/9BgLKbeft/7ucadTfKtriFHBtmokwyt0BlJW0i61qC5GRDzmXmDqAK59wdcdFoX9ifbl1GpbHz0/zUCDx4T3Gqyft7H/oXOSSkjOYd7xwh2vyl3vu/kJR9tl7lZ5lfb87cDk0cy9dmlNGADyBwxxg+Fves=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=XCmbdrT3; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2e2ed2230d8so2849746a91.0
        for <linux-pm@vger.kernel.org>; Sun, 27 Oct 2024 20:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1730086776; x=1730691576; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=UBmgyqeKJRCn5Gf659C9Da/WJZdShhgowczCYBYs4bI=;
        b=XCmbdrT3wLxU9xVyb75W5gsAJPMbX4BBAeyqhEwrUslLMEhyJwlkFaBvJqj9q0pmeV
         am5A38dz082uzyfh0gv2Rpkc9rOXSSRJluk1eDhT6E6AdFldiiEqv9pBGzNarv0lkAzg
         8bqiKi7/L+v4ABgq132gL40su/f4UiBnheJUHbg34HtTvHptUp9lUG55QKyNQDe6gv3I
         ydnTJUc7QnMlHP2B3mALlO0wisbDJTDZxUJhUtlhoIhkEyNaGiXUmGH82In9E8Thc6HB
         E9xvRkZlSdGiOf3LHFA9LQ9Y5KmyPrG7IVt69t8pTG0gZ5qD/duIAU+RELimOr25ceFO
         Szgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730086776; x=1730691576;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UBmgyqeKJRCn5Gf659C9Da/WJZdShhgowczCYBYs4bI=;
        b=mfbvtw0d3fe7fz4nmO0XSPJ7dUOtAQ2fBp15eKFresgKjgrosHK/aDdu6yjsDzq0Ef
         wlvZpRgQVwY5mEy/R6NjO3ynscC5uzYYADA+rwzDUCzb0XyAQSfW+P53AuO8LnAB8+1K
         A2RDKLYOytnUamfu2X+7FOJJLfL7Jh+zBXCgYoEbdvof2zIyyGQayVsNuebMuVyHRhx2
         DqSuow9V01VNnrjemExvVepYxZZy8G5Gvd6Rg9kxMm9+CCP7d/1sShMhy3RnGUZ7ynKQ
         1CKO6FcPeqIevIUCyVzf8KaK4gPrt2AiXTmdb3/XWghTMvcyu15NGYHA7Y2/TXMTMlNx
         ZHFw==
X-Forwarded-Encrypted: i=1; AJvYcCVxPWNBPdxRDK9cpPG91kYFmb8UJm/hLW4Dauz8aBoN1tYFRJNq9m1yZj0qH9V1Ps6z4tt5aA3UMQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwcJ0ykJo6GujBNxoTY5A/mU89N6rPNzlvt9+SmquIuUw79Yz9m
	yxfXXwhQirEXNW0tyBY6qJH+9LKcxTlE2ReFPbWCrfgqdOqh0Dh9hJ6NpmH/2kc=
X-Google-Smtp-Source: AGHT+IH453sffjIwvItRxxv3mspXtf+xzFnYsZ51wevVQNfZjTNz0DmZquqPZegSnXNUg/j6R7elmQ==
X-Received: by 2002:a17:90b:224b:b0:2e2:d7db:41fa with SMTP id 98e67ed59e1d1-2e8f11d1e8emr9087013a91.33.1730086775647;
        Sun, 27 Oct 2024 20:39:35 -0700 (PDT)
Received: from hsinchu35-syssw01.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e8e340e544sm5961888a91.0.2024.10.27.20.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 20:39:35 -0700 (PDT)
From: Nick Hu <nick.hu@sifive.com>
To: greentime.hu@sifive.com,
	zong.li@sifive.com,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Jones <ajones@ventanamicro.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Nick Hu <nick.hu@sifive.com>,
	linux-pm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] Support SSTC while PM operations
Date: Mon, 28 Oct 2024 11:39:24 +0800
Message-Id: <20241028033928.223218-1-nick.hu@sifive.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the cpu is going to be hotplug, stop the stimecmp to prevent pending
interrupt.
When the cpu is going to be suspended, save the stimecmp before entering
the suspend state and restore it in the resume path.

changes in v3:
1. Update the commit description
2. Remove csr_read/write_hi_lo from the previous patch
Link: https://lore.kernel.org/lkml/20240926065422.226518-1-nick.hu@sifive.com/T/

changes in v2:
1. Add csr_read/write_hi_lo operations
2. Apply the suggestion from Anup.
Link: https://lore.kernel.org/lkml/20240829033904.477200-3-nick.hu@sifive.com/T/#u

Nick Hu (2):
  riscv: Add stimecmp save and restore
  clocksource/drivers/timer-riscv: Stop stimecmp when cpu hotplug

 arch/riscv/include/asm/suspend.h  |  4 ++++
 arch/riscv/kernel/suspend.c       | 14 ++++++++++++++
 drivers/clocksource/timer-riscv.c |  6 ++++++
 3 files changed, 24 insertions(+)

-- 
2.34.1


