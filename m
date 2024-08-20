Return-Path: <linux-pm+bounces-12562-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B0E195854C
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 13:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A630282E2E
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 11:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACCBE18DF80;
	Tue, 20 Aug 2024 11:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="tYTRN81v"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B1A18E375
	for <linux-pm@vger.kernel.org>; Tue, 20 Aug 2024 10:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724151601; cv=none; b=n2JLIlZd95WnWUugdwcljDKdPBfJx+NdyD1OewZ/72k9UHhBtbn2Tg5eJaXe6qfnhp1q+nQUNl/0nmUvw1fMHeaeY37WcDWr6OrLu2eVr1rrhAnjdHxIqkPd2aF8ClpzTlidJ/O8VNVK5AuCNH6pfkPaFpPEWc0lYZW9Q38huyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724151601; c=relaxed/simple;
	bh=x+cc/NQ4+B/XG1Vu9ua+mQPNBaWEIBcAOi8YcjrS8nI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vu/l08Fsmr0BBSVsf2+pf3rYWyPPem6Y23ALc0GnObt+Jad2+JYVvv0zcVOPQWnlkY6CANVuWAPcgdPRpHM7NzpdSKfkqc588tTXt6xvHEXUamLehGQmZmmFDF6isCoooC8YaQuZnq7NSyjZTpyVwTsCIrjdfHwMXb98Gzn/kLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=tYTRN81v; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-39b0826298cso18349415ab.2
        for <linux-pm@vger.kernel.org>; Tue, 20 Aug 2024 03:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1724151599; x=1724756399; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GN+EIjpNUUx5GfQqCYudQRJbl+lPpTDJG3imDxVORnA=;
        b=tYTRN81vaEB3nbuA1VJ8bg4jU37PWWJMAdUoQfCSaHbYaiJFXUHb0tHPmy9QcbCVCu
         M7lfmQjdukyX2ttggi58Xqv0WYirWW/LsFYFF01ioS2Fb72fPfpKRRFgW+RbygZqDnZJ
         dTeGZCq04+9FQ3sd2PIskOMEDqfel7MG+cAg2K8U9PPS9YBEyVSvxmPsQW4tmBGq2L3y
         rg8Vc84SNInlZxTKVD4oj838Ypa3asbd3SbpnAYzP2X6kifMic7P3r97aTILreoRwVcW
         zkcZ8Aw1TFuEtd4UKU13GsiLixN7ON/Pj673KkDv/5sLI/yi/2+tmDlZ598I8qTRv96f
         27+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724151599; x=1724756399;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GN+EIjpNUUx5GfQqCYudQRJbl+lPpTDJG3imDxVORnA=;
        b=A8bRUUczqxfv4v6LwW5zUx6WdsM7jPVzqB79u5zxGX0xJBol+IJiPTwvPrIN9YLLVV
         TUfcqzoSUzUn2NHz7P/6QkFrvyYOPjf8YhZc0Iw5I0hMk08A/VCXIaj9gv2Hi7IIG4W/
         N+fvyHEvtQcRpZh3RQ9yuLpctTF6eOigfl1zoL6OiJ3mALMyYuxkaC9kJmH5bndeHaJi
         8RFnwIs0Fq5hZNkGbv1jXHqohhdNp61kRlfTl/bBOZl0uZgtH22YUi5EsvqPh/YCZ0K+
         HjDUOqcqqUB6EjprpVxkQllPKYWb4s5WghQUXJ9yDaMDUoklKz3YmMgiT4XWA/ms1chJ
         O4xg==
X-Forwarded-Encrypted: i=1; AJvYcCWeVwrRcBwOyYFHohJwoBp5jrHisexnuR9mPLvs0s5GW1s3einmK3pLpAH7SimIjB4Pe+WUEwjhCaVQehcPiuK5ukLCI9LiVsc=
X-Gm-Message-State: AOJu0YyNOfCXS+Vo5eieCQJ2iboG2DO7ZU0v8c8+ifExrLATUsJ7lo7/
	WE/YbGaWEtzz/J9r81iIqgtCDF5yjcrxtRSszrSl7fV/v0QZMp6otJsgHFOpQEL4cGaCpoOh5OU
	VjQluEGBxCbXAxqdXhnyALXnRjIIY8mdBV0VoTA==
X-Google-Smtp-Source: AGHT+IHqjjn2UapHpnmuaFhmYQPyeSNmej7VILcZMgUpLXZilMbqo1VtVFSgCamg32GBi9wtyoqu+sC1TyQmb5Inz4w=
X-Received: by 2002:a05:6e02:152b:b0:39b:2ceb:1a23 with SMTP id
 e9e14a558f8ab-39d26ce6283mr152753085ab.3.1724151599259; Tue, 20 Aug 2024
 03:59:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240820094023.61155-1-krzysztof.kozlowski@linaro.org> <20240820094023.61155-2-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240820094023.61155-2-krzysztof.kozlowski@linaro.org>
From: Anup Patel <anup@brainfault.org>
Date: Tue, 20 Aug 2024 16:29:48 +0530
Message-ID: <CAAhSdy00N62pZfMrBTMASaZUqW6L-zEe_BqNZ4ZsOWdEvxHDZA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] cpuidle: riscv-sbi: Simplify with scoped for each
 OF child loop
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Atish Patra <atishp@rivosinc.com>, linux-pm@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 3:10=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Use scoped for_each_child_of_node_scoped() when iterating over device
> nodes to make code a bit simpler.
>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

>
> ---
>
> Changes in v2:
> 1. None, only Rb tag.
>
> Other patches from the set were applied.
> ---
>  drivers/cpuidle/cpuidle-riscv-sbi.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/cpuidle/cpuidle-riscv-sbi.c b/drivers/cpuidle/cpuidl=
e-riscv-sbi.c
> index 5bb3401220d2..d228b4d18d56 100644
> --- a/drivers/cpuidle/cpuidle-riscv-sbi.c
> +++ b/drivers/cpuidle/cpuidle-riscv-sbi.c
> @@ -448,7 +448,6 @@ static void sbi_pd_remove(void)
>
>  static int sbi_genpd_probe(struct device_node *np)
>  {
> -       struct device_node *node;
>         int ret =3D 0, pd_count =3D 0;
>
>         if (!np)
> @@ -458,13 +457,13 @@ static int sbi_genpd_probe(struct device_node *np)
>          * Parse child nodes for the "#power-domain-cells" property and
>          * initialize a genpd/genpd-of-provider pair when it's found.
>          */
> -       for_each_child_of_node(np, node) {
> +       for_each_child_of_node_scoped(np, node) {
>                 if (!of_property_present(node, "#power-domain-cells"))
>                         continue;
>
>                 ret =3D sbi_pd_init(node);
>                 if (ret)
> -                       goto put_node;
> +                       goto remove_pd;
>
>                 pd_count++;
>         }
> @@ -480,8 +479,6 @@ static int sbi_genpd_probe(struct device_node *np)
>
>         return 0;
>
> -put_node:
> -       of_node_put(node);
>  remove_pd:
>         sbi_pd_remove();
>         pr_err("failed to create CPU PM domains ret=3D%d\n", ret);
> --
> 2.43.0
>

