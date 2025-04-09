Return-Path: <linux-pm+bounces-25010-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A062A82520
	for <lists+linux-pm@lfdr.de>; Wed,  9 Apr 2025 14:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59469442E5F
	for <lists+linux-pm@lfdr.de>; Wed,  9 Apr 2025 12:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D7125EFB7;
	Wed,  9 Apr 2025 12:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ITZ7WTs3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f193.google.com (mail-lj1-f193.google.com [209.85.208.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2232725A2C7;
	Wed,  9 Apr 2025 12:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744202430; cv=none; b=a4ohYf/7F8gES6NkURHtOahobu+gEav1Tx2oQgfccRZURbkWwqjQ32ZYiN+1uMVn8vT+vjy6Vj6fMRUd3NSrqQRvr12sTPw4nX3I4AYEp+0f2kQJ+lu2mLJUU6ByzcYOSP2I8ltmA0DY/MroHqJ+3T5Y6b3iwQzQ70Xof0RrNrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744202430; c=relaxed/simple;
	bh=MgzTuHYI4UmC3fqcBItcn74v49a1rM9SvhzQvrF6Hss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kDuUYVabTtBe1y4ZCMigpYnCbFQYVFnQh3M0YrSvalE5YqklQEfo3tmWC3SoN+msZXj3JVSDL23zppgEMGWu8ujar/hghxVq5+OApFgWiGiAWkx1V/kHbDtpzG4oi8nIY9/ixvkeDP4+7XyS86gUYFla0RE4PP68rIhQ7VI9Q2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ITZ7WTs3; arc=none smtp.client-ip=209.85.208.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f193.google.com with SMTP id 38308e7fff4ca-30bfc8faef9so63153941fa.1;
        Wed, 09 Apr 2025 05:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744202427; x=1744807227; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MgzTuHYI4UmC3fqcBItcn74v49a1rM9SvhzQvrF6Hss=;
        b=ITZ7WTs3WNt/Ywh28L97Ulyvxb3RlYF7IJBD2VHs+4lCc/OjwR8wcBUEOhRhA5U8mS
         LR+MxGDCtSxO5xKYJFQxsbzHu4uwklfnSYsLQUh1edS6LKsvdTQilYBWUx2wGHehblGv
         Wph+HukaBJ6K8Nx2O45qt2b8U/VFkkyGQvpDfIVyuGMEaMv+RyzQhCBo/3G8V2RNtNwL
         W0Wu7ays+mN/Fn0GwjNJVVRSN14zF5kuRoW8axfc9igzXSgq2kSuYO47vBObtTc//Y+E
         uh7ol4MN9bG6F9DlkFqKxlzEe/xYSISlcvEcRWClkIXGeBvTCoIqWwjmZtw7mIdZkFf0
         sheA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744202427; x=1744807227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MgzTuHYI4UmC3fqcBItcn74v49a1rM9SvhzQvrF6Hss=;
        b=N/3Os1GyAnhZ3OHKci5aUDuqcdW7rt0eZVtA6YbYePiZcyKbuoxaEMi3YcdWkmPKfJ
         0GPs/pOz93RFd5psxD7AoQ1q0c+xsHyVk8ekGAhy1K1MSQ4rHVkoDJtEaBhqpN8HkwzY
         Usq6fElHWe5z13acUONERIqWyBJWfM3ldxexpmnc08WBYY5Izx0Wbwb6Kbuuex/034+2
         WTa58quO62nCr6g6lcQgLwz+iTyKRVIBSC8usC/w4JKn9pF8zL4D77TPj2yjG+twrpHN
         Ac8jbHLj1rwljClk+Ce/78AlWLgM3Fz5Rl5JT7Q46mThDs+H4Iw5LLsI8XRzxNys4Xs1
         EuQw==
X-Forwarded-Encrypted: i=1; AJvYcCU0JH76iElIYIbT5k+OehIEt8j68IEMZrQ1OtFHqch5bpmALPYWHNlQX0BDqEA1FpLQPd9pSR/oipQ=@vger.kernel.org, AJvYcCWMrI3lprd7rHvjd6BZrG3/OeIdzrouk4FnsOL6BKlvvKp/ysWnlSl63tneU99eswsEuFLhBgCrcXi9CHlJ@vger.kernel.org, AJvYcCWPgt4RuikO6V4LMjw0C4GM21P6znzkk6KDTAG823IIrTNsD43clng420R9YMZ1MNYQW/YP/MexIA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1AcEu+KvvLQ2oBWXkEcU49Ok0pbak6zrtO3S1eb0Jtd06sOio
	/VJ2uiPbjw2Meivb1i60haFZf6jAsX4i+rZ/dM34y105LlrBD8ivba59dOf3ATOh7Ee+b2aLsG4
	eb+lVdvy/Zvvj8k4Z9tlc5uDB5+c=
X-Gm-Gg: ASbGncvph8Pqb0LRWhLtUMsK1GVCh8ewKi04SOPkRVvnYjpnrtz5zz7C6HwhPuVSFmQ
	Uo2cpwS28gQxqfshlRjJfMP9cStrx+NHDLJJikjfWO5dsmnWRbAXr6BRXj2SO5s32NlTBbG3y/a
	67atejNvJDdi98wZ5wqTsmbw==
X-Google-Smtp-Source: AGHT+IEaNKg3tEK+ftLM1o2sum0aaJx+lvdbNATu/ADIsB6bKVblLteROIO/hxkPHNChjpDjGBoqBy7PxCbTeETlzVM=
X-Received: by 2002:a05:651c:2220:b0:30d:e104:a943 with SMTP id
 38308e7fff4ca-30f4507af4cmr7485621fa.39.1744202426703; Wed, 09 Apr 2025
 05:40:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250408150354.104532-1-bsdhenrymartin@gmail.com> <20250409-manipulative-tall-alligator-5e6c4a@sudeepholla>
In-Reply-To: <20250409-manipulative-tall-alligator-5e6c4a@sudeepholla>
From: henry martin <bsdhenrymartin@gmail.com>
Date: Wed, 9 Apr 2025 20:40:15 +0800
X-Gm-Features: ATxdqUFPmZ6qtNKORMOownapcwDPbW_QqjjVvOf8Je_dGx5LIfMAlL8dMmVUm2A
Message-ID: <CAEnQdOpS8xETvQE-TuyffDXCcNDa7jNCefpjR2MNX18xAx-WOQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] cpufreq: scmi/scpi: Fix NULL pointer dereference
 in get_rate()
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: cristian.marussi@arm.com, rafael@kernel.org, viresh.kumar@linaro.org, 
	arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> I think unlikely is needed even in this patch[1] and thats what Viresh
> meant when he mention all similar changes under one series and consistent
> change.
Thanks for reviewing. I'll send v2 of patch[1] soon.

Sudeep Holla <sudeep.holla@arm.com> =E4=BA=8E2025=E5=B9=B44=E6=9C=889=E6=97=
=A5=E5=91=A8=E4=B8=89 19:30=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Apr 08, 2025 at 11:03:52PM +0800, Henry Martin wrote:
> > This series fixes potential NULL pointer dereferences in scmi_cpufreq_g=
et_rate()
> > and scpi_cpufreq_get_rate() when cpufreq_cpu_get_raw() returns NULL.
> >
>
> Acked-by: Sudeep Holla <sudeep.holla@arm.com>
>
> I think unlikely is needed even in this patch[1] and thats what Viresh
> meant when he mention all similar changes under one series and consistent
> change.
>
> Also I just happened to notice similar patches posted while ago[2][3].
> Not sure how to handle the situation though.
>
> --
> Regards,
> Sudeep
>
> [1] https://lore.kernel.org/all/20250405061927.75485-1-bsdhenrymartin@gma=
il.com/
> [2] https://lore.kernel.org/all/20241230093159.258813-1-hanchunchao@inspu=
r.com
> [3] https://lore.kernel.org/all/20241230090137.243825-1-hanchunchao@inspu=
r.com

