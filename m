Return-Path: <linux-pm+bounces-15403-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A84A996CE2
	for <lists+linux-pm@lfdr.de>; Wed,  9 Oct 2024 15:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EFD8B2434B
	for <lists+linux-pm@lfdr.de>; Wed,  9 Oct 2024 13:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1013E1993B8;
	Wed,  9 Oct 2024 13:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kmDMX/dN"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54533188722
	for <linux-pm@vger.kernel.org>; Wed,  9 Oct 2024 13:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728482179; cv=none; b=oZeEIUo7LVjsBbd8GvQzser5mVQZHjUUPbXmZMHQkx1PcVujwQGWnPVR+jNEwTewZwT8nsz9l/R8M8Vhg4LdM0qgnQTcWudAzTumM30hx1ASI7W2pOB4hxRe6+DLoIQgrLMvKqtMi8zTuQVo9+raTEuBkUoVv5jPDvO5meGlIvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728482179; c=relaxed/simple;
	bh=T+2dki4VF39vIbkxA14WmXn9fcUYB2iyYJbWsFhcEho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uRzxWYNlEJ6GF+jaSbb6xIQhP0cXKKTx9Z5GAIBbTXRjk043kOZ7/yUcnKkY3jd7vUmDN61I1wTAdKMjNjwMvBVNj6k85VWaBaf9TB+kAijHqPhOCVbViAZSbLzLQYGhKHcgXiKfkWyGNN4DoOjITCZk37fUq2SAyFvYmr+77pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kmDMX/dN; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c5cf26b95aso8845453a12.3
        for <linux-pm@vger.kernel.org>; Wed, 09 Oct 2024 06:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728482176; x=1729086976; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eqzIa0/gJcE/R3jckuKgBAZRYij1gkFRfpN0McDvtrE=;
        b=kmDMX/dNqGgvG2B7pD/b+Bw/AVJeXvwaA6oMMW1sB+w2QpFQjO4iZnz6ee4fNTfRf0
         MZegLj+hCAFhvpy5LeeFk6Ib5ogTMbNclbbA6nAvsVokLxzcgBQdCERCXroboIHHesnB
         aLf18Wq2NAshFqSqcbg1OthY/BRQqPvCs7ACtvpUtAnbq7s5+ejWSGpCYZBBS6GICdeN
         1va3EgKePFwxetzaQVLRB+Q9oQREp10ZSOy3Q0azeLZ6v/vYKfs28i2ZPDBxhHagi3wd
         4wiWQTggsa4irdF6gSO/nIdAFXnIEmK4hrHZnqToW3HW8uO1ZL8vXOjdfq23woMvf7R5
         JgIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728482176; x=1729086976;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eqzIa0/gJcE/R3jckuKgBAZRYij1gkFRfpN0McDvtrE=;
        b=gjW7oZ32uLQtMqdKiRiI1woFWyFk0bA6pNjktz/JMk8wRIW/8cKkJqIWEx2EkihCUB
         /PaBR9B2Bs+ZvRfljusmXH9FiUK8I9sc7lI/2SQ27tGqABPCFW6ofZp6GyACDru7t/NG
         7BuGVzn7566HuBpquNFcvn5WygoRa551pGdSAZUt/d0xSzmD+g44NmVTJ/rNPuIuhQDb
         98STnIeUAA+lZ/v67cxfDSNRuBbnZE5cTN0BW/4/qJyyLCcTg85A+sZdZovRsDTWR5PY
         NnsYhGPc8ERwHqXuupz5IoaJQsp3KN9uwWklC+4vk+x4zk6LC3zq0CiNB/0Tr/G0t2rj
         5cBg==
X-Forwarded-Encrypted: i=1; AJvYcCVIqp+Ukyf0RPVvnvYZKPOswYCxV3xNUPOyb/c3RA/rgKVMFNq5Aaz4AGyPoHuFHphppNK9KQLI1Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxmuTydMOwTCLS/OG/i5EXl7UNLBIbdy5tYXp6uHs6e1rC2zsyQ
	p0WEXXOowVfMPIZAQNYOuAb/MEqBEKeiEQGVfpDHwGEbTyim9xlzknBg2MB34ocde/PE75O+i9W
	zHVjS/PSbD0+bYYbLt/GkaZgUeP1h3Yd+uFNwUA==
X-Google-Smtp-Source: AGHT+IEDY6oABmsxHfJH5XHnlxBxVUBDjjYbzSQ7G4OqYguEkOELI7IuE4wjfYZU10PNdu1UqtivL9VdxcrOfXoEUFc=
X-Received: by 2002:a05:6402:448b:b0:5c7:2122:472 with SMTP id
 4fb4d7f45d1cf-5c91d6f6df8mr1869844a12.36.1728482175636; Wed, 09 Oct 2024
 06:56:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002122232.194245-1-ulf.hansson@linaro.org>
 <20241002122232.194245-4-ulf.hansson@linaro.org> <20241003071411.vvhqb6bxxnrbkaw7@vireshk-i7>
In-Reply-To: <20241003071411.vvhqb6bxxnrbkaw7@vireshk-i7>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 9 Oct 2024 15:55:38 +0200
Message-ID: <CAPDyKFodrKnmFNjqLWfv2AExqkfRo9DRrf7wqB4ht=XwjZDhtw@mail.gmail.com>
Subject: Re: [PATCH v4 03/11] OPP: Rework _set_required_devs() to manage a
 single device per call
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Dikshita Agarwal <quic_dikshita@quicinc.com>, 
	Vedang Nagar <quic_vnagar@quicinc.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <quic_kdybcio@quicinc.com>, Nikunj Kela <nkela@quicinc.com>, 
	"Bryan O'Donoghue" <bryan.odonoghue@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, 
	Mikko Perttunen <mperttunen@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Stephan Gerhold <stephan@gerhold.net>, Ilia Lin <ilia.lin@kernel.org>, 
	Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, Vikash Garodia <quic_vgarodia@quicinc.com>, 
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 3 Oct 2024 at 09:14, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 02-10-24, 14:22, Ulf Hansson wrote:
> >  /**
> >   * struct opp_config_data - data for set config operations
> >   * @opp_table: OPP table
> >   * @flags: OPP config flags
> > + * @index: The position in the array of required_devs
> >   *
> >   * This structure stores the OPP config information for each OPP table
> >   * configuration by the callers.
> > @@ -48,6 +49,7 @@ extern struct list_head opp_tables;
> >  struct opp_config_data {
> >       struct opp_table *opp_table;
> >       unsigned int flags;
> > +     unsigned int index;
>
> Maybe name this required_dev_index as well ?

Sure!

Did you manage to get some time to look at the other patches in the series yet?

Kind regards
Uffe

