Return-Path: <linux-pm+bounces-19087-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C2E49EDF9E
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2024 07:56:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 971242838A6
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2024 06:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C113188701;
	Thu, 12 Dec 2024 06:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PLqe9MYQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92E5181B8F
	for <linux-pm@vger.kernel.org>; Thu, 12 Dec 2024 06:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733986594; cv=none; b=K3qvW1l7IWBjViyiLEjVfUOcBnGbvDGztso3bSjuxI/cb9TxSMQMb6I9y+zxxlmGThkYRWoVJttLjhDhHez3eqag0+oiYX/uAUTPzc3EhFB/0hMgVFFwiI9kvvZ6RgpOSo9gGQZHWaR1TxH0ARwfB+zf7+ePesInU4UytYnYpSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733986594; c=relaxed/simple;
	bh=B/Yhz2XiNDoxQD3tFO1V0tfLvQF27qroWQqn6kmZ3ls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GqbtnPK0rG+qXFuO1UMpl4WMUlkKSFL51BOml3QZzSRkFdvqeFWT9dj1EHxQkY2u4ABaXCDmyzH8fHEC9iqigllBfzwjqXQSpohSSGCEaSavzp2f11DrKoCvWUUM+kiT4teXDmgYKlgAQUIn9GxreE5SdLmNweytppLKNFlW1dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PLqe9MYQ; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21670dce0a7so2747885ad.1
        for <linux-pm@vger.kernel.org>; Wed, 11 Dec 2024 22:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733986592; x=1734591392; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=V7LbkwMCmLAaQYUZoVnQnJtPhNczH7UjhysTzF0HSs0=;
        b=PLqe9MYQlvWNtm1N9D1/ntq4LBE7qz0Q1wVt/K+DCDlq8HgAXiaLDQPmA7DEjL1Dcs
         5paBNKOc+QM5Qin6KRXcQUriCzDqts24B7dZPYk9wJDXamzUNCogEKewJB77R3GV2cAG
         wbTC4U9oBIYgXHjjyMYTbZYJnodzRE0h/WmaY55a0t0o2cesrlTeoHZm5mqXDh/E1qzP
         aJ+XuxpxOAAgvFsDXG8p7gRoIfTtUi7ObTMU7M8ZN/vW3gi/mDdsNYSU9Pg85x43V50w
         0dTc66UFv39l0r3rX4dQWZekJ+vVZWIfelDIPooIiJ036V37BhN2ipzlhScILF4y3pMq
         6ODQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733986592; x=1734591392;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V7LbkwMCmLAaQYUZoVnQnJtPhNczH7UjhysTzF0HSs0=;
        b=QY8Y19NtkAEjX+URTyCnu8ELjkmJmQegXarIQNtLFXhCAryPotANP4t/ORBMJIr4ev
         x6TMfac1sNx1crOplE13fBqf3uM9fgxBn7TyLngXw2KmABBop/JLj6/6twHebYiYtP2X
         IU0NDy6D9FKW0fZLGJViCAKGNQtouIQleXo89TLKoeWM94sAB9VllYjhFZbEa6wodjSX
         t3wCho3yYBQP1+CR79V+QU2nKSvb1+BbHkjcvhKS0AWVUKHl8OMpgZMUNQZzGDN912X2
         fkzp6TRxy9V0PBGrJSdrBf3pTnz5Kv2VrpGujWUgF9rZbnoEmzMhpNXWZVHVG7GwXFz7
         TjMw==
X-Forwarded-Encrypted: i=1; AJvYcCXwgaUI+08Uv4J9qXvvpTdNTTYw0ug2GWqP4ctiubXbxfIrBBDktSLTe8YC1oDu7w4Py1OapBPPdQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/gF+LtA43T+9dxAxY2oopokQFhTKFOuUAzyuHmGwAmOm6Ly10
	hoB6uYmNAwJe97tXgiYsUYAsGUzDev6m92Ost/Xn9z6gDDzrDvyYPOiB83bduBE=
X-Gm-Gg: ASbGncsT5lmphhi/JmOX5+kpn6c/qOoJwWuAa86tqhTCvGWpMe56X2vT4+vj5nE86pd
	a6SiVJjmkbCpWDI7Wfsxq9D76QqUr57Hv/ONpIFzg7RmIYhe/W/nDFMAoWP+nSHOwSpXEi7RPq9
	zlSOfBDZLXSxGeN5f4653MAwD5ZWAoHcPN4Ncn1NIjGAleU8HP3tpEsyxLn5Z0kv+ICL7oTEl0c
	9tuI04PYYFaCLkKrZai+vXuMYu6dDs5neg9xKC1ANkYF4EeIA5y8PWa3MQ=
X-Google-Smtp-Source: AGHT+IE5hSbu8aZNspz/v/cwW2sIJqEiSGnw7L2g9/MWfA7y3YObl11jJNPpN53pEg/ur61k7KkTqA==
X-Received: by 2002:a17:903:2451:b0:20c:6399:d637 with SMTP id d9443c01a7336-2177869886emr109699365ad.40.1733986592142;
        Wed, 11 Dec 2024 22:56:32 -0800 (PST)
Received: from localhost ([122.172.83.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2165590a8ebsm58557555ad.271.2024.12.11.22.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 22:56:31 -0800 (PST)
Date: Thu, 12 Dec 2024 12:26:29 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Xuewen Yan <xuewen.yan94@gmail.com>
Cc: Christian Loehle <christian.loehle@arm.com>,
	Xuewen Yan <xuewen.yan@unisoc.com>, rafael@kernel.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	guohua.yan@unisoc.com, ke.wang@unisoc.com
Subject: Re: [RFC PATCH] cpufreq: userspace: Add fast-switch support for
 userspace
Message-ID: <20241212065629.7pi3txrij5aqraik@vireshk-i7>
References: <20241209081429.1871-1-xuewen.yan@unisoc.com>
 <09acd46b-ec63-46ec-a239-e792c3061e52@arm.com>
 <CAB8ipk92xYEkZ_+m+xKnn2Z0DNOkum+6cgHUhSd_gbdzjAbOXA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAB8ipk92xYEkZ_+m+xKnn2Z0DNOkum+6cgHUhSd_gbdzjAbOXA@mail.gmail.com>

On 10-12-24, 11:27, Xuewen Yan wrote:
> On Mon, Dec 9, 2024 at 6:36 PM Christian Loehle
> <christian.loehle@arm.com> wrote:
> >
> > On 12/9/24 08:14, Xuewen Yan wrote:
> > > Now, the userspace governor does not support userspace,
> > > if the driver only use the fast-switch and not add target_index(),
> >
> > Which driver does that? Is that actually valid?
> > No mainline driver from what I can see.
> >
> 
> Yes, indeed no mainline driver, It's on our own driver.

fast_switch is optional but not target/target_index. Its incorrect to only
implement fast_switch without target/target_index.

-- 
viresh

