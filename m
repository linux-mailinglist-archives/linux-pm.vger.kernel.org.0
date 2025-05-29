Return-Path: <linux-pm+bounces-27789-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED44AC7765
	for <lists+linux-pm@lfdr.de>; Thu, 29 May 2025 07:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E514163DCF
	for <lists+linux-pm@lfdr.de>; Thu, 29 May 2025 05:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17EC3252296;
	Thu, 29 May 2025 05:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KSIVXhD0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7733A374D1
	for <linux-pm@vger.kernel.org>; Thu, 29 May 2025 05:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748494999; cv=none; b=n6MnnJGT2a3vrEdQ/fWzTbqOtE7QpvQO2Ls7TSrrNFUwTKcWMcHrlPzwRjw+8aQ6Z7wxZrtS9E+MTk7RcbARrCY6MWmR9CKqRyAQB2w7MfqG2XS+3n6RByYY1H36qAhVvo/ipTCy3yGyqiN56J7IRz4txvvEwoym2naOOQZ2Zpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748494999; c=relaxed/simple;
	bh=UGl/ZySSb36hTdaeVYURkYFu56VLcQdFHCiCYGQ9NP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PmUaI+D4D6jN3XGtnLowA4wEw/b0OpQgk2DN2WMqRSbcrMQ/A0Z4iFkwowA2s9LPhFhF/cNNzQrHkC7FIaELVFDzWCD83R7mQSnLxfP7Al3+iDXqXo/rfgpulxKAHY4nAg5K5IoTZ2Ma6d99kx9K/mxk1SjDNHNB0zwKlwHeIc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KSIVXhD0; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-742c9907967so500450b3a.1
        for <linux-pm@vger.kernel.org>; Wed, 28 May 2025 22:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748494996; x=1749099796; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hXUzyapC+nHSzY9vYq2BZ1sPf/W9lQog0j41wUW5fwQ=;
        b=KSIVXhD0TrWpctJMvsuAiZ6AdlV5dGYv1ol3GH2qiLssxZK6fVbE/ycUYbAxFxSqOP
         H4FSYDO46z53bPbHpihy0U6MRsxs/dymC7li+TJzyeaV2ZzK7ETWdd/LyJLs0TeOxqRz
         K+/AYInFX4QFoAyHBhJCvWz/7vaXWs0xj7NklrzSCpa2llpcyKK9wmfg1MepXx1z+8xj
         oJ/jJa2HG5/D0+09tMFLaaxaE1c/lRs9prHlvMyZRbHZbuUAky0/uE/kSom50MlHXf3b
         qU6BvnZCOIuuJBQDIHrq6iVtfdlouwirlDZ0RXcpFFX3JWCsnPbkqToWsHFfFg3wP4y8
         Pviw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748494996; x=1749099796;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hXUzyapC+nHSzY9vYq2BZ1sPf/W9lQog0j41wUW5fwQ=;
        b=MBc8kAD7gbm3PZcxVSfVGw3Xa6sbHCSRZtbfj9E41on6L6+QfpklNf+1L+1FsXyf0w
         D/KIDMaZyv4OGhHLtYGSz408lXSB3UrKptLsCTguvVjEH5dErlLRL0ggMH2eL2c+Yh/F
         qCTQfkbvg9irReB1I3NOERSA0xT9hYCbHIjAVWaueRGm+U6KZvTEtIHwCwAPirgNknNR
         UUv5LcNad+gng317dnS4AhEujg7oIwtXK9ZKZo+OPS8gjaSs207G4MTxaxf0df1KXPCd
         ZUDzA2QjBJKmBodxbhvQ7eITu1tsWUDy6sm3afsw3vi3FscBjjpY8jKzbw7sAPMg6nvI
         +Vuw==
X-Forwarded-Encrypted: i=1; AJvYcCU3HzL7fE8ZgAL5PvUp9N9lpW8VmdOPivatmSMnbkNSxueGj5XUayI6+nv/7IzuFKnRYy2RQR2oEw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzsGFfBjmsKhJVXojml3bzwhgZjZQcdJ0qTl1osNt1OmdHdceRW
	1DZGZxenbz9JC14er+QUv6U670SBTl14WRpS89y8a4GTHQ7ppECwb7CsrHtDnMS9juaaGaeYh+E
	DVpri
X-Gm-Gg: ASbGncsnYsosgD77UPwKZo+AiIuBi+LeTTWu5sUDob6GP2F4R0KEYQPZmk6ziacI23h
	QvfPIt8jeV+tBFEcYVE0i5YNNH44R9QLMX0gks22iSUB3x9d+12Q9Cdad+34HUA65+WN62AVYVG
	JLYyJcF/sSoiie0DkqEgeGDiJ3ESj5jsixauqbcWobPUsmt2zIGAPC0CMZDaJyZo6XjDu1JTeIQ
	RPhrOvgLtAsX10ZbruJ11xuZWPx7f3YmX3EV6iubz9d7xvzzKwSQJax+e3gW2qR7f92du5XNBwh
	npLjQMnDE4WesJId0L976G4S5lvjKcQ5GOVlbU+3/LgoXjeyW1puiZREzU+WIWM=
X-Google-Smtp-Source: AGHT+IHmE5fBVErzq+nDLeIPGuGZs+OGjD6nPqya+VPXH7c56/1z1eUN/PtGQH+KHkU4G9x51sVhkQ==
X-Received: by 2002:a05:6a21:2986:b0:218:cf0:fadb with SMTP id adf61e73a8af0-2188c3c1213mr31783963637.37.1748494996621;
        Wed, 28 May 2025 22:03:16 -0700 (PDT)
Received: from localhost ([122.172.81.72])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747affafc2asm472742b3a.114.2025.05.28.22.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 22:03:15 -0700 (PDT)
Date: Thu, 29 May 2025 10:33:13 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>, Linux PM <linux-pm@vger.kernel.org>,
	rust-for-linux@vger.kernel.org
Subject: Re: [GIT PULL] cpufreq/arm updates for 6.16
Message-ID: <20250529050313.igzkpncndr7ssbwc@vireshk-i7>
References: <20250520061944.pl3mqw2clo2roe3s@vireshk-i7>
 <CAJZ5v0gBRQ87bFk3-MCOudgvGWb29O_ihfz0Lo2kGcVpfSu=nQ@mail.gmail.com>
 <CAJZ5v0iNwBhpmkwuo7Z_dGmLE5KQGONNRrt5kykXXKRoORTShA@mail.gmail.com>
 <aDb3JzdsrrLAxPlW@google.com>
 <CAJZ5v0iAU5oGvqvtoHAxOOUH5PkN5Q03bUqXWKR7DCdiLMELZQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iAU5oGvqvtoHAxOOUH5PkN5Q03bUqXWKR7DCdiLMELZQ@mail.gmail.com>

On 28-05-25, 14:21, Rafael J. Wysocki wrote:
> OK, it should be fixed now, thanks!

Thanks Rafael.

-- 
viresh

