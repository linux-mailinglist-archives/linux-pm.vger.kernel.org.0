Return-Path: <linux-pm+bounces-15453-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B5229985F1
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 14:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D35E28364B
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 12:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8711C4627;
	Thu, 10 Oct 2024 12:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FY45FaBe"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663181C4623
	for <linux-pm@vger.kernel.org>; Thu, 10 Oct 2024 12:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728563371; cv=none; b=dw5Nnc9ejPpv+OgxMx6Q7heW+Jc9xMrcGmewXF/rQ6KWYKiwSeZEMVQBYoO8t466ZUJYxRgygMEJY5yPHKcFDOn+ZXjgGThXrqniN0mOj7GQebn4wCSk2/ohX9HHQRL02IWyZ5XZKqtkXluHDiemEbxQBl4DzxdjUL/5LqjjvfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728563371; c=relaxed/simple;
	bh=44T4IapdZnoTohIlpRgC+8phnUpSTO6y3z62We4jQQk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CkI1+8DTdFI25YKsn2GWXssCONZgkByTuan9nNh0PL6pSRjV2148peTSHFJw1QwQ2k0nL8/qUZma8L8Otn/kmbYsx7WQSWuxZC5/hzR+EesYg0hRQCpsh3MJUKk6vQEJ0Vt3CEhhYf3eCpuRu8yFiz9hmx4DsJTbrhxa5hdhhI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FY45FaBe; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e290200a560so734339276.1
        for <linux-pm@vger.kernel.org>; Thu, 10 Oct 2024 05:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728563369; x=1729168169; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=44T4IapdZnoTohIlpRgC+8phnUpSTO6y3z62We4jQQk=;
        b=FY45FaBePKxQZO8hP3aDwm/oV6sSk/pQwyF/aRri/KUSukBKtKRt7RnUaWRWVl+Mog
         pchcnLObv/m96eupNpf07oNdGpjdx6zyWLvJ8wJ3j2VN/Nf1VfF66rfDve1gHlEbdVS+
         /EBovdwJWavbOugaXXgeEyyfpWhD2Qr/hJBG0XFSVWwRJCNYeDp66A/ofqJAgX5f5Lhj
         CiDcx852CbJcMzaDGIvdVvIHQkCxM7NYkxsruPijq7b3ss7cqs+evH1JcH+1Ifl2gqcj
         15wle2SVux4ivwfOknkhxqVCC2rw7gKhHRdXjVbYq+ZIPe1ep3PfuWJ+pcAcOLuo4Yur
         Y4iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728563369; x=1729168169;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=44T4IapdZnoTohIlpRgC+8phnUpSTO6y3z62We4jQQk=;
        b=LJ+/UxPQqHgZ7RMAJDh924t//RchKHdzRYxIcU7jo/ewcD1VLhw1n6CX9Xaw+agRaX
         vRUB0cNPMi9SQ/7DnsuMtEhI/PFbKIB6+wfHUQ+Jx3G3SiZ8eUCx7nntMBhN7YiMzDtS
         4sSINfahbbr5zLBLRLqOCxasxRUOYlSSr0UlAAWka4w5bTfqdwIVMk+NdOkv5lrPD6gO
         YXuu8XwBskPlYl4XwTRaPUWpVtUYyqbjtgHzEnx1ZasA8ecsU8ieSYgXIVdUAzXWJ1CJ
         dkVF6dm8DGuy/KlkxIdcQiiIJXkv6Y3eNSPqxFVyXa2EK4mRmxJh/VTu6Xt6r2zSCmdQ
         Z+nQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcOAkp1knhobSS4VMVHU2iE9ZYYg723y/YMRpdkmjKuTBEzD1SKgyE8R8+lpcCmHZGi1neoPF+8Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7N2dh/DDXc8vUvk8/cAHoik0wSlaAHWEBmfj+XY+eMz7gbrVU
	steicYSAm3Hm59ZEMhQuSMBEOO8RFwMFGawEqG6UpzS2jvioRYYh1eekn3qthoAkIwfTaSOyvSY
	H//1P6iWr/ZHtbI8qUParek50bMq1wQ4cqnvJeg==
X-Google-Smtp-Source: AGHT+IG3oTM4jcNG4N9rMxIqsRyiuo6YNtiGyzfUWDHQnGPUpPtD9Eezjashtg5T/HD2GNj1E7tQ5++xutKK5GSUZO0=
X-Received: by 2002:a25:ce11:0:b0:e29:e36:9cf2 with SMTP id
 3f1490d57ef6-e290e369e4amr1256926276.19.1728563369381; Thu, 10 Oct 2024
 05:29:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002122232.194245-1-ulf.hansson@linaro.org>
 <20241002122232.194245-4-ulf.hansson@linaro.org> <20241003071411.vvhqb6bxxnrbkaw7@vireshk-i7>
 <CAPDyKFodrKnmFNjqLWfv2AExqkfRo9DRrf7wqB4ht=XwjZDhtw@mail.gmail.com>
 <20241009154807.4i5qse7utnqbsoib@vireshk-i7> <CAPDyKFoL5ZB45s6sgxDusjXk6PhUCA6U-n73XGZGHbvwCtVrLg@mail.gmail.com>
 <20241010074233.s5rw7kf37glkgi2l@vireshk-i7>
In-Reply-To: <20241010074233.s5rw7kf37glkgi2l@vireshk-i7>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 10 Oct 2024 14:28:52 +0200
Message-ID: <CAPDyKFpPfd5bzPwDnxU6-Xcc5HA6qXWHQkRK6vq=BZ3SqqXL+A@mail.gmail.com>
Subject: Re: [PATCH v4 03/11] OPP: Rework _set_required_devs() to manage a
 single device per call
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Dikshita Agarwal <quic_dikshita@quicinc.com>, 
	Vedang Nagar <quic_vnagar@quicinc.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <quic_kdybcio@quicinc.com>, "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Mikko Perttunen <mperttunen@nvidia.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Stephan Gerhold <stephan@gerhold.net>, 
	Ilia Lin <ilia.lin@kernel.org>, Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, 
	Vikash Garodia <quic_vgarodia@quicinc.com>, linux-pm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 10 Oct 2024 at 09:42, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 09-10-24, 17:54, Ulf Hansson wrote:
> > Right, it was mostly patch 3 and patch4 that I would appreciate an
> > ack/reviewed-by tag from you.
> >
> > If I make the rename to "required_dev_index" according to your
> > suggestion above, it sounds like I could add the acks from you?
>
> For entire series (with above change).
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Thanks!

I decided to make the small amendment when applying, to save you from
another round of patches on the lists.

Kind regards
Uffe

