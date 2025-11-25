Return-Path: <linux-pm+bounces-38585-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EFBFC84ECB
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 13:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C92124E8C54
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 12:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26AB831ED71;
	Tue, 25 Nov 2025 12:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T6hHID/J"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81B931ED67
	for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 12:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764072567; cv=none; b=ru2r/52pNtnKX0LG5tsoijn+u7nSE/hMYJcM2vxSwKlpNU/4fs2T5u2V8z7AUTCm+bbcLuLJ+FWX6h9upyvhHCLtFkhQEhFDLlhzLzfJZmERItty1AoPE9V5bqj1R1dGGX1PhqLPDE63755skToq/3w/SFYKtSIvgvrCRf9uqPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764072567; c=relaxed/simple;
	bh=58WdHv0Q1QIG7qWTah23c6HvbdCd4eKE4+8IkHqhiWQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZevcpImdoLDbXsdHDYcR1YHVGWgFR9dXDePYTvAmoDB/Aj+iEwXphNOIfD7jWd+iP0jnWo9KJICXKhzDBBe0L8tf7VVcSv3c1UVJ+21AAw5F/S+3k1zs5PUr9TZi2Ko8QwxVrutuZhY+ifpDpN07nbG8A3kwIScbrPLc6AvL45Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T6hHID/J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A65EC19425
	for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 12:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764072567;
	bh=58WdHv0Q1QIG7qWTah23c6HvbdCd4eKE4+8IkHqhiWQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=T6hHID/JQZubgOMOOaPq391i1mgNZZLd0MRpGvzV44HCp5azZAR3jde7+ZpgzEhqm
	 JF8ZH9XphEzufbb6oEzylcu2xBJPosvWGSMFzeZJf1PmMeWrgEY4sp+9cjCLrX1Ho8
	 McICG63P3sYagaPLzvwP8EoenvUBIJWC8gm8kpff+ZiP5wjLNOywvoaMSZESOsxNN4
	 AGZJHQQOohC4lSE/1lotHWtcLkX4S7kLYVslG7CScMvS4kPJG+Ges1mYnYK6rddslJ
	 yKDXNBDNEt+LK4zv8IFM6Yq36JXvNiqtYaNKk/cv1srapdEOk6JTxIK76QgDGDaO5d
	 JxMLgcx84tcoQ==
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-657490df6f3so1967153eaf.2
        for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 04:09:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXdICTOR+Si6hyR27bARKCTw8f6gd9kpDUi8n0syVPCDakKoowv79LsFWzgPWibTg+Uhsy6xJQg/A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyoI7Ip/CfYfRzTchtdPM7IjgWeHHwFTrekYnLFx0Fe1KZLHDKk
	eFDpaUJbdHVmnU7KsTEmYTIukgTXofiIZdyJXBX6kk39zmkndNALyk6Tc63uSubVA+oD0OJmfo/
	uzeycgetTKgHAqCmAWTwV5XBws3+189A=
X-Google-Smtp-Source: AGHT+IE9qn6AkAdtcEqRltyfsyjDthReLV20d+nWAVJwXv6uEuvIWWnljgo784DDXu4sqInzpI2P5viZ6Dxb+5/MCp0=
X-Received: by 2002:a05:6808:508c:b0:450:c9f3:8eff with SMTP id
 5614622812f47-45112ba14c6mr5869562b6e.46.1764072566640; Tue, 25 Nov 2025
 04:09:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251125032437.2056626-1-kaushlendra.kumar@intel.com>
In-Reply-To: <20251125032437.2056626-1-kaushlendra.kumar@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 25 Nov 2025 13:09:13 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0g=if_+6wDVTyKQqu5WfOh0VJV2frT-19Jn0isiB0iJnA@mail.gmail.com>
X-Gm-Features: AWmQ_bkaJMfwYXHUlqGxCJ48nAxhrl5QecXLfrH6Q_sMgrFrjQKD8R0haCHdQ1U
Message-ID: <CAJZ5v0g=if_+6wDVTyKQqu5WfOh0VJV2frT-19Jn0isiB0iJnA@mail.gmail.com>
Subject: Re: [PATCH] sched/cpufreq: Fix capacity calc in shared policy update
To: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, mingo@redhat.com, 
	peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de, 
	vschneid@redhat.com, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 25, 2025 at 4:27=E2=80=AFAM Kaushlendra Kumar
<kaushlendra.kumar@intel.com> wrote:
>
> In sugov_next_freq_shared(), the CPU capacity is retrieved only
> for the CPU that triggered the update (sg_cpu->cpu) and then
> incorrectly applied to all CPUs in the shared frequency domain
> during the loop.On heterogeneous systems with CPUs of different
> capacities sharing a frequency domain, this causes incorrect
> frequency selection.

No, this is not what happens.  sugov_next_freq_shared() is for the
cases when the frequency *needs* to be set for all CPUs in the domain
in one go.

Your patch is invalid, please be more careful.

