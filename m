Return-Path: <linux-pm+bounces-30701-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11982B0202E
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jul 2025 17:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 382505444EB
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jul 2025 15:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9FB32EA472;
	Fri, 11 Jul 2025 15:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mlk5A6WU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9FE154423;
	Fri, 11 Jul 2025 15:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752246726; cv=none; b=qgpB2mKDzHvGKRHdgYAA3bbmNFT2N5k5SQUmDedNl0prfpYiwatxX0/m7z1f1+5mtvzUoizuyXeKxlCIc8fYN7f9ljz1AtZqAnGL7XW5FX3rd/SHIWaPSIq6ig+vtqWYHQaZzwiv9WUay4jO3jWmMO7J1g+a9cJ38FZMkzkoM1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752246726; c=relaxed/simple;
	bh=iVUdtKHsIH9j6954iC4BjCq8Kw47teU5CX0hHrJrfME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=USzP6pGhWYq07p0qQ0IxM467yww7W88TYwZ1FvryGfdjcKC7gxu/Y+4vhaoqwuBjxHXS+XN6Ff6I8awwX6B4gxsvE3UklxOX9Up1TKX2dddDs+9jiCRAH+ZL1itNdNeN3SfKz5dxOvMetzG72e9Lbqt7qOgJqW9UoDExakgAcKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mlk5A6WU; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4550709f2c1so5433365e9.3;
        Fri, 11 Jul 2025 08:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752246723; x=1752851523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gJaPm1lMunBuJsIarfrEFBdm2bsr8m/Si3CqGhSSbGg=;
        b=Mlk5A6WUgrLnzRmvn+1nP3Nw0iUOnNXGsbAF8MfGHfgmnchoxzJKxKO1ubmaTIbTr/
         FVaIkVD6VMzqHNFalncPR01xGVJJxfzrMRZxVaKeaLNF+uxml/IXcs4XAT7daKGZ7QAx
         w76D7OHknoNOnhocYpZko6Zn5EY4VT4FhmvQm2kAjlK1ZXw3ltkDhaNuyzFYsXep1QtS
         pm6HzfLS/6YDWb4Oog2l9I7KoZGv6HtUWyyemUwz7y4cf5pmxZhrBwYdHwvz7d0vol0T
         ZlO8QZb9eEejydH0i2H9JuezPesTlKO4meE+v7sMiFj63rIB9GmaPDGeiYLom7PBoxgw
         Qp6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752246723; x=1752851523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gJaPm1lMunBuJsIarfrEFBdm2bsr8m/Si3CqGhSSbGg=;
        b=W3INKwwtQMxu558CCU07B7EQpSxkE2bWbV9Ie4xwVytn1VVm0hGJjKKdoGAObadQNx
         XKluz2e1zjDbNkArEBoj2E/c7dQGwixKV2QbK5WAGNcCTEsuRqYpE+ZdZor1iIHfUO39
         TYv5HbbB0dsWvWRo5kJzTnMZjgExqXNEz40eqh9co+LoOKi9v0LVljCAp2X3U/1kWBUz
         2McOVIozdW15bAJiBooavktYqBN6wj02s43zkkfPgV6fOPVqIFGmNONgJXUkVathgEnL
         xVe/ZtkQu60G+JGS4WkzA7NPkURtGAbTKGoUGIsJiga2vHQxzEgCS43txh4CeOPBDrEB
         GgoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIDYhtUOYUlyeY++pzEoaIOPNpCQA04+kgVOihR0PcoZNAK7TWErAU7YxJ+tsx6g2swsB4jogrHa97sIo=@vger.kernel.org, AJvYcCV2kxPDw4aapbs266o8Kuoj9QDI2+SuNws8rWkiVJPjOsCExZhJ3peQlZgL8CGuA3XuryI3eUijKgcU@vger.kernel.org, AJvYcCXWY54UtixXQp72RRbTTt5bQkl/OrhSIxtvWsbM3wBhdveybowgv7ngNqZXAITXSaGfCp1fpRm20vxoYl7y@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd1v6YYfbN4gibrzU5fqWCzOk7wZ80o94AS6rj81r06mP7S6Wi
	i6FtL7Tks0t1zMktrjjfAOticdkTEOrPiLLM1xxAqNEr6kFIpWZTnM/Z
X-Gm-Gg: ASbGnctP2LJ0/06jSLXsCyDibHmQtwzonTBeY6NkcAlkID5dLxbP1o2Eu0sGySIAi9z
	9YZcaGK8vuYiCuSf1ERcr/dL2UcLWUYNU4TJDeJoWfraw3Po76NZyxmSEOPM77W0vqii3xiOjht
	YQ/ONeu9Cv2SHeyYKi8Mkc7hKLaIV0faNgqcC68B7466FwByN7iC+qFuJozeU0ystlbDeiXIYe2
	IE8c88x51uwZMQNTiom/bvRb27vljAtqPSN5Ok/wJigzZRRGrwGmuJAXDXyPdVMxtnFvjxbMXrI
	i+ezdojL7rXuxKURp3XfcHq8f0bDtRdvDLQGMaa+zgF6BgRZcBmTghsJh5b+aJTLkisUuD+tZfA
	/a1s8LCXncU+LdIC4xzdzRteLLFsbyuRX/fryqzMs5CbS4btZcYXUn4rrN1ZGIRKHaL3l5DIIdw
	rV8ywsDlNdMq8muQ==
X-Google-Smtp-Source: AGHT+IGXPzQSYE2XvE2dWikKvOgW4Jyizw9TRoNhVOE879ukI6LU+6xfeZ58AxAiebEynIiujRR5Kw==
X-Received: by 2002:a05:600c:828a:b0:43d:9d5:474d with SMTP id 5b1f17b1804b1-455c6197d55mr29457315e9.0.1752246723185;
        Fri, 11 Jul 2025 08:12:03 -0700 (PDT)
Received: from localhost (p200300e41f4e9b00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f4e:9b00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-454dd537c6fsm50415865e9.21.2025.07.11.08.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 08:12:02 -0700 (PDT)
From: Thierry Reding <thierry.reding@gmail.com>
To: Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Aradhya Bhatia <a-bhatia1@ti.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: Re: (subset) [PATCH v3 0/4] power: supply: add support for Pegatron Chagall battery
Date: Fri, 11 Jul 2025 17:11:59 +0200
Message-ID: <175224669831.1544516.5588804600832488421.b4-ty@nvidia.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250429061803.9581-1-clamor95@gmail.com>
References: <20250429061803.9581-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Thierry Reding <treding@nvidia.com>


On Tue, 29 Apr 2025 09:17:58 +0300, Svyatoslav Ryhel wrote:
> The Pegatron Chagall is an Android tablet utilizing a customized Cypress
> CG7153AM microcontroller (MCU) as its battery fuel gauge. It supports a
> single-cell battery and features a dual-color charging LED.
> 

Applied, thanks!

[4/4] ARM: tegra: chagall: Add embedded controller node
      commit: 3c2c00572fc3e0b128f75c7ce9c3f70ca457cc3b

Best regards,
-- 
Thierry Reding <treding@nvidia.com>

