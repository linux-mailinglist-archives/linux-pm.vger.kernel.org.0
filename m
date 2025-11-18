Return-Path: <linux-pm+bounces-38158-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E5CA8C68ADD
	for <lists+linux-pm@lfdr.de>; Tue, 18 Nov 2025 11:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 05A4F354A64
	for <lists+linux-pm@lfdr.de>; Tue, 18 Nov 2025 10:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59F732D444;
	Tue, 18 Nov 2025 10:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wk6lLght"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD821314D0B
	for <linux-pm@vger.kernel.org>; Tue, 18 Nov 2025 10:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763460055; cv=none; b=u/aSl7Cgkk32jEDAuQnUoOOh6dE7vrecYxDDYdDhAOFIYaIQDtYIaJY+srG583t8DHx7WYbQ2MEAeWK7rwIXMWul+zyPSquGhlgdAmwLyYSXI4EpTL9OPatZPdIBME5MKaiJZ/U6Hws6DMpH/okk6EfBbAwtAfQbgWOTs115Ux8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763460055; c=relaxed/simple;
	bh=9S4xr4CYXwrWKuY4wbzgmhzYcQfMrKSokVjk5flBXMA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z0pqcNJBJd1u4r/fb+7/KprDCCH/OU4rwiGM/OCg4b6P02gx+MvBPM4HBYVXkBe96ZolPElHKhG5RKnFLYX31DXTQOitq9u4PLV1iJSJIyzAbPpK3dzLiNK77eE5o5x5jE+foRe0gsltL+9w8IUEF28KrJyZKKt27++zSexeM0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Wk6lLght; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b734fcbf1e3so796155766b.3
        for <linux-pm@vger.kernel.org>; Tue, 18 Nov 2025 02:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763460052; x=1764064852; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iywdmBD+VhwBMrcRtKZbSQ53n9WTzX5M1vRO8aphD6U=;
        b=Wk6lLghtjOpIYB+S7t405ctPtO9vs2i//Agi1wrpNKQXplyaO0SuSjCwSappfaKg/4
         GiZAi1eMug+Cb97C0b7sHO9JnJrXJlVGQ60DsoKypNSfMAgDfQ1PLpI63MQnVgZyhpp7
         cyNl0wv+rUMHJrlPxbfzMpLhORqRFVr3cxwBLpjP4eL2eLLby3xelQ0/4kDPH51/URb3
         oKS/TeTSBxs+DghosgzzIllxyWWrPFZtM4vB3cK0xPvkhHWOs/mDgKX+SSFesnu1L5DM
         b/FKbc6lEWIPNxn1oP7fCYn32xqbbl1/8XMdegfn0Vxw0kg8Iaqi7sOn7QM0aFhi4xj2
         jO8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763460052; x=1764064852;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iywdmBD+VhwBMrcRtKZbSQ53n9WTzX5M1vRO8aphD6U=;
        b=QlkTEReN/tjDeOzauz9N2iEeFk1O/fgfFr5FyUQDreyXbLZsswUGy14oBp4oLMddoO
         Pc5o2JB2nlyuWcxNTAiXbbPTBa/ElmomGqNYqmMpY1o0SAltMpTdlnWyJMASIOk5udna
         z5aCVD8/IQexyZ/TQHrWbl4+ZgUcegqF5ppM04rP+U2gbwR2BPCxFy9WWYS0OkYg84fJ
         SB0GRTK7TImnRBAFjIanynnuIDV+Gcn52zFFAyWDKLfUBa0L1jwJLuBYX6EQ+hCUCzfd
         d4+zHZt1jgqWOgPNMkf0E1xVjVPZRHgiTdbTqq6dpVmBmE9Gkp4Q9xdJPLdbXtVHzW6a
         dM1A==
X-Forwarded-Encrypted: i=1; AJvYcCVb+/ZOsgq297kthoyI3lPHzdT/TlwaMV1kFXi1LSmdtXfa14897fqAwoUnD8e7XSUET/UD+q46gw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5T892nG3gxL8W5wDXN0YepMl7EjFW8GoRshagRjaHEeVQ92Bk
	BO0aDtf5rQ7ztT9UkmK9bzNTDqMaU1eqMDHcvp4+uqr9b3DVuaNULXGlXPfaPp4r4S33GnF0D/r
	wSwTgblOojNIct1a8sT8Rho+RA1WbUY/iKjfrRNad0Q==
X-Gm-Gg: ASbGncuYFmrz9edRFBsDbPJRDNJQHf1rtWICo0lMWZL0g/W2496XcGDK+J7KrntYl8P
	wA9MDP+quFAyDrFTeWmomFyfQFL1oS+HZcPfVV+y4KjJYhF9SwnkcLfWT260Syb+7eJeVZerNfk
	efakPhpj2Y2iiRqM05q9/gYzd2ZTx8fo5uK6TZoSvXmc2hllpaqmawwR2tf5tY/Ir6ZUGEZP6RA
	a0wY7/GenNdRrkhwMvFiVbigoW09LjJX3SBjSqwATo+fDtdEvO+gwl8lRYPRssyX+rA/AwNINFB
	GnNhboTSWZIIIp69oiq7Vs8TF+NfUjYtfXMnQUusRqM06lc=
X-Google-Smtp-Source: AGHT+IG2y5/jZtH9NZI75FwdD1IDitkiskmgikS57draEL4ehsmgro80http+ADk/Q/LueOJWOb+8DfENaPkBLVEV3c=
X-Received: by 2002:a17:907:74c:b0:b73:7440:bd3a with SMTP id
 a640c23a62f3a-b737440c24dmr1394508266b.40.1763460050545; Tue, 18 Nov 2025
 02:00:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251116-next-15nov_expose_sysfs-v1-0-3b7880e5b40e@oss.qualcomm.com>
 <CACMJSeuiL5XEZjh8mOSj7tUnR8wEYSJ6FfZA87v8TSu8xM8_JA@mail.gmail.com> <8b6ba46d-ab64-dbc5-8f09-e810bdef724e@oss.qualcomm.com>
In-Reply-To: <8b6ba46d-ab64-dbc5-8f09-e810bdef724e@oss.qualcomm.com>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Tue, 18 Nov 2025 11:00:39 +0100
X-Gm-Features: AWmQ_bmhSGP4K1CxiqXDz_TEgywv29PzUmaZwkYmdhYOu1LMc2UdU6C8gQtEz1o
Message-ID: <CACMJSesPSt7LM2duVuBOToxL_5e=SQysW4T+hndMu1Ubs5oJwQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] reboot-mode: Expose sysfs for registered reboot modes
To: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Cc: Sebastian Reichel <sre@kernel.org>, Bjorn Andersson <andersson@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
	Sebastian Reichel <sebastian.reichel@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 17 Nov 2025 at 19:05, Shivendra Pratap
<shivendra.pratap@oss.qualcomm.com> wrote:
>
>
>
> On 11/17/2025 6:33 PM, Bartosz Golaszewski wrote:
> > On Sun, 16 Nov 2025 at 16:20, Shivendra Pratap
> > <shivendra.pratap@oss.qualcomm.com> wrote:
> >>
> >> The reboot-mode framework provides infrastructure for drivers that wan=
t
> >> to implement a userspace reboot command interface. However, there is
> >> currently no standardized way for userspace to discover the list of
> >> supported commands at runtime. This series introduces a sysfs interfac=
e
> >> in the reboot-mode framework to expose the list of supported reboot-mo=
de
> >> commands to userspace. This will enable userspace tools to query
> >> available reboot modes using the sysfs interface.
> >>
> >> Example:
> >>   cat /sys/class/reboot-mode/<driver-name>/reboot_modes
> >>
> >> The series consists of two patches:
> >>   1. power: reset: reboot-mode: Expose sysfs for registered reboot_mod=
es
> >>   2. Documentation: ABI: Add sysfs-class-reboot-mode-reboot_modes
> >>
> >> These patches were previously being reviewed as part of =E2=80=9Cvendo=
r resets
> >> for PSCI SYSTEM_RESET2=E2=80=9D, until v17. Following the suggestions =
from
> >> Bjorn, the reboot-mode sysfs patches have been split into a separate
> >> series here, for focused discussions and better alignment.
> >>
> >> Previous discussion on these patches:
> >> https://lore.kernel.org/all/20251109-arm-psci-system_reset2-vendor-reb=
oots-v17-5-46e085bca4cc@oss.qualcomm.com/
> >> https://lore.kernel.org/all/20251109-arm-psci-system_reset2-vendor-reb=
oots-v17-4-46e085bca4cc@oss.qualcomm.com/
> >>
> >
> > When doing a split like this, please keep the versioning going. This
> > should be v18.
>
> Focus of that original series was "Implementing vendor resets for PSCI SY=
STEM_RESET2".
> These two patches have been split out of that series. The original series=
 will
> still continue to its next version(v18) after addressing all other review=
s.
> So i thought that these two patches can be split out to v1?
>

No, they both continue at v18 so that the origin of this smaller
series is contained.

Bartosz

