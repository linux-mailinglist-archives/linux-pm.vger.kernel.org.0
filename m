Return-Path: <linux-pm+bounces-27501-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C04CAC08F3
	for <lists+linux-pm@lfdr.de>; Thu, 22 May 2025 11:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99F8A188C93A
	for <lists+linux-pm@lfdr.de>; Thu, 22 May 2025 09:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E94280321;
	Thu, 22 May 2025 09:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FCIR5Zow"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82EF19ABDE;
	Thu, 22 May 2025 09:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747907239; cv=none; b=ii/kC/O3SG9Nj0gRs0+HwvBzmaBPa5VaxEq00c7jqpECC+9wyoXDXlol7XGQNhylpiAR/3juvSZtUIFajBpB9TVssu/UN1KqDrCPfhquMq74PvOFwHSPi+7YBFNteZkBRKSRAxHIVo/GkLx7wCRHVLJqYfg/Q1irc9+wRTHzSVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747907239; c=relaxed/simple;
	bh=wPk4ppqhqv2VPlVT26EM2PkHrNSLSJCeGnRWlxBg7Rk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k3NbAkf4yTW0S111Jm4XobjpGCkwtcTzpvXXQIf8isGezXtAuwaGfMF1LLIGJjcnZFvIH53vDWgtXM2r7Op42AFeNKhYpeauN7EM4EpmYo4PgAeBXXfWLUBwO5a18r01VS7JSmecsmDe6sFno3BFASFR3lDWb8+7U9N6FhlWHdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FCIR5Zow; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CAC2C4CEE4;
	Thu, 22 May 2025 09:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747907237;
	bh=wPk4ppqhqv2VPlVT26EM2PkHrNSLSJCeGnRWlxBg7Rk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FCIR5ZowXZABtr+GqkpGFt4VxzB/wqaf2T8kdnoTKbL9IHDlFogYClH3XneW86das
	 E72mm1uKBFyTyp8LOWFXdrcJvjL+nfZEg/V4NY9jfRmLlZ/J2byM0me5SNYuIWTRpn
	 jt2Of3S3fh+CSuV10FF5PGpWacglQBKkFZEQaug/PdZBKn+FKGOB8zr5P+lx5QiMuX
	 GgVH9zePHbmZ5uPU22XxlXr68TOjLoV55UMz1/NhHmO0HVxJECVwjIfa0M3BlwNfW6
	 70jOhcLggwk0BrLHrbjKJh/kQHJalyX8zIi2pncbbFqhl/6IPVnqhRA7SKt2OjKWIi
	 HMs82u5f4nrPQ==
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3f8ae3ed8f4so5005190b6e.3;
        Thu, 22 May 2025 02:47:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWAurBNXusr889NPPPrFdLZoa9iRiwj6IHY3XWTonzRcfXpgMhj8TN0utMpZDzf3yuKvru20UQlIOg=@vger.kernel.org, AJvYcCWJh/Re0K0m+NVWP4r6AnzBz3ud4dT0nMURB9g4hLcHZE2cv7GWrWkFdiDEs05oVCwVk5f6IUqq/kMsWVq3@vger.kernel.org, AJvYcCWe0Dw91dwiWKKqeLL0uXVz1HyjjMHNI0v8nyzqyBAejI2UbzqLiBk0vbsinbFLiRBhn2oNTbEgbgY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmFTIkN1DmYsm5g84lWEMhYZsWsJkDfno9XZGaIooF6ivHIl4W
	rmskHtwgNEbPz8UBdDsB0G4p51/t3Hd/PhZZ2D72DeQ0oMnvD9SbZq9rFe8+JO6Mclwh0rD/nKf
	+IabsLrDZ/Vahq+nug6XVpKjB4jWI2+4=
X-Google-Smtp-Source: AGHT+IHqj6QSMl9Aw2ToZVsCr3PhfufkcskyUJbk05OX0Q2RQ3/40Slrwh7uo0rEXdISL7J7PqeZOJVJKZNg9Y4Glqg=
X-Received: by 2002:a05:6808:338a:b0:3f6:a9d4:b7e4 with SMTP id
 5614622812f47-404d86f3f18mr16853920b6e.20.1747907236480; Thu, 22 May 2025
 02:47:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250522-userspace-governor-doc-v1-1-c8a038e39084@sony.com> <15871c67-0d18-430f-935e-261b2cda855b@gmail.com>
In-Reply-To: <15871c67-0d18-430f-935e-261b2cda855b@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 22 May 2025 11:47:04 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gz3Y+RGqBf9E1hzq9rwfrryd98Xpk51DtLd-uck5y-rw@mail.gmail.com>
X-Gm-Features: AX0GCFuEkuL_MNkf6jCc8Tj-u2AdKArucmRgg0Lk2TB1xeDhvOGntl8-Xw66Wng
Message-ID: <CAJZ5v0gz3Y+RGqBf9E1hzq9rwfrryd98Xpk51DtLd-uck5y-rw@mail.gmail.com>
Subject: Re: [PATCH] cpufreq, docs: (userspace governor) add that actual freq
 is >= scaling_setspeed
To: Russell Haley <yumpusamongus@gmail.com>
Cc: Shashank Balaji <shashank.mahadasyam@sony.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Jonathan Corbet <corbet@lwn.net>, linux-pm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Shinya Takumi <shinya.takumi@sony.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 22, 2025 at 10:51=E2=80=AFAM Russell Haley <yumpusamongus@gmail=
.com> wrote:
>
>
> On 5/22/25 3:05 AM, Shashank Balaji wrote:
> > The userspace governor does not have the CPUFREQ_GOV_STRICT_TARGET flag=
, which
> > means the requested frequency may not strictly be followed. This is tru=
e in the
> > case of the intel_pstate driver with HWP enabled. When programming the
> > HWP_REQUEST MSR, the min_perf is set to `scaling_setspeed`, and the max=
_perf
> > is set to the policy's max. So, the hardware is free to increase the fr=
equency
> > beyond the requested frequency.
> >
> > This behaviour can be slightly surprising, given the current wording "a=
llows
> > userspace to set the CPU frequency". Hence, document this.
> >
>
> In my opinion, the documentation is correct, and it is the
> implementation in intel_pstate that is wrong. If the user wanted two
> separate knobs that control the minimum and maximum frequencies, they
> could leave intel_pstate in "active" mode and change scaling_min_freq
> and scaling_max_freq.
>
> If the user asks for the frequency to be set from userspace, the
> frequency had damn well better be set from userspace.

The userspace governor requests a frequency between policy->min and
policy->max on behalf of user space.  In intel_pstate this translates
to setting DESIRED_PERF to the requested value which is also the case
for the other governors.

There is no guarantee that the request will be granted by the
hardware, either way.

