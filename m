Return-Path: <linux-pm+bounces-2322-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F29A83105F
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jan 2024 01:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1B491C21D7F
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jan 2024 00:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14EA8199;
	Thu, 18 Jan 2024 00:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="CZ1a1DKs"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5644D10EA
	for <linux-pm@vger.kernel.org>; Thu, 18 Jan 2024 00:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705536686; cv=none; b=HtVJyf1fkljOuUCI8YtGceqNSzstac2ukNXmzq4MJc2DCfrPltBG3zkqYS9JQMy677nuGkyjNq8KVt1/tdpGoVrF2MSOyIrkykZMlDJdsJEeYPe3FZTF9OytSCgepJduuZ+xj/Jz2ycJ+nhYSmTuynKgoLz2ucAmE7jDUScRYj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705536686; c=relaxed/simple;
	bh=1w5Q64brPeYx8/ViGQBpGfdLrhYesMFZVAAlV6NcyTU=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:Message-ID:Subject:To:Cc:Content-Type;
	b=UKomoQ2Kr6sYKMDChpRvS5LN9zUah7+I8PgmqvQGqrcVvCYpd2W/2+L+zjBIlCWC8mcGyal30NJc8yQZuF1feXkbQx93AwTO4VvRVjwUUejdQqQvx92JzJ6Z9Y3mfzurgEiiXqRApkTA5WDDiDNS3KkAp3OWoQaSedEtfo3QUMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=CZ1a1DKs; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a26ed1e05c7so1397937366b.2
        for <linux-pm@vger.kernel.org>; Wed, 17 Jan 2024 16:11:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1705536682; x=1706141482; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DH3fH0sAOwBA09p60ldRSMkKa4SNaStD6jUtWJRacm0=;
        b=CZ1a1DKsvHFNatqJEDZVVWubbzKXj1zr7+jhss/u03AH+PBNhsI7B8+ngeCQMCkqo2
         yUvbcoEWXNdxNLNtw87lE/kP7hxP4EAMzyyBrNQFkmf7SIf28+Q+LrCWEvr3xcmgc3hV
         d2z7haRasYut2HhCUol5f3dVcnU9G9qoTKaDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705536682; x=1706141482;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DH3fH0sAOwBA09p60ldRSMkKa4SNaStD6jUtWJRacm0=;
        b=gh8jXvwbP+537ejnxDkTAXZQD+QysoT9iwGcu/09wIFWCfCEhyfh99fLB9KsTOhBVo
         GostNs2jr4GxvJyiyJzKSQ2gAO2PttZ5P2Dl8JgENha0o8isr1tnxdrrkNR9YfqyLYaN
         r7wxFILjLO9m47ngw+aFtYhG2jLmdzMKW9m8ND2E6vDD1KVIJgWXEDm/qS+jcW/jqOvl
         DxMudCIPOyquJyNq5lwnVhxQoS5KPpu8uuWPoVYsPiJgXrSApeVEOdbWPO0iXMaueGsr
         iClHsqXvs1e2eAO8iRCKyhE+dUUZEHzeioVP+s6g1KqJRQLk7GrqQlGaOynkZwkTpDZx
         PkbA==
X-Gm-Message-State: AOJu0YwefXL2HVfgX6UOjm9lDL4HpmHJGHFcjb2ZjNPilE2uv9xLeUz2
	l5eMGO8I/aPxeBZSKXe3jfQ3rphRFuqaIzV6M7aeQXJg/nQuCJG8cef9RKBvMZ2st/8Qrj+DOQY
	hQ1XPKw==
X-Google-Smtp-Source: AGHT+IE0V63yT1YLLjYTKxeg4IQ7/4ftjJFgzcksLMDCgs6HrVU0cuTUSlU0NLplxgILKfJHvaZcAQ==
X-Received: by 2002:a17:906:50e:b0:a29:2c66:cf2e with SMTP id j14-20020a170906050e00b00a292c66cf2emr3167eja.142.1705536682467;
        Wed, 17 Jan 2024 16:11:22 -0800 (PST)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id f4-20020a170906c08400b00a2b10e20292sm8370873ejz.215.2024.01.17.16.11.21
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jan 2024 16:11:22 -0800 (PST)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-559d3fbed6bso1532132a12.1
        for <linux-pm@vger.kernel.org>; Wed, 17 Jan 2024 16:11:21 -0800 (PST)
X-Received: by 2002:a50:d4d9:0:b0:559:f13a:af60 with SMTP id
 e25-20020a50d4d9000000b00559f13aaf60mr38690edj.47.1705536681376; Wed, 17 Jan
 2024 16:11:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <nqrl5ggszhlzaew6yte6t6uv5cbf4fhl5vd4pfhkitlsbqozvf@w4pttrz6supl> <20240117180021.GA539437@dev-arch.thelio-3990X>
In-Reply-To: <20240117180021.GA539437@dev-arch.thelio-3990X>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 17 Jan 2024 16:11:04 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgx15ew5SOkri9M8dXnX1WV4__FZdiJoQ=6v8nj_7YLmA@mail.gmail.com>
Message-ID: <CAHk-=wgx15ew5SOkri9M8dXnX1WV4__FZdiJoQ=6v8nj_7YLmA@mail.gmail.com>
Subject: Re: [GIT PULL] power-supply changes for 6.8
To: Nathan Chancellor <nathan@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 17 Jan 2024 at 10:00, Nathan Chancellor <nathan@kernel.org> wrote:
>
> This is missing a fix for building with older compilers:

Dropped from my queue, will wait for a fixed pull request. Thanks for noticing,

               Linus

