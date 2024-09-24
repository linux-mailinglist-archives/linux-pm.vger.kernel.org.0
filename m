Return-Path: <linux-pm+bounces-14632-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B22984C1A
	for <lists+linux-pm@lfdr.de>; Tue, 24 Sep 2024 22:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7921D28466E
	for <lists+linux-pm@lfdr.de>; Tue, 24 Sep 2024 20:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C8B13B5B4;
	Tue, 24 Sep 2024 20:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="aRn25/mu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520E4335C7
	for <linux-pm@vger.kernel.org>; Tue, 24 Sep 2024 20:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727209214; cv=none; b=UUA0dtNJkitNqngdy/sYaS3F7KmDWIMCDA0E4otfY3D1SwPB9jKm3kD5fLYkaEAc49LRJx2Y1k9ev9Mvr4yWyYlg6K1m0YvXopk7AvID5rLLEgW4qT//55p0diDoYymY/UIps6frMptpKEQQDNWpUVwv5rERvvQjLAd2W651pF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727209214; c=relaxed/simple;
	bh=eVRfD9Nc+wdvqXHB03r1LjIIg3n38nkVigE7i0eQNUY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BCrbiV6uRJasuIoieomcr5RdGiiOhiTU6xsPQz76Y1Qc0Z2MUlUVbGufCaquUUtPt3CQ9/gZaRNMNFTjtmprHvwAwWtANBavEhs2yNMDCaYoTCrwXf+atEsTzBwqiha4UkOh4NC9+ulMauK1MDv+GA818Ch5eSaDVz1oMSoI8TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=aRn25/mu; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a8a7b1c2f2bso984911366b.0
        for <linux-pm@vger.kernel.org>; Tue, 24 Sep 2024 13:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1727209210; x=1727814010; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vcV2QbsW4DHXfNd7bvkaZy3F9FDXpyy2GL9yhM5GxRs=;
        b=aRn25/muUKn+QU4ZPOAOH8nivc+EZQyKUgGAvgDcHVe7ktaglTEhdyfzgSEB6O6zBz
         pFk+Rm+14jByBv9g66BSFbowCtfXb7bJGEKNj3EV8kIceqoLjNywTvy9+8KQPB0KLOao
         vVut7JDjwU6iPfkaNGUxerDCy5ZqiLM64o2Ac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727209210; x=1727814010;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vcV2QbsW4DHXfNd7bvkaZy3F9FDXpyy2GL9yhM5GxRs=;
        b=PnV7gOx7daR8giQ3wG6WJUsss5A8UZw7xn7qVxGxiJsgTmEdNEQe3RihhmxgxSReJo
         Uzx4SNBgtlECmG8+UMwxcmLrN6EsQjTviExTzbZ/zVoYFLJiaaSLIS+51xCgYM05QOyh
         9NgbHjRP1aB7I2oDOB+IvPZQqvrx4EeZg9RlU0kHi7/69L3J/Xjiemko8osffZhs4/Qr
         ja+OmULXTxSqGBC8ax39syz6+8nkpKGLZPIqyc2iD2ydSaZ9Y3VrTQQ/EiYpeUaLRHFc
         NSc4Shf2Jcdx8nkyzgHe9Uwe+huCYnTTY2BxQBM1rIds/Ec0GrWY2zKVttfRW11c5Icb
         SdFQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5LvrGtOcrxjVUxV1Bisi7LgPioIvq3KmxnRbSixjNHxWeu0XwS74mucemtxvbPoEapejZrKZ9+g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8jTgGw9DiDQt6jxJMqWyOt93isc3AqNuhulGGUPzU13CeWwOS
	MmG/F3bkodMHOu1MHQHkZppbSWoVld2KJYm1hFAIU6aPq72NjLbUcUWtannn/ExcPXDLEYNWAm2
	9AksTlQ==
X-Google-Smtp-Source: AGHT+IGn3WVJZFwXjZs5uI5JQhUAGeafEUz1UMcJ2YlpxSb+lPyVhpMUAL3471FpLj5Y30lNKfcIvQ==
X-Received: by 2002:a17:907:7282:b0:a8d:28dc:9e2b with SMTP id a640c23a62f3a-a93a05edc3fmr34606266b.44.1727209210107;
        Tue, 24 Sep 2024 13:20:10 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93930d0d65sm129838666b.141.2024.09.24.13.20.08
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 13:20:08 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a8d2b4a5bf1so841968366b.2
        for <linux-pm@vger.kernel.org>; Tue, 24 Sep 2024 13:20:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVTnoE3KuL+h43G2y2ydAMDfNqgSX+SRn34TuD0rE6wjzC/fk9guqfRLWW4HEpaWmq7PX0TPFJCOw==@vger.kernel.org
X-Received: by 2002:a17:907:e28c:b0:a86:6cb1:4d49 with SMTP id
 a640c23a62f3a-a93a0322a58mr40471266b.13.1727209208367; Tue, 24 Sep 2024
 13:20:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cf329845-48ee-4b25-9b5a-02a6e2b55e5a@linuxfoundation.org>
 <CAHk-=wiLgK+Fbok8cnpAJD6D4_NZzEv0==i7k2XR3-Tvc1Hr=A@mail.gmail.com> <122176aa-4948-4e90-88d7-1fc77f4156e1@linuxfoundation.org>
In-Reply-To: <122176aa-4948-4e90-88d7-1fc77f4156e1@linuxfoundation.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 24 Sep 2024 13:19:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjOUhkh0-==6JZaJ4k0Xp=caN88k12DHkNG22Yns+zGDg@mail.gmail.com>
Message-ID: <CAHk-=wjOUhkh0-==6JZaJ4k0Xp=caN88k12DHkNG22Yns+zGDg@mail.gmail.com>
Subject: Re: [GIT PULL] [GIT PULL] cpupower fixes for Linux 6.12-rc1
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, shuah <shuah@kernel.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, 
	"John B. Wyatt IV" <jwyatt@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 24 Sept 2024 at 13:18, Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> Is it all good after the lighting up or should it go through
> the normal channels through the pm tree?

It's all good and pushed out.

             Linus

