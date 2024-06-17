Return-Path: <linux-pm+bounces-9329-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD14090AE7D
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 15:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D21828A5D8
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 13:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C1A197A6D;
	Mon, 17 Jun 2024 13:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T6JZGuZL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E096418FC6F;
	Mon, 17 Jun 2024 12:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718629201; cv=none; b=hGPYtDkxJ2rGtPYVdlR2flRCdbgFXYJnkqHQYwIjZEi7ISIXdwwfJd/2NQIfSRqADrMqYVVQBKnP6IiKX7ZlGwqfi1gX54ikFCYqx/t1xxbIqxhKtx/HKUtj5/syP8zFPTwN1s7iX3rh+ctJH2vDZSHaVZcFQRiOYVfaYirDbPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718629201; c=relaxed/simple;
	bh=8G39HiKoa8xfyKHJf8Y1JNqnXPKRNwnOjDzcCynE99Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lUeNNlnkjQrtH5yh4eX2hORWVZ0ddww8ksz7H6ij9bbpvu03BkDcRYkTEtCpZmEcax/eCXvceM5qXGx62TJUnoM4KyQWtBj+/h47HwsKyyMULRcJwSWSVvdWRSQNHJJAdHw5jhc7mY/TTBfdKR0UpYWQfOvk1DflPsfEemXU6Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T6JZGuZL; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52c32d934c2so4789413e87.2;
        Mon, 17 Jun 2024 05:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718629198; x=1719233998; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O6qxWw9hbNV8Y2lcwTy4Qgqg8Y0QqnwMXXkDD5Y6lno=;
        b=T6JZGuZLrkwsnI89MrIlDx2nywMCN4eeBYsqICd4sqprwocs7m5mv5IiVINp2iajCh
         j7dxQsdzBtpuWKEhBG4IHLQW3dAomG/B38ulkv/l0r/sqiP0UIseXKU0cGM2cqQ48d4J
         2Y4wae/ga5ns8zU0j0AUfYjx0OXpvEUlj8fhbvL3HcIu532dmNFKideAQ5+11b0rYCRs
         kQD9UHKVzcwnj9WtcL+MPYBMtsUasqMlhuo4B6AzXtKRzExOwh5HsUPwdkrCnxSBtEX7
         rvKcWCJpaBmkq3v2/EeRR/1wE7XB9lzr/HK0l0PlD5Uu8Uc7n8K7Ni6irWzxscXWL2ou
         IdWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718629198; x=1719233998;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O6qxWw9hbNV8Y2lcwTy4Qgqg8Y0QqnwMXXkDD5Y6lno=;
        b=sweCL8sC4xoWEccISrcyziBRpzjnxei+beuSJkAeB62vEoPrl8xpwQHFlrPjZYiZeb
         GRV3WC1PWX4LyjhRueSbDk8YNyMGKJNbGhuAwqbhRZUQWlF6YLwYrhWqe99XrE7BaSF/
         r9UlQXAFxf7GmKAz2AFJ1NYic27xe8ZHpxzP4BZ2BAUN1m4e488qkI15BeS5vyBv1Of/
         SPleLlZ/akAP8rIf3+5um1q5jKlWCQO6Btc3o9eGv0hnPJAXlCjYuzlBBbsqXGWOjU2a
         HS7K5fR9q+rd7ow6zJj1ePjqOLaSNhF/5IYVq1rHZkeVn3uNXQBmHPjRw31RJSWYQFeB
         yAeA==
X-Forwarded-Encrypted: i=1; AJvYcCWWCDq6CZ6wEzhbOXrLefVGTNInnSBozO5Z6+1RKbPh/Ponm8SNh64YgqBQkJ8Uzn4/vEhYQ21zgqS4iljRLzIYugc/j0IV036R4WcrwOvGgfGhk+eyxw3+8DHcbqjss1cN+A/ZGc5hl1OHSuIjRWiMnH0YCB6LAtzT6o3TuxHoDqTS
X-Gm-Message-State: AOJu0Yx2QacB8Hr+CL9oqI6jTP7TYy0gPKKuTvAZjt5nvhPaYjpb03vO
	/JEbVDuGKg4Vhcp3cm61GPMpCU36NnEtW69L0RlBzWz6nq4+knWWYpwFNw==
X-Google-Smtp-Source: AGHT+IEKJUepyEo0Qr4VnqJMJm4O3lMQ8RESf1ddP7d2P9ZeNTdN+t4VyV9gLe2htpTYYLBjpsX1Rw==
X-Received: by 2002:a19:6904:0:b0:52c:7fe8:6489 with SMTP id 2adb3069b0e04-52ca6e98eb2mr5625129e87.63.1718629197730;
        Mon, 17 Jun 2024 05:59:57 -0700 (PDT)
Received: from debian ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422870e9145sm195678665e9.22.2024.06.17.05.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 05:59:57 -0700 (PDT)
Date: Mon, 17 Jun 2024 14:59:55 +0200
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: power: supply: add support for
 MAX17201/MAX17205 fuel gauge
Message-ID: <20240617125955.GA292946@debian>
References: <20240615203352.164234-1-dima.fedrau@gmail.com>
 <20240615203352.164234-2-dima.fedrau@gmail.com>
 <ee0cd414-206c-48c9-aee2-06e24e0b981c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee0cd414-206c-48c9-aee2-06e24e0b981c@kernel.org>

Am Sun, Jun 16, 2024 at 09:27:21AM +0200 schrieb Krzysztof Kozlowski:
> On 15/06/2024 22:33, Dimitri Fedrau wrote:
> > Adding documentation for MAXIMs MAX17201/MAX17205 fuel gauge.
> > 
> 
> Three patchsets within 30 minutes. No changelog et all.
>
Sorry, had to fix my mail address in the commit message. Changelog was
in the cover letter. Anyway, could have fixed that in a later version.

> Slow down (one posting per 24h) to give people chances to review. Then
> provide changelog under --- and describe what happened.
> 
[...]
> > +maintainers:
> > +  - Dimitri Fedrau <dima.fedrau@gmail.com>
> > +
> > +properties:
> > +      - description: ModelGauge m5 registers
> > +      - description: Nonvolatile registers
> > +
> > +  reg-names:
> > +    items:
> > +      - const: m5
> > +      - const: nvmem
> > +
> > +  interrupts:
> > +    maxItems: 1
> 
> This is incomplete. Missing battery and probably more... Look how other
> bindings are written.
> 
Some fuel gauges used monitored-battery and/or power-supplies others none
of them(mitsumi,mm8013.yaml). I'm not sure when to use them.

Best regards,
Dimitri Fedrau

