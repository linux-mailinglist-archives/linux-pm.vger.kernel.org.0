Return-Path: <linux-pm+bounces-20177-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE79BA085B0
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 03:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 926FD188D7BA
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 02:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F859157A5C;
	Fri, 10 Jan 2025 02:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Me+ln9vE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5785C2C9D
	for <linux-pm@vger.kernel.org>; Fri, 10 Jan 2025 02:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736477430; cv=none; b=G9JtzVbJh0i6Pu3YmqsPjr9JvPTd3ZWcd+AAfxeQ0vObkTQThetJEhVlNlmOEB7H2s8/Amrl5Aas1QT6FViwHYgDbypF7mo+mwFSPZg34boX7lt5oLljGHzu/sOk7WZrs5ZCl6sUvvIsN2+pxgi6MCeU3IZ68d3SEdsuJl0aOCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736477430; c=relaxed/simple;
	bh=o66zoOku2bbm9Y4n8pbmOlH8MafPuyTQNf2nN5CW8Ow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R5aECCj5aF8QUDquQR9qhguzdyqHzUaKAwtpRoss7Ca1UaRL5hG24IrX3k1WJRlFPHZdjCjVqoQB3HZy0KqiqY/lfxHP9w0Svh1RO5SaEFtEUL9sqATH7n0ppwcRI3/4Nh8CDZwMiNKBE9afcpjk4ejNzlHCHykVL7dDVShVBT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Me+ln9vE; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5d0d32cd31aso2083775a12.0
        for <linux-pm@vger.kernel.org>; Thu, 09 Jan 2025 18:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1736477426; x=1737082226; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uVNqVV/ljRSaQFyYY3YrukOxYF3RDkgqKP6rXa2V7Vo=;
        b=Me+ln9vEzLhmmyaOm7f5UgOfj2xLANAvVWOckJb0GpXwuKHml3DdEeoNBq87A2uyDg
         8pEO5+ssK0QzOqfRqQYmqgko6v6FoRQDXSF9Kp6gcVBrU+WM9U8O8jcwyfzWFsWTM06f
         nwlQ6vSsiUI/2GXVG9Wvkt+gRXgVExBXT/O7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736477426; x=1737082226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uVNqVV/ljRSaQFyYY3YrukOxYF3RDkgqKP6rXa2V7Vo=;
        b=lTmSfBw96L25WITqNcoftw/vD1prrpPomOshoY73XTzgNNBvNJKJ2DbFUUV2lQ/B9G
         2x09zU64oJlvh3KoAEHijd/nXzulKPUlxGDco1LcXRSDb0ffOfj6Y/n9gbhVbu9RFt8G
         nOHRG+oILRlWfeax5S7k9Ky6DUWdfvL0xUENfyVZeuGtAAMxtyWuxxjhbU1WNcfAdevK
         JFi60KIKDO16pNjU6D6kQt+ipTdJw4JMlM4MShL7DWHSVOSjznBQlBxK/br31k8PJe+x
         2ZdEXD30V43ylm8S1ga4C0qrxiyMRwT8xwEAVtJ3JNrGZ7i5PKBfZDc9PDw07MXw1Z9K
         c8jg==
X-Forwarded-Encrypted: i=1; AJvYcCU0f1ZVo08JjpQyTP9NU0cnJ6jo57O7azQH9fjLoH9pmNCLpZhnM1RmpzyQuT5kMM1XbfA09iqeag==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3dDP4mMt6jYRGxGmEVH5P5HGxJWuSKKlMHzWXkVm2kIYgRH3R
	ff8x1fiOUBSSe6OSnBEH/V0v6RisvfFfw7G0QYcLYcgOwTq7C7SMM7aMKgV+cU+ysuaX6C1SGkc
	mHg==
X-Gm-Gg: ASbGncu4JoNNZbRwmwGvGkjEthc6DjQoBNlCevCvMWnU0/KNHyAx+K5tHvfAxix8w5A
	HwjS9ywj54GYZ4Xj4nuslRRDpzXCF8LPpt9DELFCoT94ndyKvoxK25SiHPOJtD3wTqZ9c+6X+JA
	+VjaVWhwW20TNyZ4DbiKFBDRCzBVkEdWoEJ27yvxvHtpikX+9L9/PprtzfACFxpM8M7ILUGwpBT
	7HsMGmGpyEYYZXQto5uwzzLdyrbQ6JgE2B2pwq6Yao3XeBrb8I5o9iOTMlJ1Or2xi/wwWmlIPGe
	9k5DqMoZTQFYg2Lx
X-Google-Smtp-Source: AGHT+IHiMgGnWFoas8IAJJ/Qlu+elkcqu0v621htkcm1Ie9BanzMPpGAcETMmTl13Jp06TQ/y+B7vg==
X-Received: by 2002:a05:6402:35ca:b0:5d0:d818:559d with SMTP id 4fb4d7f45d1cf-5d972e0b954mr21895301a12.11.1736477426349;
        Thu, 09 Jan 2025 18:50:26 -0800 (PST)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c9647711sm125312066b.173.2025.01.09.18.50.24
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jan 2025 18:50:25 -0800 (PST)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5d442f9d285so2244a12.1
        for <linux-pm@vger.kernel.org>; Thu, 09 Jan 2025 18:50:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVRG5GVJ6kB+CibCozf9R7nypcKDOA7AZ3f+ckR4gyCuEroOaDWs7IXiP0cBciDTeziUIjBE9spog==@vger.kernel.org
X-Received: by 2002:aa7:c850:0:b0:5d0:dfe4:488a with SMTP id
 4fb4d7f45d1cf-5d99fb471c5mr38484a12.2.1736477423640; Thu, 09 Jan 2025
 18:50:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250109125957.v2.1.I4554f931b8da97948f308ecc651b124338ee9603@changeid>
In-Reply-To: <20250109125957.v2.1.I4554f931b8da97948f308ecc651b124338ee9603@changeid>
From: Tomasz Figa <tfiga@chromium.org>
Date: Fri, 10 Jan 2025 11:50:07 +0900
X-Gmail-Original-Message-ID: <CAAFQd5B30=9TT+ipyWaHdB1XMVagvEAJAw8grdU0Vva8+6JqLA@mail.gmail.com>
X-Gm-Features: AbW1kvZSRWAITYp68oDvUpBffdUWkQ7pr2zrejir-K6Mze20hNL9eqj-z_7AwHY
Message-ID: <CAAFQd5B30=9TT+ipyWaHdB1XMVagvEAJAw8grdU0Vva8+6JqLA@mail.gmail.com>
Subject: Re: [PATCH v2] PM / core: Allow configuring the DPM watchdog to warn
 earlier than panic
To: Douglas Anderson <dianders@chromium.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 10, 2025 at 6:01=E2=80=AFAM Douglas Anderson <dianders@chromium=
.org> wrote:
>
> Allow configuring the DPM watchdog to warn about slow suspend/resume
> functions without causing a system panic(). This allows you to set the
> DPM_WATCHDOG_WARNING_TIMEOUT to something like 5 or 10 seconds to get
> warnings about slow suspend/resume functions that eventually succeed.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
> Changes in v2:
> - Print the warning at warn level, not emergency level.
> - Add help text to DPM_WATCHDOG_WARNING_TIMEOUT.
>
>  drivers/base/power/main.c | 24 +++++++++++++++++++-----
>  kernel/power/Kconfig      | 21 ++++++++++++++++++++-
>  2 files changed, 39 insertions(+), 6 deletions(-)
>

Thanks for addressing my comments.

Reviewed-by: Tomasz Figa <tfiga@chromium.org>

Best regards,
Tomasz

