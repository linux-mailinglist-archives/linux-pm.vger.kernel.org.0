Return-Path: <linux-pm+bounces-24496-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C557A709EF
	for <lists+linux-pm@lfdr.de>; Tue, 25 Mar 2025 20:06:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED7803A9116
	for <lists+linux-pm@lfdr.de>; Tue, 25 Mar 2025 19:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC3E1AE876;
	Tue, 25 Mar 2025 19:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gv68XKRw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1610E15E96;
	Tue, 25 Mar 2025 19:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742929244; cv=none; b=UoS/3DtahV6BJZC2VVuzgy60+2nA19gA4cfLMRwUeGAC3zkBiqsTM3XH+4Aha7mCj1KGvsHfFIdDSzJ5uFFeQ19UoN9NeAU25wHoZu/Fgp0VrzupQ898V/0l5YvnlzaZoWgDhpxiuzRJPARUAnZx3nqCbrmUk9v9VY1FVvoHsC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742929244; c=relaxed/simple;
	bh=ZpoJko3p4m03qrok6iCtBZzPC7kUT0DPMT6jgwjpz+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ks5LW3vVQwCw3n938KdsIFYId1eqeRSMTX+E8cG0CysG79CX/ac8hEL1oPqR40zjB92due1vmy6EInEB5qYuddEPw8J9SWbxGf2Y7OOTeIf3Fwcm0Xh1uV6C8JHo+C83dMY8zwwO2ySJFzZ8YZpPsuj+O+H+9GqMf5c1ZNBgaW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gv68XKRw; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4394a0c65fcso54157255e9.1;
        Tue, 25 Mar 2025 12:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742929241; x=1743534041; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZpoJko3p4m03qrok6iCtBZzPC7kUT0DPMT6jgwjpz+M=;
        b=Gv68XKRwqop4pzkKc9JlRdw2HwgjCUxJ728IdtYxiSaWSufWez/xjOYXbhyAo2RBe6
         oQ6tMm8pEfuhEf+ax1Jt7XH3ujtp5GGElDpyZdfdXMHHSPnUTTQF6TsNarDOpN98WXTg
         3Mne9WpBulGgNDgiRkKdIhUd7E9dlW6dEYXMbo47mQFVzspYHn8a/R8/4+M7ZdTa5PWR
         oWCRG4esW6kxtRFg5NxTIic2TSL1KqevjabugPH5NFMoEM0ba6Ov5yvi7DnCH6bll/qD
         0H3jxv3wIoVw2bIHgEs1DthGHpqlqaTzvM4YQGX5BY47bkWHv8h/meUNE4GoyANDvoqL
         OuAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742929241; x=1743534041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZpoJko3p4m03qrok6iCtBZzPC7kUT0DPMT6jgwjpz+M=;
        b=bBPvM/fS+Xqacy5/Zvb76+WH//nfRisti/UWKFki/PT9GZh5CyAnXqqKK9ul2pQGTx
         n7JODJwOeVptrKnZ5KdkXmXU0JsXBli2xJx9enncwt/VisCynd8d72om23ObF7PnPEvS
         FPan5OTyiq0wGxDt4HFnMdzskO0bGFxkO/2bJ8vbNZNlC7/7BVldruRVN4pZf9JxUMQt
         dd0t3ahHxtuusu5MMUXiKDXC+2u4bjv5VUNp+y+jxaW61fhtCo941UXUSi0xwdZKOKL/
         Q6T69ya3gQZhBZepmCk/scIVOxYUwXuI9HhlS6oevZtgMQpYQY0msWvnjbFkQ0tKfkd+
         ouPA==
X-Forwarded-Encrypted: i=1; AJvYcCUOkVSC6OJP1ivCNAESf3dyoTleIlp46V0Lz2OIjjCRWMjCmdo/KPz/v75xiwxZjwPJJYCuHUvq+24=@vger.kernel.org, AJvYcCUzX/PBpbxXEgp3RKo5LO6qkXsRaZS54TT8oMgSA/G6tqZueVFvfdf6mv5ssb9Ntt41qYtmvRg379I=@vger.kernel.org, AJvYcCVV46X4hUPHiG/G4suGxIbgp2RZ995/PGCnjVl+FCHtwYDdG/SKfThM6wpoKDgm/9ymlDcunNxfpMNIIfo=@vger.kernel.org, AJvYcCXkTvagOqLh6s0PEryWSIm4bDfph7XKE0k3VylNt+1mnM7u0BhyTRqB/veyherNsvocttvWJSOravMd9+pt@vger.kernel.org
X-Gm-Message-State: AOJu0YwD0mACV3RbNGziLreMlxAclIpvBBu3JWERAKQGOYtn14q5844e
	G8KXpPxGocuOG7xRT4c0Ih9D/r++bt4z6r2HewU0A/+Rd8F0diaJG0d+niyHOpNPV5vBU8Tg08h
	Sjfs2YuhOfQFR8TSKLkTTUXy4WGs=
X-Gm-Gg: ASbGncsnVJqfs18Kc3D5W0t/eJoAxNZWznyxwzul/7d+TCiwn981Gsgob0sloT4FwCB
	q60EYOjhtwIMd8PMTVI+R0RJOmhHuqlOqoOYtip3YDFmCqukAjjkwJ234j/004+NzW3AjDab/J8
	puOC6mGqWsPhou0q+O6+pxTpRng5k=
X-Google-Smtp-Source: AGHT+IEDc3tyF/hFbw4j068/Le/2Xa4I49R2ihKwn1SilHlKBN8C9u6EyQgv8p1bCiDJ+HvE0ISRQn0HPEZ6zk620RE=
X-Received: by 2002:a5d:6d0a:0:b0:391:306f:57de with SMTP id
 ffacd0b85a97d-3997f9405c4mr17108463f8f.45.1742929241148; Tue, 25 Mar 2025
 12:00:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250321095556.91425-1-clamor95@gmail.com> <20250321095556.91425-3-clamor95@gmail.com>
 <69024f13d296cf2127e7f4229d1e6ece@kernel.org>
In-Reply-To: <69024f13d296cf2127e7f4229d1e6ece@kernel.org>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 25 Mar 2025 21:00:30 +0200
X-Gm-Features: AQ5f1JoHj-5VGdi3sDjJ-Kr3rNBl5Ntlplq3pMlWWE5QBTFl7BLAfEiK3RB3B3s
Message-ID: <CAPVz0n2GYUjV_LojZKMzAGC5P8APC5G-A_ApinV=-_K5YoO0wA@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] drivers: clk: tegra: add DFLL support for Tegra 4
To: Stephen Boyd <sboyd@kernel.org>
Cc: Jonathan Hunter <jonathanh@nvidia.com>, Michael Turquette <mturquette@baylibre.com>, 
	Peter De Schrijver <pdeschrijver@nvidia.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Prashant Gaikwad <pgaikwad@nvidia.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>, 
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=B2=D1=82, 25 =D0=B1=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 20:56 Step=
hen Boyd <sboyd@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Quoting Svyatoslav Ryhel (2025-03-21 02:55:55)
> > Extend the Tegra124 driver to include DFLL configuration settings requi=
red
> > for Tegra114 compatibility.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
>
> Drive by nitpick. The subject should drop "drivers: " because it's
> implicit from "clk:".

If this is the only remark you have to this commit, I am happy to fix it ;)

