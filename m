Return-Path: <linux-pm+bounces-32605-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F31CEB2BAFA
	for <lists+linux-pm@lfdr.de>; Tue, 19 Aug 2025 09:44:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99D1A1893511
	for <lists+linux-pm@lfdr.de>; Tue, 19 Aug 2025 07:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A25A82848B2;
	Tue, 19 Aug 2025 07:44:27 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6C220B80D;
	Tue, 19 Aug 2025 07:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755589467; cv=none; b=tGTsU9jKnsJcJ+7yGe1MHOa0skVJsorrgPQLgh/+tErRxVYMhCyuXAx2UOkw0N7QA+uDLlwnXDDGmU+tUOjfqSp4XIFjxS2FDdFc3aIgVfdlgHw0eFZipGVxm1Ck5rf6Ncm54uNeHxA/PNC38DVo6WHBpzeN4ErP+QqE/FmhAoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755589467; c=relaxed/simple;
	bh=hwDi8sI4pb6ewHpH/UxAP+aBsRc4EAsj/SVHWYMpqcc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BPClGOpBNFErDM1LBfFSWAkU0RAZgX3l74aRNBnJatJ2WrukoZyn+9HpmrhKBfUIrnliGkmlK3WOZHWvKoJ7aNCl8MeDlaoKNb3wWqoEYecKlDNOWwwSXIdlQBpOKvpG9pkH4mBiDrk9jSpTHPvlHg6EgQIAdptA9liinMVYrQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-53b1737b9c8so1762740e0c.1;
        Tue, 19 Aug 2025 00:44:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755589464; x=1756194264;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5gxhxdF3vQ/iqynK82+PoG7FIJTLcJKLDWKPn4QyzC8=;
        b=HqTj2lVzt+HrDAhFmzUz6BaCbqRP63mI/neMkKDZ4FcVjrElXHSSHOIMx4GqweceTd
         Ubvuiqyo86lLp3l5WDe8xfB7A4yJIwk9SZrG4hQu4Ym9SrNjunBoNngwm+QK4qycSIUi
         Da4hHLrQJcErm/5gOEcTI82iQ4UbIWo6UOZE460Y7uwz0O5vSPxSn95Bp0c5DFV2DFW+
         JITGMabkPK37xnhE3bCIj1Ntl+b5NKigrAKkbartAAsmdzlN3zsg7Kh/iLERGGR1IJfY
         zOrhtjowgfFpYuLsaK7atQbD90taToeSP1SqaP0S5/aB3XpSVcwAi4lD2YjWO2Oebn75
         98LQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmlH4h6Qhc9h5jSuv4OJ38MQub0TGMAS+Q178AetiKqDF7amjT9x89koMa8TzOFAXlyuSuuoSWyvo=@vger.kernel.org, AJvYcCVG42JPFJYVTfNajLGOEZbn+u2nqHjOsnFvCtsVSDhmpUbk9uwe2DrhoKj9sS5os4khf1L+hmK23NnqmxbjjQT1VlM=@vger.kernel.org, AJvYcCVwC6lzgtruvivjB/9dBx8IDIIpf+zjZz67izbTMx51aJ67jb0yl1biFgbM3NG+komlPw/VA23LIvl+C1+A@vger.kernel.org, AJvYcCWv+e8O+j4r557EbiC9g2JoKJuQtFGqVHxjIvYtpRCfLZLNzSmSOaYNUzBk8f8Qxi2heuXqGhVyn9Ek@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7tbrSauhYeJcdwSWp8hSRqUV7weoUE78O+YdwDuSjQUi3uPzi
	WKTkDAnasXoWYj1JrUfjt3ZHpi52+CA8uPCTxuBhgJO4yt+Zdx6b/tpd/lQ34df9
X-Gm-Gg: ASbGncuRvTQnsJslOz83FmH2g0b2Y1E1uVKMAsp64O4KB/ptEdY2WKo3X6WTcySawts
	GBY0NqM9yPZmp99jp+oaGQI0DDG/wnyyi9N1THA/a0ym4dgqFGR2HX3kEei8xyUpNidatIS2zNT
	qJ0OMJ9oWnmkn7/eZUw6dJzXtoSDQQuIyjdhKcefpdKf9jz/OeD7o4Umbchz0/++dHlkf6CoEiR
	VENhqIOHfYrPqeIwqbMEa3kg3QsZoLsafFjRs7EB6T9Bvlkk2wPYSOnKCinVWkA/On7GBH0YgSK
	B1F+0aoAncR2Vv6hvtkvGsCeA7KqhPXNQN3ybc6mYNZ+cnGEoPgkIQ4n8zuInwhoDPnT/XmL/wd
	smizZnB/9mJfaUO6gxiNUAVmTy8BqyLlpI+Zvw8xDvdKjosnZGd9ulsqUKGjOqmy3d5fsGyInUl
	U=
X-Google-Smtp-Source: AGHT+IGOVZ0Ffu4V1wu6gVhB4jpb0NsPaRBrR6jp7IM6Q+jX0jvdVMk5x0Zt6h35uHF3tonowGaRNQ==
X-Received: by 2002:a05:6102:4425:b0:4e5:9426:f9e6 with SMTP id ada2fe7eead31-51923d38b59mr452656137.23.1755589463775;
        Tue, 19 Aug 2025 00:44:23 -0700 (PDT)
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com. [209.85.221.172])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-53b2bd552c1sm2431853e0c.3.2025.08.19.00.44.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 00:44:23 -0700 (PDT)
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-53b1737b9c8so1762737e0c.1;
        Tue, 19 Aug 2025 00:44:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV01zDgHHKSEou+tqqsuaUQrdr3zxMNs5hUVpoASLfq7HzsF2JC3LkuqhnZ9i6a7DAXt2aVE2FY6tk=@vger.kernel.org, AJvYcCVZTWjk7WPproEy21NKNvxgfVb2dPORaGrEdhpu6U629iMLRRXE1DTq3Rl/zqsgLNzpNYuYfVSMrYwE/lgR@vger.kernel.org, AJvYcCVt4Wqh4UhI+sSToV2aZYyH2sCCbvzyV0Qp1RZ30kgVUpmN7iEqjTi/jrKfmNdDxto7Rl6E5ZGhnPiY@vger.kernel.org, AJvYcCWS1iorb+1J8GEMi6Vv11sk6eIeoareeDPkHSsNXcBjKU0/nRMvBXXMtjhmC0CgPyfco+zKvPiZ3B1h3Be3A67wnQI=@vger.kernel.org
X-Received: by 2002:a05:6102:1608:b0:4e6:edce:4b55 with SMTP id
 ada2fe7eead31-519b27c870emr28164137.4.1755589462392; Tue, 19 Aug 2025
 00:44:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818162859.9661-1-john.madieu.xa@bp.renesas.com> <20250818162859.9661-5-john.madieu.xa@bp.renesas.com>
In-Reply-To: <20250818162859.9661-5-john.madieu.xa@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 19 Aug 2025 09:44:11 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVV3tH-Mnkb4z=_3Fu9_zaB+ysuFQYni-ss+Sm_JmZFng@mail.gmail.com>
X-Gm-Features: Ac12FXxuuCpFvi4bwIVSlqKVwnnWvAMNW-GEJwHYH1WcsCL9Lbq44q3fnYgjfHs
Message-ID: <CAMuHMdVV3tH-Mnkb4z=_3Fu9_zaB+ysuFQYni-ss+Sm_JmZFng@mail.gmail.com>
Subject: Re: [PATCH v7 4/6] arm64: dts: renesas: r9a09g047: Add #address-cells
 property in sys node
To: John Madieu <john.madieu.xa@bp.renesas.com>
Cc: magnus.damm@gmail.com, mturquette@baylibre.com, sboyd@kernel.org, 
	rafael@kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com, 
	lukasz.luba@arm.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	p.zabel@pengutronix.de, catalin.marinas@arm.com, will@kernel.org, 
	john.madieu@gmail.com, linux-renesas-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, biju.das.jz@bp.renesas.com, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Hi John,

On Mon, 18 Aug 2025 at 18:29, John Madieu <john.madieu.xa@bp.renesas.com> wrote:
> A couple of registers of the system controller (sys) are shared with the TSU
> device. Add #address-cells property to sys node to allow proper parsing a
> access to these registers from the TSU driver.
>
> Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>

Thanks for your patch!

> --- a/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
> @@ -278,6 +278,7 @@ sys: system-controller@10430000 {
>                         reg = <0 0x10430000 0 0x10000>;
>                         clocks = <&cpg CPG_CORE R9A09G047_SYS_0_PCLK>;
>                         resets = <&cpg 0x30>;
> +                       #address-cells = <1>;

Iff you need this, you need to update the DT bindings first, as reported
by Rob's bot.

However, looking at Claudiu's USB series [1], I think you can do
without, by calling of_parse_phandle_with_fixed_args() instead of
of_parse_phandle_with_args() in the driver.

>                 };
>
>                 xspi: spi@11030000 {

[1] "[PATCH v5 0/7] Add initial USB support for the Renesas RZ/G3S SoC"
    https://lore.kernel.org/20250819054212.486426-1-claudiu.beznea.uj@bp.renesas.com

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

