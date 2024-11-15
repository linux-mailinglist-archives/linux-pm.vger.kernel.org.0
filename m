Return-Path: <linux-pm+bounces-17631-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B41759CEABC
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2024 16:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A64D283F53
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2024 15:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437A31D45EF;
	Fri, 15 Nov 2024 15:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OJTkSus5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2FC1CD210;
	Fri, 15 Nov 2024 15:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731683428; cv=none; b=LCSWqz3Xpwto9H29XGT66ZEgoBmUXPWU1ew241hsjEFMl0JXA0O4wLR5JO0WtuQwOTwHYvZsOm5IJoO87Re3OV9TTMBk8xdgSRBECpKeeXkSjvW4cqyHSLECE70BD00fKa7D2BqWovPgzSU52IBC6VSgAVZE5wyJplc+7K1iciw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731683428; c=relaxed/simple;
	bh=XuYVDKWxJgRzbEDpq2EnHT3AN84MFrPjCNvbUOa8htY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HaHr8kwnUThZ0Qorrg5z3qgt2RH6snjXgveXZAdFcFKGrNei3s2EkFPb1qW0NPVUqhjQVkzAfEGbi1RAaPlXw0mvqL5cskIgGXHPRPQwDh17IgE7VFERBik4KIne/C9psvKbv2DQCyp/+Vyz0wjgSwTbETvl2duCB0iSSAMo0mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OJTkSus5; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-539e63c8678so2027130e87.0;
        Fri, 15 Nov 2024 07:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731683425; x=1732288225; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aUVjcB0sOga4/HfM/3eh0FFL6nDbEVfse0QAH2YWS2s=;
        b=OJTkSus59njDKR0WGrJY54DVwkuxG16kjZy8w0+uQLTLTjK6BYJO2/nu1VEG/mOHNT
         abuggyp3k51q9J1Eb5s623nmB2p9+x2jwfRuyREm0HK9u3MneIHCq4Ja9XoSIVBiuKJs
         ayhtn8km47j1AQotTmZtaI4lE/hB8E8OPi7namtEoqAsjsRij4+MaOkwwNQtFo0y2sNE
         6Xh1Tir1mk0dTykw6qRhg3euqw1gH0m3Btbs8dgVXsXZUPNEcN6VQ4Q+k5q2j0ygFQW9
         xw2lHcvA9lSCetOI8kJ1gfWFOeQVGonUX8osrTv2IEVeBOBG6Tb/M8VYr4Xu3jRuGZeS
         mv5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731683425; x=1732288225;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aUVjcB0sOga4/HfM/3eh0FFL6nDbEVfse0QAH2YWS2s=;
        b=R+XFMtF9DHhM2pRWXrWg7vi7+Sf5nlHiNeNQ4RWHQ8urycwpb2dVn6H6KKcWxhJnVB
         txx4r1q5oMdPQzbYVFXTZ1mcGnQoYAcV+y9pHg9DRUqfahMnGouefK+SlAlUT78vmN1L
         6tiyvbeUIF1ECGPznQ5X/EB9FK2ipXq6fk+EpTVAwscdxhbQusla26yl06tQbPJi6l+q
         g5d8fHnuuGR97n2QQdQmMH+ZaP+uMfXQcJLU+ua3bzYVW43lbY/EOBJ59eGDA55b+nR5
         g0t1pA3fHhHO+h6aZCnd281WVIbTRS4urwGvlwHPs7pdkYfDdQVdUTcwJEoqhCyD7Tva
         RT/w==
X-Forwarded-Encrypted: i=1; AJvYcCVyCP6JPuRx7lAtLFuBzIhayGBAm2lan8apwcAtpTs6OjDOG8Mq0J/bK9GdMl+WeJLatOp2Ng2UdvZNSDtp1w==@vger.kernel.org, AJvYcCWFgGY9WxZ7Gc1SL3OypQ+8rDjX+yPUcimAXS9Bj0R6qyg647GwXAjma33uwdIAwF1iGEeUzDmTaOzVPviz@vger.kernel.org, AJvYcCWojxc/3yslg3sqfGj5f1w9uLI2bq6UyCx47Il/xFMIn1GJh2E1VU7WmTYZuiaJud5cYXbYD3kdySY=@vger.kernel.org, AJvYcCXmGWkpnM/WwNcVoQS3wYUC9iW7S6+BcQjtPIy3DG0j0VuJaZuuSy32twxfSiYcnV5jl9ahfVhpgBrF@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3XgkrOe8rvSsqrHbh8se0eTvLwlAOmAtTAlrEL1k9yUZKlyaF
	XUu/CEZtvKeq4KW1163QBf9qVCnIZQNjmlv/vjcrw3JH+9jL0mobhD8Nyo1Uh+vE3FV7LmiWYjk
	wBnW97INVfdnvFMzBM/4epfuduEM=
X-Google-Smtp-Source: AGHT+IFSKvpcyw2QBM31REHWotzjXsDEflFMRHu0OtabMrDtzWscE1nvK6FbR8cj0/dESTLG8Of/bCGbaYf8tMdXAx8=
X-Received: by 2002:a05:6512:1190:b0:53d:a024:ddb2 with SMTP id
 2adb3069b0e04-53dab2a076amr1380484e87.24.1731683424294; Fri, 15 Nov 2024
 07:10:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113-topic-sm8x50-gpu-bw-vote-v1-0-3b8d39737a9b@linaro.org>
 <20241113-topic-sm8x50-gpu-bw-vote-v1-2-3b8d39737a9b@linaro.org>
 <sgz4h6rlmekiwypaisjbnej326wv4vaqt3mgspp4fs4tg3mdfx@cwmdqcu6gwbf>
 <63a2b391-8b71-41cb-bed2-3bc7fd2154ab@linaro.org> <CAA8EJpoFm8EjfBq70RTPtwR7Y7Rm24kHO20NukGiLGRYD0p9Tg@mail.gmail.com>
In-Reply-To: <CAA8EJpoFm8EjfBq70RTPtwR7Y7Rm24kHO20NukGiLGRYD0p9Tg@mail.gmail.com>
From: Rob Clark <robdclark@gmail.com>
Date: Fri, 15 Nov 2024 07:10:09 -0800
Message-ID: <CAF6AEGty1fcA13rDOOJQbhT4o=CTtBYtGFspowZbxD1c-VE9Bw@mail.gmail.com>
Subject: Re: [PATCH RFC 2/8] drm/msm: adreno: add GMU_BW_VOTE quirk
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: neil.armstrong@linaro.org, Akhil P Oommen <quic_akhilpo@quicinc.com>, 
	Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Sean Paul <sean@poorly.run>, 
	Konrad Dybcio <konradybcio@kernel.org>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Connor Abbott <cwabbott0@gmail.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2024 at 6:18=E2=80=AFAM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Fri, 15 Nov 2024 at 11:21, Neil Armstrong <neil.armstrong@linaro.org> =
wrote:
> >
> > On 15/11/2024 08:07, Dmitry Baryshkov wrote:
> > > On Wed, Nov 13, 2024 at 04:48:28PM +0100, Neil Armstrong wrote:
> > >> The Adreno GMU Management Unit (GNU) can also scale the DDR Bandwidt=
h
> > >> along the Frequency and Power Domain level, but by default we leave =
the
> > >> OPP core vote for the interconnect ddr path.
> > >>
> > >> While scaling via the interconnect path was sufficient, newer GPUs
> > >> like the A750 requires specific vote paremeters and bandwidth to
> > >> achieve full functionality.
> > >>
> > >> Add a new Quirk enabling DDR Bandwidth vote via GMU.
> > >
> > > Please describe, why this is defined as a quirk rather than a proper
> > > platform-level property. From my experience with 6xx and 7xx, all the
> > > platforms need to send some kind of BW data to the GMU.
> >
> > Well APRIV, CACHED_COHERENT & PREEMPTION are HW features, why this can'=
t be part of this ?
> >
> > Perhaps the "quirks" bitfield should be features instead ?
>
> Sounds like that.

But LMLOADKILL_DISABLE and TWO_PASS_USE_WFI are quirks.. so it is kind
of a mix of quirks and features.  So meh

BR,
-R

>
> --
> With best wishes
> Dmitry

