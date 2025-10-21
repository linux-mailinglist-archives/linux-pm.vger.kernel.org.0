Return-Path: <linux-pm+bounces-36570-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA28BF6DB2
	for <lists+linux-pm@lfdr.de>; Tue, 21 Oct 2025 15:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 76CB74E2BD2
	for <lists+linux-pm@lfdr.de>; Tue, 21 Oct 2025 13:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4B11C862E;
	Tue, 21 Oct 2025 13:44:32 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD2C355049
	for <linux-pm@vger.kernel.org>; Tue, 21 Oct 2025 13:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761054272; cv=none; b=c9StRXh70VHjCM2zfNNrqnbvoO+uNHX2tjVwU+tznSoH6c6b/d5kp2ezpu5oiJXSU6WsYptAoOGKZ5HAzPK2e/22h0i3evPvphyAtJr1RZN3WA7nx6MOmL8181nHYSuyi1GsFjtcTcqwIvbkVWEDMNPBVu2cWilZqkkXKf8VtaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761054272; c=relaxed/simple;
	bh=rFDpMMd/J7LmBoOgvX90w3JvXvtchMw0C13OGNdvG04=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oBHDYy6zkk1D04ngaVFKDyxwBl+IcWcPzQOP8r3U/MmNcsRclRSQD/zkqc9r4GZYYSG6btW7CsgAEWAoH0pGsV1JhGpMLvI5KV5Mn2FgyZhjW20iQ7nPt5wwV51bwVbsyHef3dI8EQ3Ft23hsSL5CxohslIdp13NYreKxal2a+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-54a880e2858so3409554e0c.2
        for <linux-pm@vger.kernel.org>; Tue, 21 Oct 2025 06:44:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761054270; x=1761659070;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b78/bqYwVh1ldrSw5qZkZyL5FOTBO1IYeO3ztxHSC8M=;
        b=dIO4zp5byDJrdMVcXPrMoRSkzQRm9V97+nULjmLc+Vv//tkQRnixp1wYa1O1COZbpX
         9Y43NeK2O37vOo2FJdhjybp0jYL04wN+j4OWN7zYf9UJLUtcvDqL+sMi6FfVVIvP34Qb
         XtqqnzHPoZ+riiAMJI3rT+DCQ0cwn9Us7pzkO4T+wE0OvZENC8mVo0fZKI0L/SXr0P92
         2eWQtITnGzuiGlHfdF9pbFxwH43wugxe0mu+8OwM8P/mENJgTbKLthk4NuVYAb7pM1WO
         CW/MjqD2GRnY85UpgE7G+qTK7tQqlYYEfaRakLpirfQNansz//FMbmCodQz6bZjd1KJJ
         RbvA==
X-Forwarded-Encrypted: i=1; AJvYcCUL0dou89L9YJK3zCVp2yqf4GnKJhT9yVa2iWDnTb8PRGRZFkGgnHTGETUv/Qv7ybSxBsw9iU6rhg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzgKGVPAcDVOR2LQZRvDhcgctjZvHobEBSxWxj+7U0G/Qk3NGge
	LJxA/3sTLhJtp/LCL/t+JrhIv/Al/AE5SmGdNW+h7BbtO2ZilwdKz+kIuRmjo/wZ
X-Gm-Gg: ASbGncsuzEWFTKy9+iUjP7R0kW0PxBIGpaMIiiLggM+Hcxw+an33TnLBBZFBRziAYFE
	/jPk7rW7hJQhiMAGAoimoeP57S5DlVrOSlCfiQuJWkLpn/lR5+KkNatOS4bDviMhTNbJqKxioo8
	q4Hjd8WwBZCV/n5O5AQPJH1MedS/SBoto7UyT1kYLwS6CcpUQU6lCw4i/NUuOfcW+VMJks1CoeJ
	VtxVbxq56/3fAKB+gWQWC7aE2ehLMMeiTmzn7hqF6hLmWh35jsvoZS93cOej8DBtVR+VZoehQbe
	trereSGVAnX0i1CiRaL8TJ7qhpTnNy6W+1WaLDBavx/sdPt/4wHpvIxD9fm6zhjNcOCfFQEB5gP
	kmPSmCtTfnNCzbXdIFhG2GBfaZWbZrXkmNaADlXQSalo+Pdk1BWL0VwMSaBgyc/1CPrYgFw561Q
	aGJAKeJLpwAsXxQXJ1nIYmQxEM/yoIK+s/d7JBFg==
X-Google-Smtp-Source: AGHT+IGor0+JWVlun6j3/q4rNfQDLknw4kyqkL2xlYQoMibxBkBqdeOF2jznXaV+cVYAu90k7/12mQ==
X-Received: by 2002:a05:6122:469d:b0:554:afe3:1fc4 with SMTP id 71dfb90a1353d-5564ef30a63mr5424226e0c.9.1761054269778;
        Tue, 21 Oct 2025 06:44:29 -0700 (PDT)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com. [209.85.217.43])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-55661f6cebdsm3334692e0c.3.2025.10.21.06.44.29
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 06:44:29 -0700 (PDT)
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-58de3ab1831so4226822137.3
        for <linux-pm@vger.kernel.org>; Tue, 21 Oct 2025 06:44:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUeevYUfQQDRsT6NI8aL0Yp5rHIAJ0HKm6ntsS83XgPzW/SXBmQ8ZC8/AZd/H7FemF9+cNQW8CQ4Q==@vger.kernel.org
X-Received: by 2002:a05:6102:441d:b0:519:534a:6c4f with SMTP id
 ada2fe7eead31-5d7dd5ee60fmr6017748137.33.1761053815204; Tue, 21 Oct 2025
 06:36:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020143107.13974-1-ovidiu.panait.rb@renesas.com> <20251020143107.13974-2-ovidiu.panait.rb@renesas.com>
In-Reply-To: <20251020143107.13974-2-ovidiu.panait.rb@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 21 Oct 2025 15:36:44 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWNq-DFG4_i9CN+Rb2RSgO1Sxph7HO7SNhnr0d1=LoW0g@mail.gmail.com>
X-Gm-Features: AS18NWBYsMSpOo4y4kMiKki8g1BkhV5Ulk8TYURDjYYjSArsxY_VVDXQMAlwt_w
Message-ID: <CAMuHMdWNq-DFG4_i9CN+Rb2RSgO1Sxph7HO7SNhnr0d1=LoW0g@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] clk: renesas: r9a09g057: Add clock and reset
 entries for TSU
To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Cc: john.madieu.xa@bp.renesas.com, rafael@kernel.org, 
	daniel.lezcano@linaro.org, rui.zhang@intel.com, lukasz.luba@arm.com, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	magnus.damm@gmail.com, mturquette@baylibre.com, sboyd@kernel.org, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 20 Oct 2025 at 16:31, Ovidiu Panait
<ovidiu.panait.rb@renesas.com> wrote:
> Add module clock and reset entries for the TSU0 and TSU1 blocks on the
> Renesas RZ/V2H (R9A09G057) SoC.
>
> Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-clk for v6.19.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

