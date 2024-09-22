Return-Path: <linux-pm+bounces-14534-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57FAD97E251
	for <lists+linux-pm@lfdr.de>; Sun, 22 Sep 2024 17:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C723128103A
	for <lists+linux-pm@lfdr.de>; Sun, 22 Sep 2024 15:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A50FB173;
	Sun, 22 Sep 2024 15:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GaOImS/H"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60893224CF
	for <linux-pm@vger.kernel.org>; Sun, 22 Sep 2024 15:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727019590; cv=none; b=gbA59XXbUw6AmZQ/TjwUx3XR1LjjZdGJZJWBktqc9O6bQFnIOmepWBXhiTGlPMr8ivdIlV1HuFOMtzd75wUtNZrr3sGVQSpY3iKku7VpXA/dFEv3uG9xq26sfmdkxBZlrGHdFbo7h+MI0esSKTcyQiu9/1plsjfAfbgDE8dV+cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727019590; c=relaxed/simple;
	bh=PUgL8/X5kk0A6C8lhHqaF3yeeShTkPQEj3XfKgJqe94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GlIt/wXYqiPmToeJ5xaYfBUOa/Y6PlI20xItSpUaUOP1rOEq+xbaVxxv8jc8k9KyPv3oIl5AkpBihRYC/5Zuzl5FEPyVY2O6wmiwRbHtOkH6JSsX1uAvw/c4FwzsEHcYSWfo1BKihGlWVREebr+sod9Aj7rRMhXk+942UkAKJjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=GaOImS/H; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a8a897bd4f1so518551666b.3
        for <linux-pm@vger.kernel.org>; Sun, 22 Sep 2024 08:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1727019587; x=1727624387; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZFxgZTFjgb2JZJAextayyq2RXVTLpxRhrGXsrPnvanQ=;
        b=GaOImS/HYu6TN8aaWuiNiW/J9HI3dVWMeovybQVkGKBw0oXVtqa8rQfGC4ivYj3vUy
         ZNlOAwxm49ptKgcUEmy636heSYvbqsDRI/9r2Mo95tVBfQYTdOgK+bZogpCybiYTLfjj
         XKXiJjQEU3kr7Xe6exftrkPfwtA2pRWQ8bmOE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727019587; x=1727624387;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZFxgZTFjgb2JZJAextayyq2RXVTLpxRhrGXsrPnvanQ=;
        b=k9+vtm1hQhGDikluiywQ25XvFv4IeuKJ5n1qqic7FP5p16c6THQu9q6jLJRoZqt3YO
         1oVsP/yt7+uFwVi4zhRDp02OqBO7mcy3XyirNJ2x4nDNUpZdgL4qyN3922QZlT/qT7BC
         Lpk4kHy/Gm/QxVZHwTkkw3AzbLZ+KQ09iUjgzERQaKUSsizLxGDJd2IKvUsi6d/F1lFy
         ZxurfEvoWI0Kh5HNqHO1fGEh7OophlV0BfQrD3rS4rhieLxOHU4QvAZIjDwk5yNf9pzU
         5xDmsKlT4zqd//UjyVOUMRA5ftoFRzDg+JxGD5Pd6l4aiIU9xAHwWT54mzGA5D2lKnyv
         rF+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUnBAdZWnv5kheoo2r427qwSZgoNsTqw6KwIOv41x0D/OSCPENA+yvPn5PxwOpAzYPsewpE74FUZQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwPMufz62GvCEIAlPUkiBgbKehiac3e/+RSD5RGafHUMWk0nVf9
	KO6108xIVo7vp3Hlo2lNvlRcBYD6HLh4vj8G2zov2h3HH/tXPH/3oIy+0aT0U9/R9dDcVcbFo41
	2cak=
X-Google-Smtp-Source: AGHT+IGvyQkiLfi5FfH7/jY50YVbSNFRJodArfWuKwecKEN1WAB2KEr6ZcAwJ4598tXD66kep5QFsw==
X-Received: by 2002:a17:907:7e8b:b0:a86:789f:c756 with SMTP id a640c23a62f3a-a90d50fd4aamr982550166b.53.1727019586636;
        Sun, 22 Sep 2024 08:39:46 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90612e50easm1109995266b.174.2024.09.22.08.39.45
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Sep 2024 08:39:45 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a8d446adf6eso547611966b.2
        for <linux-pm@vger.kernel.org>; Sun, 22 Sep 2024 08:39:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX6jby6hxOPsQYNDOUji5duWPGSxTBOH8nMmQJvJEYVPPn5rm6/nC47pi0S81+v8w0AOoafqHAe6Q==@vger.kernel.org
X-Received: by 2002:a17:907:e253:b0:a8d:3085:a7b1 with SMTP id
 a640c23a62f3a-a90d50124d9mr838803866b.38.1727019585320; Sun, 22 Sep 2024
 08:39:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240905021916.15938-1-jwyatt@redhat.com> <20240905021916.15938-3-jwyatt@redhat.com>
 <0ff4937d-0e51-4d67-9b8a-d2bf1bebe1fb@roeck-us.net>
In-Reply-To: <0ff4937d-0e51-4d67-9b8a-d2bf1bebe1fb@roeck-us.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 22 Sep 2024 08:39:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjVpftmPF3SopywFgQ+uzgdScTPWTxmq7HwinVqwbue3w@mail.gmail.com>
Message-ID: <CAHk-=wjVpftmPF3SopywFgQ+uzgdScTPWTxmq7HwinVqwbue3w@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] pm:cpupower: Add SWIG bindings files for libcpupower
To: Guenter Roeck <linux@roeck-us.net>
Cc: "John B. Wyatt IV" <jwyatt@redhat.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	linux-pm@vger.kernel.org, Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org, 
	John Kacur <jkacur@redhat.com>, Tomas Glozar <tglozar@redhat.com>, Arnaldo Melo <acme@redhat.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "John B. Wyatt IV" <sageofredondo@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 21 Sept 2024 at 14:23, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Wed, Sep 04, 2024 at 10:19:09PM -0400, John B. Wyatt IV wrote:
> >
> >  .../bindings/python/raw_pylibcpupower.i       | 247 ++++++++++++++++++
>
> This file is deleted when running "make mrproper".

Yes, please don't create files called '*.i", "*.s" or "*.o".  We
assume they are generated files (the result of the preprocessor, the
compiler, and the assembler respectively).

And yeah, obviously "*.i" and "*.s" and not _usually_ seen, because
they are only steps on the way to "*.o", so maybe they aren't _quite_
as obvious as some "*.o" file would be, but they are very much
standard naming, and we have build rules for them (ie "make
kernel/exit.i" will create the pre-processed result of exit.c).

                    Linus

