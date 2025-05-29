Return-Path: <linux-pm+bounces-27815-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3976AC80F7
	for <lists+linux-pm@lfdr.de>; Thu, 29 May 2025 18:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E0C616B400
	for <lists+linux-pm@lfdr.de>; Thu, 29 May 2025 16:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7584522D9E4;
	Thu, 29 May 2025 16:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFUffQ4R"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B677F22DF9A;
	Thu, 29 May 2025 16:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748536507; cv=none; b=ib8M/AWcBemNTm/JPbGYqmFZVxKZgClR+qZ5Owd362tT834loubzLQ+++5J8NF0ZmfTF/IDaNqDgZ2ibPfBZfRxO8a4+90hiKFUsgeGW+wpMnCaxztxiZ219yYrZkSNUFDIPQ2c17ck6nax04Y3c8I48wJnR+jLCiWWsrcW5mhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748536507; c=relaxed/simple;
	bh=xPdHeA8Ll93Tmpat8AIFRsRknJ/2NDvjbkeniysOzuw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eBH7lghRqemd4fy/gA1HPO8RF8b9pSeH3zdejZFjCEJ0SbIDhy/cO8gjt1N9OXTmnNGVlWsaANjvF/FSp52Vd6tqdmidwohTn7PvWDpud6DZBTh798DyUSsX4N6YgDOvBtUpCO8bgssjp+FCtbiSCtSMPjNFrg1KHAvhhU4rbIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LFUffQ4R; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-adb2bb25105so102342266b.0;
        Thu, 29 May 2025 09:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748536504; x=1749141304; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xPdHeA8Ll93Tmpat8AIFRsRknJ/2NDvjbkeniysOzuw=;
        b=LFUffQ4RouMALSY21aqGAiphvu1RkxIypuZ3XSHePpnEwaGPrMzzculIBYXxPQe9Xn
         uBp3yucAqr+C2AEk49mOC5WsURW6CEdwrUxEQEaVL5CZ0XVjMMFHD9tvoP5VyTQvYQ3n
         TAGVxHUu2pd4/2dtrw04sEr6bGxNN4x9wAyOPSMM5VnMDfpo3ILSNZZqXjYd1kLrXtZz
         tIg5sDkMAqqzVwogFl5DIZIJMYnOqo+kUwV+SrNkdh49U5BYwDCZxWAm0rCMDT68A0S7
         Xb5RqzcjRAQE00g+r6ssh1snmytqkcor1eCiLgOe6JKnYwhquUe3sGqsPP7+THUeyXUt
         cnFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748536504; x=1749141304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xPdHeA8Ll93Tmpat8AIFRsRknJ/2NDvjbkeniysOzuw=;
        b=wgKZYP5g3fOjNk8Fx3lrzPozgPRDK/19BVjccDK+C8GZ4jYjJMRZiBI0NEaYwvduYh
         +Ti+h0f3z7QudauDjN4YOS3SAzX1sqA71kvAdn79cjdnkmOn5xNyHjKRWRdSSCcQaZ8z
         uIqDYDJRGN+JWb4XjRJiICUdMcBc9EYTQzvd+oY+HPvot1iHLo201XZy6Cb4mfK6FA0+
         GDxnzWWIufes3E1AyStDzt4Nm/CakvezFo8xybFOdZE2MMDBWVgx3HnbgAMsczOIlKc7
         n1/k+fvmLU415qT8aMTNegWvLtpEywP+PW2JwIpPADP6ubWLBQSZJnBFsQ1umksjIMSn
         w0pg==
X-Forwarded-Encrypted: i=1; AJvYcCUvat7vQRsEk5Y3DX2Wslgkb4F4wucynzkt9sapR30tDRJmUftcZDjhYMA+L4jr0s974Nd4xxpNzAw=@vger.kernel.org, AJvYcCW7DovhDLS4qw1ywR3q8AJeJ0O6Nzp00EWCZXBlzdlCHTZqQEbUxtz/OnqorcebQkecuGxFaiF2epKAvdM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6dXIkB+ji61c+GhJZnyOjPHIh2wh20JkX1AwbgQwHheHjXc0d
	3LncTPJbGYj3wt1PcPzlkoxsSn67XbQZO+GalLXveb3PVS2MOP9iUlUBS2px0G3Ulc2pKokXfwa
	JgZ4HRVe8p4+WVlbRzTkw0a31WjjgFJk=
X-Gm-Gg: ASbGnct9pw/UR3sDzDSZGHje61G9tcg9/ks3IJ2FLtMxt3gWMsGPAqk9sjEFvA2XKxE
	GzLFdRC8Cl2OZBMtMwL5BH+OIvK3MIiJkZ0Nv63RXmGIGl02PYfa4Ci//IqXZqG0xAvhYxEBig0
	3t3eUzzmGFa+d+61bDeyEMLioxx3smjqo=
X-Google-Smtp-Source: AGHT+IEbs96PmnODJkW/G/G3MYy5bXOl00etxzTy03AdnK8SUjHDejAWe7kguReU3u5735oIVBJB83zei/arzJfSKLs=
X-Received: by 2002:a17:906:6a1a:b0:ad8:9e80:6baf with SMTP id
 a640c23a62f3a-adb3223d710mr15188866b.13.1748536503820; Thu, 29 May 2025
 09:35:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250529085143.709-1-gautham.shenoy@amd.com> <CAJZ5v0h27Re4UwoyCrauNfQupojpfwKSOzSppC9mwR-ATWD3Vg@mail.gmail.com>
In-Reply-To: <CAJZ5v0h27Re4UwoyCrauNfQupojpfwKSOzSppC9mwR-ATWD3Vg@mail.gmail.com>
From: Manu Bretelle <chantr4@gmail.com>
Date: Thu, 29 May 2025 09:34:50 -0700
X-Gm-Features: AX0GCFscwJKRwRExy1zkvHz1qf4pxX6sXMM_PVO6NnH3h0kKbh5dWuagBoRiX0o
Message-ID: <CAArYzrKT2zMBL54i6AKj1kEASLA3D8W4-d191cuqADaC6NGbjw@mail.gmail.com>
Subject: Re: [PATCH] acpi-cpufreq: Fix nominal_freq units to KHz in get_max_boost_ratio()
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Gautham R. Shenoy" <gautham.shenoy@amd.com>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Mario Limonciello <mario.limonciello@amd.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 29, 2025 at 6:23=E2=80=AFAM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:

>
> Applied, thanks!

Thanks Rafael!

I see it was merged into pm/linux-next, will it make it into the next
5.15 LTS release?
I did not find what the process is for LTS backport and would like to
make sure this trickles
down to LTS kernels.
Thanks

