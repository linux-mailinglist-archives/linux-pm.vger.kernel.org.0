Return-Path: <linux-pm+bounces-26298-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4567AA9E355
	for <lists+linux-pm@lfdr.de>; Sun, 27 Apr 2025 15:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F1F97A9018
	for <lists+linux-pm@lfdr.de>; Sun, 27 Apr 2025 13:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B4A19882B;
	Sun, 27 Apr 2025 13:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="FU5NM75h"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D4B15689A
	for <linux-pm@vger.kernel.org>; Sun, 27 Apr 2025 13:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745761281; cv=none; b=VmpMRGMGYupl4LOYAToB91gtHAcQSDxBfjgUzQBhBa+rHMY28i4ccw4T0ZExpNd0dn7VVu55Tfo4UhyTZUu4e7UcN6gBgQNW991fNLEweRgin0B4LeZD6cB5/0r4GAjdXcEPkAxNX/IdfMwqJAmSaWoX3EBbUb5Fs7JiiC5w/jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745761281; c=relaxed/simple;
	bh=VnALKFAe0qO+P//pjggZT55wiJFa5E0L8cO8PSW+xlk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qTtmzS4GSSXT/erCApAtQtY04BSpGvURyNAPKuBEZn/zdiyJM1KC9IbUgy1kpjbQXcD79XRuwpiSRUiZti/3SNPU4UDlFSm3+FfQjEoXx4fETrHyy9M3DWH+sXCeonNyhyx3jeloujyH4t0HRT/UPuUcamKRfla/lthWryWPbjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=FU5NM75h; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5f6c3f7b0b0so7165310a12.0
        for <linux-pm@vger.kernel.org>; Sun, 27 Apr 2025 06:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1745761277; x=1746366077; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lgLsTHFUHPVY+MlDYOlPHI/6Yw7FnfxYmbCzXZmnW0Y=;
        b=FU5NM75hacbjTf/WjGAOYbr9cn1stb2HOpic2Du6PWnwncKLp4aPXdkPF5KjMGhbrX
         Gvr8s5MvTxKirq5OrANmVJVHWfPJF3pppY011xlYp8aaePN09xwPUpWERsnzZguHh/AE
         QISf2GAd4yJheDVooxIwgFB9NEW5Qx+4zweppybxiqpLfVyVcHJzDHoR2RZ6x6nlTORK
         sTXDO7JYfxh9j74YH/QOisoVzdfJtITcdcmRx4EzdSvVVWjJP3i4ZOP7R/ef8TMzIF/P
         tfQmsFETVTgFd9T15EHe6wPw30596qui0O+H9Uyc3BBeV/TWzZh1e6xz6SM+iauBG2Ie
         UXTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745761277; x=1746366077;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lgLsTHFUHPVY+MlDYOlPHI/6Yw7FnfxYmbCzXZmnW0Y=;
        b=ak/kIDANBkzeS72LWWDlYSd5Kkz3R9LEVN6r2UZfhJSDlE8j6LDPOTOZSh8qZjVCzG
         lrEBMLbo5E78SgNbHkKQN/1ScLEjsFrzJizE42lzpc24ZosTx2I3jWUIyBfyEO4DInIF
         Fke9cNfTK1lgXjSZbPMc48NQjvR3TalbTr0uZDDAOLtcu2W8EAJS5W0cI2Rd+ui/IGjC
         jVKJSiCDoRYshV9ADFsvqjYvnod1jC6nKNWlswenMhUIJi+mttOjw5lPJL1Vnm5Tqv7K
         UGoiPo60u2WC8QtKVHZVKEAGKKPgRMj0XqKu2o558WPW5XvLUd9VI2X0m2X9sTI1oohY
         V/kw==
X-Forwarded-Encrypted: i=1; AJvYcCUOVAG+/nSUupk1ZgXdfnt9sm22368hBiDG3hi53RTfLaEuDNXbA0ZvFm2c0s/y4suknj8XImTx6A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxFQaLPHnrxCj4AKOoPbfPdRaBUlbcWsJwV7G3erm+qsf+ekD4I
	9TPERBU1vWCZioW58qXwdLFTmiUMTsoXgvO0PyQsLy0M7J27Q0WOhBm6lETd5Mc=
X-Gm-Gg: ASbGncubmyDXJCFAqd+KTU25eI6qsYcOQJ3cx7Bz0xV+1muboQy4O6vaeigSfkRDJVA
	MNVFxVgDqWU9hbJukVujd/S8rOsHt6qneYwwtI4AZ4xc6RrAie6b1UqB4jZYxqStKpDs0GKxpoj
	WHdNsKEOJ840SDUMf5H8GbzBCMhzrqU8OTHlL4ida7c7xzwOW1EwKHsnn+OR8+EaArN4uj3RzPz
	2keoaRpn8xRjmordPYn2J3GFfAjePtzhJxSwetqg3sreuVTSH/knhTSdrXXvJ/Gg7Olp9I6iA7F
	wRHS3DYqNV2M+nBLAcQdyx9xHJdJHVF9nynRl+aren7H6xfeDa5qzhOoEJCi
X-Google-Smtp-Source: AGHT+IFjvYNUHCZ3dPrDRyEa/OPDZMNfSszUTn/p2tnOnx4im+io+5tXp8qpQenDsLlwqL9uw5wHmg==
X-Received: by 2002:a05:6402:2691:b0:5e7:c773:ae35 with SMTP id 4fb4d7f45d1cf-5f722672b22mr7593685a12.5.1745761277306;
        Sun, 27 Apr 2025 06:41:17 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.145])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f7013ff570sm4139225a12.23.2025.04.27.06.41.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Apr 2025 06:41:15 -0700 (PDT)
Message-ID: <86068277-5443-435d-b1cb-0d1a5731b331@tuxon.dev>
Date: Sun, 27 Apr 2025 16:41:14 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/11] Enable Power Modes Support for SAMA7D65 SoC
To: Ryan.Wanner@microchip.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, lee@kernel.org, sre@kernel.org,
 p.zabel@pengutronix.de
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-rtc@vger.kernel.org
References: <cover.1744666011.git.Ryan.Wanner@microchip.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <cover.1744666011.git.Ryan.Wanner@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 15.04.2025 00:41, Ryan.Wanner@microchip.com wrote:
>   ARM: dts: microchip: sama7d65: Add SRAM and DRAM components support
>   ARM: dts: microchip: sama7d65: Add RTT and GPBR Support for sama7d65
>     SoC
>   ARM: dts: microchip: sama7d65: Add RTT timer to curiosity board

Applied to at91-dt, thanks!

