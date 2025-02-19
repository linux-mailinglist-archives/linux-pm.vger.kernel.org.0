Return-Path: <linux-pm+bounces-22384-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C0DA3B118
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 06:52:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FBFC173BA0
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 05:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CAFB1B85D0;
	Wed, 19 Feb 2025 05:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fJ0oOVSq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC901B4154
	for <linux-pm@vger.kernel.org>; Wed, 19 Feb 2025 05:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739944326; cv=none; b=Tovx3h0+pVRGI2RWCsD7eIh554eWH83MegJ3syV91Wr6A5ee2CghlMbvxgUHA+DzrtvUXOR6Aeuf7ZQAfSgP78b/PoI+4320KT7sXKF9wcYgDEJ+pksjHTDBIIv+IhCne4YYPWOreVQxACT6j87IpKORto4/pJ1C5odnXsjc/G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739944326; c=relaxed/simple;
	bh=MGmasOVKB5m96NzhLU7i7kKNDoPO0zX/pgtqH/xh59E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n0xkH6bao3y/qV10Z1Pt91rxRlBRPjoYgY5vDPd1WKs0phJ34k9PMkHz/o7G6IsNyTiSZxjVykNjrS4OqiSvE2kjQA6sOeFtheuDpUacVxIpCODFipGQHNYhgf06vQQMrkcMQn+MzYsq3HjdFu9wIts6UbvFjP/yACy4BHTCfoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fJ0oOVSq; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-220ca204d04so86566765ad.0
        for <linux-pm@vger.kernel.org>; Tue, 18 Feb 2025 21:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739944324; x=1740549124; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zfk/XizRuq+amnzwh+c94ADuRH5dLJfB81y/ZMr4Q7I=;
        b=fJ0oOVSqexEY8v5UNSmNzQNuwBHh/prFbqDQfbpjVVFpEJ0ObGeL1JaRi3MX0LDKzY
         w16Q0hQL0vjrFzw4Ue3G5HNcuD5SRMoTjwUYxOL7sQ1wtRQ/UCICshjJeDbnqtyjUOFE
         6ARUDUfAJwfmHySyFrcbH8G8YemmbOm5n5sp9KkmOAIS6cAauSzPn7lwKpEUmIjVnqc2
         gCtbp2rBJZ3aqw5ph4P3nr8LKio5kS8nW7gGS9Hd7eV1DlQn/C5Nvv5Ks1CDlsI7Pp0X
         T74wlOroO0ZD3Gmj6BlwiYSVTkmRENJk44CL5Ef7n4so7icP3zTgtwe5jnEJwjRt/Oi8
         EEjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739944324; x=1740549124;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zfk/XizRuq+amnzwh+c94ADuRH5dLJfB81y/ZMr4Q7I=;
        b=vSP8zJX8zW7egVSioIwNKMJerqOnseDU2WL1o/+5q/lppKE0nCPZT9AZdLC9KRPTrQ
         wCt4rBZJOmmLFP3+S3RZGJeMwe5NWiNcXuP/3bgIW2CPZ9R72clVR9Noc+rwzoOvobUf
         Zu0OjO/bVfolRC8g3STixLM/i0d5d7XLXwv6WibEc60+IO4UgsMv0f+Bs/aVNiF7xAiG
         qWI3Oo2q0aCrx30zn3UtGwRbgkpgSKGQJkn/I4HZWENect4pOLlf/TFTeDiSHOZqgmr9
         G55wHJ2YPduII6xhUCJowCnvgDXuwuq7T2nNBlmxKfi/KzuNpfCRkAic4VlqoB2WrBFf
         BegQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGqd8ObxzBuCPUf6I3mi5As3jn4VDwco+9j1ydi8O3pS0+iyB3lkzLxgwngglidmcqcxhBUYPkVQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwWMN5aPeoffmr1nGCyvO5ttYsZICpII9Sjkhs/oJXu4fXrMY/M
	VETdSHs9/V7nMpy9MSLroPAgEkkDRjaBVLKO7qg0qN69GV0NhLa8d8pP5u+frSg=
X-Gm-Gg: ASbGncs9rlbrRGu0cfxRNhxcew+XTEe7nab+BRPiZMzJJWfsTAEuZoBkYPZQrgysQxP
	eMXro2kA5u/br2hGfh9dR6Y/m2omD8gMAd5nsbeOamTMdZORO3zKu5CvpxMqzEqui6CJmx4HC6t
	b/NzFjJtKXTrJXVsZH/RqMF9hbQsDiX+rRXYmlHMxwkWpcu2hymjhIu4HQo5IMFVFylAs1GkfDZ
	zsCRl+BTznAxJ0MAK6Mutf8FHUe61+6JjyGMz8r8De2owuqlhwsfhMdcrA6x5AR+eEXkNthTUxD
	6z6UrtsliD7S0AaSlw==
X-Google-Smtp-Source: AGHT+IEmzrI9J1teC1xw2bZD6oIzjvalj4grBPjeXzr9SebtpOPohSw5PBj/tF//qK/NL4kw/gkJIg==
X-Received: by 2002:a05:6a00:2382:b0:732:1840:8389 with SMTP id d2e1a72fcca58-7329dcab9d5mr3854964b3a.0.1739944323727;
        Tue, 18 Feb 2025 21:52:03 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73265678abasm7341166b3a.27.2025.02.18.21.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 21:52:03 -0800 (PST)
Date: Wed, 19 Feb 2025 11:22:01 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: bschnei@gmail.com
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Benjamin Schneider <ben@bens.haus>,
	Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: Re: [PATCH] cpufreq: enable 1200Mhz clock speed for armada-37xx
Message-ID: <20250219055201.noi6hxe6sjox6evo@vireshk-i7>
References: <20241125211452.14987-1-ben@bens.haus>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241125211452.14987-1-ben@bens.haus>

On 25-11-24, 13:14, bschnei@gmail.com wrote:
> From: Benjamin Schneider <ben@bens.haus>
> 
> This frequency was disabled because of stability problems whose source could
> not be accurately identified[1]. After seven months of testing, the evidence
> points to an incorrectly configured bootloader as the source of the historical
> instability. Testing was performed on two A3720 devices with this frequency
> enabled and the ondemand policy in use. Marvell merged[2] changes to their
> bootloader source needed to address the stability issue. This driver should
> expose this frequency option to users.
> 
> [1] https://github.com/torvalds/linux/commit/484f2b7c61b9ae58cc00c5127bcbcd9177af8dfe
> [2] https://github.com/MarvellEmbeddedProcessors/mv-ddr-marvell/pull/44
> 
> Signed-off-by: Benjamin Schneider <ben@bens.haus>
> Reviewed-by: Pali Rohár <pali@kernel.org>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Acked-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> ---
>  drivers/cpufreq/armada-37xx-cpufreq.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)

Applied. Thanks.

-- 
viresh

