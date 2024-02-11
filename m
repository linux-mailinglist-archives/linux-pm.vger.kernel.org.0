Return-Path: <linux-pm+bounces-3759-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E91ED8509FD
	for <lists+linux-pm@lfdr.de>; Sun, 11 Feb 2024 16:29:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E9AF28250B
	for <lists+linux-pm@lfdr.de>; Sun, 11 Feb 2024 15:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C615B669;
	Sun, 11 Feb 2024 15:29:02 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA0344C9E;
	Sun, 11 Feb 2024 15:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707665342; cv=none; b=pYk2snk0U/+qIx0JnWr2BPlx8XX5Wbqj5ZbsPsaWOU/attpAwFfS3+F+k9GYgbYDjSSuVD5k3X6/Hn0Jr42bD8JbRe9m00K8JIBGXAMU2dWOQgnDXmU/JtdZEPmQAiv8LQCIw7GC+df7rnE2oCFkfniV7ZhmDdZCP37vXnXCFHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707665342; c=relaxed/simple;
	bh=gXpFBV38qG07wfbk3n6B1tYa2ufvXDPPeQA6qkuj3Mg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ppthJ0J+gI2o+14GpCCfCw3pxqVzB+yR1D4PY7sxnFaUuegsaC/YivJk/xpNMLad2BnPPLmPmgwEohnZUDpddl2wmRA1Fhb46bugrYVTk68AqG2r1y07VIwVwxNcTv3RmlNFuWiJsGXUz5AI0jrRGc85lHDjuQM9xLjzNMBed8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-604fa400f85so3884417b3.2;
        Sun, 11 Feb 2024 07:28:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707665338; x=1708270138;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ps+vZnhpj0WdVvYU1PNOqTnxsRPXds+JKXHNtl9pqWQ=;
        b=gszFIscPtrgyq/MFw+13ljsSP+dU/PYr2PYoG6IdNXZMWJEBsfY65ERcKaRUmu+vx4
         rFmJrfMCdssIGpNls35+AOdAMSB0TzHpAH8PF4jZFs0z7TLxOk5ek1079Cj44yBHR5/B
         5SX8z0w6NeYhvpuSaeUF4oFrvBCf27hzCHzCVSMtPDm/DJB1+AZ7gtBunlTvBULA3wWY
         T7mlY0lysAn4RmbtAJEqlsUmj1+68pVzkFjoHEoFRuwNZUom+L+UdG7A8yaTK/MdYmeS
         nNkA6AnNvddmsozfeVignCVifkAqV2pzSvWT0wSpYhfHGdpMf/tT2gdDRYKvzw4zQ+j4
         bzCw==
X-Gm-Message-State: AOJu0YzcDM+Vt0vlaPeLA52dFXp2VJrK4KKC5RnzRQ+zaV0kg4QP4N1u
	1PbM8+ZYAAzBzYXfMO0SI9IqF3r793C8hcWbA+WfYwNzqS6OfLSagiSqOoLLCC4=
X-Google-Smtp-Source: AGHT+IGWo6t5GkLNPsUpJ+4HlqfyYQv/i0d9uSOi6UK8HvxpAC9QUERp5ftPE7sdYSlrGtxK2ARJSg==
X-Received: by 2002:a0d:dac6:0:b0:5ff:6b9e:cdd9 with SMTP id c189-20020a0ddac6000000b005ff6b9ecdd9mr2922365ywe.46.1707665338251;
        Sun, 11 Feb 2024 07:28:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWnWpzYqqAM64E/u76O5Mi39ElnY2FcsWwD5wgOYsFVigDVCVupNxjOJh1R7FqjAtwzOq7odV/hRML4HLmI7udbz5FVHkBTLWmsocEFezla9LTh/eeqCWuntE13ZS5pL9DIqlBmQ0LHVhUC9w==
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id v126-20020a0dd384000000b00604aef6896dsm797096ywd.37.2024.02.11.07.28.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Feb 2024 07:28:58 -0800 (PST)
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dc755afdecfso1946765276.2;
        Sun, 11 Feb 2024 07:28:58 -0800 (PST)
X-Received: by 2002:a25:dfca:0:b0:dc7:44bf:71b1 with SMTP id
 w193-20020a25dfca000000b00dc744bf71b1mr3492120ybg.35.1707665337940; Sun, 11
 Feb 2024 07:28:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87sf22a4sp.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87sf22a4sp.wl-kuninori.morimoto.gx@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 11 Feb 2024 16:28:45 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX=B0q0gQixehg=8xNeCuU3wYd8ak5TXwYdiiNY5TmLGQ@mail.gmail.com>
Message-ID: <CAMuHMdX=B0q0gQixehg=8xNeCuU3wYd8ak5TXwYdiiNY5TmLGQ@mail.gmail.com>
Subject: Re: [PATCH v2] pmdomain: renesas: Adjust the waiting time to cover
 the worst case
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, Dien Pham <dien.pham.ry@renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024 at 12:56=E2=80=AFAM Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> From: Dien Pham <dien.pham.ry@renesas.com>
>
> Description in HWM rev0.51E, 9.4 Usage notes, page 455 tells
>
>         "It takes several hundreds of microseconds to shutting off and
>          resuming power domain. Because actual time required for
>          shutting off and resuming depends on the status of on-board
>          power line, shutoff/resume time is not guaranteed by
>          electrical specification"
>
> Let's assume the safe value of waiting is about 1000us.
>
> Signed-off-by: Dien Pham <dien.pham.ry@renesas.com>
> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> Signed-off-by: Tho Vu <tho.vu.wh@renesas.com>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

I think you can drop that line ;-)

> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

