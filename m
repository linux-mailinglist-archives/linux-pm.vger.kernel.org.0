Return-Path: <linux-pm+bounces-6309-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D2CF8A2B10
	for <lists+linux-pm@lfdr.de>; Fri, 12 Apr 2024 11:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 137DB1F23217
	for <lists+linux-pm@lfdr.de>; Fri, 12 Apr 2024 09:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE455029B;
	Fri, 12 Apr 2024 09:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rKRryA3m"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E245D3D3BC
	for <linux-pm@vger.kernel.org>; Fri, 12 Apr 2024 09:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712913673; cv=none; b=o8MUxd2Vcg6x/bf8AUqgHQXwhjZuCLWuZ7c8QCLftjqs5JbUyaVlhyI3yxrzE++bMKijKZrrgMkFSaP2iMN5rE5Ni5FUIT+kFvkzID8HjGf4AQpKUTy49NwTt1B/Lahfn1eSgq4IXgo1LDwSiIJ2f48BkOFeiKqabskaetqbqzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712913673; c=relaxed/simple;
	bh=jyHEzfrrJiHm48IrrenYtZfCcRsh32yri0gcEofr6L0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lkQoXArVjynfp+V525R5v6P/QMv19KLrYVgoiFY1mI00sNjHvKPg6GQbCigRdHFNNzCBt7UDi+wk+yuaE8m4va/Z5tIMCNb3Q+2BUF96XGSysbt6C7cjjNF6JnD6avREfTa3zk+vm85EVkHiFr7tQ1zdjQfeL+YLMh1vDfLEWYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rKRryA3m; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1e5aa82d1f6so2259815ad.0
        for <linux-pm@vger.kernel.org>; Fri, 12 Apr 2024 02:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712913671; x=1713518471; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jyHEzfrrJiHm48IrrenYtZfCcRsh32yri0gcEofr6L0=;
        b=rKRryA3m24jx/uQ9o7DEzeJQZl3SshyedG7DaUzOdO+yyURDDS+qkRfLO3vydwUyem
         D+eeY5hk8QoMiCUBSpRUh8TII3VExLpGcxVsmn//QdpAkX94FwOrRfalLaifW4/uwR44
         CbBJsXDuBMLuc1xy/TjjNKN76xkM3cRhazLuNEk8UYJSN/ezetstyK3VxQo2YiGjojRu
         RTt5UPVifKepyJ+rG9k9yXD/9WzQ07vhdV7qiaU1eWWMgPD2VBsekufU/NacMky6TJXM
         h1IW+oTqgVZ6JfthseD0xn15gL/xYLOdQiaVX6ULOa5SJa4AS10uJP4qEZClTsca41SV
         A49Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712913671; x=1713518471;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jyHEzfrrJiHm48IrrenYtZfCcRsh32yri0gcEofr6L0=;
        b=HeMLhw2DvYw/yKKLzsymfBmGfyMWp9deHt0u9DcrkFNquH5y2yCet1CLt7mgZ+wkEq
         9MPU1i4AfeKqzejSgGHaiGaaVCy6mJ4Ur0XlHNKxGarcm4npH2hdkFBzVPeIFahD+z2N
         54eQtX0/8a2DnZoZQOpi5S7Gvw8I4AQXWJzOY2qjbcZf2JhnPtoqjPUTTGA7IH4C6/Ko
         qr9juegK8TyUOVhiXEDe9iVTNLBv8BfNT2U44OVQDRJdH9tYcM1peqyxK3Fl0oaingeP
         BKoJDgJMX/jXEwjm23pMOR4StoyIJ8q6ynylK0nm7eblqStrGu/zABUgqhxhX+xUuFpd
         LARA==
X-Forwarded-Encrypted: i=1; AJvYcCXflUrgNA0SxTKoSVdmxHjZ5Ja81Tqk1HYPqPkf5gPQ8C7wVBDoIRsAzCUhg9aAdvDuDokOdTlDovi4YqyeDdoHOa9iyaFsXTk=
X-Gm-Message-State: AOJu0YwrSrvAoW4Yf+tM+Fv1dWYoUkwZZ7weIrZkW/fP6S0OT1xBc+Xt
	gTdOlXoCh8X3RSjVUB0nZbNT3UNLOmAY88ZLG+fnpWnCPIkn5XBlKsxUY6/KSXY=
X-Google-Smtp-Source: AGHT+IFTrWzNofckRWQ3pSgrJaTHRtPBkvFOi+EAaSJCWSsCEBCZA8Rxsz9CGBIwqvAqzqj/OPtP7g==
X-Received: by 2002:a17:902:6546:b0:1e4:59a2:d7c1 with SMTP id d6-20020a170902654600b001e459a2d7c1mr6079565pln.33.1712913670951;
        Fri, 12 Apr 2024 02:21:10 -0700 (PDT)
Received: from localhost ([122.172.85.136])
        by smtp.gmail.com with ESMTPSA id lh14-20020a170903290e00b001e42f215f61sm2539106plb.187.2024.04.12.02.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 02:21:10 -0700 (PDT)
Date: Fri, 12 Apr 2024 14:51:08 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: lizhe <sensor1010@163.com>
Cc: Greg KH <gregkh@linuxfoundation.org>,
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
Message-ID: <20240412092108.xuvrfd6ioszltonf@vireshk-i7>
References: <b97964653d02225f061e0c2a650b365c354b98c8.1712900945.git.viresh.kumar@linaro.org>
 <5759bc29.32d04.18ed0ef5037.Coremail.sensor1010@163.com>
 <20240412062407.ntahibzv6xsbrnxs@vireshk-i7>
 <1b53a162.32e95.18ed0fdb13e.Coremail.sensor1010@163.com>
 <20240412063246.tk5z245miakbxws4@vireshk-i7>
 <2117690204.533771.1712904398042.JavaMail.root@mail-tracker-145-3ep34-c9h23-5f64cf7787-82gdh>
 <2024041212-bony-emphasize-75dd@gregkh>
 <663acff5.349d4.18ed18da6ff.Coremail.sensor1010@163.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <663acff5.349d4.18ed18da6ff.Coremail.sensor1010@163.com>

On 12-04-24, 17:05, lizhe wrote:
> I found it first and submitted it to the main line first. Please be fair and just. Let him withdraw his patch.

Well, I decided not to reply to your emails anymore but this needs to
be clarified a bit now.

You sent a lot of patches, over and over again and it was a mess. I
saw the this [1] series first and went over to read the code and fixed
an issue which I found (by the $subject patch).

Later I read your other patch [2], which I Acked roughly two hours
back and yes you did send a patch that fixed the problem partially. I
never saw it earlier, which is okay and it happens. Despite me giving
an Ack to your patch, you have sent half-a-dozen more emails..

Then I posted a newer version of my patch some time back, removing the
bits you already fixed [3].

That is all one side of the story. But all the noise you have created
here has really demotivated people to review your stuff now.

--
Viresh

[1] https://lore.kernel.org/all/20240410132132.3526-1-sensor1010@163.com/
[2] https://lore.kernel.org/all/20240411231818.2471-1-sensor1010@163.com/
[3] https://lore.kernel.org/all/68294ce534668c6ab3b71a1b3e6650227c6e1f20.1712911186.git.viresh.kumar@linaro.org/

