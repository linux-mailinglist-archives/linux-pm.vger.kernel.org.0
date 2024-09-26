Return-Path: <linux-pm+bounces-14807-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7838987094
	for <lists+linux-pm@lfdr.de>; Thu, 26 Sep 2024 11:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7B851C24D38
	for <lists+linux-pm@lfdr.de>; Thu, 26 Sep 2024 09:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA6C1A76D7;
	Thu, 26 Sep 2024 09:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="o38Hv11o"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A53813B7BE
	for <linux-pm@vger.kernel.org>; Thu, 26 Sep 2024 09:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727344038; cv=none; b=bMp2K49Pj23mnF//hEV3BWz4M8G4y8Nh0vC2F8phCUbevAyni0XLXL/s2tf0tqSQwRY2YUHZcS5iGjdCFlqAbooqPYBLwvDVWuRyhXuB8fXIhi0djdWbb5FnSrvitJJ7DdEVsrAe1y1s1fEf0aKUaM/fxKyBfDZWnZXFSj37XPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727344038; c=relaxed/simple;
	bh=Kq5R389tQQ2B78EwGqSvI9hBK+iAe4QHQG9BhsNCVws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mKcRFKYv2NkVrHmw7tbwAHr1rQ0DOSRtlT1HQcMJG+Zg88jPC8khChsta/VQkAi794nUESarOvxNnPGCxjDucLST1hH2J5WmfsIIYFJemJ0KLV26TXlktFlNtk5I1q7CDWGYsUh0CjcYcnAznMg+rzuaq/IOMyB0o2Ipye38kbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=o38Hv11o; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42cb0f28bfbso6290545e9.1
        for <linux-pm@vger.kernel.org>; Thu, 26 Sep 2024 02:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1727344035; x=1727948835; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/LSQ02N1RzZQqc2enuj2Tvq1BwqNOjenbSCTfQ1lHxM=;
        b=o38Hv11opbvbhMmYxVQb6mg81eEEPLyRBJ7A8+P5vUaxBDyAIqJhsCvYTOpEZbY/OL
         3DeeJiFR+3yT/GR8HG9GoQZ+8iuJamcdsIX043hrGpbzKuNKjYV1WdD6gkJtS05pjLGV
         VX/6537l3Mr+bTktSizIKHGwjhEJ5walhE6pKuLaTNx7wu4mwlynZYAtdjIPr2XFXwU4
         gR4gkdf7d/niFBu/216Azy7WpVBC7F00EsjetWvtrykXjseXrRHbaXHNL0BNDY9lLi9I
         klI09bOL0NFUvjCzhNeJv8OYDebMcRUfK48c2Sfzsta4/46rxVlMnwGfzWrey5gqWyjb
         UNgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727344035; x=1727948835;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/LSQ02N1RzZQqc2enuj2Tvq1BwqNOjenbSCTfQ1lHxM=;
        b=X/jUDnWpOZUk6f2WAEaWVUFztSPwAdayFFNTiPsat0h3QeEdruxaj8ospnFOGNgb/U
         ZfjjXhnEP+esln7YPzrCYJnjzh8+juLkDUcqvpcY5D1ZdwXgxDukmVYNnVFzkiUQr5xE
         CbWF3Ff2VNid0c/ciPPdtbBM7HOM2PWl6a44OAQVbI2ISPp/OgKvOE8P7tP/hLeiT7yT
         I6qj+jKwC+BE1xxytqt93n8hLHN8G5NSeVPXtRktObeYeNMafF1z9Oq39M/yvYTYsMCK
         pEgK2nsVl8ZdugoqlvosOdWOKPu97jjkb5SYaEA85xQXWGzOJMfvZaGiwHx+KWlKj+Ib
         qAVA==
X-Forwarded-Encrypted: i=1; AJvYcCVJ02qJwFHp0HHYmK7SSnZhS6y9hyUl3oATpQ4RjmlIiEduhK4Ecl5LqXg6v4RuUEbQYXFt1eNX7w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwSf+Y7INEuXbfS5rMcE9XP6EsDcmaArzB6zeoocafylJhy+XoW
	YvBew2x0p6HRLqS4eCGYa8i0KgGJNltQJtCJjwrWv+JakZ1zQBQSrKLEg9DbMl8=
X-Google-Smtp-Source: AGHT+IE3qgHzuWsAu9qO4coJy5+IsI0h/T+zUZ764Cb+dgkVLEukEcIucL3ssR2DiXM47S3CNpjY2w==
X-Received: by 2002:a05:600c:468a:b0:42c:b950:680a with SMTP id 5b1f17b1804b1-42e96119222mr43160685e9.20.1727344034778;
        Thu, 26 Sep 2024 02:47:14 -0700 (PDT)
Received: from localhost (cst2-173-13.cust.vodafone.cz. [31.30.173.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e969ddad1sm41992855e9.9.2024.09.26.02.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 02:47:14 -0700 (PDT)
Date: Thu, 26 Sep 2024 11:47:11 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Nick Hu <nick.hu@sifive.com>
Cc: greentime.hu@sifive.com, zong.li@sifive.com, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Pavel Machek <pavel@ucw.cz>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Anup Patel <anup@brainfault.org>, 
	Mayuresh Chitale <mchitale@ventanamicro.com>, Conor Dooley <conor.dooley@microchip.com>, 
	Atish Patra <atishp@rivosinc.com>, Samuel Holland <samuel.holland@sifive.com>, 
	Samuel Ortiz <sameo@rivosinc.com>, Sunil V L <sunilvl@ventanamicro.com>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 3/3] clocksource/drivers/timer-riscv: Stop stimecmp
 when cpu hotplug
Message-ID: <20240926-b0d87e489410fd9f83796a71@orel>
References: <20240926065422.226518-1-nick.hu@sifive.com>
 <20240926065422.226518-4-nick.hu@sifive.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240926065422.226518-4-nick.hu@sifive.com>

On Thu, Sep 26, 2024 at 02:54:18PM GMT, Nick Hu wrote:
> Stop the stimecmp when the cpu is going to be off otherwise the timer
> stimecmp register while cpu non retention suspend.

This commit message seems to be missing some words. The comment below
reads much better.

Thanks,
drew

> 
> Suggested-by: Anup Patel <anup@brainfault.org>
> Link: https://lore.kernel.org/lkml/20240829033904.477200-3-nick.hu@sifive.com/T/#u
> Signed-off-by: Nick Hu <nick.hu@sifive.com>
> ---
>  drivers/clocksource/timer-riscv.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
> index 48ce50c5f5e6..166dee14e46b 100644
> --- a/drivers/clocksource/timer-riscv.c
> +++ b/drivers/clocksource/timer-riscv.c
> @@ -127,6 +127,12 @@ static int riscv_timer_starting_cpu(unsigned int cpu)
>  static int riscv_timer_dying_cpu(unsigned int cpu)
>  {
>  	disable_percpu_irq(riscv_clock_event_irq);
> +	/*
> +	 * Stop the timer when the cpu is going to be offline otherwise
> +	 * the timer interrupt may be pending while performing power-down.
> +	 */
> +	riscv_clock_event_stop();
> +
>  	return 0;
>  }
>  
> -- 
> 2.34.1
> 

