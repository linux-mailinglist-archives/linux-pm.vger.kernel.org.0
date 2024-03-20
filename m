Return-Path: <linux-pm+bounces-5149-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 510B28811E1
	for <lists+linux-pm@lfdr.de>; Wed, 20 Mar 2024 13:49:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA26228208D
	for <lists+linux-pm@lfdr.de>; Wed, 20 Mar 2024 12:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94ADC3FE36;
	Wed, 20 Mar 2024 12:49:19 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FF83B2BB;
	Wed, 20 Mar 2024 12:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710938959; cv=none; b=kurQ0SP5503nDlnwtAMi0TpbxzgSAHgVWMO9B1F/U73Rft8YpmAF6OX8p05OiHkfjdIeVLHuH/RDcGv9SypcEL7vWa5n1ujmcqMvspcC6rRnbYvZ0Q4UspvVw/sIdNILKLBKF96uHhYdFae2DvrhA8YyS3j38xoL00mwWzV07oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710938959; c=relaxed/simple;
	bh=uvYcEWvYMj3TI2PkN8xFlNVmV0WEBtfquYJglh4tlr0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kbKFcUlfcPqtcrE2ZcoislDUJ8PH0W7LwmJ4caiKi4rylI5hd5SEJJOnXM1NU8a7FmNpDRqCUysGNpSeL5sX8lRiN8LMmRnGOlGKIkW6lnGe6nNqus/7+xfg0nbODTISF4f9/+3u+HNTttnl3lWE+RnqGxfjGr3VLzTDifbPfJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dd02fb9a31cso5745614276.3;
        Wed, 20 Mar 2024 05:49:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710938956; x=1711543756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X/WMxDB+H3wROMtm5v3LdDKSwK7r3EbtT/nMFFe98oY=;
        b=p+9sqqvFeDHEzb6fTTc62H2F4P3lj7/J0bsP7WPeYd64bGDxBlqTE80gGTbEKEqdgB
         BkW3pZWPCJzOGDE4IjnJGGudw7q8ML34Nhn6d7XBC6c0IRKpN4BCf1sWa2lQ4J/UIVhb
         2YsO1lGzGVtpgtZJTthXgWL2ZNCeiAGZOGvIl5bGmI/sB6+epjBTZDK8u4z3DVMaWR8F
         i2S29CbhcvffLRUw0nMzi4O7rnHa6OVUXMmdEEpQpn6oZwqJG3NUzNkikJvtis/n4rOV
         afhWh5AMmEu4A4haB3UcIgB4MzsdfLHIdq3GZIHsLcaHVXVoVU26P1hGtrWHZx0huWvK
         c9qg==
X-Forwarded-Encrypted: i=1; AJvYcCVATvGfEMZqfN7M2QGaZDUh6hT8VOMCjCWoYFueJLReSn6rurLkpMEsdxMkGZJlcMcSXqa/pwq95FL2kgjLALx9mdYyhWFQQEn+ZdtnMkuGZXCKvoXRipzk6QfjrG+3O/EFGDgs2ZJOuEYEkQ==
X-Gm-Message-State: AOJu0Yxw16abOy0AZK3kfz1fCnnn/GdjT2NnUvulFgO7ApV9Xi3EQ0r+
	UHRn/aye25sxfB1sJuVdLF+mhvacXkIZKwmDv9S1dK2VPchcNj9XKRvkDDWJBFY=
X-Google-Smtp-Source: AGHT+IEN06fmWarzOj7JQ9eTbZ9dkmGCZFxx2DwShXf2ahmVFztjwXTXbmwG+quJMnPMMGq5O/l0wQ==
X-Received: by 2002:a25:c50b:0:b0:dc7:1a9a:11da with SMTP id v11-20020a25c50b000000b00dc71a9a11damr14261869ybe.38.1710938955974;
        Wed, 20 Mar 2024 05:49:15 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id u13-20020a252e0d000000b00dbf52d2844bsm2508060ybu.11.2024.03.20.05.49.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 05:49:15 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dcbf82cdf05so5728147276.2;
        Wed, 20 Mar 2024 05:49:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWW7z6aUj137hSjCGfpRwthUaax+keI+y8uc+b+SwbhhKcj66RfLAZZEjMY6006sTP2+wrTQeVW8F8jle4ZiOKn1hHdCreplSotfXM5/gk9cP7R5dEtPRQGQgnQttLbM0DXHfEpDtbAbsSnjw==
X-Received: by 2002:a05:6902:4cb:b0:dcc:d694:b4a6 with SMTP id
 v11-20020a05690204cb00b00dccd694b4a6mr7893097ybs.15.1710938955364; Wed, 20
 Mar 2024 05:49:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307110216.2962918-1-niklas.soderlund+renesas@ragnatech.se> <20240307110216.2962918-2-niklas.soderlund+renesas@ragnatech.se>
In-Reply-To: <20240307110216.2962918-2-niklas.soderlund+renesas@ragnatech.se>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 20 Mar 2024 13:49:03 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWVfjYzs2vez6SiuDpY0c8HWfkZATxScA6kd8b9Mfm3BA@mail.gmail.com>
Message-ID: <CAMuHMdWVfjYzs2vez6SiuDpY0c8HWfkZATxScA6kd8b9Mfm3BA@mail.gmail.com>
Subject: Re: [PATCH 1/3] thermal: rcar_gen3: Move Tj_T storage to shared
 private data
To: =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org, 
	Geert Uytterhoeven <geert+renesas@glider.be>, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 7, 2024 at 12:03=E2=80=AFPM Niklas S=C3=B6derlund
<niklas.soderlund+renesas@ragnatech.se> wrote:
> The calculated Tj_T constant is calculated from the PTAT data either
> read from the first TSC zone on the device if calibration data is fused,
> or from fallback values in the driver itself. The value calculated is
> shared among all TSC zones.
>
> Move the Tj_T constant to the shared private data structure instead of
> duplicating it in each TSC private data. This requires adding a pointer
> to the shared data to the TSC private data structure. This back pointer
> make it easier to curter rework the temperature conversion logic.

further?

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

