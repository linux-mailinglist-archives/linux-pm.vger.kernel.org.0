Return-Path: <linux-pm+bounces-18204-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73EA39DB5B6
	for <lists+linux-pm@lfdr.de>; Thu, 28 Nov 2024 11:29:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9EF5B291FD
	for <lists+linux-pm@lfdr.de>; Thu, 28 Nov 2024 10:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57BE919049B;
	Thu, 28 Nov 2024 10:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WGJnH+Mi"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A49157493
	for <linux-pm@vger.kernel.org>; Thu, 28 Nov 2024 10:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732789700; cv=none; b=dquv8I9scK3CKQQFJJMcw1/dOjwxRLgGnkO1LOnoUrUESowwuecF9C5Y+Z1ZpKoURyVOPBcz/6oqy9aR3CxklfVLgV6hFCpv0FKCssMwXYxGRX6aZ+DmnpNgyppCiSdplz870k1PLsJXc6w940n3tFifKOHN7Y0KtYCMaJld0BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732789700; c=relaxed/simple;
	bh=xBez7rpBLjMzyjYwf7HZa9dlrkgJrg+yAQKT8Au5N6I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rsVQ3sM1sOSehpbVv5pn6/KKpXalRssHY8SyTKyuqROxlsLO3NoC5V9K45UJ3PtvcmDAeZHJb4jXNyx5ZjNxoDL7w4M42KzfizLK3xq8g/HR7JtW9kHRsVncAxEvgH3OyR3yZWyJWIUiizypQof8CJD9Rs/7Gs408xDaRTkmg4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WGJnH+Mi; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-4aef7d0cc2dso175427137.1
        for <linux-pm@vger.kernel.org>; Thu, 28 Nov 2024 02:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732789698; x=1733394498; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CKy9NFeqlqcw1t7BKiitB8spU33tefaJ6SaLKo921pw=;
        b=WGJnH+MiNnbq8GdTtyvTArrp29CWeieCAwYA18o+6AxJcUfuCp9Joto2Ey0eXVB5Xe
         40Gxi+4YKGtbmw1KJ7zp3U9PSuLRHyIYMbSoUC7mOv2M9QYFUrQrwnf9Lm/jWVUTCk1p
         G1W1/HI/ImWEv97USJwNtRVnTlIiWxiL3DN/1+DQNGf2OGva7hzYmlNDBKQCcahkpc4z
         mSlN7D6qOiDfg8pXslIGbpjpGddCV+med1Lv0hFDhb9h8vKZXHFooZyIuGZa7/Mlq9qt
         bsbqq1qTtBbGSag8AzMBwqk4i87GIB2UOu+kWVr+VuSStWpdz5vM3A5Vu1fk7JOxCg96
         nVNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732789698; x=1733394498;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CKy9NFeqlqcw1t7BKiitB8spU33tefaJ6SaLKo921pw=;
        b=XC7IxL5KE7KkBiAnyGgtkuoiTfn6eqKbXzI+C3+8PTNJCPbNj8JQR139lq6IsSOyb/
         CsEb/YiurJkk6KehB3ZAFuXsfDv0IEPWk7KpSmq50aaLqD0L/YOt6tWrIVziIq0ezRAs
         6t3R4IerjXzQXtJqDv5AziAEO6oHcRJmkSv9SxzJx+xFNRx3yzemU9LeKXu1So1EJhyo
         peXODHEwwr2gtpGTDBJQ85MHyfwIxGQFU+pwew0nCzfCWhcIWX3LLS6tXugaQaJN9Dc8
         /FELye7TLXWFH3KokcsTRyCw0yuDSQtf5vuCzaj4MlbIRVXq3kveYrhFJ3sBUYudSSmp
         AFVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdme4Xmk0yTKMecaN6ek//xERqUTpuGzzUyHWKkVsPb08jCf7yMUbmWVpf1jQ9vHxKHYmKcE2yUg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp9G5ouqS/Ahn6mEvATC5eJSEwCxQv1CfZXJfwjKiJPgqhCU/d
	9pSIQ3F/QG8W4dQMJ2DzRK5MJ/ZozoL21HsF2ySLRau+z6v01uSF1Iq08HpYnHXp9S0Mn5gzKmq
	FXIzgrLQaKbjEKOyL/oNbQHnXQp4qwB68Zplycg==
X-Gm-Gg: ASbGncs7qlw2x8tc2JWCvHIQNUdPP3tf0E1/3aOXBy2Ox/RSeKT2T0y9yLuN9NsCdoI
	v/nhJpQpF7hqLHASjTfw6qwvPug4ugG6mdg==
X-Google-Smtp-Source: AGHT+IHNjCHSookykhJ0jiELmB8RMX1pmwKtceJGivKe5r9uvyYhkK2Li/fKdNaKGIC1FiwJ9jTRq09+7ToPFKBO6rs=
X-Received: by 2002:a05:6102:82cc:b0:4af:497f:aaa4 with SMTP id
 ada2fe7eead31-4af497fac19mr5014052137.4.1732789697607; Thu, 28 Nov 2024
 02:28:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYs+2mBz1y2dAzxkj9-oiBJ2Acm1Sf1h2YQ3VmBqj_VX2g@mail.gmail.com>
 <CA+G9fYvh8n=CTCmcCdLViH=o-UXH1Euncn+7YuYkvt5O-k8NMg@mail.gmail.com> <20241125154235.GC2067874@thelio-3990X>
In-Reply-To: <20241125154235.GC2067874@thelio-3990X>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 28 Nov 2024 15:58:06 +0530
Message-ID: <CA+G9fYshK6+AuXSnu7c=j+QJ38kN6O6t7B=DdzqQrMN_rGsJhA@mail.gmail.com>
Subject: Re: pc : qnoc_probe (drivers/interconnect/qcom/icc-rpmh.c:269) :
 Dragonboard 410c - arm64 - boot failed
To: Nathan Chancellor <nathan@kernel.org>
Cc: linux-arm-msm <linux-arm-msm@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>, clang-built-linux <llvm@lists.linux.dev>, 
	Georgi Djakov <djakov@kernel.org>, konradybcio@kernel.org, quic_okukatla@quicinc.com, 
	quic_rlaggysh@quicinc.com, quic_jjohnson@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 25 Nov 2024 at 21:12, Nathan Chancellor <nathan@kernel.org> wrote:
>
> On Mon, Nov 25, 2024 at 08:43:44PM +0530, Naresh Kamboju wrote:
> > [Small correction]
> >
> > On Mon, 25 Nov 2024 at 20:33, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> > >
> > > The arm64 Dragonboard 410c has failed with the Linux next, mainline
> > > and the Linux stable. Please find boot log and build links.
> >
> > This boot regression is noticed only on Dragonboard 845c.
> > Linux next-20241125 tag.
> >
> > Good: next-20241122
> > Bad: next-20241125
>
> Can you bisect to see what change introduced this?

The bisection did not provide any good results.

I have been tracking these boot failures on db410c and then the boot
test got passed on next-20241126, next-20241127 and next-20241128.

Boot test history:
-----------------
-  https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20241125/testrun/26040307/suite/boot/test/korg-clang-19-lkftconfig-hardening/history/

- Naresh

