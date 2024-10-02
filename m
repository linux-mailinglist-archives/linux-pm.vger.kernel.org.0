Return-Path: <linux-pm+bounces-15047-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F186398D1DE
	for <lists+linux-pm@lfdr.de>; Wed,  2 Oct 2024 13:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F3E71C21F5C
	for <lists+linux-pm@lfdr.de>; Wed,  2 Oct 2024 11:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1ED020012D;
	Wed,  2 Oct 2024 10:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hybYEvhu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BD5200129
	for <linux-pm@vger.kernel.org>; Wed,  2 Oct 2024 10:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727866787; cv=none; b=HJ6YvFH3q2+x7V+gsKKF+aLDnJXxO4Ym9vYJi8jGrWwFFPkSO3PITDVZ/vo2Z+/mssCUH6drxN6e2A29zW+L0T+C+QAttjMrqZYB5kZEyJSQgo2qvDXzjfoas3qBIQpJWi8vs8gg0n4jLZWGQRAkDQPcPvtLGez4ZAIhpgJr3Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727866787; c=relaxed/simple;
	bh=arWEj26OYvQPspC84HQha4peufBrbKdb6Dt00ZcNb/o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f5/a8/BWrqu2cqhgbPpQztSk8qwffmi6lpKIVQFSeHB1AE0KFxWkP13bwxw3wq8sKKxx7XM2BI3skWcBWzZfly1Nvyg5hWFtsZ2BK8RDORoucRizYr75p4yFFOQtX/eK8d1wnr1i7lWd/pRFAqUaIi90+01m9HGiZmtUZgp83QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hybYEvhu; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e263920b6bbso597051276.0
        for <linux-pm@vger.kernel.org>; Wed, 02 Oct 2024 03:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727866785; x=1728471585; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eNwGlqBOvojI8yNCjRtK6m3A2XGZPqaWNHHuGGkMaAc=;
        b=hybYEvhu4iOS6lvWeMx8qto+LFfpkAmYVi4yk/BirYwvzlXOsCXd/OcnRt/PxMtmtu
         maNC1C8eN1/EG1f6dhxnaGfaiffXakQgYB5aneAn7oOguk2nnO8asffDJVz9JQi0+BDv
         KHn33uaQmfSARj5Nz1XFeK8LxE+rxx4P/hroo7rvVE0NLc+59p7gGCLEyC1joXOMCxds
         oT/XsPKdKD+JR0+dg78zSi/L0BJgFWqqKxAodZp4X48Zgy3/7TXBETNhr3beICfx+omt
         6ZhMbQmehhevFNVh04jOJYVMjUjf7UbZ5tlQXoV0gQczaiufDvj6pduHqfsrcH/KbK2Z
         wjhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727866785; x=1728471585;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eNwGlqBOvojI8yNCjRtK6m3A2XGZPqaWNHHuGGkMaAc=;
        b=FMOBHXHE4kmR+/1gxH7d+vF/9wiPjamGnKMsl8sAwpvlcyhd9yPx3z6qpCo2R942QQ
         2wfkOjz/j6wiTeApFNvKbccvxwlNuqaMo1PJACMi3y+IoDdyhdQJVhqlCd5znCiqF4lG
         zlHPQTSwHzKyGn2jujyBW3bMqjGWu8X2jVRF4Gaxa8FCfKruTX8Wr7S6E8rp9ksQvE/b
         DTrBJFXJiE3c5u37leMrFVMMxuaReirQQ1h+E+YnL9orBTyPaxwa0lz/FCp/uXOKHXbF
         FLSVZAZPcOFMLCr2uR/sgId+MvhBzHxtba/dOeTXT2JcGleVwM6gw/XcFHbbKDlXQ9QY
         BIAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOKNlEdTnhUXXu8ysndNlK00oOjwZMxY9SmGaYpp2Eyd5ewd5/4N+2mZRjrjxCO9Df758SdVj/XQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzRWIJFHIirjA9b6hhAoaK7yiVgod3ml+4StYYe/9ptkU+thei6
	B4cGpKmasGlY9d5petrZbO9m0Qej4+6yG9jlFYA2SQ1uTY4Gcp66mArElgTpOE9Pfs7LGffZGl8
	/gktxtZsDNowUzy5mK5I3g3FkjBswnIMwmCqh4A==
X-Google-Smtp-Source: AGHT+IEDoNnpjZ8L1Ywdhj5U3o1j/X3Z3qd9+DvHP0OLqdPF5OZl/Kdeth9Den9N5+QIL/8SSqu54jIDEMZQvg/eiOg=
X-Received: by 2002:a05:6902:e0e:b0:e1a:9024:85e8 with SMTP id
 3f1490d57ef6-e26383cacc9mr1889771276.10.1727866784903; Wed, 02 Oct 2024
 03:59:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926134211.45394-1-zhangzekun11@huawei.com>
In-Reply-To: <20240926134211.45394-1-zhangzekun11@huawei.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 2 Oct 2024 12:59:08 +0200
Message-ID: <CAPDyKFogjPsZMDPQ3pBR-8WhkOMH0W76FX_sQY2ZKRGC5XMugw@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: qcom-cpr: Fix the return of uninitialized variable
To: Zhang Zekun <zhangzekun11@huawei.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, linux-pm@vger.kernel.org, 
	dan.carpenter@linaro.org, chenjun102@huawei.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 26 Sept 2024 at 15:56, Zhang Zekun <zhangzekun11@huawei.com> wrote:
>
> The of_property_read_u64() can fail and remain the variable uninitialized,
> which will then be returned. Initializing the variable "rate" to zero to
> fix this problem.
>
> Fixes: 181c8148556a ("pmdomain: qcom-cpr: Use scope based of_node_put() to simplify code.")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/linux-pm/455a6a49-41d2-4a20-9a31-f57ee7a67920@huawei.com/T/#m0a62b501b453a6d6e94c52a428a66f65b5422c65
> Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/pmdomain/qcom/cpr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pmdomain/qcom/cpr.c b/drivers/pmdomain/qcom/cpr.c
> index e1fca65b80be..26a60a101e42 100644
> --- a/drivers/pmdomain/qcom/cpr.c
> +++ b/drivers/pmdomain/qcom/cpr.c
> @@ -1052,7 +1052,7 @@ static unsigned long cpr_get_opp_hz_for_req(struct dev_pm_opp *ref,
>                         of_parse_phandle(child_np, "required-opps", 0);
>
>                 if (child_req_np == ref_np) {
> -                       u64 rate;
> +                       u64 rate = 0;
>
>                         of_property_read_u64(child_np, "opp-hz", &rate);
>                         return (unsigned long) rate;
> --
> 2.17.1
>

