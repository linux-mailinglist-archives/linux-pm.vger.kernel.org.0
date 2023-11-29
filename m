Return-Path: <linux-pm+bounces-510-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEDEE7FDB01
	for <lists+linux-pm@lfdr.de>; Wed, 29 Nov 2023 16:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 328FE282A8E
	for <lists+linux-pm@lfdr.de>; Wed, 29 Nov 2023 15:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A948D374EE;
	Wed, 29 Nov 2023 15:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B2184;
	Wed, 29 Nov 2023 07:19:37 -0800 (PST)
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-58ddc32f43fso45357eaf.1;
        Wed, 29 Nov 2023 07:19:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701271176; x=1701875976;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B32ouiV8wszxl16Z6gCKREM70b4o5qFAT461SnSNo7o=;
        b=TlxHxhAIwdNEuZYUWHvIZE2VZ00NMBWcoXu6+bV0nF/qF9UpyatLDo7NbbU/OsiQrS
         hnUlHkkKAaVBcB745QZXUXU28ffYOzoIkovcDkxFSmP3sjcSnE3DeLKnNXLd/oTwq+u2
         HgwiuDciP7G1tiQBX/aFt8IaiA3gkNrUG5uZ+17tQa1qalULuN14hlpWdKi0lSlgfVNE
         CyfLUT/qtDlj7SvrdBvVbreuamUGxFHSqVUA2Fx4Edf6t4JfEAOkKAR7S3JMgsyxcT8J
         gNJFpk0TXEaZoS/PRjqbiJBHPmfaGJGXtQz/sFKtAUisBO6KQAjocaa9BeuSSi6dqB6P
         mZIw==
X-Gm-Message-State: AOJu0Yz0iKDb0PS4A/KAZamSbq9qXJviewsiSM0pBb0IAN0/JtSAXfyV
	RcWUHeWytBpsPp3BSqKy5gEeMtSj1DcxfGJm67/hJScw
X-Google-Smtp-Source: AGHT+IFa8cTbrlNJ3lT+phgQUqELtwivOPydjg9FhDEZN5wTKs8RyH7qoecg8XkV6fJiNp3gFg71oWlIV0SmOvSa7RE=
X-Received: by 2002:a05:6820:34b:b0:58d:a761:5f88 with SMTP id
 m11-20020a056820034b00b0058da7615f88mr6729983ooe.0.1701271176098; Wed, 29 Nov
 2023 07:19:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231129143132.32155-1-jiangyihe042@gmail.com>
In-Reply-To: <20231129143132.32155-1-jiangyihe042@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 29 Nov 2023 16:19:25 +0100
Message-ID: <CAJZ5v0jfEsNVu=fg+Xa118F=hCGGB33U5SbiqWeCMaVMqNpUEA@mail.gmail.com>
Subject: Re: [PATCH] intel_idle: add Cometlake support
To: Jiang Yihe <jiangyihe042@gmail.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>, Len Brown <lenb@kernel.org>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Zhang, Rui" <rui.zhang@intel.com>, Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+Rui and Artem

On Wed, Nov 29, 2023 at 3:32=E2=80=AFPM Jiang Yihe <jiangyihe042@gmail.com>=
 wrote:
>
> Since the Cometlake C-State is supported, support for Cometlake should
> be added to intel_idle. Just use Kabylake C-State table for Cometlake
> because they share the same table in intel_cstate.
>
> Signed-off-by: Jiang Yihe <jiangyihe042@gmail.com>
> ---
>  drivers/idle/intel_idle.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> index dcda0afec..f83f78037 100644
> --- a/drivers/idle/intel_idle.c
> +++ b/drivers/idle/intel_idle.c
> @@ -1418,6 +1418,8 @@ static const struct x86_cpu_id intel_idle_ids[] __i=
nitconst =3D {
>         X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE,             &idle_cpu_skl),
>         X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE_L,          &idle_cpu_skl),
>         X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE,            &idle_cpu_skl),
> +       X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE_L,         &idle_cpu_skl),
> +       X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE,           &idle_cpu_skl),
>         X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_X,           &idle_cpu_skx),
>         X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X,           &idle_cpu_icx),
>         X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_D,           &idle_cpu_icx),
> --

