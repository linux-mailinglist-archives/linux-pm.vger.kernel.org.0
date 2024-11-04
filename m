Return-Path: <linux-pm+bounces-16950-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2AB9BB54D
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 14:03:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 769F61F219D8
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 13:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404C31B6CFB;
	Mon,  4 Nov 2024 13:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g9HfkBhs"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930D7381B1;
	Mon,  4 Nov 2024 13:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730725413; cv=none; b=DfX37Yj0FGhDIuC/PrXWHSZZBKdGG3lJ8s2Q4Lui6KutW2sskSP6G//IqCsZVYV7qHAuUGOli1PW+bCBgerdFYxcQM8RB6KM9hWTz4aSidrth5sL971L3QlJQ+TYv73dvpW1Fy5BsqnwP+iGDgTHEWglI0mHXTQtkOEcrBOMR9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730725413; c=relaxed/simple;
	bh=bYh6V3K5DjFWn+ofN6Mv26qITEiIb8G7g1SR2SXl+ro=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=i17krdq3YBvmeSGF6IF+Px3fAVKrir2lOJY6yQIYolE0ifL/suGRriKZMUbljWgwV87ayaz8A1ZwW4WNwSRJ9ba7YhMlgnd0HLrkICumnR1/H4dhuu9xvTKAzWeCAI4NwFpfsk0T04HsRN546t/Zajn/5qYQpz021/zlHYwJK4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g9HfkBhs; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5c903f5bd0eso7569873a12.3;
        Mon, 04 Nov 2024 05:03:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730725410; x=1731330210; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6ZIvZCeqy7RfdP5tDZOW6ypxwB8F2fLxo5+2BC+8L5k=;
        b=g9HfkBhsehm2oW0EKGr17tIsxCLWXUKcZaytCoirsc9LyyUgpIXSAh000h22paTtVy
         gUuqCTWrYjANzbztHTNI6gIuDbmCN2VaAtwYF3bQwPBCieVYT7G+QlMMJVDJR0v1YJsD
         SSgphUL2zam4k7QOzopNrk3bkF7xo84Srr+F+HiGqts+g9cPyouKMKMOe1bSpU3JLcGl
         ngdF7LkOKbXzXmhhlQzhCVA1Wp6VVScJv1pppSg8XU00BMP2GK9+cAuwaNtb7b238xOG
         UwbrPY+XwQhfmMak2voWjS2N6EXIPflzO+1HdZHHVChVTrCy4R5/dcs9zx3RUPlki4/X
         oFTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730725410; x=1731330210;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6ZIvZCeqy7RfdP5tDZOW6ypxwB8F2fLxo5+2BC+8L5k=;
        b=gYWA4Y2chGPG0jG1Cb3cVOPJc/1SXde67erVXGf5y9Bivso/oiwR+bQHks9UJsEs96
         mC8aC1j3lc2ISnLWggAjLsUhB3XH4TPvlsngz4c59Tbqx6+dnPhRO/gZRX8avUaNQBrQ
         HwtQLvelEDF5L8VtvuzsfkAuhIRAquGxyT17TuF7tCcKCYScLRjI1suoWzT3k4TiSoSQ
         GnonzRExvU1RhfHX/eTiddcr5ogVB44ggcVeuZqLc4O7tHD+6Zsbx5HwOOM8wQUjf7XA
         Yfp0YSpYccb2fkJoLLztzg6BhEOKo/0N5d7wqee8lqIjbBc7lVBQGfmMFBkwWd8PIYaL
         MqQg==
X-Forwarded-Encrypted: i=1; AJvYcCU30359fBFobTcR4bywQwEEYB2rG4Kzbkw21pa9wjQla2bY2ZvRCB8Y8CXQfmdqfycwRoyQMwsGQcR7kGwS@vger.kernel.org, AJvYcCVf4qL4SlXaDbPA3Hru4EcWGABLvmAFILwLuU9TwgCbi37AXfc66n3PhDN3g2aGBZotGqd+7uK4IkNy@vger.kernel.org
X-Gm-Message-State: AOJu0YyvmXFf6qqBeoKTUAPGIhG1juqFAOUcO4KII+H0d8nQj7e49uYy
	/WKjayF+QH42qGoRgPqhpu54QJbNV//hVObIRxp5H2bSGY/hVizY
X-Google-Smtp-Source: AGHT+IFaOtQwdKPI4uQZK81r7i0bcchN1Pv3yyCSooI1ke+iqHYxVn2ST/ZCYtu1mp1g/FAUxwlMwQ==
X-Received: by 2002:a05:6402:5107:b0:5ce:dde6:dd6f with SMTP id 4fb4d7f45d1cf-5cedde6de53mr1504660a12.24.1730725409545;
        Mon, 04 Nov 2024 05:03:29 -0800 (PST)
Received: from standask-GA-A55M-S2HP (lu-nat-113-247.ehs.sk. [188.123.113.247])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ceac770226sm4216379a12.37.2024.11.04.05.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 05:03:29 -0800 (PST)
Date: Mon, 4 Nov 2024 14:03:27 +0100
From: Stanislav Jakubek <stano.jakubek@gmail.com>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] sc27xx-fuel-gauge: fix battery detect
Message-ID: <cover.1730720720.git.stano.jakubek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Marked this as V2, since the DTS (last) patch is a continuation of
the 2nd patch from [1].

[1] https://lore.kernel.org/lkml/cover.1723716331.git.stano.jakubek@gmail.com/

Stanislav Jakubek (3):
  dt-bindings: power: supply: sc27xx-fg: document deprecated
    bat-detect-gpio
  power: supply: sc27xx: Fix battery detect GPIO probe
  arm64: dts: sprd: Fix battery-detect-gpios property

 .../devicetree/bindings/power/supply/sc27xx-fg.yaml    |  5 +++++
 arch/arm64/boot/dts/sprd/sc2731.dtsi                   |  2 +-
 drivers/power/supply/sc27xx_fuel_gauge.c               | 10 +++++++---
 3 files changed, 13 insertions(+), 4 deletions(-)

-- 
2.43.0


