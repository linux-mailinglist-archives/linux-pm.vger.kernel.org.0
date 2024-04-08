Return-Path: <linux-pm+bounces-6068-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E71C489CC83
	for <lists+linux-pm@lfdr.de>; Mon,  8 Apr 2024 21:39:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FC361C215F8
	for <lists+linux-pm@lfdr.de>; Mon,  8 Apr 2024 19:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224C3145B17;
	Mon,  8 Apr 2024 19:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nGfnE2eV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCD61EA73
	for <linux-pm@vger.kernel.org>; Mon,  8 Apr 2024 19:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712605153; cv=none; b=PmCiXh1z6oE7VQ9WZw1mVPwzhBZTYRUQHDZ42HQDzaDNFuQOURGvy2xqBmTMVd8jz7rkYkyF7VhkKYtEt9Cg9sF0Wn3j6+tSA9H8R/AikWXb4DzNJ+PYI7HRQyXZBmIYSwqnMQFzKQi9hD4GVwRYO8p1xpGh0TuPelqaydV9VVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712605153; c=relaxed/simple;
	bh=D0Rxw/rHOejyh44XmYi4PJ+qu3rIoxP794lIWa8BHfo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z6p6HVmcJXl+y1p1j6xi1ok5a5PLYej9wGHqUriPTZTv4j7nJyRo/tjjkg5hvCp+nHZ/3ZXMD3jteFOOvurbjIrRWXKIZuD4YtfhJobjHsvnQBmmuH1qoMqa61rUWg5MSCLmP4QGSaGaR6U1kn44ZnYUkeRDTEfV8LqGl1q9ilc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nGfnE2eV; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-41641a889ccso15135e9.1
        for <linux-pm@vger.kernel.org>; Mon, 08 Apr 2024 12:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712605150; x=1713209950; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D0Rxw/rHOejyh44XmYi4PJ+qu3rIoxP794lIWa8BHfo=;
        b=nGfnE2eVfJegOZ+Hs+z20uN5jjm39pmb14P3Bt4OMstkTmVqG4DKq8MZzkfN98WC8j
         KMqw+poTuEo0NBvoUtm22WS3mT3TTQid1AqnWlRVnOc/kVbwQt+fUNxD80DqET6qtgpB
         2obm7qM4aJBYVBhVmKg2fxcyeq0/B1329piqE1UQAKmewE9kXHGXduPGLlCmWQndLAKJ
         RCdncKf3H1gHCpoUtl/6w57MGpem55EKXFvZem/+nHxGSAH/GiwAmsH1rmO4q4oZ24tz
         T+YA6aZR4EsXTNsGiawt2kjOQbIlOE+rgPgYHqqlEDyATKxMRn0LwumHvH+j5sN1MmYe
         WQWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712605150; x=1713209950;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D0Rxw/rHOejyh44XmYi4PJ+qu3rIoxP794lIWa8BHfo=;
        b=KuoP1Q3jug4WIQNv0MkMlh3qoANzFfaln3jbX/jJsHOPjO28LJHz3kSFV7WQ4bs3t+
         kvBI88NXAuh7cdSyatdtSlihScTepmlIpwrmZXUlsqRBnS19+4jyg22X1raFe+mQ2r35
         Pxrl2nEBLStTTbq3z9btnHuq3yDsPjAeQyYetw5EK+p/TkoS9SK1ER11zFlgE7AIZT6m
         eWPWN8Vb6odDl+u1fN169UClAjfnxGZIPDAYNaGfrUo8ANmLL5zT1czjdDXSADWCcjjU
         cAPJ45TRggaMzA/ZanDR9W0qh+5RAPiEJAG6lHA62LmvtsDdTzut0ecij/xQ2lw6VVJp
         gRQg==
X-Gm-Message-State: AOJu0YxE0iuvcNq5rkxYWc8K/ZkRyjO2p1Sp6qWsArC7mCtGGY80jniJ
	TlIP9LHH9BJ5dx/AtG+rE3sVHPSgeRXaYYHdKEs26qq8OmBGBVoI+TZcz1kuLhAk4Xq/Yrb+0az
	NEM5rQTm0E2ely/nC12Jdp8v2JfvY5E0cRIA=
X-Google-Smtp-Source: AGHT+IE34uA7EzemH0/QsQmQlpxfcXZfIWR6/94A1vCsfRdOuJ5bTOlGtsT1ElQZJYi+ed8Eyo0fF9X5lv+iYXJO0YE=
X-Received: by 2002:a05:600c:3d0b:b0:416:7f8a:c6ea with SMTP id
 bh11-20020a05600c3d0b00b004167f8ac6eamr28263wmb.1.1712605149615; Mon, 08 Apr
 2024 12:39:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20220710164026.541466-1-r.stratiienko@gmail.com>
 <CANDhNCpAhtgdwpSUTJ2jo2J5L6rHzQHVB9q+kkZ3ouTt12b-uw@mail.gmail.com>
 <CAGphcdnK8Hx-YsA-HukRKbvC-HpnLktCtq8qFicQUL-8ZHC+1w@mail.gmail.com> <CANDhNCpN-MGXswfFV=mbMJBbHh919iTv9BMYFsk7bMgbZa1gVQ@mail.gmail.com>
In-Reply-To: <CANDhNCpN-MGXswfFV=mbMJBbHh919iTv9BMYFsk7bMgbZa1gVQ@mail.gmail.com>
From: John Stultz <jstultz@google.com>
Date: Mon, 8 Apr 2024 12:38:58 -0700
Message-ID: <CANDhNCp1YszKRcQ9Ea0EgO4Zdg+M9b4HZLMMMktKo0jXaAHArQ@mail.gmail.com>
Subject: Re: [RFC] thermal/core: Disable uevent messages for cooling devices
To: Roman Stratiienko <r.stratiienko@gmail.com>
Cc: linux-pm@vger.kernel.org, rafael@kernel.org, daniel.lezcano@linaro.org, 
	amitk@kernel.org, rui.zhang@intel.com, linux-kernel@vger.kernel.org, 
	megi@xff.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 8, 2024 at 12:03=E2=80=AFPM John Stultz <jstultz@google.com> wr=
ote:
>
> On Mon, Apr 8, 2024 at 11:59=E2=80=AFAM Roman Stratiienko
> <r.stratiienko@gmail.com> wrote:
> >
> > I haven't worked on it since I posted it initially. But it looks like
> > there's an alternative patch already upstreamed and backported into
> > stable:
> >
> > https://lore.kernel.org/linux-kernel/CAJZ5v0hHTuEXmQA=3D0D90eR_KUsOsfcx=
YbTS=3DzQYDTXuY6o_K_Q@mail.gmail.com/T/
>
> Ah! Many thanks for the link! I'll check in with folks to better
> understand if there is a functionality gap between what you submitted
> and what landed upstream.

Ah. Looks like it maybe hasn't landed in -stable yet.

Thanks again for the pointer!
-john

