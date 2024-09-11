Return-Path: <linux-pm+bounces-14019-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C290C9751A6
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 14:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01A2D1C229AF
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 12:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3457F199926;
	Wed, 11 Sep 2024 12:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G5aFGvH4"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6FB189BBD;
	Wed, 11 Sep 2024 12:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726056838; cv=none; b=Hc30TkkM+onTbLkaq3/7/07UheUsf25SNqxO5E13WAQsbMhJjaAuNQ9qmb9CWUgDPGInJw0r+hHBE8NHHx7SWub87TmfiiV+4fUQG8bI5qZJkEFg4YauhmJZm1WBz0fa+uS6zKBPgoHrLqkE+Rd3nrw1snbw51nsZXxOZFg8GkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726056838; c=relaxed/simple;
	bh=CKO7NWWWSz2NvVfR0jjP8DjzbrlPQ0zU6QxXmpTDue0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NLNOfeE6jzU+jK1JxBCCLRaQklCrIcJp9pdg0iHiGZsUNscjHJdXq7Z2akyPO2f0bR8FKdu46pxUkf/6dFzIayn2IqKujH0JMiWPAusjqgsylxFuiJx4trk9eInbhrHGS3IitRw1jHtQ2zqNniEWlo6b+ZKKQtnHuaWPloD9k0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G5aFGvH4; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-206b9455460so7595935ad.0;
        Wed, 11 Sep 2024 05:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726056836; x=1726661636; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CKO7NWWWSz2NvVfR0jjP8DjzbrlPQ0zU6QxXmpTDue0=;
        b=G5aFGvH4co+Q1A9VpjjF/wBDn/NbCB1Fs/RgTVJBbb7zvJ51psyvgkBhNLw03AjoSD
         fHQq8/8EkQiwrlV4nzatg6gHc7lsioKJkUwLzp24GMKHGG2bK1YfyJA/5/aXbpcXOJet
         5WFmZPZTUDGwKhMi2zpIYTCZy686KStKal2TF1AesSbIZomtNdo1E0JdVTTx7J21lONj
         j9RJo8mkaWxSheYsIC5pvxxAyu2NA2z/Ep2kftUFzfJe3Od/MaM5fV0H4betWDOU3TuU
         H3nYM8X3g3np13hx3sJ8ldxMuRhkAxFKBgjsqx9MaUoqaills0AtuQgeRDhRxzSzoz+1
         1KYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726056836; x=1726661636;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CKO7NWWWSz2NvVfR0jjP8DjzbrlPQ0zU6QxXmpTDue0=;
        b=jTXYDVo0wYiTUALRMhbjGhSE5e2l6nY1W6ERw2Plblx29rfBEwmg0gxn6Fcota3w1o
         1TjDC1UuzMe9Du7LzIhNc80UBK5pbXQHoq3vbXBViJLOV1p67JS/xbybhEnj1epE9S1+
         ap2XpHaCBaSKOSC1BlDFXSDbTE/Di7cAlBCEQHBpzjnwI+mMNNKG2I4IT24E2pqLSBWh
         FdFKrGgegXZCRTtXZJIzvxTJ2rXzvwXABOQlOnhO+UrbnQAOcXtHtaG8KUBP0QNAtHVf
         wWsTgxFDVobt3iIv6WzKnKoHojDhUpoGe5ydjbngMZIathMuLvwof1+71a65iGQravUl
         3uLg==
X-Forwarded-Encrypted: i=1; AJvYcCW709MhEHMAFt7hhSGh899T8eSDXMFu7MmEIcwPBylzvjESmbPu2d0ycKr9wcWuSNDUYqspvOlbm8w=@vger.kernel.org, AJvYcCWP4ZQvNn9gEHwmZsqTcfswG5IuaKFQokiS3kPSH/lEtDcNzK2ZpdDsm7WhVO/dahtcka13IC6KVjON@vger.kernel.org, AJvYcCWbwcOU8J+LB/Pqxqr/2jyhNW/xkzYxZDmj1ml9mt5+lmx94mRbVaM0rMWE1/bSJz0nrqGpuxp7I+XFjM6x@vger.kernel.org, AJvYcCWwX2NHIXn9v8rWP2sCJZJOOXVE1un9E4HUi2p61W8nUaHSvKC6MihOLbnJe9utAIWGubZ7w+jgIyE+tA==@vger.kernel.org, AJvYcCXeAmREq3DiWVMFy9iwGxA/TReUpFnfm71BsT+xv89Ps6gEyF9/0lP+xcykg0wZTuDuG9lbjaLN19fTHaYRlqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKJk2FVafQqtN2NNo4sSc4QfJC8/uYlFYO8yOCpIjJ6do/XC2J
	oRnpYFrVEpF1WsmlIQhnUq2t8o5oOCssD7H+pL2hvLBGhnsO5+TH
X-Google-Smtp-Source: AGHT+IGdhEUo8Vuh9+fNRqoiJFys7qBs7E6vjNTWOIbdzrlIFWUOFggUlnmn8v6+uGErb/2AwctFPA==
X-Received: by 2002:a17:903:230b:b0:202:2e81:27cd with SMTP id d9443c01a7336-2074c760c12mr61204155ad.26.1726056835955;
        Wed, 11 Sep 2024 05:13:55 -0700 (PDT)
Received: from [172.20.10.2] ([49.130.85.218])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710f36266sm62138485ad.283.2024.09.11.05.13.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2024 05:13:55 -0700 (PDT)
Message-ID: <369a32dc-330e-4827-a61f-5686f7d90a07@gmail.com>
Date: Wed, 11 Sep 2024 20:13:48 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/22] Initial device trees for A7-A11 based Apple devices
To: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck
 <linux@roeck-us.net>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Mark Kettenis <kettenis@openbsd.org>, asahi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-watchdog@vger.kernel.org
Cc: Konrad Dybcio <konradybcio@kernel.org>,
 Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
References: <20240911084353.28888-2-towinchenmi@gmail.com>
Content-Language: en-MW
From: Nick Chan <towinchenmi@gmail.com>
In-Reply-To: <20240911084353.28888-2-towinchenmi@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The Home Button probably should be assigned KEY_MENU instead of
KEY_LEFTMETA.

Nick Chan

