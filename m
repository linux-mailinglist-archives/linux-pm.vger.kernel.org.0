Return-Path: <linux-pm+bounces-16874-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A74219B937B
	for <lists+linux-pm@lfdr.de>; Fri,  1 Nov 2024 15:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 531EA1F24E6A
	for <lists+linux-pm@lfdr.de>; Fri,  1 Nov 2024 14:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA311A7273;
	Fri,  1 Nov 2024 14:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AsGAiBG8"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408EB49620;
	Fri,  1 Nov 2024 14:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730472090; cv=none; b=oz7qxuE8uejLwugdHyH693nV3QdvkNwmvQcsTMSECSm65HcX7qblLyUwE0mYVo0pQbrV7eiB/zugtNxzKB3pvdsiBL+b1diBaXTTLltnmPB6+SQgqFHwRBF+2602FeETTSQNEXCoKKlw8DdEId+sApKsyk/IgHAmQ5SmeBXTYkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730472090; c=relaxed/simple;
	bh=AmkGd1YtaRBsWyY/PhDUar+x9+0lYLo6JDmoiR2N3Xo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ShLDPK+HDPfMsIZVqNZP8u/uoGky3+q3nBxx+eHKbBKhhgwdS2htk2mJDZ7iB1SE+orQEkrKCL9pF3mCZ5FR4Hvg6F8DTP1x3ZWDq09HyfPxD8yK6nPvunZgICMQlqJd1BMC7Uo5MAbqis+3uqe25cqegsgAX8P9yGMKyzFLyC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AsGAiBG8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAB98C4CED3;
	Fri,  1 Nov 2024 14:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730472089;
	bh=AmkGd1YtaRBsWyY/PhDUar+x9+0lYLo6JDmoiR2N3Xo=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=AsGAiBG8azxgn6tnEmoy7OPWNv9wH7dvvBmKRqwRlDS6El8ZkLSF7hStvzpydtYqK
	 Pg5U2v/XQgBSQ9woSXb4HgoYm5rAAh3FcyBnfnMi85QP47sBxwDT2xqqmKmfFiyGfN
	 1Y0iE0agDo9xuE99kEd7u3NspQZ/oVY6Zia0FXOGbLYkixeY1P/lcyOr+xrssHoV/r
	 AGq3E/3JlxyV0DK5mzg9n7rBazFqkJeBjZMS16hZitnq+FWPMT73pZF00gzXz8tDfG
	 QM4oRnDSh4Lmo3J70NF8YzPohTt7sLCMKiigBtuVG5l9PzQ81Ej6QH5Z/FnikcwwEk
	 ISMwhKfON1zXA==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2fb57f97d75so20958351fa.2;
        Fri, 01 Nov 2024 07:41:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUqtGGKYOwkRYkaz5539MnLQ7ijt48cYWMFMuoFg7UwpLlDdIbFpUfxWQJVOCO/ZoUhPJccRssnGFLHH1Zv@vger.kernel.org, AJvYcCV9RcMptKkHzeuF09QQN+M2vEgHDiZTv5GwbKMCu7Sxhy9XHTNEzs/7C62c0aNy88DacPoM4ukPBoKs@vger.kernel.org, AJvYcCXhdWrkaycAIWzl5srYZSLuUIU79116ZRiMQgIgO8jvrmxRbp45Xu5g2twypRUvhXeUJr1NQ/1F1Qo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxwpn1HTfYEOzBSCKSEX5ie4rUUG1MSygnkDncezYFKWl7BvSQR
	DSpEwnefaXV/2U0VtE0pILZmLb0VU0+K2YoWw1fXfXJlNyDAt7TRbllIzfk7f7K/e0uc8OBZi8k
	7Tu9Kb6WC3T8AQOQ9nBQjj1k4UsA=
X-Google-Smtp-Source: AGHT+IHc9jUui8eLzC4XhWJRVn+/2ELdbimwXFbBNramNpQcny1mdNUt1lZXT7vOKkYTUPt/Ls2DNpMd04J+Sb8odzA=
X-Received: by 2002:a05:651c:19ab:b0:2fb:8774:4412 with SMTP id
 38308e7fff4ca-2fcbdfc9303mr104550731fa.24.1730472088063; Fri, 01 Nov 2024
 07:41:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022154508.63563-1-sebastian.reichel@collabora.com>
 <CAPDyKFoAv1jeQitHmTMhvwG9vGzN-vLby0fPzkX1E6+-Qe2dog@mail.gmail.com>
 <CAPDyKFp=sRLVBhW2aK87pYHVGi_6gNw=e3j3AGMnEWP2SVYFpw@mail.gmail.com> <9b4c9b61-a2be-465e-a4d9-034951fc862f@sirena.org.uk>
In-Reply-To: <9b4c9b61-a2be-465e-a4d9-034951fc862f@sirena.org.uk>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Fri, 1 Nov 2024 22:41:14 +0800
X-Gmail-Original-Message-ID: <CAGb2v65ahUB_Q+HPFV6B-UqWCbCNLdGz58BGo9iHRhVyf1ruZA@mail.gmail.com>
Message-ID: <CAGb2v65ahUB_Q+HPFV6B-UqWCbCNLdGz58BGo9iHRhVyf1ruZA@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] Fix RK3588 GPU domain
To: Mark Brown <broonie@kernel.org>, Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Liam Girdwood <lgirdwood@gmail.com>, 
	Elaine Zhang <zhangqing@rock-chips.com>, 
	=?UTF-8?Q?Adri=C3=A1n_Mart=C3=ADnez_Larumbe?= <adrian.larumbe@collabora.com>, 
	Boris Brezillon <boris.brezillon@collabora.com>, devicetree@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 1, 2024 at 10:36=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Fri, Nov 01, 2024 at 12:56:16PM +0100, Ulf Hansson wrote:
> > On Wed, 23 Oct 2024 at 12:05, Ulf Hansson <ulf.hansson@linaro.org> wrot=
e:
>
> > > The merge strategy seems reasonable to me. But I am fine with that
> > > whatever works for Mark.
>
> > Mark, any update on this?
>
> > If easier, you could also just ack the regulator patch (patch1), and
> > can just take it all via my tree.
>
> I'm still deciding what I think about the regulator patch, I can see why
> it's wanted in this situation but it's also an invitation to misuse by
> drivers just blindly requesting all supplies and not caring if things
> work.

I suppose an alternative is to flag which power domains actually need
a regulator supply. The MediaTek power domain driver does this.

There's still the issue of backwards compatibility with older device
trees that are missing said supply though.


ChenYu

