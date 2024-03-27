Return-Path: <linux-pm+bounces-5539-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9738D88F0C9
	for <lists+linux-pm@lfdr.de>; Wed, 27 Mar 2024 22:21:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9AE61C2DA54
	for <lists+linux-pm@lfdr.de>; Wed, 27 Mar 2024 21:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F02153586;
	Wed, 27 Mar 2024 21:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X/tPZq6X"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB21714F9F6;
	Wed, 27 Mar 2024 21:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711574455; cv=none; b=gbyAZ7gtxl78F8y7AxZ4a4jV/29KBHa5TEzhRGMV3GfdLpMKRqpXB3Z5RH2GzC5znrU/s0PAdS4IMTsvlZJk1nUy2gH7mzlXG/ybh/gysE/qFpTUyrY7emMlTYC4T/I9pmZMlwuz0QWYE3Xg2ykr130YnZzDIaSQWIY063MBlpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711574455; c=relaxed/simple;
	bh=pnXP6K294ueuIv/kd4uAMj7jIU4MOvwGOqzoM3iOzzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=klZfXAOCQV+B9WGKeNR4khAD39YELGxFwBeYfpuBWY83Bp9KV81ahGCrAQvTc552gWlNoUTOUGuD6MaMWL/Hnx0YKj5H9ko7Alve4lNWRI2N+n6BME9uNQ0KAMfeJbu06trDsBnX1d13CQgmtUoH1bVOgNqCjOrTwKqnI3kDw+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X/tPZq6X; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5101cd91017so261129e87.2;
        Wed, 27 Mar 2024 14:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711574452; x=1712179252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ucufKvF5D/Jm5nZ+VW2enZzweqIXCgOTEb9SfQn2sM=;
        b=X/tPZq6XXo7gLxdQCgImD1nfdnXx5KeZPai3P5an0rdqmbup6Pt7xzcoZrw6Vb10N0
         G/LBC4XGA5I/JpTcOK3eDS/nkK7ez4J94Pqf+sSmvuizNLv9WJ8Poy1a4iiRg9OapgnR
         6VdAL5oq29yx2rtSl/wkB1kGhfQlIUVTN7Y5YhosiOUuXyuMVHgAx6pgHXlDDkIos8JZ
         x5XWZict1i3uQ5bGfrhFPFkVoY9NOoswrFb83js3hqgaZebbBbAAr73GmBZO6BtuLlmk
         7jRydw2v4Ex5b7KfCurSZzJMonxszk5ZFxLrJJ1wX1l3auf9/rHI7mKJe+Lz4JeQhM/9
         uZhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711574452; x=1712179252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ucufKvF5D/Jm5nZ+VW2enZzweqIXCgOTEb9SfQn2sM=;
        b=vquEdSSpZxqbmg/sgdL+RJqPBkbJ4O5XpudRRbuIZrQZJhe22iZv1wLVQYxDVsFMaR
         0Ey54+pvMxr0bx3Pu5a2bEatwctHDUYJIqijnCM74LHuff1NpiuXi8igZjlnqYOGuIZ9
         sBhwwhZqSeos4FcJeVrBYT8i9M8R/4Eps7trNAOZaKer0zDj5rhI36U6lImA+3xRO9Pf
         xzAb+Il83kkb/02bdNyViti/qQoY9ApHqffCLQmu3cvUSPYPhyujzKG6R16vXeOHMibT
         5mnQGZVTjLZ4espjSBpY5RsPhZmQzG/BGtCUMiZVHnlrQb3b1/9fPH7T0BML0wSnxvaI
         YeUg==
X-Forwarded-Encrypted: i=1; AJvYcCWb+V8oLlzRBdezi7ME2QwHPBRcbCVE7qwgC2VqfBGEDHmBQSyFjMjBgeh57J1VS9js5ibG6ThemFI7YX2lII5sCm9qIfnCG8Pdng==
X-Gm-Message-State: AOJu0YylvNzxE5LI1aEsh5K/2aKB8fJAqz7ZCUT17JTKPkPXztlxMRJi
	OuQXFiJI9Vt1LEMo8+qcDZS6T6qadushGAdphCuPBDHER/DdRYhX
X-Google-Smtp-Source: AGHT+IHz7ApOV4i4Dlb6iEnYuE8q/XfKfM2eV0rEqwdimV+tXaq/DQ/NttKfOC6IwUiIzIH/JNGmrQ==
X-Received: by 2002:a19:5e10:0:b0:515:a530:d570 with SMTP id s16-20020a195e10000000b00515a530d570mr439705lfb.59.1711574451864;
        Wed, 27 Mar 2024 14:20:51 -0700 (PDT)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id q2-20020a1709060e4200b00a4674ad8ab9sm5809630eji.211.2024.03.27.14.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 14:20:51 -0700 (PDT)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Yangtao Li <tiny.windzz@gmail.com>, Viresh Kumar <vireshk@kernel.org>,
 Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Andre Przywara <andre.przywara@arm.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-sunxi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 Brandon Cheo Fusi <fusibrandon13@gmail.com>,
 Martin Botka <martin.botka@somainline.org>,
 Martin Botka <martin.botka1@gmail.com>,
 Chris Morgan <macroalpha82@gmail.com>, Ryan Walklin <ryan@testtoast.com>
Subject: Re: [PATCH v3 5/8] cpufreq: sun50i: Add support for opp_supported_hw
Date: Wed, 27 Mar 2024 22:20:50 +0100
Message-ID: <1853595.atdPhlSkOF@jernej-laptop>
In-Reply-To: <20240326114743.712167-6-andre.przywara@arm.com>
References:
 <20240326114743.712167-1-andre.przywara@arm.com>
 <20240326114743.712167-6-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Dne torek, 26. marec 2024 ob 12:47:40 CET je Andre Przywara napisal(a):
> The opp_supported_hw DT property allows the DT to specify a mask of chip
> revisions that a certain OPP is eligible for. This allows for easy
> limiting of maximum frequencies, for instance.
> 
> Add support for that in the sun50i-cpufreq-nvmem driver. We support both
> the existing opp-microvolt suffix properties as well as the
> opp-supported-hw property, the generic code figures out which is needed
> automatically.
> However if none of the DT OPP nodes contain an opp-supported-hw
> property, the core code will ignore all OPPs and the driver will fail
> probing. So check the DT's eligibility first before using that feature.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej



