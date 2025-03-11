Return-Path: <linux-pm+bounces-23862-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E2FA5CB10
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 17:46:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98E4417ACCB
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 16:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A0826039E;
	Tue, 11 Mar 2025 16:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wiLgL5J8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DC125FA3B
	for <linux-pm@vger.kernel.org>; Tue, 11 Mar 2025 16:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741711555; cv=none; b=OQVUSk5kf29x9+pqg0G4FXADjpNQFXkp7EOOKu3bQQN+yUUbFkjV0EXcyfFGiooxNqOQZtQIaXY3Q+AEdgOFz+EVna1MRvkiGuE/c8S7dJReDJfBDRCUgVEP21xRpIc07G30gmW0qdFS85eENPQ4k7HUnJlEEiT+pf+qgXp9h8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741711555; c=relaxed/simple;
	bh=F/SWmgaOu+tEzDdMouioSKwxFeGYNsTosEe6TTUOtXs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fERGAK0/8KoqaVlmXEMtsGkYDpN2mmV3kx8F1T3EuMeFN6088tM6cEVhKXFwGkdGjq7EP90HuW/KOhdLi0b1nn9RCEXereLu8QXbhfFz+QROzn3vOFq2l2mA/yUJMDrjT76y0QgYLKirC5Sk+Bg6DtrenFuhL4jcOBbwCP2AIEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wiLgL5J8; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6feafc707d3so52753457b3.1
        for <linux-pm@vger.kernel.org>; Tue, 11 Mar 2025 09:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741711552; x=1742316352; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=F/SWmgaOu+tEzDdMouioSKwxFeGYNsTosEe6TTUOtXs=;
        b=wiLgL5J85KU/DwHZSo60140Ghb3xkdQa7E6ehVyZIsadI0EqZDgsixzaW+x9ja9TNq
         xNtZzqO9uPmCA6/RqISCHR3uF/agT6uHYMidUasyo5Do6NSoAtWVOSB40323tFZtWSEt
         kdIWuPNLB0eAhM73DCVJtBmRRbASG96B0qwVnPAwXg1n7jnmsmAPn1UnExgW2ovCHfyb
         hQG2omFAA4AwwHH2nRH8pvXD90svplgl/DVjqyEXhz5oVM8F+/qMfRgK+2qTGAvOF6Qy
         nwjM7kfRS+7k6EtJvTXJBk2ank7hyFKmxBU7+eFzi9Jj/gsyCYtPtYEKxdd5rxVzuprl
         GZ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741711552; x=1742316352;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F/SWmgaOu+tEzDdMouioSKwxFeGYNsTosEe6TTUOtXs=;
        b=Zy0mnj7UuTwGiTUW5YIckXn7+xjnb6rrvB2OBB/9kuaaR05z2NHxAhYqHzDAq/zYjo
         A7+/8rG49Bo3oFLMHOSw2AA1xALlR7EmWI43yjLBxYvGL3rdiBgtIRw9Bnv/QW6Ealng
         pPGiR210oEsVehcpAAOImK+k1YLuY51VJn+FMP0/FELlM070uz2b7dq+deE8w6FA7YKw
         +u9APBaJaULfwiF73iAvprWsIsXZPpSBJ040amMvFxyQFJFEaVwyxg52K2PvdIQCWeI1
         V/WIoEBeX5UmcxIeCbeeRi6GFTD+BlDUk2P4gBQ9C5dOgVdx6o22KtFsigWeiXS4MrzX
         MKzg==
X-Forwarded-Encrypted: i=1; AJvYcCXn5NLhKO2wERTZERZiEG7TOFcbVJ+WoL4ZK262kXqFZ7vwDMt+COxfhHR4gjeu/rxO0IT7DjHYHw==@vger.kernel.org
X-Gm-Message-State: AOJu0YylkIkgZnz+MxvUTQLrnZoJ7itKax+VRcDY5Gd0+i/HZO1bmbC+
	UGxkKh2uk65oNXAGREEXmDuVChXQi+Gxz3RGSI2ZqdZj6Cq2wm4deTAS2xXOLvs+d4ThsfqW+nz
	AiImho6R+j4zk0ytqBYMVNj3iLXzRTA97AY8KsQ==
X-Gm-Gg: ASbGncubnScG6CyjHEIh3BvLBdZ+rk87+BV0AxtB7F+FEPrOrcnTkKKEgSYYOnsMFHl
	+HM+TNvQeT2NEewiem6bZuLP2Y2un6Dgq0KH4yHxqL7TTpV24s5GowjZDBltuJBVVsFEeL10oib
	26G6z8Cl7J/GigpofrH/7IpnZt50Y=
X-Google-Smtp-Source: AGHT+IEo/dU7xJWP9UqIIVwynO6z0p618LVbgH8G9XQ04miJXT+3tW+2vCtdsEr/m8rbyTUjY548beOWZmklM9oPAoY=
X-Received: by 2002:a05:690c:3806:b0:6f9:7a3c:1fe with SMTP id
 00721157ae682-6ff0925ecb0mr56897737b3.23.1741711552512; Tue, 11 Mar 2025
 09:45:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <483602d6-4ac2-4785-b205-912b59fbd6f1@linaro.org>
In-Reply-To: <483602d6-4ac2-4785-b205-912b59fbd6f1@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 11 Mar 2025 17:45:16 +0100
X-Gm-Features: AQ5f1Jq5sVxtY5LipprKLDIaRWU6WcDQdbQdi_tZW7CvjYZ37ZpnZy93HQVPNzs
Message-ID: <CAPDyKFoHy9nqKwbHiHh7VC7Wz_Co1izQzg=O60DD7qLnnfbTYg@mail.gmail.com>
Subject: Re: TEO as default governor ?
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM mailing list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 11 Mar 2025 at 17:31, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
>
> Hi,
>
> I think we can agree the teo governor is better then the menu governor.
>
> Would it make sense to make the teo governor the default governor ?

In this regards, I just wanted to share that I have been working on
adding domain-idlestate-statistics to genpd to see how those are being
predicted/selected for a group of CPUs (aka CPU-cluster) - and
together with the cpuidle-psci-domain (PSCI OSI mode).

I will send out those patches for genpd shortly, it should help if
people want to run some tests at their side with these kind of
platforms.

Kind regards
Uffe

