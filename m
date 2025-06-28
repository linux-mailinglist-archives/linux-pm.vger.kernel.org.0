Return-Path: <linux-pm+bounces-29788-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41191AECA9A
	for <lists+linux-pm@lfdr.de>; Sun, 29 Jun 2025 00:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 723D2172753
	for <lists+linux-pm@lfdr.de>; Sat, 28 Jun 2025 22:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105C423D2A0;
	Sat, 28 Jun 2025 22:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atero-ai.20230601.gappssmtp.com header.i=@atero-ai.20230601.gappssmtp.com header.b="JornGeAG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711E4220698
	for <linux-pm@vger.kernel.org>; Sat, 28 Jun 2025 22:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751148785; cv=none; b=Jn18f8t9uYurKGXYSbvq2b6OO3sSuUeremVXlMuUVzt33LImAkfCYwmLWer6Txd9sbaHtQExcbUg5QfTCvlREvKQ6sK9/iZ2thvIQCOd2jiLDoeh8ptz8GoBm5J7SLykRelFl1SQS1S4Tbw3nLWlr/qfbCMGOXQCrqCOm+WMQhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751148785; c=relaxed/simple;
	bh=4hIoRo/BUe44/U6WOEvGpQ6TzxbhSycnGnHZnPeiuxw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nJN+UUSqEHs0dkoLYr7jJcyFWIGRIC5NvCHte1IzzJhKJS5XYWT4zPAJJr5LPPgwcT3KuCnFunCs3ty2CWGp7cnXRkV/+TbpdXNpoBCSQEOq8LLE8YUdodSgQar2T9fhvG/KyArCY3Z+kBMrv3eZS4Uj3YwA3zVju+GE86piwS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=atero.ai; spf=pass smtp.mailfrom=atero.ai; dkim=pass (2048-bit key) header.d=atero-ai.20230601.gappssmtp.com header.i=@atero-ai.20230601.gappssmtp.com header.b=JornGeAG; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=atero.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atero.ai
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e733a6ff491so787792276.2
        for <linux-pm@vger.kernel.org>; Sat, 28 Jun 2025 15:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atero-ai.20230601.gappssmtp.com; s=20230601; t=1751148782; x=1751753582; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pG0Jf3AyAuPPLWWO8w92wLQs80Toybr3R2SUNpvAU3s=;
        b=JornGeAGRFCFIZA8nfxooZmGGi0dL4DlXy1++S/NqKp/VM2aSAhoS3rmm9RSrywob6
         /NULLDBEppbz6jUhkqSZcFKsmKifVXIUuViOTaUENtsuprg/BXolyLuc53rtwXDwf0fC
         +E1vs4IdLB0fqxWz1beKbCm/1TmQz0MrLHI0dUxuqmTHjmDP993X+0VYtkxSrT6PWxAA
         5QNpKmBLQC0RRqpI6T1ZpCjGjJPPGh5Vwc+o6Dhp4BcayJtJUqt7WGcVbSo61qFejsRV
         R+zHfm2hR7cxYON2cvQ2mmCenazbbMcXdz1S2SR+nxnce4rmkXLya8o8Car7Z98PPMZL
         Mf9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751148782; x=1751753582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pG0Jf3AyAuPPLWWO8w92wLQs80Toybr3R2SUNpvAU3s=;
        b=iF20++SEnsfi/XCQ0seT1ItKHonbPOc7WJ2V0H2owooye9K+nw3d/5LVCYBKDSAw6S
         e4AbajyO0iqNbTYEloUTfc++CyBTBJ6C/z9Td4Xf8FMYDB+NcxjK/Fy2s0a421RmapnE
         5mPs3uKudEkSlyC1YMxFU+t+iLT+ZxnjBBWg6h6DQimkYm+chFVY2vJAc9n+Qxq2Ufo7
         E8cRuvKOPp/9Rd89Qpi4uwKjKkq4Ba0aIOwedr0m8tdipf9t8+tMuQc2vjHA8S7YzKW3
         JjxIPoec25bKSKXZpYq7VCnLPo6Hdq03iZEpsbpF7XKBekAlVtXd+0146CDV+jPTzvIj
         C+7g==
X-Forwarded-Encrypted: i=1; AJvYcCVxVic0yYTOkl8A3X99XDci7WyFpLw7LV+tddjvTCIv3gCHzWG7lkVAYLnnWHAoNssVLecgjTVgzQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzIpV5JbvL+RbogpRQZmUzDkbaFX3j5vCZl97QtyDCMI8KrpQkV
	DI9uaVv7WejyEki/YK8D4NSAWCqw6LaqLfryt9fPD4ILF3jeYxIxGwWIXVALaxuMgxhjP3rxQ4c
	vHyOb9UeBCl+qB+2hk+K8qD96nGzXrEInHVVEKfAqBA==
X-Gm-Gg: ASbGncth0Aw8jQwSFj62ke9yOQEJ3kzTD+BsnzeC6nMiCcVkUnettSbbc0LazBUlyvg
	dkhicK6+pGkGHfYCF+iTjWhygMI3C+rGtPw9o8jw37xdUn30vZvk86Ckyi5pbPBM17AijNxFqAa
	IhTmfuALS5lfyvoyFNyuFP7BoOQmNHQ0LL988kCtztI37R
X-Google-Smtp-Source: AGHT+IGmZPJroRvvxHKmgN9a0X1tAnR5pbdtgYaEXaOTqCbeF41sWs4hBEm9ibaXTwBW1beTqacoRcXW+Uum57AXsr0=
X-Received: by 2002:a05:690c:a0a4:10b0:714:4e0:ba42 with SMTP id
 00721157ae682-7151714574fmr86419067b3.1.1751148782373; Sat, 28 Jun 2025
 15:13:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250618231632.113471-1-sivany32@gmail.com> <CAJZ5v0jXPten8QwruK_Dqzvc0izLCfecMPBWMMoP8cnG4mDY0Q@mail.gmail.com>
In-Reply-To: <CAJZ5v0jXPten8QwruK_Dqzvc0izLCfecMPBWMMoP8cnG4mDY0Q@mail.gmail.com>
From: Elazar Leibovich <elazarl@atero.ai>
Date: Sun, 29 Jun 2025 01:12:51 +0300
X-Gm-Features: Ac12FXz7nWMf_ruYnnpMIxVSTL1Pb61zrmsTZHgUhqpM3MMbLMfc5P52r-Ru3vw
Message-ID: <CAFcvxdMozCv1mJFKemQKhOnZPLpfkWs3d97bHUijRdw7MdFO1w@mail.gmail.com>
Subject: Re: [PATCH] powercap: dtpm_cpu: Fix NULL pointer dereference race
 during CPU offlining
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Sivan Zohar-Kotzer <sivany32@gmail.com>, Daniel Lezcano <daniel.lezcano@kernel.org>, elazarl@gmail.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 27, 2025 at 11:07=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.o=
rg> wrote:
> > * DTPM power calculations are triggered (e.g., via sysfs reads) while C=
PU is online
> > * The CPU goes offline during the calculation, before em_cpu_get() is c=
alled
> > * em_cpu_get() now returns NULL since the energy model was unregistered
>
> But energy models for CPUs are never unregistered.
>

Can't the following happen (extremely rare, but still):

CPU gets set to impossible during shutdown sequence, e.g.

// arch/alpha/kernel/process.c
common_shutdown_1(void *generic_ptr)
...
        set_cpu_possible(boot_cpuid, false);

Just before `get_cpu_device` is called by `em_cpu_get`.
Then `get_cpu_device` returns NULL for impossible CPU, causing
`em_cpu_get` to return NULL.

It's not a common scenario, but it seems NULL checking doesn't cost much,
and can assure us no rare case is crashing the system.

