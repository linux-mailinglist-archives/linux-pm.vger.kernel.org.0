Return-Path: <linux-pm+bounces-41954-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8FT7LdjQgWl1JwMAu9opvQ
	(envelope-from <linux-pm+bounces-41954-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 03 Feb 2026 11:41:28 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C92D7DE4
	for <lists+linux-pm@lfdr.de>; Tue, 03 Feb 2026 11:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9F8CF3021F58
	for <lists+linux-pm@lfdr.de>; Tue,  3 Feb 2026 10:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 085F031B805;
	Tue,  3 Feb 2026 10:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u9df9jAd"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B405318B8F
	for <linux-pm@vger.kernel.org>; Tue,  3 Feb 2026 10:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770115284; cv=pass; b=KtfBbrT+sGNqh0WWejMUOjnKqYLIBy46umV5jDJKESCJJ9c79LAXMkTiqQwWnWcW3FnmmSgD57U8SWjfSYNjpm2Oz1Zri8eezHYm4zxykDeESr75PK0PPmbDt3+C5p4YpMYF/0tb29gRnyhGySw2nBtViAuSVm9RU0OHvplVbQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770115284; c=relaxed/simple;
	bh=EZhZoolcVsnf21eiX4kAKedgHHgjheaIc5imb+clfpA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TdvaOiRN+8TshXPzmLC+XzM2CnI2SLDd0OU4Khtp3a62urqW4tIkjyu+pTHAwW6xe1YsuM81iMzkBt6XxooLdqUG1KKqaXV1zsdwstPzi2Xi9Y5AQyHShsatwrSfJl2ap6AOQ4JF5Vq6b6r/J2Wct+801nwaKcgMj4Z+VAgGZ5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=u9df9jAd; arc=pass smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-59e17afd2d5so5007360e87.3
        for <linux-pm@vger.kernel.org>; Tue, 03 Feb 2026 02:41:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770115281; cv=none;
        d=google.com; s=arc-20240605;
        b=duFi0EJgG2rZTP0/CFAZ25bbR8qLvMeBhrIPg6lNaNvKKQpfcqa59xvnG+VjWyj5zn
         uh9EvouMXBGhdTBCPkML+tAxYj8pe0QP/BWqL6uIGh/UCCsNYTAc3nqWVa23SZyRP9/k
         O/aQ/34iMr9221iHEYvtig2ZzYvecRZjqlZf/ob0B+WkcCH7RLjWs5/HxUKu2QBIfx+g
         tsH3UPV1zasBFiYH5EYmE4ks2vfxasA5Tej5gauMa/5lkthtZyZPau1aa/RF9gMW9VCe
         tEdergSNgwzqTsJ3AtQ0iuB5E7nlznpqcN/2i/oZtR4jLxUGcQUg+LeSM3CPsbver5VC
         KYyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=EZhZoolcVsnf21eiX4kAKedgHHgjheaIc5imb+clfpA=;
        fh=0zS0cFacW6sGoRgo1zo4u1O325HxEKFKebay5lKUtPU=;
        b=lN2uqfuu/ATqaCz24DPIXvzAKOqwK/qiooxJtJvgCpBlREahMpO3YI4MLq2zG40R+a
         PEqtwAIF4a5t+JvDAHIjaBvMRuQOtshmi4jo1h28zlmVDMgn6hCHY9acT2RLe7lzX1OR
         qrk3t3fXnemtO6zDb/9P9UdrXH7728LQHmckYaczOC5fx8vgE8Uv8EMxkG42Ja+dE/9b
         vg1qzDk+IUsfrR44LgJPUOj+oydqeAA+zwNSScNNm9+7FmeJ+Qj6T6pADVBQzr81DEgj
         wjHoNvDNnBFArzP4PRuvafoJx5v4m5JcC3YdfvyoqErDmUmz1Su8ThwPTwVtG8Au7EfF
         fW7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770115281; x=1770720081; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EZhZoolcVsnf21eiX4kAKedgHHgjheaIc5imb+clfpA=;
        b=u9df9jAd3ocwpNvTkerjq/5EwbpvelscXEhWSwC3ym80s8IjbgyHdQcqBp45X9nu4F
         NYiYPgWEx4f31cBTrYoFs0mdyAasZdSRvrSGXQx6fAsr6ikCHnpvjoQgP/nNWsE2SJwo
         yTfIIy7K2s35FAt3R959t8mjWSPYNXL1u2sMNnKKypKrwfPGRHk9vzGlihZ/vPEqpu8a
         kJzg9L3Xvo49f0c4ypDqDWW4hPmIy6mkoI/NefVKGICLNXwOEmhaapKDgO1AvB2v8d5E
         pRWPz16LCsYRVVFuNtLdietKnxRklo/lTYqOiCEWmeVFsTJ3Z+BFSR87ren4mP988TBd
         7eeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770115281; x=1770720081;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EZhZoolcVsnf21eiX4kAKedgHHgjheaIc5imb+clfpA=;
        b=g69M8k7zKZcYBsiWuj+u8SxK/R7HKLfBQdp8Lsui1z/jQxu+3v6/YAE/QvXCGwnZzR
         1HitJy2bLvOC57qz5xWMiqxSPBbdfm5mExqN1cwukpW1LH5cQ7S2FwSGXg7FO0xzM2jb
         X3Zj9X5PSfNwtW6Ul/6MnDA91F+HsKpcMPEwQatWfkqbT+PTHWono15NghIPy1TXEBu3
         IpUkYN6brAnrBqD9awwXXBNN/ghT+SY/jGidaJRWEDQ618EpSwCRpMZJvk+ImCPxS/0f
         /qZY6j9MdOFPfKly6cl1EGTI4UB+T6lZBit7nZwSSwLUvtabDL77TCY441CIxci9E6+t
         HTOg==
X-Forwarded-Encrypted: i=1; AJvYcCX8KwKBqLvhdq56BSHpLAdC3knMFct5vnPwkqX+LbeVmR4aV7B1UZyeo04l5s4mIkky5l/OGXPHyw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1jmiVLCJT4FYqq2+edjW7QGpiYZoidRbcsYOoWzQRn6XNdncq
	57FA7T075vSAi3PIogFsO5UbpL/dUz2qWFmAmBLPPSr252G8AtjjAuNeHWjCwM3cde8f5Y6KI3s
	RpMqvqTFQ8I1XsHobveQMFIgvsyZjp+kaenBxPMbM9A==
X-Gm-Gg: AZuq6aIV1+nEKydTkk3wStudTL4AwVbHtkIH6kOV7QhiREjV/TTzEMdAjOf2q4lfzuy
	jNSTafga1lQISk740FCrhGXt6i+OrWt9mljJPtMD87mNuIo706LpJ9XHfPBDC74V80cV/HaS+w1
	j6/KKPmfS+E+ZC9ZSNcQzf2CJxt9MPA1S4fNV+byH7RriCLLchpPue0QCgRBxVew6D6pjflUCsv
	gAbtD6iaVnTQv/FZI4329BdUFitDFbB5EtRK4h7dk2feiCnn+JJlsWHd8p5ISOlSMKK/niD
X-Received: by 2002:a05:6512:615:10b0:59e:1704:e0d3 with SMTP id
 2adb3069b0e04-59e1704e0edmr3493618e87.14.1770115281299; Tue, 03 Feb 2026
 02:41:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260201-iris-venus-fix-sm8250-v2-0-6f40d2605c89@oss.qualcomm.com>
 <CAPDyKFoNX087ZhLkQ_n8-42WNQcL06noSuPJPDG87y0andVdNg@mail.gmail.com>
 <CAO9ioeXkhxjghtGVGsOH=1hwC5FvS_4LEXt3hmAEuAbwVjct3g@mail.gmail.com> <l6o4lv2sy7x4g33mjigeh6sb6cmrfyz3xshhmbc3el6qvw3oep@okwpfykypawa>
In-Reply-To: <l6o4lv2sy7x4g33mjigeh6sb6cmrfyz3xshhmbc3el6qvw3oep@okwpfykypawa>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 3 Feb 2026 11:40:45 +0100
X-Gm-Features: AZwV_Qi-wgYVrdRqK589mxNzs1gxGV1Oudp9yxPTCOEtASkncTUH7LC0VHPXYJs
Message-ID: <CAPDyKFrX7NieYszgEZXFyQJr+PA266MJZTvJcGFmrQ2oy7Mj3A@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] media: qcom: iris/venus: fix power domain handling
 on SM8250
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Taniya Das <quic_tdas@quicinc.com>, Jonathan Marek <jonathan@marek.ca>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, "Bryan O'Donoghue" <bod@kernel.org>, 
	Vikash Garodia <vikash.garodia@oss.qualcomm.com>, 
	Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Stanimir Varbanov <stanimir.varbanov@linaro.org>, 
	Abhinav Kumar <abhinav.kumar@linux.dev>, Hans Verkuil <hverkuil@kernel.org>, 
	Stefan Schmidt <stefan.schmidt@linaro.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	"Bryan O'Donoghue" <bryan.odonoghue@linaro.org>, Dikshita Agarwal <dikshita@qti.qualcomm.com>, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-media@vger.kernel.org, 
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41954-lists,linux-pm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ulf.hansson@linaro.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[linaro.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pm,dt,huawei];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,mail.gmail.com:mid,linaro.org:email,linaro.org:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 69C92D7DE4
X-Rspamd-Action: no action

On Mon, 2 Feb 2026 at 20:22, Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:
>
> On Mon, Feb 02, 2026 at 05:51:16PM +0200, Dmitry Baryshkov wrote:
> > On Mon, 2 Feb 2026 at 16:46, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > >
> > > On Sun, 1 Feb 2026 at 11:49, Dmitry Baryshkov
> > > <dmitry.baryshkov@oss.qualcomm.com> wrote:
> > > >
> > > > As pointed out by Konrad during the review of SM8350 / SC8280XP
> > > > patchset, Iris aka Venus description has several flows. It doesn't scale
> > > > MMCX, the frequencies in the OPP table are wrong, etc.
> > > >
> > > > Let's correct the Iris/Venus enablement for SM8250 (unfortunately also
> > > > stopping it from being overclocked).
> > > >
> > > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > >
> > > Do you want me to pick up patch2 for v7.0 - or what do you suggest at
> > > this point?
> >
> > I'd prefer it if it is picked through the immutable tag/branch.
>
> Another option would be to ack merging it through the media tree.

I didn't think the series was considered as material for v7.0 as it's
getting late for that.

Anyway, I have queued patch2 to v7.0 and the patch is also available
to pull in via an immutable "core" branch in my pmdomain tree.

Kind regards
Uffe

