Return-Path: <linux-pm+bounces-5800-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CEE88950A8
	for <lists+linux-pm@lfdr.de>; Tue,  2 Apr 2024 12:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DD961C21CDB
	for <lists+linux-pm@lfdr.de>; Tue,  2 Apr 2024 10:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990435F873;
	Tue,  2 Apr 2024 10:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u4tCu6Gh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36975F466
	for <linux-pm@vger.kernel.org>; Tue,  2 Apr 2024 10:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712054902; cv=none; b=rsjmHvmeQ/UW7vl72GQSYZNtC8UEoQo/uRQ8oJC59jGRuU7kdpYxULZ6q1/qy2OxfkgIxkqzOHTQHKEQq5swmzGtGXjL2Ivevb8LWzsxRM7vUclINhMo3brxHOoq3IhvBzhHNF1NNK+q8mHz5INEMaVOv59t1Z+nJ8LjDPTOgVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712054902; c=relaxed/simple;
	bh=qqkptkwBB5jmETqLjS63zlxdb+z5eD6/k+FZmoOcCP0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YKtCk++RRf7I+WTFOOrSbPRt6SCkbA7Ls64/vIoQ01LCceYL/PNORbmLEaT8Qn7vBYhq+gA9xkXYBk6DJjAL1cK5F4ZJLv6fSsstYBIBEjbsTommQtfGa4bLaUIO0dYM77iFc4s5+Xj9ZdU3m1Q3CRxljjo9evITPZ8me3VlPnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=u4tCu6Gh; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dc6d9a8815fso4837454276.3
        for <linux-pm@vger.kernel.org>; Tue, 02 Apr 2024 03:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712054900; x=1712659700; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+xPQyCvLo53dq7pKGpQQof9V6YZJuIofT5TTwfg8858=;
        b=u4tCu6GhOY38sRAviEV/tKlL3V3tT2l3fvAV59tynf3dKBVNSfO/RXTM5iS23pXu+7
         0qvMqTLkTyQqwMB0XwY4ciDrt21N1kbM3QG6YvCZtCoYUGcUiffQDKuSH56LkBwHUhES
         hOJVE4POJfo4e+7Q02ODEDCgG+/dky/Z1jpgk3nWT99mwem8H4e/cyAPXocjN0ZyW0sG
         w13myAXscyDancBhQqgM4ply80ZcqpNRp8MWGPTKaRGQfIPjRRBObK7u5Op3wtSAukId
         c/hAdLOzFkcrrQmRwa+TtxBMj4R5WToq8vDsSc5h3taODFEQh29ntK/JvlLU7IbLeikt
         sakg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712054900; x=1712659700;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+xPQyCvLo53dq7pKGpQQof9V6YZJuIofT5TTwfg8858=;
        b=CyQGbWv73I0bUHTvqnjuR9grkvZw7srSJCzZeZaVGl8ROcFyXqjOZsm23KxZxgwOIq
         +sh8oc7zC4dnAImH4pFwt+m7VCMcGGSxim2Te10O8jQ5GewZYHpp8GlypMGkZg/okCVZ
         ehIRGAW7hfJZcJRTA+yQyVVD7CZbqU2J+SW/LgD//78vgKuQiQeiSUPVITq2E9rnY0aG
         KbOxw3voEVm7MNUGnC2DBbNl7ajSaBbfN59ZGypOqTJAStQAxHpb7H9lEK8wij3imqDk
         TuVU4eMvTAhZ0DJAjcvP/88C0Cz3abE0muDkOSdOkMFyPf6erOp6mYWaz43NEisKGOW3
         02uQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbEgGEJI3fR3KA9PgXpUR5pWog+uIRbNJzNQJeAyBMKdRhXgZbg7bug0krN2sVFEp2z/7zxuVmUnnQYt0RRCrhSvtBTuEaNNA=
X-Gm-Message-State: AOJu0Yzfk4XyHJkgBivLXqhSMtbcXOhcRnKKupJ/zs9xAVH1DPqIyhgg
	TQkQL7k/OeMP0FiZc5P7gVyuDJx3c5vKC6vnKhzv72xr0ipsKl1+j5OAd4ogeSfZJh9gaKyqWcW
	ZyhrhatcRWsyB4VppiDS1OQqvkFeWA+EMs5yY6A==
X-Google-Smtp-Source: AGHT+IEdThI7DXVCE+YtsqVQ5FfgA2JdRwa/suM7w9m6RjmrZhMB+jlS68lFUGN2ID6qPpnpew/nE9vA5K+Hs04awQo=
X-Received: by 2002:a25:9a05:0:b0:dcc:9e88:b15 with SMTP id
 x5-20020a259a05000000b00dcc9e880b15mr10209955ybn.41.1712054899681; Tue, 02
 Apr 2024 03:48:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402103406.3638821-1-quic_varada@quicinc.com>
 <20240402103406.3638821-4-quic_varada@quicinc.com> <CAA8EJpphk_kqzBE7cKb73ipdpTi29t9ZSOOdSfq7pAGSs5NKeg@mail.gmail.com>
In-Reply-To: <CAA8EJpphk_kqzBE7cKb73ipdpTi29t9ZSOOdSfq7pAGSs5NKeg@mail.gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 2 Apr 2024 13:48:08 +0300
Message-ID: <CAA8EJpo=TMhu+Te+JE0cQzmjLOTDPi-Vv-h5Bch0Wfr_7iVi2w@mail.gmail.com>
Subject: Re: [PATCH v6 3/6] interconnect: icc-clk: Add devm_icc_clk_register
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: andersson@kernel.org, konrad.dybcio@linaro.org, mturquette@baylibre.com, 
	sboyd@kernel.org, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	conor+dt@kernel.org, djakov@kernel.org, quic_anusha@quicinc.com, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Apr 2024 at 13:40, Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Tue, 2 Apr 2024 at 13:34, Varadarajan Narayanan
> <quic_varada@quicinc.com> wrote:
> >
> > Wrap icc_clk_register to create devm_icc_clk_register to be
> > able to release the resources properly.
> >
> > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > ---
> > v5: Introduced devm_icc_clk_register
> > ---
> >  drivers/interconnect/icc-clk.c   | 29 +++++++++++++++++++++++++++++
> >  include/linux/interconnect-clk.h |  4 ++++
> >  2 files changed, 33 insertions(+)
>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Wait. Actually,

Unreviewed-by: me

Please return int from devm_icc_clk_register instead of returning the pointer.

-- 
With best wishes
Dmitry

