Return-Path: <linux-pm+bounces-4603-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D3186EA0A
	for <lists+linux-pm@lfdr.de>; Fri,  1 Mar 2024 21:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5434B22A98
	for <lists+linux-pm@lfdr.de>; Fri,  1 Mar 2024 20:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079FA3BB29;
	Fri,  1 Mar 2024 20:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q+jbGsF2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690783BB27
	for <linux-pm@vger.kernel.org>; Fri,  1 Mar 2024 20:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709323478; cv=none; b=IerpoCJYtVqlNkNhFk+6W3n0swvimwm5jwwwnLhnh0d2M17n9h6fJftsLZ/mJL8HgNXMqJCqvbWW9OvWQsAj6BQBhronfdW/M8wc90JmH/TM+kWLoSdn+ySW+/kIOn7ScOEYHjdZmClSS2pQn/YySfs/rVhKf+vq7P7FCxT+TXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709323478; c=relaxed/simple;
	bh=R5oeZu3MZmiPdNeeqv6OukFHlLZcN450keDyMqO0GUE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UTyTThnlDMVgL8FbhEx4IMCk8A23WohbszmZz5DJKDA5bTDx8Ufr1ytSEtDW08voGBKpphIO8H0sf0Ehl+A9ovp0eDs65TtBOoJFNQPSIanI1+eMISF+TPK5sNPIkbCEUjcZAhIDgDz0m1bL+wsexXwHW2LizMjMQQdLVSiPiVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=q+jbGsF2; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dcc84ae94c1so2479865276.1
        for <linux-pm@vger.kernel.org>; Fri, 01 Mar 2024 12:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709323476; x=1709928276; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R5oeZu3MZmiPdNeeqv6OukFHlLZcN450keDyMqO0GUE=;
        b=q+jbGsF2wPZ/JXhAMrFupjx4zeMCBrYX0gGhEnp47NcOAJHs7Lfz7xbfWt4+Mi/1QW
         kV5YwDpagkG9an0ZCVjv9KwgIu9dt3lSF7E/JRwpAwG4ja4g2WgtRBzKj3UUrR2kvsrr
         YujdrgJ7lnRj+76sXJ9TgqZPsgxbl1oH0VYqCh6/+cj8GdkF9M0vRvKL3hIkpXzFYLgS
         tCKjCJimqLla7UbybJhiND1UHnhZcERUXakcQ0widCo4DvWFVY7LwPA0Hzn+ATnJtldV
         BXnSc5hSMmcTxf1IN8bYNrYvc2SGBQshLDsv+aGubwoWGWfpm4XhK87twh8G1DBgqM9M
         Vu7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709323476; x=1709928276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R5oeZu3MZmiPdNeeqv6OukFHlLZcN450keDyMqO0GUE=;
        b=AM4QcdXGybI+NnZgDrGRc4tfLTSpYd5bXIzL1gf1DsC0VglBIn+rGY0pbyQjfuyG8Y
         KQ1AncQ82pLNoCBarbVWHwVUWV5m36YKVP+awAmfeIdc0AJdAD+Rj618kuG4xGrrCyhR
         tpyH5ljogHpj9TDZCzz7EFsFUNuoS81Swe0yh/p+fl37zChXZUUXlmld+ZgCZrDeu4FJ
         l5ov7T9z046LVeXVTx74ts5G69I6YVhMhbw/iLqWkoS+f6WyawicHelelG4FHvys3gA6
         wfKNMsNv23hByirYcts/7f3kNq6NdhUeemfvvBhnv631tPwuOEAGaF85Vt9XzMNBFTyJ
         qLQA==
X-Forwarded-Encrypted: i=1; AJvYcCWsZRvvmyX6fVVe5ToSJzAyZaPWm0EB2SlCBIw/Vv5siau/ydxkylC93vjRbcr6U4JbC5Tt1w3OlV4oozGACtMgR/pG4av9YrQ=
X-Gm-Message-State: AOJu0Ywf3ly3WJ8I89wE4IXtds8SY57AXB1VI5tOMvbzYAxvHqZ2NxLi
	TN2pBNAPjhNyEquB8/zBK3ZMhf6x+0eGwDBQrGFvqv+a2jvYM7KvsTAgkBavOthGt9Y8XTHyflZ
	meObFY3F1Z3dNFebadddwxlFAQhGTqQYBH8cf4g==
X-Google-Smtp-Source: AGHT+IEERwKVobzxEtEm7cJ4e3nbLqrW6YJjiZfXhLITgygWG31PEVgI4ANxEKFA5swXszNxIZzpyt7dNzDPzhJ+Oqs=
X-Received: by 2002:a25:83c1:0:b0:dcf:2cfe:c82e with SMTP id
 v1-20020a2583c1000000b00dcf2cfec82emr2513188ybm.55.1709323476391; Fri, 01 Mar
 2024 12:04:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301-class_cleanup-power-v1-1-97e0b7bf9c94@marliere.net>
In-Reply-To: <20240301-class_cleanup-power-v1-1-97e0b7bf9c94@marliere.net>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 1 Mar 2024 21:04:25 +0100
Message-ID: <CACRpkdbVUUTh+VA0Tjp6Y=L5nx-p6YKuJ5XjWYTm_Q_Kfmz9ig@mail.gmail.com>
Subject: Re: [PATCH] power: supply: core: make power_supply_class constant
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 6:46=E2=80=AFPM Ricardo B. Marliere <ricardo@marlier=
e.net> wrote:

> Since commit 43a7206b0963 ("driver core: class: make class_register() tak=
e
> a const *"), the driver core allows for struct class to be in read-only
> memory, so move the power_supply_class structure to be declared at build
> time placing it into read-only memory, instead of having to be dynamicall=
y
> allocated at boot time.
>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Looks good!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

