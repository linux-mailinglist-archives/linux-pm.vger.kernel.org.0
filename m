Return-Path: <linux-pm+bounces-17724-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE90D9D1366
	for <lists+linux-pm@lfdr.de>; Mon, 18 Nov 2024 15:42:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DCE2284B2D
	for <lists+linux-pm@lfdr.de>; Mon, 18 Nov 2024 14:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765411AE006;
	Mon, 18 Nov 2024 14:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D2SXBmTl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BB818B46E
	for <linux-pm@vger.kernel.org>; Mon, 18 Nov 2024 14:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731940793; cv=none; b=Cczgzt3dFV7BLtxa7qSP5UFIFmRq8Fro8GJokcL4MJ4280N24VbXt9r2JYTQGd1jjXWdcHe7KKbQJ5MBRjTOoz/OUk2cJN4El9aUt7h/auALx4Ag6lZi00FlBPOrRGUsSO7mtlcXgl5w7j5tv6bm2ubp5ARfb6cehuWT435SDDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731940793; c=relaxed/simple;
	bh=6OxsRk/yPJyDXFI5pv6/HtQ2SC7vaQPk3DaXR38kGVI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VBJJQZb3lq9YLnPoFtwQ7AxmRhr6JfPxxirIAt7Yh9x8QYa9+68LGm3ZpLXRxBkWO8yn2Jwzm0sRfKQrR9yM/W5Re0hd4oSYQl2jsNpG2Q5NLk73qv+dFkI1md74NCTdZXu2Mn8xYIN/KX3xK3lF8pemRUvE3g7/AiiVVijON6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D2SXBmTl; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e3882273bc8so1563547276.1
        for <linux-pm@vger.kernel.org>; Mon, 18 Nov 2024 06:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731940789; x=1732545589; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=r9ByUzP6+73RBqmQ54+FUS5a2RqUQJq8/v72072Hlm4=;
        b=D2SXBmTlS0Do7w9xiP9PZl6/zU0GTcrT47ekBVECE65U4AfnFkYsCIe0amUCblcu0o
         dZWmc/wi79+SafuH4uHi9YaFjRolXHvgJ6ibp5jM6hV2QhmlYKjubSGJ+UlYxv17bnyd
         6mGoqV1mMmj3svgSEcAwkueJiseUkqAYyEjUfVv1zrOlcfJwtMJq3ddSsEdV5Q3MaLTO
         Cfpln93H9+aLafOtKXWAD56W1q+Y8AuIVIRQCQSEtYcVZSW91KjMXh3SodBccqVQy1Zz
         Qfuw+mZBFl+iRxGsqSq69pxecTGFR0+d/W0gAnbAfb7Z4umHUIYKzESFFCdx1aU4gI8H
         9zng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731940789; x=1732545589;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r9ByUzP6+73RBqmQ54+FUS5a2RqUQJq8/v72072Hlm4=;
        b=F6Y7fHBf+FKiYuhGRY9fXtcoxR9J8CrOUSCzOkrbh8BX5hsJsVRAJkuTvF5BSGgPh3
         XU0FepnXeue51L2Z6KjkRF6ziu8wx1NNoptUImzpfh3/26AQ9im1rdKZaHf7FFCB8YiA
         wGIz8SD0y2FsJZG5/ccfG1LDk68WwexD/qxA+01eV3lHIpbxd7cx29PoXimzLEeVTtHF
         udV40WXI1TZ9z6kpUOtvlVtQ5dU+aIq5w8DxtZ4oXlsdaU97Lgqc6TpTE56rtBFTSc++
         UQ31l1pAvUYGh5xcR+ffLz/70xbT1YNbyMuqz1f2Buk1vK5DHF9kKNJ6vrpisOlIR9KI
         ppjg==
X-Forwarded-Encrypted: i=1; AJvYcCXY92z6wL4OBeABvwNlVmHvyrtGlNw8IylmZdCnRQklgy6ns4lQEzu3c5quyWNWDDvkYJjeUQFABg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzPhAEn0XmThEuM0Y7zf46XNx59XAyTbgqochQJB4u+yd06C/Va
	yFWeToiEKqS8PMSJpz00/9mRrTNNIeNJ4d+52UQgstYSpZuncoYDXPvSkKryVhHaMCk3FNLWNGh
	D7ixfJsZI9teAv7wcsDYnDRH9mIsqgYN+ZOopIg==
X-Google-Smtp-Source: AGHT+IEEpyD2A4JYQ5Rg/9zTZnt5t5baJqVCTEDDP7vQeL7ALYKTj4alMmxiJWSoMJkT89RKqFeUMQC/HuG0OMTqlRs=
X-Received: by 2002:a05:6902:3381:b0:e30:c76e:960d with SMTP id
 3f1490d57ef6-e3826176347mr9019615276.27.1731940789418; Mon, 18 Nov 2024
 06:39:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113-topic-sm8x50-gpu-bw-vote-v1-0-3b8d39737a9b@linaro.org>
 <20241113-topic-sm8x50-gpu-bw-vote-v1-6-3b8d39737a9b@linaro.org>
 <nw2sqnxmhntvizzvygfho6nhiwfni4xfquwst5gd5g2tel6pnr@h66d4mw46jcf>
 <8df952a8-3599-4198-9ff0-f7fac6d5feaf@linaro.org> <p4pqswgaxbx2aji6y5v2qngn3xp4gdlruthhbzpb4cgfs2earz@mo7zbsgqwc4b>
 <e76a2531-a96a-441d-ac2d-bc1557370aa5@linaro.org>
In-Reply-To: <e76a2531-a96a-441d-ac2d-bc1557370aa5@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 18 Nov 2024 16:39:38 +0200
Message-ID: <CAA8EJpoO6sE8noSvvn0s7bu4Vi6-3YZ=kuxnv4+Vn_MfM3hSaw@mail.gmail.com>
Subject: Re: [PATCH RFC 6/8] drm/msm: adreno: enable GMU bandwidth for A740
 and A750
To: neil.armstrong@linaro.org
Cc: Akhil P Oommen <quic_akhilpo@quicinc.com>, Viresh Kumar <vireshk@kernel.org>, 
	Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Konrad Dybcio <konradybcio@kernel.org>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Connor Abbott <cwabbott0@gmail.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 18 Nov 2024 at 15:43, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
> On 15/11/2024 15:39, Dmitry Baryshkov wrote:
> > On Fri, Nov 15, 2024 at 10:20:01AM +0100, Neil Armstrong wrote:
> >> On 15/11/2024 08:33, Dmitry Baryshkov wrote:
> >>> On Wed, Nov 13, 2024 at 04:48:32PM +0100, Neil Armstrong wrote:
> >>>> Now all the DDR bandwidth voting via the GPU Management Unit (GMU)
> >>>> is in place, let's declare the Bus Control Modules (BCMs) and
> >>>
> >>> s/let's //g
> >>>
> >>>> it's parameters in the GPU info struct and add the GMU_BW_VOTE
> >>>> quirk to enable it.
> >>>
> >>> Can we define a function that checks for info.bcm[0].name isntead of
> >>> adding a quirk?
> >>
> >> Probably, I'll need ideas to how design this better, perhaps a simple
> >> capability bitfield in a6xx_info ?
> >
> > I'm not sure if I follow the question. I think it's better to check for
> > the presens of the data rather than having a separate 'cap' bit in
> > addition to that data.
>
> I don't fully agree here, I just follow the other features (CACHED_COHERENT/APRIV/...)
> nothing fancy.
> I'll introduce a features bitfield, so we don't mix them with quirks

SGTM

>
> >
> >> There's other feature that are lacking, like ACD or BCL which are not supported
> >> on all a6xx/a7xx gpus.
> >
> > Akhil is currently working on ACD, as you have seen from the patches.
>
> Yep I've tested and reviewed the patches
>
> >
> >>
> >>>
> >>>>
> >>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> >>>> ---
> >>>>    drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 26 ++++++++++++++++++++++++--
> >>>>    1 file changed, 24 insertions(+), 2 deletions(-)
> >>>>
> >>>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> >>>> index 0c560e84ad5a53bb4e8a49ba4e153ce9cf33f7ae..014a24256b832d8e03fe06a6516b5348a5c0474a 100644
> >>>> --- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> >>>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> >>>> @@ -1379,7 +1379,8 @@ static const struct adreno_info a7xx_gpus[] = {
> >>>>                    .inactive_period = DRM_MSM_INACTIVE_PERIOD,
> >>>>                    .quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
> >>>>                              ADRENO_QUIRK_HAS_HW_APRIV |
> >>>> -                    ADRENO_QUIRK_PREEMPTION,
> >>>> +                    ADRENO_QUIRK_PREEMPTION |
> >>>> +                    ADRENO_QUIRK_GMU_BW_VOTE,
> >>>>                    .init = a6xx_gpu_init,
> >>>>                    .zapfw = "a740_zap.mdt",
> >>>>                    .a6xx = &(const struct a6xx_info) {
> >>>> @@ -1388,6 +1389,16 @@ static const struct adreno_info a7xx_gpus[] = {
> >>>>                            .pwrup_reglist = &a7xx_pwrup_reglist,
> >>>>                            .gmu_chipid = 0x7020100,
> >>>>                            .gmu_cgc_mode = 0x00020202,
> >>>> +                  .bcm = {
> >>>> +                          [0] = { .name = "SH0", .buswidth = 16 },
> >>>> +                          [1] = { .name = "MC0", .buswidth = 4 },
> >>>> +                          [2] = {
> >>>> +                                  .name = "ACV",
> >>>> +                                  .fixed = true,
> >>>> +                                  .perfmode = BIT(3),
> >>>> +                                  .perfmode_bw = 16500000,
> >>>
> >>> Is it a platform property or GPU / GMU property? Can expect that there
> >>> might be several SoCs having the same GPU, but different perfmode_bw
> >>> entry?
> >>
> >> I presume this is SoC specific ? But today the XXX_build_bw_table() are
> >> already SoC specific, so where should this go ?
> >
> > XXX_build_bw_table() are GPU-specific. There are cases of several SoCs
> > sharing the same GPU on them.
>
> So it's gpu-specific
>
> >
> >> Downstream specifies this in the adreno-gpulist.h, which is the equivalent
> >> here.
> >
>


-- 
With best wishes
Dmitry

