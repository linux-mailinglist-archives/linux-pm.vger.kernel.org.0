Return-Path: <linux-pm+bounces-21201-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7CDEA24856
	for <lists+linux-pm@lfdr.de>; Sat,  1 Feb 2025 11:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5EE33A8049
	for <lists+linux-pm@lfdr.de>; Sat,  1 Feb 2025 10:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E64D14F126;
	Sat,  1 Feb 2025 10:49:43 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7709433D1;
	Sat,  1 Feb 2025 10:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738406983; cv=none; b=BPVJvyT5Vhbje5vf0spyrKgKOpdKuB4AcDzK8L0IXcbdOP0I29bpODxMmXVmRHIQEfhO/DNXyS9sJ2roforYNAPNG/U+tmvrMXoNURu+PSmwOHMx3TcRLtjPUCjvTKfMMvumvccmOmG9E/9OFbG+WEjhQXP29AbH6cBTgpbG+BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738406983; c=relaxed/simple;
	bh=/B22Pf1Q1LEbOWQIOojFa5ozInbH7GFfKtk2tqbFAjk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IQRO4tZ6z2lgMGbqt9lGkT4fx5sVHsGoTmyrh16LWu3kQ326fZvuQvrZnKukjGUx8rHzTzQef0AFSNKGUkNi0KXM/d7spvKNRBBlbIFp5lSaTJslR4ibrPCAE+8nltODHUc0oTUFd5aDkOr/SJfNjcw3V8kovfzHvrysYugTOGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-30167f4c1e3so25862081fa.3;
        Sat, 01 Feb 2025 02:49:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738406977; x=1739011777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/B22Pf1Q1LEbOWQIOojFa5ozInbH7GFfKtk2tqbFAjk=;
        b=mpR+tr3Dy4yzmw7GgdrlyzxXQ6i5E0JNn3PQbRrOyzMT+ufuvhzBCEjPHAUx42HaiX
         1h6FVhJb8peFBk/Zc8NKHfncz4d/c6l1IaSVeI82k9Ddqdcdn7akfvnU9GMRviTeHdba
         m0juOn7A1VlCl9FNtreHw49+tfyZ/G9ky3uQ9ckaHpKoImQFhxN6R6AWtoXbMsyat5jr
         crsRfB4MavrfcFB43WdsupNvIDw1efiaO3hmXnlxbnqSPTZum1MQbQRO03paj0ean1yV
         vC8oGI+U06QLNOiN9vAWozpJ83AsBTYUb63gImUGMVdszWiggRckyqBT779N/1eaoXDV
         NCig==
X-Forwarded-Encrypted: i=1; AJvYcCU+F29+MUX3bfNDh1jAyyBorRKFNhgh4AmMCMWz3/MUSG3Gw55GqszfuMMEumd1enlwXEbQvvu0p2JM@vger.kernel.org, AJvYcCV0ONr0M3+Hi3E0Uevt67yI8f+bhBWUcUGhU9IpYkvJ+rLN3XwKBdgztYD9lD0kDNCFqhgMVsGrfHE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4jdNF/gy3+4gu0e1RBgUK/k37uz9lT2VMxl8P8pq6wQ9C+LU9
	S+evJH+0vRx8cOreeGxhwXTk6iWEyEA7r5jLCnp9eGpXffmC5Lfjc9jQ/GxV
X-Gm-Gg: ASbGncuxj5G16JV806s7frqAWl4la0gFV68weVBOWPfyVigoqCgLfq1jsHjkyAmNjXj
	9E0pvJNWeBdT1Vne0gMYKrIaRU0PokhGUB2GR0LTeww9cdGyY3yiP4k4YvfbiE/eABZWXP2vMXw
	YsfyiOoRQ0++QoDfEznAo1A33DLzdlPjEWdUuIEGvbbLTniZOZ/9cTWnExL9cKoNNQpN1Ds5cdk
	RRrbhfw9zF8kZnMlX6nWkyzOYtqrLA6+hiqgN2t5PNwnKnQQGZzAAR0pq2Og2kswPiwjkuBScSA
	/UqVv2ufWqDS/AsEN8vdpu0LEeZJAiArfwzMqXFvaeI9VU7f
X-Google-Smtp-Source: AGHT+IEvL0ZUEbihgS+73DjuU8fBWZcxIDFPZHjgdsjFiLSVsTZPwEycVonbpsGKTnRHHTSmPZuNuA==
X-Received: by 2002:a05:6512:3d10:b0:542:2999:2f56 with SMTP id 2adb3069b0e04-543e4be0097mr3899291e87.1.1738406976861;
        Sat, 01 Feb 2025 02:49:36 -0800 (PST)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-543ebeb06bbsm716380e87.146.2025.02.01.02.49.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Feb 2025 02:49:36 -0800 (PST)
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-30615661f98so30407361fa.2;
        Sat, 01 Feb 2025 02:49:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVbso6yIf528o+T8p0hBVVerzlpqxb36C9XNJQ/9f3KJaBzl3YG4EVpFOFLlIzoDTvSn3CewECvl3kA@vger.kernel.org, AJvYcCWLjXjZ4/zzTd1JHCWH9cLp0YNfMES2KDKIlZpK4UMlHKv9IiIQa7qiziRry5VhPSm4el3YppiunJw=@vger.kernel.org
X-Received: by 2002:a2e:bc0f:0:b0:302:4131:56c2 with SMTP id
 38308e7fff4ca-307968b8e2cmr53207751fa.4.1738406976433; Sat, 01 Feb 2025
 02:49:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250131231455.153447-1-macroalpha82@gmail.com> <20250131231455.153447-2-macroalpha82@gmail.com>
In-Reply-To: <20250131231455.153447-2-macroalpha82@gmail.com>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Sat, 1 Feb 2025 18:49:24 +0800
X-Gmail-Original-Message-ID: <CAGb2v65bsWdmG4mLwuUz9RAKGFBjyj0YDXTMcZg7krRcuH0chA@mail.gmail.com>
X-Gm-Features: AWEUYZkHj08AuejAZwQspl3ckJlNuUu0Wojot3XgvMeDb6OyjwsyKUkY_2GYQhY
Message-ID: <CAGb2v65bsWdmG4mLwuUz9RAKGFBjyj0YDXTMcZg7krRcuH0chA@mail.gmail.com>
Subject: Re: [PATCH 1/5] power: supply: axp20x_battery: Fix fault handling for AXP717
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-sunxi@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-pm@vger.kernel.org, lee@kernel.org, samuel@sholland.org, 
	jernej.skrabec@gmail.com, conor+dt@kernel.org, krzk+dt@kernel.org, 
	robh@kernel.org, sre@kernel.org, Chris Morgan <macromorgan@hotmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 1, 2025 at 7:17=E2=80=AFAM Chris Morgan <macroalpha82@gmail.com=
> wrote:
>
> From: Chris Morgan <macromorgan@hotmail.com>
>
> Correct the fault handling for the AXP717 by changing the i2c write
> from regmap_update_bits() to regmap_write_bits(). The update bits
> function does not work properly on a RW1C register where we must
> write a 1 back to an existing register to clear it.
>
> Additionally, as part of this testing I confirmed the behavior of
> errors reappearing, so remove comment about assumptions.
>
> Fixes: 6625767049c2 ("power: supply: axp20x_battery: add support for AXP7=
17")
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>

