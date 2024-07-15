Return-Path: <linux-pm+bounces-11097-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 043389312EE
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jul 2024 13:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B48262817FC
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jul 2024 11:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5C018787F;
	Mon, 15 Jul 2024 11:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MVnXAzCs"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EC216CD36
	for <linux-pm@vger.kernel.org>; Mon, 15 Jul 2024 11:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721042280; cv=none; b=SxPhqVZUJWJK1mD/pDHbcpzc3VUJfW/JReLmYLtdOEcnF9jNuljE/vJdjodEXUam+fN5zWmdp0w43Hw6PKPXW4aHpHWs5Jfl55wbFeSnUCXowI/PlZ0ypE/MFibfDXwW69TYBZHaCAzUqlTwN1ZEX4hd2YcAE7pT5d4XOoYvLqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721042280; c=relaxed/simple;
	bh=F6nPlNFjvSL5hHKaGrRmsMQTJQxHkN7LmQRO1aSkssc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h/FdOS+PNDX/ut2noXw7gu2jYtPx4nnY2ggVo+TQAyPwDvcyptzqjhTjR7QL7CJb8yWogpo1eDNvngacbAzVxtM84yf9rr6vCZCJyFol9poCoq6srs+PLzb4bGl3W7Ik45x7vvOeFFWN9DncVT4F7Qgm5zmunYZE8WTeZKAjIn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MVnXAzCs; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e03a0faee1eso3884227276.1
        for <linux-pm@vger.kernel.org>; Mon, 15 Jul 2024 04:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721042278; x=1721647078; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Y0nsMHYvyytvB0GcQcRWQhieGQMx8L/l5mGgk1F9IiI=;
        b=MVnXAzCsfhZEPtwFLcMjltELzRMY6ApC2/zYeBWgQikVmyAgeNjO2NdYGynJ5zSkrL
         RunPhGA7Xw4F3hlby5PHbTSXEDypY+ehP4qzEuoBrza3UdA8+6acQyY/sjxMVdTGtNw+
         Oq5SlKdBfqK657Q0s0F9u1QItDvMDAMTS5pTnB3O1CDfdvzGtlytVtQpyvaJfsyuaWiX
         jf8IKo/ALPOKnFOpiW6UIpV8A7/Zj+kzRa9Zg7EVmPWO1axcg3dqZD2QUovC7mpdihME
         foGJ3LYKAq2UAJBqHae4oZpWDAVSMPQYueO9OgAVVK0wXpt2J54XEEhAKiBHBhCqvf27
         sXYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721042278; x=1721647078;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y0nsMHYvyytvB0GcQcRWQhieGQMx8L/l5mGgk1F9IiI=;
        b=JNpLEe2GPuFt7xz9IeA3vmAVHYIEVOiFNASC0PZRkA2HM/j47QKwXwJW/exhrJo0YG
         8aWbNHPEtnqg30g83A4tExRMsmnNpuXUtLu/GRSMDPddUlHZkHB4cTv9iRBObLIdWMhj
         GsOuJb07naX/9wA9MNvOz27atr9Zm0sTrbwT4kDn2MDtYTxu56wW9Xy8MRla2AtQyzSj
         FqFluFFrvoT2WJ9lum9WESdB3Tv3dlU28Fw6ozJ1QGCaJOvDgiT2SCykeUetMUAcU2Fl
         QYHx2THPpAwJY5zSy8sbkGqu/53yMZPWt/yd4Au3BxrW0fJ3VGUzFAfIFPY5jWAFm7QF
         hMNA==
X-Forwarded-Encrypted: i=1; AJvYcCWPLXJNHslr1Qy6hPu11kGf+cEKojohiEX2KFwp+wu0kheYGyV/HJC0Q3NIUjJmGyqyI/LUSRkRApPB+UBQmusUkM7KvkkaF04=
X-Gm-Message-State: AOJu0Yx51vTo9oaaImmi+jWKxoJIxs/quCFcnPXpf/YkIZCEmFIkBWmQ
	kWf6d0s/giPgy9JJuIfB0AA9+DKnzdO88xqV80TWdEp+Na2EcoIy/nFAibvBVl64u9TcNIFooUk
	yGd8K+68FAPsSyHdM/trPFa0ZShNQrgvYhYNWEA==
X-Google-Smtp-Source: AGHT+IGLXkpZxf5SwZRwilp0h5f1EqxnZ58jIcQl/Dg8fhJhziq7OC9pG7TnHNdfC3tUtLirO7j3kKAjrv2vNsA4rao=
X-Received: by 2002:a25:7408:0:b0:e03:34ec:16b2 with SMTP id
 3f1490d57ef6-e041b11d31amr20722985276.42.1721042278123; Mon, 15 Jul 2024
 04:17:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1720763312-13018-1-git-send-email-quic_dikshita@quicinc.com>
In-Reply-To: <1720763312-13018-1-git-send-email-quic_dikshita@quicinc.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 15 Jul 2024 13:17:22 +0200
Message-ID: <CAPDyKFosMMAWfiEvpaXHn5X+fEL=Asi=o-YEa9Hj5AYzyoRcHg@mail.gmail.com>
Subject: Re: [PATCH 0/2] add device managed version of dev_pm_domain_attach|detach_list()
To: Dikshita Agarwal <quic_dikshita@quicinc.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, Vikash Garodia <quic_vgarodia@quicinc.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	"Bryan O'Donoghue" <bryan.odonoghue@linaro.org>, 
	Stanimir Varbanov <stanimir.varbanov@linaro.org>, 
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 12 Jul 2024 at 07:49, Dikshita Agarwal
<quic_dikshita@quicinc.com> wrote:
>
> These patches add the devres-enabled version of dev_pm_domain_attach|detach_list
> in pm domain framework and use the same APIs in venus driver.
> If any client drivers use devm_pm_domain_attach_list() to attach the PM domains,
> devm_pm_domain_detach_list() will be invoked implicitly during remove phase.
>
> Dikshita Agarwal (2):
>   PM: domains: add device managed version of
>     dev_pm_domain_attach|detach_list()
>   media: venus: use device managed APIs for power domains
>
>  drivers/base/power/common.c                    | 41 ++++++++++++++++++++++++++
>  drivers/media/platform/qcom/venus/pm_helpers.c |  5 +---
>  include/linux/pm_domain.h                      |  4 +++
>  3 files changed, 46 insertions(+), 4 deletions(-)
>

This ended up being a little bit late for v6.11, please re-post a new
version when rc-1 is out.

Kind regards
Uffe

