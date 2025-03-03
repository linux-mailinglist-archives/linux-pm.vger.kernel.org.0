Return-Path: <linux-pm+bounces-23298-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0080EA4BF87
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 12:57:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 868A1188AFA3
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 11:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949DD20C499;
	Mon,  3 Mar 2025 11:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FCX1s3W7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102982036F9
	for <linux-pm@vger.kernel.org>; Mon,  3 Mar 2025 11:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741002959; cv=none; b=Cej2U4ng/3yR+WtPxKng+YIF+VB9sJ3JV04/jcjfMynT/10dqbkAwHm0kzHUx8MldpP5meDcH2ePnqYOzOPqUEazACYnrQ5R+bA/yWnA9lIn2PQQMZ/2vzhp0Ps6Uj/zjRSY2itMim7YocRISeB0FjzPdwPiSVi1Jig5zz33cPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741002959; c=relaxed/simple;
	bh=XNgWdH8fl5cRzt9ljpvgTEJNjZwPu9TAIUcQAUPpGJ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rx1I3SsJE0227n5B4xgi8UXBnp1ZQO5Wv77U3p9wNLDLB9YdxFJk6neYjcOyUWbBOsdNxKv/sVlUD5e0A95iduC3HJsXCilpwe02egz7l3qlfcHo5Dexxf8L3J0prAUxji6zpjOPuZaDkjqxWq1JeDXP7fIF1IwrLjrBZfkJlUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FCX1s3W7; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6efe4e3d698so37452907b3.0
        for <linux-pm@vger.kernel.org>; Mon, 03 Mar 2025 03:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741002957; x=1741607757; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XNgWdH8fl5cRzt9ljpvgTEJNjZwPu9TAIUcQAUPpGJ4=;
        b=FCX1s3W7gks/gh1gIaOYRXTZMnZnt5XYck4kneFLu1lY53SmOcChbVtjj/FYmSWOvE
         tH7XeRuCCxMQDvpvj6CIE2s35eMVGd3dMRELe4xJl3w4Ecw4tHdwFSYjicq7XMaZrbK9
         J3Zb9GnCK5MrgVENiax+Wj4CP4+30ULaKIoB7cVk4HVlL1UC3lOPeeK7/4mi2KDNPZon
         HakKlODddkGd/FkddB4b54NQlKJsWDeoMXTDS0mkYtmvypHOLx3QqKDx+hrdtAtWdmbR
         2rMFSIV50oWxtzECb6I3YOChrCr4tzRgYE+UMvGAthnElw6O81qqExbblEn+/LbCYvxU
         Y+yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741002957; x=1741607757;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XNgWdH8fl5cRzt9ljpvgTEJNjZwPu9TAIUcQAUPpGJ4=;
        b=I5dbz9qoO/2j70p4Gh8RPB244XR9Cktu2wcKrBt924sA/LkJdkn7dtishckgl/7daR
         4XnReSbV6hU35ujnUEgowW88EOkBvpd40gxyW+D6SvbBTbhofrNwTcOXq/bkIodaPFYZ
         HdvzXBD+KYXveFbcUL4jduFQcEwWIK/HxWi9ZbAHzRo9j8mumu0bFI7mwYF7utyYLVxG
         MC0pFJEdNDZHsFnT3FCReEObVmIHktUkNtzT3UMoRsyZU1VtATtqnzLpbmxdnPy5EgbO
         jaodJDx4sim5jnJgt2u+Rdo9IOnjcxB4pVp5u4RXcGfDGzqLVbiip0IfUOecaxM5LkuS
         Z6Aw==
X-Gm-Message-State: AOJu0Yw0JVZBcjx1ETH1KIQfgHQ0n2LAXVi4Ccv2SGYtrUL8c1R2E5/f
	nJOnGyomvIfoKddOVJvbOS3gDB0D5fS9EbXQWyIzWWzyUbzAd4yfZkNLKfCIrla+/QSeO2t9d6F
	AzjRQ1GygrobPQselcSvGTItK+CDkI/yv5kK5+Q==
X-Gm-Gg: ASbGncvaYwSqbvg5I1YaP9kMyfBlusMqOnmZk9DyEn2/QGJt+Rqyz4T43A/T25y/jo1
	fBDzHxa8iL7YiZABEolR4KwPTYNDNTfZhdqArevb3Czsnygen+IJyPz61DFIlthFC6ytQIXuR5u
	Qeo/rd9CXF/cIxvoHhb6KnJN0r3Is=
X-Google-Smtp-Source: AGHT+IGX8q8UK5ca8HVl/UrYuKtJYKHT+VOk7Nc15oA5SjFGT6TC1WnbIOSec57WlAO7CIGV36a6PfFL7M2kit01IOI=
X-Received: by 2002:a05:690c:5719:b0:6fd:3ff9:ad96 with SMTP id
 00721157ae682-6fd4a16d0aemr115286237b3.37.1741002957064; Mon, 03 Mar 2025
 03:55:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5000287.31r3eYUQgx@rjwysocki.net>
In-Reply-To: <5000287.31r3eYUQgx@rjwysocki.net>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 3 Mar 2025 12:55:20 +0100
X-Gm-Features: AQ5f1JoaEzH0RILD_BxoqNSMy1juR0ec4QxtwfOG9M6tuXJbj4t5l5bWPbiZLn4
Message-ID: <CAPDyKFpo-Pn_4aUAwowQmNDDa2zEZ6hwJhAAzCfArzzdt511Fw@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] PM: Tweaks on top of "smart suspend" handling changes
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Alan Stern <stern@rowland.harvard.edu>, Johan Hovold <johan@kernel.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Jon Hunter <jonathanh@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 27 Feb 2025 at 11:49, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> Hi Everyone,
>
> These are some tweaks based on
>
> https://lore.kernel.org/linux-pm/12612706.O9o76ZdvQC@rjwysocki.net/
>
> which in the meantime has been applied to linux-pm.git/linux-next (as 6.15
> material).
>
> None of them is essential, so if you have objections, please let me know,
> but IMV they generally will make the code work better.
>
> Please refer to the individual patch changelogs for details.

For the series:

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

