Return-Path: <linux-pm+bounces-6646-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C3C8A9644
	for <lists+linux-pm@lfdr.de>; Thu, 18 Apr 2024 11:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F3DCB21628
	for <lists+linux-pm@lfdr.de>; Thu, 18 Apr 2024 09:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9678215ADB1;
	Thu, 18 Apr 2024 09:34:54 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2757C15991E;
	Thu, 18 Apr 2024 09:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713432894; cv=none; b=ktA716Oc2gY3B8x2y1qcfl6ysN3wXmVNPc2XR3ePp5r/4ySg8vgggQYDsnZxdt7INWsWyw/njsRbta6ofHecOlNP170bmMkWH9IGs8Xljg69xsdetBmzi8wgb14IiKtApWHTQXptJXAWWDSR52yLw0IR6yiDz5+T4sHW2db/mIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713432894; c=relaxed/simple;
	bh=nW+RxFXIJffeGeLp2lJlID7nfuAFbwLIQajDYRcl63M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JE4Rs09C+7vHIntIM5JC1Iq2HgT8Bk9nCkgOZhwKuocwbfMW8xvZU5bPNu0xbFPkGmhRjWG5vqP6phnZYiAKyhos0mGlh6ThcRYZXBVU0lndq14FckP+CGjb3CcQxGY15j8T4YEyCpi2ZwIfVpGJROdgBh0cnlArEbJifG+Efxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-de45e5c3c84so679959276.1;
        Thu, 18 Apr 2024 02:34:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713432891; x=1714037691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WKeCkhXcVcL+wVa8viqGB7N6ji7Cb4daNtIF2XPG4H4=;
        b=FA48MAdH7wnST+tq4dLDFZYLcY5POpPLvWf7qyJYN4RYeCCpnEn3JQIQ0xvjaHTVfa
         hDgO+3caGzfoJmRuBLXKLd5sSo7wgWX3t+13UpB2QuVUo4minUcE/X1j/YGp+vfTnHem
         YBf4Ewl/ygyRCG1Gc4ET7qJ9eQFVqVMVFesQGAn4djhQoDYCwQWP6vhd3vh8bS78srSW
         hRWSwE8z6L9dmFiDJnznA2box0VpjC+8WOjxCzfkJ4LowypMG6eHO6GaZjtkPHdOGiTR
         KAFXBLvHYo063I8K14lmnEtlhMjrxJ1mndVel5EU7P0byLtjvvoYKXTDZcr/sP17eAe/
         F7jA==
X-Forwarded-Encrypted: i=1; AJvYcCWqyMQz3zAjk3WRAP2k71kIlZucCWvJVvivN4BzsN03kJwX7DGV8NLaYYbjZxTFfD01DzuXtgnyUyd74SFI46TXwVx7s+nTKCVvGZPf5YwsrL/oRHIC3aDwn+2+HMXnfZn3yRBNbVgQUPTCmQ==
X-Gm-Message-State: AOJu0YzxwfrHeXMgoz+PVrkpA6VpCDmaq7U0feWEIOt1/bd1je6dnEAI
	a6AtR3QXfv3sTmlQF6bNMJ/mRDrLJl8nCXYpmz4c/1+wZ+VAx7spV8U4XX5r13k=
X-Google-Smtp-Source: AGHT+IFxRaFPuY9HLM/8tGNXpNmDu0F3p5RhnPh2S8RnJeRncUZlE4dbBNV5Rm3VOkNFxOZvaCximg==
X-Received: by 2002:a05:6902:510:b0:dcf:3580:8bc3 with SMTP id x16-20020a056902051000b00dcf35808bc3mr1899719ybs.23.1713432891231;
        Thu, 18 Apr 2024 02:34:51 -0700 (PDT)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id ck13-20020a05690218cd00b00de45d421915sm278065ybb.46.2024.04.18.02.34.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 02:34:50 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-617d25b2bc4so6022547b3.2;
        Thu, 18 Apr 2024 02:34:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVpFP7dqWgHq5am4WDBBIFATQDmQ1VMW/F+/AT/7zK6qSODPOswb+JKgOhFhw1C1mgJ51CDkstYQCtymhS+rrxLG1ql03JaO+bV395aWwChqPCh20uFkNcPgov0O4mqWylRnpxJPQ4A8MBeCw==
X-Received: by 2002:a05:690c:62c4:b0:615:9a1:602b with SMTP id
 hn4-20020a05690c62c400b0061509a1602bmr1978617ywb.44.1713432888026; Thu, 18
 Apr 2024 02:34:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327133013.3982199-1-niklas.soderlund+renesas@ragnatech.se> <20240327133013.3982199-3-niklas.soderlund+renesas@ragnatech.se>
In-Reply-To: <20240327133013.3982199-3-niklas.soderlund+renesas@ragnatech.se>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 18 Apr 2024 11:34:36 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUJJXrd0++ep6RBikBCrBqh0oQvVV9_diR=VuDiEVmUzg@mail.gmail.com>
Message-ID: <CAMuHMdUJJXrd0++ep6RBikBCrBqh0oQvVV9_diR=VuDiEVmUzg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] thermal: rcar_gen3: Update temperature
 approximation calculation
To: =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 2:30=E2=80=AFPM Niklas S=C3=B6derlund
<niklas.soderlund+renesas@ragnatech.se> wrote:
> The initial driver used a formula to approximate the temperature and
> register values reversed engineered from an out-of-tree BSP driver. This
> was needed as the datasheet at the time did not contain any information
> on how to do this. Later Gen3 (Rev 2.30) and Gen4 (all) now contains
> this information.
>
> Update the approximation formula to use the datasheet's information
> instead of the reversed-engineered one.
>
> On an idle M3-N without fused calibration values for PTAT and THCODE the
> old formula reports,
>
>     zone0: 52000
>     zone1: 53000
>     zone2: 52500
>
> While the new formula under the same circumstances reports,
>
>     zone0: 52500
>     zone1: 54000
>     zone2: 54000
>
> Signed-off-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.=
se>
> ---
> * Changes since v1
> - Fix spelling in commit message and code comments.
> - Improve calculation per Geert's suggestion of calculating directly in
>   decidegrees. This allowed squashing patch 3/3/ in v1 into patch 2/2 in
>   v2.

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

