Return-Path: <linux-pm+bounces-15906-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E889A2E14
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2024 21:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C22B8284488
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2024 19:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A42E1C3034;
	Thu, 17 Oct 2024 19:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b3658SlL"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560961C1ADA
	for <linux-pm@vger.kernel.org>; Thu, 17 Oct 2024 19:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729194785; cv=none; b=Y+DI14MDxE+Imk0vQTS5Mzrkkuf2ek10HzSmjn9eqgOK5HSiUC7/fGf51BX6lwjO2iSrexX4Rvp2WMMex0n8m5wG8NSW+ihHK4dmn8t9cOMVWNTJ9lmtcFstjYDCbLTCgaImIt4ST4HkoF3PbwhZ49K+SxSwuEl0NvzpOmxv26o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729194785; c=relaxed/simple;
	bh=Ssd11H93sk5ygXnqhgbjXUBPDX5cnQRhKUv7pZtwu0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f3HoqtNZ4KTW2n+UWDWDBj+8NIIel6J0E9UiJFZpzQi1YhZzfWQtEMAUwgloqD+uByour1eQ4WGFl8vwwwWP13lXnCP0+aKuOc1BgyfbDhTc3THtMWfg6sx3MxFoDjeBO9at9hD0fWVpjcX90sv+1qBml13kQQmdEFA2sZXBaXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b3658SlL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729194782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MAAY1Jp51BHOMwyTh1DOH9dr6mO8pFEFLfZAahSAVno=;
	b=b3658SlLhkWVC7Ewx5LkuKuv3gv2pgkEnfzXbiyLzoZcci8RnwjDc6lEIl/eye0DZRKpyB
	C81abrkGT38EtwqxYtomdIqUpDRbn/tno0u3F/ZjRUB2nZVwmqgfjBvNeDlZCryTWTTxkb
	jDMzOnOeyTzMWpK1dfzOwBC8u8DVDnY=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-348-hh3fW54cMC2cgWpvglJ6oQ-1; Thu, 17 Oct 2024 15:53:00 -0400
X-MC-Unique: hh3fW54cMC2cgWpvglJ6oQ-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6cbeca2b235so25006246d6.3
        for <linux-pm@vger.kernel.org>; Thu, 17 Oct 2024 12:53:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729194780; x=1729799580;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MAAY1Jp51BHOMwyTh1DOH9dr6mO8pFEFLfZAahSAVno=;
        b=tb3ZFeSE5rtsPohx0LjffSehM/0O+Qc0p2bQLO8w87UEde54GDmwgW08xHr9jKgwE6
         LMLe85eRoHrSDeNTctDQfnNFCPW8JtYg8qPQozYw9/n/be+ccx619tHqAZgCwj0yBJXv
         bvSHAIi8OQcUhhoOqshG0Vl16yRKAVgGIbMR1XGrQNzi9PNgiFr02gNpVxF1W9y79cDe
         7TYa+txkBm6miUjhVSUXT83jKsdd9FEsmGpUtgFtACb8zGPZv/X3FJnYpsx5L1ZTBElz
         F/vld2qJFvLWRk0wk/c5BrhOA3WzWs/R6Q+B2atgVBSHg/m8Q8m7U5KGfcEBNoIXra9l
         3zRA==
X-Forwarded-Encrypted: i=1; AJvYcCXq7ymO0BBJOpFDbNLjw9dvHdSXvj38or5cfU7Xywt12/rmEFrKTTqCy0XGtsm7sxPzlRaIbIHUmg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxUC3qmXJfx0ZWHoURi2pz1h38XfzkvV9l85Dd5gc2aujDYcPvG
	r/0BK2DzGYXhzsblMbIciFJWRedAt2yniTKxniK6wTyuAWEsFRtKiN07Ez6fsT86qSTpdhe37hn
	FTiUA1VsgxTPzznz0aZnIp+SRj5xHqogci8AhHLG2FCrQi/ogVjFdYV0a
X-Received: by 2002:a05:6214:5d0b:b0:6cc:1e1c:b325 with SMTP id 6a1803df08f44-6cc1e1cb376mr198400256d6.42.1729194780188;
        Thu, 17 Oct 2024 12:53:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHV9CY4jwCJGAWu6mTkhoOW5s5G1h+wF8O0ZmWD5QGWvzhssrrwfhrcjRrqJie2woP3QeRAsA==
X-Received: by 2002:a05:6214:5d0b:b0:6cc:1e1c:b325 with SMTP id 6a1803df08f44-6cc1e1cb376mr198400066d6.42.1729194779810;
        Thu, 17 Oct 2024 12:52:59 -0700 (PDT)
Received: from rhfedora ([71.217.60.247])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cde11829dcsm3316d6.60.2024.10.17.12.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 12:52:59 -0700 (PDT)
Date: Thu, 17 Oct 2024 15:52:57 -0400
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Siddharth Menon <simeddon@gmail.com>, shuah@kernel.org, trenn@suse.com,
	jkacur@redhat.com, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3] cpupower: add checks for xgettext and msgfmt
Message-ID: <ZxFrGUvXlyMkCUel@rhfedora>
References: <20241017133223.53070-1-simeddon@gmail.com>
 <d027a0be-b1b1-4679-89d6-351e0f313e4f@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d027a0be-b1b1-4679-89d6-351e0f313e4f@linuxfoundation.org>

On Thu, Oct 17, 2024 at 10:04:29AM -0600, Shuah Khan wrote:
> On 10/17/24 07:32, Siddharth Menon wrote:
> > Check whether xgettext and msgfmt are available on the system before
> > attempting to  generate GNU gettext Language Translations.
> > In case of missing dependency, generate warning message directing user
> > to install the necessary package.
> > 
> > Signed-off-by: Siddharth Menon <simeddon@gmail.com>
> > ---
> >   v1->v2:
> >   - Checks for gettext tools outside the target definitions instead
> >   of inline
> >   - Replace command with which
> >   v2->v3:
> >   - Update commit message
> 
> Looks like there is more than just updating commit log
> in this version. You fixed a problem in your v2. :)
> 
> Also when someone suggests an approach and give you a
> diff, the practice is to add Suggested-by
> 
> John, Do you have time to test this? Asking since you
> tested the previous version. Just want to make sure
> this one works as well.
> 

Yes I do, all 3 messages only appear once when the gettext pkg is not
installed on a Fedora 40 server using the make command. When it is
installed none of the messages show. Works as expected.

Siddharth, assuming no other changes. :) Please include my Tested-by
tags so others know your code was tested in your V4 along with Shuah's
Suggested-by and document the clean up of V3's msgmerge.

Tested-by: John B. Wyatt IV <jwyatt@redhat.com>
Tested-by: John B. Wyatt IV <sageofredondo@gmail.com>

> thanks,
> -- Shuah
> 

-- 
Sincerely,
John Wyatt
Software Engineer, Core Kernel
Red Hat


