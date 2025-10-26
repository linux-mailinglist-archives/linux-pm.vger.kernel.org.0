Return-Path: <linux-pm+bounces-36837-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD30C0A4B8
	for <lists+linux-pm@lfdr.de>; Sun, 26 Oct 2025 09:37:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A96318A0709
	for <lists+linux-pm@lfdr.de>; Sun, 26 Oct 2025 08:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEEEC23C38C;
	Sun, 26 Oct 2025 08:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZhivO7wz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6442E1A9FB8
	for <linux-pm@vger.kernel.org>; Sun, 26 Oct 2025 08:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761467863; cv=none; b=ss7HZpBytbUEEf9FU9EpezVaD8IHgB7bd4NfI3xK/RcoL9ujaddEsNbosjN1Pu5d1FQC8us5jPsZfRBFuv54+ZOjvtrhckLkKVu5z6h77Jy/b4Z3DmjetjpO6xmdNnXSSyWcfTIl6dfIY6wTJREw4GaiAt+Z082xgQFAV2ZXllo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761467863; c=relaxed/simple;
	bh=w467O+L55fOeLsepwJkIOKiqvTnDbF1E2q9UHqLXp9A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hi6zLVerCALZNX+nvvjmrPc4Bpadt/8byLhXKpW+OosbNfvLbzSAuD2mJiSp3tgHVGbVk8RAJncjsltzJ1JjGyNAskJjMkN38eBXLH9KGooT4ru9luaikwmaq8X/Ia4hioJBijR9GO3TCvnGYldWHkg/NwB75mpGlo2abYypqhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZhivO7wz; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7832691f86cso48568357b3.1
        for <linux-pm@vger.kernel.org>; Sun, 26 Oct 2025 01:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761467861; x=1762072661; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3B2YCjT0fh+UhVXmU6Tftcslg67rIdAnaclE2h1Mnf0=;
        b=ZhivO7wz5jd0UbuoCSuOPIO+9UD2VRT3q9Rv+oDvo+ewnXZ40lvcUgcM2NOpvSFKhb
         gSj0i2gX6snLg3ha4EaySkjbweDiTUbMn134EE6DDl0yNymIDWEYJj8pMxjz29fW/u4m
         MF1Qyzrq/oQbUhnMuFlRbqkhnyFXBS9mYJGlqtg6fbo7Qp9BxSczngrti5k7d/sMsYXk
         B5Fje32Eu3NrVzSUn22ThNu21yu0PD3GN9NlQcNGHGnld3U0DoFhf9G+YbWuywD7yAaV
         tG706opddz2/inxp9s2N4PnsabWcdInKx/By0YpkNFAG4XtTOEsXY7/ZOScDl8DycfLO
         /25w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761467861; x=1762072661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3B2YCjT0fh+UhVXmU6Tftcslg67rIdAnaclE2h1Mnf0=;
        b=rZFrW9UFAamRxJrU2a9XuDA+6nS1jykgrt3ZNbQkHZAV3eTf3Uz7N1aP6NiVGzUJbd
         atejrT+qsJR5ruEWkdGatv32Q1gQPS0yk104hMUjUa7NRUM+Kf9KN08z1PNCbYO0tX/8
         O7spn4y4+RiN5qhqhoBGz1nOW9TZwW4t+nXc4QK4W358o9JOygMKUETD19VehQAh/E8c
         M1lLRewyOFkVW1SipbME7HmTwcF2FX+EIM5ynn/9iOvEM9ztwZl3aR/4bTVleFrcZf1v
         +/jbypj6UmQtFlarR3LNKt+4lZEWOaC4rtINoVUeaIz6Tzyn5cZUIWBrOx61WdZRK97B
         vSLA==
X-Forwarded-Encrypted: i=1; AJvYcCU65vbw7qR8SgnuUSi88fsv3qL40HtpicOYAm2U3YJpKgrl0TRqA3vNpmmMuBrxeiydKLXqDvmvaQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwzIJplC11rXJPNOlzInLKO+z8R3kXfU3DBpXuvUYp2pTP9NHx2
	4Zf446sZ3v+BOyPJ/2PShk2Rd7Aw9YoFqS6cNjnwQGjXV4ayZjCKF87BXTKfRiyQXyGtVsqQBZJ
	xBrXvPKz3IQ285SdhiWR/ICW0ik6Rp03qs1Jx
X-Gm-Gg: ASbGnctPfvkXjkYeNNjJfEajvakERMb/cc4Uy/FDaAe8j0TmruPfjHkp1zZip9GQ1Pt
	QOyiaPXj9RvHlLldcclYhH5ISIkke/1bSgdd3y+MzjxA/CVmKhoTtLdLD6sropEYRCSNG0ZnaNM
	0LVaBor+1JcWV42nlawKIAZzRSgjWdMcJaje3GNQbbL0A5ZUuUqGkpK5Nxq4mbZXnyv/okErPos
	uEiSqMXykkin723eGNp9TYoQBC2T4VhbfhoucHJ3egtEFe9h6BHrT5As4LzeDRk
X-Google-Smtp-Source: AGHT+IGse1ucBcCKBH2vCyjLvDKjtuRFs/t0gyJbHD5rpGMiQkverFP0dVowyAhvUv2k5cWZkzzoX/BieobHpyEIuqk=
X-Received: by 2002:a05:690e:120b:b0:63f:556b:5b7 with SMTP id
 956f58d0204a3-63f556b0680mr1856626d50.15.1761467861249; Sun, 26 Oct 2025
 01:37:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251026033115.436448-1-superm1@kernel.org>
In-Reply-To: <20251026033115.436448-1-superm1@kernel.org>
From: Askar Safin <safinaskar@gmail.com>
Date: Sun, 26 Oct 2025 11:37:05 +0300
X-Gm-Features: AWmQ_bnkqK7PyhDkz3ndIsN__qmiXNOVPD3UEEu7WXnC43CrktI12PyMWlQc3RU
Message-ID: <CAPnZJGCZKLvyzTMbrfYRvAvKUtGzen5AK61ZnURYyskQ6QiEhQ@mail.gmail.com>
Subject: Re: [PATCH] PM: hibernate: Restore GFP mask in power_down() for HIBERNATION_PLATFORM
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: mario.limonciello@amd.com, rafael@kernel.org, lenb@kernel.org, 
	pavel@kernel.org, rafael.j.wysocki@intel.com, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 26, 2025 at 6:31=E2=80=AFAM Mario Limonciello (AMD)
<superm1@kernel.org> wrote:
> commit 449c9c02537a1 ("PM: hibernate: Restrict GFP mask in
> hibernation_snapshot()") added a restrict GFP mask call that leads to
> mismatch when using the platform for hibernation.  As part of calling
> hibernation_platform_enter() the mask will be restricted when calling
> dpm_suspend_start().

I tested the fix in Qemu. It indeed works.

--=20
Askar Safin

