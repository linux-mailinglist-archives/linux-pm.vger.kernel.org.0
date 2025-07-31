Return-Path: <linux-pm+bounces-31653-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC24B16B2E
	for <lists+linux-pm@lfdr.de>; Thu, 31 Jul 2025 06:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D9FC5453FD
	for <lists+linux-pm@lfdr.de>; Thu, 31 Jul 2025 04:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F84217B421;
	Thu, 31 Jul 2025 04:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A2Bjq/Wy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A582E539A
	for <linux-pm@vger.kernel.org>; Thu, 31 Jul 2025 04:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753936294; cv=none; b=mQMx42pbIfJ1OCGFafRzeaJLj3K9offTI/x9je1W1MHyPRZfF34kk6rRvu7VI4ndr+4ePmvdH2eogbrQmIPmzDbnnPCzTt1wPmz+j22yhvNWykZJIOeCjGt9gYneakX4chzcVYJPsnj2/6y8uzmsOo2WSm5kB83EsHr/J+UK5Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753936294; c=relaxed/simple;
	bh=e5Pt2D+lJivBS28/plTuvgaI+t3rSje6fmXy3hZeQKs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AFZSh556e08E0c+vWstg8zoiOyWhrHnVk5I0DAd1gx+DGzwbR+ci9SdYdspHvyli4viocjLlNscZ5GuqTStOEObwECwKznXE2CIY6kDCU4j8AR6PlaG62lP1CI46PsO252frmdvwQcjCRlQOfTxC9sxxmO1uaEXMGYxVCyK8VFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=A2Bjq/Wy; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-7074bad0523so5529136d6.3
        for <linux-pm@vger.kernel.org>; Wed, 30 Jul 2025 21:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753936291; x=1754541091; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e5Pt2D+lJivBS28/plTuvgaI+t3rSje6fmXy3hZeQKs=;
        b=A2Bjq/WyAtH0cResg6b3gfTGtLxHN2bB0UFBjhtTbgSGJalfes7N93rQBBdmciBJ6X
         bz0Nc//8dx8uQqd9me8GGPH9UbJ4C+V/HjGS5hCQ4B3AoUjYljyOsv/3LyZ5pKdyZ5eg
         w4ktTUDpij6b+HWbg6oAoABSq+JJMEh+RVEwY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753936291; x=1754541091;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e5Pt2D+lJivBS28/plTuvgaI+t3rSje6fmXy3hZeQKs=;
        b=djo0mS2TXukYPsg6Zzk7MaNyuyJrlGrGm/1GnQ2GyFWTrfYAbCcX8mxjK3Epn0v1Xj
         3PGu83/tAaPVdqJEW1/C5Y8hSw6NcySnNdWzsN9Lryxxs30ci7vbONWLrgOjkWbw7pZ9
         drbRUliONR8n9pgpQQ7gwL6gjepODJkXmR/YwzwZjanqnb5ERYFEGrc3L3k8Xy+pHhqG
         HXwMCENGlkilOk6OJhlDV3ABD1dHUHIiHQcfmnpA3aL1sVAQz5id0qwvG3OOD/bLkoDQ
         wZ+Rw/2ZVHOvllq0u4jXM+Moonil6qmsIv2OKmbZnQSpJ0sPQn+q2xVrEgSBEp95ukqx
         MArw==
X-Forwarded-Encrypted: i=1; AJvYcCXyG8qwCkdyS5hHnkOIHbUgKOFhCR2ug4LQop5/4Ii79+tXlA8Ha/e5qcaXmQ4p/fU0RlrhwcQvqg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwH+e6ZlXpWpeGRe6Omjv58XpYFttRVM7VIgCmWu3qhv17br3C7
	MCBeLv4gd9vGt96ICyNaYJdFbiif2VHOJdqTna6zNYSzVMNJXdWaGJ8J/NmwNrpzopUmff7mxEQ
	HgkU=
X-Gm-Gg: ASbGnctS0o31M/FHHvuBzT/PrVZ7iMMsABOmBRdkQjQXtkZm2z7rDPjMm/aZy6H2SsW
	AW9SBPFCmjaMv83hr9RMXI4HsSPGf/IB2hGCK4uHAfOjdrc7DRPwm3XQF2EnGbbi/T3TD5fvk7l
	R6s3W026Jarp3wb1+DYi9B/9SenxTuSXqGQO723/RK8arfDy1dV3EwQYMi5jvlDe6r7+8+pBMJH
	m1PjX56VoUo/cyUyDSnSEF8P0xpiVNsebLgUzHtMapQPmScRMxrG2CqN7GxRCYnOvUJQAW2r55v
	QwrP5LCazFHRKPRLJZo5KpshgfvDr8/GN5yz05i9LrNK5xT/kHEIpljOy3Xv2JDz79DNSrSsK3z
	yjhd0SpnKLzalTew9RYUqqJVWDbRz/vLIGg27QKYlv1BVYVRmvXSZCm7marT2Th5ZcCad
X-Google-Smtp-Source: AGHT+IHE7smwf24q+/ftn0uPK3ExwyqJkyj2EtOY6RqHlGCu+tNwQUtRCAVfrZ+YqxkFShNANGegDQ==
X-Received: by 2002:a05:6214:b6b:b0:704:a0cd:f597 with SMTP id 6a1803df08f44-70766e6de4fmr103838046d6.21.1753936290736;
        Wed, 30 Jul 2025 21:31:30 -0700 (PDT)
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com. [209.85.219.44])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077ca474a8sm2696636d6.37.2025.07.30.21.31.30
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 21:31:30 -0700 (PDT)
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-7074bad0523so5529036d6.3
        for <linux-pm@vger.kernel.org>; Wed, 30 Jul 2025 21:31:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVu0QRqkrXmroVtSHaDV+MdNACNh/+waD9RNbyw34AOz73OUyY7iDMOlhIoGADnGZA0+yYpg6JcNA==@vger.kernel.org
X-Received: by 2002:a05:6102:3c84:b0:4e2:ecd8:a27 with SMTP id
 ada2fe7eead31-4fbe7efb067mr3218583137.4.1753935982767; Wed, 30 Jul 2025
 21:26:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730152128.311109-1-laura.nao@collabora.com> <20250730152128.311109-7-laura.nao@collabora.com>
In-Reply-To: <20250730152128.311109-7-laura.nao@collabora.com>
From: Fei Shao <fshao@chromium.org>
Date: Thu, 31 Jul 2025 12:25:46 +0800
X-Gmail-Original-Message-ID: <CAC=S1njcFhyY6+dT2MHU02ZsLDq+k_vAVv==bWuoGt3KA18PHg@mail.gmail.com>
X-Gm-Features: Ac12FXzpMbFxjUu23GFYxUNlitLi6oNpjwDf0fTbw3kLbAuwV_H195C3EX5jG7A
Message-ID: <CAC=S1njcFhyY6+dT2MHU02ZsLDq+k_vAVv==bWuoGt3KA18PHg@mail.gmail.com>
Subject: Re: [PATCH v2 6/9] thermal/drivers/mediatek/lvts: Add support for ATP mode
To: Laura Nao <laura.nao@collabora.com>
Cc: srini@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	rafael@kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com, 
	lukasz.luba@arm.com, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, andrew-ct.chen@mediatek.com, 
	kernel@collabora.com, nfraprado@collabora.com, arnd@arndb.de, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, u.kleine-koenig@baylibre.com, 
	linux-arm-kernel@lists.infradead.org, wenst@chromium.org, 
	linux-mediatek@lists.infradead.org, bchihi@baylibre.com, 
	colin.i.king@gmail.com, lala.lin@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 30, 2025 at 11:40=E2=80=AFPM Laura Nao <laura.nao@collabora.com=
> wrote:
>
> MT8196/MT6991 uses ATP (Abnormal Temperature Prevention) mode to detect
> abnormal temperature conditions, which involves reading temperature data
> from a dedicated set of registers separate from the ones used for
> immediate and filtered modes.
>
> Add support for ATP mode and its relative registers to ensure accurate
> temperature readings and proper thermal management on MT8196/MT6991
> devices.
>
> While at it, convert mode defines to enum.
>
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> Signed-off-by: Laura Nao <laura.nao@collabora.com>

It's not visible in this patch, but a heads-up that I see
lvts_ctrl_start() also depends on whether lvts is in immediate mode. I
wonder if anything is needed there for ATP mode e.g. a new
sensor_atp_bitmap.
Feel free to ignore if this is a false alarm.

Regards,
Fei

