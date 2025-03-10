Return-Path: <linux-pm+bounces-23773-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E534A59A35
	for <lists+linux-pm@lfdr.de>; Mon, 10 Mar 2025 16:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A78323AAF9C
	for <lists+linux-pm@lfdr.de>; Mon, 10 Mar 2025 15:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DEF822DF82;
	Mon, 10 Mar 2025 15:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YQ0/P1FO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8964822D79D
	for <linux-pm@vger.kernel.org>; Mon, 10 Mar 2025 15:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741621269; cv=none; b=MjHw+ccsyrcXQEihet/Vgf8ny2Ypx2kDW3z+Ks4JuXphXu/VL7UKQ/JEPoZVN1ygGPFQjXxXdt8EiDQX8fX/5LREfBZxosm6wxD5hegCP4zlVeGiBjVFoZizYgtS2wVaFTdPtsfmmfTjw1efFOc9Tj40erlOpt8jcPI7d9J4EYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741621269; c=relaxed/simple;
	bh=SiSYBMtitncv76R++Rvdfnd/5GTxkby/K+Y+pHo4VFE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FMkBzSjeu8OhNmYfHSJttJbYUSKBGXnmRd9dCaikeevKdn++o1FAMVCAfR8yXYf8zt5GiIxGN830DBgxF333c62Yqt4avJfBVFAW+D2bfTunmGbu83Qd+8hvsqInJQF+0UPnOBLUMxtTssRX7395PX4kqtf3TVFdYqmxBWjGY8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YQ0/P1FO; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-391342fc148so1969843f8f.2
        for <linux-pm@vger.kernel.org>; Mon, 10 Mar 2025 08:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741621265; x=1742226065; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4DcQn3+I0jIkpf3ZBvexKFO6QcwbDbsZfCGjmeAilYo=;
        b=YQ0/P1FOgLtnKJwGzKdrHdKAX4TNkcXOMSXbGeIJS1f6kzqt7pIvlGQX/PEywZ3oMz
         yk4b5kyYSaCp7jlEt+YlaRu2fTv05yXZ49zv5hVoEzdt8EJb+vacPZics1TAHjeWaN+v
         MfcOy1NcT0NQrdPgtVgAeh3ybjAnIH0rF8PQcYbqj3x7h4nVk3CK0Vgwx+pooDOJiB9a
         39io3uTIc6KQ0aXvKxety5Hgfd6ssr4oaapzqJ9rXGHZe2m+1jdTRyV+10KEMao5ROgD
         7osNuEJLqmLYqDlUs75AEz9FVQH1PJHeTCKX85Lm90PYEZWTduYxg5QVsKLvsPMrslK7
         Be7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741621265; x=1742226065;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4DcQn3+I0jIkpf3ZBvexKFO6QcwbDbsZfCGjmeAilYo=;
        b=WK+M3RdUyeZngChnGRMJfK1rmVZiQpWnu+9OSV9c4w0GFCX/vkqqKwGmHTg5hmCLfV
         yRXMLH85oJbgVFYBNsuTUwWxWygQZO4GKweNSLpTs935K0f9QDOPtNwwiuLl25wCZCAB
         PtrxtdUAwHZWnPBsqlCD/h0r5U8nnaZ4cSAu+LunyUH2BHIU7+3cWof0a3PPgaxrEw+n
         34K5LzeKx/abNrbWhbSKtf50wsI1VKgMxWxukCc02/IsVxzOPvKIaeRyxQLBvmLXJrJB
         ZFaruSaO79oEQBqQRuRtf9KLF9ZCUBRICmIE3ITZvKbAoRs+TynE9QVEHw/HCKGtoxrt
         DfpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsb1t5e2Maowbk44Ax8oJQm5M37z0uNG5SW+FBPC2O91MqlcFZ9WzdGEdh+Gwj7tKMOm5sEGQT+g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzCm8d+EbNrr5K4Bt8thKDqXGln8kH0/BChk5kMhpymu9lFZnp9
	V2qDTYTIIiz9xT3IAPlDATW3cEpbWPtbCcRg8C+KOIIKJyRkLwoy9bbS0YUlqV8=
X-Gm-Gg: ASbGncvgq8Yz1MmhW5zbneik23lvxsl3xntyU/vTlQ00btsvYd9Kq6+n3PaLlBWNCyY
	S8vwHKuuDMkG/xsq23x8FDEN1fCVXvxmfM/Mh88Dtu42xyDubLxGfrpaJ2VfrIhqOxM71t5pIIE
	QtUP6FEP2QvCIgrwjrKLF8R65Ka8bxImNXxe1GCeC8L7x6O6IJ8PQrv7+rM3XlCMshIfraU7Q+r
	dSffrrerLYmUzY+Nw3hlnkLsmIYbma7J0YjqVChS2q7ehCHIBOa5Vc7hm8rM+UydtEoNFFS0xl7
	SlKjogSUAn+pI5mJ+bSEz52cPtj58IpALdgJhIvSoug7y8n6WX1V7zdUgQ9vQzDtAuK5Mjzhhy7
	il1hC9J0J
X-Google-Smtp-Source: AGHT+IFTM9dXcEZw51WkmRY68H9XVcAqrdb0vR4We3kH39AbYRJBbyFLPPSlwgwvD+LzdOV/7amBMg==
X-Received: by 2002:a5d:648f:0:b0:38f:2b77:a9f3 with SMTP id ffacd0b85a97d-39132dd6934mr10735927f8f.43.1741621264831;
        Mon, 10 Mar 2025 08:41:04 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3912c104acesm15499409f8f.98.2025.03.10.08.41.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 08:41:04 -0700 (PDT)
Message-ID: <9dc5dadc-7ff1-484c-88a8-461d505cec03@linaro.org>
Date: Mon, 10 Mar 2025 16:41:03 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] thermal: bcm2835: use %pC instead of %pCn
To: Luca Ceresoli <luca.ceresoli@bootlin.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui
 <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Petr Mladek <pmladek@suse.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
 Liu Ying <victor.liu@nxp.com>, linux-clk@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20250307-vsprintf-pcn-v1-0-df0b2ccf610f@bootlin.com>
 <20250307-vsprintf-pcn-v1-1-df0b2ccf610f@bootlin.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20250307-vsprintf-pcn-v1-1-df0b2ccf610f@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 07/03/2025 12:19, Luca Ceresoli wrote:
> The %pC and %pCn printk format specifiers produce the exact same string. In
> preparation for removing %pCn, use %pC.
> 
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> ---

Applied patch 1/2

Thanks!

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

