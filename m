Return-Path: <linux-pm+bounces-14629-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82180984BE4
	for <lists+linux-pm@lfdr.de>; Tue, 24 Sep 2024 22:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEA2C1C2017C
	for <lists+linux-pm@lfdr.de>; Tue, 24 Sep 2024 20:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF54126F0A;
	Tue, 24 Sep 2024 20:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gDIeMDP2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0875A450EE
	for <linux-pm@vger.kernel.org>; Tue, 24 Sep 2024 20:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727208118; cv=none; b=MucV9jLyIxVE/+K1IkmCWYs0WPv2uOr2LCK+mRk7G6Av/oGrQbhCEnhjVRLiPGCFe/asF9q0jIPekfLC6Wrc9v9rNSlxWajT7muyW+qucArtHWEDeaeZGgHhCd1L1HeoY3jcrADKnDO9dGUt6keRGHVYTQioAVXROLqOmO7Zf24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727208118; c=relaxed/simple;
	bh=WUWs1cGV8UAjwT4Z5LncZWgi8ievdMfXJpppyHQHoic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ur3tNESIugg1ZKns4CcIai2UQhyieN3KRlqzVc1TnJrOUko4+De5VzZNBPRuzeWmqaLhPYfm8doM9J/x4BY1KtIuvMzUtqJykSbF8uJe2dvbhepgH5CppcwOeHDSSUOEVFCg+L+rVVxg51X2f4+aq5V59/Ru0YGcGzRim+c2Tm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=gDIeMDP2; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5365c512b00so439785e87.3
        for <linux-pm@vger.kernel.org>; Tue, 24 Sep 2024 13:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1727208115; x=1727812915; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RCAkYMz+z1YFzhY4Fh2dqrlaBUsgV20ERyXCfxSdKns=;
        b=gDIeMDP2zRPht7KWvmrz75gkmfCJbuA2e/eXqMBGxScju2PnB7CeFciKt7h3RyXYev
         9JlInlXCx1V6e8NXHVmcRMeI1w4k8LUuhgWukNHlltqrpIsR/rEmG1OxRuy1eptkwDtO
         p39cNrL3VN0HoonK+nCqfcYy9LgdDPm+ofnm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727208115; x=1727812915;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RCAkYMz+z1YFzhY4Fh2dqrlaBUsgV20ERyXCfxSdKns=;
        b=oId/vwuzPT/YpKBdHES+1kIILw98Y/uBvFwFkAlr4HdNyM+xVQ6prZnvNet3G1zlQu
         hA3MPl3MlPrU/WO3+yZDhplxBacjLNvo0nA4tocNkEdHFtLtA31aT5ctAX0j9624qViX
         SnfAzdFWKV5Qn96gukWzAeC27DriI4GZuF0DJQxXKOrpS0qnlfgpGoTt8FqIUZPSIfq7
         0GjoBXhGwGz87HiNqOJ1bgMiTTYPyAShgJoY/rtJi7y5CQ8qlvFEzmBCnrUazZdPzAVG
         yBiqbwHfySlKDzUO5XlQKk4CVKjmqI7+/c/eRWGDWKoZZrrgFdummeqxLRPW5pIowbAX
         DkHg==
X-Forwarded-Encrypted: i=1; AJvYcCWDBP3kE4RpbPhauriVT2XSrDrRSpacEAGFDRs39ZXOhkStrbeBHpTp5+dTUkLVZMhdTmdZ8fhchg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yze8p6vz7M4mqcR/FUcI6mfNis9W7KQEMz3Ya0WWy51qE7WY2oK
	s8SL5rLChEPKlWp3fsCZ/8bNG5qPd22AwZH2s4bnO2Lez4cuJNQbdCV5bwulCa42bhUN4aj5Pa9
	nzqMtLg==
X-Google-Smtp-Source: AGHT+IFLF/DXBmcjOML5Yelx1YqUO33S+9SooBXyroqyhwhB/15mE5obNiQUgBNjD3+ixeKahigkoA==
X-Received: by 2002:a05:6512:138d:b0:536:a4ed:76a5 with SMTP id 2adb3069b0e04-53877538a5cmr146251e87.21.1727208114744;
        Tue, 24 Sep 2024 13:01:54 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9392f54691sm125201666b.85.2024.09.24.13.01.53
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 13:01:54 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a910860e4dcso378382266b.3
        for <linux-pm@vger.kernel.org>; Tue, 24 Sep 2024 13:01:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU9/+ZkuUZSwyC6qIwN86tTDBBdM5Hf+qoholjSWeXrFubLnkrr/2Df3qDQPi1CkyJOI2kae48GyQ==@vger.kernel.org
X-Received: by 2002:a17:907:a0e:b0:a7a:a960:99ee with SMTP id
 a640c23a62f3a-a93a03af734mr34328766b.32.1727208113495; Tue, 24 Sep 2024
 13:01:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cf329845-48ee-4b25-9b5a-02a6e2b55e5a@linuxfoundation.org>
In-Reply-To: <cf329845-48ee-4b25-9b5a-02a6e2b55e5a@linuxfoundation.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 24 Sep 2024 13:01:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiLgK+Fbok8cnpAJD6D4_NZzEv0==i7k2XR3-Tvc1Hr=A@mail.gmail.com>
Message-ID: <CAHk-=wiLgK+Fbok8cnpAJD6D4_NZzEv0==i7k2XR3-Tvc1Hr=A@mail.gmail.com>
Subject: Re: [GIT PULL] [GIT PULL] cpupower fixes for Linux 6.12-rc1
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, shuah <shuah@kernel.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, 
	"John B. Wyatt IV" <jwyatt@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 23 Sept 2024 at 13:19, Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> Please send this up to Linus if at all possible before the merge
> window closes.

Bah, I took it directly, since it was in my mailbox and was lit up
like a christmas tree because it triggered my git pull search
criteria.

                     Linus

