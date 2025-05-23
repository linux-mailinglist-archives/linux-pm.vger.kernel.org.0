Return-Path: <linux-pm+bounces-27589-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9FD2AC263D
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 17:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D065A46E19
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 15:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD3621A428;
	Fri, 23 May 2025 15:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ET7Son7D"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3C57DA7F;
	Fri, 23 May 2025 15:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748013536; cv=none; b=SADy3t5JCND49lgdldWkBtAm6kz9/HzTO8vLDCnRKYZa2foxiqcg/SQH7DSMGpCfhUIrztHkUz2Lw0cl91tEk7fFBYIamM5Bl++3IJivT9qjOX61/szp1oRWBFfvWiImekADzh7kh6RvEPzwj2ZgwnHNwCkXZQPKdEay+WQm/j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748013536; c=relaxed/simple;
	bh=vfrsRDC6toZA+evlzaTSgd0r4TXuSQZJBOrWeoSSGR0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qmNliHtLeEM3PcP2/HlpbNIZYsFb5QnXn14TVYaT8qWNARZxau2JdfuiTHYGb5Zn4Q58pgFx3I2Do2mK0X+hy6UpIsu97zNkUXiwBWAiBM1TsTO2EjadFE36963SxsLex5YrJIMGr9ZTmbgL1IwPj1mvqc8kAhc+BMf/VzDSL2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ET7Son7D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AFE9C4CEED;
	Fri, 23 May 2025 15:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748013536;
	bh=vfrsRDC6toZA+evlzaTSgd0r4TXuSQZJBOrWeoSSGR0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ET7Son7DWye4nzTmP7deVo+13G2+w6nhIgr/TCY1KLrgOPmdg9DjWFrayGbs7QqzM
	 nZpH4uK4uCrYQKWlDQ5HCmxC3XZMWNTcco261RAWT/43pIYR40OH1KMqFQ/IrOQoXu
	 XpFOyrssdQj+jKxe8loGsKXIJbUo9Zwi8laY8lwgjvjS6sPptT9WYv++xSaCJbpTbw
	 FxBXeQ9ixjm7Xp+QWujOuYuzfuVnJVN6rde6l5rP6cornSLoREJOcxV5UukB0iTxxw
	 djMHSBLQrePkLXf11sRHW1S9WaBjYZbB3bJMziaomCibSR1546sqlgEUrHALOAL2BR
	 wMOZl9Cxx+22A==
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3f6dccdcadaso37563b6e.2;
        Fri, 23 May 2025 08:18:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUSVS3WzrZd98XZqClFqJ7RlFRvtvEISwEhDLzM5sDFwGWvMctuYOGYOCJuf9Q5Sjg8Mm6zPKpgQUaWDlXF@vger.kernel.org, AJvYcCVe14pGS+dcSJhu82HoYXEhF06h7e6PmDZ/vf0WB7kfuhrexLeN27yovZcz5ALhlqwpRNmXlxOJ3LE=@vger.kernel.org, AJvYcCWvVlRS9TyOfQOWG7Tw/32dWZqkryiS2/MmlLJpHESz2kwZxUwaA6BzBVRvLq/sc2ogBCfiAemISTbEniqQ@vger.kernel.org
X-Gm-Message-State: AOJu0YywvvG9PFEKkgiXvf/G24neXELPUvNMxSlEpJdtic6CUebdTGWj
	pra5jVVSnTTYzPlId9Qb3J3p1GeQoz08FI9oAOSjVE1CDL1qLg647ByB87Kwk8zjnHUBShJyySu
	Wwn/HIzvQ86YULPphgIjvpVAllZlJOIA=
X-Google-Smtp-Source: AGHT+IHqceP+lC/wJAfpjWJOMSCJpGmiTDiP7m0vFW32EFbftFDinT7X0A/Vw50GaEKOLrQUWd6NttIzO0oLfmNWvh8=
X-Received: by 2002:a05:6808:2029:b0:3fb:2e8f:4de5 with SMTP id
 5614622812f47-4063d9e4051mr2272588b6e.17.1748013535331; Fri, 23 May 2025
 08:18:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250522-ipq5018-tsens-sparse-v1-1-97edaaaef27c@outlook.com> <h7eddsjh27vvv53gbexo42pizjrma47463nhiytqhk5nyzmanh@bdnjxzc4hzro>
In-Reply-To: <h7eddsjh27vvv53gbexo42pizjrma47463nhiytqhk5nyzmanh@bdnjxzc4hzro>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 23 May 2025 17:18:44 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hKVGFG_wY+HukbG97J4QQA7ab=KjBMqu9EZCsqEOHsog@mail.gmail.com>
X-Gm-Features: AX0GCFu3fJEjZzip-edk-QaLx-X2X4v7J1xiA4ww_junHpoOgM8SeByFOmwqxhk
Message-ID: <CAJZ5v0hKVGFG_wY+HukbG97J4QQA7ab=KjBMqu9EZCsqEOHsog@mail.gmail.com>
Subject: Re: [PATCH] thermal: qcom: ipq5018: make ops_ipq5018 struct static
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, george.moussalem@outlook.com
Cc: Amit Kucheria <amitk@kernel.org>, Thara Gopinath <thara.gopinath@gmail.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 22, 2025 at 2:46=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:
>
> On Thu, May 22, 2025 at 09:48:51AM +0400, George Moussalem via B4 Relay w=
rote:
> > From: George Moussalem <george.moussalem@outlook.com>
> >
> > Fix a sparse warning by making the ops_ipq5018 struct static.
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202505202356.S21Sc7bk-lkp=
@intel.com/
> > Signed-off-by: George Moussalem <george.moussalem@outlook.com>
> > ---
> > Fix below sparse warning by making the ops_ipq5018 struct static.
> >
> > sparse warnings: (new ones prefixed by >>)
> > >> drivers/thermal/qcom/tsens-v1.c:246:24: sparse: sparse: symbol 'ops_=
ipq5018' was not declared. Should it be static?
> >
> > vim +/ops_ipq5018 +246 drivers/thermal/qcom/tsens-v1.c
> >
> >    245
> >  > 246        const struct tsens_ops ops_ipq5018 =3D {
> >    247                .init           =3D init_tsens_v1_no_rpm,
> >    248                .calibrate      =3D tsens_calibrate_common,
> >    249                .get_temp       =3D get_temp_tsens_valid,
> >    250        };
> >    251
> > ---
> >  drivers/thermal/qcom/tsens-v1.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Fixes: 04b31cc53fe0 ("thermal/drivers/qcom/tsens: Add support for IPQ5018=
 tsens")
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Applied as 6.16 material, thanks!

