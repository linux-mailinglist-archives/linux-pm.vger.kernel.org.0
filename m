Return-Path: <linux-pm+bounces-34273-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F0DB4FEA9
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 16:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0242A172059
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 14:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61AF9229B38;
	Tue,  9 Sep 2025 14:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="IJdurj9p"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DF8345735
	for <linux-pm@vger.kernel.org>; Tue,  9 Sep 2025 14:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757426606; cv=none; b=oZsBVT5dRWom4EW93ggCmG5GNWi3OPUt2JEv4FeiJifuGlfpFjgfNdyvssZe0PwRDgChnoffgVUws7K+Lwpq/Yr1nzuKAxiEEz9nIG7DkWkHPYZ9lRTMmBitLUBd784TDRb1OVjkVU/m72o80blJZJ9MXRiBmnKTVXK3JYpDDFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757426606; c=relaxed/simple;
	bh=q45CxhQhD0f4Z1JjVjqiatYI0JZBd8Wv+yGFW41DUnI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WFXSZEcIXBI5fulkUM7Gt3gd3cat/kKpXw5cYbcIdTWYSjVFkb09rLrQc4c+ysZMSbnIg2ET1BoEOnGOqFR1eMCns8Lnu3jLaRNx4Dfn5kFPts6DyaZ2xY+yGA9xSYSF0LcEcUUfjX++xNrpZUf+md/pyVnOGNxYIFyLopFDhN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=IJdurj9p; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7459fa1ef2aso5501273a34.1
        for <linux-pm@vger.kernel.org>; Tue, 09 Sep 2025 07:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757426604; x=1758031404; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0+Ty4Uw7gGeDTrt6VENR+8GGLY9kK+eZiE7VvFqZl0w=;
        b=IJdurj9puoLU70SjlftyP20JIzi7s6VhI3Lcw2bojFuTQ6v7ty91P148OQBx9o+Fvb
         KhvWGiIsVTlG5HLym5pgLXegQLZoo/jdUu6yxMKizCASu8v87UUYv7fCrNaurkSfKsPM
         7VLHedco7D6pwAdSsLBajvone97mAyyN6lKWRJQDinTeHAGtGgM1wLtncOAgHY9wNX38
         FfgMhTa7I+RGLBSAZlE+VGA67gFkIu1Cdn/vScttIkR75F2fjWQdGL+xmVwc/S68y7pB
         QWSf+qGFG9uPmRX9nXjCJ+MYH6QIWQ/5CuUGqYTbRLlrajcdD6OmlOXDqDGMVNwRwncd
         ccgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757426604; x=1758031404;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0+Ty4Uw7gGeDTrt6VENR+8GGLY9kK+eZiE7VvFqZl0w=;
        b=JWUHcfsqYO/2Q1tq0n3F2EU7N5FpEs09icTzANSEpXuALHMAUy+/T4zx7I5N5kpUoq
         8Tbt/IU4oB/+K3CIpxIbxu+RchIU0fyS5MA1NH9E+8Gki9k+tL2qHb/c7nvsaOYUnKAz
         G2IJ1AWF5BMQbqEo04aTIJM/uhg8RrpJhwiDHIYdQPHMWrXmNW9ByvJjfeCCp1ZYxcb5
         BOzfdYSs5u2lkehfWN34+jRzVbTzUfwJAGvegS8pG9m496FBT+RW9BGFVBOVIlywSDlq
         zr7YExjSsPfDmSCCeKWmEoCjPXbX1Mkc+OuwnhN4GRn9nOzlfRjz3AcVQODOKvfNj1TN
         hPug==
X-Forwarded-Encrypted: i=1; AJvYcCXdHMpSyltAd5X75dTfPzdhWD44GuUVq6MSUHszZfHpPFBNS4gafvgCzDoTvzfNdPMuS60IFdNCPQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwnWTG7Z+x03unqajAzzYuC9D6vcg201f9ERjrhhNCMWHuz0yeP
	EYk4ux0EqVWBCTLDn0V2UbM4cgwlmcQ1CIeD3mlwFUlbcVoHxBosMg8i9k/2BrLQd7tDctKr8Le
	dRW+4
X-Gm-Gg: ASbGnctAtSpX9FMBO0fBgIfcn//A7hIaEFm9IT2gx6ysp/uzd8Vq/UDFeQvQQOTVulQ
	bZehb7bIDrSWhdDH7cUOkvnNH64xjRF3MjP/+5OGkH4ymyGQia7fMF0dVALK1DN9c9GVmSZLU3f
	KYH9BQeWbl0A3ZT9ldek2W8LaMJMYz5fNxFjycpz3tgqTtBPI7cfMrCcJ9IdJfLktEclhe43J6C
	aOYl9dcj2OGS4JPocj/TzJJKd7M9aHEsFyAonxWogxSSwKbD8/SY+kOLngZRCa5rTpZgsdVKFFL
	yuHc/rDATXYUkfnOB4a7PKVf8k9iuLJuzT6Wy6T34t+Z9L+HGn7VMuvbHZT1PUIAPAJRmFjBw0d
	1c91SqzehBKfudd2i6vw3/8vN/IDpW77XQodld08+p6ooCbg2payElvznFvmVuwNiD2tVuK/aSs
	waw+hh770=
X-Google-Smtp-Source: AGHT+IGBODO1pzDIKXSlNVnZ1VymhDBL90KIRXoVOSdBF5kuyeZU2GyRm2nEjTxrDqEYWt0BWjhcgQ==
X-Received: by 2002:a05:6830:6ab4:b0:743:968b:3440 with SMTP id 46e09a7af769-74c75e4fe75mr5174495a34.20.1757426597538;
        Tue, 09 Sep 2025 07:03:17 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:3bc0:a377:2a07:2a0? ([2600:8803:e7e4:1d00:3bc0:a377:2a07:2a0])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6218ac3645dsm1067679eaf.8.2025.09.09.07.03.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 07:03:16 -0700 (PDT)
Message-ID: <0cdc56d2-091c-4d60-851e-788beec5e3d6@baylibre.com>
Date: Tue, 9 Sep 2025 09:03:14 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/5] iio: imu: inv_icm42600: use guard() to release
 mutexes
To: Sean Nyekjaer <sean@geanix.com>,
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, rafael@kernel.org,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250909-icm42pmreg-v4-0-2bf763662c5c@geanix.com>
 <20250909-icm42pmreg-v4-5-2bf763662c5c@geanix.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250909-icm42pmreg-v4-5-2bf763662c5c@geanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/9/25 2:11 AM, Sean Nyekjaer wrote:
> Replace explicit mutex_lock() and mutex_unlock() with the guard() macro
> for cleaner and safer mutex handling.
> 
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> ---

Reviewed-by: David Lechner <dlechner@baylibre.com>

(I wouldn't mind seeing the "obvious" reference counting comments
removed either).

