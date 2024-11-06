Return-Path: <linux-pm+bounces-17052-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E36169BDF3E
	for <lists+linux-pm@lfdr.de>; Wed,  6 Nov 2024 08:20:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A76FB284E87
	for <lists+linux-pm@lfdr.de>; Wed,  6 Nov 2024 07:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E9C1BDABF;
	Wed,  6 Nov 2024 07:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PGyGmiVh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD2D1BDAA2;
	Wed,  6 Nov 2024 07:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730877604; cv=none; b=ceq75tTwEVN2m6v9sNT+f0SAj/SolyNtN3pUHMvO5WJt0tSsojO7BD1GdxqeUwmKrpPU9F6stiRagis4PuIso9E3op4LHY8DK9p8Vd57N4sSuyZlwllL05ZEanvRkzZ5ImiNzy5GBd3ZRPS1hdb65HsHdnxIdCmzZui8BROHmL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730877604; c=relaxed/simple;
	bh=PkD1pDNi+SE7n4FTnQ6HlbOdb3kuf8fFkjPrzdG/sQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RWM4lua980qngQXWN/QhAcnetAOWOZ2W/9FHPnIDgfQYfTQyLqZ419tnIJ+6vd3JQlbWY2hdFfgvYciDWDBOWdwPHm4Yhpp14M9yuYbsc/V2bnFTQE7UGfpxd1gPCqnCmou9ntqQO0JF1oBSXQhgxba3hb6fbL/OVQeJfAqvo9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PGyGmiVh; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5ced377447bso4320729a12.1;
        Tue, 05 Nov 2024 23:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730877601; x=1731482401; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vRtfotueanFyuwOcdsHrcVQgySi4mNzZ2NNuN1ktvAY=;
        b=PGyGmiVhwkiNLaieoMO8Dl6YyFCDnNleUIStbXGjcNtGUhZDtHH1puuSmz+TGJxy7N
         gErUnUv/KGaJ/Cqno+pKYOKGe/wRbQM8qUJN7ceG2qbkXxIiTaoKFYxaboCa4re2gvVm
         JBN5vfjic+jHTacrwvVE3pvRfrq/9Gp/ep1bOeELzhEVLtqZSbnT39lheXsYbU8ISJkB
         sksMq0Bh2i1ISgP7N9tBoehfdkvGIl+ypp7FNkCP3ArChAznD0uf9m+/NbvVJ4F6A58I
         bAraci0nH4mUdxbvb5IFXJxQ4oKW9Vo77hEhQF8hhmkf2LL7g8WAZsegBMKFNbfE7r52
         KqZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730877601; x=1731482401;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vRtfotueanFyuwOcdsHrcVQgySi4mNzZ2NNuN1ktvAY=;
        b=uJDKxlk8Z4485s234EHSzvhoaSCuJ7AwhGvhRdWITiJVIOPx1cbq3dlo/oV8Z+QRXD
         04j6sKWarLgGJwHE0okcuY0mVr0Sc1AgVLieRjm/Qy/ndCLKPeZoJ3woh9OUbujvEnVR
         jK8g+EE57y4kV79MnSWu3Lx8tb8cHaH4zr4/N4FyEpa8WNLDyrxLYFXq9uzeEJrYRDS0
         MdrL36W9HO37pIoUba40r/EeXZAszeuubZCcJSIg+SjCcZ1fWT4iWNP12H9j+jCjEwpF
         fdzsnmu1cAkNroZKNl9h7TeEsa+CX+jF+H9fLN+Q0o+yAEiTFmBJFshHuKPprBNtltFB
         Nh2A==
X-Forwarded-Encrypted: i=1; AJvYcCUR8PIwrpog0sUpW7hpJJdfK70GwICGBpdQXEkKuS3QNhlZ+H7ZAkbhsq+UEVUxHSMTX9gzujpUyTKR@vger.kernel.org, AJvYcCV3lyx0Falb+9tFvvdxKWfr2JUvF4hlaTiSL1Wl3wy/Qs3F/u/oBYgCZRmsScUIU7rAhYvA88MXyhS/7aVr@vger.kernel.org, AJvYcCVgc7p6pRN9q92n1wpQYMYsyjIde6JFnMCACH+WQMJ4keaPWhYUytpEuYQWjUiJ53eOaZswJzlNniA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKrg5PjfyGpkg6i2I3PC2ObbX4BYe4SDhEyr4BdkJDDXTTh4uq
	302OVIvJ99WNzB02zYR4TJ1f033hHCCRFYduUfzKA4jQ3Kg5OJO5
X-Google-Smtp-Source: AGHT+IH/ZAmYF8ReqMplFnxCbkC6IEJQAH0xL9boLQxzwMi1ilf/4qqxVXYZJqpVYu6kWqLSMbfZzw==
X-Received: by 2002:a05:6402:1d4c:b0:5ce:de14:65d0 with SMTP id 4fb4d7f45d1cf-5cede146642mr6064626a12.0.1730877601136;
        Tue, 05 Nov 2024 23:20:01 -0800 (PST)
Received: from standask-GA-A55M-S2HP (lu-nat-113-247.ehs.sk. [188.123.113.247])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cee6a9a3f9sm2301453a12.7.2024.11.05.23.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 23:20:00 -0800 (PST)
Date: Wed, 6 Nov 2024 08:19:58 +0100
From: Stanislav Jakubek <stano.jakubek@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: power: supply: sc27xx-fg: document
 deprecated bat-detect-gpio
Message-ID: <ZysYnmWYTFzMBVMj@standask-GA-A55M-S2HP>
References: <cover.1730720720.git.stano.jakubek@gmail.com>
 <f334c973dd4e6390a0cd51dbde358277a07604d7.1730720720.git.stano.jakubek@gmail.com>
 <atetahoyv7iz4hvw2avx6gs6kit6owvmfsniorkmzrqhl2gvgv@iwdz7uzcpxcy>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <atetahoyv7iz4hvw2avx6gs6kit6owvmfsniorkmzrqhl2gvgv@iwdz7uzcpxcy>

On Tue, Nov 05, 2024 at 10:03:16AM +0100, Krzysztof Kozlowski wrote:
> On Mon, Nov 04, 2024 at 02:03:58PM +0100, Stanislav Jakubek wrote:
> > While the bindings have always used the correct 'battery-detect-gpios'
> > property, the DTS and the Linux driver have been using the incorrect
> > 'bat-detect-gpio' property. Document this property and mark it
> > as deprecated.
> 
> Well, I would just correct bindings instead - much less changes needed.
> Document 'bat-detect-gpios' (note the 's') and drop
> 'battery-detect-gpios'.

Hi Krzysztof,

this approach was preferred by one of the Spreadtrum maintainers [1],
so I did it this way.

[1] https://lore.kernel.org/lkml/CAAfSe-uC+G8iEk_37vBr3+dQsv4a4tTTsz11hUguVRnU=r+4qQ@mail.gmail.com/

Regards,
Stanislav

> 
> Best regards,
> Krzysztof
> 

