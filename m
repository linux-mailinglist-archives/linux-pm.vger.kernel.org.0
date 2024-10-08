Return-Path: <linux-pm+bounces-15337-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83090994F71
	for <lists+linux-pm@lfdr.de>; Tue,  8 Oct 2024 15:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EAE81F23B88
	for <lists+linux-pm@lfdr.de>; Tue,  8 Oct 2024 13:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C7D1DFE26;
	Tue,  8 Oct 2024 13:25:10 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6664B1DF722;
	Tue,  8 Oct 2024 13:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728393910; cv=none; b=JiV1nrOzLXLPij090sJLiQJUuWGeFrXmuxcNyYYPwcfImyJa/N0DmLLAmXBQ7T8IdcEdfXR5DMuYw31Dnc3obywFzNTasbdXW1WdolLb7rv29m9GKp+GyOn+STcGSBioY33u6cQbXGZQUNuISj3xL9Tc/M06i5onQt94MYM+Azg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728393910; c=relaxed/simple;
	bh=8cPQ18ZYxStSBAQyPBEV3/pACcDlNo2MF0tRAhLZyKg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nU2lg/RLIxPgnwiSn881vOsCs3EOgiLulLt4d9sINiEWfmUmWEChnxbl88jyIHRSzzJH/JS2D9g9KAmRGV4zNL7AmJiQxgiyhtMxj6p/utbzitc6jpXUNUcGgqoD88wjNI2MGUZefZ3I0wDRaA6cxuo3a6rJRKhVpZxIFILVJ70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6e2d36343caso30992717b3.2;
        Tue, 08 Oct 2024 06:25:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728393907; x=1728998707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+nSn19YtBYesjA0jHORDHT8Ybkkt74qSl6rAXa4U574=;
        b=lv9362xw59ncHpX2vCjw+kI4GgJW3Ykl/xjkWet9jsGZODOhKNIw0qvfYerLMv1kRH
         wc474zpLqgfiIbncQweRKaLrtJbOZo3zu8F0u8G9+UwjjMZsy5bNR6Ud9D6hIHWOfVEZ
         FzNAbEMkIsqAh7IKdz7iioUCWfGM3PD3ijB9SnEw44S+cCIbr0BZ8oR8m6k/bre4vKY6
         Pc5KRj1Ilh9IbLch4Pgdc9jEPRz52TtFzqjqSLdjUkAcnUcdNZF+tGNR0bVRoZppbbp3
         nolAE/9rgn+6d01sJ82cYpf8sWKUFew04+odVxEd2lqyaU5fIYS7AIfYkNPWIrmBscjI
         vaMA==
X-Forwarded-Encrypted: i=1; AJvYcCU2LW/IJzrUQ2duHwWUERNZwzVdmpmFlhrwGncTL2SyoSyozwQ4T2kxtrGTHKXuymSMt322XfV+yoxowAM5@vger.kernel.org, AJvYcCVDjP+9DeIsXQ8dx94tQH65IUFSJZZXeN4TzsOtWlc1sNkFjCDm/xH63eVyTxP1AnvwnIvl2hnjydp3@vger.kernel.org, AJvYcCVhFHZxiKTMoGnZ4+nwZ1AZVFQiXr5w9BUeKuyvSbA0V7p1h7cliBQfXHe2KJxAANI2dBYbhX7xvraA@vger.kernel.org, AJvYcCVyP9xJkPFnIIfAs8CljQRclIB/GqT8pvOKMiho0ZXGUgymPJTOnr0/Nv6r8IPNkdYHt0vRFjMj91R0@vger.kernel.org, AJvYcCX5mXDwxxOTerJZ81MC20QV1qOyVyfc4jC+z6A9trrwmZAN0Zd/uJBLE8aaaFI/+77NvVw9sz8UNxI=@vger.kernel.org, AJvYcCXXjiJwKo+QqufEO6u5N86IBnbGt+LNgiqW4Zxx1PaMCF4es9y3fEgIoKYb+pXLOqNOMQ+KbKzNdg/hDZ7jWAQnqBw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFgvU247Hofi+m/3vq+qTz+FRt73EUa5dkOIMK0nZC0BJjWERC
	Lb9j9cxuWDdph+6kz1O8tpitPmxXCyNSWP961vo8X3WNUQqvNz4ULyAiPSyD
X-Google-Smtp-Source: AGHT+IEVXmJv+lKoyHQ3MS8mqKn+VCRIcPc3y8remeQQ+xKEiSjX0SIylKUkfZT7qpy+zr+8vCMgkA==
X-Received: by 2002:a05:690c:6484:b0:6e3:182f:f974 with SMTP id 00721157ae682-6e3182ffbc9mr8724307b3.45.1728393906775;
        Tue, 08 Oct 2024 06:25:06 -0700 (PDT)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e2d93d6eedsm14209307b3.78.2024.10.08.06.25.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 06:25:05 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6de14e0f050so43213957b3.0;
        Tue, 08 Oct 2024 06:25:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUZUm2U2jAZ4wQi7fHEQNmu7Qf/ZK7I/cgSsUtmTgwTiTRkm8dm3I7SLsDTdKRy0W61lxNGZqTJ7VsTPUFltjIHuSw=@vger.kernel.org, AJvYcCUlqWozA0Z4WWFYdmoJkPZYCAoPJi+iPZA24jg0DMy/xWDTYon45w0lPhPsMV6jMpkGXLHjgaOXCFZa@vger.kernel.org, AJvYcCW0TBSpVT86NtDgQYMaIJyxbu7fYSIvyFCbnkEAgew4nwrjF79gfvXiNT8btN7rtHVK/5qn7fEj6h4s@vger.kernel.org, AJvYcCWfQH9n1NJilMUNoPU8KkmeHZ3YTBVTQW/vs2ud0S4thypsCcQJkRhPeyYQt8mnjjRIhUjQ5pL/EzI4URC8@vger.kernel.org, AJvYcCXAVYz4ITXVAS3Vq55KVi98xDDd8w/dwTrMFRhIYKXDd/1p/nNbrb79tn/9cqfw0FCNLvHWNgaJP+w=@vger.kernel.org, AJvYcCXXokzrEKfJS6xpKfwA7aqbcJ4VAQ3R/6fKV/z0sIJa78Z8N2P8SITe+XWQ8JhMsjLR62TrErwmFG+c@vger.kernel.org
X-Received: by 2002:a05:690c:7007:b0:6dd:d407:4568 with SMTP id
 00721157ae682-6e2c7262e78mr141049967b3.26.1728393905298; Tue, 08 Oct 2024
 06:25:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822152801.602318-1-claudiu.beznea.uj@bp.renesas.com> <20240822152801.602318-3-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240822152801.602318-3-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 8 Oct 2024 15:24:53 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWOTtVcSu36orjrsnNykPcNCmHpXmGz7mV9WGW-aN9WZg@mail.gmail.com>
Message-ID: <CAMuHMdWOTtVcSu36orjrsnNykPcNCmHpXmGz7mV9WGW-aN9WZg@mail.gmail.com>
Subject: Re: [PATCH 02/16] dt-bindings: soc: renesas: renesas,rzg2l-sysc: Add
 #reset-cells for RZ/G3S
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: vkoul@kernel.org, kishon@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, p.zabel@pengutronix.de, magnus.damm@gmail.com, 
	gregkh@linuxfoundation.org, mturquette@baylibre.com, sboyd@kernel.org, 
	yoshihiro.shimoda.uh@renesas.com, biju.das.jz@bp.renesas.com, 
	ulf.hansson@linaro.org, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, 
	linux-pm@vger.kernel.org, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 5:28=E2=80=AFPM Claudiu <claudiu.beznea@tuxon.dev> =
wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> The RZ/G3S System controller has registers to control signals that need
> to be de-asserted/asserted before/after different SoC areas are power
> on/off. This signals are implemented as reset signals. For this document
> the #reset-cells property.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

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

