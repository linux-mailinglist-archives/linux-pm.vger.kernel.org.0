Return-Path: <linux-pm+bounces-17924-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A65A9D5391
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2024 20:48:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8C48B2291E
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2024 19:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7340D1C4A35;
	Thu, 21 Nov 2024 19:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VUVRg+Qw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E314614F10E;
	Thu, 21 Nov 2024 19:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732218523; cv=none; b=Ogsh2RUEm4Ikg5meuJ8M/pTUy6wVZ42W89U+lY8fm69tRiftiWZ37SYI7rKXynNHfXiBXJXTQwc0FVMtPii0Lj0EuDgUFJxk7/m1I73w5I90xCCaMDCSB3sJAiB7yk9ob1SXa4Qys2iE0X5a7xqKEVf+eexhduDPF0C4OC54G9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732218523; c=relaxed/simple;
	bh=2mmxw9K5UaQSpBQU/eNyl68TYy8cqH/wCI4bKyVA72c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jk/5+hOpPHbvrmVayzCKck6vE8PnKaEz/01ux86VOnjwveJrmQFCKE4mMZct+L90zOkxgw63AFCPcRQum7carl7TFC709OXTsJN4FD4Si7YKR8/ZqhJOwlDGhe6sRg2E6gDQ9HDDsUlFyeUjp+4Zu0GmsuhDh2UQpxamHr8aN9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VUVRg+Qw; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-83aad4a05eeso50343339f.1;
        Thu, 21 Nov 2024 11:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732218521; x=1732823321; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2mmxw9K5UaQSpBQU/eNyl68TYy8cqH/wCI4bKyVA72c=;
        b=VUVRg+QwDSUGxhyBiHEWVmX+SASSwXV+0mdLiCtN2jnYdYel+a/BrdEwHyZGRpluXr
         M6YJHrzIBLE+uTchZN7gMTj3N42m005NieEiCo7b3aOzB6c4E/i+BeBA8AvG5RUnxzzB
         dHKWkb//UZFQ7bNuJvm644wr+AQRHyRUUMJQxei/7+JsTnPRyoAdaH0jQQ37M0cYlEWs
         Iao3+lU6ufOpHDI0Aw7S1D+u+vV0TENJNk3Mx82atoVG7/ZOQTVcZT87ygtvG1YkghW1
         FbVquzi5tN3Ku/2S/9LF/fVnb3SJ/MST0wpAo/xFjpNa8+1XiewW+wmqg+X2hw+Geipf
         fwjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732218521; x=1732823321;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2mmxw9K5UaQSpBQU/eNyl68TYy8cqH/wCI4bKyVA72c=;
        b=T+Y9xLi4X+neSID0QbseL5g3iDJbNgE/zhXbUVZV3afrgxamab4bFqBHtOHDUamVPe
         3QOqJzjw6Z7nu5fO++aBsr68GZOwRVxah8zrGaBfF5hQfdSHjrAw34OndmPhph2J07lC
         RlHQe23g5rTjeyD2/Z14tYbdAJcZP6UQnbSLG68k4Pxo+BEFIQd9ZS1kHfNdTWTnMKJ9
         UGCa01k780XxAxBVCJvDQtEHem1sZxWdiTayXmJ0kl9TPq8JqrOxSqVY55nNj08MIctR
         3Mzt415Ui9ihBjikTMG6wQw+LfYHhBK0Y4GUXviUM2C08o3Nxpz1ROOJxx9HwZ3WKo8p
         nUQA==
X-Forwarded-Encrypted: i=1; AJvYcCUruV1+KlIYpy/AGPtCyeeO9NywVzvJBq5vdYkXBNcP98aM0IwXI0+n8jOSwMu1cTYvAXvDLaiM64Qfg2RRJw==@vger.kernel.org, AJvYcCWCqFlnLSWjQfrViJUVX/EcTxUzhRuw1Sd+0Q7anAkQsjkX3143mqFJlIhePJJt/RQuSNqxQpKqkUZ8@vger.kernel.org, AJvYcCWzP0kaHENDQvNCrT6rDuDDemHhSauhg3cAlCoLFazUndTI3n/f71hWBPiZtMQ3wXhsriXjl3Yar9OOqC+j@vger.kernel.org, AJvYcCXMqDkBfAb4UURTX9IYJNA4bLqzkNz3wmjjj/R4Qx5aaBRgF1jSdRuNnHwbe1vaH7+1WZRQ+GtMMg0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDROSNMfwseXyFAgwsr2zO8oTd0JfORmCS4oqVXOjcM+6rHCYB
	SIIezJ89bczBJZtd97K7odrDVirmauR2gKQZHT2m3MuDbNJKSl0PiMmEQlME5MUZkWysLCeR4va
	tleK0jdWZctsUP+mhg+fi/sAJ2jY=
X-Gm-Gg: ASbGncvM9WZkgpRpDQlMxs8PyqiYX7sNkDz6bR6LekPe+ZjVUE+wxmWPYQ6YHHVbUx3
	kDj2Wd2o5D7q3haVsBJ7oI61uLuMx38e8EdPQIwX1tWnSQJU+L1AWqfNvpU7ciA==
X-Google-Smtp-Source: AGHT+IHdcAeKJTnbBs+MjzCxYbF1H9xK69rOeH8X0oOXQybp3afVqWQjay99oVRaX9L75eLDJV9epy2kOJM1zrHXieY=
X-Received: by 2002:a05:6602:154d:b0:83a:872f:4b98 with SMTP id
 ca18e2360f4ac-83ecdc44f29mr19701639f.2.1732218521051; Thu, 21 Nov 2024
 11:48:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241119-topic-sm8x50-gpu-bw-vote-v2-0-4deb87be2498@linaro.org>
 <20241119-topic-sm8x50-gpu-bw-vote-v2-3-4deb87be2498@linaro.org>
 <fkezpguictntg2wkouwqipnaaiauo6vu46n7a2xzvlorzvyeaw@bbcpj3bs5eko>
 <CAF6AEGs6zT_kaTXNohUaA7KWZxZTr4byaoMoLAceuyqA7S+2CQ@mail.gmail.com> <dtt6d427u5yep3i3b3zxxef7uh572aeu3vtatmjvpbqfpjbvjc@epkkr7oumncn>
In-Reply-To: <dtt6d427u5yep3i3b3zxxef7uh572aeu3vtatmjvpbqfpjbvjc@epkkr7oumncn>
From: Rob Clark <robdclark@gmail.com>
Date: Thu, 21 Nov 2024 11:48:28 -0800
Message-ID: <CAF6AEGsr2WoOdytWzDU_TJJh4myPj3B943LMisxisnA45rLFKA@mail.gmail.com>
Subject: Re: [PATCH v2 03/11] drm/msm: adreno: move features bits in a
 separate variable
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Akhil P Oommen <quic_akhilpo@quicinc.com>, 
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

On Thu, Nov 21, 2024 at 10:44=E2=80=AFAM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Wed, Nov 20, 2024 at 10:54:24AM -0800, Rob Clark wrote:
> > On Wed, Nov 20, 2024 at 3:18=E2=80=AFAM Dmitry Baryshkov
> > <dmitry.baryshkov@linaro.org> wrote:
> > >
> > > On Tue, Nov 19, 2024 at 06:56:38PM +0100, Neil Armstrong wrote:
> > > > Now the features defines have the right name, introduce a features
> > > > bitfield and move the features defines in it, fixing all code check=
ing
> > > > for them.
> > > >
> > > > No functional changes intended.
> > >
> > > I think it might be better to squahs this patch into the previous one=
,
> > > it would simplify checking that we use .quirks for ADRENO_QUIRK_foo a=
nd
> > > .features for ADRENO_FEAT_bar.
> > >
> >
> > IMHO better to keep this separated
>
> If they are separated, it is easy to overlook presense of a statement
> checking .quirks against ADRENO_FEAT_bar.

Maybe just drop this patch.. we don't really have so many
quirks+features so a single bitmask is fine and avoids this
wrong-bitmask-problem in the first place.

BR,
-R

> >
> > But we don't have _that_ many features/quirks so I don't find
> > combining them all that problematic
> >
>
> --
> With best wishes
> Dmitry

