Return-Path: <linux-pm+bounces-25318-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29731A86EC6
	for <lists+linux-pm@lfdr.de>; Sat, 12 Apr 2025 20:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DF4C1896352
	for <lists+linux-pm@lfdr.de>; Sat, 12 Apr 2025 18:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2847720298A;
	Sat, 12 Apr 2025 18:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fr2Uy2ZY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981411392;
	Sat, 12 Apr 2025 18:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744482744; cv=none; b=SOG7nEe573HTkfB2RrcbycWhmm/MLaIHS25/QnJbfOXNOTHu7J3Dye3gEMEh4tgzgnXb1fgyA0AlNvhhvNwwBk2Gwqmoy8r4Dnw6EeKTkfA15Fvyvs9RagwLwUnoV5vrT3WPyCHWfI8gVHtfEkweV/2Xkk+7Z5UQMRFxD1fY9Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744482744; c=relaxed/simple;
	bh=T3Qc1STNEB1yk7+zuWvJIvGi5r/g6z5PQsnptk7pOCk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LrqWB/LHduouMf9kpVQIfypv1070k64v6SWV0oj9Y3mvu8Y1z3OA5cpl2MTVHE+QkuTEho+6neelcY9YOTp2ShUR8dH2iS0Qohx55W3wvM4OR/zbNzxPQAw5PTb4beEy3YNuJk07toptP8WU8bM43oJ3ih83TiYubG7f5E/Kmsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fr2Uy2ZY; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5240d07fee1so81793e0c.1;
        Sat, 12 Apr 2025 11:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744482741; x=1745087541; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T3Qc1STNEB1yk7+zuWvJIvGi5r/g6z5PQsnptk7pOCk=;
        b=fr2Uy2ZY67DAzF3w4HYhxB62WBAwxBjsj4perDH3i432rJQaxgpUhGjKsFsZGkEzwY
         vOKyR/lUdyMUAO7ZZy7Lj+GbhNMLnsfX1wqMyD1d1hoQ/P8b64k3DfbL8SrhJGPaIm+X
         MSiKmAHngT41blDQ1hdI+/lR1bOQFcL8lQC/6cuFavKcNqP6wbJNcGBOi4Nfcy1ckjKf
         7fCUxQw3abvS4IAx0ZS67nv4QbHlX5s0lVpnFRhW06OZFRQsuVvMycAD5/zbRjOl9LZJ
         ASa4e67KZiLik8Q3qWVlPPd+hA+dIeTu0ztGZ3yMDYfyqmvhpe6deTl9QPYiiYWjSLIT
         VA+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744482741; x=1745087541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T3Qc1STNEB1yk7+zuWvJIvGi5r/g6z5PQsnptk7pOCk=;
        b=SrBG6EVI6Fx+N6ZGQxxz0Ncsj2yULWLip+ezBlfr9w5TxlmO/mdCoAA1r0qaKMvKhs
         1NjEuFDoKRdmGtklJI3Vj3gLmjvcYuKJAB5J29+zOrgjF9rbRk3b0JJA3lTzOXmQurxT
         iDCuYvdnPpEffIFIz8O2hRJNCWGW8bnvpacFT6HyoX0q1J2qwKCXbqDlcvGBPv2U1g/s
         fCbT7EmNpbFCly6e3LFky1t0SOXeHF5yaRi6IfgRr8v4fEGyNB8VQL5fqHSsh05SBAel
         VNYctn0+nWC+oQxw4LWyLDfxOdLQXh/433Q7effK83GloJzmHU/7b94vT7puEqCGce6+
         T83g==
X-Forwarded-Encrypted: i=1; AJvYcCVZpS70X7klWE2JWbHKu2n5NYmmxGjvvAR2QPwDekZYd99G5HnP3O1rOmvimoWoi1ElrIPPMgw6zrA=@vger.kernel.org, AJvYcCXFJrdubRAOjkAv0Zb49MZ35dJjv1dGvQRN274BNhIasblB6zOw0mGpWVJAGQD3p4wVgV10WoI98Q==@vger.kernel.org, AJvYcCXMZ2MXm0zBAk0HvsyPHcWbRCpfaBgOwNY15SbLexDOGHnOjel26Pj0Q0LPQ/SW8dJibGt2kxXio7AcZx1H@vger.kernel.org
X-Gm-Message-State: AOJu0YzbKQoXdSF1/jCa7XQJL65FqSHtUwTSbEaPEUe+7fqTV70grgtL
	Ipf894J5P4+eyo2fnAvCAJi1VRrULJ69CiP67asXbSamLnt/JbCRFjRFLa2bDzh10v9J8oWuJUj
	bAHPaGHepq7CfK9N25vDN1GXbSw==
X-Gm-Gg: ASbGncsXU390jboR007/yWXUmABxuWfw7CHF91/IQ2pAiQ04h1tMmOXxAs71BOqXqu4
	bvH7wKhhcYwS+2UilMVFgWzPBK0I4gdViKNbkZpaJRQyq+vQXNeb91G8I46xp8RD742vM+Tireb
	aZgmwvwL3tr92AzDnevxAzKvA=
X-Google-Smtp-Source: AGHT+IFCaLFGAxkVT2lKsAkCtftPnKhBh6OillpidkjEeNtDizhqaCJZ4mRNIO8IrtKoYG9vlpMmuPDQ1K3J4xbTIcg=
X-Received: by 2002:a05:6102:15a3:b0:4c4:e3d2:25c2 with SMTP id
 ada2fe7eead31-4c9e7836f75mr1550793137.6.1744482741062; Sat, 12 Apr 2025
 11:32:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250412180831.3252963-1-chenyuan0y@gmail.com> <0081fcd8-da99-47b2-b136-3ea04232046a@stanley.mountain>
In-Reply-To: <0081fcd8-da99-47b2-b136-3ea04232046a@stanley.mountain>
From: Chenyuan Yang <chenyuan0y@gmail.com>
Date: Sat, 12 Apr 2025 13:32:10 -0500
X-Gm-Features: ATxdqUFVNadBq9M9pZcwFONeYCEW6qDbC52ykl-YedCykxT8ppzW_PXwHA1Fxys
Message-ID: <CALGdzurRtHLOokUH7GOhmkDkzBioDFt1iJ19eSbrjyeWW7p4KA@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: scmi: Fix possible null pointer dereference
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: sudeep.holla@arm.com, cristian.marussi@arm.com, rafael@kernel.org, 
	viresh.kumar@linaro.org, arm-scmi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 12, 2025 at 1:31=E2=80=AFPM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
>
> On Sat, Apr 12, 2025 at 01:08:31PM -0500, Chenyuan Yang wrote:
> > Check if policy is NULL before dereferencing it.
> >
> > This is similar to the commit cf7de25878a1
> > ("cppc_cpufreq: Fix possible null pointer dereference").
> >
> > This is found by our static analysis tool KNighter.
> >
> > Signed-off-by: Chenyuan Yang <chenyuan0y@gmail.com>
> > Fixes: 99d6bdf33877 ("cpufreq: add support for CPU DVFS based on SCMI m=
essage protocol")
>
> Henry Martin already fixed this in commit 484d3f15cc6c ("cpufreq: scmi:
> Fix null-ptr-deref in scmi_cpufreq_get_rate()").

Thanks so much for pointing this out!
It is good to hear that there is already a fix.

> regards,
> dan carpenter

-Chenyuan

