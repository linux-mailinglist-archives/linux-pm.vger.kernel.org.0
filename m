Return-Path: <linux-pm+bounces-5805-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62397895199
	for <lists+linux-pm@lfdr.de>; Tue,  2 Apr 2024 13:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 944BA1C22B1E
	for <lists+linux-pm@lfdr.de>; Tue,  2 Apr 2024 11:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9210C65BBB;
	Tue,  2 Apr 2024 11:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xtz5tf/Q"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4100C604BB
	for <linux-pm@vger.kernel.org>; Tue,  2 Apr 2024 11:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712056630; cv=none; b=su7G4sTTt6NFglqI2cF2Ew9nvMsmUtcQw7vHmZuV8OcDsc/cseGHjWwRSlRYSG77j3F5LUPK/uQmjC1gDGWsnmRNlx47AnAsuibFxi1CPrd/PI+UeCeDMJ2F/gyWm7fZRm1ndD0FtrgqDDSzVnXDy2QZJakO2dEgzo5gbKKTs28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712056630; c=relaxed/simple;
	bh=xYEx1wB0KeFh5dfJ6HSa7rT6aZpOvWbEWZUcFmvpOYM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B/jRalVmDuGNrBFIT9bue4ZMiE1lD22eLHoUnt92aU9t5h//20P1yOpIhBp5Y1eZ6cTiQxZcHJLZ2sKirzAJB5qPrst2qW1Ojoc7ctQj4pOr2HG55O0xCjmB8qC1vpnGQIiaWK2/PwQrXlqtG1S6h3yrwlKdvHKjWZ6UYqlxDpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xtz5tf/Q; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dcc73148611so5147861276.3
        for <linux-pm@vger.kernel.org>; Tue, 02 Apr 2024 04:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712056627; x=1712661427; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mFAn5q7CQFxXq7JaY+/0V77lsWhz1Tz0icfhEeQZiIA=;
        b=xtz5tf/QsdMLoKnoqx6rUztU2p56/IxKm4kRKm+X4rVcFkrg6e4owC085eK/kYL9kn
         1tjX/ujIHU2cSIoDXA+qTG4MG/rMfvW26UTiwox3tRNqJOZ89Rk+y3ptLICVRhzHPQ6x
         jkQbPlQehDn2Y+KS9/2U1QRPC2pEjlrfZbyjnzhgecb4F638Q1Nyz44id0neiJPxZLI6
         qk/2LfRlq7Me3H7TwhUfQHDas1GKcuIiVc0CGuTn2F6ZLc2h41wtu7/tw81J7mVFKcap
         3mAT8KO0GKbRQ1WL0Wyuc+RV03yzIC5f0jZ3AuBZT/oyofHnXGfIP5L9Or4GyuZLT078
         Xqvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712056627; x=1712661427;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mFAn5q7CQFxXq7JaY+/0V77lsWhz1Tz0icfhEeQZiIA=;
        b=JeuuWW5cNHZ2XPn4n2D1lubZ+9ejXn099O/IN5EP7yD3f0yYcHXwjn4x7/su03f9ip
         uV/U3glaZbgB3a4ypJnTLeVYGF5owAjir0LniGImG0L6+Xuras32FcrfCv3jQSQINQPX
         /0TpS5tetAyp6/0EfHx7qqphjBaWKhn+gtdHpVmxpaV5zkzFuY6bVTxYFLoSqAjXJ6eX
         8dtRlXc40wd+xuq3uDu/nIhYos2tdanQgWaqWpIsz3RlXlTm9t3PwvIfUNYiOpPRFqxr
         VB2yf0Iv0PjQJ01+Bzvy7sR9/CknxEe+jX+gpKDV7zI+E62DE0u1TN8WYiNb1LHcqW8Z
         jT+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUrRG5bDVxVaM/BJBxdVy8ej934q5z0Pg7g1cqD1w6moO8WL5C92ZnVebQ3WNbizQKlFFoDeGs9LgtPDeNk7xm3VeFj3SLYzp4=
X-Gm-Message-State: AOJu0YwNCtRjY/57FuNjh6Ue+bYA/sJDAkz1xfYWkDgJy2aPkCxokdKM
	/Vzvj2bWE8rDEFKO3d46f3fECAsCmEBXRi2N3RvfxIHP5BD/bYpu5JsrKUd90hdXukOs4NOGbYF
	wvp8qy7IfTTMyp8AIM1PJ5aI/OYpZNndsYQAmEw==
X-Google-Smtp-Source: AGHT+IEigHxfdu3Sh5IlyKpDafnA1zAw4DSQNtZfWejv/aZ9zNxq090wRE2n00r1tIubWICmJpip1//6zCXSEBerIZY=
X-Received: by 2002:a25:640c:0:b0:dc6:cbb9:e with SMTP id y12-20020a25640c000000b00dc6cbb9000emr10783156ybb.41.1712056627317;
 Tue, 02 Apr 2024 04:17:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402103406.3638821-1-quic_varada@quicinc.com>
 <20240402103406.3638821-4-quic_varada@quicinc.com> <CAA8EJpphk_kqzBE7cKb73ipdpTi29t9ZSOOdSfq7pAGSs5NKeg@mail.gmail.com>
 <CAA8EJpo=TMhu+Te+JE0cQzmjLOTDPi-Vv-h5Bch0Wfr_7iVi2w@mail.gmail.com> <ZgvlrbvvPNA6HRiL@hu-varada-blr.qualcomm.com>
In-Reply-To: <ZgvlrbvvPNA6HRiL@hu-varada-blr.qualcomm.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 2 Apr 2024 14:16:56 +0300
Message-ID: <CAA8EJpp2dgy0DcLoUuo6gz-8ee0RRwJ_mvCLGDbdvF-gVhREFg@mail.gmail.com>
Subject: Re: [PATCH v6 3/6] interconnect: icc-clk: Add devm_icc_clk_register
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: andersson@kernel.org, konrad.dybcio@linaro.org, mturquette@baylibre.com, 
	sboyd@kernel.org, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	conor+dt@kernel.org, djakov@kernel.org, quic_anusha@quicinc.com, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Apr 2024 at 14:02, Varadarajan Narayanan
<quic_varada@quicinc.com> wrote:
>
> On Tue, Apr 02, 2024 at 01:48:08PM +0300, Dmitry Baryshkov wrote:
> > On Tue, 2 Apr 2024 at 13:40, Dmitry Baryshkov
> > <dmitry.baryshkov@linaro.org> wrote:
> > >
> > > On Tue, 2 Apr 2024 at 13:34, Varadarajan Narayanan
> > > <quic_varada@quicinc.com> wrote:
> > > >
> > > > Wrap icc_clk_register to create devm_icc_clk_register to be
> > > > able to release the resources properly.
> > > >
> > > > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > > > ---
> > > > v5: Introduced devm_icc_clk_register
> > > > ---
> > > >  drivers/interconnect/icc-clk.c   | 29 +++++++++++++++++++++++++++++
> > > >  include/linux/interconnect-clk.h |  4 ++++
> > > >  2 files changed, 33 insertions(+)
> > >
> > > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> >
> > Wait. Actually,
> >
> > Unreviewed-by: me
> >
> > Please return int from devm_icc_clk_register instead of returning the pointer.
>
> Wouldn't returning int break the general assumption that
> devm_foo(), returns the same type as foo(). For example
> devm_clk_hw_get_clk and clk_hw_get_clk return struct clk *?

Not always. The only reason to return icc_provider was to make it
possible to destroy it. With devres-managed function you don't have to
do anything.


-- 
With best wishes
Dmitry

