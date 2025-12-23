Return-Path: <linux-pm+bounces-39835-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ABCECD8EA6
	for <lists+linux-pm@lfdr.de>; Tue, 23 Dec 2025 11:45:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7DD9030779AB
	for <lists+linux-pm@lfdr.de>; Tue, 23 Dec 2025 10:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F30BC34CFC0;
	Tue, 23 Dec 2025 10:41:32 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1F632AAA5
	for <linux-pm@vger.kernel.org>; Tue, 23 Dec 2025 10:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766486492; cv=none; b=J26rHAwzeKDgc9gtxHoM2/7AZZX+mR/qzKbd18O9ybUYZ3M1MSbrHMd70qJCPq3SmsEr+Cp6y5gNKj5/uzDC2aVOwhYUIkiU5umX+uInx6PvPoO2nNp5Qk+bek9dBwyESEm3+8jHHPbOFfmUPomnoNr45lQzg8V3682sJKdNiV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766486492; c=relaxed/simple;
	bh=xl1vXOaleR0j5ZD3l3FjtDUkU+B3UA3o3alRtYcoeVY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ldnmPqG5fpeQJvCpzP7HCYEoJGX6E6PO43HsxhRWheuofQ7FMIbop+uHTwEpm0jMyruwQ0FKLZe9sFH539wSoq2gZisyPNhD8EkPGl+F3veDtGBcTnP6JLi70NhTMPUiguHCaHxj7kD+AXTfvZUHkhDy+zjsybn98HzG/Ryxgn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-5dfae681ff8so3297610137.1
        for <linux-pm@vger.kernel.org>; Tue, 23 Dec 2025 02:41:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766486490; x=1767091290;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xq7HSic6ryPtqfCpQmmpcvZwrfLwAAt26kNsndZzLGc=;
        b=usAJTzGkvvXTVQDJfbhd/7Sxm5StwKQ8lSDRbtG72yRciD3Q0VuZFfeGciFtsxHZ0g
         pVbuD1zIofxE3mB5rzhIuepvVtT/YI1bshLaf03Mbp6TsNiM5PGvwZsZQzqt0grWcmeb
         5Iok/mo2QJ+7JXramoBt77K109R192xxbVf9EpdEtjYX5RzlYB+i2ahnaerW4D82OnTX
         OXLRBkd9YMzRWuG/TZZxVznM0xvdOfB4PdJ6YvIgbJBdBRNoDicsgZ2lRn+JjqQ0ECU8
         Q78K1PhFkrZ5B7dgDcnxrsPVqX3GjQRA7MmnmeaBbR03gDsbO6PzIS1FRC+G4MUVfQS+
         olNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjzYJOLH4eUP94C9h5e620mmyWcLyo2xrzsFAGpuogH4raRQ0GkzE4GDdmhn3i0leswLMcZ+8jJg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzM2J5ZGKGVfPYINJrYZosVVGnSnRUClM06G/NWHRZ1ese0nkEf
	bE5qZBrkIjUA8ARG0UIpy7JqPHY5/GdMBAJLv5GuHdMjgnEPJv1sTCW2Zhn372Ie
X-Gm-Gg: AY/fxX64mshtzdtpQDf/6Qo2WWgD1efLTe1mb/et2msQkDnV12X8R0dwry4mEwLgpsc
	j8MLB/zdFMWnRPndqK1gNqXeTvXCPmn8tLf7Nau5RK1sCaSJvbjvs/F6IEB+JI47HJj21uq03Ji
	dXK9F1j2Zr1ENFlDPmOOj68MPo8x3a+ewCu+6ujBpgMXR+zQvwOJv5utlnR2dL+A31+1ZQMP8Gf
	Y3E0hmJZzxvx2gM0nG1Y3D6MTbhCwv0Rk/UhjUt07T8fgkXRXbtMF0A0NnGNnzcxTu6fzrJkHCE
	QPlNNunWMLqhugKOhKwSk82AHbmPOgyBIXgNQVOhIEjcHLyIKMrkZQMq5yhdbTBzEPEFJTxaCuv
	ZctGToBnb3/AZrt6aDH3XxeOVYGBa8cZj469OUXm5wGqYvNPjwYhxZK5ORTI+jj1rVQ6QL01bwc
	eEX16W9/3C+S3Y1VsTX9335Fifiuf8LQaR81tLHuLE+mDRTd4n7pgC
X-Google-Smtp-Source: AGHT+IH1kDC3hyMviwFeg7hxvaIS1sxCLt7u1sUt7iDTav1yruk8UTNO1oAek9I9RvYWvB6s54PoUQ==
X-Received: by 2002:a05:6102:3fa2:b0:5d5:f6ae:38ee with SMTP id ada2fe7eead31-5eb1a817ebcmr4719979137.37.1766486490349;
        Tue, 23 Dec 2025 02:41:30 -0800 (PST)
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com. [209.85.221.176])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5eb1aa4f338sm4337406137.1.2025.12.23.02.41.28
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Dec 2025 02:41:29 -0800 (PST)
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-55982d04792so3838998e0c.1
        for <linux-pm@vger.kernel.org>; Tue, 23 Dec 2025 02:41:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUHq9YWh7TTdFKKM5eIZIq5olX8c0RZL+e/XB8PosAYVM4QAquFJUvnepDZuAz5KrotmNXCVrH/XQ==@vger.kernel.org
X-Received: by 2002:a05:6122:3c84:b0:54a:992c:815e with SMTP id
 71dfb90a1353d-5615bd1b39cmr4360914e0c.8.1766486488573; Tue, 23 Dec 2025
 02:41:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251209091115.8541-1-ovidiu.panait.rb@renesas.com> <20251209091115.8541-4-ovidiu.panait.rb@renesas.com>
In-Reply-To: <20251209091115.8541-4-ovidiu.panait.rb@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 23 Dec 2025 11:41:17 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXLkOnxSNBoAJ_Q7hQj=Eb1u3x-Wo1JiHU8uz_tCJcy5g@mail.gmail.com>
X-Gm-Features: AQt7F2orNy1GBmSkRttc0kHF_Evq8f58iyWH7SaoZ_piWZcfCDJUCF-OXqEH57Q
Message-ID: <CAMuHMdXLkOnxSNBoAJ_Q7hQj=Eb1u3x-Wo1JiHU8uz_tCJcy5g@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: dts: renesas: r9a09g056: Add TSU nodes
To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Cc: john.madieu.xa@bp.renesas.com, rafael@kernel.org, 
	daniel.lezcano@linaro.org, rui.zhang@intel.com, lukasz.luba@arm.com, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	magnus.damm@gmail.com, mturquette@baylibre.com, sboyd@kernel.org, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 9 Dec 2025 at 10:11, Ovidiu Panait <ovidiu.panait.rb@renesas.com> wrote:
> The Renesas RZ/V2N SoC includes a Thermal Sensor Unit (TSU) block designed
> to measure the junction temperature. The device provides real-time
> temperature measurements for thermal management, utilizing two dedicated
> channels for temperature sensing:
> - TSU0, which is located near the DRP-AI block
> - TSU1, which is located near the CPU and DRP-AI block
>
> Since TSU1 is physically closer the CPU and the highest temperature
> spot, it is used for CPU throttling through a passive trip and cooling
> map. TSU0 is configured only with a critical trip.
>
> Add TSU nodes along with thermal zones and keep them enabled in the SoC
> DTSI.
>
> Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.20.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

