Return-Path: <linux-pm+bounces-11949-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD9E949517
	for <lists+linux-pm@lfdr.de>; Tue,  6 Aug 2024 18:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8601C1F2A3CF
	for <lists+linux-pm@lfdr.de>; Tue,  6 Aug 2024 16:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B975339D;
	Tue,  6 Aug 2024 16:00:16 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0AB1F949
	for <linux-pm@vger.kernel.org>; Tue,  6 Aug 2024 16:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722960015; cv=none; b=q5vr0akg+i/byGMvcDUbLi/ndb+FNBLMFbc7VtGC1PgcRt2q6pwnZ6qS3iHfnm/+MccCMGsnIeYflvBrc4tI4QyJaJaJUH7LE5Armn1QM6YHN0eQT2FSM4R9Ph3uzY0cwsr6L7/QtO4JnhHkJl6KU+Qe/zrcG0kdojcHJu3ElIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722960015; c=relaxed/simple;
	bh=AJHk99JRG5OpJoSoQueFp2kEW1qBz/ld8n7MnXvLs9E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cLDs4tovEJ4yKtlWkj7d+ktLmIawdNeNHdw+a3teEIELENnEZgNdXzZPvU8vLT2iWMzdEEQUpt3TZBQpSAEZqJnI8LUeuDaKTKe0dDS5Blm/L7n8LMWwPxszbit1GyycEQTE2Kl5vLNjRMIh0F2yHuZCl6fozTbc724yrbl5x8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=baylibre.com; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fc5296e214so7480065ad.0
        for <linux-pm@vger.kernel.org>; Tue, 06 Aug 2024 09:00:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722960013; x=1723564813;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N0OH1lK0iyrEFjZ+sxfEDU/w6C/qIfjEuNJOJDkGoH0=;
        b=OSYIwXCEHslLTrmT6qexN0r2myLopVgAoR3ecXFtkdG82pLyocy+Xmb8hFkDuJXHkB
         n+vOz2YWISulJST7yj/ROQACjnb0gGVAgLxk9HWZ1rHe6aqghsu1JVr3fOYc/6MqpjTu
         oYaoeyqEqsdkA19WCRH54zqsZyZB+l7jLwA0ug8uUV2CLKBlAkZgfrUtNAkFR9pSfZG4
         yjdrFqFuAMExGqO2/A1p2xq3lfBBhD6+hhZVjPAGgv171pw/ejdgL9jVJXefQmaxI10V
         3mxUSQgcw75Nj7aQZVW/cHGjd2fyOKVgtGWKBjAlEM7if0bx7L6pQ3h7UIgJLoObiXNW
         dKhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWr5J47lrA0usG1yeEC0eZFG23qcVC76z8XU32mqskrBuWRh23aAdOAg++tjhgHaeOcSwwRQ3gCXz67Y2i32SbPWdd1L1HdSQ=
X-Gm-Message-State: AOJu0Yxw6WFeiKyOJS/VpITbHmOgoGTOCjNogo9Bh1N8MEKxvEpb1718
	22NGQ5d41tS9pOlncv60swfNJWCet3Mhl8XXohYhQJ1rjImNAqRxmyur//4JI1tbX1zqVz+yWyF
	HKqI=
X-Google-Smtp-Source: AGHT+IHwXaMUruJCX9M/RHqtmhUbj4EyviX70/VCd+gvNCZm8JC044UbL01+TgvDOTnUpG7G2lRLZQ==
X-Received: by 2002:a17:902:e54f:b0:1fb:9627:b348 with SMTP id d9443c01a7336-1ff57495ca7mr237971045ad.58.1722960012898;
        Tue, 06 Aug 2024 09:00:12 -0700 (PDT)
Received: from localhost ([71.212.170.185])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff5905fec0sm89249425ad.149.2024.08.06.09.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 09:00:12 -0700 (PDT)
From: Kevin Hilman <khilman@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Andrew Lunn
 <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>, Sebastian
 Hesselbarth <sebastian.hesselbarth@gmail.com>, Nishanth Menon <nm@ti.com>,
 Stephen Boyd <sboyd@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/6] cpufreq: omap: Drop asm includes
In-Reply-To: <20240806-dt-api-cleanups-v1-2-459e2c840e7d@kernel.org>
References: <20240806-dt-api-cleanups-v1-0-459e2c840e7d@kernel.org>
 <20240806-dt-api-cleanups-v1-2-459e2c840e7d@kernel.org>
Date: Tue, 06 Aug 2024 09:00:12 -0700
Message-ID: <7h1q313alv.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Rob Herring (Arm)" <robh@kernel.org> writes:

> The omap driver doesn't actually need asm/smp_plat.h, so drop it.
> asm/cpu.h is not needed either as linux/cpu.h is already included.
>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Acked-by: Kevin Hilman <khilman@baylibre.com>

> ---
>  drivers/cpufreq/omap-cpufreq.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/cpufreq/omap-cpufreq.c b/drivers/cpufreq/omap-cpufreq.c
> index 3458d5cc9b7f..de8be0a8932d 100644
> --- a/drivers/cpufreq/omap-cpufreq.c
> +++ b/drivers/cpufreq/omap-cpufreq.c
> @@ -28,9 +28,6 @@
>  #include <linux/platform_device.h>
>  #include <linux/regulator/consumer.h>
>  
> -#include <asm/smp_plat.h>
> -#include <asm/cpu.h>
> -
>  /* OPP tolerance in percentage */
>  #define	OPP_TOLERANCE	4
>  
>
> -- 
> 2.43.0

