Return-Path: <linux-pm+bounces-42813-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uIiyDJCelWk4SwIAu9opvQ
	(envelope-from <linux-pm+bounces-42813-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 18 Feb 2026 12:12:16 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D28155CFB
	for <lists+linux-pm@lfdr.de>; Wed, 18 Feb 2026 12:12:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8AF9530193B5
	for <lists+linux-pm@lfdr.de>; Wed, 18 Feb 2026 11:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CFAF30497C;
	Wed, 18 Feb 2026 11:12:13 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5637B2FF677
	for <linux-pm@vger.kernel.org>; Wed, 18 Feb 2026 11:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771413132; cv=none; b=mnicv+rteQfIsgIRg2c7KCQjA1C5f6lHtKvJmAb3MEeI5FMx5r11n3QLIYfSo7zyj9SPPXNMDIbV9dZztMi/XpsVKU9hcVHpTf6imH9vQxxvcXXkB8/EQJPqYcjGja83eaz2EvAnlqtV2y9LdIlKDIthVWvqbKCFETUJzw/pZ+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771413132; c=relaxed/simple;
	bh=EVRae9qMHeq9BCtv/qf3jwFb6lOOcGA+J4dBoAHt028=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZT4VX1WJFoZSchWaR7SDyLBr19/C4+mDnDyq2TufHEdkLKxgA58bPvPuC266gblnTXT/QtVx5swenIzbrP6z++36nu+VIFYabPaNCQ6+k6HD4CcIBoc7yIQsKj9cREm5uTElt3WzPuoXWKt8DNlefDampvksPvt7JLAPhYlKWa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-5fa26e497feso1543625137.3
        for <linux-pm@vger.kernel.org>; Wed, 18 Feb 2026 03:12:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771413129; x=1772017929;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qVLsxu170PB1z35uEMY8OwYn2VFsOBgEYVbP/16mc98=;
        b=dLsCgX/LsJVs/m5RJrJmiyQz+JU5vWcoSDXlw5yoWBJLMdv2OPZOhIGNFzoY/guelB
         4VBGWg/Go5LIYz+Ej41QbAauWMdlEDduTXNtT4QTfD0/rKB3coIqDOlqXY8w2NJYEpjT
         vLFpn0VpOecERD3B9KwgL1tiuGcleSr6LjMxpH2RYXscXJ/GClHBz1kn6XTpAasRZm1b
         S+gLLNaAp7J9Ez9pk92fqvrRaAHUZBmfXU6KMfO48Wddx3p37QcRY+b92p0lnfA8POlP
         oql7bN4RDvKkQ8A4Z4tCPUufMT6Foo9aAJ2NrMZXKBk47LbTi22ju68Ec7hG7p86g4ts
         1AJA==
X-Forwarded-Encrypted: i=1; AJvYcCXASEsDIQEsJABTSJnTcmDxQDnvaBB2RS9/G4XDFtxhU//MMgyWSeB6q2ueN7edwajfRD69JbvkyA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz89anfYnxa+ThPvmiBVrH2BILg3vL1rSaQCdH+1unZbFBzyJDf
	+kDPLjORey4kiRxzIUKV7aPOsXCaLgFMrYuCMzQLw5YF4RbyQPNwIZP9gcNWgFgY
X-Gm-Gg: AZuq6aJBX3qOElym7R0WunDxMcngvRXmMYZrtRFzJyWeTXbjJqGE1R6LAYG2GtbF7h+
	A09mr9MIfgICrJ6h9+QTo5Q6EWk/dqg6YHFScHidapx2nYSWHG62IR0uVsqimmOvTjBaRGTTF0Q
	8ZppxfV2CYkaQP5wI0NqehxGW6dDMUInD8MEX1Brnj3VDNU1IipAt6C5pfttG1Ftnys4l8+ukpc
	v9Yl9P0VEzEgzlY0B7mg4QgKf88FpkzUl36vYbBZwHAFwvdiAE549+u/GzxBd3VuibmeciK2JFB
	gcKlNfRjYblVt3qnO3Mq0cVIhc7Hyu/KMe3VO9UXrwY7hmf93gUB8oyQ3ydGWTMUB1x+jXxMWzN
	n8Weg0oPzmhV/LIR2y7L7Q0arSmGN5XTHvg6keKy1s/BdLZiMoOdL9N9zZQmzcHzXirCn/68/FX
	Y3abkzxp1PeCCUd2pFJh3yt4E9ehjmkcHk5osRCpAUbv8npGCao0LxQnmGevBhPBqeQA5eFeTwm
	PI=
X-Received: by 2002:a05:6102:a4f:b0:5ef:a666:5654 with SMTP id ada2fe7eead31-5fe7fd82ba1mr464096137.34.1771413129177;
        Wed, 18 Feb 2026 03:12:09 -0800 (PST)
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com. [209.85.221.179])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-94afd1d85d9sm10045548241.7.2026.02.18.03.12.08
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Feb 2026 03:12:08 -0800 (PST)
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5673804da95so1985329e0c.0
        for <linux-pm@vger.kernel.org>; Wed, 18 Feb 2026 03:12:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV178TQwKqUHrATe6h5snrZReuFu08v71F1gIhvEwqioWeobxFd8Oe6f6IXFzWzgN73F4fUqq78Lg==@vger.kernel.org
X-Received: by 2002:a05:6122:221e:b0:566:23dd:19b9 with SMTP id
 71dfb90a1353d-568bf50eee7mr565791e0c.3.1771413128203; Wed, 18 Feb 2026
 03:12:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMuHMdWapT40hV3c+CSBqFOW05aWcV1a6v_NiJYgoYi0i9_PDQ@mail.gmail.com>
 <6854ea2b-b316-4711-b849-038d532f00c1@imgtec.com> <CAMuHMdUdYidx7u2FOFUmiijp-YeYaQQw_Lrj_E-BoUubuxxR_A@mail.gmail.com>
 <0256cf2b-ac62-437c-a6ee-7768e56a35fb@imgtec.com>
In-Reply-To: <0256cf2b-ac62-437c-a6ee-7768e56a35fb@imgtec.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 18 Feb 2026 12:11:56 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUFS7zyvro7h_XvKrKAsK06m4WB+2nD_iYbMLYEVkxn0g@mail.gmail.com>
X-Gm-Features: AaiRm51vN2U_vJPwapu806O-QDmm3RJwGxx5l1KqCSVNurX9AILsymzNQI7z9fY
Message-ID: <CAMuHMdUFS7zyvro7h_XvKrKAsK06m4WB+2nD_iYbMLYEVkxn0g@mail.gmail.com>
Subject: Re: drm/imagination: genpd_runtime_suspend() crash
To: Matt Coster <Matt.Coster@imgtec.com>
Cc: Frank Binns <Frank.Binns@imgtec.com>, Alessio Belle <Alessio.Belle@imgtec.com>, 
	Alexandru Dadu <Alexandru.Dadu@imgtec.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-42813-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[linux-m68k.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,renesas];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-m68k.org:email,imgtec.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: A5D28155CFB
X-Rspamd-Action: no action

Hi Matt,

On Wed, 18 Feb 2026 at 12:00, Matt Coster <Matt.Coster@imgtec.com> wrote:
> On 31/10/2025 08:43, Geert Uytterhoeven wrote:
> > On Thu, 30 Oct 2025 at 13:18, Matt Coster <Matt.Coster@imgtec.com> wrote:
> >> On 29/10/2025 14:08, Geert Uytterhoeven wrote:
> >>> While playing with the PowerVR driver on various R-Car SoCs, I ran into
> >>> a crash/race condition on Gray Hawk Single (R-Car V4M).  After adding
> >>> the GPU device node to DTS, the driver fails to probe due to lack of
> >>> suitable firmware, as expected:
> >>
> >> Thanks for the detailed report! I'll make time to look into this. Do you
> >> encounter a similar issue on other R-Car platforms, or is this exclusive
> >> to the V4M?
> >
> > Yes, I managed to trigger it on Salvator-X with R-Car M3-W, too.
> > Reproduction steps at:
> > https://lore.kernel.org/linux-renesas-soc/CAMuHMdWyKeQq31GEK+-y4BoaZFcCxJNac63S7NoocMj1cYKniw@mail.gmail.com
> >
> > renesas-drivers-2025-10-28 is available at
> > https://web.git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git/tag/?h=renesas-drivers-2025-10-28-v6.18-rc3
> > My aarch64-linux-gnu-gcc is gcc version 13.3.0 (Ubuntu 13.3.0-6ubuntu2~24.04)
>
> I've managed to get some time with a Gray Hawk board today, but I'm
> struggling to reproduce the original issue. Can you share the DTS node
> you've constructed for the GPU? The patch below contains what I put
> together based on the previous gen3 DTS changes and the V4M TRM.

Your DTS node looks fine to me.

> That said, it's not all clear sailing. I hit this error way before the
> original reported error could occur:
>
>   renesas-cpg-mssr e6150000.clock-controller: Cannot get module clock 0: -2
>
> This is emitted when attempting to dev_pm_domain_attach_by_name() for
> the first domain (A33DGA), and is reproducible on the tag mentioned
> above, as well as the master branch in renesas-drivers and drm-misc-next
> (as of this morning).

The R-Car V4M clock driver does not have the GPU clocks yet
(we haven't added them yet, as we couldn't test the GPU).
The whitespace-damaged patch below should add the clocks.

Note that to reproduce you do need the extra pr_info() calls added in
https://lore.kernel.org/linux-renesas-soc/CAMuHMdWyKeQq31GEK+-y4BoaZFcCxJNac63S7NoocMj1cYKniw@mail.gmail.com
And any R-Car board with IMG GPU should do, just make sure the GPU
node is enabled in the board DTS (it is still disabled, due to the crash).

Thanks for looking into this!

--- a/drivers/clk/renesas/r8a779h0-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a779h0-cpg-mssr.c
@@ -158,6 +158,8 @@ static const struct cpg_core_clk
r8a779h0_core_clks[] __initconst = {
        DEF_DIV6P1("csi",       R8A779H0_CLK_CSI,       CLK_PLL5_DIV4,
 CPG_CSICKCR),
        DEF_FIXED("dsiref",     R8A779H0_CLK_DSIREF,    CLK_PLL5_DIV4,  48, 1),
        DEF_DIV6P1("dsiext",    R8A779H0_CLK_DSIEXT,    CLK_PLL5_DIV4,
 CPG_DSIEXTCKCR),
+       // FIXME programmable divider in FRQCRB
+       DEF_FIXED("zg",         R8A779H0_CLK_ZG,        CLK_PLL4_DIV2,  2, 1),
        DEF_DIV6P1("mso",       R8A779H0_CLK_MSO,       CLK_PLL5_DIV4,
 CPG_MSOCKCR),

        DEF_GEN4_SDH("sd0h",    R8A779H0_CLK_SD0H,      CLK_SDSRC,
    CPG_SD0CKCR),
@@ -171,6 +173,7 @@ static const struct cpg_core_clk
r8a779h0_core_clks[] __initconst = {
 };

 static const struct mssr_mod_clk r8a779h0_mod_clks[] __initconst = {
+       DEF_MOD("3dge",           0,    R8A779H0_CLK_ZG),
        DEF_MOD("isp0",          16,    R8A779H0_CLK_S0D2_VIO),
        DEF_MOD("avb0:rgmii0",  211,    R8A779H0_CLK_S0D8_HSC),
        DEF_MOD("avb1:rgmii1",  212,    R8A779H0_CLK_S0D8_HSC),

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

