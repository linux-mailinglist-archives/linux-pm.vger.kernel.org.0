Return-Path: <linux-pm+bounces-11130-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F13F8931EBE
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2024 04:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE008282A52
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2024 02:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD7534C74;
	Tue, 16 Jul 2024 02:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WZTrapg3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E733101EC
	for <linux-pm@vger.kernel.org>; Tue, 16 Jul 2024 02:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721096336; cv=none; b=Nst9s+jMr5yeVSDwebVgY9ZA8m8PegZC3Q8g6I6JAZDx1aIfhEITHJ1QGbQYmjfCFotjHjKmneP9WCOszK7BqDrSA+lnO7Hd2sOUfsNMQ+K+rzAXvSCPdquWPJWdr3gLcD1ipddyqL6kcPOpiNBl7GbbmJjFH0Lp2JnXANndwJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721096336; c=relaxed/simple;
	bh=pyKsuwqVIboN9EwThCz5EI7HZB3JIVS86qz5vkpAtLc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UXXTqZq94gFWqKZ1JaxhiCq2FwSINZSMBRas8ofY+JZttZYXBuSL9pU2cyOQOho8yjI0g6KAzuwKMd7q0nvBYEQPyqpq1I9IRMi5SOdL4XTaCk77NBdHRcWOBAeYYsWiXZmKWJIsA/EbnCXKTtRY6o2MUVXto1auHkN+k9yr5R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=WZTrapg3; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52ea2f58448so6630095e87.1
        for <linux-pm@vger.kernel.org>; Mon, 15 Jul 2024 19:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1721096332; x=1721701132; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=c+l4WKIaaq5577Hbze0C2fWBRy2R2qvbUGhdaCCzWQY=;
        b=WZTrapg34Dbp03FU43bq4kj6Hx51l/zqXX0MqKNRp+56sBM8tI86sPnvKraGXehBLQ
         D+XqCv6PKvqYPzff/SEPWzrXFlwm4OXso3TlSF4NbFYATJN5hgPOFfCSYFJ0go8U76Nj
         ZWlnu+JvimAQywFcBRc5ijuGaPNKgpQ+vPRcM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721096332; x=1721701132;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c+l4WKIaaq5577Hbze0C2fWBRy2R2qvbUGhdaCCzWQY=;
        b=A+yFOevRWMaKOruYioByAnXfrYEhmgjKUZCoN7tkse2oOK9VXP3Ep/KMlLBBPzeyTc
         UAisoIuK7BdOu+Q1P9jOFNZBJ4/tiFllEzVW7MGBMnE57viD2ew6zfJirXJsjU9LMn04
         Y9zGQQxgF8fMatpDL1J4VY5DNAgW8i7eItz5IOs2KpLpqAbDR26+FmJG8JoNTBsVBaDO
         csYDJMrYp/cYxdPyryxsJ810M1L5DEMtCQkvFG81p0s6AbF783RXHBg7scFGLWUsIiw7
         w3L2be7ycvTTzncq3Jr+YRP608wf1S14svwxxb2vWL0ENEForBROP+r5YjTcLZFwb7MF
         lsmg==
X-Forwarded-Encrypted: i=1; AJvYcCVRGS5CEtiMwd5yASDyXD5pyY4ZANiuOX8+hBQSXQrep3Q/VlTC+k0iqfnZIEuRnhmX4doF2qZCqobIBNPZ+O2LlqTmQHy2CN0=
X-Gm-Message-State: AOJu0YwUV7AzHR407boSqUXKgIQxd7EN/mngLn8sLQN6KwrE85l/MxeU
	nNFb3sNzJIN8nnO0WjLag0JplV9cfRQkvCznj9TMFeLaRx1E9QF/aq60a8cmulirKaL55HkdQLw
	MYy4=
X-Google-Smtp-Source: AGHT+IFm//lq+pn5picf3/puKbdlwLJ+Z3ZFWbsXL84JsJyWX/rGNrw251ELuDCImbp5Mggs+sR4Cw==
X-Received: by 2002:a05:6512:3ba3:b0:52c:881b:73c0 with SMTP id 2adb3069b0e04-52edef1da7bmr418224e87.17.1721096332297;
        Mon, 15 Jul 2024 19:18:52 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ed2532684sm1026080e87.202.2024.07.15.19.18.51
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jul 2024 19:18:51 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52e9944764fso5707284e87.3
        for <linux-pm@vger.kernel.org>; Mon, 15 Jul 2024 19:18:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXU3I9kTNu54wEtvNgrYkluaRxsQ/p8h4aNgROOMThPvR2yKC/K9FvmO3kuS70jNOxrp3gRVrTH0ej73ofHsoZLgqwM/+Eja80=
X-Received: by 2002:a05:6512:280d:b0:52e:9905:eb98 with SMTP id
 2adb3069b0e04-52edf018688mr350932e87.35.1721096330887; Mon, 15 Jul 2024
 19:18:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240712091008.14815-1-brgl@bgdev.pl> <CAHk-=wjWc5dzcj2O1tEgNHY1rnQW63JwtuZi_vAZPqy6wqpoUQ@mail.gmail.com>
In-Reply-To: <CAHk-=wjWc5dzcj2O1tEgNHY1rnQW63JwtuZi_vAZPqy6wqpoUQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 15 Jul 2024 19:18:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgiVHdEX5i5kuNLewy9OUvYaWX_DYiRmOS1Fcj1pJ+QPQ@mail.gmail.com>
Message-ID: <CAHk-=wgiVHdEX5i5kuNLewy9OUvYaWX_DYiRmOS1Fcj1pJ+QPQ@mail.gmail.com>
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

On Mon, 15 Jul 2024 at 19:17, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> But asking *twice* is definitely not kosher.

.. and obviously it's only "twice" right now.

If every driver continues this pattern, we'll have "n+1" questions.

        Linus

