Return-Path: <linux-pm+bounces-32202-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 768E3B215D3
	for <lists+linux-pm@lfdr.de>; Mon, 11 Aug 2025 21:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F27577A141D
	for <lists+linux-pm@lfdr.de>; Mon, 11 Aug 2025 19:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D362D8774;
	Mon, 11 Aug 2025 19:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b6KiaIHQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDE92D63EF;
	Mon, 11 Aug 2025 19:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754941478; cv=none; b=feIL4k0FyhM7O8MvGrI5IlG4cXL453TsoPj6mVIdsX7R23rIuaA8RzutoYZkajgT8n5Wr1EEsCg8tTScyuw8PN7ONiJFq5vwnvBVcQ+54CvwupUC0X6cwlcrREoW2EaJYlfbBdx+dODL5AtqT7UqLcMRvFBVd5cEkTqbSkUE+/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754941478; c=relaxed/simple;
	bh=HFSYTomcVpDYyiQFcDFS3TsPSZJ29/pXHWsxX2aDE1k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lujzy6HAVSsf/KpwPPlqSB5UoWYI2n0BlK1AjJxbkVBqj/mx6wFlKsfbUlUJCKmGNfuqqPy4mVW20WfXzv2eZfKJ3H7/EBPqLdaE8B4VFMrrjJo0bmheODc1Wx5w+5lVR2qa1ldVg/xIk7ScE3+rzzVvA3JjdTjCCPjjttS4iwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b6KiaIHQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A99C5C4CEED;
	Mon, 11 Aug 2025 19:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754941477;
	bh=HFSYTomcVpDYyiQFcDFS3TsPSZJ29/pXHWsxX2aDE1k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=b6KiaIHQIyLmAqF1UgqVPT1b2R+w8bBmuvtGAs8Q+UCFv/24OSSpbMWlGIIoy5IyN
	 naZurcG4UFxMmqFk7DNmQ+T079Q6uUiaBCn+9Z/LRVtm45hlE18ZlQaoqe14HAb99s
	 FfScQuG50Cv3BS296u/XUR2N3L2obKTQUO+0IxVLfIM1YJncOILr33yqdCPKlPVoZ9
	 lbMwHAxQ7RLXlBSVC1I6KwXOMAd5ByR3WXeweV7Hub61Nq2kBcmWCcvlt6THDorsvD
	 IE4J43fqIS8ttiEWDRm20BKuIcvezarhfVgMlYC/1NIgJV0HxuIX6J4SUWiopesEmQ
	 M2TXCDnElLUJQ==
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-61b43c84905so3334664eaf.3;
        Mon, 11 Aug 2025 12:44:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCURoiO3A0bcUcN5z8yOJrGTRvrorqFZbOrKg5rLohkfF6h6XyR24OBcCPHtqQab7iRWGPGaR7BvzGVS8WU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd1e/o3GFfOycy+5Rb5IqJ5eSIHYpQtDb87Mz9LIgQKyuH8pna
	5P6qKWFSQYjXpo3hpzOSrzAykgvslc2pMBn2LLjeCC6HxKFt8BpWLg1lxQRNQL/9sY5Crq2S2ct
	5yT4aSlajyve3glfi54DyoywavL8b6Hw=
X-Google-Smtp-Source: AGHT+IHfJz06vTr38ESm7NpPOx6l99brQRfdr65BgZZuwPz16AtJCOoXaAGUwqQUHutgsxsepX0vxOSM/BQr2Ta5Svo=
X-Received: by 2002:a05:6820:822:b0:619:6fea:2fb8 with SMTP id
 006d021491bc7-61bb5bc72f0mr626387eaf.5.1754941476961; Mon, 11 Aug 2025
 12:44:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <06101aa4fe784e5b0be1cb2c0bdd9afcf16bd9d4.1754681697.git.len.brown@intel.com>
In-Reply-To: <06101aa4fe784e5b0be1cb2c0bdd9afcf16bd9d4.1754681697.git.len.brown@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 11 Aug 2025 21:44:25 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hiWnp8+Np7OWvYa6=QYQOmRWi_W4-8bBxo71LEt5703g@mail.gmail.com>
X-Gm-Features: Ac12FXyr97rsSmdGovPBKM9r-GqGH0lO6y7PAe-f17kvohnH5LtVurUKfncG9uo
Message-ID: <CAJZ5v0hiWnp8+Np7OWvYa6=QYQOmRWi_W4-8bBxo71LEt5703g@mail.gmail.com>
Subject: Re: [PATCH 1/1] intel_idle: Allow loading ACPI tables for any family
To: Len Brown <lenb@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Len Brown <len.brown@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 8, 2025 at 9:37=E2=80=AFPM Len Brown <lenb@kernel.org> wrote:
>
> From: Len Brown <len.brown@intel.com>
>
> There is no reason to limit intel_idle's loading of ACPI tables to
> family 6.  Upcoming Intel processors are not in family 6.
>
> Below "Fixes" really means "applies cleanly until".
> That syntax commit didn't change the previous logic,
> but shows this patch applies back 5-years.
>
> Fixes: 4a9f45a0533f ("intel_idle: Convert to new X86 CPU match macros")
> Signed-off-by: Len Brown <len.brown@intel.com>
> ---
>  drivers/idle/intel_idle.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> index 73747d20df85..91a7b7e7c0c8 100644
> --- a/drivers/idle/intel_idle.c
> +++ b/drivers/idle/intel_idle.c
> @@ -1679,7 +1679,7 @@ static const struct x86_cpu_id intel_idle_ids[] __i=
nitconst =3D {
>  };
>
>  static const struct x86_cpu_id intel_mwait_ids[] __initconst =3D {
> -       X86_MATCH_VENDOR_FAM_FEATURE(INTEL, 6, X86_FEATURE_MWAIT, NULL),
> +       X86_MATCH_VENDOR_FAM_FEATURE(INTEL, X86_FAMILY_ANY, X86_FEATURE_M=
WAIT, NULL),
>         {}
>  };
>
> --

Applied as 6.17-rc material, thanks!

