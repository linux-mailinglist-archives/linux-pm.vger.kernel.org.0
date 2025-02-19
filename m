Return-Path: <linux-pm+bounces-22485-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89ACFA3C9A4
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 21:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD1CA17257A
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 20:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E2D22FF44;
	Wed, 19 Feb 2025 20:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HcuQRQF7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC8F22FF32;
	Wed, 19 Feb 2025 20:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739996721; cv=none; b=nGn42ZZ3QVzRCeYudo584hkSUiRQBkto/8pb4tkLGxNmuaYAVZcHqLGDUHYIV+Ugjczxpuv+u4wjsNjMAZe6YMqJnge5EswnrZhQtrRf1fUHBpaiBcSMd9U1HaPq/tIMUcDq5sju8k1l5p3zP8Cr6nrb1hQ78ESmH4J9u0mABEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739996721; c=relaxed/simple;
	bh=z2Itno5XHizBUyP+XMgPT9B/6BDBul2rQNllFEnJbYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WaT8OHRAZQiSckg/Zobc/HlJuYjG2u08FjmzqnccQMojqzuznlKHhCgQHLP5s6jvyaqHbbblqFZeuRPNpPMAImbL5cZTwrX4/225xhODcJDcNEqjLkfVUeCnEMCLn2he5fk3+P8PN6bTYiuYPiQxIut8pLsT3EnHHKoGoDN+B9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HcuQRQF7; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-439a2780b44so1019495e9.1;
        Wed, 19 Feb 2025 12:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739996718; x=1740601518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z2Itno5XHizBUyP+XMgPT9B/6BDBul2rQNllFEnJbYc=;
        b=HcuQRQF7ClxYHXG1VR1y0d+vcjsBfGjUFkxpQg8mh4NS2iE37+56ghiEFYvcTQ8wmh
         IGBYAiL9gVE86ybBNRJn1QZ8YZgCjv8jh7SoC5tzl/ZiN3ntL1HT9hecwzjjuMYRDzJR
         P6tN9ZP4e3IFPdeHCu/HeTrSniK4WbRcTUe6u1YpR0ov1FxX8O1Tx1YI+n22TW60IQ05
         fuvqJyxcQd4H27ho1PnFMXoNPKu6/tQuWXeMBCj6r4XBcnvm5DWfb5Or3V1kjeIvYnBj
         uHTYEH4HrBaHDIYjzb+EFC35/PhRIqtRAC1r1CtBQV5Xd/9EuJ5mOOre7ytdzgwPIO5o
         VCOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739996718; x=1740601518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z2Itno5XHizBUyP+XMgPT9B/6BDBul2rQNllFEnJbYc=;
        b=cIyR/6r9lSgNEAuJLS6VtXDo4iy7S16bZ/w0aK1+YUmGEMvGatCWB8LKQ78D93bPCU
         WL5qIO4ngYb5LkIGB8wGsNHzyZAt5biBLxLlfngf36HQ2qHh+oqNoAftdOqQEDVWZcdS
         sMqXjH1IS8BxwfOsQQUWyCBCB64D6m53YQiuiMWBEb5PtgB9YdBmLPqy9AEaYANwyQBD
         kPXXSIl6YL3wHVEyf4B78CFeG5I4iHm3YDXnvkgQSJnPxeMKJQO3sY0zNQ+758f9hLR7
         aGvExrQtK2Jmh8pAuhGn8GiXq0tl5FtzaoL8dsKdwTOoGJiTjv4YsscGylLmpreMzL1v
         ZxFw==
X-Forwarded-Encrypted: i=1; AJvYcCWCJoJEVsQPNIfK4nP+EZgjZrTa0U4mhrAx02CGreQqKpD5VVXMBMi83iD0UTCrASpNJ59060LSAXzJtQ==@vger.kernel.org, AJvYcCWeGz/xC904a9/nc1hSikMP29BA0Tq31RyyNx8ncvjFT2ULCn+sUsgEaqhq5Ew09q+2PpzMd4NUAA7i@vger.kernel.org, AJvYcCWtAQj+XyJavm+4O+XB887cUptpfxwe7Pqb6JRilzyuQH4m8t8VpGiWVOl/rwqzvUS5Tc13vgwD6pCUn/Yj@vger.kernel.org, AJvYcCXkW0PuS9oNSSAWa6kyPVSdOyuEbrVZXUGL6p9ihptsBXq7scd+JBbrDFVoD3/qHTeVr0nlPfsU5Dg=@vger.kernel.org, AJvYcCXyA9VPC/rUeX20jduPKu1Vk5tZPv9yHzvDW/KYQE3qYxnhUAN3bXF0RL6UubYxu1qDRrUZBMfyCbKB@vger.kernel.org
X-Gm-Message-State: AOJu0Yy71WElrG8GQbLnhsyvbKQLcVWxCk30Bytkrs9t9gBYL1o67zaN
	VfcUtOwSM4uzOeokdPp39BfnvQUnmYaolTSBtfN+p6tu51nuGSuR
X-Gm-Gg: ASbGncsjd+V3v5Irqeeiu5sVfZYX6XW+YiMyGQe3C4PaiRxLpnG/YoVLjqw3s76UfqL
	2u+VwXTRA5eXKburT6A8ldYbpTGkU0Lvamr1oL5otKNEce7iIWwgChpBQskJVXed1OT8W3mUrWj
	bXkZMan04hHEx2Ceba6CvJ2NvEhQYFelU8nnrZ8twHC5Y+M2Ds5DTIx8NNtSLD+Z+VIgUxoZqYQ
	sZWlhgcSwMjyVh6gSZ3JTB1cQs1pwTuFS/FV58I7YXCQbLSqkKU0SJ6psP5TBrDoOEguZvfueuI
	pWO5M5cFPW1wShLchsdHGAY4PF//Eu823/xbSV514U39rTs4LgmnZs2NNL9tMOFT7g0=
X-Google-Smtp-Source: AGHT+IHf4EAn7H3CMgTwZHs2HxQi2OgH2VAHDrFSev5fKHMaDGPeUF2VlnzgRIOgA7Yc1ikIuakyZg==
X-Received: by 2002:a5d:5f8c:0:b0:38f:3e8d:dd42 with SMTP id ffacd0b85a97d-38f587f3f3emr5580525f8f.53.1739996718008;
        Wed, 19 Feb 2025 12:25:18 -0800 (PST)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258f0597sm18467209f8f.42.2025.02.19.12.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 12:25:17 -0800 (PST)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, Maxime Ripard <mripard@kernel.org>,
 Andras Szemzo <szemzo.andras@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-gpio@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 08/10] phy: allwinner: add v853 usb phy compatible
Date: Wed, 19 Feb 2025 21:25:15 +0100
Message-ID: <4604743.8F6SAcFxjW@jernej-laptop>
In-Reply-To: <20250205125225.1152849-9-szemzo.andras@gmail.com>
References:
 <20250205125225.1152849-1-szemzo.andras@gmail.com>
 <20250205125225.1152849-9-szemzo.andras@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne sreda, 5. februar 2025 ob 13:52:23 Srednjeevropski standardni =C4=8Das =
je Andras Szemzo napisal(a):
> V853 has a dual role USB phy, similar to other Allwinner devices, but with
> only one phy. Add a compatible for it.
>=20
> Signed-off-by: Andras Szemzo <szemzo.andras@gmail.com>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej



