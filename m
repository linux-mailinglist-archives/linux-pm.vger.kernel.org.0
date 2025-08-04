Return-Path: <linux-pm+bounces-31865-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 440AEB19EC7
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 11:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B1AA3A7616
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 09:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D057424500A;
	Mon,  4 Aug 2025 09:28:28 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38531487D1;
	Mon,  4 Aug 2025 09:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754299708; cv=none; b=j2xEgRowcDVthDyqmS2EBjY3g4mZfyKwVDBwyXWJywtjZmC3bwMkracZMe6pX7KqORM8fxeYV66Hc54eWoITa3833cMyfZ24TINa2OZyhsBvbKXFPkn4n+oXKBnS9ozfkIl3/Zz9CrqyITN3rVrjNPGfXgcwbuuP3PQvJl06cyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754299708; c=relaxed/simple;
	bh=Op1Cu2OCo+8zzqzdfkFHi9VwH4vvFLuz8rocXpDkYa8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AqxQgas1MlTNMmdtKE8fkFdvCnmlNAuewVGMa57Um7Rhn4pAB685HVAsPqP8M/5uW5KFB6NBKhNyiSnl0zTId/VzlNdm+0SiM+nQnZmRglC7mVUnbfma17N3pdhIfKkeI4rqsggsPA70udvOyi0wwm4sCPNN2/Dy+7PSFJtbXBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-88ba6bb90d6so2979960241.0;
        Mon, 04 Aug 2025 02:28:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754299705; x=1754904505;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NM4RzI8b5w8BHb6iPZ8WypxhF4/bEym0kHOS+34MQdM=;
        b=j2jvy1dksjJvmRlkib5hHM1IaKdhYowVrRa9PmRMq59IfBSZBp/4qZzvWz4Krm+cXP
         i5OTRq1N64hPyddk7ax+pGQrRgPgCxlbBQ/eORg+eOeAKoPsjKrSY1PYORb9KrXuNx10
         TAHov6xk9HzItLPhWMlDTuVPPiZKeSD8Sv+Hqfo3AocX/qgUV7DruF1XhCrpEWiUnUYM
         wmof6uFIXtYpGj8j2++IpCZHnX1TdvVJ99V6cx8YWe2SeaPmt8N4moOqTA4YRWau0Ng3
         jPMPcEIfOeSEHA36uc8GmZTvDUjH5f2Dy9bTZ2a53adkCZIwtFqv8M3UjTzmBv+2FOQE
         4J2A==
X-Forwarded-Encrypted: i=1; AJvYcCUsjlOXT4LWymVpyIp6pvVJECez2+KqIkrojqtlFtNDxlDBu/jxT0Nr6DVvsBbUZtPVzmht9zU4lD8n@vger.kernel.org, AJvYcCVrAfJOchaDMoweUYQk7GRLulpsJZSkjXIJrj5jRnO+sVSOKd2hBDCvpVuzc7U7zPVTK8A+syIY1tR2YV17@vger.kernel.org, AJvYcCW6AnLbnkUXAbqu7DfcJBrH0TSX0qxGz7oqfgBjZb1+HtdZDjvIAS/IEgO1bit/gpgMryWHWxEQTuETP7X2PzySttI=@vger.kernel.org, AJvYcCXsQXSqINZa6NnFA5STZ+u5t7rwtXQOwt06Im4z/kR3TatDoIHc/gdaWI1EeTOlTNJXAH+IXQir3/o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoKalv7ZnUnK30oyMLOh6UbEs0yFx82QzcNkhytG95Pl5YnrUk
	YPgQUvCsAzCpdZl7htTQN3ODosxKoMBrAI04sKqbLEdziTOh+/0bbl0uUDwpAqGP
X-Gm-Gg: ASbGncvTAzGVXI4fsLA2H7iRs+KoIkYaHS1qcL9iaO3z1NmvYI/vwLKVD/cdBk4YddQ
	lDPIYe52wCud0/iw3JbuKT0vbDC7HF/ELNmZ3JTOeQNs7sQVNVm9zf65K0XhYAZFhJ8ErOt5b4u
	eHvZuLfadJBPl5MSv2moRGehArAoi1OG0S4hlz6hoTVagru8yQiyrsvffx3vVrWCwlLkVyC74OT
	Mg8xdsTPWfDe5LT8rJbKzYFi3b07oGcGGzkvAO7b4HC1R0tnDikw8bkqPnePMbbfHv1GHqr7wJy
	vMTv+91DbV6oKn+P+BL51zM67Ruf46SDCcRiyKTrbPm56hbmqJxbnALxB2/Ycm/XccZz8i9o3Zd
	yEboIG68ElV5Awk8hEtorG2/yrGRgyqDE9kQU1RksKUUqXmSG7DMI8T9lhQ7P
X-Google-Smtp-Source: AGHT+IHgLi7j9U9K3o7J4WCY+3GF9dtyQ2NoBfXIFIS/dSHhV3lYPVMlzNvK5iZzdfkXZlUNdAHmzQ==
X-Received: by 2002:a05:6102:598f:b0:4ec:e1fa:ed7b with SMTP id ada2fe7eead31-4fda9d71323mr3577910137.9.1754299705402;
        Mon, 04 Aug 2025 02:28:25 -0700 (PDT)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com. [209.85.217.42])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4fc0d42b93esm2318463137.14.2025.08.04.02.28.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Aug 2025 02:28:25 -0700 (PDT)
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-4fbf846d16fso2913930137.1;
        Mon, 04 Aug 2025 02:28:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU9HMYehhOs7WpzSzPIL8uoRAoZoemLB6n0V1sGIxapW/Ng4c0AEeVjCIYlesvIpkvuBaDSvKm5+8Q=@vger.kernel.org, AJvYcCVFItsZPdwm1zpNdlxnHlptsNH1AGCA3B+hLEnHsiWsyniDllQPQevT8YY25Rgk/UOrvfvMxZS3hIcoM7xj+DvdPO4=@vger.kernel.org, AJvYcCVl0m4VcrMSC2x34ja4lLY3UHI0juhIHS4uB70vK2MYolmCS5lCrqXsBtxJUOgwLIs7yhFoWR7tNrf5qL9G@vger.kernel.org, AJvYcCXzumknr4yPA2/3tD6ywW0GRCve1ETFSvUiPa287F4hGcO86g88zHPB5pvqiJTTxhQebmzEMiXk8x4l@vger.kernel.org
X-Received: by 2002:a05:6102:30c2:10b0:4fb:fbdb:283c with SMTP id
 ada2fe7eead31-4fc1014a3f0mr4991146137.13.1754299704994; Mon, 04 Aug 2025
 02:28:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250522182252.1593159-1-john.madieu.xa@bp.renesas.com> <20250522182252.1593159-4-john.madieu.xa@bp.renesas.com>
In-Reply-To: <20250522182252.1593159-4-john.madieu.xa@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 4 Aug 2025 11:28:13 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW0CTM+d-N0FgP=dKoSTdmRr2Rpg2Rtzj33gDk8qW+FUw@mail.gmail.com>
X-Gm-Features: Ac12FXzM7Sh92j_AJX5q67H2G4qqtIdJKLBAiucGCMpNwDKj6cCTppLwuXCJCtg
Message-ID: <CAMuHMdW0CTM+d-N0FgP=dKoSTdmRr2Rpg2Rtzj33gDk8qW+FUw@mail.gmail.com>
Subject: Re: [PATCH v6 3/5] thermal: renesas: rzg3e: Add thermal driver for
 the Renesas RZ/G3E SoC
To: John Madieu <john.madieu.xa@bp.renesas.com>
Cc: conor+dt@kernel.org, daniel.lezcano@linaro.org, krzk+dt@kernel.org, 
	rafael@kernel.org, biju.das.jz@bp.renesas.com, devicetree@vger.kernel.org, 
	john.madieu@gmail.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, lukasz.luba@arm.com, magnus.damm@gmail.com, 
	robh@kernel.org, rui.zhang@intel.com, sboyd@kernel.org, 
	niklas.soderlund+renesas@ragnatech.se
Content-Type: text/plain; charset="UTF-8"

Hi John,

On Thu, 22 May 2025 at 20:23, John Madieu <john.madieu.xa@bp.renesas.com> wrote:
> The RZ/G3E SoC integrates a Temperature Sensor Unit (TSU) block designed
> to monitor the chip's junction temperature. This sensor is connected to
> channel 1 of the APB port clock/reset and provides temperature measurements.
>
> It also requires calibration values stored in the system controller registers
> for accurate temperature measurement. Add a driver for the Renesas RZ/G3E TSU.
>
> Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>

Thanks for your patch!

The TSUs in RZ/V2H and RZ/V2N seem to be identical to the one in RZ/G3E.
However, RZ/V2H and RZ/V2N have two instances, while RZ/G3 has only one.

> --- /dev/null
> +++ b/drivers/thermal/renesas/rzg3e_thermal.c
> @@ -0,0 +1,443 @@

> +/* SYS Trimming register offsets macro */
> +#define SYS_TSU_TRMVAL(x) (0x330 + (x) * 4)

RZ/V2H and RZ/V2N have a second set of trim values for the second
TSU instance.  So I guess you want to specify the offset in DT instead.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

