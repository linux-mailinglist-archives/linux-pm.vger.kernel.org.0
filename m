Return-Path: <linux-pm+bounces-32179-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE42B21301
	for <lists+linux-pm@lfdr.de>; Mon, 11 Aug 2025 19:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 525BA3B4073
	for <lists+linux-pm@lfdr.de>; Mon, 11 Aug 2025 17:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E141A9F8A;
	Mon, 11 Aug 2025 17:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vh64SCF5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5830B78F26
	for <linux-pm@vger.kernel.org>; Mon, 11 Aug 2025 17:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754932560; cv=none; b=C180Rx8SHXawbHPJ3sGAu/Z1srUviTDTQlAhTr6bMVCUKYHyO59Sl6n04lfHoozJes0g0QExOsqk4xplmLSqTFx7c0isAM6d+eVhIslvFMzglxVW+N3MFQv53PjlCcWWb96soaCN2tNdeYrAT2LveKxBtnvjgjYfop7FdX0PmOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754932560; c=relaxed/simple;
	bh=DQDV5MSdG7iIlFM3KP66cLZJSF82N+ojje6K3pNRkwo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZRJz9mu6vYQUb9Hj5Ee1ce9g+EzFLpYj+Wne36F1XOz+q3bFHBJh/I9vXtnWrf6s+Kqn9ozOKmYgV9eZMLrVKlEE5RRtLEjyxjdWCo1MjLu53yQymEGqkGifnm7T5/xBm6QP8Zzi1vs4+o27JObRsl2j36dP06nPwlpbPxGBOa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=vh64SCF5; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-242d8dff9deso19868355ad.2
        for <linux-pm@vger.kernel.org>; Mon, 11 Aug 2025 10:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1754932557; x=1755537357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=se2ODQFZ+H1X/pnjLuBikbbRlreY+4s+qe+LloKg96s=;
        b=vh64SCF5UGSpyt7z/X6CYC6hJIe45nZemLoiUFfqikcjcZALcmmfAoOBORz1EToAgH
         6iURYKHezwwBy4Llboxd3OLIZSIZxapyJ+16E6Hxst8okFWe+7hByP16R1UagSRLhaRi
         Wy4tvi3lCW+SPikWouYFYlf/wVHOphbNy9gixF9IRn0IsQ3/Cr90q/A+sU1cDJb8cm/r
         4vByz3FsIxFnuwDFIvCGnUx9+91T7zHTP3qBKnK4ZjsZrFfwYZf4fpcvTri7F5NBQNKT
         W4qpdDtyD2x7ILRgcNh+JZ9PbTrZlyKqJbLoDQFSTRm4LAb709AdCeVj6As5NBMOsc2R
         7tkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754932557; x=1755537357;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=se2ODQFZ+H1X/pnjLuBikbbRlreY+4s+qe+LloKg96s=;
        b=JYNsGiBybPv0Capy7N84Ug58Uljm5ITpEzFJmO+tzalFLoR4LUehDdgZEu8o2L/4TT
         hbaO4tY38ke+htq7ldfnE5CcxG67MhVWmlhg4JeHgDQ4hmtbAzv949gDz7VGKqzeD6nX
         8rIUXqULdOxMy2E1GnQFtWf8TTD8MrbTAO+rAxjFqpIB6Q3JYXPifeir4evfW4BPG+Cw
         8HGBWTAQy24bXjKOmhHhGlADC29vXKkG927jv4+J4Adp8lx9VG35sGjjIc6k0ornwBEB
         S9MvawGaVLQ/y3p0+nRlWp6v81+sx9VULh01f4Kr/DMd1/3zuA3xYq51884fzaCq0p9X
         eusg==
X-Forwarded-Encrypted: i=1; AJvYcCXacPDK4E713sk2LIP4YV1e9jIy+V7GBB6WN8vMBdJkTR2alNKSdjlgBhelNr+qkY304yeF+stuow==@vger.kernel.org
X-Gm-Message-State: AOJu0YyjBChG4yxiopSYR6hN/PQENg5nsOE42JsIRoOh3rsYhQ0FSczX
	SwvZGNuyhyczHyhOd4i9vBQRYxV0qGtEM1BP7GphMmDhHH3kjOo7w2MutlAzOhKSQu4=
X-Gm-Gg: ASbGnctXoyWrsZVhaCOcxEXrfiQkMlywgMG5QKSyX0mFfdC2kHL5KeKWk4dq5gYFfwY
	DjYnMlbK47EL47mCJBaa+qwu7yf1uOznyUq9tNP0oViE2nfFpEZovbsS+Qkdldts55RwGgrH3TT
	hpG2JwMKfOwBT13xbcRQXkxPSHkVxeKXSuO3Vm1K+9hCFRBEaUllruK6YpkdtNoO+TkoGkdkwFe
	sS+tecABvHN0nBPjQsnMHhuuM/eEABItBAkwCVJ6TJXkb5RokUvl7lcBfWoSEqmzEq9MqlHT2Cc
	8SiXCw8h94SIKYqN4xoTlg7ytHrYn3GC8oXTr0i+uRdFb5UZpXX+lAkmnHeiXutWmYcpoKQjJmX
	SNuzSeMXUAX5u+XvMMZCp5DTZDwD7rnyqMy3X
X-Google-Smtp-Source: AGHT+IEbJyyWqbQ4DL4JW1yoKcbTondc4o8KsIOOyz7k/Arl4I5K5BEN0nKVMUcO32W1ob2oOWy9ug==
X-Received: by 2002:a17:902:d486:b0:242:abc2:7f32 with SMTP id d9443c01a7336-242fc210059mr5262035ad.3.1754932557531;
        Mon, 11 Aug 2025 10:15:57 -0700 (PDT)
Received: from localhost ([71.212.208.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32115948a74sm24825423a91.4.2025.08.11.10.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 10:15:57 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Ulf Hansson
 <ulf.hansson@linaro.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
 Pavel Machek <pavel@kernel.org>, Len Brown <len.brown@intel.com>, Daniel
 Lezcano <daniel.lezcano@linaro.org>, Saravana Kannan
 <saravanak@google.com>, Maulik Shah <quic_mkshah@quicinc.com>, Prasad
 Sodagudi <psodagud@quicinc.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC/PATCH 1/3] PM: QoS: Introduce a system-wakeup QoS limit
In-Reply-To: <CAJZ5v0iq7UODJ83fkwnzfFR3HpG2_R-YRnip_cLwyUHZZ+rXyg@mail.gmail.com>
References: <20250716123323.65441-1-ulf.hansson@linaro.org>
 <20250716123323.65441-2-ulf.hansson@linaro.org>
 <CAJZ5v0iq7UODJ83fkwnzfFR3HpG2_R-YRnip_cLwyUHZZ+rXyg@mail.gmail.com>
Date: Mon, 11 Aug 2025 10:15:56 -0700
Message-ID: <7hldnp6apf.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Rafael J. Wysocki" <rafael@kernel.org> writes:

> On Wed, Jul 16, 2025 at 2:33=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.o=
rg> wrote:
>>
>> Some platforms and devices supports multiple low-power-states than can be
>> used for system-wide suspend. Today these states are selected on per
>> subsystem basis and in most cases it's the deepest possible state that
>> becomes selected.
>>
>> For some use-cases this is a problem as it isn't suitable or even breaks
>> the system-wakeup latency constraint, when we decide to enter these deep=
er
>> states during system-wide suspend.
>>
>> Therefore, let's introduce an interface for user-space, allowing us to
>> specify the system-wakeup QoS limit. Subsequent changes will start taking
>> into account the QoS limit.
>
> Well, this is not really a system-wakeup limit, but a CPU idle state
> latency limit for states entered in the last step of suspend-to-idle.
>
> It looks like the problem is that the existing CPU latency QoS is not
> taken into account by suspend-to-idle, so instead of adding an
> entirely new interface to overcome this, would it make sense to add an
> ioctl() to the existing one that would allow the user of it to
> indicate that the given request should also be respected by
> suspend-to-idle?
>
> There are two basic reasons why I think so:
> (1) The requests that you want to be respected by suspend-to-idle
> should also be respected by the regular "runtime" idle, or at least I
> don't see a reason why it wouldn't be the case.
> (2) The new interface introduced by this patch basically duplicates
> the existing one.

I also think that just using the existing /dev/cpu_dma_latency is the
right approach here, and simply teaching s2idle to respect this value.

I'm curious about the need for a new ioctl() though.  Under what
conditions do you want normal/runtime CPUidle to respect this value and
s2idle to not respect this value?

Kevin

