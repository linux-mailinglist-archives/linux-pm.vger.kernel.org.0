Return-Path: <linux-pm+bounces-26239-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C24CA9D0D4
	for <lists+linux-pm@lfdr.de>; Fri, 25 Apr 2025 20:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DB237B880C
	for <lists+linux-pm@lfdr.de>; Fri, 25 Apr 2025 18:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92AC721ABBD;
	Fri, 25 Apr 2025 18:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BQNUegll"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6674121A427;
	Fri, 25 Apr 2025 18:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745607093; cv=none; b=FcLN7Tu4AAhV2wbS1yk8jhd0coeKW2MaT9UQLIhJRxsMUeJOmODmBA9UXed/2pXhHh/UabiXnLHFxLNNdw75L9xOMzJkBibN/r4XmZe2DmT6wIwQWI0xCpTwzd3jeJih4021hiN2lFDmJ2Mb/CT6PTO3QTReHELOZ2bzp2CilvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745607093; c=relaxed/simple;
	bh=n7uadKRE/wx0GOgHoEW+JWXXoJqo2SeruMdhqMd13+E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X+5dINmNOvntMWUMxQ8446tsfYDTZTPkJoxwbx0GuWL0dmvqr6b5yNOwliMQxjNLaS+8xbBSyjKXrs0XWsDJ0lJWTe23vvqeKAZndmdGIeeQVFSZ7w5ZVvoTKCONSxfOyGrPQy0ghpnMHXJfJaKx2LdD3Fqf9DESqIin6DDRI8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BQNUegll; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6CC0C4CEEE;
	Fri, 25 Apr 2025 18:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745607092;
	bh=n7uadKRE/wx0GOgHoEW+JWXXoJqo2SeruMdhqMd13+E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BQNUegll61Ijq+MM/y0mrI1cWvDc0BpLUHkCPpwTwJPYicc4nHXi3dJhMhXf/BOYd
	 G0j+1fOlwd3N31ZF7TueFJNBTekm7w0sb1jmrH2oS/y5ws61+RUqzaOguDFyawlQ9K
	 Vc08l3ty9VSDeDypFH490GpVcXeIMMzQjFlBbkW8MBx1d71w2p1q3T+rQzAThoCJKo
	 YXuR8JhdekLnJNLucJQAtMMXpoZL8J+b35yAC/0oAvkEy5V98zp0MjrOMRAlXB1TgU
	 t0DyNR2nYGdrPIex2Z/pDgsQ+9BbVIYRhQ5rjq12FQMr1mu6Too7IcYi2W7hclzRJz
	 2Y/ubXS48gxaw==
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-605f7d3215cso1323154eaf.0;
        Fri, 25 Apr 2025 11:51:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU56yqCSlf358XOLGI1W+zaMcIoUiD9ru0pazrH4fVewq5lVNLz93CJhrGD6jdSuzRybG8tXf+3ucM=@vger.kernel.org, AJvYcCV/DC/nnfa4EEaJaoSaedvbRJCJsMD0bSOoYvvANNhz8n0zNxvS1NSPs7xA06mo7etAXg7G3dI8EQtX5bM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgeGArPNvGhpiO/rSkDjl/w6JwNEcK6L4LhNRPlBum+8bs9PXh
	EkCmLAzJmBYW5rYAX2d6W+DJ8srlpIA4I4Vi28vT6XONPJlcq5GfiKoWPmmiMxRPeHdIxvsRO+f
	yYmVGjyMscaTbHfox8r/gNAGMyME=
X-Google-Smtp-Source: AGHT+IG0FKJH/2AyzEJav/cqqoVWJ4GwSXOTaFBGxNOoPCtuqkv007PCy7ueP1IWIE6mwrE3FkDUdLF+caVrFBmy3YQ=
X-Received: by 2002:a05:6870:a786:b0:2d8:957a:5164 with SMTP id
 586e51a60fabf-2d99d7e45d9mr2006634fac.10.1745607091994; Fri, 25 Apr 2025
 11:51:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250424060339.73119-1-zhangzihuan@kylinos.cn>
In-Reply-To: <20250424060339.73119-1-zhangzihuan@kylinos.cn>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 25 Apr 2025 20:51:21 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jbA4_0Fb_n0pR1pCtJBfMgkqBD7ePO-TrxB_E1mv5=Hw@mail.gmail.com>
X-Gm-Features: ATxdqUFU3pwTZlsiuAC5IF8WcxX6KXjBedO-zXlxghyfFDkSvamf_bkO_zV126U
Message-ID: <CAJZ5v0jbA4_0Fb_n0pR1pCtJBfMgkqBD7ePO-TrxB_E1mv5=Hw@mail.gmail.com>
Subject: Re: [PATCH v1] PM: Remove unnecessary !!
To: Zihuan Zhang <zhangzihuan@kylinos.cn>
Cc: rafael@kernel.org, pavel@kernel.org, len.brown@intel.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2025 at 8:04=E2=80=AFAM Zihuan Zhang <zhangzihuan@kylinos.c=
n> wrote:
>
> Double ! or !! are normally required to get 0 or 1 out of a expression.
> A comparision always returns 0 or 1 and hence there is no need to apply
> double ! over it again.
>
> Signed-off-by: Zihuan Zhang <zhangzihuan@kylinos.cn>
> ---
>  kernel/power/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/power/main.c b/kernel/power/main.c
> index 6254814d4817..97746f08b762 100644
> --- a/kernel/power/main.c
> +++ b/kernel/power/main.c
> @@ -594,7 +594,7 @@ power_attr(pm_print_times);
>
>  static inline void pm_print_times_init(void)
>  {
> -       pm_print_times_enabled =3D !!initcall_debug;
> +       pm_print_times_enabled =3D initcall_debug;
>  }
>
>  static ssize_t pm_wakeup_irq_show(struct kobject *kobj,
> --

Applied as 6.16 material with edited changelog, thanks!

