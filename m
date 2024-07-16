Return-Path: <linux-pm+bounces-11129-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9FB8931EBB
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2024 04:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EEE6B2192D
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2024 02:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC09B4C74;
	Tue, 16 Jul 2024 02:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YVnqDJCD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF28101EC
	for <linux-pm@vger.kernel.org>; Tue, 16 Jul 2024 02:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721096253; cv=none; b=Y2YEy/861EDrL7A40Y9OYPv92VXFc4K6sGfrbP7DGrkxO6uNuY12lXekeocGdW9EfYk/1oxrKSGKTZZiYsNiYVZncUlxlUoCR1dT2Vqf7/k4UqL9eWYDCCJkJxHs3UJRtfu0EYO3al8NFAqvFspD/FD/DsuYYcvjbJuMUT0NWwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721096253; c=relaxed/simple;
	bh=BBaTfLOz45gv5TSiEZbKjsh54MGUgFRkzmECknTKYSY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=npiWjNqoTTBzRXcofxbiDrCtny78lbfw0hNhC7Le+ZhsEZXuzN7gDNonmmb49Kbobi8uPe7dUVsTdKEzMErxbRv9UmJg1lOHkaF91sg6rqO6GXVH/nE6R8BmC5KspCbv3hT8xkMkjgrm5cpjTYSBHRL5gPq1wad/SnqmU6NjS6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=YVnqDJCD; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52ea0f18500so5126974e87.3
        for <linux-pm@vger.kernel.org>; Mon, 15 Jul 2024 19:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1721096250; x=1721701050; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OxmhwjjpGd8zVAlRCw8Rz5PC00uRnZ4KkvDhpfV+dDA=;
        b=YVnqDJCD44kOXZXBTBGc9EuBsfn8Qw7UHx15ihLUr41gkBovehWIeUtE+vp/ht7/FR
         8f2vNAys/tI71b5Zn0nyHaRaCn/VEJTXB0CHVaL91jFNAc5ggQOI6nWv7mhQj305cnMS
         HjAUtTfYPeMJWrzCTeRyQwaJOG1hFbzGd0VE0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721096250; x=1721701050;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OxmhwjjpGd8zVAlRCw8Rz5PC00uRnZ4KkvDhpfV+dDA=;
        b=l/a8LJ9t98fLCC7yATKN8VTdKiPIVc6EsJBamIBg0L1Y/8cCVrSqlM1aFGuBNfez33
         32aAIpumJd0AF7fD44UOKyY6Eps7LcPN55K57nujhawcKBJPVYz9MGqV3UZwL71MqCkm
         70tKDvaSVnlYcfwQMReUS2hFjtsRl1NBOr3g3W1b+pqH+zVH4fHaf+DS7/htc9e9waXa
         dBMldF6tpwkkIJ/3K/zExbidBQJwDjtLdUMReEAeOKn0k21Z4W5/IqDIEaiNLXsrCZP9
         N9QvpLDB8ej64pbP467mOel94fZuktlmtUGU3SkYqwF3ZI7M245ixBUj6h31WH0nTvt2
         fQvw==
X-Forwarded-Encrypted: i=1; AJvYcCV5pSFtas65ocbhTtq6BkEDIQZIs12/33SluLzgudHI5ZzpkAzBpXI9+EAl8ZI+1FN/3MP3RmNz+NkJ+OqYdBaEnv+v4MdKhDs=
X-Gm-Message-State: AOJu0YxuPTZzTL9y6S5jch5qZKGmx7vZZsfmn0IelR3Cg5/5gg2yc1nd
	eYIsio1rl3N30+d9PiefDh6R8GnZhMvcDSG6QqspvT7/lZSFl4o4sjnyfoH75/fZOs70jlwwcCL
	mQIT79A==
X-Google-Smtp-Source: AGHT+IEriTBxRcHuQ9Ef2xo7ghPBAHPhMyBckGTjw5+OBjugoxsdWqO8rX04BVaPxtFzqnRaa2uu+w==
X-Received: by 2002:ac2:4c49:0:b0:52c:d626:77aa with SMTP id 2adb3069b0e04-52edf038bb0mr354829e87.58.1721096249886;
        Mon, 15 Jul 2024 19:17:29 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ed2532c02sm1020222e87.229.2024.07.15.19.17.28
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jul 2024 19:17:28 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2eeb1ba0481so67809421fa.2
        for <linux-pm@vger.kernel.org>; Mon, 15 Jul 2024 19:17:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWGBS3VcQ78Th3WIq+8tXe9Bhp5jNUIyzkr3JGNqc3/JPVuOrvEWqyYG7nkKIoejDEp8sIwLn20WiuK++FoVqQlHJqWsCxffeI=
X-Received: by 2002:a2e:9d86:0:b0:2ee:699b:466 with SMTP id
 38308e7fff4ca-2eef41dab4amr4022321fa.36.1721096248037; Mon, 15 Jul 2024
 19:17:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240712091008.14815-1-brgl@bgdev.pl>
In-Reply-To: <20240712091008.14815-1-brgl@bgdev.pl>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 15 Jul 2024 19:17:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjWc5dzcj2O1tEgNHY1rnQW63JwtuZi_vAZPqy6wqpoUQ@mail.gmail.com>
Message-ID: <CAHk-=wjWc5dzcj2O1tEgNHY1rnQW63JwtuZi_vAZPqy6wqpoUQ@mail.gmail.com>
Subject: Re: [GIT PULL] power sequencing updates for v6.11-rc1
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 12 Jul 2024 at 02:13, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> This PR contains the core power sequencing framework, the first driver, PCI
> changes using the pwrseq library (blessed by Bjorn Helgaas) and some fixes
> that came later.

Hmm. Let's see how this all works out, but I already found an annoyance.

It first asks me about the new PCI power sequencing driver.

And then it asks me separately if I want the power sequencing support.

Now, either this should

 (a) not ask about the generic power sequencing support at all, and
just select if if a driver that is enabled needs it

OR

 (b) it should ask about power sequencing support and then if you say
"N", it should not ask about the drivers.

But asking *twice* is definitely not kosher.

            Linus

