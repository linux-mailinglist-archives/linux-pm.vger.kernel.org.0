Return-Path: <linux-pm+bounces-3927-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07EF0855414
	for <lists+linux-pm@lfdr.de>; Wed, 14 Feb 2024 21:35:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AFB21C2825B
	for <lists+linux-pm@lfdr.de>; Wed, 14 Feb 2024 20:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C9638F86;
	Wed, 14 Feb 2024 20:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UTYJ8qsH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E6C1DDE7;
	Wed, 14 Feb 2024 20:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707942947; cv=none; b=qA+rhzi3+MLUXjLVnizC43SII30x3o6WpUGfgy6wHMLi+B7mf6YZOzg+6sF2mOA+XSaE6nkYxuLnMUmidtCSHyQSFdmE0vQw35z2sxgOg3nRsEm2cWnQ0LnCBhPVYgndDYEgjMZB+gnNZUTKCJdG+Ul0DXrqYWy2mTvAaZVmNCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707942947; c=relaxed/simple;
	bh=AwNGRr3P6UeHkwkfGk+RMyvN6HM4hjPVJ6icGLILO+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VKmrAe2tGdwqJitmwgomGpFfZa/o+lhlg4PLaV74Rv4kqr3aaQqyqswQOiKZ4qiuRblakKxq162sy1zt7Cn0ACsbJbXbsRTfAhi0pegf6nNQb5wvVKZRVZX6JVa3V44jyEWlOhT3uNirlJgda+mnod+O1qjhT56S05ekklYA77k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UTYJ8qsH; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5610cc8cc1aso175462a12.1;
        Wed, 14 Feb 2024 12:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707942944; x=1708547744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZoK5DDGECT3y2yC/4x+K2eF6VlIMfrM4/DtWMEfIDm0=;
        b=UTYJ8qsH4s4MNop4dH3rWrTr5ge1/TZOGE0HYQJUu+BRLNRP/B6DN8oQiTNxodLkBe
         0jmREJQK/17VIENUlKxqWI+kMn1nhvs5RWM7r3gYFX3wfZoZGgTZyvq8dJIiyaEo9Y35
         3y9OtkZo13RS/ZPnuSefruOOfdCvL8efOgfEsh714ZwbyPBh3X0ZJ4Tl7fOrYGC1xJDq
         CXd1O2oL7E7r3VT9Kv3UG1pl/+Nb2kX9nzYNPniB2MJe01DQUAetWuwaqF+MCLjwFkHf
         kLw7zNEBT7KlB9rkSpHCOAi9DyaSW3w9H6YYWNODFJY9dBpvBgnwJvU/7ROEgfEVhF6T
         tV9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707942944; x=1708547744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZoK5DDGECT3y2yC/4x+K2eF6VlIMfrM4/DtWMEfIDm0=;
        b=Y/80MWuihCm1/0M4JZNEfvCXId2YjtJizOdd1Z1j3J5cIcKg5ozpyLTF/kGXr32fug
         bKxbeuTynCFeNf+Xi+6cs0uVgu+ZKqT9kd8uTl3sNjUnuOMXXiAqA8q2irO2K8FoS3WZ
         8IxrWDz75T03NyJKI2R0ZZwrYMUQdORqcjhPQtFAiFPz1xHgv1B+HblIPf7C3HKcmmqV
         wYfo+lXknI4JrTUpaMXN6OipuDti2V/8E/xhU6Df6wxzcpbYagOtbZpnL8jbF1EK+R9D
         BV6SqSNNMXgI/8/YP/sYQfNvDk4LVESKVkOAzD49gpAKXHxu6fSbXxFDHCmMNoj2eM1L
         FIxg==
X-Forwarded-Encrypted: i=1; AJvYcCUYg90tNju/WOUHaA3NVDN75C+8gcrc7lLZi34+Z1+YJz+tTsromIABT9EuLEdSkfMTfD2C907Iqg29iL/dTnHbQqY8y/i8Yg/ODGlg8hlhHs9pWVMxBO4tfk0EFRCDJtitZK+g
X-Gm-Message-State: AOJu0Yy1m30Gog8mMztmvZVV0W4VhUutvj4AEkrYuyWanot9rcWDK7Zb
	+K2QZfvhSxdc818yFqyHTb40h/EQmGTeV502mMae8MTKLYj87o58
X-Google-Smtp-Source: AGHT+IE+6v6GkktwOFy5sYNfQpUQjHr1S06/NsGtwNn3OxmYTmNEbUvMzaogP/sq4WjmIpKbJQCNrg==
X-Received: by 2002:a05:6402:2ce:b0:563:7ee0:b865 with SMTP id b14-20020a05640202ce00b005637ee0b865mr1930319edx.15.1707942944090;
        Wed, 14 Feb 2024 12:35:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWNoa72Uu049WhSseEkbY6cpFGS1+Y7YTmDO7b4fU8At5Xq076737IJXdhaU2dEVwGWonzTMEUIlohLFHnCfBszBvLRR4bgUEXZejEEBwU/aRkosYABU9RauERH6+i6yTiQOJXMEmVbRoV1txWhydTAlG8OJpMjdwn5ixSkvsuFa7daogC9HQXDQXrOFO+YEgbK9jUxWdjpxnPdXXy+aNZB2XKSRQ6NlulC2ZhTy/ju2OtUTaMqGhia7Fv1AwMBy2wfIuXXuL9hq9SZYdl6SRFNzybrqP3gl4sskhVFXp5R5FaBcWqhhXg/xoYF6yFUslGtJG9VG+Ueu/vQEoQAvG8ErvJW9jEWSYm/4JA8radzy1/Ml/CmfxGJ/3P1L1xgnGSRsZBBcfqx16o7/CvLrRdshktygZrXw6HwTewDf/IBTbN6l4Dp4/2M/2BqO3mBNoEahyxDAOC4HX+FSJcdpJIlQN5jwvY5bHjNJhUaoAsi7PNwYZllhxUGrb1/tvRKhh2+qSQgFU65ZdnIjDxRJEYFZUB0vIBdrZQzE6i6SZorAzrNvWSKje9VY/+G04TNApmG5UAPTShhfQR/XaEKyd0O/psySHsdeWDKIiSVo7hoLCqhpUi8Ww==
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id fe9-20020a056402390900b00561ffe7adb2sm1627977edb.1.2024.02.14.12.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 12:35:43 -0800 (PST)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Vasily Khoruzhick <anarsoul@gmail.com>,
 Yangtao Li <tiny.windzz@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>, Andre Przywara <andre.przywara@arm.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Martin Botka <martin.botka@somainline.org>,
 Maksim Kiselev <bigunclemax@gmail.com>,
 Bob McChesney <bob@electricworry.net>, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev
Subject:
 Re: [PATCH v4 4/7] thermal: sun8i: extend H6 calibration to support 4 sensors
Date: Wed, 14 Feb 2024 21:35:42 +0100
Message-ID: <10416904.nUPlyArG6x@jernej-laptop>
In-Reply-To: <20240209144221.3602382-5-andre.przywara@arm.com>
References:
 <20240209144221.3602382-1-andre.przywara@arm.com>
 <20240209144221.3602382-5-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Dne petek, 09. februar 2024 ob 15:42:18 CET je Andre Przywara napisal(a):
> From: Maksim Kiselev <bigunclemax@gmail.com>
> 
> The H616 SoC resembles the H6 thermal sensor controller, with a few
> changes like four sensors.
> 
> Extend sun50i_h6_ths_calibrate() function to support calibration of
> these sensors.
> 
> Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
> Co-developed-by: Martin Botka <martin.botka@somainline.org>
> Reviewed-by: Andre Przywara <andre.przywara@arm.com>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej



