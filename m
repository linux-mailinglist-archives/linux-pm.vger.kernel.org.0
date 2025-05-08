Return-Path: <linux-pm+bounces-26888-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09BEDAAF8C8
	for <lists+linux-pm@lfdr.de>; Thu,  8 May 2025 13:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED6554E62C5
	for <lists+linux-pm@lfdr.de>; Thu,  8 May 2025 11:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F81221F1E;
	Thu,  8 May 2025 11:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cErWP2Vc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C6821D3E2
	for <linux-pm@vger.kernel.org>; Thu,  8 May 2025 11:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746704114; cv=none; b=RySH6BUYyVq4qx2qbyEk527gR5LThaqOgJ5iVhweAkK2aRRZN124qrt5Nqeg+KLrnlT/7RgdNXN6eVyzvyEYuWvAiG0pFlfDtmevBNt60MOtU7iJxmYDjKnN2PkC1INQ0UsNry+2/6wsrVJIxfdWYyDotP8gwWhepViJMzbn75M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746704114; c=relaxed/simple;
	bh=bvVyv6xMDGMJyUYc55F9Ofhjgol/RDYaGz3yYp9ZNsY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tG5nTnxV9ni6XO487cKv0/acidY3NFskkujz9tu2c8VAvsOd5VN1w2EA66YviV8/ljVCWb0vAEeljCz4gh8OaDd0FV62wPdE1U4Y4NjlNCSZShiFtEW20dBeGcP0oaa+wb7xD5FCdIpU1zq6iRZ+rWG/JGKaLCBuKj4R8LIOuqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cErWP2Vc; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-70a338b1ce5so4284027b3.0
        for <linux-pm@vger.kernel.org>; Thu, 08 May 2025 04:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746704111; x=1747308911; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+cFDupK6Xf2E6C4tAlReAOJJ7NUs3xHRwtk+nXwvxV4=;
        b=cErWP2Vc/udCDZVBdVmIOClhqgVwY5EE0StXi91/R55KoNHE9Ne4hqyo1PrCO3+2CF
         9XnzoeQKlP6Dc4Bf/SGBhLoRAd2wBK7ctdqxu8li70ktwE5BzlEalTqC75Xo7DKShKHv
         myd3fBwnxA1VvoFVylqPXZeSrQLX2MGY/OoIcRSvzTUE6xgc+jQr/CwtIrBISKWmsX9p
         B7pFG+mfmwCGCBs9UgDTkJb4kCV6NzR6Cy+ugQ+YdWQYXOzlsLLRMOI78nP1bRhIPtRX
         cxqlye0x0MYW7VGWdEz4/2WLYGJDs4/BUEtv4DgWLh7+sgCPLCNvZofzJgzdnZr6jMtN
         y1Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746704111; x=1747308911;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+cFDupK6Xf2E6C4tAlReAOJJ7NUs3xHRwtk+nXwvxV4=;
        b=i4weemKce46XShDffEWa2XtTQNvN5S4CRZPWtEAyx/M8s+kS/dcFmB6uUnBURd5m7W
         I5m3b9gYH+d01pJp2oZFqyRmtTnM0hzv8C3c4m41lvbB2dmVBIJR7wZQw0oxkvg0ccJP
         /jvs+0WmQI8R3sYYA9Q7eDlZ9n9LU4j5g2B/JDGgM8OflPgOzk2pgCiYajofQ7vZr9lw
         X0pBZQg7fFMKhOF439nmcI9PMkGbRdnLjwbQxJWBIbc0EkAKVQeaquJJpjNGlQUnhuMp
         8OMcPRs82zmG/YT8odk0LzTbmebZiVcpq9QQNADX67t3mamCDST4gc27xBR/5Z4ibdQ/
         wn4A==
X-Forwarded-Encrypted: i=1; AJvYcCUZbJoxrQgHDa2L7mLm0CoQzh9zggh8zAMyjGbyhy0on+3QjMG6J1jcpdLTsazAWSuLYmqqKIl/Hw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2GZ3zw7isrTOmVMM8swyUBtHbhV0O8T43h1BZdwDUpx77HOhS
	ak214KFOT11VGDnB1aIqzqfXpE79rc8GtOB71hVQ9C6kEoAqYqhHIXT2edwLthK8xWr1bKzQv53
	6rRGVp0f+HWkZEMhcmvzt46/iOtNrZ7W+T8U97a/OmkTXhRGC
X-Gm-Gg: ASbGncsnf+44U/iB9RDuhD9wmeePD/P1yFiuLCyZajbIB4iGcwVEu6wQhu14k5QGFYP
	85Py2KizBd176EQUB8wn7pb7SHyQ+2O38enOMMBJ/O1DLQ0WY2/SqHENlrDmBHawhSIVUuvvmp4
	Tu4gYDRZQMsL2m1peIqn/TwNc=
X-Google-Smtp-Source: AGHT+IHN2lUuKUTarkdcjyDqAknRCn/fWmfDn/tSy5fWl2NXM12u16FDC4NBp9NnMQQejpVFcCMkShO7wmk1XhnlUdU=
X-Received: by 2002:a05:690c:3581:b0:6f9:48c6:6a17 with SMTP id
 00721157ae682-70a1db14904mr97981527b3.26.1746704111629; Thu, 08 May 2025
 04:35:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aBxPQ8AI8N5v-7rL@stanley.mountain> <CAPDyKFoZiEAn8yT8a9VZqayR1=HPnMn+a51O3zUAUR3L6RXH=Q@mail.gmail.com>
 <aByIzTj2t1I9Wrzw@stanley.mountain>
In-Reply-To: <aByIzTj2t1I9Wrzw@stanley.mountain>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 8 May 2025 13:34:35 +0200
X-Gm-Features: ATxdqUGOeXxjQLDl7WQSeWq8Dw_7uuE6KmRvz_BasEIpW18BLduzRZu0OBCb7go
Message-ID: <CAPDyKFpiqrZwebmo+n9mO6Fce3ZYWhVLzcDu37SfphdvpQxSiA@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: core: Fix error checking in genpd_dev_pm_attach_by_id()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Niklas Cassel <niklas.cassel@linaro.org>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 8 May 2025 at 12:34, Dan Carpenter <dan.carpenter@linaro.org> wrote:
>
> On Thu, May 08, 2025 at 12:14:41PM +0200, Ulf Hansson wrote:
> > On Thu, 8 May 2025 at 08:29, Dan Carpenter <dan.carpenter@linaro.org> wrote:
> > >
> > > The error checking for of_count_phandle_with_args() does not handle
> > > negative error codes correctly.  The problem is that "index" is a u32 so
> > > in the condition "if (index >= num_domains)" negative error codes stored
> > > in "num_domains" are type promoted to very high positive values and
> > > "index" is always going to be valid.
> > >
> > > Test for negative error codes first and then test if "index" is valid.
> > >
> > > Fixes: 3ccf3f0cd197 ("PM / Domains: Enable genpd_dev_pm_attach_by_id|name() for single PM domain")
> > > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> >
> > Thanks for the fix! It looks correct to me!
> >
> > What puzzles me though, if this is a real problem I am sure we would
> > have been receiving bug reports, don't you think?
> >
>
> I think it would only cause an issue for invalid devicetrees?  So it's
> probably not an issue people often see in real life.

Yes, you are probably right.

Anyway, I have applied this for fixes and added a stable tag.

Thanks!
Uffe

