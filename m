Return-Path: <linux-pm+bounces-40404-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AF823D000D4
	for <lists+linux-pm@lfdr.de>; Wed, 07 Jan 2026 21:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7C9FA30019F9
	for <lists+linux-pm@lfdr.de>; Wed,  7 Jan 2026 20:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35A5250BEC;
	Wed,  7 Jan 2026 20:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fndgA9yN"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7A31DF751
	for <linux-pm@vger.kernel.org>; Wed,  7 Jan 2026 20:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767818876; cv=none; b=CybHEZSrKNWu6zzbzvGpzMpsQcJHRPXzLbAbC5kfLfRQlCRbGj6wxCE/ffBueS6TnJCiLfWf2JoH53xzRK09syoM+SFoTTYTXIsF9KteK6CarFIn5PsnidylWHCo2gtVOeJEHxNiUS7kjQ/HBCI89dZe07VOWCa48Bof0dr3XCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767818876; c=relaxed/simple;
	bh=qY1tKb+VpmkuxgiHKFRqXAg/Mvh99Isc402Y5OtPydw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GI50expM3zcVwOt1ExLCRFo1FGir62xU9za5d4xnyVOABGnWFTAMbnPGi7KAN/x2RwB+/oQcn+Wc4JTr8o6lIg+HRGvHylBq3X8aPPx2qyv4Xf7i5cUrsPYNSvl1P+nZkmlbbw6g9QPkqsaDwuXH/+5LfaMdRmiutdqgzXG5+7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fndgA9yN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72952C2BC9E
	for <linux-pm@vger.kernel.org>; Wed,  7 Jan 2026 20:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767818876;
	bh=qY1tKb+VpmkuxgiHKFRqXAg/Mvh99Isc402Y5OtPydw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fndgA9yNaXjf8hYplI6ChnGjhun825kiGKQ8cnezk3enwGdYEZr8Bp2uN/Q2/n2Tj
	 o1FK6ItWAA1utnC+1TeS+0LyEDqlwJD3/ie+5YtuTVlX7llGuImwvUhlein2TKj32c
	 3mCmNYuNZsFG5/zzjx9wL5tJrr66k79UeZ4X0c7NrjEKCcV4Om6cepPl8hX9nWB3U1
	 wNzEpCc4K/jr9SU4Lf155m7azKfz/tj8Swc3cowGmO8foHQnoEGXlX8ig+Z4w/yzw/
	 zZy3M7tSR0nrbMABq0HBJX2UBlTxKzLkEJ1DDv/sp8BUltSya3b4ojKCEJYS+hpnFy
	 ebrpGg1cgONKA==
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-65f59501df9so276960eaf.1
        for <linux-pm@vger.kernel.org>; Wed, 07 Jan 2026 12:47:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUFw/JJr6Hvpo2biABm57RiZRbnHh5sMx+iSiVTxj2xxO13lTm5uLBX4O2fGlzsHAXTXAJwEpsfTA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyS1ClaTAzEpc1uEb610DqPzI+8/6YvhbHlu20yZ6dt691KnQ55
	PXzhF4NNpVTtIU4raXa+ImQX+IS0MRIadcnASeMrOgA5qE+4IsZoBGb+XaanQUuXhrB2ErBFyd7
	bR2Udy62kZZQz6xlTGV5uUbpMJD9RZ+g=
X-Google-Smtp-Source: AGHT+IGaAHwi8PLrPFPlAFkMhaYdXhvtfJHstYFNCHyq+/RP7r1Mgy5UOApxbCdFpyK0uWW/tdUk3qiLhozx9mbURXU=
X-Received: by 2002:a05:6820:a0d0:b0:65b:33ec:1bca with SMTP id
 006d021491bc7-65f550851cemr1028131eaf.60.1767818875492; Wed, 07 Jan 2026
 12:47:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251220223026.125678-1-thorsten.blum@linux.dev> <1dd5045fbbb443fc12e602fc2803857401289294.camel@linux.intel.com>
In-Reply-To: <1dd5045fbbb443fc12e602fc2803857401289294.camel@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 7 Jan 2026 21:47:44 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0h+iY=KFJmq5omw1CruukDjc9vr9KFVmosStTsqu__=WQ@mail.gmail.com>
X-Gm-Features: AQt7F2rYYjSF3zxCjacSSdxr8GPa6G6x30ZGfb7D4rgiAo53VQU5dK1XFZncM_w
Message-ID: <CAJZ5v0h+iY=KFJmq5omw1CruukDjc9vr9KFVmosStTsqu__=WQ@mail.gmail.com>
Subject: Re: [PATCH] thermal: intel: int340x: Use sysfs_emit{_at} in sysfs
 show functions
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Thorsten Blum <thorsten.blum@linux.dev>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Ingo Molnar <mingo@kernel.org>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, "Xin Li (Intel)" <xin@zytor.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 22, 2025 at 3:43=E2=80=AFPM srinivas pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> On Sat, 2025-12-20 at 23:30 +0100, Thorsten Blum wrote:
> > Replace sprintf() with sysfs_emit() and sysfs_emit_at() in sysfs show
> > functions. sysfs_emit() and sysfs_emit_at() are preferred to format
> > sysfs output as it provides better bounds checking.
> >
> > Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
>
> Reviewed-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Applied as 6.20 material, thanks!

