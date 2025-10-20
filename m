Return-Path: <linux-pm+bounces-36457-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93616BF1227
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 14:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54CB03AD39A
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 12:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26CAB313264;
	Mon, 20 Oct 2025 12:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I1cOESkD"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F42063126A7
	for <linux-pm@vger.kernel.org>; Mon, 20 Oct 2025 12:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760962698; cv=none; b=GOiydRsF2+OXIEVOykzpsLUdmSETpUB7DqiMILzTQiLz2WQNuT5Ku710xWN7PKxzI5nN2Qc8iGr40xxkjehigxkeSbjh5s7Nb41pS/I38xZwb8GYcG30ni/j7V3WRMEI7/uMIG2kkFFtUF7a8WV59k4FqKa+9KSS54ZLhyEjgcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760962698; c=relaxed/simple;
	bh=r0EfMT9X6rvzpWUrxQejrhPkjoIbmWaoix43K/pnhuc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uj6rMwkFHv5h7dRMH9W4Nb5rdbMbt66R6QLRSEskWSgquLOWgZn4NgnvG5EgCVnewVNBMqGNNeP+m8O4m2UQehPXKR3rehC8mw1ZzOE1ApF5jOwI6HLXfGPzaKCkHCg6yLRW0hhZ3Tt+xqFw5ZF5MZ4hPKutbQZDXalG0gP7eg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I1cOESkD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97DA8C19421
	for <linux-pm@vger.kernel.org>; Mon, 20 Oct 2025 12:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760962697;
	bh=r0EfMT9X6rvzpWUrxQejrhPkjoIbmWaoix43K/pnhuc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=I1cOESkDtb6jDYTXLVe4Dl3S4aPAdgaz2tunhE9MAUX7pnxJ+zvtEzeHGD85fwSMV
	 wo4twoV+aRl5m0m3+J9sXf6CDWOFf72G5r3VRsSmmQZrclErGfuBw68qujzeO5sb0z
	 G7dXTs+2aVkxhqbeJg9aSqAVmxfAxA0XXYBeqO9K597f3qtyjryKf2oD5uHHIQQ0b8
	 OUz8Gi5QMy+AERiXtZ6H4sYXbTn8xIMK0nQSTWd09e1HZbRpbQtRI6L0Z3BPoPjsYu
	 wNx69wiqGIUi4RvL3weYDM6gU/kdjAT2YA7b84MaZDJ85S5pZe00hLDZhLb+O1kG3x
	 iMiZLMSBdxEWg==
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-443a9ae4639so1578386b6e.1
        for <linux-pm@vger.kernel.org>; Mon, 20 Oct 2025 05:18:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUJ376t5+U685Hy+AmHMixXQaXrQ80veLwpCsy2Olc1XsIXj2vlJcJlq8onC7QMwfmDxXEBQmXgKQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyUuOKCcfIaDO7Ts5RMiFBCADhJBW/Umc3/JEqpPE/45Wvnck94
	S37HFw7NK+B/gjYry1bk5Jk88a1FpndF5CB3vc+QtX1cxAH/tea7JlA8/tcN4zwXuKz8KGl7Xot
	IjKNd+0Gm6eBbVrQJ8hl/yAXVyaKKRxc=
X-Google-Smtp-Source: AGHT+IE0I6W30GnSKbp2Erj/Uw5BnMxh4MvGbK/mgLcIWPEuN+PmNy1oBqcy5zKua0ICQgW7Xmqsmz8sxUjrWFBxnRM=
X-Received: by 2002:a05:6808:1806:b0:439:b9b3:af44 with SMTP id
 5614622812f47-443a2e20f40mr5745349b6e.19.1760962696808; Mon, 20 Oct 2025
 05:18:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020084429.230322-1-changwoo@igalia.com>
In-Reply-To: <20251020084429.230322-1-changwoo@igalia.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 20 Oct 2025 14:17:58 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ib0dXYiNsj8cP6jcGpdqer_ASzMo7RAKhDU7eh_cHAZw@mail.gmail.com>
X-Gm-Features: AS18NWDRFvBXPdetqSzpiuDZVc9Lq0RSEVb4luTn_5z_vJ4UDkHiWtyqqMdvrZY
Message-ID: <CAJZ5v0ib0dXYiNsj8cP6jcGpdqer_ASzMo7RAKhDU7eh_cHAZw@mail.gmail.com>
Subject: Re: [PATCH 1/2] PM: EM: Remove an unused variable in em_notify_pd_deleted()
To: Changwoo Min <changwoo@igalia.com>
Cc: lukasz.luba@arm.com, rafael@kernel.org, len.brown@intel.com, 
	pavel@kernel.org, christian.loehle@arm.com, tj@kernel.org, 
	kernel-dev@igalia.com, linux-pm@vger.kernel.org, sched-ext@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 10:45=E2=80=AFAM Changwoo Min <changwoo@igalia.com>=
 wrote:
>
> The variable `ret` in em_notify_pd_deleted() is set but not used, so
> that it causes the following warning:
>
> >> kernel/power/em_netlink.c:228:6: warning: variable 'ret' set but
>    not used [-Wunused-but-set-variable]
>
> So, let's remove the unused `ret` to avoid the warning.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202510151223.THlBK6QR-lkp@i=
ntel.com/
> Signed-off-by: Changwoo Min <changwoo@igalia.com>
> ---
>  kernel/power/em_netlink.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/kernel/power/em_netlink.c b/kernel/power/em_netlink.c
> index 2c55c758de6b..48752189a07b 100644
> --- a/kernel/power/em_netlink.c
> +++ b/kernel/power/em_netlink.c
> @@ -269,7 +269,6 @@ static int __em_notify_pd_deleted_size(const struct e=
m_perf_domain *pd)
>  void em_notify_pd_deleted(const struct em_perf_domain *pd)
>  {
>         struct sk_buff *msg;
> -       int ret =3D -EMSGSIZE;
>         void *hdr;
>         int msg_sz;
>
> @@ -287,7 +286,6 @@ void em_notify_pd_deleted(const struct em_perf_domain=
 *pd)
>                 goto out_free_msg;
>
>         if (nla_put_u32(msg, EM_A_PD_TABLE_PD_ID, pd->id)) {
> -               ret =3D -EMSGSIZE;
>                 goto out_free_msg;
>         }
>
> --

Would you please fix the patches on top of which these fixes are needed?

