Return-Path: <linux-pm+bounces-42488-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gBL7CCQzjGkAjAAAu9opvQ
	(envelope-from <linux-pm+bounces-42488-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 08:43:32 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA6F121EE9
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 08:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 13DA23005596
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 07:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0DE30EF89;
	Wed, 11 Feb 2026 07:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W6kdFowf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085C13EBF1D
	for <linux-pm@vger.kernel.org>; Wed, 11 Feb 2026 07:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770795808; cv=pass; b=awdR7ILmekrSj0Nkks5OLOiXKf0rvABa+ANatWUPIqc5Xkhp9P8JN499dq6A3XQTRwG2kPU1ft3awXfCByA9EaBP+j9XUcokIPwmuXOWh7L3lEynJ6GkePkgD6Tuy9rrK9iMPreJ6RPi12hjta5LXM7cuLMTEuokaCmgS53UdB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770795808; c=relaxed/simple;
	bh=+CdFnEZorIZHFEwjp1z+uksYgHluy5bUqY4uiOMDXg4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ao8nv+ViC5h4dhLjrFcse8/UCHALOEmws9d+MPzjn5YZ3spRFw0z47PKdt4+Wc3cqhlWUHntUQvtyh0/riwO/ImlwLdiIfsDpzgK9bjFg78XyweUgDCvGWoFASyB0pZrBXKqm0BTCZS1x+2H4PJ7mRZR7bxAajinNzOEiEi41YY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W6kdFowf; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-5036d7d14easo59993651cf.1
        for <linux-pm@vger.kernel.org>; Tue, 10 Feb 2026 23:43:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770795806; cv=none;
        d=google.com; s=arc-20240605;
        b=Izno2GggmOe2p2RtENBQvhI21x9usc25r9jNQDyOKavfqdJQ66cxMkeB+i1v2frkzN
         rBwXWH+L/A2FY0v28uVpRE00hPFaKIv+EQtUShtxHDi7Z6ujWb0rcTUU6Qc3QUFhmMcx
         +Dm92b/Th4+8B35/5tmPrvpFd80RqWwmZFozUJ9wQIPHTTIjSU9QT1o6hpf58NiXRsu6
         InAIbOxeUi9BxtFKQyO+gvor2hLAdQAA+HBDnPZFmla8GbM1j0Q6H5uLLr0acPFg/ZFZ
         E3nm47Bgo2H+EHoUGlfP14Hza+wiSMQe+Hhzq/pfjaqy2eLVxrcMvHJcYUmWx7R/vuv8
         Ii0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ipWQm9hmbqAY5gkf5rmXScVZaRp6KnP7ocvfdb/cjKw=;
        fh=faXmyK8es08Zhf65oXfE7uerrpaZYDA1ZnrqvN70iyQ=;
        b=UGJRExz/MjG5xwqloHVb4eujTk8dTlZmk6loVJ/Lcf56T8G6fTlrqPYlLj0LpUnPNR
         MI5yGB2ciXS306sC2lwrLP3Mi4VVNn3N0VMFa2D3Ybv4mXtww/H0ebGeMRetNTVn/zRm
         FDKVTad2aEU3KpkCadedj05OROSFehv+vHe5s593GdsZXd1Xtp1Z2MSaloY+u5qZofXc
         r1toJaGbfy5Bwk54J7+nlXcxXSx8wNWjxh1NcAruawwKkhD9EM/yU8pTM2XBPDR86tP4
         qgVA0ahknOCH+mpThpMQcIiJiNrb7liA8mxuFm23c1TeMPQg8bqiZjTfDa0utGp5T91n
         Ly4Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770795806; x=1771400606; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ipWQm9hmbqAY5gkf5rmXScVZaRp6KnP7ocvfdb/cjKw=;
        b=W6kdFowf/1m3+C9jQcYMYuKVs9MGZ52hhGQLXd2M293DOlpqxLaDqx0x7dfZL23vdt
         wOsivBTBdkQWWWPP3KqDoubxsIYfA5YBPKN59CSLJwkDQOQzYuyPdpj6kmKIZrKjImcf
         nRBPa8yJ82LeSYmsMg42xFPAnqZn0uWefbZy8cPXR2LUiS7ZxlrNYs3kHxIn/O/Q/IkY
         q1W9gNudnKW6a2GrasTdhkWy7CuhYxsz1kb0p39P095jOiQNSlC3QeW1DFselLgEvJ2w
         j5+zr5VabPD0GFLSkyzLtFdaUUVrCE846uVg1wPpVSNXHaSxpFrSD1ud6wdr/5+Fd0d8
         JYgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770795806; x=1771400606;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ipWQm9hmbqAY5gkf5rmXScVZaRp6KnP7ocvfdb/cjKw=;
        b=J//iM9bHrAtxxumpSP9ntRlxFwuGx0I94pw2hllJnp9bz9xyXQ2FzpIoo3VBqHUHYp
         PaVecwhD6dmXmDdyu+4Ee2Do6DUTu876E4eOL2Wf/Y4MTPkr3gLz94hx/Kud1xuc+Xcd
         o73ekrKv3PZmBx25DOQ0lw0JLypPnod/9XR01Ymv0q1Hy+xDzBJGjCauYy4T+jtc1W5O
         YVZlYWWjiu6LlijdpUZbVBsr9EI0aYi6c92D9vfGWlFeG+EAcPV3P88fmha+IC2TwlbW
         Tv9OMZegl0n/+5eRo1zf3MWE5ZJGXSMLAarnMP1nCNC+/YR4xeX8zYv+694Y3pO6OMZ5
         gKRA==
X-Forwarded-Encrypted: i=1; AJvYcCXBc/i1ykwRjsAM2zJZgqjSzrsHplEvbgeMpWHnVRIK0NbrVrCjX52hYTRa5kqMavRSlCukwDzLag==@vger.kernel.org
X-Gm-Message-State: AOJu0YzjYHi61BZ26Q+fwmNjWPGCJnZrnOKzxwMsAua2eHX2bS1vzH9l
	pU+g0jrQwSoL8ISzuNk2JIWr3mVPKRxQZIPQkbcAIhc+qCibx0vxu9uL21ONGHBdNTzZd0TNqVU
	TREpu4mpeg5u8N8URgMARYJuvaYUjKsc=
X-Gm-Gg: AZuq6aJpxT5pk3jFrQOPQtppO76R+ahq4Fng30OtqKgchzroRnNTzB9Joanl9vSaYeL
	rRG+shbt7tgLqR2CIUqvUrYdpAPssFQRSWf/iYRdWVUZtVvXVeDiL+Yoorob23zA4dEN3JEx91b
	e5/tUqk6RwAQnC94yWt+KAIIf1EU/R47lSYvulNO1oKSCowp2HxtV09v4XwSqdX0cskgY6Euuak
	Cqo9XseNhe1UNC6kds/fgMa625lC2YzlrwM4CyaClZlg8VFpbkcbtRlKo8wiqRYuVffhWDl9iof
	EBHXSLBs
X-Received: by 2002:ac8:5753:0:b0:506:1c3b:c8a3 with SMTP id
 d75a77b69052e-50681076e51mr26758531cf.27.1770795805924; Tue, 10 Feb 2026
 23:43:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119015803.183-1-xuewen.yan@unisoc.com> <CAB8ipk93vxpuSF3msuryedefJ8v_4ZMrk56MFaGp8+Mh-EqnSA@mail.gmail.com>
 <3aec2667-a62d-4a68-ba7d-bad7487dd0f7@arm.com>
In-Reply-To: <3aec2667-a62d-4a68-ba7d-bad7487dd0f7@arm.com>
From: Xuewen Yan <xuewen.yan94@gmail.com>
Date: Wed, 11 Feb 2026 15:43:15 +0800
X-Gm-Features: AZwV_QjVwMIBgUSZctQ8HyTvzBiiXKJl9tl-BiCWQfUb6WblUrpR9LAuudZD7t8
Message-ID: <CAB8ipk_+hF2tbLe-GXo_VEb+_xTPjYgx37XAWRvUxXpujZrRZg@mail.gmail.com>
Subject: Re: [RFC PATCH] thermal: power_allocator: Ignore cutoff when integral
 is less than zero
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: Xuewen Yan <xuewen.yan@unisoc.com>, rafael@kernel.org, daniel.lezcano@linaro.org, 
	rui.zhang@intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ke.wang@unisoc.com, jeson.gao@unisoc.com, di.shen@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42488-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xuewenyan94@gmail.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:email,mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,unisoc.com:email]
X-Rspamd-Queue-Id: BCA6F121EE9
X-Rspamd-Action: no action

On Mon, Feb 9, 2026 at 8:35=E2=80=AFPM Lukasz Luba <lukasz.luba@arm.com> wr=
ote:
>
> Hi Xuewen,
>
> On 1/26/26 03:24, Xuewen Yan wrote:
> > Hi lukasz,
> >
> > Do you have any comments on this patch?
>
> I missed that patch, my apologies.
>
> >
> > Thanks!
> >
> > On Mon, Jan 19, 2026 at 10:00=E2=80=AFAM Xuewen Yan <xuewen.yan@unisoc.=
com> wrote:
> >>
> >> From: Jeson Gao <jeson.gao@unisoc.com>
> >>
> >> The cutoff means threshold below which the error is no longer accumula=
ted.
> >> However, in some scenarios, this may cause performance degradation.
> >>
> >> For example:
> >> the control-temp is 85, the cutoff is 0 or other small value:
> >>
> >> If the current temperature frequently exceeds the set temperature,
> >> the negative integral will continuously accumulate.
> >> Over an extended period, this will result in a significantly
> >> large negative integral value, the positive integral can=E2=80=99t bui=
ld up
> >> because of the cutoff. This makes the power_range very low,
> >> even if the temperature is already under the control target.
> >>
> >> So, if the err_integral is negative, ignore the cutoff to force
> >> add the positive integral.
>
> The accumulated Integral in the PID works like that, so no surprise
> here (the math is correct). The Integral part tires to 'compensate'
> the previous 'mistakes', e.g. slow down the rapid change which
> has been seen and caused the overshoot.
>
> >>
> >> Co-developed-by: Di Shen <di.shen@unisoc.com>
> >> Signed-off-by: Di Shen <di.shen@unisoc.com>
> >> Signed-off-by: Jeson Gao <jeson.gao@unisoc.com>
> >> Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> >> ---
> >>   drivers/thermal/gov_power_allocator.c | 3 ++-
> >>   1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/g=
ov_power_allocator.c
> >> index 0d9f636c80f4..404ae1d75612 100644
> >> --- a/drivers/thermal/gov_power_allocator.c
> >> +++ b/drivers/thermal/gov_power_allocator.c
> >> @@ -263,7 +263,8 @@ static u32 pid_controller(struct thermal_zone_devi=
ce *tz,
> >>           */
> >>          i =3D mul_frac(tz->tzp->k_i, params->err_integral);
> >>
> >> -       if (err < int_to_frac(tz->tzp->integral_cutoff)) {
> >> +       if (err < int_to_frac(tz->tzp->integral_cutoff) ||
> >> +           (err > 0 && params->err_integral < 0)) {
> >>                  s64 i_next =3D i + mul_frac(tz->tzp->k_i, err);
> >>
> >>                  if (abs(i_next) < max_power_frac) {
> >> --
> >> 2.25.1
> >>
>
> Although, I might probably know where you're coming from and what you
> are trying to achieve (what is your platform's situation). Let me do
> some simulations based on what you've described. I will look into
> those signals in those conditions.
>
> At the moment, I'm a bit afraid about your proposed simple change
> and possible impact to other platforms.
> Let me do my research and come back.

Thank you very much for your reply! We would also be happy to
participate in testing your follow-up research. Thanks again!

BR

---
xuewen

>
> Thank you for reporting this issue!
>
> Regards,
> Lukasz

