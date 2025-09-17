Return-Path: <linux-pm+bounces-34822-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8725FB7D520
	for <lists+linux-pm@lfdr.de>; Wed, 17 Sep 2025 14:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C66457A49C7
	for <lists+linux-pm@lfdr.de>; Wed, 17 Sep 2025 05:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9899627E077;
	Wed, 17 Sep 2025 05:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bhyrsogj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2215F266B40
	for <linux-pm@vger.kernel.org>; Wed, 17 Sep 2025 05:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758086038; cv=none; b=ZFxIcgjyzZdrBowUWBA47cFhuRxgtjqb1x089XHoY/FGT9KWhJ2F7FCh9xSEMSL9oKmg8I0cABqPbC29zt11CnrZULaWomRAnZnDMYa6y4kcBQz84EVgpXElUZ6Xi8N5jor0cb2/qlfsUV/cuiHM4FcshB/QQBdEdUdWgrwntSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758086038; c=relaxed/simple;
	bh=sPYx5AEOiKjmkdLNHabB47pnhMs4u/bilvZUHKYNgmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XIAPD0y7Mga8Zs1FAWo/ojMez6NnCE2ipN+Y5AdE70iD+ufwo6ktmjK/X2XsUIe2wk44mAzR5GdzxyYFT5kkWsT9cgc1RhZUNqEOYtYHxWfghtEJS8MUKL345dVcLfuBQ6WNq9vW2x9t/42EDMFUvqCCVLdtuhwY71FOp627BJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bhyrsogj; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-261682fdfceso5409785ad.1
        for <linux-pm@vger.kernel.org>; Tue, 16 Sep 2025 22:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1758086036; x=1758690836; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eWYaoffWKIIQ1eAIMueoITKMYiLkj90T5d8Op1iUdtA=;
        b=bhyrsogjmjYNydXCIzxHlSWb6uTrIU7Zj/MdMESVLRUG7ATPtToKb5vU7vxYjtYXbQ
         +xXLid/E8wbvbqr0wr4QhbNmsHtQuX4Oxkb+lZxDP8I0BwR3nRJCCTBT955vC0PO66zF
         QKI0nbEdJqt8K5dHvQTOeBNSZ+zZ2yXhlhzWo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758086036; x=1758690836;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eWYaoffWKIIQ1eAIMueoITKMYiLkj90T5d8Op1iUdtA=;
        b=Yz3SBOTyvAonZB30l8GfTyrl/HWQiGdy1SBH5oFEeTOEWuyuPusg+lvR7BsTKripRd
         jQ0YzsP7SqlIkNv2UYd7erUQCAkQX3QchXTJXMcSz6cEkSYi3ETEzkj5xVy3R0tnJsRl
         i2Yl3fm9BXz+FN60X3lsnMYEW3cLzOcTqKnFIQVqSMEqapmhX6zDtR7HCBoyzdhRMof9
         DsonARkE6E1f2Us2E0f12nbKQLy/t38ppvaeaqIBbytfOvJjvWALcjkuJx6XWgODVYB4
         6vLuv7dCEIAclSqxSn7XMjkZbG79Ei8i2dy2U6ULxiHOKqOLFUjDjMlm1Su6Onbl5bTB
         BGBA==
X-Forwarded-Encrypted: i=1; AJvYcCWAYLk62nzEHUEW1aA12rQn/0CWGv2zQvI7XYtUo8Oje79yjYgBtDqtnXNDRx496dk8k+IgyA43Gw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2pkYkP1iqvQe2SzqJROfrYRAh795Oo06IH2Rg0Je+CS/i9pse
	gckIXCXLYRarpw0A+JvgB85yen4bnlwkMqAuE3/MeZv7XU6m8RLkRBcU8wxKYuPMyg==
X-Gm-Gg: ASbGncsOPCmFdV8f7SCBGWdj/CZmCe0SNwn1oWNtAlQaDy0nepJW61zfdDcQp2Tzen4
	SrNHlIit3rQv18HElqpPnzb57jjIeQothClTuXdl6xK4h2gGZuK0uTkLLzFh5B40d/7saBkNiYK
	0A6Om18ZF+5eefrJ8XR3vhRHHcCq7ScO7FyP3q8vhbTixz3u6U4TxOSw7ofzVGnNVVVTK7ODkHn
	5q+snG56YNgmOtzhDg/rlP0rWq/mrNPNbfzlng3uhSTDZGB9Ra6wVFkdehA49UJiQLt1VMZPLdH
	xZlcFvk6NRNTjpNf+Cg0mi0U5qPBsky2dSOHaFC0xuaHpvqCFxoBhPSqHi5kMgzyOxxESLs7KJO
	N/K1Pw6aGXH93xeiLeUgU+WlEcF3Xzrn5GP1G
X-Google-Smtp-Source: AGHT+IGcJYlYxaD1+nJ+rGBRpr6K7LDYr2yIFUEezr+8d9gx+crkPpfS3Bmpw1FsjBHG3Enags/5SQ==
X-Received: by 2002:a17:902:d4c8:b0:262:9ac8:6132 with SMTP id d9443c01a7336-267d160b79fmr59046075ad.19.1758086036285;
        Tue, 16 Sep 2025 22:13:56 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:383a:598a:bcc0:4cf8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2651ca21842sm86647835ad.34.2025.09.16.22.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 22:13:55 -0700 (PDT)
Date: Wed, 17 Sep 2025 14:13:51 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Pavel Machek <pavel@kernel.org>, Tomasz Figa <tfiga@chromium.org>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH] PM: dpm: add module param to backtrace all CPUs
Message-ID: <ren47plwmywfz3wmg2vjprknyfwzt7rkp4nppnqnnw4hqxdjxt@skmmbvfok3wt>
References: <20250731030125.3817484-1-senozhatsky@chromium.org>
 <CAJZ5v0jAdsyHKsfRtW+Crh_aDY_uryvNekTBivcdPVGAL4UyPQ@mail.gmail.com>
 <afspavnfnnhyttvxmcgdl76jwpawqp7v7g7dd5bnjfc3vv3hg7@g3zey3r3zqc4>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <afspavnfnnhyttvxmcgdl76jwpawqp7v7g7dd5bnjfc3vv3hg7@g3zey3r3zqc4>

On (25/08/20 11:04), Sergey Senozhatsky wrote:
> On (25/08/19 21:35), Rafael J. Wysocki wrote:
> > On Thu, Jul 31, 2025 at 5:01 AM Sergey Senozhatsky
> > <senozhatsky@chromium.org> wrote:
> > >
> > > Add dpm_all_cpu_backtrace module parameter which controls
> > > all CPU backtrace dump before DPM panics the system.
> > 
> > This is exclusively about the DPM watchdog, so the module parameter
> > name should reflect that.
> 
> I thought dpm in dpm_all_cpu_backtrace explains that.  Should
> I rename it so something like dpm_watchdog_all_cpu_backtrace?
> Any better suggestions?

Gentle ping.

Rafael, are you OK with dpm_watchdog_all_cpu_backtrace name?

Or maybe we can have a bitmask dmp_watchdog_print_flags and
various bits can control different things to print/do during
panic.  E.g. dmp_watchdog_print_flags=0x1 can backtrace all CPUs,
0x2 can do something else, etc.

