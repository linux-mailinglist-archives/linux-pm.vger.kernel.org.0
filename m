Return-Path: <linux-pm+bounces-6250-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9611C8A0125
	for <lists+linux-pm@lfdr.de>; Wed, 10 Apr 2024 22:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01416B26627
	for <lists+linux-pm@lfdr.de>; Wed, 10 Apr 2024 20:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865F7181B91;
	Wed, 10 Apr 2024 20:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="H/RMv6Th"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDBE1E877
	for <linux-pm@vger.kernel.org>; Wed, 10 Apr 2024 20:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712780301; cv=none; b=R3OwdF0m8Zvxoi0YwAEJDrp09fAk1ViZUGxyqGIZxDQXLU5UnwgtoOBUEoMX/bVVpXI0c5jmKis+d4CiM0p6Jualm1vr4IvC0eGvIW6eW2UyDa88hWMSNmHu2lDq8zbexkyfparuaZEUKrK4ZMoqZ8m3eMAfGzf1XyZwhV6NTto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712780301; c=relaxed/simple;
	bh=0QmAEO9gx6lEuCEFA6L/n80e1g8oAxeOfd6kHXLpqyA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SHDO6yKK27WZftVfeZjxBNZwLL4rnCt0aSgZW4PrulGchX/Zp9hVcrba8QGI4nu7QIQBFBdfobpPJPWNxA1QPQW2EVV9SqOpCh2gqngnSjzWLXxUJX15JEBWeISgeJknSb06KiEOa/2QySWigza8rulfZZDogMtehWrsYCIus4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=H/RMv6Th; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a51addddbd4so630859866b.0
        for <linux-pm@vger.kernel.org>; Wed, 10 Apr 2024 13:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1712780298; x=1713385098; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NrCW3DHTcZwfmublVXY2qPJR7NVLmg9fl0riAP8CR10=;
        b=H/RMv6Th/2sbroktS5xFRhDp4fYlAplzCRpQq1FkN3UkdLh0eUElCDulc7kXo0EuWv
         NrOX8wfmbCcNEMTil71D3joPJhux+Loxe96j1dPmjjWPYqhaX1cNz+8Qjs4yYW5le4Ld
         a+EPlfuRowOh7dSV+zVfCd7mWJxKY/ZQ4NTQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712780298; x=1713385098;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NrCW3DHTcZwfmublVXY2qPJR7NVLmg9fl0riAP8CR10=;
        b=DAlP4arn7JIKMbbME+RrAmhU+5H/YWd1rJ7/aEeWxVG6aYnoOGMMXjPHnPSbsR9sQi
         TR6UkFBtSM8OZu1s7FCK4LWzXlljn7xLA3Bcv+LylO203YZfCCC7OdFy+HjDnsrABv0P
         zTq/N3kQQ3i8v8VirQQ/cmWgtJD1t7QqfCos5ZiVAXtN5fJoGVBhl/b8c6Nczlme/eKv
         WoJNvW0mJ2A5IPy05I1VxjCfYl1m6LW6o3NdVnc1NgSgnyHoLMTLWp9NX26X8Guiu5EK
         huFgEAav+bloA/rcIJ0kbFdg9ZnelcyYALoJEwTEC90PRGdSA765kbeW8qFHpYbr7NVf
         YIHQ==
X-Gm-Message-State: AOJu0Ywex6HAfQpvLVR0lbbXsxr7y+vSgdVrUMJW5GgSfk9T3eHztvl+
	tgSxOZKVRA4buaH5O56oxBTHSP5otDS+yI1rs5VJ504qOX6J6VaJ8HvwFky9+CUDNJAlK7iFpFO
	tM6DwOg==
X-Google-Smtp-Source: AGHT+IF/ZdhD7L6YEUZWqLeSCPr28uPT8+189ycMi01ml0FrV6DnRxr0HqvHB7NxU19TcoZiV2xyYQ==
X-Received: by 2002:a17:907:968b:b0:a51:d1f6:3938 with SMTP id hd11-20020a170907968b00b00a51d1f63938mr2923655ejc.42.1712780297651;
        Wed, 10 Apr 2024 13:18:17 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id gz7-20020a170906f2c700b00a51b1dc3b6asm19209ejb.64.2024.04.10.13.18.17
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 13:18:17 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-56c5d05128dso8055686a12.0
        for <linux-pm@vger.kernel.org>; Wed, 10 Apr 2024 13:18:17 -0700 (PDT)
X-Received: by 2002:a17:907:b9d3:b0:a4d:f5d4:fb02 with SMTP id
 xa19-20020a170907b9d300b00a4df5d4fb02mr2295400ejc.51.1712780296715; Wed, 10
 Apr 2024 13:18:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJvTdKmK_U7nChpm=MzaDyw3T9V6hSua-6C89WCjo828vxm+yw@mail.gmail.com>
In-Reply-To: <CAJvTdKmK_U7nChpm=MzaDyw3T9V6hSua-6C89WCjo828vxm+yw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 10 Apr 2024 13:18:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgaTzpJssX2z7OiQOLL0BZzHGAfJn0MYPhuN9oU0R2f-Q@mail.gmail.com>
Message-ID: <CAHk-=wgaTzpJssX2z7OiQOLL0BZzHGAfJn0MYPhuN9oU0R2f-Q@mail.gmail.com>
Subject: Re: [GIT PULL] turbostat 2024.04.10
To: Len Brown <lenb@kernel.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 10 Apr 2024 at 06:24, Len Brown <lenb@kernel.org> wrote:
>
> Turbostat version 2024.04.10

Tssk. Things like this should still come in during the merge window
and preferably be in linux-next.

I have pulled this, since it's obviously just tooling (and the
maintainer file pattern update), but stil...

                Linus

