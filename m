Return-Path: <linux-pm+bounces-15438-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4535C997FAB
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 10:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD076280F3D
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 08:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511631F943B;
	Thu, 10 Oct 2024 07:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EWIlVZyq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C881D1F941A
	for <linux-pm@vger.kernel.org>; Thu, 10 Oct 2024 07:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728546158; cv=none; b=UJ5ldqkL9ly7ECDaZpkAW380J0QDli25lYzXabeULVHE7+IoUHrOBxgJWW9T2jHKzhyEJB/vV2xddOYKw+IlJQ6olyVqS+eRMdGjdm2rKwPsO82PFjrs8oZni7X3myXoWgU5DvaUjWpbDHSBIgnziftAtXsKWHXbu5jSD4tbhtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728546158; c=relaxed/simple;
	bh=STN6QxUVD2dVR9YjNXmUvMxd6idCs756ZvIov2g2HS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n+M+Oz/EWpOAKbgFjWlypgUY6ed1PRUxvP/4YrFh5gV+CKc3x9Ag8QN9M8ME71NbZVZzDKC26QCPoLACaPY5pBkQIZccm81ttJGkWnXJh+FFaIBNRf4igRSGjs8KX/QciHHBdBFaRVL1GXmmxur97qkSs6RxVeRvLDMx0/mgp8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EWIlVZyq; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20b64584fd4so5862175ad.1
        for <linux-pm@vger.kernel.org>; Thu, 10 Oct 2024 00:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728546156; x=1729150956; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rB9MS+OSoCKnJI226KdUhyLvFiOBCe/rn/d38cpBX4w=;
        b=EWIlVZyq5O6wIkFgkPNyb8yZwYEtsF3Dd14hJvOFnF9z7QGIodt4ZSOaJnnL+cwpO0
         EXBJ84VlHurNqQkgb+vyM4AueobgRmvDzp2sKCcJKQK2wZ6BOamVZjQ2bxkR/RM7Waus
         dZXkqEuoGYbq/hpMFYqevBhy+NCPi9VbiPBNpIde9F3Qy8tZFuiWe41ZO4fVgl/OWoAE
         TRxChtTFDms8dLxIu8aUUd2TKmYCbagLcmP/i8IO2Xx179zW5ONpSpMyr2M8K60sBhkq
         x/GycKvetQfxS1JLH3aB7j5fzUVjdUxSodXsvBRJZsHoq339syzpMBh3Z3x6/snC4s2u
         q5xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728546156; x=1729150956;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rB9MS+OSoCKnJI226KdUhyLvFiOBCe/rn/d38cpBX4w=;
        b=hIXe5WB0WToruNmjHj0kxPTvZaNh1AD+Wt0llnAGBF5dgUN/Xv09XIYMOrzbLBV8Ps
         2vwmQCarakECAspl2oPPZqpPd0JLBoI5aNgi1ggAWi0V+eTla+QiasMCheZ5WQIzfvUj
         kXzonz6uxZECgO/F3AfKE3E2wtuQJgmH5h3RgxID2XMZCW5RSe+i0yOv+nLNiG4bqLQQ
         i22DMNugeHzh9i1Yq2kB+MYyvXdRofSDJQH+n2qGjBXsd+aNva64NPVwik2skiydcf5c
         ro4nPVOpfBX64cc2CAM0a8qMQpxxK3/6BHuzMbYgF0lokl3VL3vr9aBV/zpVEzF78aQH
         sYWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWN9YChbM6oIucxaH7wGY1ut369MxVlqqTfv3/IbY7SAZVx1iJs9rXYhbBk79S814/FGVy95gU1EQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3P8b+KisI/lyM4V+idYnRIBjGCEONXmydU6YKgIvnUPdtdDVu
	cPQsU/aBV5BO7z5ZnWMTRtDbWNXKv3X1bks9nBwpoBQQIKv4fuGu3a5/Mos+25E=
X-Google-Smtp-Source: AGHT+IEq3hkzm6E1ohw2y557xveBL0B9VvN01FT/oaUkvjCiTzz5z2pb3BYkA2s+ALH3W5dnU5Cwzg==
X-Received: by 2002:a17:902:ce82:b0:207:15f9:484a with SMTP id d9443c01a7336-20c7ec8c349mr33908135ad.15.1728546156075;
        Thu, 10 Oct 2024 00:42:36 -0700 (PDT)
Received: from localhost ([122.172.84.231])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8c216429sm4693565ad.218.2024.10.10.00.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 00:42:35 -0700 (PDT)
Date: Thu, 10 Oct 2024 13:12:33 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Dikshita Agarwal <quic_dikshita@quicinc.com>,
	Vedang Nagar <quic_vnagar@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <quic_kdybcio@quicinc.com>,
	Nikunj Kela <nkela@quicinc.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Stephan Gerhold <stephan@gerhold.net>,
	Ilia Lin <ilia.lin@kernel.org>,
	Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
	Vikash Garodia <quic_vgarodia@quicinc.com>,
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 03/11] OPP: Rework _set_required_devs() to manage a
 single device per call
Message-ID: <20241010074233.s5rw7kf37glkgi2l@vireshk-i7>
References: <20241002122232.194245-1-ulf.hansson@linaro.org>
 <20241002122232.194245-4-ulf.hansson@linaro.org>
 <20241003071411.vvhqb6bxxnrbkaw7@vireshk-i7>
 <CAPDyKFodrKnmFNjqLWfv2AExqkfRo9DRrf7wqB4ht=XwjZDhtw@mail.gmail.com>
 <20241009154807.4i5qse7utnqbsoib@vireshk-i7>
 <CAPDyKFoL5ZB45s6sgxDusjXk6PhUCA6U-n73XGZGHbvwCtVrLg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFoL5ZB45s6sgxDusjXk6PhUCA6U-n73XGZGHbvwCtVrLg@mail.gmail.com>

On 09-10-24, 17:54, Ulf Hansson wrote:
> Right, it was mostly patch 3 and patch4 that I would appreciate an
> ack/reviewed-by tag from you.
> 
> If I make the rename to "required_dev_index" according to your
> suggestion above, it sounds like I could add the acks from you?

For entire series (with above change).

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

