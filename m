Return-Path: <linux-pm+bounces-41773-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kESEH6GVfGkQNwIAu9opvQ
	(envelope-from <linux-pm+bounces-41773-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 12:27:29 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D33BA107
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 12:27:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BD559300A4C4
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 11:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103C935CBC4;
	Fri, 30 Jan 2026 11:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eacAcz6d"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CD5367F42
	for <linux-pm@vger.kernel.org>; Fri, 30 Jan 2026 11:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769772444; cv=pass; b=qMoXHCIhvUZCAGqn9zwbJjIiHOYdKHYkYsQSZ1YsZQFw1VK/amqUecJtnrvEL3gwfSM3la6ldM0LigJNC385UyrZeaqY2BpE+E4xyQd9ITsaCs09WeYG5SRU8c0XjQT+umvA/E2ptLJHnH+KGlmUS9i+guHKAzVmtqJ9GOUiNac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769772444; c=relaxed/simple;
	bh=pC6EqmS+EnGYe8Q5IuSOWCmBS0Js0/5aG8PXRBQ4GlM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JjoKlMKVal3FCSpGydPZVKw0vC9NZsbQv7RgdvA2cb9oudSXHxcja2DVQU2dZSXPg003DIAbLQ5R8Ge1iXpNEVhiqeQ1uyXDod+TfoSfmA04dVoxDEY5SZLYt8vMtxWNWydnDxDqm5zEInfTGfP6JyDMO0njSfTslx9Cb44Evb4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eacAcz6d; arc=pass smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-385e7cafef9so15492411fa.0
        for <linux-pm@vger.kernel.org>; Fri, 30 Jan 2026 03:27:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769772442; cv=none;
        d=google.com; s=arc-20240605;
        b=MqtbMmsmmu1cE6L3+F4+TH+tZGrdBcuCSAWv7YapqykiRVrlzdSWtendn8ITtWiSxT
         PNw3w9EFk0FJlJqpTgV9Eo2u1UYQDFyMnYUHIEHYI0IyGzpJmWfjl5IIpuiN5uY0UaT2
         ny9GslBO7C3yiGkbrwE899bZ5dvoAaiOcXV7+o6yxVDGrg1cjLA+sHU24yBMnODWgSgT
         CbP+PdLicyZMeiWkV1+ZOtrJOGH5jNKQtrouIjJsATjxQylubWozmIopZd0lKhtaEj3X
         Cy5jKdx/qybXOkDh6nhPhUZH47jSRPM4xDMUcV7rmKH6N1S/E9ybl4Mase5QN7WqSp+G
         A6pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=CTJuqQRZKV7ijK4EJjSamZFAm+pamffo2mFKEbOeye0=;
        fh=hEaSNYhLc6006zjaskylJ7kobNROz+C1hfl5oMvFeWc=;
        b=TNAJUkugRxlkVIzX8OYQrfSsI064WRK1fD+GE0uQDKiRycNOlFKaM6gxlTz/QmbIOK
         xzA1suwujR1OdVF13TA98O2H8rx8d0lfSttzlPhULwdV+yjajDnBrvUOgFZ7/u8cc7+e
         1Gtu6lP4mis8EZIUkq2TO5sr1C1qyzdxOx0H8nMNewUPByrDJKPItYPUOYzqA5ACRDYi
         duID0fK2Ts5Nujgvv+c2jl6FdE3OUep5afIrKU+o53/22hQ+M+bSmVSHqyeNezucOu2o
         lSbDMAlEZ8I3L0IH8NUoxAjdq/jVSbEZh71OM+gXYlUuDm2/vPadF6mPqKC7CH2QfuwV
         TMYw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769772442; x=1770377242; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CTJuqQRZKV7ijK4EJjSamZFAm+pamffo2mFKEbOeye0=;
        b=eacAcz6d5BiANL3HwUEFCEohpNeH5wEOJEJIPHVDsPSOtDh0XIn8arSwO1/AtKuXqE
         GmeIlTilKWKtFaC26Q4aq3vu2ysEZUt+zrHTK9jjXGtiZHw2kF1E0exK9mpziEpvU8yh
         8EWtKQicCCBPALi/wDsPxHI5H2nTuZAd3eqR6B6Y1c7raanZHLiMIfQ/yvKkuZYjS5KX
         OXnEBYUbJHZ5EuNxVV8ace6tagsUDtCmXPvxbtDM654SRpSY42+X3a6wsb/NGJqTWEUo
         WhnVW+Si6499mU0jJDT9f9bSWSscEYSLsQ9WfzLidFtcmpUcuZfrSV/DgJHgSa0/5WY5
         oPpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769772442; x=1770377242;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CTJuqQRZKV7ijK4EJjSamZFAm+pamffo2mFKEbOeye0=;
        b=npfcvLdFd35gP3X/mE011MPR/+IQPwu4irsbue0n1aKYOfedaZ1oeAV0xxTE5pZglw
         so0IhTMMA6OYCpYXjnZtdvzInKrXW9xJJIs7/q9dAKw1ukrL6oph9+sPb/7OIxXdKVY6
         TIufpoAYpKsAettTz53YnEqlkTu2t0+tBJgFcBTpuwq5jkfsRuJC2K8Ivr1RwxhrT5mg
         LQ7EMtDcgyar/BPlQXSyP5RJah7PG0k/8UZ5TYHw8BNH6evF2BeL4tlesu6OiZc/mB8d
         0SHmvNcKJDMuOPTZoDYYoNTW+v2TEOSXlNftcw8PnlFy7keYOEZFuqk86uBq7hDaLihY
         ZrHA==
X-Forwarded-Encrypted: i=1; AJvYcCW5edWdVexbAh/dD62zvTyH3hedSjLgdmfh+tPc8XFgNYUqfTSx3AZmC+F1apWuuhaDGjDe9NAqFQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9CDvXesQt4JLp7PHu1kvT3IQDwq2gobOUGC9k758vUE33xVdb
	SwGpkmOvER1mZFpf16YaYa/vDQF8GMZLsER2rOhtoMvP5JwWLwO9+J61gBKHQWoR6qaPSp6ezyi
	QsOZhHjpTmUMF+Dme8qhMKIkqZmJwl1zvD3SRGUtqOg==
X-Gm-Gg: AZuq6aILvIeWx1wwCb+c5wsStnttzz9bAL/gF9ZsKdxNIpPGPu8IvZrKGYs5OT78tkW
	iJP6unmAtmC6zddnQOnsxhtixT7VirgZjtCl4f3W2+VJ79dXsxzPe5diglNx7IufXnfEMxzlnu9
	/5MoIKpL2+NsyepUC5ZnUizfLI57VW6BB+d4nVDZJosU6XQIHa1E8+OazIgvtwdGUuTEi4Sh2nd
	vFr4pEQPWJ3J5yZXAEEECOtl0Di/eFOOqmBLog32cNPJYfkO4d84h+yMfgCwkH0O3qyak5hk1V+
	ceqZjbk=
X-Received: by 2002:a05:6512:1105:b0:59d:e714:fece with SMTP id
 2adb3069b0e04-59e164051d2mr838308e87.24.1769772441507; Fri, 30 Jan 2026
 03:27:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251211-rework-rpmhpd-rpmpd-v2-0-a5ec4028129f@oss.qualcomm.com> <CAPDyKFpCZyseq2XiQLfL+zHWjYZpS-4Wo56=W5AkBpdhajJxrQ@mail.gmail.com>
In-Reply-To: <CAPDyKFpCZyseq2XiQLfL+zHWjYZpS-4Wo56=W5AkBpdhajJxrQ@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 30 Jan 2026 12:26:45 +0100
X-Gm-Features: AZwV_Qho2KSeqV-UA771mqMAbX-CoeazXpNaSx_w79F053JQdWzkRlNIUDFeZ6I
Message-ID: <CAPDyKFpSgRkc_cPnX9uTfxB_xrOc6=gjy0+OaQr-outr_eeX8Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] pmdomain: qcom: sort out RPM power domain indices
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Bjorn Andersson <andersson@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41773-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linaro.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ulf.hansson@linaro.org,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: E0D33BA107
X-Rspamd-Action: no action

On Thu, 11 Dec 2025 at 12:41, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Thu, 11 Dec 2025 at 02:52, Dmitry Baryshkov
> <dmitry.baryshkov@oss.qualcomm.com> wrote:
> >
> > - Switch platforms to using bindings for RPM power domains controller
> >   where compatible
> >
> > - Drop now-unused binding indices for RPM platforms.
> >
> > Two last patch depend on first two patches and either should be merged
> > through the same tee, should be merged with the help of the immutable
> > branch or just merged in the next release.
>
> As soon as a couple of related changes [1] that are taken care of by
> Bjorn, has reached an 6.19-rc[n], I can pick the complete series and
> share it via an immutable branch. Let me know if you prefer another
> route.
>
> Kind regards
> Uffe

FYI, this one didn't make it for v7.0, please make a re-submit after
the merge window.

Kind regards
Uffe

>
> [1]
> https://lore.kernel.org/all/176499396490.224243.15580177530806530343.b4-ty@kernel.org/
>
>
>
> >
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > ---
> > Changes in v2:
> > - Rebased on linux-next, dropping merged patches.
> > - Split RPMh bindings patch to separate series.
> > - Link to v1: https://lore.kernel.org/r/20250718-rework-rpmhpd-rpmpd-v1-0-eedca108e540@oss.qualcomm.com
> >
> > ---
> > Dmitry Baryshkov (3):
> >       arm64: dts: qcom: dts: switch to RPMPD_* indices
> >       ARM: dts: qcom: dts: switch to RPMPD_* indices
> >       dt-bindings: power: qcom-rpmpd: drop compatibility defines
> >
> >  arch/arm/boot/dts/qcom/qcom-msm8226.dtsi |  4 +-
> >  arch/arm64/boot/dts/qcom/msm8916.dtsi    |  8 +--
> >  arch/arm64/boot/dts/qcom/msm8917.dtsi    | 10 ++--
> >  arch/arm64/boot/dts/qcom/msm8937.dtsi    | 12 ++---
> >  arch/arm64/boot/dts/qcom/msm8976.dtsi    |  4 +-
> >  arch/arm64/boot/dts/qcom/msm8998.dtsi    | 16 +++---
> >  arch/arm64/boot/dts/qcom/sdm630.dtsi     | 16 +++---
> >  arch/arm64/boot/dts/qcom/sdm660.dtsi     |  2 +-
> >  arch/arm64/boot/dts/qcom/sm6125.dtsi     | 12 ++---
> >  include/dt-bindings/power/qcom-rpmpd.h   | 88 --------------------------------
> >  10 files changed, 42 insertions(+), 130 deletions(-)
> > ---
> > base-commit: 008d3547aae5bc86fac3eda317489169c3fda112
> > change-id: 20250717-rework-rpmhpd-rpmpd-13352a10cbd5
> >
> > Best regards,
> > --
> > With best wishes
> > Dmitry
> >

