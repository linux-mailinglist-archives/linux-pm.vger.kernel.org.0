Return-Path: <linux-pm+bounces-6310-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA87A8A2B1E
	for <lists+linux-pm@lfdr.de>; Fri, 12 Apr 2024 11:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 800631F21ED9
	for <lists+linux-pm@lfdr.de>; Fri, 12 Apr 2024 09:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EACA153E20;
	Fri, 12 Apr 2024 09:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WWWZQsuH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D3C53E13
	for <linux-pm@vger.kernel.org>; Fri, 12 Apr 2024 09:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712913795; cv=none; b=h6ZIkuLmlrm2DDEai0OTnBUb/9h2/JKGuYbq5WzwkIoeo9mbdXRpBGs+juO2gt0Y2YM+k2nkafqd3r4Ybb2NHPGM2Xtw9WEu6CqzpzIMfANXPKWTw30tyimNszlcUzGD/1UOgHhHWSP1BMW0veHBhkhKQUKbw6cmfx31aidgKME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712913795; c=relaxed/simple;
	bh=E6KMIIOqA1QVK9aa+E0L6Y6Fc7WePR4/O5s11BcWfok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cyQ1Zc/wpSvo5knZW1N5LlY7DDwSqJiNaFBNio8vpB9XbZLL0BpUzykaPiGbqfwyNHou4CbILRcz1l0EatbOY7QwF3QjgytoP9vyxRS0DeV0QWm28EA/eOa5kjZm+VHq6Sac44oIYRSDBlX5Gr/99YF4B6l8me1I1vCV//GNZOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WWWZQsuH; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5cddfe0cb64so444433a12.0
        for <linux-pm@vger.kernel.org>; Fri, 12 Apr 2024 02:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712913794; x=1713518594; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R4ch3SZG+u9KXNYx8JP1SCc8PoJ9Y2e8skYjDOyaH8k=;
        b=WWWZQsuHFHnCUmSOMppKC9RD9CDRVRn1jvopIq0uQQpE9Y5hPwxp6PVqPyzq51i9a1
         6+Luj8bCDxoa/A6q2tQtleV15POEx3q/ok1dkKcklazuC0mmtDwgF/UmKp1fl8LWiK7w
         ng7W+T670wi8FOnaOzJ+j+KP9U4gwmQgBP3RavhmOWei613axLNLfIGDbzEGTgNwQ33w
         avJuX+rFRTlFI59R3OXZNATIOOJXa2jbriLf3A7ZgAleH1u6grt0kGj0WA4GjcFLU84L
         lSRY/A1kn4R+YgfBPFBBI89sypVV/QRkjWEnBzze4GGBhCk4ENk+2gViUEFbONZ1YiYw
         m4Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712913794; x=1713518594;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R4ch3SZG+u9KXNYx8JP1SCc8PoJ9Y2e8skYjDOyaH8k=;
        b=pym1mqKR6Y7rTEsqn5BO8Gcq9KQIxgZ1FnyRAuZwBGEP+2+4WWNxAjSQzWkvA2nKEy
         iOYrPL8dxPBqEQByIE+gZVZDQnNgxIw8NjPh5ny50qLJmYXOOElUdYZBdwtgjdFu7a93
         +C9ovvmxcJlDYODm6mfcV1wCl6E56V3fkdFOaO8rBaCOLvhOCKcBLu8fSMTJaVb947Ti
         OQ8WIYK0nhmb7+ccTFfuI5UOa/DUNxtOUZyB/Q8+w1S40QLaimohYPX0aW0A2Nb8l4g3
         l92A7D4I111/kQe6irwxMIGNZNQ3PgYlninfeM8JavpauN15KLNYBk5o9TkYwiXAi7y5
         veEA==
X-Forwarded-Encrypted: i=1; AJvYcCVe/7/3Hhal9bvC7T5cnI0KXeh68PjIRv8/qsOYfM7Ey5sci0+Pd9qtGZJTRlzHSua8NXd1KeA+bVZjkCTNOYJyWFRq3Y5R1bM=
X-Gm-Message-State: AOJu0Yyl759+8IqFYKKTmiZc3ciHvXZzn7mvfO8uk0Cx+tJvnspIOfep
	Hz0UQipYNL1S3Jrmj2Jgbor7tWL/NKR2MjNbqGurbZjcPYXQZiT5uDyCxZMPAPQ=
X-Google-Smtp-Source: AGHT+IGbtWnfzY4wLra4XHruU+wkDpKN8WajlFxh72ENwVoA79DpapgLQC70i+IR0TNX+C1q+A0hIQ==
X-Received: by 2002:a05:6a20:de14:b0:1a9:84f6:dcb6 with SMTP id kz20-20020a056a20de1400b001a984f6dcb6mr1767828pzb.57.1712913793598;
        Fri, 12 Apr 2024 02:23:13 -0700 (PDT)
Received: from localhost ([122.172.85.136])
        by smtp.gmail.com with ESMTPSA id o16-20020a170902d4d000b001e088a9e2bcsm2537800plg.292.2024.04.12.02.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 02:23:13 -0700 (PDT)
Date: Fri, 12 Apr 2024 14:53:11 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: lizhe <sensor1010@163.com>,
	"grygorii.strashko" <grygorii.strashko@ti.com>,
	"gregory.clement" <gregory.clement@bootlin.com>,
	"grant.likely" <grant.likely@secretlab.ca>,
	bsegall <bsegall@google.com>, broonie <broonie@kernel.org>,
	bristot <bristot@redhat.com>, brgl <brgl@bgdev.pl>,
	"f.fainelli" <f.fainelli@gmail.com>,
	"fancer.lancer" <fancer.lancer@gmail.com>,
	festevam <festevam@gmail.com>, Finn Thain <fthain@linux-m68k.org>,
	rafael <rafael@kernel.org>, linux-pm <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] cpufreq: exit() callback is optional
Message-ID: <20240412092311.nlwmqlt7ujtew4cw@vireshk-i7>
References: <b97964653d02225f061e0c2a650b365c354b98c8.1712900945.git.viresh.kumar@linaro.org>
 <5759bc29.32d04.18ed0ef5037.Coremail.sensor1010@163.com>
 <20240412062407.ntahibzv6xsbrnxs@vireshk-i7>
 <1b53a162.32e95.18ed0fdb13e.Coremail.sensor1010@163.com>
 <20240412063246.tk5z245miakbxws4@vireshk-i7>
 <2117690204.533771.1712904398042.JavaMail.root@mail-tracker-145-3ep34-c9h23-5f64cf7787-82gdh>
 <2024041212-bony-emphasize-75dd@gregkh>
 <663acff5.349d4.18ed18da6ff.Coremail.sensor1010@163.com>
 <2024041238-publisher-provable-7ebe@gregkh>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024041238-publisher-provable-7ebe@gregkh>

On 12-04-24, 11:14, Greg KH wrote:
> On Fri, Apr 12, 2024 at 05:05:05PM +0800, lizhe wrote:
> > I found it first and submitted it to the main line first. Please be fair and just. Let him withdraw his patch.
> 
> lore.kernel.org links for this please?

Yeah, I just posted those in a separate reply. There was some
confusion in the beginning and I already acked the concerned patch few
hours back. Rafael may apply them later.

Not sure why the emails are still coming despite that..

-- 
viresh

