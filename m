Return-Path: <linux-pm+bounces-35555-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 45006BA90CF
	for <lists+linux-pm@lfdr.de>; Mon, 29 Sep 2025 13:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 31B184E19DF
	for <lists+linux-pm@lfdr.de>; Mon, 29 Sep 2025 11:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835A63009F7;
	Mon, 29 Sep 2025 11:36:20 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B0E3009F6
	for <linux-pm@vger.kernel.org>; Mon, 29 Sep 2025 11:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759145780; cv=none; b=CX+v55l5wHEOOb4Qrs1UUXNEJ1/jqW9CEVzQDiZpus1TbqgqHg/8T8ec7ECcmtB+glOjJsWnbtZ4dV6U30mCg21uhBZaJpA6lp1PFNLAsDLsLDNxXTJpvXw3goCFjmzgpBZxzJsXWk0Is8Oc7vkOEShgj9fx+gyzkyiz62EECYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759145780; c=relaxed/simple;
	bh=mnFFlAyLIwT1Q5AcB5DFjSNt1dV9nkw1CzOpVFtZBvQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WtpizM1xsa2EAdfTGDDC2ztvdojq7LTwr+ADHdGr/9Rn5rc7TFJx2Se4yJjtjZ2INydGMhmR1nmHFR5SmkkCF1wwujuIYO+9ozoEo15w3U3glkBsNq9QaotGGzF+F7kBoQqLzXD2MFJN7FjKR8C63rgTiQzFp6hcOS3OiWMjF1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-5ccccc1f7caso238263137.1
        for <linux-pm@vger.kernel.org>; Mon, 29 Sep 2025 04:36:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759145778; x=1759750578;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4wo+c49wamlH5OIn4NEbxEDOQ99erhVXBTj7EjS/boc=;
        b=nblwuzQrA85F6ins0zGWdlrBrskxrGVRUCSXgcK//GCPjk8zMaApR3sCtpaEHGaF38
         4+kz74XoYTXz2Fh5vAeqN4klzjXSufyy2wdeGvv+/ANqtNTMAB4zfeTsC+Xsn32oLmcA
         S5ul/xzipoq07jNgTBnO1KZ0FtWVRG1uraWqUI0+gk+DmgjKK6EzNGYkHinTW0wvzs+7
         tjyj+xQSqFN8HzLfMarEnyvKkh/HN8QsL2naga5dKVprSibR2b/3sOBeREiUA0ix0wih
         kGCHFuYzbdxXTOyQYftmF4L3C3yT85xhDtQMVRH64JXV/tZ9ZjksGQuMDQqrwQ2XZUj/
         5RCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMEEKEMLeNpbuCm6XT22GS5fb3FqL6IH8Eshn40yqjek54nK8F5Q2kOtWRhyAyRsQ4WovFNi5JzQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwHZzaUYZrAHQ7PWHWi4b8G20O+RCINux8JTnI5POfKMjZ+anGn
	AODuWzIOCbbABhvjP+74Gx3W5DlO4mlpdvPES38RLy61P9vdcP/C6gGopuI3RJ17
X-Gm-Gg: ASbGncv6mLaxeqdaRTQljVUIqhlhUH26zHecdgAt/spOchvF8q7zsdH2Fo2fjjQFkGO
	UzCmPw2fQVVDw9Re3K+iC/1LZ0c42dlOiLWkSE89clRpA8BCogz3o6S0cwX648wlQxPoi1mCC1I
	QsZtF4yK0dc+54Fks74qTVwDwnqmYLEV/gL0g8FD31+NFflasBWQ18sSjGcr+V10xAZtrgOerL1
	qpO7XvHw099IcqpngiJdT4ecDkEPGuNXGxiN+hj+lL8qC+AQbmvqO4hJ4t7w75RC96SaiywHSDq
	ddmTxd5e2Trb7cWLzQ9qGk1sO+Au6XPQJ0UAeCqeKUuR4vODsQmwObOFCRgDllhkMfhYkWPaYeP
	mJNo+6RlXW8hIeO39t9Cse+/4QO0uwRK7F8WzN74Ea/LYGhd3BI5bgWQvR6FMFZVmsrXH+dU=
X-Google-Smtp-Source: AGHT+IFZ/0U/D1tG7QUvFiE4pyeAvbkROuFXq9ubQB5FufAxB7JxmHH3OabpFric6YSh8NpcHsAV/Q==
X-Received: by 2002:a05:6102:3ecb:b0:519:534a:6c24 with SMTP id ada2fe7eead31-5acd2161437mr6400874137.34.1759145777611;
        Mon, 29 Sep 2025 04:36:17 -0700 (PDT)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com. [209.85.217.42])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5cc4abefcc9sm304623137.3.2025.09.29.04.36.17
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 04:36:17 -0700 (PDT)
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-5ccccc1f7caso238247137.1
        for <linux-pm@vger.kernel.org>; Mon, 29 Sep 2025 04:36:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXG9dwkPyRH/jxcLNuw2Kp7d1Fz5ttDDPqj3UB0n7Cs3UwqoaAZdzyYAACLutWUWQJAciaRqgXt4w==@vger.kernel.org
X-Received: by 2002:a05:6102:38d0:b0:536:7bfa:22d7 with SMTP id
 ada2fe7eead31-5accd215f1dmr5953694137.18.1759145777154; Mon, 29 Sep 2025
 04:36:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917170202.197929-1-john.madieu.xa@bp.renesas.com> <20250917170202.197929-5-john.madieu.xa@bp.renesas.com>
In-Reply-To: <20250917170202.197929-5-john.madieu.xa@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 29 Sep 2025 13:36:06 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUfZG=FEMesgTz=q4agJ0huMPFe+gsvX+8-zmKBup-Feg@mail.gmail.com>
X-Gm-Features: AS18NWA4k5X5kIR9EAR4SmDXTePu3QOZUfbdTpezmeEEx4rSxAt1uKChq-x8rPA
Message-ID: <CAMuHMdUfZG=FEMesgTz=q4agJ0huMPFe+gsvX+8-zmKBup-Feg@mail.gmail.com>
Subject: Re: [PATCH v9 4/4] arm64: defconfig: Enable the Renesas RZ/G3E
 thermal driver
To: John Madieu <john.madieu.xa@bp.renesas.com>
Cc: conor+dt@kernel.org, daniel.lezcano@linaro.org, krzk+dt@kernel.org, 
	lukasz.luba@arm.com, magnus.damm@gmail.com, mturquette@baylibre.com, 
	robh@kernel.org, rui.zhang@intel.com, sboyd@kernel.org, will@kernel.org, 
	biju.das.jz@bp.renesas.com, catalin.marinas@arm.com, 
	devicetree@vger.kernel.org, john.madieu@gmail.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	p.zabel@pengutronix.de, rafael@kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 17 Sept 2025 at 19:03, John Madieu
<john.madieu.xa@bp.renesas.com> wrote:
> Enable the Renesas RZ/G3E thermal driver, as used on the Renesas
> RZ/G3E SMARC EVK board.
>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>

Thanks, will queue in renesas-devel for v6.19.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

