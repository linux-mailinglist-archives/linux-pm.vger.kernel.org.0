Return-Path: <linux-pm+bounces-1384-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C8B819143
	for <lists+linux-pm@lfdr.de>; Tue, 19 Dec 2023 21:21:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86B411C23C1B
	for <lists+linux-pm@lfdr.de>; Tue, 19 Dec 2023 20:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4D615494;
	Tue, 19 Dec 2023 20:21:39 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DC439AC2
	for <linux-pm@vger.kernel.org>; Tue, 19 Dec 2023 20:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5907b9c3fd6so685112eaf.0
        for <linux-pm@vger.kernel.org>; Tue, 19 Dec 2023 12:21:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703017297; x=1703622097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LuA/JsuMDdzS4YIRiykbu0z6JDAv3SJUj/Ch3kvU0FM=;
        b=dm6dl6cAstxaxxs6B+YMs/qZ9dAxq8275k4BimfbiXAklil+b0KxGEO+D22BZghh8e
         xZmt0eHNdr6Mn6WzDNE5euT+ZiVaVhov5Oq7gtlCyorlVzc/geGNThRg8F84wYu406ms
         JXZn+aN5YgK5OmypfPrlGTJXW8lWM1mxuVnREX6R7wrrnobtw0iVIlDLbU9FtZbyHHcj
         xzSVUz3iw8TEdzmUoZp3kYsY94dSHxwrBK2KFPtsfhf9jx82PmeCa8tt06YkdGRsbw59
         2J3EtAFWcXn9KOK7s7Jyr4ob/6P1uSe8A6Hf3RqGbHGXpmxKyuRt4+AxF4xlw1A8MvmC
         sBAw==
X-Gm-Message-State: AOJu0YyRAi7QzvS7GFyT1+BhAiAOUC4tB6gs7/yyDnHyGTt8fxMvTtPe
	2JRQKxuVEy31MpPVPPKGGRJ6TEse8uleU29PRZc=
X-Google-Smtp-Source: AGHT+IGtZQjfKW3UJbBoUfSaOlxYpVFSEW7ey+qhgN5ck2iqVLYiyZ9ZoHZWid+l/xhC6b+YA26Kl9VVyVuF1ygkbY0=
X-Received: by 2002:a4a:b141:0:b0:591:c8cd:a13a with SMTP id
 e1-20020a4ab141000000b00591c8cda13amr9314867ooo.0.1703017297589; Tue, 19 Dec
 2023 12:21:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231216115717.2285930-1-haokexin@gmail.com>
In-Reply-To: <20231216115717.2285930-1-haokexin@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 19 Dec 2023 21:21:26 +0100
Message-ID: <CAJZ5v0gdq22bum86-QGLKdbz+YVWfomoHsMADeiWKxCHj55=pQ@mail.gmail.com>
Subject: Re: [PATCH] PM: Remove the mention of freezer_count() in comment
To: Kevin Hao <haokexin@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 16, 2023 at 12:57=E2=80=AFPM Kevin Hao <haokexin@gmail.com> wro=
te:
>
> The freezer_count() has been removed by commit f5d39b020809
> ("freezer,sched: Rewrite core freezer logic").
>
> Signed-off-by: Kevin Hao <haokexin@gmail.com>
> ---
>  kernel/power/main.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/kernel/power/main.c b/kernel/power/main.c
> index f6425ae3e8b0..768c07155d53 100644
> --- a/kernel/power/main.c
> +++ b/kernel/power/main.c
> @@ -61,8 +61,7 @@ EXPORT_SYMBOL_GPL(lock_system_sleep);
>  void unlock_system_sleep(unsigned int flags)
>  {
>         /*
> -        * Don't use freezer_count() because we don't want the call to
> -        * try_to_freeze() here.
> +        * Don't call try_to_freeze() here.
>          *
>          * Reason:
>          * Fundamentally, we just don't need it, because freezing conditi=
on

IMV, it would be better to remove the entire comment from
unlock_system_sleep(), because there is no particular purpose for
having it after the freezer changes.

