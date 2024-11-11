Return-Path: <linux-pm+bounces-17299-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0FA9C37D3
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2024 06:31:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D5CB1F2005B
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2024 05:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F39F145B2E;
	Mon, 11 Nov 2024 05:31:21 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55AAAA933;
	Mon, 11 Nov 2024 05:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731303081; cv=none; b=gFGhvRjiacSe6NTGIs9Datd5O6Ujfv9/dToRrskZGHxCj9Nd1nZY1fWJqHnjJIWlKpH/0QK84spt8yNm8AM2AGV6HIElzfTvuHymeG7BQ2hi1aqPrnMv7GhBxNHUm9DslM69EA3VIdkssVRUxh5NPwXUHrOc+9lG3wqGkcgzfdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731303081; c=relaxed/simple;
	bh=zyKW1CXLEkdNEPmzSCYDESj1AeODVNzwQcQ+WLCbHjY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZbmHg7bFNGsUSGtu2i+7zWpbOuzKRDgWx2kMkQo4OPHUjnfmdVJpvOzkHvRNMaH9KO1EDFpdEbkTA0+XkBrkqx4hwdVPPHrabr3SpvM74OeLwF7MIJZ8D3wAX5X/ZN7xsGk+mgeU8qL6A2G4Kj8XnbdK217CY4/74P/WVPD7cww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-539f76a6f0dso4515623e87.1;
        Sun, 10 Nov 2024 21:31:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731303074; x=1731907874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qlYch/7P7MKfX51HOayXD115fD1eKIDV7PlOr922WnY=;
        b=k3gO0wDBu3b3BmUGTSE0xye/Cga2YbXfOneRFkiCUgif+dIVGam+H4EI1voiVqiBzZ
         CPrhTasBzvXbgeyRiVJGgTqt1KjnuY1Tptz10dKjYLevcCyGTxRPPLUAsjD7krfmghJp
         5lDn4iae9SZsnBzyqtNcLv233xC2zBFMa4LkdEMQpqlR8sDT0WIB1ug6zhv+nQ+BEOUi
         l3Cx6q5Jm7NC3/JEaLzULyccLYjD5aQIobtzPsQJaC7houy50ieowKnu1fjUZR6Oguuo
         x2aMS784icJ1YXT+BxaGV1RF5Mb+gXUZLWhY9mz+RFXA9cZ5TU8gcyg2yeLpa5Ng1uYa
         GW+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWPpKzLNbM8fTZCcovs6e8RR9f5//vFyEdR665BTPKxbf/ww0TSjDxnnSXQ1FGBNJrwYCQjRRJeVrNKibE=@vger.kernel.org, AJvYcCX8K0I4Wmu2vrG5lmJACqcvCYkhhxyBSKRYHDSeZIDps30reYf01MziX3C67iL5LvyjSgubnGFSzJg=@vger.kernel.org
X-Gm-Message-State: AOJu0YweVD2Rz+3GDeRNCttFMWSUXJaBHbEeRq0u/4ueATeRm42SEPQ1
	rQ+zCVvCSJNBR4NG9kHkSzqdLmO3y5d+GW/ddQMnzUiHUwJxRGnsLHi3fBE4
X-Google-Smtp-Source: AGHT+IGhFnvy0eCsJfaKWoU6+t5TVNa8r65JMf4XokSzEmdxoUsY1EOHazBvA5SuzmMRubqXCeVIdg==
X-Received: by 2002:a05:6512:3048:b0:53c:761c:2a14 with SMTP id 2adb3069b0e04-53d86296c97mr4594669e87.29.1731303074275;
        Sun, 10 Nov 2024 21:31:14 -0800 (PST)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53d826a9d0asm1426380e87.183.2024.11.10.21.31.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Nov 2024 21:31:12 -0800 (PST)
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-53c73f01284so4880765e87.0;
        Sun, 10 Nov 2024 21:31:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUEGA+7Sw62UNQeYiboyYAXmou6AtLLOZwMbgPqaEHIm5rZjk3eThy1GhknECeFUomC7CqBCnoeZHQ=@vger.kernel.org, AJvYcCWuEfpCBSp7EY1Z+lTXRuSFOrsy6kb8XiqP6oEd+ZwP0GkldTw+sAuBw833eNrFqlMXygN9TbOJDCq1I3s=@vger.kernel.org
X-Received: by 2002:a05:651c:544:b0:2fb:6027:7c0a with SMTP id
 38308e7fff4ca-2ff201e734amr40481541fa.8.1731303071547; Sun, 10 Nov 2024
 21:31:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241031070232.1793078-1-masterr3c0rd@epochal.quest>
 <20241031070232.1793078-13-masterr3c0rd@epochal.quest> <20241111041311.hleaz5fgipsyxigm@vireshk-i7>
In-Reply-To: <20241111041311.hleaz5fgipsyxigm@vireshk-i7>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Mon, 11 Nov 2024 13:30:59 +0800
X-Gmail-Original-Message-ID: <CAGb2v646NHFAni=P+iC8OZsWMpg0PJc=kYbuWaY=C0-W-q6qAw@mail.gmail.com>
Message-ID: <CAGb2v646NHFAni=P+iC8OZsWMpg0PJc=kYbuWaY=C0-W-q6qAw@mail.gmail.com>
Subject: Re: [PATCH v2 12/13] cpufreq: sun50i: add a100 cpufreq support
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Cody Eksal <masterr3c0rd@epochal.quest>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Yangtao Li <tiny.windzz@gmail.com>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Conor Dooley <conor+dt@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Maxime Ripard <mripard@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Nishanth Menon <nm@ti.com>, Rob Herring <robh@kernel.org>, 
	Stephen Boyd <sboyd@kernel.org>, Vinod Koul <vkoul@kernel.org>, Viresh Kumar <vireshk@kernel.org>, 
	Parthiban <parthiban@linumiz.com>, Andre Przywara <andre.przywara@arm.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 12:13=E2=80=AFPM Viresh Kumar <viresh.kumar@linaro.=
org> wrote:
>
> On 31-10-24, 04:02, Cody Eksal wrote:
> > From: Shuosheng Huang <huangshuosheng@allwinnertech.com>
> >
> > Let's add cpufreq nvmem based for allwinner a100 soc. It's similar to h=
6,
> > let us use efuse_xlate to extract the differentiated part.
> >
> > Signed-off-by: Shuosheng Huang <huangshuosheng@allwinnertech.com>
> > [masterr3c0rd@epochal.quest: add A100 to opp_match_list]
> > Signed-off-by: Cody Eksal <masterr3c0rd@epochal.quest>
> > ---
> > Changes in V2:
> >  - Add the A100 to the cpufreq-dt-platdev blacklist.
>
> Can this be applied to the cpufreq tree separately ?

Yes.

Acked-by: Chen-Yu Tsai <wens@csie.org>

