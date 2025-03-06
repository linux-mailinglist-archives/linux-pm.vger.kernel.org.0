Return-Path: <linux-pm+bounces-23566-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49884A54D71
	for <lists+linux-pm@lfdr.de>; Thu,  6 Mar 2025 15:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 820DA16A9BE
	for <lists+linux-pm@lfdr.de>; Thu,  6 Mar 2025 14:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D023B157A48;
	Thu,  6 Mar 2025 14:19:15 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BC28F5E;
	Thu,  6 Mar 2025 14:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741270755; cv=none; b=n3yj/3RAlLWvkAaduM6Znn2HkedZelBBee7yQHMT5+Fa7cZ5S6dEIt+bvSXIvOU/PpZgPc5uy1eYJSJN35HvYvFU1+Gs542wQbKlyMSpc4lUHGNRFG26dX6zYalkHi4jIIqbn2GAuBlPcrn7AJrlV1l87zJbQojfHJejMOeTLxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741270755; c=relaxed/simple;
	bh=Q1j8gHpbri1CxFrvKlgL6l/RLbYkeNcBavgftpIbKpo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Chr0tDjkezYOt8+vGqi3Ow+Sfg9aXe9aY5MSbSMy+Nvmh25kkSTmA7/9snyfoP1nZsCHfKIPKmWXcoZMOUdpnNTLq6mZxCV+lcaHozbx3U2LLlhucQRuolX0m4fUM9whN+oYDmZh7M2kcBjUaQzlQyU4dNj8+6s2KGJ8dmPXaMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-abf518748cbso131696766b.2;
        Thu, 06 Mar 2025 06:19:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741270749; x=1741875549;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/nVfiSll248rUsfwTdZE7ebVgcWytnodaotzGSUKaQ4=;
        b=ClCZ+PBsxy7Rqlx39kJ/zSsVeRarWNo37tfZCOlwSb8q9msh8/B2TH2UM9rE/qF1wO
         C7ipWiAqkUa/LcG+hZMJtXqH6eWJg4OP0tqFZWRObwv6LM3ivdg7DCCQgJXFjN+a0fiP
         QSL5Wje7TS+af6JNQN2bpxwAYdzQtadrb7PVppfSZbJ0TVKFu5HwWIw+fW2nFPKMKG3b
         zqBA/l1ismH1Ub1TdkcflnIwnMIz5z8CUayzE6EnvhLJCguJ/HYsnynvLFkl36Qm0Jm7
         brHobEBl2q7WgdhzXcMLEzOIoVBMU3mkpH+M3V85L6JgUFQStYGfy1o2IR0utboCXMZo
         cdNA==
X-Forwarded-Encrypted: i=1; AJvYcCUCxvidpILSqd+oqi3k7oAmH1WKSINiK0NS/9A9yhZ5fMw9AQjWxaDfPSHKyy9CInAwqdEktkIQdE8=@vger.kernel.org, AJvYcCVgA9p8+jaNxITD+3ORC22RAuXOMAb95fIXi5P250nTtu2aSDGywTnKLwyUCF/qD7a3C2GJBOMQ1/Rj@vger.kernel.org, AJvYcCVuhGNksJEPcRSYS1RLmt7zuiPuJvlgwGY+Lfa4hFRE9G3UIwq7ClJI1hnzhG+9lCb193cYT4PD1c+SXArJYX15X1M=@vger.kernel.org, AJvYcCWN6CaZ1y5qBteXMfb+1j+CfNKw+B19eYL26WgyYwmGNskwFsxpLat5Yh3Drz45IgsYV2S8a+p1c6j4b9Mr@vger.kernel.org, AJvYcCX3z75FDRao5tgoDGk+e11kYLxn0U/aWvjryPCcU6QbUrfU+fybj+lFs5dJpPfh6jR+hJOF2Xarfx9Z@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8r/lfztxhruQymMT7h6aTk7bYK9BogLcRXf+mWpbuJSStkHpX
	ActfCyFTgGF7/iJw0JV4gFgG3JZSDjEzcXVmzgZALhwGFwuC/coGHo/ExbUX7Ho=
X-Gm-Gg: ASbGnctMW0ywuAzdkIq7bX/JAuvB6yhI7cQXBClmcfczANW8wG87ZWTGHaCMIP+eAf8
	FbUnQt1cgNGtZxAPYhy80pMvGq1ozT+c0MDgoXJH6PpwAzxzyOnlz1AjMSC0KtdI4OiguSkAWiw
	vGwWbQ4+iasUsNrVgRT31+1/2lAPmux9Lq29JJaD3isu448sjf/HBkv/JG97Zr8l8MUriC1VKIz
	yzOF3Ss9AsQpFXmWXsm8lS4BSvKi0IctuKxqeE1ylq8C2ue4tbXsq4OW91jZdLf7z9lH5I8SFKM
	JzeBdIIetLC0kL6pfpEcuA9v/QFH5Bgls/sL3Mo1nENgkYgT6adIBTanawqyKJn3CavBf+0+7nW
	6kyab+Uc=
X-Google-Smtp-Source: AGHT+IHc53ajEExPLTmKtS4CSNRVGzQJulovXInObWfYQzjzXRe3tdupsM3v1I1o8ziklEj11TVPpA==
X-Received: by 2002:a17:907:940d:b0:ac1:e7a2:f5e8 with SMTP id a640c23a62f3a-ac20da87bb6mr831742666b.35.1741270749148;
        Thu, 06 Mar 2025 06:19:09 -0800 (PST)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac2397366b0sm103690766b.95.2025.03.06.06.19.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 06:19:06 -0800 (PST)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-abf538f7be0so137019566b.3;
        Thu, 06 Mar 2025 06:19:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU3oScEQtf/dRxo5zlJDup1sCGlySalLmywSCvVjwee2z/6yg5+EinUZR7LzWA95YmX4wAMBr3cCgsC@vger.kernel.org, AJvYcCWCw4ffZBLzFZUePHVWj9YbSDauw9NW8Wh2YlWSoY9XBnHkQQDUjBYlou8fQR8cmFkrV+Xkqh6fAm2q@vger.kernel.org, AJvYcCWPBw01Ne78wM5e/A2V292n9S7q1LqtEWuNzIecysJGIia7H4ot1r+pXo9+g0+TOA+hxFDULPLmlwtlvYq3GQpZcT0=@vger.kernel.org, AJvYcCWZ0JA1nyA8sQc3KnRJfnxzAtb4ZK72W9T2atuaHtYqjZ+mXx48OYfA7fTo+ijqJEJFKP6kMYM9av0=@vger.kernel.org, AJvYcCXLDYTknwEqBKxNJZNyB4dXK6xAKuI7ZI+o6oEt3uwnwub7s5KdBWJedw8DKIlWGQOkOQtbJtHNe33m8qd0@vger.kernel.org
X-Received: by 2002:a17:907:c27:b0:abc:c34:4130 with SMTP id
 a640c23a62f3a-ac20d8bf8c7mr709557766b.18.1741270746647; Thu, 06 Mar 2025
 06:19:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250227122453.30480-1-john.madieu.xa@bp.renesas.com> <20250227122453.30480-3-john.madieu.xa@bp.renesas.com>
In-Reply-To: <20250227122453.30480-3-john.madieu.xa@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 6 Mar 2025 15:18:51 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUoXSerYfb2L_tLmC2-5w9mhoZHc20LSYQgCHxB+bJOtw@mail.gmail.com>
X-Gm-Features: AQ5f1JpSCkfow0oWUCpHHLfYKAm9cW04YyVX-MUYgns8UbS1cnyHUBvgSNPUv8M
Message-ID: <CAMuHMdUoXSerYfb2L_tLmC2-5w9mhoZHc20LSYQgCHxB+bJOtw@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] clk: renesas: r9a09g047: Add clock and reset
 signals for the TSU IP
To: John Madieu <john.madieu.xa@bp.renesas.com>
Cc: magnus.damm@gmail.com, mturquette@baylibre.com, sboyd@kernel.org, 
	rafael@kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com, 
	lukasz.luba@arm.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	p.zabel@pengutronix.de, catalin.marinas@arm.com, will@kernel.org, 
	john.madieu@gmail.com, linux-renesas-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, biju.das.jz@bp.renesas.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 27 Feb 2025 at 13:25, John Madieu <john.madieu.xa@bp.renesas.com> wrote:
> Add required clocks and resets signals for the TSU IP available on the
> Renesas RZ/G3E SoC
>
> Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-clk for v6.15.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

