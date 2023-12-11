Return-Path: <linux-pm+bounces-921-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E2080DC9D
	for <lists+linux-pm@lfdr.de>; Mon, 11 Dec 2023 22:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4E99B2164C
	for <lists+linux-pm@lfdr.de>; Mon, 11 Dec 2023 21:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B2E54BE7;
	Mon, 11 Dec 2023 21:11:04 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF54FCE;
	Mon, 11 Dec 2023 13:11:01 -0800 (PST)
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6d9d6f8485eso711709a34.0;
        Mon, 11 Dec 2023 13:11:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702329061; x=1702933861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+28nOcEyCcEuwJJom4JSQW5x+/ek8mhjRptDpKqeApE=;
        b=sqhTYToQpNIxKfyxA2a7yrdheIoCq2ywXrn0fnILnZrcj/pm3iLc1oVjeJrwOJIN7j
         vWk/nNtwXVsVE/oD42h+/WEYd9PKr9u6t9Z1hPUqcJD93IxBYeViiBCP+ArMV2QzLPSj
         lNjPovs0OAToFsWpbc2h+TFC8TkcrJq8QJld+v/FmQ+Zidc6P0rjcqJmkcGNj4dM1ip2
         /ggbJBitjP21muKk0msXHgiY2k30THtNUQRydoQClHIKh/OptQkw6NIV9IFGiDU/Z5F3
         BnNO4xxOdXLBUPO+6z8LVUy0h/18DDCasbHYR6fcwMapRDnIiXHvMgUm++6Q27R0dpjD
         k5Eg==
X-Gm-Message-State: AOJu0YxiBHe3rzoV+HRXqnenwheWtdDFfmJaeJ0Bx1A3cw/n2WKt91om
	HZEByg0E9HkMAyDd8M/trt81zb67PBjLBSzIcKA=
X-Google-Smtp-Source: AGHT+IGPrkYJLDfxqTwDOmJQQiLfS+sFr/VYQzZCMQ4uwzE3+4BdKwQRzCpU3Hz2N5pz5NSxwD7dJv1P28MAUJAKDTY=
X-Received: by 2002:a05:6871:7589:b0:1fa:db26:78a6 with SMTP id
 nz9-20020a056871758900b001fadb2678a6mr10132449oac.1.1702329061054; Mon, 11
 Dec 2023 13:11:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231024020434.34145-1-zeming@nfschina.com>
In-Reply-To: <20231024020434.34145-1-zeming@nfschina.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 11 Dec 2023 22:10:50 +0100
Message-ID: <CAJZ5v0iRhjjqOsp+h5KzyJBV33vr2NuUbwaDMrTWdmQvBdX9dQ@mail.gmail.com>
Subject: Re: [PATCH] power: snapshot: Optimize the error variable in the snapshot_write_next()
To: Li zeming <zeming@nfschina.com>
Cc: rafael@kernel.org, len.brown@intel.com, pavel@ucw.cz, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 24, 2023 at 4:05=E2=80=AFAM Li zeming <zeming@nfschina.com> wro=
te:
>
> Assign a value when removing the definition for error, which is assigned
> before use.
>
> Signed-off-by: Li zeming <zeming@nfschina.com>
> ---
>  kernel/power/snapshot.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
> index 87e9f7e2bdc05..40c141144c9a1 100644
> --- a/kernel/power/snapshot.c
> +++ b/kernel/power/snapshot.c
> @@ -2776,7 +2776,7 @@ static void *get_buffer(struct memory_bitmap *bm, s=
truct chain_allocator *ca)
>  int snapshot_write_next(struct snapshot_handle *handle)
>  {
>         static struct chain_allocator ca;
> -       int error =3D 0;
> +       int error;
>
>  next:
>         /* Check if we have already loaded the entire image */
> --

Applied as 6.8 material with rewritten subject and changelog.

Thanks!

