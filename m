Return-Path: <linux-pm+bounces-34025-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C40FB463F0
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 21:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CA411B26742
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 19:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB2627AC31;
	Fri,  5 Sep 2025 19:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Zo/88RbZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFBD248176
	for <linux-pm@vger.kernel.org>; Fri,  5 Sep 2025 19:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757101749; cv=none; b=coTaMiIXtCqtobhlwElARIxtl+q9x5C8cInQr+afiN/2fBNDfZuukkRLZSWbEWUbX1luMi0hIvzMdYl/SW4L3vsnTbvh9Jq+jjfkoeNVo6R9hn3pQJ+39kI76sXt4mHoB7G83JmDsJVChmg35gG4Wuzalt2vt74bxDfGngVreVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757101749; c=relaxed/simple;
	bh=SDXmXmmQ1vFXl5JZs1WJtKI6JEciS/jqDcvT58tTS3k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vDNBx8bkZVZY+VbW9DGCUNQcqYRovhu47wryqvmJYRXCzXjtJvtId4B2ugIHzo7xqMMmaWFqYZqQtqdeFveyVAV9sbbqbZUkIFXHalqUEcz7XRzwLFj+xGpSo2ggCb4HV++SMNNlvXNCJcFS5d9xp7q6dXquDIUjWJizndScw7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Zo/88RbZ; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-30cce872d9cso2374441fac.1
        for <linux-pm@vger.kernel.org>; Fri, 05 Sep 2025 12:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757101747; x=1757706547; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Szv82Yg+I4qLiwXwVi16VMgcWXR81jSEFdZnsxSabZg=;
        b=Zo/88RbZ8lyQFhw9ebZaQt80sP8CNUlPBN7QFTYbY7uYEhD9sEhlMiKaOWPucu9vYi
         Z+vNYCJuXYTpkvPOprh3Ax1h0qj1Mas6y0HCobeHzgv4g/2Tiuamkt76y62jViwwH+h/
         uqbBGWx8NoiCWMrPQpt5gkXd+VpRNWgLmkBWpjl6duA8Zf/esd4gZbxJypYlB/gkf0Ov
         eUblqhPoltvH5PMDFaQhltsEX4bB4EVspdVkakHYifC4tSCeGamL9AnBO1D39JVX5aqk
         9ec31rWFBRQQTaePZ33eaG92gUmoysdl52K66KMZlUOAvdRm09r4BRPmqQ8NIFPvXdxX
         yVqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757101747; x=1757706547;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Szv82Yg+I4qLiwXwVi16VMgcWXR81jSEFdZnsxSabZg=;
        b=i1p7wBAII59CbvQ58K4kAujzudZrb8ZeEyqAgrjDk6iUr3oLA1ZFeFuuV897QZ+jBm
         cmFvX7G8DQa2KuZCdUDmlHf2OAbLcMN0cPUSPgyqZQ810AuSYiFjDU18WWbKvUUH2mnZ
         aOU2LVmoOQ0dBTx/wsDxDwf/CG5iIRlRuF8Ls5q/KJR/KowGTbWTqhS6jmipo0BsxDYM
         HlYtRvWlZd7m2kmdZ3ID7zhVLwUc0Ijur3wSfY6ASDMMrgrAl4KcZZ+i0mStiDcwmTmP
         1DRley6cM7aiQEWmzJt9L370D62JZZKAFgd+JQ/ythH2ugRlRuBak3SdqQy6xHO6x8kO
         JaqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGZ/GIWin/JHzoJAXZIwjPuPsKIUhYXD8zgUkvTPM9huYTPzINeyNMKX4QK70xYvv3WmxioC9H1A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2601kQE6G5u6hMOrTLxe1gVtaJXDbQsyGIAj90/4X8cQCA2+6
	w4zP25b6hGnNMDtMNtQOKk/m5frrrWa1/vJmbwXAcUWrjcuKjhGQksmX6AeWnFRvNwI=
X-Gm-Gg: ASbGnct4oOZyIVZJSlvDCH5bD8DY+JMDRE8eXR6+lcW2P6+QCPW/9ugszYuATT2wBCQ
	XX3aFlBCJTgbQLiOtvaWz4v181QzhuCm2/Igw2lM2UbPAXEHXSUPr0CKYtSufQX0NHYYVZ8VmHb
	5Tv2ot+7LJ9kt6pODbx4Dmd8iaKr/iNtXjavamse0zrutGNt12MLekpnwtKWIvE0IQzolxvCSBl
	XRu2dfxlPKKxOO781UI6NhSNffxk0NMfGRLi/5gPOEVnwvxoOKoYttcWOctZrEb56Ehdw2gwyjM
	9u9zc9/F4z8YKtOyGKEtTtmMk+p8H7LRwtAwmviF6Wtc3aFj3oEGDaXzBG9CYEdpEp9tuv14kWa
	zsm5sTn5MuAi3mEJDwnRuvcgr0L2/w9i5VGajWMMvm2HL1UVS3D6haKp1BlWNQmFjjB1ws846bx
	6e4ik2tbM=
X-Google-Smtp-Source: AGHT+IFRxRKk8LtvZ6He+rGVAow3FoQP7Fwy9rnhW18mDzyKWJ4V4U2SXMzMRn0S6iDAapzSQorQTA==
X-Received: by 2002:a05:6870:b013:b0:321:8f88:a39c with SMTP id 586e51a60fabf-3218f88c130mr1286348fac.47.1757101746811;
        Fri, 05 Sep 2025 12:49:06 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:52e:cda3:16cc:72bb? ([2600:8803:e7e4:1d00:52e:cda3:16cc:72bb])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-319b5fcbbaasm3996358fac.15.2025.09.05.12.49.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 12:49:06 -0700 (PDT)
Message-ID: <e97130f5-9ec6-4ac4-9944-96f992eb215f@baylibre.com>
Date: Fri, 5 Sep 2025 14:49:05 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] iio: imu: inv_icm42600: Use
 devm_regulator_get_enable() for vdd regulator
To: Sean Nyekjaer <sean@geanix.com>,
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, rafael@kernel.org,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250901-icm42pmreg-v3-0-ef1336246960@geanix.com>
 <20250901-icm42pmreg-v3-4-ef1336246960@geanix.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250901-icm42pmreg-v3-4-ef1336246960@geanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/1/25 2:49 AM, Sean Nyekjaer wrote:
> The vdd regulator is not used for runtime power management, so it does
> not need explicit enable/disable handling.
> Use devm_regulator_get_enable() to let the regulator be managed
> automatically by devm.
> 
> This simplifies the code by removing the manual enable and cleanup
> logic.
> 
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> ---
Reviewed-by: David Lechner <dlechner@baylibre.com>


