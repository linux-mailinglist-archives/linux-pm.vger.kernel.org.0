Return-Path: <linux-pm+bounces-13903-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9525972025
	for <lists+linux-pm@lfdr.de>; Mon,  9 Sep 2024 19:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D45E71C21040
	for <lists+linux-pm@lfdr.de>; Mon,  9 Sep 2024 17:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C5C16DC12;
	Mon,  9 Sep 2024 17:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JY3sl1qn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675F3282E2;
	Mon,  9 Sep 2024 17:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725902222; cv=none; b=ox8wiu3NJeCJu8x+DLd8S752APE9BG5qAAuZN1sUxiO5vq6laR+bMgOcPAA1CVRBqxBxkV71bPRCmHXa+Xz3ObOj5dktieKl/LNYhhAV/lac6JMpjDvxWNj3bhSRfaNQ/h/4vGk+lvT5hfxNUPgBBuvP8ivpFEYWQ30ezLWFGbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725902222; c=relaxed/simple;
	bh=J7ZxKBd8GNjoUAMjkac/WKKJV8okz4PGJYbZ3Y3ZgkY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=avZw4+A9J/4aQYo2I5ib3LMtSBOWEcd5ut0/qIoOg/1lntqjnsDcZ31cBsCFXSYh+v4yfXAFWcVGyT4HSU7eirU1N+7cbPC37o5fsFMb+uv5EBsawRdFzNU2KErWMA1FdBOEjNMozgylahL3DNBpMV4IhhHFz1nEaJ5rhk+lJ1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JY3sl1qn; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2068acc8a4fso43325395ad.1;
        Mon, 09 Sep 2024 10:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725902221; x=1726507021; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hauHXk0UHvL9WIL9OJwYkRJrxeJ42bwu7guvi9wUyZ0=;
        b=JY3sl1qnjLg4/r0ntWouCd3WpY6GppXlx7hP2US9/VU584jvVDDxGbXMp1FyZMnUWo
         u77ji/zmcuV+Ht5XwvQK0rEnwb3x7MFuz53Q9jh2ur7ElNGIlv6OCNEmxx/JROojhLFt
         YXKIYFXRV8LIjAX6OS/go5ey9rYvtQr6iV+j492LWMm3e6L1HBPTgHlRy41xaaib8SMa
         BrTSK/mmx2nPKfT9gu35IE34sOapUlPSHBmWKx09CTLG787B8B4TyLLhdwuLIsKoAHnS
         tjNPSpyb5jRu29bAFSecb3eiYoJ0SnaVvWz/r1SE4pHLMxEMJHsGSOs4nYTBn9tVraxv
         oHuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725902221; x=1726507021;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hauHXk0UHvL9WIL9OJwYkRJrxeJ42bwu7guvi9wUyZ0=;
        b=IsFA5TrjJD1bOO8Zm9m+acIxCxZOk2YuXKFp8te2+7Ih4sAmLQMcvg81sWDnoxvWrL
         VjdJmUGLqsm5FrUFD23h7vjUOYPqTxt+itsWLyx3ngQgK4fmHI4jIJ7xFEPDbJyUvgj8
         vrP8thmGJXVqMd1h26GWrb6vfBaSGAtv4VXMq5+Y0p3eJt52i4MMiF+jpGYrt3y8avIc
         4xragrImeDAP2o+evEj0VZiUyMKlqMknmkD0Vw85ARqyTsQXzKaF4x93id+YXQob5Vlt
         ruqEkkdVe6oLP2I0ZOMOc1SJ/nKoaWj2gV5CFjuPPL3U4ZnZGraM/vc15tC+kLwnaqPi
         jM/w==
X-Forwarded-Encrypted: i=1; AJvYcCULs+ix832Mk2eoGb7l7AlJANgr76nQO4wJuhygM78F9QD6CgwUh9fv6IF3+CmOjGsw7MVBHQhK+s0=@vger.kernel.org, AJvYcCVNOhC5/C7VxrZC/UEMv9StGpphYo6rW9ciOv/q8wJR0OIuc9f4dYpQ/NObGC/G9uicjyvTwAI9cTNS@vger.kernel.org, AJvYcCW+fBVEoeWHSO9mtClJ8+Oupb00Lxg+ve+kz+3+z6ZgYjajb5dX5ptZ/DeYNyD0TykLJCtV202bK+brfLOu@vger.kernel.org
X-Gm-Message-State: AOJu0YzRrgs2HVLGn49fqyalsvTjwtoGJB2HNakjO8hofUa7nw9BVSKC
	FZ6sxyt6JlCLdcizJ5JVV42e9AXeIwUO7nW3k2TdXa/gJRA4x+b2
X-Google-Smtp-Source: AGHT+IHnNeEvODa1Qt6cj+F9ZMmq0nJBVXi/m6bl9hffcSzJHoVbOj9/wfPZtg6NqY9graxO1THDuw==
X-Received: by 2002:a17:903:120d:b0:205:866d:174f with SMTP id d9443c01a7336-207070002e8mr83668675ad.44.1725902220449;
        Mon, 09 Sep 2024 10:17:00 -0700 (PDT)
Received: from ?IPV6:2601:1c2:c184:dc00:6c38:4539:e063:d0ba? ([2601:1c2:c184:dc00:6c38:4539:e063:d0ba])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710f31729sm36233705ad.261.2024.09.09.10.16.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Sep 2024 10:16:59 -0700 (PDT)
Message-ID: <08466bb0-4306-4941-97e1-e62ba07d8ea2@gmail.com>
Date: Mon, 9 Sep 2024 10:16:56 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Sam Edwards <cfsworks@gmail.com>
Subject: Re: [PATCH v6 3/3] riscv: dts: allwinner: d1: Add thermal sensor
To: bigunclemax@gmail.com
Cc: anarsoul@gmail.com, andre.przywara@arm.com, aou@eecs.berkeley.edu,
 conor+dt@kernel.org, contact@jookia.org, cristian.ciocaltea@collabora.com,
 daniel.lezcano@linaro.org, devicetree@vger.kernel.org,
 jernej.skrabec@gmail.com, krzysztof.kozlowski+dt@linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-sunxi@lists.linux.dev, lukasz.luba@arm.com, mkl@pengutronix.de,
 palmer@dabbelt.com, paul.walmsley@sifive.com, rafael@kernel.org,
 robh+dt@kernel.org, rui.zhang@intel.com, samuel@sholland.org,
 tiny.windzz@gmail.com, wens@csie.org
References: <20231217210629.131486-4-bigunclemax@gmail.com>
Content-Language: en-US
In-Reply-To: <20231217210629.131486-4-bigunclemax@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Maksim,

Apologies if I have failed to find a v7 of this patch in my searching, 
but I'm seeing that patch #3 here was never applied, so Linux still does 
not enable the thermal sensor in these chips. I just thought I'd give 
you a heads-up in case you weren't aware. :)

Thanks for all your hard work,
Sam

