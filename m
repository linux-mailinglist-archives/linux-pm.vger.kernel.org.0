Return-Path: <linux-pm+bounces-16353-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B71269AE1FC
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 12:03:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E647E1C203F4
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 10:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA171B85CC;
	Thu, 24 Oct 2024 10:03:27 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A26014B088;
	Thu, 24 Oct 2024 10:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729764207; cv=none; b=lYX1Jp3aY+zc8/hckbxG1e6drhH/1K8yWV32hLpTSwcjPyZdgkJXrobJwfLW9heciD8BnZnxycClMxPAFBGusGazw24T/YcilFKEUDO+2uAIGTVXfUz4wEiCO8QNQ+kQYiMaExqfdeA9eMCIhMnJBQwnIOoBw9rhXzTdrP02qeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729764207; c=relaxed/simple;
	bh=JfA7s9h1r7dOP65fYEcmf+ngJd2T42Ah1uFcGYp+84E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ROTW8JaDVgN2v+VEQ3+22iENdt1FY4cmB6qHdHExJIfisUZies1do8fUB07eGrsgKBfVZENvNVOr6nfEw81bStBWjTIUbPAY01UhhPcpX+qmOz+iwDp4D0njC2CAvnumviMxPruLuA8x0NQo49SU35fjs/Glp5/lwTzLVeL+1n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6e35bf59cf6so18198887b3.0;
        Thu, 24 Oct 2024 03:03:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729764204; x=1730369004;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mk6HHFS0Ev4Q9EifU/2bP+TIFQ/sMDH6tFh0VAy4Fq8=;
        b=Ip4MAKMccEqQn1xB7fRz6gp0XPGNQsyt1XetyQ4QaAanA+A5cq8pQwrOGpLiDKUAyR
         08PaiP02BcJ2ooqeCW/H5ZEkDAzpBmgJUsLnVvUx5OZZQiWp0EaoE9TFsxaIeqAQPSgl
         B9r+OMkq2AR3VM8gQXi0sB8X6IVr1S60fNBn9W2HYVozJiTVOFgVk0uALLj4Cm7IHgKQ
         tapSSMuxWv4oqOGqcgpc38p3bt/uv8anwbH/D1qMEubxgd9Mqn6C8rvXtMgCd3Pf9mMF
         rutq6HuZhRDuOO4uNRwxduRAqVq8vjJaEXsK1p2IqQg/eWszeIk9lIqRtzfIm8WIhF7N
         UfLQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1NqWECeXjqI+KCmZqRA3FbW4hQcgmEXniwRlyOUGhcavSyMkYgb0VQiDm7HqqsLsn+8nz+lIhfPAOnVvr@vger.kernel.org, AJvYcCVDfNKlm/1WFyHnV+bJ4cHDFcg+BgW1vSWO5Rd0DKgDr0h8Ty4eYYI6IYy/nTpxUs3CQghKyUn7dklIOtCXNsk=@vger.kernel.org, AJvYcCVN03qTXfVTIOMRlQ8LfrTnbOnv3aiMs4TXOkHmPLXlABYQpR1D2MIGOeA3gYYbFpWmWpg/4Q32MvY=@vger.kernel.org, AJvYcCW+8BR+mz6Xt14vWxVgSSz64DpaIKb4wfBhmYOPSAdNVdOTa5LwY03gSQH2r/Fx7kutTHo1gEiVF/g=@vger.kernel.org, AJvYcCXWte8qE4Im0oIHpnP2nm+8BagxXDsNvGfdG8zorQsNP9iNz80ftMNnvJWEsr200+nWTj9uO3I0cML3IDMe+a52KSM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbjTlB/crHv+4Wp8ZtBYiqpq0jafhHGkyzFWiEOH4ZDURFXspA
	V1gEpOY+AdXYGMAboY9XtzALGQ7Zct0xFh7Rnz86tCA7EzIqP5kovo5RpRcO
X-Google-Smtp-Source: AGHT+IGWNcZIexPY13axSOs0+fYFSXf/XoNU6AJm02Gm7QiYsrHaQr3zJ79PH/lbKTJsl2EJAxPlDw==
X-Received: by 2002:a05:690c:f8a:b0:6e2:5a6f:d90b with SMTP id 00721157ae682-6e84a7e69dfmr11801817b3.2.1729764203765;
        Thu, 24 Oct 2024 03:03:23 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e7e06fe05esm10527557b3.12.2024.10.24.03.03.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2024 03:03:23 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e29218d34f8so570844276.1;
        Thu, 24 Oct 2024 03:03:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU+9XiE5d8QIALHoAXQACw3LvqN91bKcRvohld0rBdO3SIj8VAPZPG9Q/kQU/HPGoJI6KLEzT49DCC3Fv32hsOl1+w=@vger.kernel.org, AJvYcCU6/WmFdTLvVPuJnJK32dYcbvUW01XjPxzk1yrGKC1FWdUEBGM4c/yGgUwW6vPwLDYOdfITX/I54MqtBwEZ@vger.kernel.org, AJvYcCUSvZdh7a2D8MvTw8S4YD9KLa4TXiv/kzmVI/v8DoCfoHkgWwodR1dKqK9i1slOSRlGbVZ0yXNenpI=@vger.kernel.org, AJvYcCUTqjVP+9X0+zzin/E87gQkVjbo+lqBAmn8SXTxfCA2hwSc8BVhO/iGpzbruExOz8lfFf0Qa8Lj9ls=@vger.kernel.org, AJvYcCVfRydwvONlc29jl28ONCYmrdVaEtrj7QgDj7DO74xt3j/CQ/x3TpDshVIr8uAtKB0kd9dTnqq2eNhMOfKlWyc=@vger.kernel.org
X-Received: by 2002:a05:690c:385:b0:6bf:1ca2:f6ce with SMTP id
 00721157ae682-6e84df3c053mr11552027b3.11.1729764203133; Thu, 24 Oct 2024
 03:03:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241015164732.4085249-1-claudiu.beznea.uj@bp.renesas.com> <20241015164732.4085249-3-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20241015164732.4085249-3-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 24 Oct 2024 12:03:11 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV=qcHBZdK26n7+xNNAH9ixrQMwixYtCywkT+D6ZJpxnQ@mail.gmail.com>
Message-ID: <CAMuHMdV=qcHBZdK26n7+xNNAH9ixrQMwixYtCywkT+D6ZJpxnQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] clk: renesas: rzg2l-cpg: Use GENPD_FLAG_* flags
 instead of local ones
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: mturquette@baylibre.com, sboyd@kernel.org, wim@linux-watchdog.org, 
	linux@roeck-us.net, ulf.hansson@linaro.org, linux-renesas-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-watchdog@vger.kernel.org, linux-pm@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 6:48=E2=80=AFPM Claudiu <claudiu.beznea@tuxon.dev> =
wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> For watchdog PM domain it is necessary to provide GENPD_FLAG_IRQ_SAFE fla=
g
> to be able to power on the watchdog PM domain from atomic context. For
> this, adjust the current infrastructure to be able to provide GENPD_FLAG_=
*
> for individual PM domains.
>
> With this, remove the always_on flag from rzg2l_cpg_add_pm_domains() as
> it is not necessary anymore.
>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>
> Changes in v4:
> - rebased on latest next
> - collected tags

Thanks, will queue in renesas-clk for v6.13.

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

