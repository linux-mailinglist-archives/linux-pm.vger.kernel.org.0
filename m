Return-Path: <linux-pm+bounces-22291-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8434A39542
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2025 09:27:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FD2B7A1FA5
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2025 08:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD0C22B5A1;
	Tue, 18 Feb 2025 08:25:28 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577F21B6D1C;
	Tue, 18 Feb 2025 08:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739867127; cv=none; b=M6ZBw3MSHha5BL6Bly/3kg0zCOKGDfwFQls0HvWT4UmeYp+9kbQFVVLgdEl35kWgE+mAHJ1F1L/UVZo9ERFCCdKpn6aoF4ZisZkXb8KO0R8xackcHnMkVRBcLB04ATyDTAkRM0iYCAJqubSvoS0zkZiRgSR1Z4lYJI4QsZbi/gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739867127; c=relaxed/simple;
	bh=eKpFWYk9gLsR1VwUPE2StO3ksoQrbMsGjkHO71WMvoQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AITSth1eOC8NVOdGsnJu3PB1MHROdIx4P8nWktAeiG4W+RBm7N/0iOxFLWHcKNwOcjcqQwZJcsZtJij1ftINF5qph7GrBvc/nFJl5URjm9vhoACmV95NhjpW6OE66YXPWHHXmudqqeARnbe1hjBgNRjSiXoYVSKpDL+GvBB3ltw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-4be75b2bbceso171881137.1;
        Tue, 18 Feb 2025 00:25:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739867124; x=1740471924;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cDPxvkilNbMO9E7etRrlexrHd+7C+mRJTRHcVNpSHmo=;
        b=sJ0Q3Xox/u95WqxVZRxCuS4BC6PSny10ggGyTCVOhkfbc1X4KmGEsAZLqU1odlYy8m
         g9ieNPkhmZ/lMBvHp5WXRibVjGeua+9jlaDb0p12tLzS4JKbDLCzzSXT1++E3n1ZwslJ
         4bu1WTNsUegnJYfKujIBpZ87oDJObloHhfMZgIWi/ELUGqRH+qrI2XNylDGqtxbP0T/g
         exKSordtriNHswhtuWtUFEe7d366rzCp4nn7e10ME9vLTCcdmOyJDaDGXV6SDyGWJRk4
         ZpyHBJwv3smiDXIXoGXHWbD84oDu06D+k1OK1BC30ljWU3zvF4ej0NoLNUVJ5eaI+Fkg
         E59A==
X-Forwarded-Encrypted: i=1; AJvYcCU5Qt2szS09qiQzieG6iWCsFZ3Rf1vxwJfjPNO97xipEzwiBHB0+vxvU42K3Zo5qUj08g8GfjpcU+ZbyAIPtPlRxTc=@vger.kernel.org, AJvYcCWNXq50Z7rHmWKWz3O/uJ9RB/eXqa3yr7HDpsEqvdaUJ81Bru8z9sCi13dr/L6ZCsrmHtqXti/S64U=@vger.kernel.org, AJvYcCWWDlc8zIYvljfpVrGIQXLeZozEpoZdjpILQfEJnXqWc3w+UoGU2RbUaFcwtcNcwqMyY+IEyagdiOac@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0mQqu78queFB2jV8npYOS/iDogATdPSzAEF+fAym/oVSFs4G3
	tqbJM3keGQL41jISBlAOePicQ9V8K9+fkpIYznnmC/EWZKesd+Sf1pV+8nIRzto=
X-Gm-Gg: ASbGnctu2j6XCsVyPrpfFxEHWhgJqx00BQE65mQUsYgDGotN7EW+Dh3dACEiL08/D4Y
	QAnDOizn8sz/ESwUyxsEBH4IC+CqGiLTWkma/7HTvoZgZYGLE6eLETamUB5YwaRglYwkiuquROz
	GOG5xdN6avCcrQUp6TiC7bakw1xyxgUSAhcCwnGJOtpsLxI7X1uBAmpU1ON/38M8cwEFEc3kpRv
	OAKfioUUbAbsErOC3Wg//RHbc4dDIDvGxEvM0TNP2MSjOnosX7xWvIdcVdYSYwpf1q7MLmf9Ge8
	I00wswNuhNwqW/XVR4rtv4faJ16CtCZ3aEWNZmTRvIwYAy/7qZkl7g==
X-Google-Smtp-Source: AGHT+IF24tgc8uwn/sK840AKDhGIqFJnaEdfbamqf+EEzCL5YyNsZiYxvqe9r6cOnKJ85VgyvyCngw==
X-Received: by 2002:a05:6102:c4f:b0:4b2:485b:e151 with SMTP id ada2fe7eead31-4bd3fc9b9fbmr5691529137.10.1739867124544;
        Tue, 18 Feb 2025 00:25:24 -0800 (PST)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com. [209.85.217.41])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-868e86bce70sm2242220241.27.2025.02.18.00.25.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 00:25:24 -0800 (PST)
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-4be4de0c038so709494137.0;
        Tue, 18 Feb 2025 00:25:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUNxXRuEibyVgoBByMJxS0ntcvDNt4Ek/tJWeBSznZ2Z3H+7W1MnR9HEg9oWdhGvX+uraZOqRzFThRA@vger.kernel.org, AJvYcCUjQtUg+P6JAy+7zY7BP3sgshwzD8QwWXJrKzBh9VArqXCXAGTa0M463cqESXz7eI+NBO72e7dfouM=@vger.kernel.org, AJvYcCUkgPkooICdn+ufci68XbVk0ShbfewSWB9cn4Sp5cgsAAcILS4zsxt2aJbMJbygB3sGr+/U6xMfvIwt1To+Yt90ZfU=@vger.kernel.org
X-Received: by 2002:a05:6102:f8a:b0:4b2:adfb:4f91 with SMTP id
 ada2fe7eead31-4bd3fe2a660mr6642224137.21.1739867124064; Tue, 18 Feb 2025
 00:25:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1728377971.git.geert+renesas@glider.be>
In-Reply-To: <cover.1728377971.git.geert+renesas@glider.be>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 18 Feb 2025 09:25:12 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX6CBXuKn8bk9y=YpYyD6tCE8fSbQJBns=1aO6uG1_irQ@mail.gmail.com>
X-Gm-Features: AWEUYZkUFoq6t5-uqY2bkFLs-5l0x0T4E_EBgtc_8teNEaiiojRb2XaDjcZj1a8
Message-ID: <CAMuHMdX6CBXuKn8bk9y=YpYyD6tCE8fSbQJBns=1aO6uG1_irQ@mail.gmail.com>
Subject: Re: [PATCH/RFC 0/2] arm64: dts: renesas: Re-add voltages to OPP tables
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Lukasz Luba <lukasz.luba@arm.com>, Magnus Damm <magnus.damm@gmail.com>, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, linux-pm@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 8 Oct 2024 at 11:14, Geert Uytterhoeven <geert+renesas@glider.be> wrote:
> When CONFIG_ENERGY_MODEL=y, an error is printed on RZ/G2E and R-Car E3:
>
>     cpu cpu0: EM: invalid perf. state: -22
>
> This happens because the Operating Points Parameters tables do not list
> voltages, as they are all identical.  Previously, it was assumed they
> were optional, and unused, when none of the CPU nodes is tied to a
> regulator using the "cpu-supply" property.  This assumption turned out
> to be incorrect, causing the reported error message.
>
> This RFC patch series fixes this by adding the missing voltages.
>
> Note that the Energy Model calculates energy efficiency by dividing the
> (estimated) CPU power consumption by CPU core clock frequency.  When all
> voltages have the same value, the former is proportional to clock
> frequency, and energy efficiency becomes a constant.  Hence all
> operating points are considered to have the same efficiency, and the
> Energy Model always picks the one with the highest clock rate (see also
> [1]).
>
> Alternatively, the Energy Model could be changed to silently ignore OPP
> tables with missing frequencies.  IMHO this is not an unusual case.
>
> Which approach should be taken?
> Thanks for your comments!
>
> [1] "PM: EM: Question Potential Issue with EM and OPP Table in cpufreq
>      ondemand Governor"
>     https://lore.kernel.org/all/a2ca883e-122e-43a1-b377-c43956b5b3be@arm.com
>
> Geert Uytterhoeven (2):
>   arm64: dts: renesas: r8a774c0: Re-add voltages to OPP table
>   arm64: dts: renesas: r8a77990: Re-add voltages to OPP table
>
>  arch/arm64/boot/dts/renesas/r8a774c0.dtsi | 3 +++
>  arch/arm64/boot/dts/renesas/r8a77990.dtsi | 3 +++
>  2 files changed, 6 insertions(+)

Queuing in renesas-devel for v6.15.
This can be replaced by an alternative solution later...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

