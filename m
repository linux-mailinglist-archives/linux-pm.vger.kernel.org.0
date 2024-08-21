Return-Path: <linux-pm+bounces-12603-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E61595955F
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 09:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 484CC1F24E08
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 07:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E246A1A2861;
	Wed, 21 Aug 2024 07:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IIUNDe8t"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C241A2859
	for <linux-pm@vger.kernel.org>; Wed, 21 Aug 2024 07:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724224113; cv=none; b=kcMNcvdGarCpQdZ41pkRBgz9S07jAijTf//1bJYzLoG5XkWObRUyis1JKGmFhzfjgBweZYostaqGtm8MGwYJmpNxNohSfD/ZzDm6nLd3jqOOOExb2PjFdGsz+TJdCrlsJv0jhY6X6UWoBJImENqnLhpFuPgviZ45Psx7+z+0DCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724224113; c=relaxed/simple;
	bh=CLEdfv65cmZ7yOiRS4fBiMrgUE1o5HGN+bVab4VE4Dw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gU0tyERaL13mr23it8NiLSC2kpuNXlw+qombUTW0hMCeZIjSLjorBPvPmfk1mpDKiT9EdUiDDi+2Dow/mQ2JWuyTaTNzcYCmtK37Y5OzGQOwUxr+I603qnKxL+rO8pRETbpdsHW7lUTjwUMi2VcUa8JAPOFM/MKh7/sEu0YASpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IIUNDe8t; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2021c08b95cso3588595ad.0
        for <linux-pm@vger.kernel.org>; Wed, 21 Aug 2024 00:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1724224110; x=1724828910; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XMySUmxyXV0NOwpl4IYLel9pKasMWHD/SNyRw5xpg6U=;
        b=IIUNDe8tnfZRDi7sAWxlsPZwOxyflrIy+4Vx/U1tWU0Y7aVuEUA/SW71zXr+/RdR8y
         xTUDmVVmCOQNntWXFlt5jutWXXknZr6UU4c24ZtHwL39KzcUS0qlDdgEnSCDzTrkBTuY
         QckW9INcdw5BbyOBQXi5WSoxmh+CZsaMGlyYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724224110; x=1724828910;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XMySUmxyXV0NOwpl4IYLel9pKasMWHD/SNyRw5xpg6U=;
        b=Pxvc8K0Co4TfV/MTs1gSeyJ7/JdoKw0Ut5D3PybPuO+KNUOWPNcwSj9D2rLLIkkDE6
         isQdedY1dtbzjhPiz/PpDKpVHjDZUd8tG0Xbuy+g3yfznD30jXaQFpX9Iz19MBfAbVxo
         2vgUNVjXn2Sz+BlzobeFwizPmk6BIoGtBBxwowfB4qg4q9HZjqSxahiL40QPYTsmGGyx
         cVE8QAMmMJEx5wZz2in2GcqsGhmR2nm0LDhqYxb5j5Gg7mdJjSxDpSQx0s5RhSZwFRhR
         pjtIq2Rq2NuYdeLWHnQAa2wLvWQzxTcsRNWe8bS16F1o9ZHoQuPDzkR0Vhzz90rxYt+Z
         CNDg==
X-Gm-Message-State: AOJu0YzL4GPUX0UmAV668zxGlLQXTljvKmhwVKyxfiFY2X6fcZ1/pMP6
	PouOWDYpUcFcD2dB/jIE9EpUlzEJPiJelut/gMnOa7f+m71pOqBn6Dehb57a7PE=
X-Google-Smtp-Source: AGHT+IHrSweQAP5MHApPfx8uzHjaXvrxcGV1j8LFNsPci/5pjmOxrBTZPRenC8Fnbcs7qh+Tk05sYg==
X-Received: by 2002:a17:903:2352:b0:1fd:70a6:ffbf with SMTP id d9443c01a7336-20367ac9444mr30836105ad.2.1724224110169;
        Wed, 21 Aug 2024 00:08:30 -0700 (PDT)
Received: from [172.20.0.208] ([218.188.70.188])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f0302e84sm87841825ad.32.2024.08.21.00.08.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Aug 2024 00:08:29 -0700 (PDT)
Message-ID: <c7259d79-4e66-48c2-922c-f6ab88b3af69@linuxfoundation.org>
Date: Wed, 21 Aug 2024 01:08:25 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2][RFC] Add SWIG Bindings to libcpupower
To: "John B. Wyatt IV" <jwyatt@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-pm@vger.kernel.org, Thomas Renninger <trenn@suse.com>,
 Shuah Khan <shuah@kernel.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org,
 John Kacur <jkacur@redhat.com>, Tomas Glozar <tglozar@redhat.com>,
 Arnaldo Melo <acme@redhat.com>, "John B. Wyatt IV"
 <sageofredondo@gmail.com>, Shuah Khan <skhan@linuxfoundation.org>
References: <20240724221122.54601-1-jwyatt@redhat.com>
 <1f5c24b6-f3ee-4863-8b7a-49344a550206@linuxfoundation.org>
 <Zqv9BOjxLAgyNP5B@hatbackup> <2024080405-roundish-casket-2474@gregkh>
 <ZrKOCLYvYklsPg1K@fedora.redhat.com> <ZsQ6XKQ4pRFYkGoS@rhfedora>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <ZsQ6XKQ4pRFYkGoS@rhfedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/20/24 00:40, John B. Wyatt IV wrote:
> I wanted to follow up on this since I am close to sending out the v2 of
> this patchset.
> 
> 3 points I wanted to raise:
> 
> 1) Does everyone understand, is okay with the SWIG license, and wants to
> proceed with me sending in a more complete version of this as a candidate for
> upstreaming?
> 
> 2) About maintainership: if I am to be the maintainer of this, how would
> myself and John Kacur be listed? As a CPU POWER MONITORING SUBSYSTEM
> maintainer, a separate category below it called CPU POWER MONITORING SUBSYSTEM
> PYTHON BINDINGS maintainer, or is not needed to be listed at this time?
> 
> A quick search for bindings shows what I believe to be all of them for device
> tree. This may establish a new precedent.
> 
> If I was to be added, I assume it would be a separate commit in the v2
> submission?
> 
> 3) I had to comment out powercap_set_enabled
> 
> SWIG reported this symbol not being found despite being in powercap.h. I did a
> quick search and was not able to find it's implementation in powercap.c. The
> get equivalent powercap_get_enabled is in powercap.c. Wanted to check on this
> just in case it is a bug or part of future functionality. I am assuming the
> latter; I would send it v2 with that declaration commented out with a note
> explaining it for users if there is no objection.

Yes please send a complete version for review.

thanks,
-- Shuah

