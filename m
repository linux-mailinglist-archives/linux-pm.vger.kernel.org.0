Return-Path: <linux-pm+bounces-39836-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A381CD8EBB
	for <lists+linux-pm@lfdr.de>; Tue, 23 Dec 2025 11:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9499E3001017
	for <lists+linux-pm@lfdr.de>; Tue, 23 Dec 2025 10:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EDCB302773;
	Tue, 23 Dec 2025 10:46:11 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DDD2E1C57
	for <linux-pm@vger.kernel.org>; Tue, 23 Dec 2025 10:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766486771; cv=none; b=Gbr8DERcbjeTvQQI9qwdYRGyVYenhz6msCRa6u9A8T2ASrmvVt9jYhlTz1M+xe0OfSMrAfgiwQyDU4yjbjm251Cs2gkTJGPGGReZ7zlOz8KFikMiP5FcRpUOHP3cKMaYkmTPg1VM0x3AXqv6I+dP+gRcSfMP6T/Uov0HNpzVAgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766486771; c=relaxed/simple;
	bh=66jVhePVgbDY99R/UaDytJcux4TaSRR0e9iC1VpGw7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nu7GqtxQQDqnPqgAGN7MD3x8mK4EX8YxmOzcVTmZ+7saL3ieXn+Ijuyu/TdQaXskTbrBB4iLvFzgbKgqXrJWR47/sGQqxR/4+juar1zEpORI90hkDm6QQ1Hhj2qOb5SgnIzPa6NHBtbFB9TaPtP1OuWXQX6rbsW+0BHRpA3Bndo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8035e31d834so2260889b3a.2
        for <linux-pm@vger.kernel.org>; Tue, 23 Dec 2025 02:46:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766486769; x=1767091569;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bXELbjF6YF4DeXko/6RU1bv5uamffDsE6H3g1pKMitA=;
        b=E0FbopeRIzcy4QllCln2drzgYR1VLgbseN+hfVsP0mqxFpijoBUzJTaEJBMUM0j1Ik
         AgHXVdRgs3kucMZ80Vf7E6804+vVW5GHA4/gqIS2kmyobWAk/BURCEYoJ0y+Pr03S8o1
         HrUuD70xiqoKVo1Mkf7VGj6EfvT+oHBfrg02uZOskgNzTGmarS3ggqtsr9OOFyDszpLY
         h4C0gfLC05xfGHXdmP7Z0Ymrvjm1XwB0ozvkoLSg4kU3VWLHZoksn59lEUgLwHL2eu8V
         WYGkUZD+Kjht/UuCTLX5wQWxdD3U+zbqKin7nuXzZ6lQu1aQmCqo2OW74pbacnjoC8sz
         RPzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfOOkZh6QQxFK9ZVcdBfTqXl9yvZRlFzOC5XSAfpwFuXW1U+eUcaBL4OmMbHWijRJcHmpzV39hfg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5PPFkA16TZTA7COHZpeXiu8dVenZWbN6gjZNysNPF3pMdu2Ie
	nPD6+ydr0xbunG8+kivem3ITdc8ZWJO9i+l618ixgf54+KqXUedhLXCTeZpZgFCI
X-Gm-Gg: AY/fxX7ftwU5fbxkv/Pmi86oLy+BLA7Q30bD/J9md3JHWL4Dq0t3dF1/pf4P61l0/Xc
	3K7noURdoGlECj5vUW6MemWKje4rCoTPlNV6oF0k1wM5jhr8b3z8+Zpc26stS768ciMmUpvqwVl
	vZ1DKvLCuO9Gvxd9609OLxKL9p/mxm0hBxzUoLnn8QPQlU118+ebe0ottnBcjO7VITqC7p7Hb2Z
	M878V2zU2SIa2fZ8tB4cg7uXElW1oIU6C0w7p33YqyQDzTj7fVT/s43LjriA9jr/eP2omVClDEK
	DM3thMiCux5v3HoPsPgHf7pL7LyvdI5tS0aYckAD1Ll3Mnka7FhXBmryJUTH70kZTnKMl5jWvxV
	hRb2tqib7cAyJrx/or1XSXj/PSRyu/iX1mHq2ejqMEs+lRsgjHuZwiW8k1YLnbXv4h5IMiANB/V
	2IcpK2CGbp9lTgTRX147mUEpX4pWijjh0+aQYvEaj2+lGvzJdU2sun
X-Google-Smtp-Source: AGHT+IF6ne65LyKitvtohHkd/RhYdjvtlI53xxlS71gKJpjuQbQ/5Ucc5NzSoGtxdjiDZvwFwV7oSQ==
X-Received: by 2002:a05:6a20:2446:b0:361:3bda:43aa with SMTP id adf61e73a8af0-376a81dc0d7mr13150056637.1.1766486769079;
        Tue, 23 Dec 2025 02:46:09 -0800 (PST)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com. [209.85.214.181])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7af29dcfsm13388309b3a.17.2025.12.23.02.46.08
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Dec 2025 02:46:08 -0800 (PST)
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-29f102b013fso59850405ad.2
        for <linux-pm@vger.kernel.org>; Tue, 23 Dec 2025 02:46:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVALhj6OIuAuzkxuZ3I6K3lHDfE3DAR+PSmKI2D7VvpYDbgyp+Ft8xC6SRrBHdiLT4p0VGB2SgmQQ==@vger.kernel.org
X-Received: by 2002:a05:6102:2c83:b0:5db:cba0:941 with SMTP id
 ada2fe7eead31-5eb1a833fdamr4565375137.38.1766486456463; Tue, 23 Dec 2025
 02:40:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251209091115.8541-1-ovidiu.panait.rb@renesas.com> <20251209091115.8541-3-ovidiu.panait.rb@renesas.com>
In-Reply-To: <20251209091115.8541-3-ovidiu.panait.rb@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 23 Dec 2025 11:40:45 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUqntcjKsJN=-hiVcXfan5Ps6bBjknQ3aYbc8+z7+1eRA@mail.gmail.com>
X-Gm-Features: AQt7F2r-712B74ouLs8f-R2peKEALS9-alhfFATxSjlyRwz2ItMteJAgsFd78_E
Message-ID: <CAMuHMdUqntcjKsJN=-hiVcXfan5Ps6bBjknQ3aYbc8+z7+1eRA@mail.gmail.com>
Subject: Re: [PATCH 2/3] clk: renesas: r9a09g056: Add clock and reset entries
 for TSU
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
> Add module clock and reset entries for the TSU0 and TSU1 blocks on the
> Renesas RZ/V2N (R9A09G056) SoC.
>
> Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-clk for v6.20.

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

