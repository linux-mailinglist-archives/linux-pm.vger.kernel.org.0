Return-Path: <linux-pm+bounces-919-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4FE80DC63
	for <lists+linux-pm@lfdr.de>; Mon, 11 Dec 2023 22:04:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE5FA1C215C8
	for <lists+linux-pm@lfdr.de>; Mon, 11 Dec 2023 21:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D9554BCC;
	Mon, 11 Dec 2023 21:04:05 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFAE8B6;
	Mon, 11 Dec 2023 13:04:02 -0800 (PST)
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3b8652c0bd2so356826b6e.1;
        Mon, 11 Dec 2023 13:04:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702328642; x=1702933442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YcmIjbD4ilvUJJ/ddZWdrhHOetOQgyrrR2/xbKsOJOE=;
        b=XvS+o7P/FB0KBj6ixdPo3z8a0OU7Oawccz970nShq8ETnlEzWMp51FdCdI9fabym2E
         5tC/IQmklMQtE79w4LcvczBhKmZtimPggadlfbnIu+Md71l3zR5GbipXqfg563CsZkIq
         kER3JQliDBy7CRu2N3s7wZ7EwrDSa5iQZN+UFFSuAGhYTO9liU1bzrPFlLObou6tP+61
         6ZRWQMZtcGEju8q130UuZKtSNkDKRRzK+pyQhQ+yiYaMNoLk69rHEbfqeAohK2pDcV3W
         sX3H5J2x3kGuitqXZdbhuR437WO+lpBn4/6pCPIPwDVJsHbO0E7Aa+Ai+JrpYpir7B82
         qENA==
X-Gm-Message-State: AOJu0YwYCWlzxYKdub/L9igldYfa4PWaCaJ+laEA+lUBnpk5IwDoa5Ju
	fs8GKzw1ezDYFy7GYHdJdQc19CkrcA5/afw/apeUQyWo
X-Google-Smtp-Source: AGHT+IH6eTK0P1jlWaFq384C1b231MI2KUrjIyx8Hc2zjlAPFyoCXmien2MztNQ2kiKnQFeQL/P3ZF5BM61CLUgPbRA=
X-Received: by 2002:a05:6871:e717:b0:1fa:df87:4eba with SMTP id
 qa23-20020a056871e71700b001fadf874ebamr10609885oac.5.1702328642162; Mon, 11
 Dec 2023 13:04:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231020085106.12026-1-chaodong@nfschina.com>
In-Reply-To: <20231020085106.12026-1-chaodong@nfschina.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 11 Dec 2023 22:03:50 +0100
Message-ID: <CAJZ5v0g873f9jHRfEfBhX4bYeyFR_1zuB_Jga+fKX0Tc7mQX9A@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH=5D_power=3A_snapshot=3A_Remove_unnecessary_=E2=80=980?=
	=?UTF-8?Q?=E2=80=99_values_from_error?=
To: Wang chaodong <chaodong@nfschina.com>
Cc: rafael@kernel.org, pavel@ucw.cz, len.brown@intel.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 20, 2023 at 10:51=E2=80=AFAM Wang chaodong <chaodong@nfschina.c=
om> wrote:
>
> error is assigned first, so it does not need to initialize the assignment=
.
>
> Signed-off-by: Wang chaodong <chaodong@nfschina.com>
> ---
>  kernel/power/snapshot.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
> index 87e9f7e2bdc05..9acdc4458a36d 100644
> --- a/kernel/power/snapshot.c
> +++ b/kernel/power/snapshot.c
> @@ -1119,7 +1119,7 @@ static void mark_nosave_pages(struct memory_bitmap =
*bm)
>  int create_basic_memory_bitmaps(void)
>  {
>         struct memory_bitmap *bm1, *bm2;
> -       int error =3D 0;
> +       int error;
>
>         if (forbidden_pages_map && free_pages_map)
>                 return 0;
> --

Applied as 6.8 material with rewritten subject and changelog.

Thanks!

